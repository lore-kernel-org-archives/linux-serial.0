From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/2] serdev: Add ACPI support
Date: Tue, 10 Oct 2017 17:35:18 +0200
Message-ID: <20171010153518.GM4269@localhost>
References: <1507630365-26692-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507630365-26692-2-git-send-email-frederic.danis.oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507630365-26692-2-git-send-email-frederic.danis.oss@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, marcel@holtmann.org, sre@kernel.org, loic.poulain@gmail.com, johan@kernel.org, lukas@wunner.de, hdegoede@redhat.com, rafael@kernel.org, greg@kroah.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 10, 2017 at 12:12:44PM +0200, Frédéric Danis wrote:
> This patch allows SerDev module to manage serial devices declared as
> attached to an UART in ACPI table.
> 
> acpi_serdev_add_device() callback will only take into account entries
> without enumerated flag set. This flags is set for all entries during
> ACPI scan, except for SPI and I2C serial devices, and for UART with
> 2nd patch in the series.
> 
> Check if a serdev device as been allocated during acpi_walk_namespace()
> to prevent serdev controller registration instead of the tty-class device.

Good that we caught that one before every ACPI serial port broke. ;)

> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serdev/core.c | 106 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 99 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c

> @@ -385,6 +401,78 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
> +					    struct acpi_device *adev)
> +{
> +	struct serdev_device *serdev = NULL;
> +	int err;
> +
> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
> +	    acpi_device_enumerated(adev))
> +		return AE_OK;
> +
> +	serdev = serdev_device_alloc(ctrl);
> +	if (!serdev) {
> +		dev_err(&ctrl->dev, "failed to allocate serdev device for %s\n",
> +			dev_name(&adev->dev));
> +		return AE_NO_MEMORY;
> +	}
> +
> +	ACPI_COMPANION_SET(&serdev->dev, adev);
> +	acpi_device_set_enumerated(adev);

Looks like this flag needs to be cleared when the device is later
deregistered or you will not be able to reprobe the device (mostly
useful for development). Can probably done in a follow-up patch.

> +
> +	err = serdev_device_add(serdev);
> +	if (err) {
> +		dev_err(&serdev->dev,
> +			"failure adding ACPI serdev device. status %d\n", err);
> +		serdev_device_put(serdev);
> +		ctrl->serdev = NULL;

You should not clear this pointer here. This should be taken care of by
serdev core when registration fails, something which would also address
the problem with how to deal with multiple child nodes which is a
problem for ACPI as well as DT (as I mentioned briefly at Kernel
Recipes).

I'll submit a fix for that shortly, but the NULL assignment above needs
to go.

> +	}
> +
> +	return AE_OK;
> +}
> +
> +static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
> +				       void *data, void **return_value)
> +{
> +	struct serdev_controller *ctrl = data;
> +	struct acpi_device *adev;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +
> +	return acpi_serdev_register_device(ctrl, adev);
> +}
> +
> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(ctrl->dev.parent);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");

So what if there are more than one child node defined? You could end up
with an error here but with a slave still registered. And then when you
return -ENODEV, that memory will leak.

> +		return -ENODEV;

Simply falling through here, and then return 0 or -ENODEV based on
ctrl->serdev should suffice for now.

> +	}
> +
> +	if (!ctrl->serdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +#else
> +static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_ACPI */
> +
>  /**
>   * serdev_controller_add() - Add an serdev controller
>   * @ctrl:	controller to be registered.
> @@ -394,7 +482,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>   */
>  int serdev_controller_add(struct serdev_controller *ctrl)
>  {
> -	int ret;
> +	int ret_of, ret_acpi, ret;
>  
>  	/* Can't register until after driver model init */
>  	if (WARN_ON(!is_registered))
> @@ -404,12 +492,16 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>  	if (ret)
>  		return ret;
>  
> -	ret = of_serdev_register_devices(ctrl);
> -	if (ret)
> +	ret_of = of_serdev_register_devices(ctrl);
> +	ret_acpi = acpi_serdev_register_devices(ctrl);
> +	if (ret_of && ret_acpi) {
> +		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
> +			ret_of, ret_acpi);
> +		ret = -ENODEV;
>  		goto out_dev_del;
> +	}
>  
> -	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
> -		ctrl->nr, &ctrl->dev);
> +	dev_dbg(&ctrl->dev, "registered: dev:%p\n", &ctrl->dev);

This change belongs in a separate patch. There seem to be a few more
instances like this one, which can all be fixed in a later patch
instead.

>  	return 0;
>  
>  out_dev_del:

Johan
