From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Mon, 28 Apr 2014 02:08:16 +0200
Message-ID: <2068512.62K6gPl1LN@avalon>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au> <CAMuHMdWB4ZnwyNFXMK_rdCKAMOXt+HRMZKG+j4O-tdfiP_-PLg@mail.gmail.com> <20140428000314.GK32087@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:57490 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaD1AIH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Apr 2014 20:08:07 -0400
In-Reply-To: <20140428000314.GK32087@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Monday 28 April 2014 09:03:14 Simon Horman wrote:
> On Fri, Apr 25, 2014 at 09:11:06AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 25, 2014 at 9:05 AM, Laurent Pinchart wrote:
> > >> +     scif0: serial@ffe40000 {
> > >> +             compatible = "renesas,scif", "renesas,scif-r8a7779";
> > >> +             reg = <0xffe40000 265>;
> > >> +             interrupt-parent = <&gic>;
> > >> +             interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> > >> +             clocks = <&cpg_clocks R8A7779_CLK_P>;
> > >> +             clock-names = "sci_ick";
> > > 
> > > Clock handling in the sh-sci driver should probably be improved. The
> > > driver currently requires an "sci_ick" interface clock and supports an
> > > optional "sci_fck" functional clock. In practice, as far as I can see,
> > > platforms that provide both sci_ick and sci_fck set the two clocks to
> > > the same source.
>
> > That's right. As a consequence, the clock's enable count is incremented
> > 
> > 3 times:
> >   - once for fck,
> >   - once for ick,
> >   - once for generic Runtime PM using the "NULL" clock.
> 
> This approach is fine by me.
> But I think you need to maintain compatibility with the old
> binding ("sci_ick" required, "sci_fsk") as it seems that
> was included in v3.14.

sci_fck isn't part of the DT bindings, so we can at least drop that one.

-- 
Regards,

Laurent Pinchart

