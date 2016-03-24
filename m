From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Wed, 23 Mar 2016 20:17:07 -0700
Message-ID: <56F35C33.7030608@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com> <56F34C61.50505@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F34C61.50505@universe-factory.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 03/23/2016 07:09 PM, Matthias Schiffer wrote:
>>> autoconfig_16550a() is doing all kinds of weird checks to detect different
>>> hardware by writing a lot of register values which are documented as
>>> reserved in the AR7242 datasheet (there's a leaked version going around
>>> that can be easily googled...), no idea if any of those are problematic.
>>> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
>>> altogether.
>>
>> That's just a debugging patch and not appropriate for permanent use,
>> the reason being that this uart is _not_ 16550 compatible (or even 16450
>> compatible).
>>
>> The three options for 8250 driver support for this part are:
>> 1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type
>>    to PORT_8250 instead. This will lose FIFO support so 115K won't be
>>    possible and likely neither will 38400.
>>
>> 2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for
>>    this PORT_* value to uart_config array, uapi headers, and anywhere
>>    the scratch register is used.
>>
>> 3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe function
>>    that detects ports of this type to autoconfig(). I don't recommend this
>>    method.
>>
>> This requirement is independent of fixing prom_putchar_ar71xx().
>>
> 
> I can send patches for all of this, and I think that 2. would be the nicest
> solution. I've noticed though that include/uapi/linux/serial_core.h is
> experiencing a little "overflow": PORT_MAX_8250 has grown just below the
> first non-8250 entry.

Ugh. Thanks for noting this.

> Should I just add the new entry at the bottom (and
> thus grow the uart_config array by ~85 unused entries)? What about
> PORT_MAX_8250 (used at least in drivers/tty/serial/8250/8250_of.c)?

None of the above, unfortunately. Ok, plan B.

I need to clean off a dusty series that adds probe steering and
bugs pass-thru for 8250 sub-drivers and platform data. Then add a
UART_BUG_NOSCR to indicate a uart does not have a scratch register
(like this one). Then for this uart, set UPF_FIXED_TYPE and type to
PORT_16550A, with UART_BUG_NOSCR flag.

Couple of days because I'm in the middle of something else, ok?

Regards,
Peter Hurley
