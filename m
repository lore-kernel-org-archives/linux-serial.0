Received: from mx15lb.world4you.com (mx15lb.world4you.com [81.19.149.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92332E147
	for <linux-serial@vger.kernel.org>; Fri, 17 Oct 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712150; cv=none; b=m0yNBKOsz/ediNDZoHgQr07xzIWZpvasFy0zj6BTTemHjY5AzIo73tzWjzv/d2c0YY1rmwZcHLgePdE025GzMb/0o3VHf3z3RIPEE/QEHc0HKQ8NmTtRSRttKSh8at6LiwI/YiVJE/opO/vBkPJ4aSJlW9/9TtLI0LkL8pn9VHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712150; c=relaxed/simple;
	bh=P7/qrpyRqah5nzNa7lNoZSIDcV00nBKsaLXs08kLe6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SgInsAPoRPVlawM73pzZwS291+EM7pO7ydjd2C/hJXUHGN7gGPl76CjP6VGmAk5aPG/ASjpGjBwr/EhmnKs0017XFYEK61+pIHDkht0ubETkcxSuO5D85uce6wXcUFq9O1sSHFTH5v1aTt9+a0Z7DNswzRbc+jjPEmfbSTln4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=I7Xc5vpL; arc=none smtp.client-ip=81.19.149.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="I7Xc5vpL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s8SSZrAVvO5Vf5WDwakeU7gMADycezhfoAdfXGVfR7o=; b=I7Xc5vpLiCwtSf5Soe74M0yKiJ
	t7fvDLvd7PiEQjMK6DD2wt4qnmYDaav8ddMBmzqBtfiAZnc1IsDQI3XJ4QI14EsB1NBo+QrSz8Dz1
	dpmF/gXq7Pb8A0ecK6/Oh0tpwzMl6SCJ/qP6/UYJzJQKcw7VWdoUzfkRpe8RzpiVKb1s=;
Received: from 93-82-65-102.adsl.highway.telekom.at ([93.82.65.102] helo=hornet.engleder.at)
	by mx15lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1v9lex-000000000dl-0BdA;
	Fri, 17 Oct 2025 16:42:24 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>,
	Daniel Gierlinger <gida@keba.com>
Subject: [PATCH v2 2/2] serial: 8250: add driver for KEBA UART
Date: Fri, 17 Oct 2025 16:42:09 +0200
Message-Id: <20251017144209.2662-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251017144209.2662-1-gerhard@engleder-embedded.com>
References: <20251017144209.2662-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

The KEBA UART is found in the system FPGA of KEBA PLC devices. It is
mostly 8250 compatible with extension for some UART modes.

3 different variants exist. The simpliest variant supports only RS-232
and is used for debug interfaces. The next variant supports only RS-485
and is used mostly for communication with KEBA panel devices. The third
variant is able to support RS-232, RS-485 and RS-422. For this variant
not only the mode of the UART is configured, also the physics and
transceivers are switched according to the mode.

Signed-off-by: Gerhard Engleder <eg@keba.com>
Tested-by: Daniel Gierlinger <gida@keba.com>
---
 drivers/tty/serial/8250/8250_keba.c | 281 ++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  13 ++
 drivers/tty/serial/8250/Makefile    |   1 +
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c

diff --git a/drivers/tty/serial/8250/8250_keba.c b/drivers/tty/serial/8250/8250_keba.c
new file mode 100644
index 000000000000..b923556139ee
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_keba.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 KEBA Industrial Automation GmbH
+ *
+ * Driver for KEBA UART FPGA IP core
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/misc/keba.h>
+
+#include "8250.h"
+
+#define KUART "kuart"
+
+/* flags */
+#define KUART_RS485		BIT(0)
+#define KUART_USE_CAPABILITY	BIT(1)
+
+/* registers */
+#define KUART_VERSION		0x0000
+#define KUART_REVISION		0x0001
+#define KUART_CAPABILITY	0x0002
+#define KUART_CONTROL		0x0004
+#define KUART_BASE		0x000C
+#define KUART_REGSHIFT		2
+#define KUART_CLK		1843200
+
+/* mode flags */
+enum kuart_mode {
+	KUART_MODE_NONE = 0,
+	KUART_MODE_RS485,
+	KUART_MODE_RS422,
+	KUART_MODE_RS232
+};
+
+/* capability flags */
+#define KUART_CAPABILITY_NONE	BIT(KUART_MODE_NONE)
+#define KUART_CAPABILITY_RS485	BIT(KUART_MODE_RS485)
+#define KUART_CAPABILITY_RS422	BIT(KUART_MODE_RS422)
+#define KUART_CAPABILITY_RS232	BIT(KUART_MODE_RS232)
+#define KUART_CAPABILITY_MASK	GENMASK(3, 0)
+
+/* Additional Control Register DTR line configuration */
+#define UART_ACR_DTRLC_MASK		0x18
+#define UART_ACR_DTRLC_COMPAT		0x00
+#define UART_ACR_DTRLC_ENABLE_LOW	0x10
+
+struct kuart {
+	struct keba_uart_auxdev *auxdev;
+	void __iomem *base;
+	unsigned int line;
+
+	unsigned int flags;
+	u8 capability;
+	enum kuart_mode mode;
+};
+
+static void kuart_set_phy_mode(struct kuart *kuart, enum kuart_mode mode)
+{
+	iowrite8(mode, kuart->base + KUART_CONTROL);
+}
+
+static void kuart_enhanced_mode(struct uart_8250_port *up, bool enable)
+{
+	u8 lcr, efr;
+
+	/* backup LCR register */
+	lcr = serial_in(up, UART_LCR);
+
+	/* enable 650 compatible register set (EFR, ...) */
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	/* enable/disable enhanced mode with indexed control registers */
+	efr = serial_in(up, UART_EFR);
+	if (enable)
+		efr |= UART_EFR_ECB;
+	else
+		efr &= ~UART_EFR_ECB;
+	serial_out(up, UART_EFR, efr);
+
+	/* disable 650 compatible register set, restore LCR */
+	serial_out(up, UART_LCR, lcr);
+}
+
+static void kuart_dtr_line_config(struct uart_8250_port *up, u8 dtrlc)
+{
+	u8 acr;
+
+	/* set index register to 0 to access ACR register */
+	serial_out(up, UART_SCR, UART_ACR);
+
+	/* set value register to 0x10 writing DTR mode (1,0) */
+	acr = serial_in(up, UART_LSR);
+	acr &= ~UART_ACR_DTRLC_MASK;
+	acr |= dtrlc;
+	serial_out(up, UART_LSR, acr);
+}
+
+static int kuart_rs485_config(struct uart_port *port, struct ktermios *termios,
+			      struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct kuart *kuart = port->private_data;
+	enum kuart_mode mode;
+	u8 dtrlc;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = KUART_MODE_RS422;
+		else
+			mode = KUART_MODE_RS485;
+	} else {
+		mode = KUART_MODE_RS232;
+	}
+
+	if (mode == kuart->mode)
+		return 0;
+
+	if (kuart->flags & KUART_USE_CAPABILITY) {
+		/* deactivate physical interface, break before make */
+		kuart_set_phy_mode(kuart, KUART_MODE_NONE);
+	}
+
+	if (mode == KUART_MODE_RS485) {
+		/*
+		 * Set DTR line configuration of 95x UART to DTR mode (1,0).
+		 * In this mode the DTR pin drives the active-low enable pin of
+		 * an external RS485 buffer. The DTR pin will be forced low
+		 * whenever the transmitter is not empty, otherwise DTR pin is
+		 * high.
+		 */
+		dtrlc = UART_ACR_DTRLC_ENABLE_LOW;
+	} else {
+		/*
+		 * Set DTR line configuration of 95x UART to DTR mode (0,0).
+		 * In this mode the DTR pin is compatible with 16C450, 16C550,
+		 * 16C650 and 16c670 (i.e. normal).
+		 */
+		dtrlc = UART_ACR_DTRLC_COMPAT;
+	}
+
+	kuart_enhanced_mode(up, true);
+	kuart_dtr_line_config(up, dtrlc);
+	kuart_enhanced_mode(up, false);
+
+	if (kuart->flags & KUART_USE_CAPABILITY) {
+		/* activate selected physical interface */
+		kuart_set_phy_mode(kuart, mode);
+	}
+
+	kuart->mode = mode;
+
+	return 0;
+}
+
+static int kuart_probe(struct auxiliary_device *auxdev,
+		       const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct uart_8250_port uart = {};
+	struct resource res;
+	struct kuart *kuart;
+	int retval;
+
+	kuart = devm_kzalloc(dev, sizeof(*kuart), GFP_KERNEL);
+	if (!kuart)
+		return -ENOMEM;
+	kuart->auxdev = container_of(auxdev, struct keba_uart_auxdev, auxdev);
+	kuart->flags = id->driver_data;
+	auxiliary_set_drvdata(auxdev, kuart);
+
+	/*
+	 * map only memory in front of UART registers, UART registers will be
+	 * mapped by serial port
+	 */
+	res = kuart->auxdev->io;
+	res.end = res.start + KUART_BASE - 1;
+	kuart->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(kuart->base))
+		return PTR_ERR(kuart->base);
+
+	if (kuart->flags & KUART_USE_CAPABILITY) {
+		/*
+		 * supported modes are read from capability register, at least
+		 * one mode other than none must be supported
+		 */
+		kuart->capability = ioread8(kuart->base + KUART_CAPABILITY) &
+				    KUART_CAPABILITY_MASK;
+		if ((kuart->capability & ~KUART_CAPABILITY_NONE) == 0)
+			return -EIO;
+	}
+
+	spin_lock_init(&uart.port.lock);
+	uart.port.dev = dev;
+	uart.port.mapbase = kuart->auxdev->io.start + KUART_BASE;
+	uart.port.irq = kuart->auxdev->irq;
+	uart.port.uartclk = KUART_CLK;
+	uart.port.private_data = kuart;
+
+	/* 8 bit registers are 32 bit aligned => shift register offset */
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = KUART_REGSHIFT;
+
+	/*
+	 * UART mixes 16550, 16750 and 16C950 (for RS485) standard => auto
+	 * configuration works best
+	 */
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_IOREMAP;
+
+	/*
+	 * UART supports RS485, RS422 and RS232 with switching of physical
+	 * interface
+	 */
+	uart.port.rs485_config = kuart_rs485_config;
+	if (kuart->flags & KUART_RS485) {
+		uart.port.rs485_supported.flags = SER_RS485_ENABLED |
+						  SER_RS485_RTS_ON_SEND;
+		uart.port.rs485.flags = SER_RS485_ENABLED |
+					SER_RS485_RTS_ON_SEND;
+	}
+	if (kuart->flags & KUART_USE_CAPABILITY) {
+		/* default mode priority is RS485 > RS422 > RS232 */
+		if (kuart->capability & KUART_CAPABILITY_RS422) {
+			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
+							   SER_RS485_RTS_ON_SEND |
+							   SER_RS485_MODE_RS422;
+			uart.port.rs485.flags = SER_RS485_ENABLED |
+						SER_RS485_RTS_ON_SEND |
+						SER_RS485_MODE_RS422;
+		}
+		if (kuart->capability & KUART_CAPABILITY_RS485) {
+			uart.port.rs485_supported.flags |= SER_RS485_ENABLED |
+							   SER_RS485_RTS_ON_SEND;
+			uart.port.rs485.flags = SER_RS485_ENABLED |
+						SER_RS485_RTS_ON_SEND;
+		}
+	}
+
+	retval = serial8250_register_8250_port(&uart);
+	if (retval < 0) {
+		dev_err(&auxdev->dev, "UART registration failed!\n");
+		return retval;
+	}
+	kuart->line = retval;
+
+	return 0;
+}
+
+static void kuart_remove(struct auxiliary_device *auxdev)
+{
+	struct kuart *kuart = auxiliary_get_drvdata(auxdev);
+
+	if (kuart->flags & KUART_USE_CAPABILITY)
+		kuart_set_phy_mode(kuart, KUART_MODE_NONE);
+
+	serial8250_unregister_port(kuart->line);
+}
+
+static const struct auxiliary_device_id kuart_devtype_aux[] = {
+	{ .name = "keba.rs485-uart", .driver_data = KUART_RS485 },
+	{ .name = "keba.rs232-uart", .driver_data = 0 },
+	{ .name = "keba.uart", .driver_data = KUART_USE_CAPABILITY },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, kuart_devtype_aux);
+
+static struct auxiliary_driver kuart_driver_aux = {
+	.name = KUART,
+	.id_table = kuart_devtype_aux,
+	.probe  = kuart_probe,
+	.remove = kuart_remove,
+};
+module_auxiliary_driver(kuart_driver_aux);
+
+MODULE_AUTHOR("Gerhard Engleder <eg@keba.com>");
+MODULE_DESCRIPTION("KEBA 8250 serial port driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f64ef0819cd4..5c3e4bcb3b93 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -430,6 +430,19 @@ config SERIAL_8250_IOC3
 	  behind the IOC3 device on those systems.  Maximum baud speed is
 	  38400bps using this driver.
 
+config SERIAL_8250_KEBA
+	tristate "Support for KEBA 8250 UART"
+	depends on SERIAL_8250
+	depends on KEBA_CP500
+	help
+	  Selecting this option will add support for KEBA UARTs. These UARTs
+	  are used for the serial interfaces of KEBA PLCs.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called 8250_keba.
+
+	  If unsure, say N.
+
 config SERIAL_8250_RT288X
 	bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 513a0941c284..f7a463c9860a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
+obj-$(CONFIG_SERIAL_8250_KEBA)		+= 8250_keba.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
-- 
2.39.5

