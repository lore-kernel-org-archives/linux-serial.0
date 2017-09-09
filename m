From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC 1/3] serdev: Add ACPI support
Date: Sat, 9 Sep 2017 20:50:44 +0200
Message-ID: <AC100BF1-B6E9-47ED-95A0-7E7E75C0DE89@holtmann.org>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com>
 <1BC8D5B0-EC18-4F20-9CBC-D73CB1765683@holtmann.org>
 <55c85c4d-f674-6f00-f112-76d1a70e8e0a@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55c85c4d-f674-6f00-f112-76d1a70e8e0a@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Cc: robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fred,

>>> +#ifdef CONFIG_ACPI
>>> +static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
>>> +					    struct acpi_device *adev)
>>> +{
>>> +	struct serdev_device *serdev = NULL;
>>> +	int err;
>>> +
>>> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
>>> +	    acpi_device_enumerated(adev))
>>> +		return AE_OK;
>>> +
>>> +	serdev = serdev_device_alloc(ctrl);
>>> +	if (!serdev) {
>>> +		dev_err(&ctrl->dev, "failed to allocate Serial device for %s\n",
>>> +			dev_name(&adev->dev));
>>> +		return AE_NO_MEMORY;
>>> +	}
>>> +
>>> +	ACPI_COMPANION_SET(&serdev->dev, adev);
>>> +	acpi_device_set_enumerated(adev);
>>> +
>>> +	err = serdev_device_add(serdev);
>>> +	if (err) {
>>> +		dev_err(&serdev->dev,
>>> +			"failure adding ACPI device. status %d\n", err);
>>> +		serdev_device_put(serdev);
>>> +	}
>>> +
>>> +	return AE_OK;
>>> +}
>>> +
>>> +static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>>> +				       void *data, void **return_value)
>>> +{
>>> +	struct serdev_controller *ctrl = data;
>>> +	struct acpi_device *adev;
>>> +
>>> +	if (acpi_bus_get_device(handle, &adev))
>>> +		return AE_OK;
>>> +
>>> +	return acpi_serdev_register_device(ctrl, adev);
>>> +}
>>> +
>>> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>>> +{
>>> +	acpi_status status;
>>> +	acpi_handle handle;
>>> +
>>> +	handle = ACPI_HANDLE(ctrl->dev.parent);
>>> +	if (!handle)
>>> +		return -ENODEV;
>>> +
>>> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>>> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
>>> +	if (ACPI_FAILURE(status)) {
>>> +		dev_warn(&ctrl->dev, "failed to enumerate Serial slaves\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>> how are we ensuring that we only take UART devices into account here?
> 
> acpi_serdev_add_device() callback will only take into account entries without enumerated flag set.
> This flags is set for all entries during ACPI scan, except for SPI and I2C serial devices, and for UART with 2nd patch in the series.

sounds good to me. Can you respin this series with the other comments addressed and maybe add some extra comments in the code or the commit message to make this clear.

Regards

Marcel

