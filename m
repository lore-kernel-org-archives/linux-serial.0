From: maowenan <maowenan@huawei.com>
Subject: Re: [PATCH serial] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Date: Fri, 8 Mar 2019 21:58:27 +0800
Message-ID: <d4d29f26-03eb-1644-26ca-98ed4d450166@huawei.com>
References: <20190308140933.55262-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308140933.55262-1-maowenan@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

sorry for duplicate mail, please ignore this one.

On 2019/3/8 22:09, Mao Wenan wrote:
> Add the missing uart_unregister_driver() and i2c_del_driver() before return
> from sc16is7xx_init() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 268098681856..114e94f476c6 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1509,7 +1509,7 @@ static int __init sc16is7xx_init(void)
>  	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
>  	if (ret < 0) {
>  		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
> -		return ret;
> +		goto err_i2c;
>  	}
>  #endif
>  
> @@ -1517,10 +1517,18 @@ static int __init sc16is7xx_init(void)
>  	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
>  	if (ret < 0) {
>  		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
> -		return ret;
> +		goto err_spi;
>  	}
>  #endif
>  	return ret;
> +
> +err_spi:
> +#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
> +	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
> +#endif
> +err_i2c:
> +	uart_unregister_driver(&sc16is7xx_uart);
> +	return ret;
>  }
>  module_init(sc16is7xx_init);
>  
> 
