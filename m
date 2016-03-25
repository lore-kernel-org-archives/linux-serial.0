From: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Fri, 25 Mar 2016 13:59:18 +0100
Message-ID: <56F53626.1040507@openwrt.org>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com> <56F34C61.50505@universe-factory.net>
 <56F35C33.7030608@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <56F35C33.7030608@hurleysoftware.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Peter Hurley <peter@hurleysoftware.com>, Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016.03.24. 4:17 keltez=C3=A9ssel, Peter Hurley =C3=ADrta:
> On 03/23/2016 07:09 PM, Matthias Schiffer wrote:
>>>> autoconfig_16550a() is doing all kinds of weird checks to detect d=
ifferent
>>>> hardware by writing a lot of register values which are documented =
as
>>>> reserved in the AR7242 datasheet (there's a leaked version going a=
round
>>>> that can be easily googled...), no idea if any of those are proble=
matic.
>>>> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that=
 code
>>>> altogether.
>>>
>>> That's just a debugging patch and not appropriate for permanent use=
,
>>> the reason being that this uart is _not_ 16550 compatible (or even =
16450
>>> compatible).
>>>
>>> The three options for 8250 driver support for this part are:
>>> 1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port =
type
>>>    to PORT_8250 instead. This will lose FIFO support so 115K won't =
be
>>>    possible and likely neither will 38400.
>>>
>>> 2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support=
 for
>>>    this PORT_* value to uart_config array, uapi headers, and anywhe=
re
>>>    the scratch register is used.
>>>
>>> 3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe fu=
nction
>>>    that detects ports of this type to autoconfig(). I don't recomme=
nd this
>>>    method.
>>>
>>> This requirement is independent of fixing prom_putchar_ar71xx().
>>>
>>
>> I can send patches for all of this, and I think that 2. would be the=
 nicest
>> solution. I've noticed though that include/uapi/linux/serial_core.h =
is
>> experiencing a little "overflow": PORT_MAX_8250 has grown just below=
 the
>> first non-8250 entry.
>=20
> Ugh. Thanks for noting this.
>=20
>> Should I just add the new entry at the bottom (and
>> thus grow the uart_config array by ~85 unused entries)? What about
>> PORT_MAX_8250 (used at least in drivers/tty/serial/8250/8250_of.c)?
>=20
> None of the above, unfortunately. Ok, plan B.
>=20
> I need to clean off a dusty series that adds probe steering and
> bugs pass-thru for 8250 sub-drivers and platform data. Then add a
> UART_BUG_NOSCR to indicate a uart does not have a scratch register
> (like this one). Then for this uart, set UPF_FIXED_TYPE and type to
> PORT_16550A, with UART_BUG_NOSCR flag.

Introducing the UART_BUG_NOSCR flag for this UART is pointless in my op=
inion,
because it does have a scratch register in fact. Even if it is not list=
ed in the
datasheet of the SoCs, it exists.

I have tested that from the bootloader on the Netgear WNDR3700 board wh=
ich uses
the AR7161 SoC:

ar7100> md.l 0xb802001c 1
b802001c: 00000000    ....
ar7100> mw.l 0xb802001c a5
ar7100> md.l 0xb802001c 1
b802001c: 000000a5    ....
ar7100> mw.l 0xb802001c 5a
ar7100> md.l 0xb802001c 1
b802001c: 0000005a    ...Z
ar7100>

The same test is on the TL-WR842ND v1 board (AR7241 SoC):

ar7240> md.l b802001c 1
b802001c: 00000000    ....
ar7240> mw.l b802001c a5
ar7240> md.l b802001c 1
b802001c: 000000a5    ....
ar7240> mw.l b802001c 5a
ar7240> md.l b802001c 1
b802001c: 0000005a    ...Z
ar7240>

And on the TL-WR841N v8 board (AR9341 Soc):

wasp> md.l b802001c 1
b802001c: 00000000    ....
wasp> mw.l b802001c a5
wasp> md.l b802001c 1
b802001c: 000000a5    ....
wasp> mw.l b802001c 5a
wasp> md.l b802001c 1
b802001c: 0000005a    ...Z
wasp>

Although i did not test it on other SoCs, but i assume that the behavio=
ur is the
same on those.

-Gabor
