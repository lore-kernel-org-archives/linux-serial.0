From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: remove redundant setting of line config
 during port reset
Date: Mon, 31 Dec 2012 14:03:46 -0800
Message-ID: <032f01cde7a2$b6a7a250$23f6e6f0$@samsung.com>
References: <1356990165-3905-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1356990165-3905-1-git-send-email-thomas.ab@samsung.com>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Thomas Abraham wrote:
> 
> The setting of uart line control configuration in s3c24xx_serial_resetport
> is can be removed since the 'set_termios' call will overwrite any ULCON
> register setting which s3c24xx_serial_resetport does.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Greg, if you're ok on this, please pick this up for v3.8

Happy New Year!!!

- Kukjin

> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/tty/serial/samsung.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 12e5249..e514b3a 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1006,7 +1006,6 @@ static void s3c24xx_serial_resetport(struct
> uart_port *port,
> 
>  	ucon &= ucon_mask;
>  	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
> -	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
> 
>  	/* reset both fifos */
>  	wr_regl(port, S3C2410_UFCON, cfg->ufcon |
> S3C2410_UFCON_RESETBOTH);
> --
> 1.7.5.4
