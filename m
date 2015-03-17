From: Jon Ringle <jon-7zJyie9iPacdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] sc16is7xx: enable the clock
Date: Tue, 17 Mar 2015 10:46:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1503171045480.3566@jring-w510-7m3g.gridpoint.com>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl> <1426548529-21738-5-git-send-email-moorray3@wp.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-5-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Ringle, Jonathan" <Jonathan.Ringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?ISO-8859-2?Q?Karol_D=EAbog=F3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



On Mon, 16 Mar 2015, Jakub Kicinski wrote:

> From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
> 
> Although clk_disable_unprepare() is called both on .remove()
> and in .probe() error path, the clock is never actually enabled.
> 
> Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

Signed-off-by: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>

> ---
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 24902d589b07..20573d72715d 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1064,6 +1064,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		else
>  			return PTR_ERR(s->clk);
>  	} else {
> +		clk_prepare_enable(s->clk);
>  		freq = clk_get_rate(s->clk);
>  	}
>  
> -- 
> 2.1.0
> 
> 
