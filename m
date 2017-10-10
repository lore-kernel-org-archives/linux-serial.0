From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Tue, 10 Oct 2017 10:10:58 +0200
Message-ID: <BC1C29B8-C76B-499D-B8BE-365B5D3A0065@holtmann.org>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151255.GH2618@localhost>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171007151255.GH2618@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Johan,

>> This patch allows SerDev module to manage serial devices declared as
>> attached to an UART in ACPI table.
>> 
>> acpi_serdev_add_device() callback will only take into account entries
>> without enumerated flag set. This flags is set for all entries during
>> ACPI scan, except for SPI and I2C serial devices, and for UART with
>> 2nd patch in the series.
>> 
>> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
>> ---
>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 94 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index c68fb3a..104777d 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
> 
>> @@ -385,6 +401,74 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>> 	return 0;
>> }
>> 
>> +#ifdef CONFIG_ACPI
>> +static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
>> +					    struct acpi_device *adev)
>> +{
>> +	struct serdev_device *serdev = NULL;
>> +	int err;
>> +
>> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
>> +	    acpi_device_enumerated(adev))
>> +		return AE_OK;
>> +
>> +	serdev = serdev_device_alloc(ctrl);
>> +	if (!serdev) {
>> +		dev_err(&ctrl->dev, "failed to allocate Serial device for %s\n",
> 
> s/Serial/serdev/
> 
>> +			dev_name(&adev->dev));
>> +		return AE_NO_MEMORY;
>> +	}
>> +
>> +	ACPI_COMPANION_SET(&serdev->dev, adev);
>> +	acpi_device_set_enumerated(adev);
>> +
>> +	err = serdev_device_add(serdev);
>> +	if (err) {
>> +		dev_err(&serdev->dev,
>> +			"failure adding ACPI device. status %d\n", err);
> 
> s/ACPI/ACPI serdev/?
> 
>> +		serdev_device_put(serdev);
>> +	}
>> +
>> +	return AE_OK;
>> +}
>> +
>> +static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>> +				       void *data, void **return_value)
>> +{
>> +	struct serdev_controller *ctrl = data;
>> +	struct acpi_device *adev;
>> +
>> +	if (acpi_bus_get_device(handle, &adev))
>> +		return AE_OK;
>> +
>> +	return acpi_serdev_register_device(ctrl, adev);
>> +}
>> +
>> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>> +{
>> +	acpi_status status;
>> +	acpi_handle handle;
>> +
>> +	handle = ACPI_HANDLE(ctrl->dev.parent);
>> +	if (!handle)
>> +		return -ENODEV;
>> +
>> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_warn(&ctrl->dev, "failed to enumerate Serial slaves\n");
> 
> s/Serial/serdev/
> 
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
> 
> What if there are no slaves defined? I'm not very familiar with the ACPI
> helpers, but from a quick look it seems you'd then end up returning zero
> here which would cause the serdev controller to be registered instead of
> the tty-class device.
> 
> [ And if I'm mistaken, you do want to suppress that error message for
> when there are no slaves defined. ]
> 
>> +}
>> +#else
>> +static inline int acpi_serdev_register_devices(struct serdev_controller *ctlr)
> 
> s/ctlr/ctrl/
> 
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif /* CONFIG_ACPI */
>> +
>> /**
>>  * serdev_controller_add() - Add an serdev controller
>>  * @ctrl:	controller to be registered.
>> @@ -394,7 +478,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>>  */
>> int serdev_controller_add(struct serdev_controller *ctrl)
>> {
>> -	int ret;
>> +	int ret_of, ret_acpi, ret;
>> 
>> 	/* Can't register until after driver model init */
>> 	if (WARN_ON(!is_registered))
>> @@ -404,9 +488,14 @@ int serdev_controller_add(struct serdev_controller *ctrl)
>> 	if (ret)
>> 		return ret;
>> 
>> -	ret = of_serdev_register_devices(ctrl);
>> -	if (ret)
>> +	ret_of = of_serdev_register_devices(ctrl);
>> +	ret_acpi = acpi_serdev_register_devices(ctrl);
>> +	if (ret_of && ret_acpi) {
>> +		dev_dbg(&ctrl->dev, "serdev%d no devices registered: of:%d acpi:%d\n",
> 
> "serdev%d" is redundant here as you're using dev_dbg (which will print
> the device name).
> 
>> +			ctrl->nr, ret_of, ret_acpi);
>> +		ret = -ENODEV;
>> 		goto out_dev_del;
>> +	}
>> 
>> 	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
>> 		ctrl->nr, &ctrl->dev);
> 
> Hmm, I see it's already used here. No need to follow that example
> though.

lets have an extra patch on top of it that fixes these.

Regards

Marcel

