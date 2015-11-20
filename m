From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Fri, 20 Nov 2015 09:22:16 +0100
Message-ID: <CAMuHMdUVu40bOoau8AwLnzd+MWLsNODGDazyAeN1jpZordvi9Q@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1662323.uZlFXR9U2a@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1662323.uZlFXR9U2a@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 10:08 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> For patches 3-6, 13, 15-16 and 22 and 24,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Many thanks for your review comments!

> I'm not sure I'd bother with patch 25/25, but I'm not against merging it
> either. I'd be surprised if the serial driver still worked at all on SH :-)

It should not cause problems, as long as sh7734 doesn't add the optional
clocks ;-)

> On Thursday 19 November 2015 19:38:39 Geert Uytterhoeven wrote:
>> This patch series adds support to the Renesas SCI serial driver for
>>   - the optional external clock on (H)SCI(F) and some SCIFA, where this
>>     pin can serve as a clock input,
>>   - the optional clock sources for the Baud Rate Generator for External
>>     Clock (BRG), as found on some SCIF variants and on HSCIF.
>
> Could you briefly explain (and even better in a source code comment) how you
> handle baud rate calculation with the chained BRGs ?

I'll do that. Note that there's no chaining of BRGs, only muxing (so yes, it
needs more clarification ;-).

There can be 4 possible sources for the sampling clock:
  1. Internal BRG (BRR register),
  2. (H)SCK,
  3. BRG for external clock
      a. Using SCIF_CLK,
      b. Using the bus clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
