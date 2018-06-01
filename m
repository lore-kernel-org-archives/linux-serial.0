From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 15/19] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Fri, 1 Jun 2018 10:59:39 +0200
Message-ID: <d41488cd-18db-f99a-67ae-b0e809005b1d@i2se.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-16-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180529131014.18641-16-ricardo.ribalda@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, "David S . Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,


Am 29.05.2018 um 15:10 schrieb Ricardo Ribalda Delgado:
> Export serdev table to the module header, allowing module autoload via
> udev/modprobe.
>
> Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>   drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
> index db6068cd7a1f..bb7aed805083 100644
> --- a/drivers/net/ethernet/qualcomm/qca_uart.c
> +++ b/drivers/net/ethernet/qualcomm/qca_uart.c
> @@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
>   	free_netdev(qca->net_dev);
>   }
>   
> +static struct serdev_device_id qca_uart_serdev_id[] = {
> +	{ QCAUART_DRV_NAME, },

i guess the id must be stable, so in case someone changes the driver 
name this has unexpected side effects?

Apart from that i'm fine with this patch.

Thanks
Stefan

> +	{},
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
> +
>   static struct serdev_device_driver qca_uart_driver = {
>   	.probe = qca_uart_probe,
>   	.remove = qca_uart_remove,
> @@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
>   		.name = QCAUART_DRV_NAME,
>   		.of_match_table = of_match_ptr(qca_uart_of_match),
>   	},
> +	.id_table = qca_uart_serdev_id,
>   };
>   
>   module_serdev_device_driver(qca_uart_driver);
