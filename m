From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Sun, 13 Dec 2015 10:09:58 +0100
Message-ID: <CAMuHMdUtkyUbVDNBcrUVWj=FE=tO8x522Krk2c4q-7UAXe=P0g@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdVGni+uTcFzMwnjJ2R_K-FiHpzeEioMMmqwXzdnOYu30g@mail.gmail.com>
	<20151213064348.GC16326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151213064348.GC16326@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Sun, Dec 13, 2015 at 7:43 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Nov 20, 2015 at 10:09:24AM +0100, Geert Uytterhoeven wrote:
>> On Thu, Nov 19, 2015 at 7:38 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>> > This patch series adds support to the Renesas SCI serial driver for
>> >   - the optional external clock on (H)SCI(F) and some SCIFA, where this
>> >     pin can serve as a clock input,
>> >   - the optional clock sources for the Baud Rate Generator for External
>> >     Clock (BRG), as found on some SCIF variants and on HSCIF.
>> > Using external clocks increases the range and accuracy of supported baud
>> > rates. Please see the descriptions of the DTS patches for more detailed
>> > information regarding the impact on the supported platforms.
>>
>> For the consumers: I've pushed this (incl. the dependencies and a few
>> WIP patches) to the scif-brg branch of my renesas-drivers repo.
>
> I don't know what I can do with this series given the dependancies, but
> if it helps, you can add:
>         Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> to the serial patches and take them through what ever tree you want to.

Thanks for your ackes, they make (my) life a bit simpler!

I was going to post an updated version tomorrow. I will include a list of
merge options.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
