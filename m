From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Mon, 21 Mar 2016 19:51:21 -0700
Message-ID: <56F0B329.30506@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <20160321230821.GA17910@kroah.com> <56F0975A.7050609@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F0975A.7050609@universe-factory.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Schiffer <mschiffer@universe-factory.net>, Greg KH <gregkh@linuxfoundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 03/21/2016 05:52 PM, Matthias Schiffer wrote:
> On 03/22/2016 12:08 AM, Greg KH wrote:
>> On Tue, Mar 22, 2016 at 12:02:57AM +0100, Matthias Schiffer wrote:
>>> Hi,
>>> we're experiencing weird nondeterministic hangs during bootconsole/console
>>> handover on some ath79 systems on OpenWrt. I've seen this issue myself on
>>> kernel 3.18.23~3.18.27 on a AR7241-based system, but according to other
>>> reports ([1], [2]) kernel 4.1.x is affected as well, and other SoCs like
>>> QCA953x likewise.
>>
>> Can you try 4.4 or ideally, 4.5?  There's been a lot of console/tty
>> fixes/changes since the obsolete 3.18 kernel you are using...
>>
>> thanks,
>>
>> greg k-h
>>
> 
> With 4.4, I was not able to reproduce this hang, but I have no idea if this
> is caused by an actual bugfix, or just random timing changes hiding the
> bug.

Can you continue testing with 4.4.x and see if it eventually reproduces?


> I suspect the latter might be the case (as I wrote in my first mail,
> even minor differences in kernel images of the same version and the same
> config make the hang more or less probable.) I was not yet able to test
> 4.5, as OpenWrt is a hell of kernel patches...
> 
> On 3.18, I also tried other things like disabling the early console
> altogether, which also made the hang go away, but as even much smaller
> changes hid the bug, this doesn't really say much.

FWIW, printk() is not a small change; takes ~500us @ 115200


> 
> The basic code path during the console handover seems to be the same in
> 3.18 and 4.4, even though a few functions have been moved; the relevant
> part of the log looks the same:
> 
>> [    0.756298] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
>> [    0.766754] console [ttyS0] disabled
>> [    0.790293] serial8250.0: ttyS0 at MMIO 0x18020000 (irq = 11, base_baud = 12500000) is a 16550A
>> [    0.798909] console [ttyS0] enabled
>> [    0.798909] console [ttyS0] enabled
>> [    0.805854] bootconsole [early0] disabled
>> [    0.805854] bootconsole [early0] disabled
> 
> So, in propect of an actual bugfix or backport, this boils down to two
> questions, which I hope the serial or MIPS maintainers can answer me:
> 
> * Is it sane to have two console drivers using the same serial port? In
> particular, is it sane for the early console to use the serial port after
> serial8250_config_port has reset/configured it, but before the rest of the
> setup of uart_configure_port has run? (this would be the case for the
> message "serial8250.0: ttyS0 at MMIO...")
> * Is it possible to get the serial controller into a state in which
> early_printk might wait for THRE forever?

I think I addressed these questions in my other reply; let me know if not.

Regards,
Peter Hurley
