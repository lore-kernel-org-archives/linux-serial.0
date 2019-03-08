From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH serial] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Date: Fri, 8 Mar 2019 22:26:44 +0200
Message-ID: <d2888b44-2475-ebe1-bbc7-844147e9d11a@mleia.com>
References: <20190308140933.55262-1-maowenan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308140933.55262-1-maowenan@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mao Wenan <maowenan@huawei.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/08/2019 04:09 PM, Mao Wenan wrote:
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

Nice catch, thank you!

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
