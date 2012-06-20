From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] serial: samsung: protect NULL dereference of clock name
Date: Wed, 20 Jun 2012 13:28:47 +0900
Message-ID: <029001cd4e9d$2f2af9b0$8d80ed10$%kim@samsung.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyoungil Kim' <ki0351.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: 'Alan Cox' <alan@linux.intel.com>, 'KeyYoung Park' <keyyoung.park@samsung.com>, 'Huisung Kang' <hs1218.kang@samsung.com>, gregkh@linuxfoundation.org
List-Id: linux-serial@vger.kernel.org

Kyoungil Kim wrote:
> 
> From: KeyYoung Park <keyyoung.park@samsung.com>
> 
> When priting the serial clock source, if clock source name is null,
> kernel reference NULL point.
> 
> Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
> Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>

(Cc'ed Greg)

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Greg, could you please pick this up?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/tty/serial/samsung.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index ea76b40..77484e0 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1160,7 +1160,8 @@ static ssize_t s3c24xx_serial_show_clksrc(struct
> device *dev,
>  	struct uart_port *port = s3c24xx_dev_to_port(dev);
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 
> -	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
> +	return snprintf(buf, PAGE_SIZE, "* %s\n",
> +			ourport->baudclk->name ?: "(null)");
>  }
> 
>  static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc,
> NULL);
> --
> 1.7.1
