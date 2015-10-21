From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: console vs earlycon ?
Date: Wed, 21 Oct 2015 18:30:05 +0900
Message-ID: <CAK7LNATniscPQ_vLMg91PWbMVSdoXtJYGL9nicsn49=ULQ-oAw@mail.gmail.com>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com>
	<5490668.HV7UIzY6eu@wuerfel>
	<CAK7LNASkAsi59dtmrVX2MjNqgTAiGJ8rrtV3VqO2FJ0JaHzfpQ@mail.gmail.com>
	<14202684.GgqlkWAZA0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14202684.GgqlkWAZA0@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,


2015-10-21 18:19 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 21 October 2015 18:09:33 Masahiro Yamada wrote:
>> Hi Arnd,
>>
>>
>> 2015-10-21 17:57 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Wednesday 21 October 2015 17:21:07 Masahiro Yamada wrote:
>> >> Hi.
>> >>
>> >>
>> >>
>> >>
>> >> I think there are three places where console could be enabled.
>> >>
>> >> [1] earlycon
>> >>
>> >> Each driver entry is declared with
>> >> EARLYCON_DECLARE()  or OF_EARLYCON_DECLARE()
>> >>
>> >>
>> >>
>> >> [2] console_init()
>> >>
>> >> Each entry is declared with  console_initcall()
>> >>
>> >>
>> >>
>> >> [3]  when driver is probed
>> >> The console is usually enabled at this point
>> >> unless some special treatment is done.
>> >>
>> >>
>> >>
>> >>
>> >> My question is about [2].
>> >>
>> >> I am using 8250-ish UART device.
>> >>
>> >>
>> >> I noticed univ8250_console_match() and univ8250_console_setup()
>> >> always fail at the point of [2] unless early_serial_setup() has been
>> >> called in advance;
>> >> however, it looks like early_serial_setup() is only used for old platforms.
>> >>
>> >> So, console cannot be enabled at [2] for modern platforms.
>> >>
>> >>
>> >> My questions are:
>> >>
>> >>  -  Given that earlycon can be now available for major architectures such ARM,
>> >>      [2] will be deprecated at some point in the future?
>> >>
>> >>  - I am implementing  earlycon  for my own UART driver.
>> >>    Is it meaningless to implement  console_initcall()  as well as earlycon?
>> >
>> > I would still do both. We don't enable earlycon by default at the moment,
>> > and I'd say things should remain working with just console_initcall().
>> >
>> > How closely related to 8250 is your hardware? If it's not all that different,
>> > you should probably reuse the existing driver.
>>
>>
>> Very close.
>> It is already in the mainline.
>>
>> drivers/tty/serial/8250/8250_uniphier.c
>>
>> The core parts are shared with 8250_core.c
>
> Ok, but I guess no close enough that it makes sense to use drivers/serial/of_serial.c

Right.


>
>> I am trying to implement OF_EARLYCON_DECLARE() for that.
>>
>> I was just wondering if console_initcall() should work as well.
>>
>>
>> As I said, I noticed the console_initcall() in 8250_core.c
>> only works on very limited platforms.
>
> It works with all those that use of_serial.c, right?

I doubt it.


I have a board with a pure 8250-compat device working.
(  compatible = "ns16550a")
It uses of_serial.c, of course.


As far as I tested, it would never enable the console at console_init().

The console is enabled when the UART driver is probed.
(or earlycon if "earlycon" is specified in the kernel-parameter.)


-- 
Best Regards
Masahiro Yamada
