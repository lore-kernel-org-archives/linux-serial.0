From: "George G. Davis" <george_davis@mentor.com>
Subject: Re: [PATCH] serial: sh-sci: disable DMA for uart_console
Date: Mon, 13 May 2019 11:43:06 -0400
Message-ID: <20190513154306.GA6060@mam-gdavis-lt>
References: <20190506194233.GA32430@vmlxhi-102.adit-jv.com>
 <1557413011-1662-1-git-send-email-george_davis@mentor.com>
 <20190513135114.GA20443@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513135114.GA20443@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "George G. Davis" <ggdavisiv@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Andy Lowe <andy_lowe@mentor.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

Hello Wolfram,

On Mon, May 13, 2019 at 03:51:14PM +0200, Wolfram Sang wrote:
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
> 
> Minor nit: maybe the comment can be made more specific?
> 
> /*
>  * DMA on console may interfere with Kernel log messages which use
>  * plain putchar(). So, simply don't use it with a console.
>  */

I'll submit v2 with the above recommended change.

Thanks!

> Other than that:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Much better than dropping the properties, as Geert noted.

-- 
Regards,
George
