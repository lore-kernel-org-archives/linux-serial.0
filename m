From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 17/25] serial: sh-sci: Correct SCIF type on R-Car for BRG
Date: Sun, 13 Dec 2015 21:18:24 +0200
Message-ID: <2202629.UfeqFbQ39W@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1865922.WzPYzesBTg@avalon> <CAMuHMdUEbkp4neqP_p5Srp_nfASd4aTKNqzL7LNRnvFDxWUGCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUEbkp4neqP_p5Srp_nfASd4aTKNqzL7LNRnvFDxWUGCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Thursday 10 December 2015 10:21:27 Geert Uytterhoeven wrote:
> On Fri, Nov 20, 2015 at 4:33 PM, Laurent Pinchart wrote:
> > On Friday 20 November 2015 16:30:22 Geert Uytterhoeven wrote:
> >> On Fri, Nov 20, 2015 at 3:52 PM, Laurent Pinchart wrote:
> >>> On Friday 20 November 2015 08:46:56 Geert Uytterhoeven wrote:
> >>>> On Thu, Nov 19, 2015 at 9:55 PM, Laurent Pinchart wrote:
> >>>>> On Thursday 19 November 2015 19:38:56 Geert Uytterhoeven wrote:
> >>>>>> The "renesas,scif" compatible value is currently used for the SCIF
> >>>>>> variant in all Renesas SoCs of the R-Car family.  However, the
> >>>>>> variant used in the R-Car family is not the common "SH-4(A)"
> >>>>>> variant, but a derivative with added "Baud Rate Generator for
> >>>>>> External Clock" (BRG), which is also present in sh7734.
> >>>>> 
> >>>>> Time to introduce a "renesas,scif-rcar" compatible string ? ;-)
> >>>>> 
> >>>>> As the only DT-enabled platform to have a different SCIF type is
> >>>>> r7s72100 we could also consider just switching the regtype to
> >>>>> SCIx_SH4_SCIF_BRG_REGTYPE for the generic "renesas,scif" entry as
> >>>>> it's listed after the "renesas,scif- r7s72100" entry. That might
> >>>>> cause an issue if we want to enable DT on arch/sh though, but even if
> >>>>> that happens due to the J-Core processors I'd be surprised to see the
> >>>>> old Renesas SH platforms being moved to DT.
> >>>> 
> >>>> I thought about that, but you never know in which out-of-tree BSP it
> >>>> ended up being used, too. So better safe than sorry.
> >>> 
> >>> Out-of-tree should be banned :-)
> >>> 
> >>> More seriously, I suppose you wouldn't be thrilled by the idea of a
> >>> "renesas,scif-rcar-gen2" ?
> >> 
> >> Nope. Note that it's also used in R-Car Gen 1 and Gen 3, and sh7734.
> > 
> > Yes, but it would at least cover the whole Gen2 family that behaves the
> > same way. And wouldn't preclude adding "renesas,scif-rcar-gen1". That's
> > two compat strings only.
> 
> In light of all the recent "add fallback compatibility strings" patch series
> from Simon, perhaps I should reconsider, and just match against three (new)
> family-specific compatible values:
> 
>     "renesas,scif-rcar-gen1"
>     "renesas,scif-rcar-gen2"
>     "renesas,scif-rcar-gen3"
> 
> instead of the 8 (and more coming) SoC-specific compatible values?
> 
> Following that scheme means we will have to add many compatible values
> to the existing dtsis. I.e. every SCIx device node (there are more than 100)
> will have 3, like
> 
>         scif0: serial@e6e60000 {
>                 compatible = "renesas,scif-r8a7791",
> "renesas,scif-rcar-gen2", "renesas,scif";
> 
> Not having the SoC-specific ones in the driver won't cause an issue when
> using an old DTS with a new kernel: you can't use the new BRG features
> without adding the extra clocks to the DTS anyway, so you can add the
> family-specific compatible value when doing that update.
> 
> Simon, what do you think?

Needless to say I agree :-)

-- 
Regards,

Laurent Pinchart
