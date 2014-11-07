From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
Date: Fri, 07 Nov 2014 17:29:33 +0100
Message-ID: <545CF36D.3060501@elproma.com.pl>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl> <201411071202.16344.marex@denx.de> <545CC7CB.1010107@elproma.com.pl> <201411071548.58044.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:51227 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751519AbaKGQ3f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Nov 2014 11:29:35 -0500
In-Reply-To: <201411071548.58044.marex@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Huang Shijie <shijie8@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>


W dniu 2014-11-07 o 15:48, Marek Vasut pisze:
> On Friday, November 07, 2014 at 02:23:23 PM, Janusz U=C5=BCycki wrote=
:
> [...]
>
>>>> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART por=
t
>>>> in order to obtain as much uarts as possible using i.mx283.
>>>> Therefore gpios can be used for "hardware" flow control.
>>> Your logic is outright flawed here, the first sentence doesn't impl=
icate
>>> the second sentence. In fact, those two are completely unrelated.
>> I didn't write MUST but CAN. There is a choice. Is flexibility of th=
e
>> driver disadvantage?
> If the flexibility brings in known problems, then yes, it is a proble=
m. Not
> because of the flexibility, but because it brings in bugs.

New features new bugs :) Does it mean to stop development?

>
>>>>>>      If we change them to gpio.  Could the DMA still
>>>>>>
>>>>>> works fine?
>>>>>> did you test the DMA with this patch?
>>>>>>
>>>>>> Add Marek for this patch too.
>>>>> I didn't look too deep into the patch, so here's just my experien=
ce:
>>>>>
>>>>> 1) The AUART block signals and GPIO block signals are not sychron=
ised
>>>>> using the
>>>>>
>>>>>       same clock. Therefore, the latency between toggling of the =
AUART
>>>>>       lines and the GPIO-driven pins will not be deterministic an=
d will
>>>>>       vary. There might be a way to approximate that, but that's
>>>>>       definitelly not a reliable solution.
>>>>>      =20
>>>>>       This is very bad for example if you drive RS485 DIR line wi=
th the
>>>>>       RTS pin as a GPIO ; the RTS pin will toggle at non-determin=
istic
>>>>>       time compared to the end of UART transmission. This will tr=
igger
>>>>>       bit-loss on the RS485 line and you just don't want that.
>>>>>
>>>>> 2) Speaking of RS485, there's [1] and [2]. which I believe apply =
to any
>>>>> combo
>>>>>
>>>>>       of UART+GPIO toggling.
>>>>>
>>>>> So I hate to bring the bad news , but UART+GPIO combo toggling is
>>>>> really a bad bad idea.
>>>> Unfortunately if hardware is limited there is no choice and UART+G=
PIO is
>>>> necessary.
>>> You will run into timing problems (see above).
>> A lot of 8250-compatible devices has no hardware flow control and in
>> most cases
>> they works and it is enough even for 115200 speed if CTS is handled =
by irq.
>> So it depends on your needs.
> I presume that in such a case , the 8250 still handles the CTS line, =
not some
> external GPIO block, yes ?

Yes. However mxs includes both GPIO and AUART. Clocks differs but it is=
=20
still the same silicon.
External GPIO block is extreme example highly not recommended here.

>
>>> What you're proposing here is a workaround for broken hardware, whi=
ch was
>>> proven to be a bad idea and NAK'd already multiple times in the pas=
t
>>> (please see the links I posted in my last email).
>> It is not broken  hardware - rather limited to lower speeds but stil=
l
>> very useful solution.
> What exact "lower speed" are you talking about here and why ?

=46or example not more than 115200 but it depends on CPU load of course=
,=20
=46IFO size
and device on the opposite site. RTS/CTS via GPIO require to know the l=
imit
in an application.

I googled even so exotic thing like:
"8250: add support for DTR/DSR hardware flow control"

>
>>>> Your experience confirms the discussion [3] with Russell King. DMA
>>>> should be disabled and
>>>> the patch disables DMA support in mxs_auart_init_gpios() if RTS or=
 CTS
>>>> line is set as gpio.
>>> DMA has nothing to do with those problems here. DMA can be safely i=
gnored
>>> for the purpose of the discussion altogether.
>> When gpios are used for RTS/CTS DMA is not used. However DMA is rela=
ted
>> due to the driver
>> and "fsl,uart-has-rtscts". If you look into code of the driver you
>> should agree.
> This makes me believe that the DMA introduces too many timing fluctua=
tions,
> so it's really not possible for you to keep toggling the GPIOs such t=
hat the
> bus would work. Is that the case ?

Yes, for RTS/CTS based on gpio DMA is not used. They are just toggled.
So you probably misunderstood me.

> [...]
>
>>>> Now the question: "fsl,uart-has-rtscts" name seems to be misleadin=
g now,
>>>> do you agree? It rather should include "dma" word in the name. Any
>>>> suggestion?
>>>>
>>>> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=3D16077
>>> The best suggestion I can give you is to fix your hardware early, b=
efore
>>> you run into nasty deep s.....tuff. These workarounds do not work a=
nd
>>> they will bit you later on, when it's hard to fix the hardware anym=
ore.
>> The speed is limited but why don't you accept SW-HW mixed solutions?
> Did you read up on the RS485 timing problems and why that solution wa=
s never
> accepted for any driver ? I believe the threads explained that quite =
clearly.

Example of RS485 implementation where RTS is toggled by software:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/drivers/tty/serial/omap-serial.c?id=3D4a0ac0f55b18dc297a87a85417fcf068=
658bf103
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tr=
ee/drivers/tty/serial/omap-serial.c

>
>> Exactly the same method is accepted for 8250.
> Can you point out this code please ?

If 8250 doesn't support auto flow control RTS/CTS are also toggled by=20
software,
uart_trottle(), uart_untrothle(), uart_handle_cts_change():
http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L=
635
http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L=
2796
Detected by irq (ms enabled when CRTSCTS) CTS change stops tx because
UPF_HARD_FLOW flag is not set by the mxs-auart driver.
Of course timing problem exists but in many cases it is not critical -
the toggle method was implemented many years ago and it seems to work.

>
>> It is good to have choice than not. We can comment that speed is lim=
ited
>> for gpio-based hardware flow control. So please, rethink again.
> [...]

The only problem for me is misleading "fsl,uart-has-rtscts" name becaus=
e=20
the flag
only enables DMA if CRTSCTS is set and hardware flow control of AUART=20
block is used.

best regards
Janusz

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
