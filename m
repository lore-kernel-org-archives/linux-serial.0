From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 00/16] serial: sh-sci: Clock Cleanups
Date: Mon, 14 Dec 2015 18:11:19 +0900
Message-ID: <20151214091118.GA20278@verge.net.au>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
 <20151214081547.GE9929@verge.net.au>
 <CAMuHMdXwYr3RKhdbB6tpY-A=g6z_Lo3d79fL8AWqLXzL8q6jiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXwYr3RKhdbB6tpY-A=g6z_Lo3d79fL8AWqLXzL8q6jiA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 14, 2015 at 09:31:30AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 14, 2015 at 9:15 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 19, 2015 at 07:35:57PM +0100, Geert Uytterhoeven wrote:
> >> The SCI driver currently handles two clocks, an interface clock named
> >> sci_ick and a functional clock named sci_fck. Studying the datasheets of
> >> the SH and ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed
> >> (un)surprisingly that the hardware doesn't have a separate controllable
> >> interface clock.
> >>
> >> All the platforms that declare an interface clock for the SCI set it to
> >> the clock used as the SCI functional clock. The two clocks can thus be
> >> merged on the driver side, which is what this patch series does. The
> >> resulting clock is called "fck", and all H8/300, SH and ARM users (both
> >> DT and non-DT) are fixed to name their SCI clocks appropriately.
> >>
> >> Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
> >> backward compatibility, and support for the "peripheral_clk" clock to
> >> not break SH platforms that don't declare device-specific SCI clocks.
> >> The latter can be removed when all SH platforms will declare their SCI
> >> clocks properly.
> >>
> >> This series serves as a preparatory clock cleanup for the SCI baud rate
> >> generator clock support series. I decided to keep it separate as this
> >> series has more stringent internal dependencies:
> >
> > I have tentatively queued up patch 1 as a driver change for v4.5
> > with Greg's Ack. I plan to send a pull request to the ARM SoC maintainers
> > some time this week.
> >
> >>   - The SH patches 2-3 depend on patch 1,
> >
> > I have tentatively queued these up on top of patch 1 as sh changes for v4.5.
> > I intend to send a pull request to Linus once patch 1 hits his tree
> > via the ARM SoC tree. If all goes well that will likely be in v4.5-rc1 or rc2.
> >
> >>   - The DT patches 4-15 depend on patch 1,
> >
> > I have tentatively queued up the ARM patches up as (ARM) cleanup
> > patches for v4.5 and the ARM64 patch as ARM64 cleanup patches for v4.5.
> > They are based on patch 1. I plan to send a pull request for them
> > to the ARM SoC maintainers later this week.
> >
> > I have queued these up in cleanup rather than the dt arm64-dt branches as
> > they have dependencies not already present there (patch 1) and at this
> > stage of the merge-cycle I would like to keep the dt branches as simple as
> > possible.
> >
> >>   - Cleanup patch 16 depends on SH patch 2.
> >
> > I have tentatively queued this up as a driver change for v4.6 with
> > Greg's Ack. I plan to send a pull request to the ARM SoC maintainers
> > after rebasing on v4.5-rc1 or rc2 assuming that patch 1 is present there.
> >
> > Can you confirm that patch 16 only depends on patch 2?
> 
> Yes it does.
> 
> (seems I got confused myself, due to Laurent having it at the end of the
>  series ;-)
> 
> > I have not queued up the h8300 patch. I believe that one is for Sato-san.
> 
> Note that it depends on patch 1. Hence if Sato-san doesn't provide his
> Acked-by, it cannot go in before v4.6.

Right, but it doesn't block anything, right?


As discussed on IRC a little earlier, I have _not_ queued up the patches
in the manner describe above. Instead I'm waiting for you to repost.
