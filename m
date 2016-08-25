From: Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] serial: 8250_mtk: support big baud rate.
Date: Thu, 25 Aug 2016 11:15:06 +0800
Message-ID: <1472094906.19004.2.camel@mhfsdcap03>
References: <1470969671-17235-1-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470969671-17235-1-git-send-email-long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-08-12 at 10:41 +0800, Long Cheng wrote:
> From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> mediatek can support baud rate up to 4M.
> the 'uart_get_baud_rate' function will limit the max baud rate.
> Modify max baud to remove the limit.
> 
> Signed-off-by: Long Cheng <long.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_mtk.c  |    6 +-----
>  drivers/tty/serial/8250/8250_port.c |    4 +---
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 3611ec9..ce0cc47 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -62,7 +62,7 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 */
>  	baud = uart_get_baud_rate(port, termios, old,
>  				  port->uartclk / 16 / 0xffff,
> -				  port->uartclk / 16);
> +				  port->uartclk);
>  
>  	if (baud <= 115200) {
>  		serial_port_out(port, UART_MTK_HIGHS, 0x0);
> @@ -76,10 +76,6 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
>  		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
>  	} else {
>  		serial_port_out(port, UART_MTK_HIGHS, 0x3);
> -
> -		/* Set to highest baudrate supported */
> -		if (baud >= 1152000)
> -			baud = 921600;
>  		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
>  	}
>  
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 7481b95..c45c1e3 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2504,8 +2504,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  					     struct ktermios *termios,
>  					     struct ktermios *old)
>  {
> -	unsigned int tolerance = port->uartclk / 100;
> -
>  	/*
>  	 * Ask the core to calculate the divisor for us.
>  	 * Allow 1% tolerance at the upper limit so uart clks marginally
> @@ -2514,7 +2512,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  	 */
>  	return uart_get_baud_rate(port, termios, old,
>  				  port->uartclk / 16 / 0xffff,
> -				  (port->uartclk + tolerance) / 16);
> +				  port->uartclk);
>  }
>  
>  void

Ping? Any reaction to the above?

Regards, thanks.
