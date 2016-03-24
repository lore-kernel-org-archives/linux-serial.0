From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Wed, 23 Mar 2016 17:44:26 -0700
Message-ID: <56F3386A.5040100@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F2D523.6000405@universe-factory.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Matthias,

On 03/23/2016 10:40 AM, Matthias Schiffer wrote:
> On 03/22/2016 04:38 PM, Peter Hurley wrote:
>> On 03/22/2016 06:07 AM, Matthias Schiffer wrote:
>>> I've tried your patch and I can't reproduce the issue anymore with it; I
>>> have no idea if this actually has to do something with the issue, or the
>>> change of the code path just hid the bug again.
>>>
>>> Regarding your other mail: with "small change", I was not talking about
>>> adding an additional printk; as mentioned, even changing the numbers in
>>> UTS_VERSION can hide the issue. I diffed a working and a broken kernel
>>> image, and the UTS_VERSION is really the only difference. I have no idea
>>> how to explain this.
>>
>> If _any_ change may hide the problem, that will make it impossible
>> to determine if any attempted fix actually works, regardless of what
>> debugging method you use.
>>
>> FWIW, you could still use the boot console to debug the problem by
>> disabling the regular command-line console.
>>
>> Regards,
>> Peter Hurley
> 
> Hi,
> it seems Peter was on the right track. With some help from Ralf, I was able
> to narrow down the issue a bit, and I'm fairly sure the hang happens
> somewhere in autoconfig().
> 
> autoconfig_16550a() is doing all kinds of weird checks to detect different
> hardware by writing a lot of register values which are documented as
> reserved in the AR7242 datasheet (there's a leaked version going around
> that can be easily googled...), no idea if any of those are problematic.
> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
> altogether.

That's just a debugging patch and not appropriate for permanent use,
the reason being that this uart is _not_ 16550 compatible (or even 16450
compatible).

The three options for 8250 driver support for this part are:
1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type
   to PORT_8250 instead. This will lose FIFO support so 115K won't be
   possible and likely neither will 38400.

2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for
   this PORT_* value to uart_config array, uapi headers, and anywhere
   the scratch register is used.

3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe function
   that detects ports of this type to autoconfig(). I don't recommend this
   method.

This requirement is independent of fixing prom_putchar_ar71xx().


> That being said, I found another minimal change that seems to fix the
> issue: prom_putchar_ar71xx() in arch/mips/ath79/early_printk.c only waits
> for UART_LSR_THRE, while serial_putc() in
> drivers/tty/serial/8250/8250_early.c waits for (UART_LSR_TEMT |
> UART_LSR_THRE). Adjusting arch/mips/ath79/early_printk.c in the same way
> makes the hangs go away.

Go ahead and do this as well.


> Maybe the AR7242 doesn't like its serial config
> registers being poked while there's still something in the FIFO? Waiting
> for UART_LSR_TEMT seems like a good idea anyways to ensure that all
> characters have been printed before autoconfig() starts taking things
> apart.

I agree.


> (Why do these two versions of essentially the same code exist anyways?)

earlyprintk command-line parameter is arch-specific and predates
the arch-independent earlycon support.

earlycon requires the arch to either supply a fixmap for the uart i/o address
or ioremap() must work by parse_early_param(); note how the mmio in
arch/mips/ath79/early_printk.c accesses the mmio space @ KSEG1ADDR(uart base addr)?

Can't do that in arch-independent earlycon code.

Regards,
Peter Hurley
