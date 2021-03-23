Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED98C433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 03:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A4F619A8
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCWDX1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 23:23:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59827 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCWDXB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 23:23:01 -0400
X-Originating-IP: 68.203.5.165
Received: from [192.168.1.186] (cpe-68-203-5-165.austin.res.rr.com [68.203.5.165])
        (Authenticated sender: frank@zago.net)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A534F1C0004
        for <linux-serial@vger.kernel.org>; Tue, 23 Mar 2021 03:22:57 +0000 (UTC)
To:     linux-serial@vger.kernel.org
From:   Frank Zago <frank@zago.net>
Subject: [PATCH 1/1] [RFC] USB: serial: ch341: Add I2C support to CH341 driver
Message-ID: <4286affb-bed1-0fc1-1d07-a5cb8d475fb1@zago.net>
Date:   Mon, 22 Mar 2021 22:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Winchiphead CH341 IC is more than a UART interface. Amongst other
things, it can talk to an I2C bus.

Several people have contributed to an out of tree driver: Tse Lun
Bien, Marco Gittler and Till Harbaum.

  https://github.com/allanbian1017/i2c-ch341-usb.git

This commit integrates the I2C portions into the CH341 serial driver
and exposes the I2C device.

Tested with a CH341A, CH341B and CH341T.

Signed-off-by: Frank Zago <frank@zago.net>
---

I didn't find a way to say a USB device has several functions. I
followed what the CP210x driver did with gpio, but I think it's a
hack. The private data for the I2C part should be linked to the USB
device, not the serial port. It works here and in the cp210x driver
because there is only 1 serial port in the device. If it had 2 or more
ports, I believe bad things would happen. So is there a better way to
handle USB devices like that?

For info, the CH341A/B supports 3 different modes, each with a different
USB PID, usually selected by jumpers. All of them support I2C, but
only 2 support UART, one supports SPI and 2 support GPIOs.


 drivers/usb/serial/Kconfig |   4 +-
 drivers/usb/serial/ch341.c | 284 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 283 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index de5c01257060..3771dc5dd055 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -106,7 +106,7 @@ config USB_SERIAL_CH341
 	tristate "USB Winchiphead CH341 Single Port Serial Driver"
 	help
 	  Say Y here if you want to use a Winchiphead CH341 single port
-	  USB to serial adapter.
+	  USB to serial adapter. This driver also provide access to I2C.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ch341.
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2db917eab799..fc695b745fa5 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -4,12 +4,19 @@
  * Copyright 2007, Werner Cornelius <werner@cornelius-consult.de>
  * Copyright 2009, Boris Hajduk <boris@hajduk.org>
  *
- * ch341.c implements a serial port driver for the Winchiphead CH341.
+ * I2C code:
+ * Copyright (c) 2016 Tse Lun Bien
+ * Copyright (c) 2014 Marco Gittler
+ * Copyright (C) 2006-2007 Till Harbaum (Till@Harbaum.org)
+ *
+ * ch341.c implements a serial port driver for the Winchiphead CH341,
+ * with I2C support
  *
  * The CH341 device can be used to implement an RS232 asynchronous
  * serial port, an IEEE-1284 parallel printer port or a memory-like
  * interface. In all cases the CH341 supports an I2C interface as well.
- * This driver only supports the asynchronous serial interface.
+ * This driver only supports the asynchronous serial and I2C
+ * interfaces.
  */
 
 #include <linux/kernel.h>
@@ -19,6 +26,7 @@
 #include <linux/usb.h>
 #include <linux/usb/serial.h>
 #include <linux/serial.h>
+#include <linux/i2c.h>
 #include <asm/unaligned.h>
 
 #define DEFAULT_BAUD_RATE 9600
@@ -80,6 +88,20 @@
 #define CH341_QUIRK_LIMITED_PRESCALER	BIT(0)
 #define CH341_QUIRK_SIMULATE_BREAK	BIT(1)
 
+#define CH341_I2C_LOW_SPEED 0      /* low speed - 20kHz */
+#define CH341_I2C_STANDARD_SPEED 1 /* standard speed - 100kHz */
+#define CH341_I2C_FAST_SPEED 2     /* fast speed - 400kHz */
+#define CH341_I2C_HIGH_SPEED 3     /* high speed - 750kHz */
+
+#define CH341_REQ_I2C_STREAM 0xAA
+
+#define CH341_I2C_STM_STA 0x74
+#define CH341_I2C_STM_STO 0x75
+#define CH341_I2C_STM_OUT 0x80
+#define CH341_I2C_STM_IN 0xC0
+#define CH341_I2C_STM_SET 0x60
+#define CH341_I2C_STM_END 0x00
+
 static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1a86, 0x5512) },
 	{ USB_DEVICE(0x1a86, 0x5523) },
@@ -99,8 +121,260 @@ struct ch341_private {
 	u8 lcr;
 	unsigned long quirks;
 	unsigned long break_end;
+
+#ifdef CONFIG_I2C
+	/* I2C */
+	struct i2c_adapter adapter;
+	bool i2c_registered;
+	u8 ep_in;
+	u8 ep_out;
+	u8 in_buf[32];
+	u8 out_buf[32];
+#endif
+};
+
+#ifdef CONFIG_I2C
+static int ch341_i2c_bulk(struct usb_serial_port *port, int out_len, int in_len)
+{
+	struct usb_device *dev = port->serial->dev;
+	struct ch341_private *priv = usb_get_serial_port_data(port);
+	int retval;
+	int actual;
+
+	dev_dbg(&dev->dev, "bulk_out %d bytes, bulk_in %d bytes\n",
+		out_len, (in_len == 0) ? 0 : 32);
+
+	retval = usb_bulk_msg(dev, usb_sndbulkpipe(dev, priv->ep_out),
+			      priv->out_buf, out_len, &actual, 2000);
+	if (retval < 0)
+		return retval;
+
+	if (in_len == 0)
+		return actual;
+
+	memset(priv->in_buf, 0, sizeof(priv->in_buf));
+	retval = usb_bulk_msg(dev, usb_rcvbulkpipe(dev, priv->ep_in),
+			      priv->in_buf, 32, &actual, 2000);
+	if (retval < 0)
+		return retval;
+
+	return actual;
+}
+
+static int ch341_i2c_check_dev(struct usb_serial_port *port, u8 addr)
+{
+	struct ch341_private *priv = usb_get_serial_port_data(port);
+	int retval;
+
+	priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+	priv->out_buf[1] = CH341_I2C_STM_STA;
+	priv->out_buf[2] = CH341_I2C_STM_OUT; /* must be zero length */
+	priv->out_buf[3] = (addr << 1) | 0x1;
+	priv->out_buf[4] = CH341_I2C_STM_IN;  /* zero length here as well */
+	priv->out_buf[5] = CH341_I2C_STM_STO;
+	priv->out_buf[6] = CH341_I2C_STM_END;
+
+	retval = ch341_i2c_bulk(port, 7, 1);
+	if (retval < 0)
+		return retval;
+
+	if (priv->in_buf[0] & 0x80)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ch341_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
+			  int num)
+{
+	struct usb_serial_port *port = adapter->algo_data;
+	struct ch341_private *priv = usb_get_serial_port_data(port);
+	int retval;
+	int i;
+	int l;
+
+	dev_dbg(&port->serial->dev->dev, "master xfer %d messages\n", num);
+
+	retval = ch341_i2c_check_dev(port, msgs[0].addr);
+	if (retval < 0)
+		return retval;
+
+	if (num == 1) {
+		/* size larger than endpoint max transfer size */
+		if ((msgs[0].len + 6) > 32)
+			return -EIO;
+
+		if (msgs[0].flags & I2C_M_RD) {
+			priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+			priv->out_buf[1] = CH341_I2C_STM_STA;
+			priv->out_buf[2] = CH341_I2C_STM_OUT | 0x1;
+			priv->out_buf[3] = (msgs[0].addr << 1) | 0x1;
+
+			if (msgs[0].len) {
+				for (i = 0, l = msgs[0].len; l > 1; l--, i++)
+					priv->out_buf[i + 4] =
+						CH341_I2C_STM_IN | 1;
+				priv->out_buf[msgs[0].len + 3] =
+					CH341_I2C_STM_IN;
+			}
+
+			priv->out_buf[msgs[0].len + 4] = CH341_I2C_STM_STO;
+			priv->out_buf[msgs[0].len + 5] = CH341_I2C_STM_END;
+
+			retval = ch341_i2c_bulk(port, msgs[0].len + 6, msgs[0].len);
+			if (retval < 0)
+				return retval;
+
+			memcpy(msgs[0].buf, priv->in_buf, msgs[0].len);
+		} else {
+			priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+			priv->out_buf[1] = CH341_I2C_STM_STA;
+			priv->out_buf[2] =
+				CH341_I2C_STM_OUT | (msgs[0].len + 1);
+			priv->out_buf[3] = msgs[0].addr << 1;
+
+			memcpy(&priv->out_buf[4], msgs[0].buf, msgs[0].len);
+
+			priv->out_buf[msgs[0].len + 4] = CH341_I2C_STM_STO;
+			priv->out_buf[msgs[0].len + 5] = CH341_I2C_STM_END;
+
+			retval = ch341_i2c_bulk(port, msgs[0].len + 6, 0);
+			if (retval < 0)
+				return retval;
+		}
+	} else if (num == 2) {
+		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD)) {
+			/* size larger than endpoint max transfer size */
+			if (((msgs[0].len + 4) > 32) ||
+			    ((msgs[1].len + 6) > 32))
+				return -EIO;
+
+			/* write data phase */
+			priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+			priv->out_buf[1] = CH341_I2C_STM_STA;
+			priv->out_buf[2] =
+				CH341_I2C_STM_OUT | (msgs[0].len + 1);
+			priv->out_buf[3] = msgs[0].addr << 1;
+
+			memcpy(&priv->out_buf[4], msgs[0].buf, msgs[0].len);
+
+			retval = ch341_i2c_bulk(port, msgs[0].len + 4, 0);
+			if (retval < 0)
+				return retval;
+
+			/* read data phase */
+			priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+			priv->out_buf[1] = CH341_I2C_STM_STA;
+			priv->out_buf[2] = CH341_I2C_STM_OUT | 0x1;
+			priv->out_buf[3] = (msgs[1].addr << 1) | 0x1;
+
+			if (msgs[1].len) {
+				for (i = 0, l = msgs[1].len; l > 1; l--, i++)
+					priv->out_buf[i + 4] =
+						CH341_I2C_STM_IN | 1;
+				priv->out_buf[msgs[1].len + 3] =
+					CH341_I2C_STM_IN;
+			}
+
+			priv->out_buf[msgs[1].len + 4] = CH341_I2C_STM_STO;
+			priv->out_buf[msgs[1].len + 5] = CH341_I2C_STM_END;
+
+			retval = ch341_i2c_bulk(port, msgs[1].len + 6, msgs[1].len);
+			if (retval < 0)
+				return retval;
+
+			memcpy(msgs[1].buf, priv->in_buf, msgs[1].len);
+		} else {
+			return -EIO;
+		}
+	} else {
+		dev_err(&port->serial->dev->dev,
+			"This case(num > 2) is not supported for now\n");
+		return -EIO;
+	}
+
+	return num;
+}
+
+
+static u32 ch341_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm ch341_i2c_algorithm = {
+	.master_xfer = ch341_i2c_xfer,
+	.functionality = ch341_i2c_func,
 };
 
+static void ch341_i2c_setup(struct usb_serial_port *port)
+{
+	struct ch341_private *priv = usb_get_serial_port_data(port);
+	const struct usb_host_interface *setting =
+		port->serial->interface->cur_altsetting;
+	int retval = -ENOMEM;
+
+	priv->ep_out = setting->endpoint[1].desc.bEndpointAddress;
+	priv->ep_in = setting->endpoint[0].desc.bEndpointAddress;
+
+	/* setup i2c adapter description */
+	priv->adapter.owner = THIS_MODULE;
+	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.algo = &ch341_i2c_algorithm;
+	priv->adapter.algo_data = port;
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		 "i2c-ch341-usb at bus %03d device %03d",
+		 port->serial->dev->bus->busnum, port->serial->dev->devnum);
+
+	priv->adapter.dev.parent = &port->serial->dev->dev;
+
+	/* and finally attach to i2c layer */
+	i2c_add_adapter(&priv->adapter);
+
+	/* set ch341 i2c speed */
+	priv->out_buf[0] = CH341_REQ_I2C_STREAM;
+	priv->out_buf[1] = CH341_I2C_STM_SET | CH341_I2C_STANDARD_SPEED;
+	priv->out_buf[2] = CH341_I2C_STM_END;
+	retval = ch341_i2c_bulk(port, 3, 0);
+	if (retval < 0) {
+		dev_err(&priv->adapter.dev, "failure setting I2C speed\n");
+		goto error;
+	}
+
+	priv->i2c_registered = true;
+
+	dev_info(&priv->adapter.dev, "registered i2c device\n");
+
+	return;
+
+error:
+	i2c_del_adapter(&priv->adapter);
+}
+
+static void ch341_i2c_remove(struct usb_serial_port *port)
+{
+	struct ch341_private *priv = usb_get_serial_port_data(port);
+
+	if (priv->i2c_registered) {
+		priv->i2c_registered = false;
+		i2c_del_adapter(&priv->adapter);
+	}
+}
+
+#else
+
+static int ch341_i2c_setup(struct usb_serial *serial)
+{
+	return 0;
+}
+
+static void ch341_i2c_remove(struct usb_serial *serial)
+{
+	return 0;
+}
+
+#endif
+
 static void ch341_set_termios(struct tty_struct *tty,
 			      struct usb_serial_port *port,
 			      struct ktermios *old_termios);
@@ -414,9 +688,12 @@ static int ch341_port_probe(struct usb_serial_port *port)
 	if (r < 0)
 		goto error;
 
+	ch341_i2c_setup(port);
+
 	return 0;
 
-error:	kfree(priv);
+error:
+	kfree(priv);
 	return r;
 }
 
@@ -424,6 +701,7 @@ static void ch341_port_remove(struct usb_serial_port *port)
 {
 	struct ch341_private *priv;
 
+	ch341_i2c_remove(port);
 	priv = usb_get_serial_port_data(port);
 	kfree(priv);
 }
-- 
2.27.0

