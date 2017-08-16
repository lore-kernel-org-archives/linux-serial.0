From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 4/6] max9260: add driver for i2c over GMSL passthrough
Date: Wed, 16 Aug 2017 15:22:26 +0200
Message-ID: <1502889748-31499-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

This driver implements tunnelling of i2c requests over GMSL via a
MAX9260 deserializer. It provides an i2c adapter that can be used
to reach devices on the far side of the link.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/media/i2c/Kconfig   |   6 +
 drivers/media/i2c/Makefile  |   1 +
 drivers/media/i2c/max9260.c | 300 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 drivers/media/i2c/max9260.c

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index fa2e7d8..b85ae78 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -424,6 +424,12 @@ config VIDEO_VPX3220
 	  To compile this driver as a module, choose M here: the
 	  module will be called vpx3220.
 
+config VIDEO_MAX9260
+	tristate "Maxim MAX9260 GMSL deserializer support"
+	depends on I2C
+	---help---
+	  This driver supports the Maxim MAX9260 GMSL deserializer.
+
 comment "Video and audio decoders"
 
 config VIDEO_SAA717X
diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index 30e856c..3b6f6f2 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_VIDEO_OV7640) += ov7640.o
 obj-$(CONFIG_VIDEO_OV7670) += ov7670.o
 obj-$(CONFIG_VIDEO_OV9650) += ov9650.o
 obj-$(CONFIG_VIDEO_OV13858) += ov13858.o
+obj-$(CONFIG_VIDEO_MAX9260) += max9260.o
 obj-$(CONFIG_VIDEO_MT9M032) += mt9m032.o
 obj-$(CONFIG_VIDEO_MT9M111) += mt9m111.o
 obj-$(CONFIG_VIDEO_MT9P031) += mt9p031.o
diff --git a/drivers/media/i2c/max9260.c b/drivers/media/i2c/max9260.c
new file mode 100644
index 0000000..9c890ab
--- /dev/null
+++ b/drivers/media/i2c/max9260.c
@@ -0,0 +1,300 @@
+/*
+ * Maxim MAX9260 GMSL Deserializer Driver
+ *
+ * Copyright (C) 2017 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+
+#define SYNC	0x79
+#define ACK	0xc3
+
+#define REG_ID		0x1e
+
+#define ID_MAX9260	0x02
+
+enum max9260_rx_state {
+	RX_FINISHED,
+	RX_FRAME_ERROR,
+	RX_EXPECT_ACK,
+	RX_EXPECT_ACK_DATA,
+	RX_EXPECT_DATA,
+};
+
+struct max9260_device {
+	struct serdev_device *serdev;
+	u8 *rx_buf;
+	size_t rx_len;
+	enum max9260_rx_state rx_state;
+	wait_queue_head_t rx_wq;
+	struct i2c_adapter adap;
+};
+
+static void max9260_wait_for_transaction(struct max9260_device *dev)
+{
+	wait_event_timeout(dev->rx_wq, dev->rx_state <= RX_FRAME_ERROR,
+		HZ/2);
+}
+
+static void max9260_transact(struct max9260_device *dev,
+			     int expect,
+			     const u8 *request, int len,
+			     u8 *rx_buf, int rx_len)
+{
+	dev->rx_buf = rx_buf;
+	dev->rx_len = rx_len;
+
+	serdev_device_mux_select(dev->serdev);
+
+	serdev_device_set_baudrate(dev->serdev, 115200);
+	serdev_device_set_parity(dev->serdev, SERDEV_PARITY_EVEN);
+
+	dev->rx_state = expect;
+	serdev_device_write_buf(dev->serdev, request, len);
+
+	max9260_wait_for_transaction(dev);
+
+	serdev_device_mux_deselect(dev->serdev);
+}
+
+static int max9260_read_reg(struct max9260_device *dev, int reg)
+{
+	u8 request[] = { SYNC, 0x91, reg, 1 };
+	u8 rx;
+
+	dev->rx_len = 1;
+	dev->rx_buf = &rx;
+
+	max9260_transact(dev, RX_EXPECT_ACK_DATA, request,
+			 ARRAY_SIZE(request),
+			 &rx, 1);
+
+	if (dev->rx_state == RX_FINISHED)
+		return rx;
+
+	return -EIO;
+}
+
+static int max9260_setup(struct max9260_device *dev)
+{
+	int ret;
+
+	ret = max9260_read_reg(dev, REG_ID);
+
+	if (ret != ID_MAX9260) {
+		dev_err(&dev->serdev->dev,
+			"device does not identify as MAX9260\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void max9260_uart_write_wakeup(struct serdev_device *serdev)
+{
+}
+
+static int max9260_uart_receive_buf(struct serdev_device *serdev,
+				    const u8 *data, size_t count)
+{
+	struct max9260_device *dev = serdev_device_get_drvdata(serdev);
+	size_t accepted;
+
+	switch (dev->rx_state) {
+	case RX_FINISHED:
+		dev_dbg(&dev->serdev->dev, "excess data ignored\n");
+		return count;
+
+	case RX_EXPECT_ACK:
+	case RX_EXPECT_ACK_DATA:
+		if (data[0] != ACK) {
+			dev_dbg(&dev->serdev->dev, "frame error");
+			dev->rx_state = RX_FRAME_ERROR;
+			wake_up_interruptible(&dev->rx_wq);
+			return 1;
+		}
+
+		if (dev->rx_state == RX_EXPECT_ACK_DATA) {
+			dev->rx_state = RX_EXPECT_DATA;
+		} else {
+			dev->rx_state = RX_FINISHED;
+			wake_up_interruptible(&dev->rx_wq);
+		}
+		return 1;
+
+	case RX_EXPECT_DATA:
+		accepted = min(dev->rx_len, count);
+
+		memcpy(dev->rx_buf, data, accepted);
+
+		dev->rx_len -= accepted;
+		dev->rx_buf += accepted;
+
+		if (!dev->rx_len) {
+			dev->rx_state = RX_FINISHED;
+			wake_up_interruptible(&dev->rx_wq);
+		}
+
+		return accepted;
+
+	case RX_FRAME_ERROR:
+		dev_dbg(&dev->serdev->dev, "%d bytes ignored\n", count);
+		return count;
+
+	}
+	return 0;
+}
+
+static const struct serdev_device_ops max9260_serdev_client_ops = {
+	.receive_buf = max9260_uart_receive_buf,
+	.write_wakeup = max9260_uart_write_wakeup,
+};
+
+static u32 max9260_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static s32 max9260_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+	unsigned short flags, char read_write, u8 command, int size,
+	union i2c_smbus_data *data)
+{
+	u8 request[] = { SYNC,
+			 (addr << 1) + (read_write == I2C_SMBUS_READ),
+			 command, 0, 0 };
+	struct max9260_device *dev = i2c_get_adapdata(adap);
+
+	switch (size) {
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE) {
+			max9260_transact(dev, RX_EXPECT_ACK, request, 4,
+					 NULL, 0);
+			dev_dbg(&adap->dev,
+				"smbus byte - addr 0x%02x, wrote 0x%02x.\n",
+				addr, command);
+		} else {
+			/* TBD */
+			return -EOPNOTSUPP;
+		}
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		request[3] = 1;
+		if (read_write == I2C_SMBUS_WRITE) {
+			request[4] = data->byte;
+			max9260_transact(dev, RX_EXPECT_ACK, request, 5,
+					 NULL, 0);
+			dev_dbg(&adap->dev,
+				"smbus byte data - addr 0x%02x, wrote 0x%02x at 0x%02x.\n",
+				addr, data->byte, command);
+		} else {
+			max9260_transact(dev, RX_EXPECT_ACK_DATA, request, 4,
+					 &data->byte, 1);
+			dev_dbg(&adap->dev,
+				"smbus byte data - addr 0x%02x, read  0x%02x at 0x%02x.\n",
+				addr, data->byte, command);
+		}
+		break;
+	default:
+		dev_dbg(&adap->dev,
+			"Unsupported I2C/SMBus command %d\n", size);
+		return -EOPNOTSUPP;
+	}
+
+	if (dev->rx_state != RX_FINISHED) {
+		dev_dbg(&adap->dev, "xfer timed out\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static const struct i2c_algorithm max9260_i2c_algorithm = {
+	.functionality	= max9260_i2c_func,
+	.smbus_xfer	= max9260_smbus_xfer,
+};
+
+static int max9260_probe(struct serdev_device *serdev)
+{
+	struct max9260_device *dev;
+	struct i2c_adapter *adap;
+	int ret;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	init_waitqueue_head(&dev->rx_wq);
+
+	dev->serdev = serdev;
+	serdev_device_open(serdev);
+	serdev_device_set_drvdata(serdev, dev);
+
+	serdev_device_set_client_ops(serdev, &max9260_serdev_client_ops);
+
+	ret = max9260_setup(dev);
+	if (ret < 0)
+		goto err_free;
+
+	adap = &dev->adap;
+	i2c_set_adapdata(adap, dev);
+
+	adap->owner = THIS_MODULE;
+	adap->algo = &max9260_i2c_algorithm;
+	adap->dev.parent = &serdev->dev;
+	adap->retries = 5;
+	strlcpy(adap->name, dev_name(&serdev->dev), sizeof(adap->name));
+
+	ret = i2c_add_adapter(adap);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+
+err_free:
+	kfree(dev);
+	return ret;
+}
+
+static void max9260_remove(struct serdev_device *serdev)
+{
+	struct max9260_device *dev = serdev_device_get_drvdata(serdev);
+
+	serdev_device_close(dev->serdev);
+
+	kfree(dev);
+}
+
+static const struct of_device_id max9260_dt_ids[] = {
+	{ .compatible = "maxim,max9260" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, max9260_dt_ids);
+
+static struct serdev_device_driver max9260_driver = {
+	.probe = max9260_probe,
+	.remove = max9260_remove,
+	.driver = {
+		.name = "max9260",
+		.of_match_table = of_match_ptr(max9260_dt_ids),
+	},
+};
+
+module_serdev_device_driver(max9260_driver);
+
+MODULE_DESCRIPTION("Maxim MAX9260 GMSL Deserializer Driver");
+MODULE_AUTHOR("Ulrich Hecht");
+MODULE_LICENSE("GPL");
-- 
2.7.4
