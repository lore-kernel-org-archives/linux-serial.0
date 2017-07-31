From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC v2 5/6] max9260: add driver for i2c over GMSL passthrough
Date: Mon, 31 Jul 2017 14:13:05 +0300
Message-ID: <12735239.0iiT7hxZXA@avalon>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 17 Jul 2017 17:24:35 Ulrich Hecht wrote:
> This driver implements tunnelling of i2c requests over GMSL via a
> MAX9260 deserializer. It provides an i2c adapter that can be used
> to reach devices on the far side of the link.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  drivers/media/i2c/Kconfig   |   6 +
>  drivers/media/i2c/Makefile  |   1 +
>  drivers/media/i2c/max9260.c | 288 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 295 insertions(+)
>  create mode 100644 drivers/media/i2c/max9260.c

[snip]

> diff --git a/drivers/media/i2c/max9260.c b/drivers/media/i2c/max9260.c
> new file mode 100644
> index 0000000..ca34e67
> --- /dev/null
> +++ b/drivers/media/i2c/max9260.c
> @@ -0,0 +1,288 @@
> +/*
> + * Maxim MAX9260 GMSL Deserializer Driver
> + *
> + * Copyright (C) 2017 Ulrich Hecht
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by
> the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <linux/tty.h>
> +
> +#define SYNC	0x79
> +#define ACK	0xc3
> +
> +#define RX_FINISHED		0
> +#define RX_FRAME_ERROR		1
> +#define RX_EXPECT_ACK		2
> +#define RX_EXPECT_ACK_DATA	3
> +#define RX_EXPECT_DATA		4

Should you make this an enum and update the type of max9260_device::rx_state 
accordingly ?

> +
> +struct max9260_device {
> +	struct serdev_device *serdev;
> +	u8 *rx_buf;
> +	int rx_len;

rx_len can't be negative, you can make it an unsigned int.

> +	int rx_state;
> +	wait_queue_head_t rx_wq;
> +	struct i2c_adapter adap;
> +};
> +
> +static void wait_for_transaction(struct max9260_device *dev)
> +{
> +	wait_event_interruptible_timeout(dev->rx_wq,
> +		dev->rx_state <= RX_FRAME_ERROR,
> +		HZ/2);
> +}
> +
> +static void max9260_transact(struct max9260_device *dev,
> +			     int expect,
> +			     u8 *request, int len)
> +{
> +	serdev_device_mux_select(dev->serdev);
> +
> +	serdev_device_set_baudrate(dev->serdev, 115200);
> +	serdev_device_set_parity(dev->serdev, 1, 0);
> +
> +	dev->rx_state = expect;
> +	serdev_device_write_buf(dev->serdev, request, len);
> +
> +	wait_for_transaction(dev);
> +
> +	serdev_device_mux_deselect(dev->serdev);

You will end up selecting and deselecting the multiplexer around every I2C 
transaction, which can be quite inefficient when initializing devices on the 
other side of the link that require hundreds of I2C writes.

Fixing this could be considered as a future optimization, but it will likely 
involve changes in the serdev mux API, so I think it should be considered now 
already, even if not fully implemented in this driver.

> +}
> +
> +static int max9260_read_reg(struct max9260_device *dev, int reg)
> +{
> +	u8 request[] = { 0x79, 0x91, reg, 1 };
> +	u8 rx;
> +
> +	dev->rx_len = 1;
> +	dev->rx_buf = &rx;
> +
> +	max9260_transact(dev, RX_EXPECT_ACK_DATA, request, 4);

s/4/ARRAY_SIZE(request)/

Passing part of the transaction through function arguments and part through 
the max9260_device structure seems weird. I think you should pass both the 
output and input buffers and lengths as arguments, and store the information 
you need in max9260_device within max9260_transact().

> +	if (dev->rx_state == RX_FINISHED)
> +		return rx;
> +
> +	return -EIO;
> +}
> +
> +static int max9260_setup(struct max9260_device *dev)
> +{
> +	int ret;
> +
> +	ret = max9260_read_reg(dev, 0x1e);

No magic values, please use macros.

> +
> +	if (ret != 0x02) {

Ditto here and in multiple locations below.

> +		dev_err(&dev->serdev->dev,
> +			"device does not identify as MAX9260\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max9260_uart_write_wakeup(struct serdev_device *serdev)
> +{
> +}
> +
> +static int max9260_uart_receive_buf(struct serdev_device *serdev,
> +				    const u8 *data, size_t count)
> +{
> +	struct max9260_device *dev = serdev_device_get_drvdata(serdev);
> +	int accepted;

This can't be negative, you can make it an unsigned int.

> +
> +	switch (dev->rx_state) {
> +	case RX_FINISHED:
> +		dev_dbg(&dev->serdev->dev, "excess data ignored\n");
> +		return count;
> +
> +	case RX_EXPECT_ACK:
> +	case RX_EXPECT_ACK_DATA:
> +		if (data[0] != ACK) {
> +			dev_dbg(&dev->serdev->dev, "frame error");
> +			dev->rx_state = RX_FRAME_ERROR;
> +			wake_up_interruptible(&dev->rx_wq);
> +			return 1;
> +		}
> +
> +		if (dev->rx_state == RX_EXPECT_ACK_DATA) {
> +			dev->rx_state = RX_EXPECT_DATA;
> +		} else {
> +			dev->rx_state = RX_FINISHED;
> +			wake_up_interruptible(&dev->rx_wq);
> +		}
> +		return 1;
> +
> +	case RX_EXPECT_DATA:
> +		accepted = dev->rx_len < count ? dev->rx_len : count;

accepted = min(dev->rx_len, count);

> +
> +		memcpy(dev->rx_buf, data, accepted);
> +
> +		dev->rx_len -= accepted;
> +		dev->rx_buf += accepted;
> +
> +		if (!dev->rx_len) {
> +			dev->rx_state = RX_FINISHED;
> +			wake_up_interruptible(&dev->rx_wq);
> +		}
> +
> +		return accepted;
> +
> +	case RX_FRAME_ERROR:
> +		dev_dbg(&dev->serdev->dev, "%d bytes ignored\n", count);
> +		return count;
> +
> +	}
> +	return 0;
> +}
> +
> +struct serdev_device_ops max9260_serdev_client_ops = {

static const ?

> +	.receive_buf = max9260_uart_receive_buf,
> +	.write_wakeup = max9260_uart_write_wakeup,
> +};
> +
> +static u32 max9260_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_BYTE|I2C_FUNC_SMBUS_BYTE_DATA;
> +}
> +
> +static s32 max9260_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +	unsigned short flags, char read_write, u8 command, int size,
> +	union i2c_smbus_data *data)
> +{
> +	u8 request[] = { SYNC,
> +			 (addr << 1) + (read_write == I2C_SMBUS_READ),
> +			 command, 0, 0 };
> +	struct max9260_device *dev = i2c_get_adapdata(adap);
> +
> +	switch (size) {
> +	case I2C_SMBUS_BYTE:
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			max9260_transact(dev, RX_EXPECT_ACK, request, 4);
> +			dev_dbg(&adap->dev,
> +				"smbus byte - addr 0x%02x, wrote 0x%02x.\n",
> +				addr, command);
> +		} else {
> +			/* TBD */
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +
> +	case I2C_SMBUS_BYTE_DATA:
> +		request[3] = 1;
> +		if (read_write == I2C_SMBUS_WRITE) {
> +			request[4] = data->byte;
> +			max9260_transact(dev, RX_EXPECT_ACK, request, 5);
> +			dev_dbg(&adap->dev,
> +				"smbus byte data - addr 0x%02x, wrote 0x%02x 
at 0x%02x.\n",
> +				addr, data->byte, command);
> +		} else {
> +			dev->rx_len = 1;
> +			dev->rx_buf = &data->byte;
> +			max9260_transact(dev, RX_EXPECT_ACK_DATA, request, 4);
> +			dev_dbg(&adap->dev,
> +				"smbus byte data - addr 0x%02x, read  0x%02x 
at 0x%02x.\n",
> +				addr, data->byte, command);
> +		}
> +		break;

Missing blank line.

> +	default:
> +		dev_dbg(&adap->dev,
> +			"Unsupported I2C/SMBus command %d\n", size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (dev->rx_state != RX_FINISHED) {
> +		dev_dbg(&adap->dev, "xfer timed out\n");
> +		return -EIO;

The comment states timed out but the return value corresponds to an I/O error. 
Which one should it be ?

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_algorithm max9260_i2c_algorithm = {
> +	.functionality	= max9260_i2c_func,
> +	.smbus_xfer	= max9260_smbus_xfer,
> +};
> +
> +static int max9260_probe(struct serdev_device *serdev)
> +{
> +	struct max9260_device *dev;
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	init_waitqueue_head(&dev->rx_wq);
> +
> +	dev->serdev = serdev;
> +	serdev_device_open(serdev);
> +	serdev_device_set_drvdata(serdev, dev);
> +
> +	serdev_device_set_client_ops(serdev, &max9260_serdev_client_ops);
> +
> +	ret = max9260_setup(dev);
> +	if (ret < 0)
> +		goto err_free;
> +
> +	adap = &dev->adap;
> +	i2c_set_adapdata(adap, dev);
> +
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &max9260_i2c_algorithm;
> +	adap->dev.parent = &serdev->dev;
> +	adap->retries = 5;
> +	strlcpy(adap->name, dev_name(&serdev->dev), sizeof(adap->name));
> +
> +	ret = i2c_add_adapter(adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +
> +err_free:

No need for a serdev_device_close() ?

> +	kfree(dev);
> +	return ret;
> +}
> +
> +static void max9260_remove(struct serdev_device *serdev)
> +{
> +	struct max9260_device *dev = serdev_device_get_drvdata(serdev);
> +
> +	serdev_device_close(dev->serdev);
> +
> +	kfree(dev);
> +}
> +
> +static const struct of_device_id max9260_dt_ids[] = {
> +	{ .compatible = "maxim,max9260" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, max9260_dt_ids);
> +
> +static struct serdev_device_driver max9260_driver = {
> +	.probe = max9260_probe,
> +	.remove = max9260_remove,
> +	.driver = {
> +		.name = "max9260",
> +		.of_match_table = of_match_ptr(max9260_dt_ids),
> +	},
> +};
> +
> +module_serdev_device_driver(max9260_driver);
> +
> +MODULE_DESCRIPTION("Maxim MAX9260 GMSL Deserializer Driver");
> +MODULE_AUTHOR("Ulrich Hecht");
> +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart
