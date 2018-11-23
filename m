From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] serial: imx: fix error handling in console_setup
Date: Fri, 23 Nov 2018 09:03:08 +0100
Message-ID: <20181123080308.b5t75gfmjcop5rmb@pengutronix.de>
References: <20181114174940.7865-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114174940.7865-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, fabio.estevam@nxp.com, s.hauer@pengutronix.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 14, 2018 at 06:49:38PM +0100, Stefan Agner wrote:
> The ipg clock only needs to be unprepared in case preparing
> per clock fails. The ipg clock has already disabled at the point.
> 
> Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 0f67197a3783..313c3b1900a8 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2068,7 +2068,7 @@ imx_uart_console_setup(struct console *co, char *options)
>  
>  	retval = clk_prepare(sport->clk_per);
>  	if (retval)
> -		clk_disable_unprepare(sport->clk_ipg);
> +		clk_unprepare(sport->clk_ipg);

good catch,

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
