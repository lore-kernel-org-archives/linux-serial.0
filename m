From: "George G. Davis" <george_davis@mentor.com>
Subject: Re: [PATCH v2] serial: sh-sci: disable DMA for uart_console
Date: Tue, 14 May 2019 12:16:04 -0400
Message-ID: <20190514161604.GD18528@mam-gdavis-lt>
References: <1557762446-23811-1-git-send-email-george_davis@mentor.com>
 <CAMuHMdVaNWa=Q-7K-+_rM-8yYWB0-+4_o4hgACK6o-4BOrY07A@mail.gmail.com>
 <20190514153021.GC18528@mam-gdavis-lt>
 <20190514155450.GB6508@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190514155450.GB6508@kunai>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Chris Brandt <chris.brandt@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello Wolfram,

On Tue, May 14, 2019 at 05:54:51PM +0200, Wolfram Sang wrote:
> 
> > > > Fixes: https://patchwork.kernel.org/patch/10929511/
> > > 
> > > I don't think this is an appropriate reference, as it points to a patch that
> > > was never applied.
> > 
> > I included it as a link to an upstream problem report similar to other commits
> > that I previewed. The link provides the extra context that I was perhaps to
> > lazy to note in the commit header.
> 
> We have a "Link:" tag for things like this, e.g.:
> 
> Link: https://patchwork.kernel.org/patch/10929511/

Right, I've changed it to a Link instead.

Thanks!

-- 
Regards,
George
