From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] serial: sh-sci: disable DMA for uart_console
Date: Mon, 13 May 2019 12:28:59 +0200
Message-ID: <20190513102859.GA18462@vmlxhi-102.adit-jv.com>
References: <20190506194233.GA32430@vmlxhi-102.adit-jv.com>
 <1557413011-1662-1-git-send-email-george_davis@mentor.com>
 <20190510171021.GA22691@vmlxhi-102.adit-jv.com>
 <20190510183847.GB28648@mam-gdavis-lt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510183847.GB28648@mam-gdavis-lt>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <george_davis@mentor.com>
Cc: "George G. Davis" <ggdavisiv@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>Eug
List-Id: linux-serial@vger.kernel.org

Hi George,

On Fri, May 10, 2019 at 02:38:47PM -0400, George G. Davis wrote:
> Hello Eugeniu,
> 
> On Fri, May 10, 2019 at 07:10:21PM +0200, Eugeniu Rosca wrote:
> > Hi George,
> > 
> > I am able to reproduce the SCIF2 console freeze described in the
> > referenced patchwork link using M3-ES1.1-Salvator-XS and recent
> > v5.1-9573-gb970afcfcabd kernel.
> > 
> > I confirm the behavior is healed with this patch. Thanks!
> > Hope to see it accepted soon, since it fixes a super annoying
> > console breakage every fourth boot or so on lots of R-Car3 targets.
> > 
> > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> Thanks for testing.
> 
> Also note, for the record, that the problem is not limited to SCIF2, e.g. try
> setting console=ttySC<n> wheren <n> is not SCIF2 on any other board which
> includes support for other serial ports, e.g. r8a7795-salvator-x, and you will
> observe the same problem on other SCIF ports too. It's just a concidence that
> most boards use SCIF2 as the default serial console where the console hangs
> (resolved by this patch) have been observed on multiple boards.

Thanks for the additional level of detail.

FTR, trying to track the origin of the problem, it looks to me that the
issue was _unmasked_ by v4.16-rc1 commit be7e251d20e6c8 ("tty: serial:
sh-sci: Hide DMA config question") which turned on DMA on SCIF by
default.

I wonder if it'd be helpful to resend the patch w/o using --in-reply-to,
so that it appears as standalone entry in linux-renesas-soc patchwork.
Currently, assuming that the R-Car maintainers filter out any "Rejected"
patches (which is the default patchwork behavior), your patch would be
hidden from their eye.

-- 
Best Regards,
Eugeniu.
