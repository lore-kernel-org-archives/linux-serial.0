From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Fri, 20 Nov 2015 10:58:10 +0200
Message-ID: <11872773.MUvOKIUXMO@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1662323.uZlFXR9U2a@avalon> <CAMuHMdUVu40bOoau8AwLnzd+MWLsNODGDazyAeN1jpZordvi9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUVu40bOoau8AwLnzd+MWLsNODGDazyAeN1jpZordvi9Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Friday 20 November 2015 09:22:16 Geert Uytterhoeven wrote:
> On Thu, Nov 19, 2015 at 10:08 PM, Laurent Pinchart wrote:
> > For patches 3-6, 13, 15-16 and 22 and 24,
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Many thanks for your review comments!

You're welcome.

> > I'm not sure I'd bother with patch 25/25, but I'm not against merging it
> > either. I'd be surprised if the serial driver still worked at all on SH
> > :-)
> 
> It should not cause problems, as long as sh7734 doesn't add the optional
> clocks ;-)

To be clear I don't expect this patch set to break it, I expect it to be 
broken already :-)

> > On Thursday 19 November 2015 19:38:39 Geert Uytterhoeven wrote:
> >> This patch series adds support to the Renesas SCI serial driver for
> >> 
> >>   - the optional external clock on (H)SCI(F) and some SCIFA, where this
> >>   
> >>     pin can serve as a clock input,
> >>   
> >>   - the optional clock sources for the Baud Rate Generator for External
> >>   
> >>     Clock (BRG), as found on some SCIF variants and on HSCIF.
> > 
> > Could you briefly explain (and even better in a source code comment) how
> > you handle baud rate calculation with the chained BRGs ?
> 
> I'll do that. Note that there's no chaining of BRGs, only muxing (so yes, it
> needs more clarification ;-).

Really ? I thought the BRG-EC was one possible input for the internal BRG ? 
Does it bypass the internal BRG ? Or do you configure the internal BRG to not 
divide the clock when using the BRG-EC ?

> There can be 4 possible sources for the sampling clock:
>   1. Internal BRG (BRR register),
>   2. (H)SCK,
>   3. BRG for external clock
>       a. Using SCIF_CLK,
>       b. Using the bus clock.

-- 
Regards,

Laurent Pinchart

