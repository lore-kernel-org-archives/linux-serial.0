From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 14/24] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 15:14:46 +0200
Message-ID: <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-15-ricardo.ribalda@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-15-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

> Export serdev table to the module header, allowing module autoload via
> udev/modprobe.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/mfd/rave-sp.c | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 5c858e784a89..c0ecfbc16dca 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *serdev)
> 
> MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
> 
> +static struct serdev_device_id rave_sp_serdev_id[] = {
> +	{ "rave-sp", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
> +
> static struct serdev_device_driver rave_sp_drv = {
> 	.probe			= rave_sp_probe,
> 	.driver = {
> 		.name		= "rave-sp",
> 		.of_match_table	= rave_sp_dt_ids,
> 	},
> +	.id_table = rave_sp_serdev_id,
> };
> module_serdev_device_driver(rave_sp_drv);

so I would actually prefer that we not duplicate the .driver.name in the .id_table. This one for example is non-functional since all supported hardware needs a specific .data entry. It will fail here:

        sp->variant = of_device_get_match_data(dev);                             
        if (!sp->variant)                                                        
                return -ENODEV;

Maybe we focus first on getting the base support for new_device etc. merged and use the Edison Bluetooth platform driver support in hci_bcm.c so we can do a real cleanup there. And then later add broad new_device support. Some of these instances should be just fine with never getting it since they require to many per device quirks to make things functional. A blind search+replace is not going to work.

And things like device_get_match_data() should work as well even if the hardware is listed via serdev_device_id. Drivers that are solely DT centric will need a lot more work before dynamic adding of serdev devices can happen.

Regards

Marcel
