From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix early deassertion of dedicated RTS
Date: Mon, 9 Jan 2017 10:53:55 +0100
Message-ID: <CAMuHMdXfmjqQV6ms-Q21WaQUbEeKNyt5DZ89nV8rifWf-7Ypfg@mail.gmail.com>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
 <1480682111-9299-2-git-send-email-geert+renesas@glider.be> <8834208.BLCpAM3tlx@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8834208.BLCpAM3tlx@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Fri, Jan 6, 2017 at 1:30 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 02 Dec 2016 13:35:10 Geert Uytterhoeven wrote:
>> If a UART has dedicated RTS/CTS pins, there are some issues:
>> 1. When changing hardware control flow, the new AUTORTS state is not
>>    immediately reflected in the hardware, but only when RTS is raised.
>>    However, the serial core doesn't call .set_mctrl() after
>>    .set_termios(), hence AUTORTS may only become effective when the port
>>    is closed, and reopened later.
>>    Note that this problem does not happen when manually using stty to
>>    change CRTSCTS, as AUTORTS will work fine on next open.
>>
>> 2. When hardware control flow is disabled (or AUTORTS is not yet
>>    effective), changing any serial port configuration deasserts RTS, as
>>    .set_termios() calls sci_init_pins().
>
> Isn't this still a problem with this patch applied ? Calling sci_set_mctrl()
> should reconfigure the pins properly, but won't there be a short window during
> which the configuration will be wrong ?

You mean in between the calls to sci_init_pins() and sci_set_mctrl()?
I don't think _de_asserting RTS for a few microseconds matters much, would it?
Asserting RTS wrongly would be worse.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
