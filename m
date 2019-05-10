From: "George G. Davis" <george_davis@mentor.com>
Subject: Re: [PATCH] serial: sh-sci: disable DMA for uart_console
Date: Fri, 10 May 2019 14:38:47 -0400
Message-ID: <20190510183847.GB28648@mam-gdavis-lt>
References: <20190506194233.GA32430@vmlxhi-102.adit-jv.com>
 <1557413011-1662-1-git-send-email-george_davis@mentor.com>
 <20190510171021.GA22691@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510171021.GA22691@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: "George G. Davis" <ggdavisiv@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello Eugeniu,

On Fri, May 10, 2019 at 07:10:21PM +0200, Eugeniu Rosca wrote:
> Hi George,
> 
> I am able to reproduce the SCIF2 console freeze described in the
> referenced patchwork link using M3-ES1.1-Salvator-XS and recent
> v5.1-9573-gb970afcfcabd kernel.
> 
> I confirm the behavior is healed with this patch. Thanks!
> Hope to see it accepted soon, since it fixes a super annoying
> console breakage every fourth boot or so on lots of R-Car3 targets.
> 
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks for testing.

Also note, for the record, that the problem is not limited to SCIF2, e.g. try
setting console=ttySC<n> wheren <n> is not SCIF2 on any other board which
includes support for other serial ports, e.g. r8a7795-salvator-x, and you will
observe the same problem on other SCIF ports too. It's just a concidence that
most boards use SCIF2 as the default serial console where the console hangs
(resolved by this patch) have been observed on multiple boards.

> 
> On Thu, May 09, 2019 at 10:43:30AM -0400, George G. Davis wrote:
> > As noted in commit 84b40e3b57ee ("serial: 8250: omap: Disable DMA for
> > console UART"), UART console lines use low-level PIO only access functions
> > which will conflict with use of the line when DMA is enabled, e.g. when
> > the console line is also used for systemd messages. So disable DMA
> > support for UART console lines.
> > 
> > Fixes: https://patchwork.kernel.org/patch/10929511/
> > Reported-by: Michael Rodin <mrodin@de.adit-jv.com>
> > Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Signed-off-by: George G. Davis <george_davis@mentor.com>
> > ---
> >  drivers/tty/serial/sh-sci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 3cd139752d3f..885b56b1d4e4 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -1557,6 +1557,9 @@ static void sci_request_dma(struct uart_port *port)
> >  
> >  	dev_dbg(port->dev, "%s: port %d\n", __func__, port->line);
> >  
> > +	if (uart_console(port))
> > +		return; /* Cannot use DMA on console */
> > +
> >  	if (!port->dev->of_node)
> >  		return;
> >  
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Best Regards,
> Eugeniu.

-- 
Regards,
George
