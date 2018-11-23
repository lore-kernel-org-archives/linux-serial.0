From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] serial: imx: unprepare console clocks on remove
Date: Fri, 23 Nov 2018 09:08:11 +0100
Message-ID: <20181123080811.nezdtq47fqd265kx@pengutronix.de>
References: <20181114174940.7865-1-stefan@agner.ch>
 <20181114174940.7865-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114174940.7865-2-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, fabio.estevam@nxp.com, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 14, 2018 at 06:49:39PM +0100, Stefan Agner wrote:
> Currently imx_uart_console_setup() prepares clocks which do not
> get unprepared anywhere. Check whether the console has been used
> by testing if index is set and unprepare clocks in this case.
> 
> This makes sure that clocks are properly unprepared after the
> console device has been unbound.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/tty/serial/imx.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 313c3b1900a8..757c91e5105a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2085,7 +2085,7 @@ static struct console imx_uart_console = {
>  	.data		= &imx_uart_uart_driver,
>  };
>  
> -#define IMX_CONSOLE	&imx_uart_console
> +#define IMX_CONSOLE	(&imx_uart_console)
>  
>  #ifdef CONFIG_OF
>  static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
> @@ -2378,8 +2378,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  static int imx_uart_remove(struct platform_device *pdev)
>  {
>  	struct imx_port *sport = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +
> +	if (IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE) && IMX_CONSOLE->index >= 0) {
> +		clk_unprepare(sport->clk_ipg);
> +		clk_unprepare(sport->clk_per);
> +		IMX_CONSOLE->index = -1;
> +	}
>  
> -	return uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +	return ret;

I doubt this is right. imx_uart_console_setup is called once, and
if the console is on (say) ttymxc0 you don't want to unprepare the
clocks if ttymxc3 gets unbound.

So I think this cleanup must go into imx_uart_exit().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
