From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 2/3] serial/8250_pci: Clear FIFOs for Intel ME Serial
 Over Lan device on BI
Date: Wed, 18 Apr 2012 15:36:40 -0700
Message-ID: <CABE8wwvw1R_ObcjGLfPXhGLq1g1H54QTRZf2Y-E3XHYg+v=APg@mail.gmail.com>
References: <20120410210438.13805.40525.stgit@dwillia2-linux.jf.intel.com>
	<20120410211058.13805.75833.stgit@dwillia2-linux.jf.intel.com>
	<20120418221207.GA4489@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120418221207.GA4489@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sudhakar Mamillapalli <sudhakar@fb.com>, Nhan H Mai <nhan.h.mai@intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 18, 2012 at 3:12 PM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Tue, Apr 10, 2012 at 02:10:58PM -0700, Dan Williams wrote:
>> From: Sudhakar Mamillapalli <sudhakar@fb.com>
>>
>> When using Serial Over Lan (SOL) over the virtual serial port in a I=
ntel
>> management engine (ME) device, on device reset the serial FIFOs need=
 to
>> be cleared to keep the FIFO indexes in-sync between the host and the
>> engine.
>>
>> On a reset the serial device assertes BI, so using that as a cue FIF=
Os
>> are cleared. =A0So for this purpose a new handle_break callback has =
been
>> added. =A0One other problem is that the serial registers might tempo=
rarily
>> go to 0 on reset of this device. =A0So instead of using the IER regi=
ster
>> read, if 0 returned use the ier value in uart_8250_port. This is hid=
den
>> under a custom serial_in.
>>
>> Cc: Nhan H Mai <nhan.h.mai@intel.com>
>> Signed-off-by: Sudhakar Mamillapalli <sudhakar@fb.com>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> What tree did you make this against?
>
> It fails with:
> patching file drivers/tty/serial/8250/8250.c
> patching file drivers/tty/serial/8250/8250.h
> patching file drivers/tty/serial/8250/8250_pci.c
> Hunk #2 FAILED at 1093.
> 1 out of 2 hunks FAILED -- saving rejects to file drivers/tty/serial/=
8250/8250_pci.c.rej
>
> While that file hasn't been changed since it was moved to that locati=
on.
>
> Any ideas?

Hmm, I think this is because this patch depends on the reverts went
into 3.4 via tty-linus.

On my internal tree I have the following against 3.4-rc2

48013c6 Revert "serial/8250_pci: init-quirk msi support for kt serial
controller"
0f4149f Revert "serial/8250_pci: setup-quirk workaround for the kt
serial controller"
5580b22 serial/8250_pci: add a "force background timer" flag and use
it for the "kt" serial port
d8a8351 tegra, serial8250: add ->handle_break() uart_port op
1d9aafe serial/8250_pci: Clear FIFOs for Intel ME Serial Over Lan devic=
e on BI
d4cb218 serial/8250_pci: fix suspend/resume vs init/exit quirks

> Because of this, I've only applied your first patch in this series, n=
ot
> the last two.

Not sure how these things are handled in tty.git, backmerge?

--
Dan
