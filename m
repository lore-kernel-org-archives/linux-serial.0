From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 15/24] net: qualcomm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 15:01:01 +0200
Message-ID: <CCB7FF79-F89A-4421-A6C0-E0663BEE6065@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-16-ricardo.ribalda@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-16-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, "David S. Miller" <davem@davemloft.net>, Stefan Wahren <stefan.wahren@i2se.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, netdev@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

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
> drivers/net/ethernet/qualcomm/qca_uart.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
> index db6068cd7a1f..6d2ac6cae63f 100644
> --- a/drivers/net/ethernet/qualcomm/qca_uart.c
> +++ b/drivers/net/ethernet/qualcomm/qca_uart.c
> @@ -405,6 +405,12 @@ static void qca_uart_remove(struct serdev_device *serdev)
> 	free_netdev(qca->net_dev);
> }
> 
> +static struct serdev_device_id qca_uart_serdev_id[] = {
> +	{ QCAUART_DRV_NAME, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(serdev, qca_uart_serdev_id);
> +
> static struct serdev_device_driver qca_uart_driver = {
> 	.probe = qca_uart_probe,
> 	.remove = qca_uart_remove,
> @@ -412,6 +418,7 @@ static struct serdev_device_driver qca_uart_driver = {
> 		.name = QCAUART_DRV_NAME,
> 		.of_match_table = of_match_ptr(qca_uart_of_match),
> 	},
> +	.id_table = qca_uart_serdev_id,
> };

the commit message is misleading me. If I build something with ACPI or DT support, then modinfo will show all modalias information for ACPI and DT compatible strings. What else does udev/modprobe actually need? Is something broken with the modalias export?

Regards

Marcel
