From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] serial: sh-sci: Add device tree support for r8a7779
Date: Mon, 28 Apr 2014 09:03:14 +0900
Message-ID: <20140428000314.GK32087@verge.net.au>
References: <1398322484-3630-1-git-send-email-horms+renesas@verge.net.au>
 <1418731.YSFS18bIMD@avalon>
 <20140425002641.GB31164@verge.net.au>
 <1922942.7jvlviEDpf@avalon>
 <CAMuHMdWB4ZnwyNFXMK_rdCKAMOXt+HRMZKG+j4O-tdfiP_-PLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56483 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaD1ADY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Apr 2014 20:03:24 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWB4ZnwyNFXMK_rdCKAMOXt+HRMZKG+j4O-tdfiP_-PLg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Apr 25, 2014 at 09:11:06AM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 25, 2014 at 9:05 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >> +     scif0: serial@ffe40000 {
> >> +             compatible = "renesas,scif", "renesas,scif-r8a7779";
> >> +             reg = <0xffe40000 265>;
> >> +             interrupt-parent = <&gic>;
> >> +             interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> >> +             clocks = <&cpg_clocks R8A7779_CLK_P>;
> >> +             clock-names = "sci_ick";
> >
> > Clock handling in the sh-sci driver should probably be improved. The driver
> > currently requires an "sci_ick" interface clock and supports an optional
> > "sci_fck" functional clock. In practice, as far as I can see, platforms that
> > provide both sci_ick and sci_fck set the two clocks to the same source.
> 
> That's right. As a consequence, the clock's enable count is incremented
> 3 times:
>   - once for fck,
>   - once for ick,
>   - once for generic Runtime PM using the "NULL" clock.

This approach is fine by me.
But I think you need to maintain compatibility with the old
binding ("sci_ick" required, "sci_fsk") as it seems that
was included in v3.14.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
