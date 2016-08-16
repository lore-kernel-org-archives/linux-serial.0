From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh-sci: fix transition from noflow to HW flow control
Date: Tue, 16 Aug 2016 11:48:14 +0200
Message-ID: <CAMuHMdUVMRp_qXt7tdgDv0KP8uSF=Hh7Z5knavuV1YTNt3BUTg@mail.gmail.com>
References: <HE1PR0601MB2683A0C1895F3622D6E1EDA2D0130@HE1PR0601MB2683.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <HE1PR0601MB2683A0C1895F3622D6E1EDA2D0130@HE1PR0601MB2683.eurprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Baumann, Christoph (C.)" <cbaumann@visteon.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Christoph,

On Tue, Aug 16, 2016 at 11:36 AM, Baumann, Christoph (C.)
<cbaumann@visteon.com> wrote:
>> Which port are you using? SCIF or HSCIF?
>
> just SCIF
>
>> You mean sci_set_mctrl() isn't called by the serial core after
>> sci_set_termios()?
>>
>> However, uart_set_termios() calls both uart_change_speed() and
>> uart_{clear,set}_mctrl(), in that order?
>
> Upon calling open() on the tty device sci_set_termios() and sci_set_mctrl() are called in this order.
> When issuing changes (baud rate, CRTSCTS...) only sci_set_termios() gets called.
> On calling close() sci_set_mctrl() and sci_shutdown() are called in this order.

OK, so it works on subsequent uses as the flag is kept in .c_cflag?

>> Have you tried using GPIO RTS/CTS instead of hardware-assisted
>> RTS/CTS?
>> Does it show the same behavior?
>> When adding support for hardware-assisted RTS/CTS, I used the
>> behavior of GPIO RTS/CTS as the expected behavior.
>
> No, I haven't tried GPIO RTS/CTS so far. How would this be configured?

In DT, instead of specifying "uart-has-rtscts" and pinctrl for the "ctrl" group,
you specify "rts-gpios" and "cts-gpios".

Compare e.g. the following two commits in
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/renesas-overlays:
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=58a6b5f63108db2fd88b869c5de13ff43789f0ca
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=a071804359e8aa631954461f9af65ac72621ca81

The first commit uses HSCIF1 with GPIO RTS/CTS, the second with
hardware-assisted RTS/CTS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
