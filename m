From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] serial: imx: Add Rx Fifo overrun error message
Date: Wed, 13 Mar 2013 08:30:12 +0100
Message-ID: <3571150.CV0PYqRImP@ws-stein>
References: <1362997628-20246-1-git-send-email-alexander.stein@systec-electronic.com> <20130312154623.GA18972@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50745 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754489Ab3CMHaQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Mar 2013 03:30:16 -0400
In-Reply-To: <20130312154623.GA18972@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Tuesday 12 March 2013 08:46:23, Greg Kroah-Hartman wrote:
> On Mon, Mar 11, 2013 at 11:27:08AM +0100, Alexander Stein wrote:
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> No description of what you are doing in the changelog area?

I can be more verbose here in a v2.

> > ---
> >  drivers/tty/serial/imx.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 147c9e1..fe72099 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -449,6 +449,13 @@ static void imx_start_tx(struct uart_port *port)
> >  		temp &= ~(UCR1_RRDYEN);
> >  		writel(temp, sport->port.membase + UCR1);
> >  	}
> > +	/* Clear any pending ORE flag before enabling interrupt */
> > +	temp = readl(sport->port.membase + USR2);
> > +	writel(temp | USR2_ORE, sport->port.membase + USR2);
> > +
> > +	temp = readl(sport->port.membase + UCR4);
> > +	temp |= UCR4_OREN;
> > +	writel(temp, sport->port.membase + UCR4);
> 
> This seems like a bugfix, right?  Different than what you put in the
> Subject line above.

I would not see this as a bugfix. It enables the overrun interrupt which can be tested in the interrupt handler (see below).

> >  
> >  	temp = readl(sport->port.membase + UCR1);
> >  	writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
> > @@ -582,6 +589,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
> >  {
> >  	struct imx_port *sport = dev_id;
> >  	unsigned int sts;
> > +	unsigned int sts2;
> >  
> >  	sts = readl(sport->port.membase + USR1);
> >  
> > @@ -598,6 +606,12 @@ static irqreturn_t imx_int(int irq, void *dev_id)
> >  	if (sts & USR1_AWAKE)
> >  		writel(USR1_AWAKE, sport->port.membase + USR1);
> >  
> > +	sts2 = readl(sport->port.membase + USR2);
> > +	if (sts2 & USR2_ORE) {
> > +		dev_err(sport->port.dev, "Rx FIFO overrun\n");
> 
> Why?  What can a user now do about this?  Will this flood the syslog?

I have next to no knowledge on tty, so I don't know much how a user can be notified on a serial device that characters have been dropped. If this occurs very often, it will flood your syslog. Until now it is the only way to inform the user at all.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
