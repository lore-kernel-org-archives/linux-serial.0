From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 11/24] Bluetooth: hci_bcm: MODULE_DEVICE_TABLE(serdev)
Date: Mon, 11 Jun 2018 14:59:19 +0200
Message-ID: <D4622EB7-BB18-4931-BF14-34995F7EBBA8@holtmann.org>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-12-ricardo.ribalda@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-12-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ricardo,

> Export serdev table to the module header, allowing module autoload via
> udev/modprobe.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index f4d7846c06b8..ff0fd3502a90 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1327,8 +1327,10 @@ MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
> 
> static const struct serdev_device_id bcm_serdev_id[] = {
> 	{ "bcm43438-bt", },
> +	{ "hci_uart_bcm", },
> 	{}
> };
> +MODULE_DEVICE_TABLE(serdev, bcm_serdev_id);

so this one I can see real use of and is a good fix to finally clean up hci_bcm.c and remove platform support for the Edison hardware. However, I would really then first rename hci_uart_bcm into some Edison specific string since this is really just one outlier here. Everything else will have ACPI or DT support.

With that said, I do not understand why we need to duplicate the DT compatible strings in serdev_device_id. They will be enumerated fine via ACPI or DT in the first place. So if we want some new_id support, then wouldn’t an empty serdev_device_id table just be fine?

Regards

Marcel
