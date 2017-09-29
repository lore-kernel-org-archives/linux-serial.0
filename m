From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: [RFC 1/3] serdev: Add ACPI support
Date: Fri, 29 Sep 2017 14:17:33 +0200
Message-ID: <6c1a7ba2-ba04-b075-4a04-4f42dfe3a8c7@gmail.com>
References: <1504786214-1866-1-git-send-email-frederic.danis.oss@gmail.com>
 <1504786214-1866-2-git-send-email-frederic.danis.oss@gmail.com>
 <1BC8D5B0-EC18-4F20-9CBC-D73CB1765683@holtmann.org>
 <55c85c4d-f674-6f00-f112-76d1a70e8e0a@gmail.com>
 <AC100BF1-B6E9-47ED-95A0-7E7E75C0DE89@holtmann.org>
 <D48CDCC9-F039-4E80-BA12-5A579E13E09F@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <D48CDCC9-F039-4E80-BA12-5A579E13E09F@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh@kernel.org>, sre@kernel.org, loic.poulain@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, johan@kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Marcel,

Le 29/09/2017 à 14:00, Marcel Holtmann a écrit :
> Hi Fred,
>
>>>>> +#ifdef CONFIG_ACPI
>>>>> +static acpi_status acpi_serdev_register_device(struct serdev_controller *ctrl,
>>>>> +					    struct acpi_device *adev)
>>>>> +{
>>>>> +	struct serdev_device *serdev = NULL;
>>>>> +	int err;
>>>>> +
>>>>> +	if (acpi_bus_get_status(adev) || !adev->status.present ||
>>>>> +	    acpi_device_enumerated(adev))
>>>>> +		return AE_OK;
>>>>> +
>>>>> +	serdev = serdev_device_alloc(ctrl);
>>>>> +	if (!serdev) {
>>>>> +		dev_err(&ctrl->dev, "failed to allocate Serial device for %s\n",
>>>>> +			dev_name(&adev->dev));
>>>>> +		return AE_NO_MEMORY;
>>>>> +	}
>>>>> +
>>>>> +	ACPI_COMPANION_SET(&serdev->dev, adev);
>>>>> +	acpi_device_set_enumerated(adev);
>>>>> +
>>>>> +	err = serdev_device_add(serdev);
>>>>> +	if (err) {
>>>>> +		dev_err(&serdev->dev,
>>>>> +			"failure adding ACPI device. status %d\n", err);
>>>>> +		serdev_device_put(serdev);
>>>>> +	}
>>>>> +
>>>>> +	return AE_OK;
>>>>> +}
>>>>> +
>>>>> +static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
>>>>> +				       void *data, void **return_value)
>>>>> +{
>>>>> +	struct serdev_controller *ctrl = data;
>>>>> +	struct acpi_device *adev;
>>>>> +
>>>>> +	if (acpi_bus_get_device(handle, &adev))
>>>>> +		return AE_OK;
>>>>> +
>>>>> +	return acpi_serdev_register_device(ctrl, adev);
>>>>> +}
>>>>> +
>>>>> +static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>>>>> +{
>>>>> +	acpi_status status;
>>>>> +	acpi_handle handle;
>>>>> +
>>>>> +	handle = ACPI_HANDLE(ctrl->dev.parent);
>>>>> +	if (!handle)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>>>>> +				     acpi_serdev_add_device, NULL, ctrl, NULL);
>>>>> +	if (ACPI_FAILURE(status)) {
>>>>> +		dev_warn(&ctrl->dev, "failed to enumerate Serial slaves\n");
>>>>> +		return -ENODEV;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>> how are we ensuring that we only take UART devices into account here?
>>> acpi_serdev_add_device() callback will only take into account entries without enumerated flag set.
>>> This flags is set for all entries during ACPI scan, except for SPI and I2C serial devices, and for UART with 2nd patch in the series.
>> sounds good to me. Can you respin this series with the other comments addressed and maybe add some extra comments in the code or the commit message to make this clear.
> any updates on this?

While working on it, I tried to add the PM support 
(bcm_serdev_driver.driver.pm = &bcm_pm_ops) but it ends up in kernel 
freeze during suspend to ram test.
I may have found the problem but do not have access to T100 now to test 
it (this may take some times as I work on it on spare time).

Regards,

Fred
