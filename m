From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: imx: Add Rx Fifo overrun error message
Date: Tue, 12 Mar 2013 08:46:23 -0700
Message-ID: <20130312154623.GA18972@kroah.com>
References: <1362997628-20246-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:53362 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab3CLPpe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Mar 2013 11:45:34 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so5085648pbc.9
        for <linux-serial@vger.kernel.org>; Tue, 12 Mar 2013 08:45:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1362997628-20246-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Mon, Mar 11, 2013 at 11:27:08AM +0100, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

No description of what you are doing in the changelog area?

> ---
>  drivers/tty/serial/imx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 147c9e1..fe72099 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -449,6 +449,13 @@ static void imx_start_tx(struct uart_port *port)
>  		temp &= ~(UCR1_RRDYEN);
>  		writel(temp, sport->port.membase + UCR1);
>  	}
> +	/* Clear any pending ORE flag before enabling interrupt */
> +	temp = readl(sport->port.membase + USR2);
> +	writel(temp | USR2_ORE, sport->port.membase + USR2);
> +
> +	temp = readl(sport->port.membase + UCR4);
> +	temp |= UCR4_OREN;
> +	writel(temp, sport->port.membase + UCR4);

This seems like a bugfix, right?  Different than what you put in the
Subject line above.

>  
>  	temp = readl(sport->port.membase + UCR1);
>  	writel(temp | UCR1_TXMPTYEN, sport->port.membase + UCR1);
> @@ -582,6 +589,7 @@ static irqreturn_t imx_int(int irq, void *dev_id)
>  {
>  	struct imx_port *sport = dev_id;
>  	unsigned int sts;
> +	unsigned int sts2;
>  
>  	sts = readl(sport->port.membase + USR1);
>  
> @@ -598,6 +606,12 @@ static irqreturn_t imx_int(int irq, void *dev_id)
>  	if (sts & USR1_AWAKE)
>  		writel(USR1_AWAKE, sport->port.membase + USR1);
>  
> +	sts2 = readl(sport->port.membase + USR2);
> +	if (sts2 & USR2_ORE) {
> +		dev_err(sport->port.dev, "Rx FIFO overrun\n");

Why?  What can a user now do about this?  Will this flood the syslog?

thanks,

greg k-h
