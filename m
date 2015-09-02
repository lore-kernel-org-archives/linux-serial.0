From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] serial: core: prevent softlockups on slow consoles
Date: Wed, 02 Sep 2015 18:09:47 +0200
Message-ID: <874mjceras.fsf@vitty.brq.redhat.com>
References: <1441031656-17959-1-git-send-email-vkuznets@redhat.com>
	<55E709DD.1070709@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E709DD.1070709@hurleysoftware.com> (Peter Hurley's message of
	"Wed, 2 Sep 2015 10:38:21 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-serial@vger.kernel.org

Peter Hurley <peter@hurleysoftware.com> writes:

> Hi Vitaly,
>
> On 08/31/2015 10:34 AM, Vitaly Kuznetsov wrote:
>> Hyper-V serial port is very slow on multi-vCPU guest
>
> How slow and why?
>

Not sure why, but here is a trace:

1)               |                          serial8250_console_putchar() {
1)               |                            wait_for_xmitr() {
1) ! 848.371 us  |                              io_serial_in();
1) ! 849.815 us  |                            }
1) ! 832.455 us  |                            io_serial_out();
1) ! 1684.686 us |                          }

This is just one char. In case we have a couple hundred lines in output
buffer we can easily spend several seconds there. + virtualization
specifics kicks in and our vCPU doing the output can be preempted in
favor of other guest.

>> this causes
>> soflockups on intensive console writes. Touch nmi watchdog after putting
>> every char on port to avoid the issue for all serial drivers, the overhead
>> should be small.
>
> Once per message should be sufficient.

Sure, but we don't have messages in uart_console_write(), we output the
whole buffer here. Or do you mean just moving touch_nmi_watchdog() call
under the if (*s == '\n') clause?
>
> Although I have no objection to adding this to uart_console_write() for
> all serial drivers, please remove it from drivers that already do this.
>

Not sure we can remove it from wait_for_xmitr() in 8250_core.c and
pch_uart.c as in UPF_CONS_FLOW case we wait up to 1 second there -
especially if we start calling touch_nmi_watchdog() once per line of
text in uart_console_write().

touch_nmi_watchdog() call from pch_console_write(),
lpc32xx_hsuart_console_write() and serial8250_console_write() can
probably be removed (we'll be calling it after printing first line).

>> This is just a part of the fix: serial8250_console_write() disables irqs
>> for all its execution time
>
> Interrupts are disabled by printk()/console_unlock() right now anyway;
> very thorny problem to fix with lots of complications.

Probably, but I think we can have some sort of an output limit (size or
time based) and print our buffer partialy rescheduling next print in
case there are some leftovers. But I haven't looked into the code yet...

>
> Regards,
> Peter Hurley
>
>> (which on such slow consoles can be dozens of
>> seconds), it should be possible to observe devices being stuck on this
>> CPU. We need to find a better way, e.g. do output in batches enabling irqs
>> in between.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index f368520..cc05785 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -33,7 +33,7 @@
>>  #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
>>  #include <linux/serial_core.h>
>>  #include <linux/delay.h>
>> -#include <linux/mutex.h>
>
> Why isn't this required anymore?
>

Because I screwed up, it is an unintentional change :-( Sorry. But as I
got no errors while compiling maybe it isn't needed...

>> +#include <linux/nmi.h>
>>  
>>  #include <asm/irq.h>
>>  #include <asm/uaccess.h>
>> @@ -1792,6 +1792,7 @@ void uart_console_write(struct uart_port *port, const char *s,
>>  		if (*s == '\n')
>>  			putchar(port, '\r');
>>  		putchar(port, *s);
>> +		touch_nmi_watchdog();
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(uart_console_write);
>> 

-- 
  Vitaly
