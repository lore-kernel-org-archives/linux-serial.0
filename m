From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] serial: core: prevent softlockups on slow consoles
Date: Sun, 6 Sep 2015 11:48:04 +0000
Message-ID: <8dcca26a00c7451bba759391d5daae43@SIXPR30MB031.064d.mgd.msft.net>
References: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
 <20150904042039.GA3719@kroah.com> <87bndid52t.fsf@vitty.brq.redhat.com>
 <20150904161014.GA8274@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150904161014.GA8274@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman
> Sent: Saturday, September 5, 2015 0:10
> On Fri, Sep 04, 2015 at 09:19:38AM +0200, Vitaly Kuznetsov wrote:
> > Greg Kroah-Hartman writes:
> >
> > > On Mon, Aug 31, 2015 at 04:34:16PM +0200, Vitaly Kuznetsov wrote:
> > >> Hyper-V serial port is very slow on multi-vCPU guest, this causes
> > >> soflockups on intensive console writes. Touch nmi watchdog after putting
> > >> every char on port to avoid the issue for all serial drivers, the overhead
> > >> should be small.
> > >>
> > >> This is just a part of the fix: serial8250_console_write() disables irqs
> > >> for all its execution time (which on such slow consoles can be dozens of
> > >> seconds), it should be possible to observe devices being stuck on this
> > >> CPU. We need to find a better way, e.g. do output in batches enabling irqs
> > >> in between.
> > >>
> > >> Signed-off-by: Vitaly Kuznetsov

Thank you Vitaly for the help of trying to mitigate the issue!

Please let me explain the "real" issue here since I investigated the same issue a
few months ago.

(Please see the below)

> > >> ---
> > >>  drivers/tty/serial/serial_core.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > >> index f368520..cc05785 100644
> > >> --- a/drivers/tty/serial/serial_core.c
> > >> +++ b/drivers/tty/serial/serial_core.c
> > >> @@ -33,7 +33,7 @@
> > >>  #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
> > >>  #include <linux/serial_core.h>
> > >>  #include <linux/delay.h>
> > >> -#include <linux/mutex.h>
> > >> +#include <linux/nmi.h>
> > >>
> > >>  #include <asm/irq.h>
> > >>  #include <asm/uaccess.h>
> > >> @@ -1792,6 +1792,7 @@ void uart_console_write(struct uart_port *port,
> const char *s,
> > >>                  if (*s == '\n')
> > >>                          putchar(port, '\r');
> > >>                  putchar(port, *s);
> > >> +                touch_nmi_watchdog();
> > >
> > > I don't like this, please narrow this down to the real problem that your
> > > hardware has here, the putchar function should not be this slow.  If it
> > > is, something is wrong.
> >
> > I'm afraid this is really the case:
> >
> > 3)               |                                          serial8250_console_putchar() {
> > 3)               |                                            wait_for_xmitr() {
> > 3) # 3111.189 us |                                              io_serial_in();
> > 3) # 3115.334 us |                                            }
> > 3) # 2234.099 us |                                            io_serial_out();
> > 3) # 5353.883 us |                                          }
> >
> > This is one char and I use local pipe for Hyper-V output. In case
> > something like remote pipe is in use ...
> >
> > So I'm sorry, but I don't really understand the suggestion to 'narrow
> > this down' - this is how slow Hyper-V serial's implementation is,
> > io_serial_in() is just an inb() and io_serial_out() is an outb().
>
> So a call to inb() and outb() really takes that long?  Again, this is

Yes, if you're using a VM with many vCPUs, like 16 or 32 vCPUs.
If you only use 1 vCPU, inb()/outb() is pretty fast as it should be.
The more vCPU your VM has, the slower inb()/outb() can be.
There is almost a linear relationship here...

> broken somewhere in the hypervisor, or you need to fix up the platform
Yes, the serial emulation code in the host is broken for SMP guest.

Historically, usually Windows VM itself doesn't use the serial so much
as Linux VM. The most important usage of the serial in Windows VM is
windbg: a host debugger can connect to the VM by its (virtual) serial.

Windbg may use multiple consecutive ins/outs instructions, trying to
exchange data faster between the host and Windows VM. In the host's
serial emulation code, there is a software instruction emulator, which
tries to "execute" the VM's ins/outs on behalf of the VM -- this way,
there are fewer ins/outs intercepts to the hypervisor (in Intel CPU, it's
called "VM exit") and the intercepts are forwarded to the host's serial
emulation code.

This optimization of reducing the number of the intercepts is probably
good for the 6-years-ago old CPUs, but is pretty questionable for today's
CPUs since the cost of the intercept has been reduced really a lot.

A side effect of the software instruction emulator in the host's serial
emulation code is: it triggers the need to pause the other vCPUs when
emulating ins/outs, probably for the atomicity of accessing the
memory(?). Unluckily it turns out pausing n vCPUs is expensive,
especially when n is >8 and on relatively new faster CPUs.
I suspect nobody ever tested the case of "vCPUS > 8" here.

This is the cause of the slow serial issue here, AFAIK.

> logic for inb() and outb() to properly kick the watchdog.  Perhaps
> hyperv needs its own arch type for this kind of crud?
>
> Don't "paper over" the real issue here please.
>
> greg k-h

I agree with Greg.

AFAIK, the "slow serial console for SMP guest" issue should be fixed
in Hyper-V 2016. Unluckily IMO there is no workaround for the
current version of Hyper-V -- we'd better avoid outputting lots of
messages by the serial console in a SMP Hyper-V VM with many vCPUs.

Thanks,
-- Dexuan
