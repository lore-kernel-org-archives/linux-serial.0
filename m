Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A4C4361B
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16EC23D57
	for <linux-serial@archiver.kernel.org>; Thu, 10 Dec 2020 18:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392975AbgLJR4A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Dec 2020 12:56:00 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:49606 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392537AbgLJRMu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Dec 2020 12:12:50 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 12:12:46 EST
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 17E10123B09;
        Thu, 10 Dec 2020 18:05:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607619935;
        bh=b1r0rYXtqUe5buc1B70ue/zyh5AX2uxBFnIFcnAs6OU=;
        h=Date:From:To:Subject:From;
        b=OcbcSrLnxbN33bXY1WFMoz1izEmSKKKQeLmXlJ7nuFUgasj5rK66M+HjrDL1c2OI/
         4P8P5xmpSTcNYJABYEbfGhPllhV64Q3uzChBzAwI1A3q5pgt7c/uc1eBM0TYH58Lav
         la6JYVH2o18WydxLyMdTEVcYjE9CSL4tvvkzWU/Z8f6y2WHZdhC7YKyWll6UM9g5D0
         F6fvuNcVmP4uB/rPUf10MyoOSBoYS5jvQ0B40bEt3BmxoWuP2Ga9kjX1VP6Ca+SgLp
         ZQThJgVEjy+PmG54QPQHzJzGDU2yyCAmDlMMNvXbnigsUGDgZYg0fzYDkP/QVclGkC
         VfqK+ufE/wsWA==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K6fa5xgqAg4y; Thu, 10 Dec 2020 18:04:52 +0100 (CET)
Received: from dincontrollerdev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 45F90123B06;
        Thu, 10 Dec 2020 18:04:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1607619891;
        bh=b1r0rYXtqUe5buc1B70ue/zyh5AX2uxBFnIFcnAs6OU=;
        h=Date:From:To:Subject:From;
        b=mZNdWGkc3md76f5itChNixB5U8EtgmYur8EDxOXDhmAOh+n5giZ1G61xlZLjXofQy
         WKx7wTXnnYyHDDDCy24RufitgeletmzRVmE2viQ8KR6nmDFq3D1Gnzf5zkkXMYMUlA
         083C8lF5dTPzxFMeYoB+JxO+hgZatsEPADKVecZFiHWnT9U2BFrIbXkJ7SsaPtyjs/
         6fzYvq3xLJk1ejWOGP1JlsYVYdrcX11GkjymCD3WYimbSQhl61iJtU3DyiJIgJ4sFn
         /nTB81ezxGd/ink700f5SATEh3Zc1OQyFh7TNHMbzBQGlP6sIWOFqqgpa5G4j1p/cT
         PIMnFpksPkf9Q==
Date:   Thu, 10 Dec 2020 17:04:46 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Serial: silabs si4455 serial driver
Message-ID: <20201210170443.GA17304@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a serial port driver for
Silicon Labs Si4455 Sub-GHz transciver.

Signed-off-by: József Horváth <info@ministro.hu>
---
 .../bindings/serial/silabs,si4455.yaml        |   53 +
 MAINTAINERS                                   |    7 +
 drivers/tty/serial/Kconfig                    |    8 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/si4455.c                   | 1235 +++++++++++++++++
 drivers/tty/serial/si4455_api.h               |   56 +
 6 files changed, 1360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
 create mode 100644 drivers/tty/serial/si4455.c
 create mode 100644 drivers/tty/serial/si4455_api.h

diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
new file mode 100644
index 000000000000..80a73a61755b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Silicon Labs Si4455 device tree bindings
+
+maintainers:
+  - József Horváth <info@ministro.hu>
+
+allOf:
+  - $ref: "/schemas/serial.yaml#"
+
+properties:
+  compatible:
+    const: silabs,si4455
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    description: maximum clock frequency on SPI port
+    maximum: 500000
+
+  shutdown-gpios:
+    description: gpio pin for SDN
+    maxItems: 1
+
+required:
+  - reg
+  - interrupts
+  - spi-max-frequency
+  - shutdown-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    &spi0 {
+      serial0: si4455@0 {
+        compatible = "silabs,si4455";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+        shutdown-gpios = <&gpio 26 1>;
+        spi-max-frequency = <300000>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70f3c16..52ce36c5b029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15952,6 +15952,13 @@ M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
 F:	drivers/staging/wfx/
 
+SILICON LABS SI4455 SERIAL DRIVER
+M:	József Horváth <info@ministro.hu>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/silabs,si4455.yaml
+F:	drivers/tty/serial/si4455.c
+F:	drivers/tty/serial/si4455_api.h
+
 SILICON MOTION SM712 FRAME BUFFER DRIVER
 M:	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
 M:	Teddy Wang <teddy.wang@siliconmotion.com>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c..560aa311cd03 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1583,6 +1583,14 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
 	  receives all kernel messages and warnings and which allows logins in
 	  single user mode).
 
+config SERIAL_SI4455
+	tristate "Si4455 support"
+	depends on SPI
+	select SERIAL_CORE
+	help
+	  This driver is for Silicon Labs's Si4455 Sub-GHz transciver.
+	  Say 'Y' here if you wish to use it as serial port.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index caf167f0c10a..2a3076b98c78 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
 obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
+obj-$(CONFIG_SERIAL_SI4455) += si4455.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/si4455.c b/drivers/tty/serial/si4455.c
new file mode 100644
index 000000000000..20ade2fe934b
--- /dev/null
+++ b/drivers/tty/serial/si4455.c
@@ -0,0 +1,1235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 József Horváth <info@ministro.hu>
+ *
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/spi/spi.h>
+#include <linux/uaccess.h>
+#include "si4455_api.h"
+
+#define PORT_SI4455						1096
+#define SI4455_NAME						"Si4455"
+#define SI4455_MAJOR						432
+#define SI4455_MINOR						567
+#define SI4455_UART_NRMAX					1
+#define SI4455_FIFO_SIZE					64
+
+#define SI4455_CMD_ID_EZCONFIG_CHECK				0x19
+#define SI4455_CMD_ID_PART_INFO					0x01
+#define SI4455_CMD_REPLY_COUNT_PART_INFO			9
+#define SI4455_CMD_ID_GET_INT_STATUS				0x20
+#define SI4455_CMD_REPLY_COUNT_GET_INT_STATUS			8
+#define SI4455_CMD_ID_FIFO_INFO					0x15
+#define SI4455_CMD_ARG_COUNT_FIFO_INFO				2
+#define SI4455_CMD_REPLY_COUNT_FIFO_INFO			2
+#define SI4455_CMD_FIFO_INFO_ARG_TX_BIT				0x01
+#define SI4455_CMD_FIFO_INFO_ARG_RX_BIT				0x02
+#define SI4455_CMD_ID_READ_CMD_BUFF				0x44
+#define SI4455_CMD_ID_READ_RX_FIFO				0x77
+#define SI4455_CMD_ID_WRITE_TX_FIFO				0x66
+#define SI4455_CMD_ID_START_RX					0x32
+#define SI4455_CMD_ARG_COUNT_START_RX				8
+#define SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX			8
+#define SI4455_CMD_START_RX_RXVALID_STATE_RX			8
+#define SI4455_CMD_START_RX_RXINVALID_STATE_RX			8
+#define SI4455_CMD_ID_START_TX					0x31
+#define SI4455_CMD_ARG_COUNT_START_TX				5
+#define SI4455_CMD_ID_CHANGE_STATE				0x34
+#define SI4455_CMD_ARG_COUNT_CHANGE_STATE			2
+#define SI4455_CMD_CHANGE_STATE_STATE_READY			3
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK		0x08
+#define SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT		0x08
+#define SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT		0x20
+#define SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT		0x10
+#define SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT			0x08
+#define SI4455_CMD_ID_GET_MODEM_STATUS				0x22
+#define SI4455_CMD_ARG_COUNT_GET_MODEM_STATUS			2
+#define SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS			8
+
+struct si4455_part_info {
+	u8 chip_rev;
+	u16 part;
+	u8 pbuild;
+	u16 id;
+	u8 customer;
+	u8 rom_id;
+	u8 bond;
+};
+
+struct si4455_int_status {
+	u8 int_pend;
+	u8 int_status;
+	u8 ph_pend;
+	u8 ph_status;
+	u8 modem_pend;
+	u8 modem_status;
+	u8 chip_pend;
+	u8 chip_status;
+};
+
+struct si4455_modem_status {
+	u8 modem_pend;
+	u8 modem_status;
+	u8 curr_rssi;
+	u8 latch_rssi;
+	u8 ant1_rssi;
+	u8 ant2_rssi;
+	u16 afc_freq_offset;
+};
+
+struct si4455_fifo_info {
+	u8 rx_fifo_count;
+	u8 tx_fifo_space;
+};
+
+struct si4455_one {
+	struct uart_port port;
+	struct work_struct tx_work;
+};
+
+struct si4455_port {
+	struct mutex mutex; /* For syncing access to device */
+	int power_count;
+	struct gpio_desc *shdn_gpio;
+	struct si4455_part_info part_info;
+	struct si4455_modem_status modem_status;
+	struct si4455_iocbuff configuration;
+	struct si4455_iocbuff patch;
+	u32 tx_channel;
+	u32 rx_channel;
+	u32 package_size;
+	bool configured;
+	bool tx_pending;
+	bool rx_pending;
+	u32 current_rssi;
+	struct si4455_one one;
+};
+
+static struct uart_driver si4455_uart = {
+	.owner			= THIS_MODULE,
+	.driver_name		= SI4455_NAME,
+#ifdef CONFIG_DEVFS_FS
+	.dev_name		= "ttySI%d",
+#else
+	.dev_name		= "ttySI",
+#endif
+	.major			= SI4455_MAJOR,
+	.minor			= SI4455_MINOR,
+	.nr			= SI4455_UART_NRMAX,
+};
+
+static int si4455_get_response(struct uart_port *port, int length, u8 *data)
+{
+	int ret;
+	u8 data_out[] = { SI4455_CMD_ID_READ_CMD_BUFF };
+	u8 *data_in = NULL;
+	struct spi_transfer xfer[2];
+	int timeout = 10000;
+
+	if (length > 0 && !data)
+		return -EINVAL;
+
+	data_in = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_in)
+		return -ENOMEM;
+
+	memset(&xfer, 0x00, sizeof(xfer));
+	xfer[0].tx_buf = data_out;
+	xfer[0].len = sizeof(data_out);
+	xfer[1].rx_buf = data_in;
+	xfer[1].len = 1 + length;
+
+	while (--timeout > 0) {
+		data_out[0] = SI4455_CMD_ID_READ_CMD_BUFF;
+		ret = spi_sync_transfer(to_spi_device(port->dev), xfer,
+					ARRAY_SIZE(xfer));
+		if (ret) {
+			dev_err(port->dev, "%s: spi_sync_transfer error(%i)", __func__, ret);
+			break;
+		}
+
+		if (data_in[0] == 0xFF) {
+			if (length > 0 && data)
+				memcpy(data, &data_in[1], length);
+
+			break;
+		}
+		usleep_range(100, 200);
+	}
+	if (timeout == 0) {
+		dev_err(port->dev, "%s:timeout==%i", __func__, timeout);
+		ret = -EIO;
+	}
+	kfree(data_in);
+	return ret;
+}
+
+static int si4455_poll_cts(struct uart_port *port)
+{
+	return si4455_get_response(port, 0, NULL);
+}
+
+static int si4455_send_command(struct uart_port *port, int length, u8 *data)
+{
+	int ret;
+
+	ret = si4455_poll_cts(port);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_poll_cts error(%i)", __func__, ret);
+		return ret;
+	}
+	ret = spi_write(to_spi_device(port->dev), data, length);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_write error(%i)", __func__, ret);
+	}
+	return ret;
+}
+
+static int si4455_send_command_get_response(struct uart_port *port,
+					    int out_length, u8 *data_out,
+					    int in_length, u8 *data_in)
+{
+	int ret;
+
+	ret = si4455_send_command(port, out_length, data_out);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command error(%i)", __func__, ret);
+		return ret;
+	}
+
+	ret = si4455_get_response(port, in_length, data_in);
+
+	return ret;
+}
+
+static int si4455_read_data(struct uart_port *port, u8 command, int poll,
+			    int length, u8 *data)
+{
+	int ret = 0;
+	u8 data_out[] = { command };
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = data_out,
+			.len = sizeof(data_out),
+		}, {
+			.rx_buf = data,
+			.len = length,
+		}
+	};
+
+	if (poll) {
+		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
+
+	ret = spi_sync_transfer(to_spi_device(port->dev),
+				xfer,
+				ARRAY_SIZE(xfer));
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_sync_transfer error(%i)", __func__, ret);
+	}
+	return ret;
+}
+
+static int si4455_write_data(struct uart_port *port, u8 command, int poll,
+			     int length, u8 *data)
+{
+	int ret = 0;
+	u8 *data_out;
+
+	if (poll) {
+		ret = si4455_poll_cts(port);
+		if (ret)
+			return ret;
+	}
+
+	data_out = kzalloc(1 + length, GFP_KERNEL);
+	if (!data_out)
+		return -ENOMEM;
+
+	data_out[0] = command;
+	memcpy(&data_out[1], data, length);
+	ret = spi_write(to_spi_device(port->dev), data_out, 1 + length);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: spi_write error(%i)", __func__, ret);
+	}
+	kfree(data_out);
+
+	return ret;
+}
+
+static void si4455_set_power(struct si4455_port *priv, int on)
+{
+	if (!priv->shdn_gpio)
+		return;
+	if (on) {
+		gpiod_direction_output(priv->shdn_gpio, 0);
+		usleep_range(4000, 5000);
+		gpiod_set_value(priv->shdn_gpio, 1);
+		usleep_range(4000, 5000);
+	} else {
+		gpiod_direction_output(priv->shdn_gpio, 0);
+	}
+}
+
+static int si4455_s_power(struct device *dev, int on)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s(on=%d)\n", __func__, on);
+	if (s->power_count == !on)
+		si4455_set_power(s, on);
+	s->power_count += on ? 1 : -1;
+	WARN_ON(s->power_count < 0);
+
+	return 0;
+}
+
+static int si4455_get_part_info(struct uart_port *port,
+				struct si4455_part_info *result)
+{
+	int ret;
+	u8 data_out[] = { SI4455_CMD_ID_PART_INFO };
+	u8 data_in[SI4455_CMD_REPLY_COUNT_PART_INFO];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error(%i)",
+			__func__, ret);
+		return ret;
+	}
+
+	result->chip_rev = data_in[0];
+	memcpy(&result->part, &data_in[1], sizeof(result->part));
+	result->pbuild = data_in[3];
+	memcpy(&result->id, &data_in[4], sizeof(result->id));
+	result->customer = data_in[6];
+	result->rom_id = data_in[7];
+	result->bond = data_in[8];
+
+	return ret;
+}
+
+static int si4455_get_int_status(struct uart_port *port, u8 ph_clear,
+				 u8 modem_clear, u8 chip_clear,
+				 struct si4455_int_status *result)
+{
+	int ret;
+	u8 data_out[] = {
+		SI4455_CMD_ID_GET_INT_STATUS,
+		ph_clear,
+		modem_clear,
+		chip_clear
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_INT_STATUS];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error(%i)",
+			__func__, ret);
+	} else {
+		result->int_pend       = data_in[0];
+		result->int_status     = data_in[1];
+		result->ph_pend        = data_in[2];
+		result->ph_status      = data_in[3];
+		result->modem_pend     = data_in[4];
+		result->modem_status   = data_in[5];
+		result->chip_pend      = data_in[6];
+		result->chip_status    = data_in[7];
+	}
+	return ret;
+}
+
+static int si4455_get_modem_status(struct uart_port *port, u8 modem_clear,
+				   struct si4455_modem_status *result)
+{
+	int ret;
+	u8 data_out[] = {
+		SI4455_CMD_ID_GET_MODEM_STATUS,
+		modem_clear,
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_GET_MODEM_STATUS];
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error(%i)",
+			__func__, ret);
+	} else {
+		result->modem_pend      = data_in[0];
+		result->modem_status    = data_in[1];
+		result->curr_rssi       = data_in[2];
+		result->latch_rssi      = data_in[3];
+		result->ant1_rssi       = data_in[4];
+		result->ant2_rssi       = data_in[5];
+		memcpy(&result->afc_freq_offset,
+		       &data_in[6], sizeof(result->afc_freq_offset));
+	}
+	return ret;
+}
+
+static int si4455_fifo_info(struct uart_port *port, u8 fifo,
+			    struct si4455_fifo_info *result)
+{
+	int ret;
+	u8 data_out[SI4455_CMD_ARG_COUNT_FIFO_INFO] = {
+		SI4455_CMD_ID_FIFO_INFO, fifo
+	};
+	u8 data_in[SI4455_CMD_REPLY_COUNT_FIFO_INFO] = { 0 };
+
+	ret = si4455_send_command_get_response(port, sizeof(data_out), data_out,
+					       sizeof(data_in), data_in);
+	if (ret) {
+		dev_err(port->dev,
+			"%s: si4455_send_command_get_response error(%i)",
+			__func__, ret);
+	} else {
+		result->rx_fifo_count  = data_in[0];
+		result->tx_fifo_space  = data_in[1];
+	}
+	return ret;
+}
+
+static int si4455_read_rx_fifo(struct uart_port *port, int length, u8 *data)
+{
+	return si4455_read_data(port, SI4455_CMD_ID_READ_RX_FIFO, 0, length,
+				data);
+}
+
+static int si4455_write_tx_fifo(struct uart_port *port, int length, u8 *data)
+{
+	return si4455_write_data(port, SI4455_CMD_ID_WRITE_TX_FIFO, 0, length,
+				 data);
+}
+
+static int si4455_rx(struct uart_port *port, u32 channel, u8 condition,
+		     u16 length, u8 next_state1, u8 next_state2,
+		     u8 next_state3)
+{
+	u8 data_out[SI4455_CMD_ARG_COUNT_START_RX];
+
+	data_out[0] = SI4455_CMD_ID_START_RX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	data_out[5] = next_state1;
+	data_out[6] = next_state2;
+	data_out[7] = next_state3;
+
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_START_RX,
+				   data_out);
+}
+
+static int si4455_tx(struct uart_port *port, u8 channel, u8 condition,
+		     u16 length)
+{
+	u8 data_out[/*6*/ SI4455_CMD_ARG_COUNT_START_TX];
+
+	data_out[0] = SI4455_CMD_ID_START_TX;
+	data_out[1] = channel;
+	data_out[2] = condition;
+	data_out[3] = (u8)(length >> 8);
+	data_out[4] = (u8)(length);
+	/*TODO: data_out[5] = 0x44; in case of rev c2a*/
+
+	return si4455_send_command(port, /*6*/ SI4455_CMD_ARG_COUNT_START_TX,
+				   data_out);
+}
+
+static int si4455_change_state(struct uart_port *port, u8 next_state1)
+{
+	u8 data_out[SI4455_CMD_ARG_COUNT_CHANGE_STATE];
+
+	data_out[0] = SI4455_CMD_ID_CHANGE_STATE;
+	data_out[1] = (u8)next_state1;
+
+	return si4455_send_command(port, SI4455_CMD_ARG_COUNT_CHANGE_STATE,
+				   data_out);
+}
+
+static int si4455_begin_tx(struct uart_port *port, u32 channel, int length,
+			   u8 *data)
+{
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+
+	dev_dbg(port->dev, "%s(%u, %u)", __func__, channel, length);
+	if (length > SI4455_FIFO_SIZE || length < 0)
+		return -EINVAL;
+
+	ret = si4455_change_state(port,
+				  SI4455_CMD_CHANGE_STATE_STATE_READY);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_change_state error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_fifo_info(port,
+			       SI4455_CMD_FIFO_INFO_ARG_TX_BIT, &fifo_info);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_fifo_info error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_write_tx_fifo(port, (u16)length, data);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_write_tx_fifo error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_tx(port, channel, 0x30, length);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_tx error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int si4455_end_tx(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+
+	ret = si4455_change_state(port,
+				  SI4455_CMD_CHANGE_STATE_STATE_READY);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_change_state error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int si4455_begin_rx(struct uart_port *port, u32 channel, u32 length)
+{
+	int ret = 0;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+
+	dev_dbg(port->dev, "%s(%u, %u)", __func__, channel, length);
+	ret = si4455_get_int_status(port, 0, 0, 0, &int_status);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_get_int_status error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_fifo_info(port,
+			       SI4455_CMD_FIFO_INFO_ARG_RX_BIT,
+			       &fifo_info);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_fifo_info error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	ret = si4455_rx(port, channel, 0x00, length,
+			SI4455_CMD_START_RX_RXTIMEOUT_STATE_RX,
+			SI4455_CMD_START_RX_RXVALID_STATE_RX,
+			SI4455_CMD_START_RX_RXINVALID_STATE_RX);
+	if (ret) {
+		dev_err(port->dev, "%s: si4455_rx error(%i)",
+			__func__, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int si4455_end_rx(struct uart_port *port, u32 length, u8 *data)
+{
+	return si4455_read_rx_fifo(port, length, data);
+}
+
+static int si4455_configure(struct uart_port *port, u8 *configuration_data)
+{
+	int ret = 0;
+	u8 col;
+	u8 response;
+	u8 count;
+	struct si4455_int_status int_status = { 0 };
+	u8 radio_cmd[16u];
+
+	/* While cycle as far as the pointer points to a command */
+	while (*configuration_data != 0x00) {
+		/* Commands structure in the array:
+		 * --------------------------------
+		 * LEN | <LEN length of data>
+		 */
+		count = *configuration_data++;
+		dev_dbg(port->dev, "%s: count(%u)",
+			__func__, count);
+		if (count > 16u) {
+			/* Initial configuration of Si4x55 */
+			if (SI4455_CMD_ID_WRITE_TX_FIFO
+				 == *configuration_data) {
+				if (count > 128u) {
+					/* Number of command bytes exceeds
+					 * maximal allowable length
+					 */
+					dev_err(port->dev, "%s: command length error(%i)",
+						__func__, count);
+					ret = -EINVAL;
+					break;
+				}
+
+				/* Load array to the device */
+				configuration_data++;
+				ret = si4455_write_data(port,
+							SI4455_CMD_ID_WRITE_TX_FIFO,
+							1,
+							count - 1,
+							configuration_data);
+				if (ret) {
+					dev_err(port->dev, "%s: si4455_write_data error(%i)",
+						__func__, ret);
+					break;
+				}
+
+				/* Point to the next command */
+				configuration_data += count - 1;
+
+				/* Continue command interpreter */
+				continue;
+			} else {
+				/* Number of command bytes exceeds
+				 * maximal allowable length
+				 */
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		for (col = 0u; col < count; col++) {
+			radio_cmd[col] = *configuration_data;
+			configuration_data++;
+		}
+
+		dev_dbg(port->dev, "%s: radio_cmd[0](%u)", __func__, radio_cmd[0]);
+		ret = si4455_send_command_get_response(port, count, radio_cmd,
+						       1, &response);
+		if (ret) {
+			dev_err(port->dev,
+				"%s: si4455_send_command_get_response error(%i)",
+				__func__, ret);
+			break;
+		}
+
+		/* Check response byte of EZCONFIG_CHECK command */
+		if (radio_cmd[0] == SI4455_CMD_ID_EZCONFIG_CHECK) {
+			if (response) {
+				/* Number of command bytes exceeds
+				 * maximal allowable length
+				 */
+				ret = -EIO;
+				dev_err(port->dev, "%s: EZConfig check error(%i)",
+					__func__, radio_cmd[0]);
+				break;
+			}
+		}
+
+		/* Get and clear all interrupts.  An error has occurred... */
+		si4455_get_int_status(port, 0, 0, 0, &int_status);
+		if (int_status.chip_pend
+		    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_MASK) {
+			ret = -EIO;
+			dev_err(port->dev, "%s: chip error(%i)",
+				__func__, int_status.chip_pend);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int si4455_re_configure(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	mutex_lock(&s->mutex);
+	s->configured = 0;
+	if (s->power_count > 0)
+		si4455_s_power(port->dev, 0);
+
+	si4455_s_power(port->dev, 1);
+	if (s->configuration.length > 0) {
+		ret = si4455_configure(port, s->configuration.data);
+		if (ret == 0)
+			s->configured = 1;
+	}
+	mutex_unlock(&s->mutex);
+	return ret;
+}
+
+static int si4455_do_work(struct uart_port *port)
+{
+	int ret = 0;
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int tx_pending = 0;
+	unsigned int tx_to_end = 0;
+	u8 *data = NULL;
+
+	mutex_lock(&s->mutex);
+	if (s->configured && s->power_count > 0) {
+		if (!(uart_circ_empty(xmit) || uart_tx_stopped(port) || s->tx_pending)) {
+			tx_pending = uart_circ_chars_pending(xmit);
+			if (s->package_size > 0) {
+				if (tx_pending >= s->package_size) {
+					tx_pending = s->package_size;
+					data = kzalloc(s->package_size, GFP_KERNEL);
+					tx_to_end = CIRC_CNT_TO_END(xmit->head,
+								    xmit->tail,
+								    UART_XMIT_SIZE);
+					if (tx_to_end < tx_pending) {
+						memcpy(data,
+						       xmit->buf + xmit->tail,
+						       tx_to_end);
+						memcpy(data,
+						       xmit->buf,
+						       tx_pending - tx_to_end);
+					} else {
+						memcpy(data,
+						       xmit->buf + xmit->tail,
+						       tx_pending);
+					}
+					if (si4455_begin_tx(port, s->tx_channel,
+							    tx_pending, data) == 0) {
+						s->tx_pending = true;
+					}
+					kfree(data);
+				}
+			} else {
+				//TODO: variable packet length
+			}
+		}
+		if (!s->tx_pending) {
+			if (s->package_size > 0) {
+				ret = si4455_begin_rx(port, s->rx_channel,
+						      s->package_size);
+			} else {
+				//TODO: variable packet length
+			}
+		}
+	}
+	mutex_unlock(&s->mutex);
+	return ret;
+}
+
+static void si4455_handle_rx_pend(struct si4455_port *s)
+{
+	struct uart_port *port = &s->one.port;
+	u8 *data = NULL;
+	int sret = 0;
+	int i = 0;
+
+	if (s->package_size > 0) {
+		data = kzalloc(s->package_size, GFP_KERNEL);
+		sret = si4455_end_rx(port, s->package_size, data);
+		if (sret == 0) {
+			for (i = 0; i < s->package_size; i++) {
+				uart_insert_char(port, 0, 0, data[i], TTY_NORMAL);
+				port->icount.rx++;
+			}
+			tty_flip_buffer_push(&port->state->port);
+		} else {
+			dev_err(port->dev,
+				"%s: si4455_end_rx error(%i)",
+				__func__,
+				sret);
+		}
+		kfree(data);
+	} else {
+		//TODO: variable packet length
+	}
+}
+
+static void si4455_handle_tx_pend(struct si4455_port *s)
+{
+	struct uart_port *port = &s->one.port;
+	struct circ_buf *xmit = &port->state->xmit;
+
+	if (s->tx_pending) {
+		if (s->package_size) {
+			port->icount.tx += s->package_size;
+			xmit->tail = (xmit->tail + s->package_size)
+					& (UART_XMIT_SIZE - 1);
+		} else {
+			//TODO: variable packet length
+		}
+		si4455_end_tx(port);
+		s->tx_pending = 0;
+	}
+}
+
+static irqreturn_t si4455_port_irq(struct si4455_port *s)
+{
+	struct uart_port *port = &s->one.port;
+	irqreturn_t ret = IRQ_NONE;
+	struct si4455_int_status int_status = { 0 };
+	struct si4455_fifo_info fifo_info = { 0 };
+
+	mutex_lock(&s->mutex);
+	if (s->configured && s->power_count > 0) {
+		if (!si4455_get_int_status(port, 0, 0, 0, &int_status)) {
+			si4455_get_modem_status(port, 0, &s->modem_status);
+			if (int_status.chip_pend
+			    & SI4455_CMD_GET_CHIP_STATUS_ERROR_PEND_BIT) {
+				dev_err(port->dev,
+					"%s: chip_status:CMD_ERROR_PEND",
+					__func__);
+			} else if (int_status.ph_pend
+				   & SI4455_CMD_GET_INT_STATUS_PACKET_SENT_PEND_BIT) {
+				dev_dbg(port->dev,
+					"%s: ph_status:PACKET_SENT_PEND",
+					__func__);
+				si4455_handle_tx_pend(s);
+			} else if (int_status.ph_pend
+				   & SI4455_CMD_GET_INT_STATUS_PACKET_RX_PEND_BIT) {
+				dev_dbg(port->dev,
+					"%s: ph_status:PACKET_RX_PEND",
+					__func__);
+				s->current_rssi = s->modem_status.curr_rssi;
+				si4455_fifo_info(port, 0, &fifo_info);
+				si4455_handle_rx_pend(s);
+			} else if (int_status.ph_pend
+				   & SI4455_CMD_GET_INT_STATUS_CRC_ERROR_BIT) {
+				dev_dbg(port->dev,
+					"%s: ph_status:CRC_ERROR_PEND",
+					__func__);
+			}
+			ret = IRQ_HANDLED;
+		}
+	} else {
+		ret = IRQ_HANDLED;
+	}
+	mutex_unlock(&s->mutex);
+	si4455_do_work(port);
+	return ret;
+}
+
+static irqreturn_t si4455_ist(int irq, void *dev_id)
+{
+	struct si4455_port *s = (struct si4455_port *)dev_id;
+	bool handled = false;
+
+	if (si4455_port_irq(s) == IRQ_HANDLED)
+		handled = true;
+
+	return IRQ_RETVAL(handled);
+}
+
+static void si4455_tx_proc(struct work_struct *ws)
+{
+	struct si4455_one *one = container_of(ws, struct si4455_one, tx_work);
+
+	si4455_do_work(&one->port);
+}
+
+static unsigned int si4455_tx_empty(struct uart_port *port)
+{
+	return TIOCSER_TEMT;
+}
+
+static unsigned int si4455_get_mctrl(struct uart_port *port)
+{
+	dev_dbg(port->dev, "%s", __func__);
+	return TIOCM_DSR | TIOCM_CAR;
+}
+
+static void si4455_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	dev_dbg(port->dev, "%s", __func__);
+}
+
+static void si4455_set_termios(struct uart_port *port, struct ktermios *termios,
+			       struct ktermios *old)
+{
+	dev_dbg(port->dev, "%s", __func__);
+	if ((termios->c_cflag & CSIZE) != CS8)
+		dev_err(port->dev, "%s: CSIZE must be CS8", __func__);
+}
+
+static int si4455_startup(struct uart_port *port)
+{
+	dev_dbg(port->dev, "%s", __func__);
+	si4455_s_power(port->dev, 1);
+	return 0;
+}
+
+static void si4455_shutdown(struct uart_port *port)
+{
+	dev_dbg(port->dev, "%s", __func__);
+	si4455_s_power(port->dev, 0);
+}
+
+static const char *si4455_type(struct uart_port *port)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+
+	if (port->type != PORT_SI4455)
+		return NULL;
+	if (s->part_info.rom_id == 3)
+		return "SI4455-B1A";
+	else if (s->part_info.rom_id == 6)
+		return "SI4455-C2A";
+
+	return "SI4455(UNKNOWN-REV)";
+}
+
+static void si4455_config_port(struct uart_port *port, int flags)
+{
+	dev_dbg(port->dev, "%s", __func__);
+	if (flags & UART_CONFIG_TYPE)
+		port->type = PORT_SI4455;
+}
+
+static int si4455_verify_port(struct uart_port *port, struct serial_struct *s)
+{
+	if (s->type != PORT_UNKNOWN && s->type != PORT_SI4455)
+		return -EINVAL;
+
+	if (s->irq != port->irq)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void si4455_start_tx(struct uart_port *port)
+{
+	struct si4455_one *one = container_of(port,
+					struct si4455_one,
+					port);
+
+	dev_dbg(port->dev, "%s", __func__);
+
+	if (!work_pending(&one->tx_work))
+		schedule_work(&one->tx_work);
+}
+
+static int si4455_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
+{
+	struct si4455_port *s = dev_get_drvdata(port->dev);
+	void __user *argp = (void *)arg;
+	int ret = 0;
+
+	dev_dbg(port->dev, "%s(%u)", __func__, cmd);
+	switch (cmd) {
+	case SI4455_IOC_SEZC:
+		if (copy_from_user(&s->configuration, argp, sizeof(s->configuration)))
+			return -EFAULT;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SEZC, length(%i)",
+			__func__, cmd, s->configuration.length);
+		ret = si4455_re_configure(port);
+	break;
+	case SI4455_IOC_CEZC:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_CEZC", __func__, cmd);
+		memset(&s->configuration, 0x00, sizeof(s->configuration));
+		ret = si4455_re_configure(port);
+	break;
+	case SI4455_IOC_SEZP:
+		if (copy_from_user(&s->patch, argp, sizeof(s->patch)))
+			return -EFAULT;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SEZP, length(%i)",
+			__func__, cmd, s->configuration.length);
+	break;
+	case SI4455_IOC_CEZP:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_CEZP",
+			__func__, cmd);
+		memset(&s->patch, 0x00, sizeof(s->patch));
+	break;
+	case SI4455_IOC_STXC:
+		if (copy_from_user(&s->tx_channel, argp, sizeof(s->tx_channel)))
+			return -EFAULT;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_STXC, tx_channel(%i)",
+			__func__, cmd, s->tx_channel);
+	break;
+	case SI4455_IOC_GTXC:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GTXC",
+			__func__, cmd);
+		if (copy_to_user(argp, &s->tx_channel, sizeof(s->tx_channel)))
+			return -EFAULT;
+	break;
+	case SI4455_IOC_SRXC:
+		if (copy_from_user(&s->rx_channel, argp, sizeof(s->rx_channel)))
+			return -EFAULT;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SRXC, rx_channel(%i)",
+			__func__, cmd, s->rx_channel);
+	break;
+	case SI4455_IOC_GRXC:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GRXC",
+			__func__, cmd);
+		if (copy_to_user(argp, &s->rx_channel, sizeof(s->rx_channel)))
+			return -EFAULT;
+	break;
+	case SI4455_IOC_SSIZ:
+		if (copy_from_user(&s->package_size, argp, sizeof(s->package_size)))
+			return -EFAULT;
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_SSIZ, package_size(%i)",
+			__func__, cmd, s->package_size);
+	break;
+	case SI4455_IOC_GSIZ:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GSIZ",
+			__func__, cmd);
+		if (copy_to_user(argp, &s->package_size, sizeof(s->package_size)))
+			return -EFAULT;
+	break;
+	case SI4455_IOC_GRSSI:
+		dev_dbg(port->dev, "%s(%u): SI4455_IOC_GRSSI",
+			__func__, cmd);
+		if (copy_to_user(argp, &s->current_rssi, sizeof(s->current_rssi)))
+			return -EFAULT;
+	break;
+	default:
+		ret = -ENOIOCTLCMD;
+	break;
+	}
+
+	if (ret == 0)
+		si4455_do_work(port);
+
+	return ret;
+}
+
+static void si4455_null_void(struct uart_port *port)
+{
+	/* Do nothing */
+}
+
+static const struct uart_ops si4455_ops = {
+	.tx_empty		= si4455_tx_empty,
+	.set_mctrl		= si4455_set_mctrl,/* required */
+	.get_mctrl		= si4455_get_mctrl,
+	.stop_tx		= si4455_null_void,
+	.start_tx		= si4455_start_tx,
+	.stop_rx		= si4455_null_void,
+	.startup		= si4455_startup,
+	.shutdown		= si4455_shutdown,
+	.set_termios		= si4455_set_termios,/* required */
+	.type			= si4455_type,
+	.release_port		= si4455_null_void,
+	.config_port		= si4455_config_port,
+	.verify_port		= si4455_verify_port,
+	.ioctl			= si4455_ioctl,
+};
+
+static int __maybe_unused si4455_suspend(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	uart_suspend_port(&si4455_uart, &s->one.port);
+	return 0;
+}
+
+static int __maybe_unused si4455_resume(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	uart_resume_port(&si4455_uart, &s->one.port);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(si4455_pm_ops, si4455_suspend, si4455_resume);
+
+static int si4455_probe(struct device *dev,
+			int irq)
+{
+	int ret;
+	struct si4455_port *s;
+
+	/* Alloc port structure */
+	dev_dbg(dev, "%s\n", __func__);
+	s = devm_kzalloc(dev, sizeof(*s), GFP_KERNEL);
+	if (!s) {
+		dev_err(dev, "Error allocating port structure\n");
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, s);
+	mutex_init(&s->mutex);
+
+	s->shdn_gpio = devm_gpiod_get(dev, "shutdown", GPIOD_OUT_HIGH);
+	if (IS_ERR(s->shdn_gpio)) {
+		dev_err(dev, "Unable to reguest shdn gpio\n");
+		ret = -EINVAL;
+		goto out_generic;
+	}
+
+	/* Initialize port data */
+	s->one.port.dev	= dev;
+	s->one.port.line = 0;
+	s->one.port.irq	= irq;
+	s->one.port.type	= PORT_SI4455;
+	s->one.port.fifosize	= SI4455_FIFO_SIZE;
+	s->one.port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
+	s->one.port.iotype	= UPIO_PORT;
+	s->one.port.iobase	= 0x00;
+	s->one.port.membase	= (void __iomem *)~0;
+	s->one.port.rs485_config = NULL;
+	s->one.port.ops	= &si4455_ops;
+
+	si4455_s_power(dev, 1);
+
+	//detect
+	ret = si4455_get_part_info(&s->one.port, &s->part_info);
+	dev_dbg(dev, "si4455_get_part_info()==%i", ret);
+	if (ret == 0) {
+		dev_dbg(dev, "partInfo.chip_rev= %u", s->part_info.chip_rev);
+		dev_dbg(dev, "partInfo.part= %u", s->part_info.part);
+		dev_dbg(dev, "partInfo.pbuild= %u", s->part_info.pbuild);
+		dev_dbg(dev, "partInfo.id= %u", s->part_info.id);
+		dev_dbg(dev, "partInfo.customer= %u", s->part_info.customer);
+		dev_dbg(dev, "partInfo.rom_id= %u", s->part_info.rom_id);
+		dev_dbg(dev, "partInfo.bond= %u", s->part_info.bond);
+		if (s->part_info.part != 0x5544) {
+			dev_err(dev, "part(%u) error", s->part_info.part);
+			ret = -ENODEV;
+		}
+	}
+	si4455_s_power(dev, 0);
+	if (ret)
+		goto out_generic;
+
+	/* Initialize queue for start TX */
+	INIT_WORK(&s->one.tx_work, si4455_tx_proc);
+
+	/* Register port */
+	ret = uart_add_one_port(&si4455_uart, &s->one.port);
+	if (ret) {
+		s->one.port.dev = NULL;
+		goto out_uart;
+	}
+
+	/* Setup interrupt */
+	ret = devm_request_threaded_irq(dev, irq, NULL, si4455_ist,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(dev), s);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+
+out_uart:
+	uart_remove_one_port(&si4455_uart, &s->one.port);
+out_generic:
+	mutex_destroy(&s->mutex);
+
+	return ret;
+}
+
+static int si4455_remove(struct device *dev)
+{
+	struct si4455_port *s = dev_get_drvdata(dev);
+
+	cancel_work_sync(&s->one.tx_work);
+	uart_remove_one_port(&si4455_uart, &s->one.port);
+
+	mutex_destroy(&s->mutex);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused si4455_dt_ids[] = {
+	{ .compatible = "silabs,si4455" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, si4455_dt_ids);
+
+static int si4455_spi_probe(struct spi_device *spi)
+{
+	int ret;
+	const struct of_device_id *of_id;
+
+	/* Setup SPI bus */
+	spi->bits_per_word	= 8;
+	spi->mode		= SPI_MODE_0;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	if (spi->dev.of_node) {
+		of_id = of_match_device(si4455_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
+	}
+
+	return si4455_probe(&spi->dev, spi->irq);
+}
+
+static int si4455_spi_remove(struct spi_device *spi)
+{
+	return si4455_remove(&spi->dev);
+}
+
+static struct spi_driver si4455_spi_driver = {
+	.driver = {
+		.name		= SI4455_NAME,
+		.of_match_table	= of_match_ptr(si4455_dt_ids),
+		.pm		= &si4455_pm_ops,
+	},
+	.probe			= si4455_spi_probe,
+	.remove			= si4455_spi_remove,
+};
+
+static int __init si4455_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&si4455_uart);
+	if (ret)
+		return ret;
+	spi_register_driver(&si4455_spi_driver);
+
+	return 0;
+}
+module_init(si4455_uart_init);
+
+static void __exit si4455_uart_exit(void)
+{
+	spi_unregister_driver(&si4455_spi_driver);
+	uart_unregister_driver(&si4455_uart);
+}
+module_exit(si4455_uart_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("József Horváth <info@ministro.hu>");
+MODULE_DESCRIPTION("Si4455 serial driver");
diff --git a/drivers/tty/serial/si4455_api.h b/drivers/tty/serial/si4455_api.h
new file mode 100644
index 000000000000..a769de9064b0
--- /dev/null
+++ b/drivers/tty/serial/si4455_api.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 József Horváth <info@ministro.hu>
+ *
+ */
+#ifndef SI4455_API_H_
+#define SI4455_API_H_
+
+struct si4455_iocbuff {
+	uint32_t length;
+	uint8_t	data[4096];
+};
+
+#define BASE_TTYIOC_PRIVATE		0xA0
+/* Set EZConfig.
+ * After this ioctl call, the driver restarts the si4455,
+ * then apply the new configuration and patch.
+ */
+#define SI4455_IOC_SEZC		_IOW('T', \
+				     BASE_TTYIOC_PRIVATE + 0x01, \
+				     struct si4455_iocbuff)
+/* Clear driver EZConfig.
+ * After this ioctl call, the driver restarts the si4455,
+ * then apply the new configuration and patch.
+ */
+#define SI4455_IOC_CEZC		_IO('T', BASE_TTYIOC_PRIVATE + 0x02)
+/* Set radio patch.
+ * After this ioctl call, the driver restarts the si4455,
+ * then apply the new configuration and patch.
+ * This ioctl code is for future use only. Not implemented yet.
+ */
+#define SI4455_IOC_SEZP		_IOW('T', \
+				     BASE_TTYIOC_PRIVATE + 0x03, \
+				     struct si4455_iocbuff)
+/* Clear radio patch.
+ * After this ioctl call, the driver restarts the si4455,
+ * then apply the new configuration and patch.
+ * This ioctl code is for future use only. Not implemented yet.
+ */
+#define SI4455_IOC_CEZP		_IO('T', BASE_TTYIOC_PRIVATE + 0x04)
+/* Get transmit channel. */
+#define SI4455_IOC_GTXC		_IOR('T', BASE_TTYIOC_PRIVATE + 0x11, uint32_t)
+/* Set transmit channel. */
+#define SI4455_IOC_STXC		_IOW('T', BASE_TTYIOC_PRIVATE + 0x12, uint32_t)
+/* Get receive channel. */
+#define SI4455_IOC_GRXC		_IOR('T', BASE_TTYIOC_PRIVATE + 0x13, uint32_t)
+/* Set receive channel. */
+#define SI4455_IOC_SRXC		_IOW('T', BASE_TTYIOC_PRIVATE + 0x14, uint32_t)
+/* Get fixed length package size. */
+#define SI4455_IOC_GSIZ		_IOR('T', BASE_TTYIOC_PRIVATE + 0x15, uint32_t)
+/* Set fixed length package size. */
+#define SI4455_IOC_SSIZ		_IOW('T', BASE_TTYIOC_PRIVATE + 0x16, uint32_t)
+/* Get last rssi value. */
+#define SI4455_IOC_GRSSI	_IOR('T', BASE_TTYIOC_PRIVATE + 0x20, uint32_t)
+
+#endif
-- 
2.17.1


