Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8CC4708D
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLGWGt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGWGs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 17:06:48 -0500
Received: from mail.someserver.de (mail2.someserver.de [31.15.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C970112D
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 14:06:46 -0800 (PST)
Received: from localhost (unknown [213.55.243.226])
        by mail.someserver.de (Postfix) with ESMTPSA id E5EDF80198;
        Wed,  7 Dec 2022 23:06:45 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH tty-next v2] hid-ft260: Add serial driver
Date:   Wed,  7 Dec 2022 23:06:17 +0100
Message-Id: <20221207220617.116082-1-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This commit adds a serial interface /dev/FTx which implements the tty
serial driver ops, so that it is possible to set the baudrate, send
and receive data, etc.

Signed-off-by: Christina Quast <contact@christina-quast.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
This patch applies after the cleanup patch series sent previously.

Changelog:
Hopefully applied all clean-ups suggested by Ilpo Järvinen.
Also considered some feedback from Greg Kroah-Hartman to Daniel Beer's
patch.

---
 drivers/hid/hid-ft260.c | 652 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 606 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 8979f85a1ac3..f494cf49bef2 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -13,6 +13,16 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/kfifo.h>
+#include <linux/tty_flip.h>
+#include <linux/minmax.h>
+#include <asm-generic/unaligned.h>
+
+#define UART_COUNT_MAX		4	/* Number of UARTs this driver can handle */
+#define FIFO_SIZE	256
+#define TTY_WAKEUP_WATERMARK	(FIFO_SIZE / 2)
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -30,6 +40,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + ((len) - 1) / 4)
+#define FT260_UART_DATA_REPORT_ID(len) (FT260_UART_REPORT_MIN + ((len) - 1) / 4)
 
 /*
  * The input report format assigns 62 bytes for the data payload, but ft260
@@ -73,7 +84,8 @@ enum {
 	FT260_UART_INTERRUPT_STATUS	= 0xB1,
 	FT260_UART_STATUS		= 0xE0,
 	FT260_UART_RI_DCD_STATUS	= 0xE1,
-	FT260_UART_REPORT		= 0xF0,
+	FT260_UART_REPORT_MIN		= 0xF0,
+	FT260_UART_REPORT_MAX		= 0xFE,
 };
 
 /* Feature Out */
@@ -124,6 +136,13 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
+/* Return values for ft260_get_interface_type func */
+enum {
+	FT260_IFACE_NONE,
+	FT260_IFACE_I2C,
+	FT260_IFACE_UART
+};
+
 #define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
@@ -218,6 +237,53 @@ struct ft260_input_report {
 	__u8 data[2];		/* data payload */
 } __packed;
 
+/* UART reports */
+struct ft260_uart_write_request_report {
+	__u8 report;		/* FT260_UART_REPORT */
+	__u8 length;		/* data payload length */
+	__u8 data[];		/* data payload */
+} __packed;
+
+struct ft260_configure_uart_request {
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_UART_CONFIG */
+	__u8 flow_ctrl;		/* 0: OFF, 1: RTS_CTS, 2: DTR_DSR */
+				/* 3: XON_XOFF, 4: No flow ctrl */
+	/* The baudrate field is unaligned: */
+	__le32 baudrate;	/* little endian, 9600 = 0x2580, 19200 = 0x4B00 */
+	__u8 data_bit;		/* 7 or 8 */
+	__u8 parity;		/* 0: no parity, 1: odd, 2: even, 3: high, 4: low */
+	__u8 stop_bit;		/* 0: one stop bit, 2: 2 stop bits */
+	__u8 breaking;		/* 0: no break */
+} __packed;
+
+/* UART interface configuration */
+enum {
+	FT260_CFG_FLOW_CTRL_OFF		= 0x00,
+	FT260_CFG_FLOW_CTRL_RTS_CTS	= 0x01,
+	FT260_CFG_FLOW_CTRL_DTR_DSR	= 0x02,
+	FT260_CFG_FLOW_CTRL_XON_XOFF	= 0x03,
+	FT260_CFG_FLOW_CTRL_NONE	= 0x04,
+
+	FT260_CFG_DATA_BITS_7		= 0x07,
+	FT260_CFG_DATA_BITS_8		= 0x08,
+
+	FT260_CFG_PAR_NO		= 0x00,
+	FT260_CFG_PAR_ODD		= 0x01,
+	FT260_CFG_PAR_EVEN		= 0x02,
+	FT260_CFG_PAR_HIGH		= 0x03,
+	FT260_CFG_PAR_LOW		= 0x04,
+
+	FT260_CFG_STOP_ONE_BIT		= 0x00,
+	FT260_CFG_STOP_TWO_BIT		= 0x02,
+
+	FT260_CFG_BREAKING_NO		= 0x00,
+	FT260_CFG_BEAKING_YES		= 0x01,
+
+	FT260_CFG_BAUD_MIN		= 1200,
+	FT260_CFG_BAUD_MAX		= 12000000,
+};
+
 static const struct hid_device_id ft260_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_FUTURE_TECHNOLOGY,
 			 USB_DEVICE_ID_FT260) },
@@ -228,6 +294,14 @@ MODULE_DEVICE_TABLE(hid, ft260_devices);
 struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
+
+	int ft260_is_serial;
+	struct tty_port port;
+	unsigned int index;
+	struct kfifo xmit_fifo;
+	spinlock_t write_lock;
+	struct uart_icount icount;
+
 	struct completion wait;
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
@@ -735,7 +809,7 @@ static int ft260_get_system_config(struct hid_device *hdev,
 	return 0;
 }
 
-static int ft260_is_interface_enabled(struct hid_device *hdev)
+static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device *dev)
 {
 	struct ft260_get_system_status_report cfg;
 	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
@@ -755,18 +829,22 @@ static int ft260_is_interface_enabled(struct hid_device *hdev)
 	switch (cfg.chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
-		if (interface == 1)
-			hid_info(hdev, "uart interface is not supported\n");
-		else
-			ret = 1;
+		if (interface == 1) {
+			ret = FT260_IFACE_UART;
+			dev->ft260_is_serial = 1;
+		} else {
+			ret = FT260_IFACE_I2C;
+		}
 		break;
 	case FT260_MODE_UART:
-		hid_info(hdev, "uart interface is not supported\n");
+		ret = FT260_IFACE_UART;
+		dev->ft260_is_serial = 1;
 		break;
 	case FT260_MODE_I2C:
-		ret = 1;
+		ret = FT260_IFACE_I2C;
 		break;
 	}
+
 	return ret;
 }
 
@@ -910,6 +988,447 @@ static const struct attribute_group ft260_attr_group = {
 	}
 };
 
+/***
+ * START Serial dev part
+ */
+static struct ft260_device *ft260_uart_table[UART_COUNT_MAX];
+static DEFINE_SPINLOCK(ft260_uart_table_lock);
+
+static int ft260_uart_add_port(struct ft260_device *port)
+{
+	int index, ret = -EBUSY;
+
+	spin_lock_init(&port->write_lock);
+	if (kfifo_alloc(&port->xmit_fifo, FIFO_SIZE, GFP_KERNEL))
+		return -ENOMEM;
+
+	spin_lock(&ft260_uart_table_lock);
+	for (index = 0; index < UART_COUNT_MAX; index++) {
+		if (!ft260_uart_table[index]) {
+			port->index = index;
+			ft260_uart_table[index] = port;
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&ft260_uart_table_lock);
+
+	return ret;
+}
+
+static void ft260_uart_port_remove(struct ft260_device *port)
+{
+	spin_lock(&ft260_uart_table_lock);
+	ft260_uart_table[port->index] = NULL;
+	spin_unlock(&ft260_uart_table_lock);
+
+	mutex_lock(&port->port.mutex);
+	/* tty_hangup is async so is this safe as is ?? */
+	tty_port_tty_hangup(&port->port, false);
+	mutex_unlock(&port->port.mutex);
+
+	kfifo_free(&port->xmit_fifo);
+}
+
+static struct ft260_device *ft260_uart_port_get(unsigned int index)
+{
+	struct ft260_device *port;
+
+	if (index >= UART_COUNT_MAX)
+		return NULL;
+
+	spin_lock(&ft260_uart_table_lock);
+	port = ft260_uart_table[index];
+	if (port)
+		tty_port_get(&port->port);
+	spin_unlock(&ft260_uart_table_lock);
+
+	return port;
+}
+
+static void ft260_uart_port_put(struct ft260_device *port)
+{
+	tty_port_put(&port->port);
+}
+
+static int ft260_uart_open(struct tty_struct *tty, struct file *filp)
+{
+	int ret;
+	struct ft260_device *port = tty->driver_data;
+
+	ret = tty_port_open(&port->port, tty, filp);
+
+	return ret;
+}
+
+static void ft260_uart_close(struct tty_struct *tty, struct file *filp)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty_port_close(&port->port, tty, filp);
+}
+
+static void ft260_uart_hangup(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty_port_hangup(&port->port);
+}
+
+static int ft260_uart_transmit_chars(struct ft260_device *port)
+{
+	struct hid_device *hdev = port->hdev;
+	struct kfifo *xmit = &port->xmit_fifo;
+	struct tty_struct *tty;
+	struct ft260_uart_write_request_report *rep;
+	int len, data_len, ret = 0;
+
+	tty = tty_port_tty_get(&port->port);
+
+	data_len = kfifo_len(xmit);
+	if (!tty || !data_len) {
+		ret = -EINVAL;
+		goto tty_out;
+	}
+
+	rep = (struct ft260_uart_write_request_report *)port->write_buf;
+
+	do {
+		len = min(data_len, FT260_WR_DATA_MAX);
+
+		rep->report = FT260_UART_DATA_REPORT_ID(len);
+		rep->length = len;
+
+		len = kfifo_out_locked(xmit, rep->data, len, &port->write_lock);
+
+		ret = ft260_hid_output_report(hdev, (u8 *)rep, len + sizeof(*rep));
+		if (ret < 0) {
+			hid_err(hdev, "Failed to start transfer, ret %d\n", ret);
+			goto tty_out;
+		}
+
+		data_len -= len;
+		port->icount.tx += len;
+	} while (data_len > 0);
+
+	len = kfifo_len(xmit);
+	if ((FIFO_SIZE - len) > TTY_WAKEUP_WATERMARK)
+		tty_wakeup(tty);
+
+	ret = 0;
+
+tty_out:
+	tty_kref_put(tty);
+	return ret;
+}
+
+static int ft260_uart_receive_chars(struct ft260_device *port,
+				    u8 *data, u8 length)
+{
+	struct hid_device *hdev = port->hdev;
+	int ret = 0;
+
+	if (length > FT260_RD_DATA_MAX) {
+		hid_err(hdev, "Received too much data (%d)\n", length);
+		return -EBADR;
+	}
+
+	ret = tty_insert_flip_string(&port->port, data, length);
+	if (ret != length)
+		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
+	port->icount.rx += ret;
+
+	if (ret)
+		tty_flip_buffer_push(&port->port);
+	return ret;
+}
+
+static int ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
+			    int count)
+{
+	struct ft260_device *port = tty->driver_data;
+	struct hid_device *hdev = port->hdev;
+	int ret;
+
+	ret = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
+	if (ft260_uart_transmit_chars(port) != kfifo_len(&port->xmit_fifo))
+		hid_err(hdev, "Failed sending all kfifo data bytes\n");
+
+	return ret;
+}
+
+static unsigned int ft260_uart_write_room(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	return FIFO_SIZE - kfifo_len(&port->xmit_fifo);
+}
+
+static unsigned int ft260_uart_chars_in_buffer(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	return kfifo_len(&port->xmit_fifo);
+}
+
+static int ft260_uart_change_speed(struct ft260_device *port,
+				   struct ktermios *termios,
+				    struct ktermios *old)
+{
+	struct hid_device *hdev = port->hdev;
+	unsigned int baud;
+	struct ft260_configure_uart_request req;
+	int ret;
+	struct tty_struct *tty = tty_port_tty_get(&port->port);
+
+	memset(&req, 0, sizeof(req));
+
+	req.report = FT260_SYSTEM_SETTINGS;
+	req.request = FT260_SET_UART_CONFIG;
+
+	switch (termios->c_cflag & CSIZE) {
+	case CS7:
+		req.data_bit	= FT260_CFG_DATA_BITS_7;
+		break;
+	case CS5:
+	case CS6:
+		hid_err(hdev, "Invalid data bit size, setting to default (8 bit)\n");
+		req.data_bit		= FT260_CFG_DATA_BITS_8;
+		termios->c_cflag	= CS8;
+		break;
+	default:
+	case CS8:
+		req.data_bit	= FT260_CFG_DATA_BITS_8;
+		break;
+	}
+
+	req.stop_bit = (termios->c_cflag & CSTOPB) ?
+		FT260_CFG_STOP_TWO_BIT : FT260_CFG_STOP_ONE_BIT;
+
+	if (termios->c_cflag & PARENB) {
+		req.parity = (termios->c_cflag & PARODD) ?
+			FT260_CFG_PAR_ODD : FT260_CFG_PAR_EVEN;
+	} else {
+		req.parity = FT260_CFG_PAR_NO;
+	}
+
+	baud = tty_termios_baud_rate(termios);
+	if (baud == 0 || baud < FT260_CFG_BAUD_MIN || baud > FT260_CFG_BAUD_MAX) {
+		hid_err(hdev, "Invalid baud rate %d\n", baud);
+		baud = 9600;
+		tty_encode_baud_rate(tty, baud, baud);
+	}
+	put_unaligned_le32(cpu_to_le32(baud), &req.baudrate);
+
+	if (termios->c_cflag & CRTSCTS)
+		req.flow_ctrl = FT260_CFG_FLOW_CTRL_RTS_CTS;
+	else
+		req.flow_ctrl = FT260_CFG_FLOW_CTRL_OFF;
+
+	ft260_dbg("Configured termios: flow control: %d, baudrate: %d, ",
+		  req.flow_ctrl, baud);
+	ft260_dbg("data_bit: %d, parity: %d, stop_bit: %d, breaking: %d\n",
+		  req.data_bit, req.parity,
+		  req.stop_bit, req.breaking);
+
+	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
+	req.breaking	= FT260_CFG_BREAKING_NO;
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
+	if (ret < 0) {
+		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void ft260_uart_set_termios(struct tty_struct *tty,
+				   const struct ktermios *old_termios)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	ft260_uart_change_speed(port, &tty->termios, NULL);
+}
+
+static int ft260_uart_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	int idx = tty->index;
+	struct ft260_device *port = ft260_uart_port_get(idx);
+	int ret = tty_standard_install(driver, tty);
+
+	if (ret == 0)
+		/* This is the ref ft260_uart_port get provided */
+		tty->driver_data = port;
+	else
+		ft260_uart_port_put(port);
+
+	return ret;
+}
+
+static void ft260_uart_cleanup(struct tty_struct *tty)
+{
+	struct ft260_device *port = tty->driver_data;
+
+	tty->driver_data = NULL;	/* Bug trap */
+	ft260_uart_port_put(port);
+}
+
+static int ft260_uart_proc_show(struct seq_file *m, void *v)
+{
+	return -EINVAL;
+}
+
+static const struct tty_operations ft260_uart_ops = {
+	.open			= ft260_uart_open,
+	.close			= ft260_uart_close,
+	.write			= ft260_uart_write,
+	.write_room		= ft260_uart_write_room,
+	.chars_in_buffer	= ft260_uart_chars_in_buffer,
+	.set_termios		= ft260_uart_set_termios,
+	.hangup			= ft260_uart_hangup,
+	.install		= ft260_uart_install,
+	.cleanup		= ft260_uart_cleanup,
+	.proc_show		= ft260_uart_proc_show,
+};
+
+static void uart_dtr_rts(struct tty_port *tport, int onoff)
+{
+}
+
+static int uart_carrier_raised(struct tty_port *tport)
+{
+	return -EINVAL;
+}
+
+static void ft260_uart_shutdown(struct tty_port *tport)
+{
+}
+
+static int ft260_uart_activate(struct tty_port *tport, struct tty_struct *tty)
+{
+	struct ft260_device *port =
+		container_of(tport, struct ft260_device, port);
+
+	/*
+	 * Set the TTY IO error marker - we will only clear this
+	 * once we have successfully opened the port.
+	 */
+	set_bit(TTY_IO_ERROR, &tty->flags);
+
+	kfifo_reset(&port->xmit_fifo);
+
+	ft260_uart_change_speed(port, &tty->termios, NULL);
+
+	clear_bit(TTY_IO_ERROR, &tty->flags);
+
+	return 0;
+}
+
+static void ft260_uart_port_destroy(struct tty_port *tport)
+{
+}
+
+static const struct tty_port_operations ft260_uart_port_ops = {
+	.dtr_rts = uart_dtr_rts,
+	.carrier_raised = uart_carrier_raised,
+	.shutdown = ft260_uart_shutdown,
+	.activate = ft260_uart_activate,
+	.destruct = ft260_uart_port_destroy,
+};
+
+static struct tty_driver *ft260_tty_driver;
+/***
+ * END Serial dev part
+ */
+
+static int ft260_i2c_probe(struct hid_device *hdev, struct ft260_device *dev)
+{
+	int ret;
+
+	dev->hdev = hdev;
+	dev->adap.owner = THIS_MODULE;
+	dev->adap.class = I2C_CLASS_HWMON;
+	dev->adap.algo = &ft260_i2c_algo;
+	dev->adap.quirks = &ft260_i2c_quirks;
+	dev->adap.dev.parent = &hdev->dev;
+	snprintf(dev->adap.name, sizeof(dev->adap.name),
+		 "FT260 usb-i2c bridge on hidraw%d",
+		 ((struct hidraw *)hdev->hidraw)->minor);
+
+	ret = ft260_xfer_status(dev);
+	if (ret)
+		ft260_i2c_reset(hdev);
+
+	i2c_set_adapdata(&dev->adap, dev);
+	ret = i2c_add_adapter(&dev->adap);
+	if (ret) {
+		hid_err(hdev, "failed to add i2c adapter\n");
+		return ret;
+	}
+
+	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
+	if (ret < 0) {
+		hid_err(hdev, "failed to create sysfs attrs\n");
+		goto err_i2c_free;
+	}
+err_i2c_free:
+	i2c_del_adapter(&dev->adap);
+	return ret;
+}
+
+static int ft260_uart_probe(struct hid_device *hdev, struct ft260_device *dev)
+{
+	struct ft260_configure_uart_request req;
+	int ret;
+	struct device *devt;
+
+	tty_port_init(&dev->port);
+	dev->port.ops = &ft260_uart_port_ops;
+
+	ret = ft260_uart_add_port(dev);
+	if (ret) {
+		hid_err(hdev, "failed to add port\n");
+		return ret;
+	}
+	hid_info(hdev, "tty driver: %px, ports: %px, hdev->dev: %px\n",
+		ft260_tty_driver, ft260_tty_driver ?
+		ft260_tty_driver->ports : NULL,
+		&hdev->dev);
+	devt = tty_port_register_device_attr(&dev->port,
+					     ft260_tty_driver,
+					     dev->index, &hdev->dev,
+					     dev, NULL);
+	if (IS_ERR(devt)) {
+		hid_err(hdev, "failed to register tty port\n");
+		ret = PTR_ERR(devt);
+		goto err_register_tty;
+	}
+
+	/* Send Feature Report to Configure FT260 as UART 9600-8-N-1 */
+	req.report	= FT260_SYSTEM_SETTINGS;
+	req.request	= FT260_SET_UART_CONFIG;
+	req.flow_ctrl	= FT260_CFG_FLOW_CTRL_NONE;
+	put_unaligned_le32(cpu_to_le32(9600), &req.baudrate);
+	req.data_bit	= FT260_CFG_DATA_BITS_8;
+	req.parity	= FT260_CFG_PAR_NO;
+	req.stop_bit	= FT260_CFG_STOP_ONE_BIT;
+	req.breaking	= FT260_CFG_BREAKING_NO;
+
+	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
+	if (ret < 0) {
+		hid_err(hdev, "ft260_hid_feature_report_set failed: %d\n", ret);
+		goto err_hid_report;
+	}
+	return 0;
+
+err_hid_report:
+	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
+err_register_tty:
+	ft260_uart_port_remove(dev);
+	return ret;
+}
+
 static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
@@ -952,45 +1471,28 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 version.chip_code[0], version.chip_code[1],
 		 version.chip_code[2], version.chip_code[3]);
 
-	ret = ft260_is_interface_enabled(hdev);
-	if (ret <= 0)
+	ret = ft260_get_interface_type(hdev, dev);
+	if (ret <= FT260_IFACE_NONE) {
 		goto err_hid_close;
+	}
 
 	hid_set_drvdata(hdev, dev);
 	dev->hdev = hdev;
-	dev->adap.owner = THIS_MODULE;
-	dev->adap.class = I2C_CLASS_HWMON;
-	dev->adap.algo = &ft260_i2c_algo;
-	dev->adap.quirks = &ft260_i2c_quirks;
-	dev->adap.dev.parent = &hdev->dev;
-	snprintf(dev->adap.name, sizeof(dev->adap.name),
-		 "FT260 usb-i2c bridge on hidraw%d",
-		 ((struct hidraw *)hdev->hidraw)->minor);
-
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
 
-	ret = ft260_xfer_status(dev);
-	if (ret)
-		ft260_i2c_reset(hdev);
-
-	i2c_set_adapdata(&dev->adap, dev);
-	ret = i2c_add_adapter(&dev->adap);
-	if (ret) {
-		hid_err(hdev, "failed to add i2c adapter\n");
-		goto err_hid_close;
-	}
-
-	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
-	if (ret < 0) {
-		hid_err(hdev, "failed to create sysfs attrs\n");
-		goto err_i2c_free;
+	if (!dev->ft260_is_serial) {
+		ret = ft260_i2c_probe(hdev, dev);
+		if (ret)
+			goto err_hid_close;
+	} else {
+		ret = ft260_uart_probe(hdev, dev);
+		if (ret)
+			goto err_hid_close;
 	}
 
 	return 0;
 
-err_i2c_free:
-	i2c_del_adapter(&dev->adap);
 err_hid_close:
 	hid_hw_close(hdev);
 err_hid_stop:
@@ -1005,8 +1507,13 @@ static void ft260_remove(struct hid_device *hdev)
 	if (!dev)
 		return;
 
-	sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
-	i2c_del_adapter(&dev->adap);
+	if (dev->ft260_is_serial) {
+		tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
+		ft260_uart_port_remove(dev);
+	} else {
+		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
+		i2c_del_adapter(&dev->adap);
+	}
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
@@ -1017,24 +1524,27 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_input_report *xfer = (void *)data;
+	int ret = 1;
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
-
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
 
 		if (dev->read_idx == dev->read_len)
 			complete(&dev->wait);
-
+	} else if (xfer->length > FT260_RD_DATA_MAX) {
+		hid_err(hdev, "Received data too long (%d)\n", xfer->length);
+		return -EBADR;
+	} else if (xfer->report >= FT260_UART_REPORT_MIN &&
+		   xfer->report <= FT260_UART_REPORT_MAX) {
+		ret = ft260_uart_receive_chars(dev, xfer->data, xfer->length);
 	} else {
 		hid_err(hdev, "unknown report: %#02x\n", xfer->report);
 		return 0;
 	}
-	return 1;
+	return ret;
 }
 
 static struct hid_driver ft260_driver = {
@@ -1045,7 +1555,57 @@ static struct hid_driver ft260_driver = {
 	.raw_event	= ft260_raw_event,
 };
 
-module_hid_driver(ft260_driver);
-MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge");
+static int __init ft260_driver_init(void)
+{
+	int ret;
+
+	ft260_tty_driver = tty_alloc_driver(UART_COUNT_MAX,
+					    TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	ft260_tty_driver->driver_name = "ft260_ser";
+	ft260_tty_driver->name = "ttyFT";
+	ft260_tty_driver->major = 0;
+	ft260_tty_driver->minor_start = 0;
+	ft260_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	ft260_tty_driver->subtype = SERIAL_TYPE_NORMAL;
+	ft260_tty_driver->init_termios = tty_std_termios;
+	ft260_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	ft260_tty_driver->init_termios.c_ispeed = 9600;
+	ft260_tty_driver->init_termios.c_ospeed = 9600;
+	tty_set_operations(ft260_tty_driver, &ft260_uart_ops);
+
+	ret = tty_register_driver(ft260_tty_driver);
+	if (ret) {
+		pr_err("tty_register_driver failed: %d\n", ret);
+		goto err_reg_driver;
+	}
+
+	ret = hid_register_driver(&(ft260_driver));
+	if (ret) {
+		pr_err("hid_register_driver failed: %d\n", ret);
+		goto err_reg_hid;
+	}
+
+	return 0;
+
+err_reg_hid:
+	tty_unregister_driver(ft260_tty_driver);
+err_reg_driver:
+	tty_driver_kref_put(ft260_tty_driver);
+
+	return ret;
+}
+
+static void __exit ft260_driver_exit(void)
+{
+	hid_unregister_driver(&(ft260_driver));
+	tty_unregister_driver(ft260_tty_driver);
+	tty_driver_kref_put(ft260_tty_driver);
+}
+
+module_init(ft260_driver_init);
+module_exit(ft260_driver_exit);
+
+MODULE_DESCRIPTION("FTDI FT260 USB HID to I2C host bridge and TTY driver");
 MODULE_AUTHOR("Michael Zaidman <michael.zaidman@gmail.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.35.1

