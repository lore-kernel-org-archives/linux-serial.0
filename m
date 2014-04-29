From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Wed, 30 Apr 2014 06:48:50 +0900
Message-ID: <20140429214846.GA27566@verge.net.au>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
 <20140428011354.GA13324@verge.net.au>
 <20140428070748.GA24537@verge.net.au>
 <1986104.5bpNkKVN8D@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34447 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390AbaD2Vsy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Apr 2014 17:48:54 -0400
Content-Disposition: inline
In-Reply-To: <1986104.5bpNkKVN8D@avalon>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Apr 29, 2014 at 03:44:46PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 28 April 2014 16:07:49 Simon Horman wrote:
> > On Mon, Apr 28, 2014 at 10:13:55AM +0900, Simon Horman wrote:
> > > On Mon, Apr 28, 2014 at 02:08:16AM +0200, Laurent Pinchart wrote:
> > > > On Monday 28 April 2014 09:03:14 Simon Horman wrote:
> > > > > On Fri, Apr 25, 2014 at 09:11:06AM +0200, Geert Uytterhoeven wrote:
> > > > > > On Fri, Apr 25, 2014 at 9:05 AM, Laurent Pinchart wrote:
> > > > > > >> +     scif0: serial@ffe40000 {
> > > > > > >> +             compatible = "renesas,scif",
> > > > > > >> "renesas,scif-r8a7779";
> > > > > > >> +             reg = <0xffe40000 265>;
> > > > > > >> +             interrupt-parent = <&gic>;
> > > > > > >> +             interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > >> +             clocks = <&cpg_clocks R8A7779_CLK_P>;
> > > > > > >> +             clock-names = "sci_ick";
> > > > > > > 
> > > > > > > Clock handling in the sh-sci driver should probably be improved.
> > > > > > > The driver currently requires an "sci_ick" interface clock and
> > > > > > > supports an optional "sci_fck" functional clock. In practice, as
> > > > > > > far as I can see, platforms that provide both sci_ick and sci_fck
> > > > > > > set the two clocks to the same source.
> > > > > > 
> > > > > > That's right. As a consequence, the clock's enable count is
> > > > > > incremented
> > > > > > 
> > > > > > 3 times:
> > > > > >   - once for fck,
> > > > > >   - once for ick,
> > > > > >   - once for generic Runtime PM using the "NULL" clock.
> > > > > 
> > > > > This approach is fine by me.
> > > > > But I think you need to maintain compatibility with the old
> > > > > binding ("sci_ick" required, "sci_fsk") as it seems that
> > > > > was included in v3.14.
> > > > 
> > > > sci_fck isn't part of the DT bindings, so we can at least drop that one.
> > > 
> > > So long as its not used anywhere in-tree, which I believe is the case,
> > > then that is fine by me.
> > 
> > BTW, are you planning to make the above mentioned driver update
> > before or after re-posting enablement patches for Koelsch and/or Lager?
> > I ask because I would like to make such patches the basis for
> > a patch for Marzen.
> 
> I'll try to do so today, after my talk at the ELC :-)

I thought you might be a bit busy with ELC so I went
ahead and made my Marzen patches. Hopefully they aren't
too far away from what you have in mind for the Koelsch and Lager.
