From: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] sc16is7xx: don't wipe out port configuration on
 shutdown
Date: Tue, 17 Mar 2015 10:43:02 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1503171042480.3566@jring-w510-7m3g.gridpoint.com>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl> <1426548529-21738-3-git-send-email-moorray3@wp.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-3-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Ringle, Jonathan" <Jonathan.Ringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?ISO-8859-2?Q?Karol_D=EAbog=F3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On Mon, 16 Mar 2015, Jakub Kicinski wrote:

> From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
> 
> EFCR register contains RS-485 configuration which should not
> be changed by shutdown.  Instead of doing a write only update
> the appropriate bits.
> 
> Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

Signed-off-by: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>

> ---
>  drivers/tty/serial/sc16is7xx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 11bb44039a57..e6b396e584f3 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -903,9 +903,11 @@ static void sc16is7xx_shutdown(struct uart_port *port)
>  	/* Disable all interrupts */
>  	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, 0);
>  	/* Disable TX/RX */
> -	sc16is7xx_port_write(port, SC16IS7XX_EFCR_REG,
> -			     SC16IS7XX_EFCR_RXDISABLE_BIT |
> -			     SC16IS7XX_EFCR_TXDISABLE_BIT);
> +	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
> +			      SC16IS7XX_EFCR_RXDISABLE_BIT |
> +			      SC16IS7XX_EFCR_TXDISABLE_BIT,
> +			      SC16IS7XX_EFCR_RXDISABLE_BIT |
> +			      SC16IS7XX_EFCR_TXDISABLE_BIT);
>  
>  	sc16is7xx_power(port, 0);
>  }
> -- 
> 2.1.0
> 
> 
