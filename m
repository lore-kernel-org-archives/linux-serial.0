Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64573412BE7
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435811; cv=none; b=GOb6s3J3eJputD/KJNrqQTimZVi5VZmrLDZ85DKp3Zr1Pp8k0lvQBT8Oaj+tSLjbpgeJLAOQq4hmJHiNQFTXQhzFjfnB6XoVhgrA5+rHLo0wPRgatEXKd/aXP3myOOSqgpRYQLmImbfqn6ynEvE2pwruqR38U9xkDnqxoYUdjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435811; c=relaxed/simple;
	bh=pRywqyjcN+s9xqw6lT2yIXo8H0f36+MeGHolX/N/5LE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsxtwmTsQr/g8k/26tBFCBhTYMF6uBXkxaIXAW0aJyMlYSzF6uOvmF6m4OgccrhAWfuudesVdutQKAMUKMtgvp/QXQGPRREy55tmx+oGddP2bLtq2FUZ2cDmDUqcp2496zi7SGngylZZKZipPUZwQkzxwAk8+AFOpdcQ6Tnee14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv9ajNIS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv9ajNIS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980dc26022so28263695e9.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435807; x=1787040607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t7y42iTAOFamntAXZPdzptkHEiwN6mZNRtIqENKnw0w=;
        b=bv9ajNISe9OuW4WpKRN9GwafsNwSUPkw/NMqWmacLBF/YSNysqWvywE9Oul0NGS6iA
         9tO7n1aHBbShS7nQg3+Vy59lPMSsndOZQP+MLTCCpy7eiR1+IZnMzQH5LoE1jk7vA8MU
         G2PCSA6lScDtADBIJToUy0L5Gc4mPX+e33anl1XIM7TdShstC56o2k0c90n6DOvZbirf
         l3kb6vYGTXAVVBXnf082bbhd29nadkXcVSMfSkWmvnK35SsmTPNCRHLfZaJUzMUtGJi+
         TWhhyH9wCMfx9fOpQ9UiavehgO4yZDADJ7iFnJtURDSTlTstnZENO7CrBb/R3Ghb4ZNG
         J/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435807; x=1787040607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t7y42iTAOFamntAXZPdzptkHEiwN6mZNRtIqENKnw0w=;
        b=r4jDIuf6UndMxU/t/cTkb67pnWJ3uRES/NJbaYFkzfgWr9Z0dNRGz/77IbaXWSnuOl
         BCeefwQ/sOkAW4W7eYWWF4DKtEJzXYLtOSu4mUqT83wiWZCAPKFLLC9gthbE7XATk0G7
         eBzeraVJ0Qkq87H0IVUSNSegCzkkgiugbKo57U/T3K1gr8mpeJ9iic6MmblfSo4Fzk0l
         3LMcGOo4lF+LRiGwQtnJEP4MhnWcUTZu71YLoOP8RAXoe0axHCp7q5AivI4m7V5Zkbfj
         OhwxINabh3f0/00HANDl1mR1KfdZj77WSzQtAvWruLN/yWyDPSnoV4eXlQOcArYw/gmD
         z+OA==
X-Forwarded-Encrypted: i=1; AHgh+RqNC7KXUg7ynTf58m8ck5vh/hTnNX+Wq6kYZ30K5JkPkhbPI4QI/kNUBfbUa70PWLb9gMSttw/MbwBoYyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4L4WoQkGi6OCjeHRFdY2Fe0OP8FuVgaiO0tZ6UFnw9MuBrUe
	uMkodWV32D9Y7SJ25YbvmsBN0EOeBOwf5DMUuiTU1b8LV6o62Rpkpfae
X-Gm-Gg: AR+sD12uXjETMpOg5W6Eq7yIP/2whbZUjVx1oP0tP8ngLTRDzzsLlfwsUTUoQu0VI0M
	CGHIu2L5kPtzl5pKxQTa206MG0CXdXV6YnD/6dcxifm6PFK7uV6jQr5meCIgdQx9BxhYi4PbuL4
	IeoAtk3kpbU1H8zFVLwE3bAS429wyqfNONFbsiJnEKbisJuA9+H86xzC3662Q4osTJbXniOsTvn
	8yMqtNdZxuSvcEN9yMDF++FXn7xiFVCuaNXihyx+QBEVhlus3mKFCJo1EPM+FIoxSXm1Ymv9rwb
	pQpETC2Yv4lXOxwH3SGK44XQBz2urU0WRRp/kdPg0E8AtckaG1AZrQ7W3/CdCruqxY8mK0W42C+
	n2PuTWoPF5GViKCUkmH9mdkpTUxjaBOQNTS3IEJIrD0D7QN65mQa21IdpnQX0G9Q70ZaBfFQnBP
	frHo+0n8A2q7R084BSDREWj7QYJYriXHWOWbCbGL/ByTnssvYgPLdrmIqUIeJldxQydX2CxlZRJ
	JRPNcS3bAI84hXConJpE423bsfbBJNKb3njbcjEc25kpoUIIz382bYnd3M=
X-Received: by 2002:a05:600c:4ecd:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-4997913e137mr9703225e9.17.1786435807466;
        Tue, 11 Aug 2026 01:10:07 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm45336675e9.1.2026.08.11.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:06 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 3/3] serial: 8250: Add Airoha SoC UART and HSUART support
Date: Tue, 11 Aug 2026 10:09:48 +0200
Message-ID: <20260811080950.664379-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811080950.664379-1-ansuelsmth@gmail.com>
References: <20260811080950.664379-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7523 UART and AN7581 HSUART.

These implement a standard 16550 UART with only some custom logic
for baud rate handling.

Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/tty/serial/8250/8250.h        |   6 +
 drivers/tty/serial/8250/8250_airoha.c | 187 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c   |  16 +++
 drivers/tty/serial/8250/Kconfig       |  11 ++
 drivers/tty/serial/8250/Makefile      |   1 +
 5 files changed, 221 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 77fe0588fd6b..e6b2b9431229 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -73,6 +73,12 @@ struct serial8250_config {
 	unsigned int	flags;
 };
 
+enum uart_port_type {
+	/* Internal 8250 only */
+	UART_PORT_AIROHA		= 124,
+	UART_PORT_AIROHA_HS		= 125,
+};
+
 #define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
 #define UART_CAP_EFR	BIT(9)	/* UART has EFR */
 #define UART_CAP_SLEEP	BIT(10)	/* UART has IER sleep */
diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
new file mode 100644
index 000000000000..fe72a39561c2
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha UART driver
+ *
+ * Copyright (c) 2025 Genexis Sweden AB
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ *	   Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "8250.h"
+
+#define UART_AIROHA_XINCLKDR	10
+#define UART_AIROHA_XYD		11
+#define   UART_AIROHA_XYD_X	GENMASK(31, 16)
+#define   UART_AIROHA_XYD_Y	GENMASK(15, 0)
+
+struct airoha_8250_priv {
+	int line;
+};
+
+#define UART_BRD_20M		0x0001
+
+#define XINDIV_CLOCK		(20 * HZ_PER_MHZ)
+#define XYD_Y			65000
+
+static const unsigned int airoha_clk_divs[] = { 2, 4, 10 };
+
+static unsigned int airoha_get_divisor(struct uart_port *port,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	/* Hardware always uses BRDIV = 1. */
+	*frac = 0;
+
+	return UART_BRD_20M;
+}
+
+/*
+ * Airoha UART baud rate calculation logic
+ *
+ * crystal_clock = 20 MHz (fixed frequency)
+ * xindiv_clock = crystal_clock / clock_div
+ * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
+ * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
+ *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
+ *
+ * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
+ *
+ * Selecting divider needs to fulfill
+ * 1.8432 MHz <= xindiv_clk <= APB clock / 2
+ * The clocks are unknown but a divider of value 1 did not result in a valid
+ * waveform.
+ *
+ * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
+ * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 gives even values
+ * for usual baud rates.
+ */
+static void airoha_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 xindiv_clk;
+	u64 xyd_x, nom;
+	int div_bit;
+
+	/* Set baud rate calculation defaults (BRDIV [BRDH,BRDL] to 1) */
+	serial8250_do_set_divisor(port, baud, UART_BRD_20M);
+
+	/*
+	 * Calculate XYD_x and XINCLKDR register by searching
+	 * through a table of crystal_clock divisors.
+	 */
+	nom = (u64)baud * XYD_Y;
+	for (div_bit = ARRAY_SIZE(airoha_clk_divs) - 1; div_bit >= 0; div_bit--) {
+		unsigned int div = airoha_clk_divs[div_bit];
+
+		xindiv_clk = XINDIV_CLOCK / div;
+		xyd_x = div_u64(nom * 16, xindiv_clk);
+
+		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
+		if (port->type == UART_PORT_AIROHA_HS)
+			xyd_x /= 2;
+
+		if (xyd_x < XYD_Y)
+			break;
+	}
+
+	/* Couldn't find a valid xyd_x */
+	if (div_bit < 0) {
+		dev_err(port->dev, "failed to find suitable clock divisor for baud %u\n",
+			baud);
+		return;
+	}
+
+	serial_port_out(port, UART_AIROHA_XINCLKDR, BIT(div_bit));
+	serial_port_out(port, UART_AIROHA_XYD,
+			FIELD_PREP(UART_AIROHA_XYD_X, xyd_x) |
+			FIELD_PREP(UART_AIROHA_XYD_Y, XYD_Y));
+
+	/* Restore normal register access. */
+	serial_port_out(port, UART_LCR, up->lcr);
+}
+
+static int airoha_8250_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = { };
+	struct device *dev = &pdev->dev;
+	struct airoha_8250_priv *priv;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -EINVAL, "invalid address\n");
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	uart.port.dev = dev;
+	if (device_is_compatible(dev, "airoha,an7581-hsuart"))
+		uart.port.type = UART_PORT_AIROHA_HS;
+	else
+		uart.port.type = UART_PORT_AIROHA;
+	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+			  UPF_FIXED_TYPE | UPF_IOREMAP;
+	uart.port.set_divisor = airoha_set_divisor;
+	uart.port.get_divisor = airoha_get_divisor;
+	uart.port.mapbase = res->start;
+	uart.port.mapsize = resource_size(res);
+
+	ret = uart_read_and_validate_port_properties(&uart.port);
+	if (ret)
+		return ret;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		return ret;
+
+	priv->line = ret;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void airoha_8250_remove(struct platform_device *ofdev)
+{
+	struct airoha_8250_priv *priv = platform_get_drvdata(ofdev);
+
+	serial8250_unregister_port(priv->line);
+}
+
+static const struct of_device_id airoha_8250_dt_ids[] = {
+	{ .compatible = "airoha,en7523-uart" },
+	{ .compatible = "airoha,an7581-hsuart" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, airoha_8250_dt_ids);
+
+static struct platform_driver airoha_8250_driver = {
+	.driver = {
+		.name = "8250_airoha",
+		.of_match_table = airoha_8250_dt_ids,
+	},
+	.probe = airoha_8250_probe,
+	.remove = airoha_8250_remove,
+};
+module_platform_driver(airoha_8250_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Airoha UART driver");
+MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 630deb7dd344..c888cae7d98b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -311,6 +311,22 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[UART_PORT_AIROHA] = {
+		.name		= "Airoha UART",
+		.fifo_size	= 8,
+		.tx_loadsz	= 1,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4, 4, 4},
+		.flags		= UART_CAP_FIFO,
+	},
+	[UART_PORT_AIROHA_HS] = {
+		.name		= "Airoha HSUART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
+		.rxtrig_bytes	= {1, 4},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index fc3e58d62233..310da7af7a49 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -337,6 +337,17 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
+config SERIAL_8250_AIROHA
+	tristate "Airoha UART support"
+	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on SERIAL_8250
+	help
+	  Selecting this option enables an Airoha SoC specific baud rate
+	  calculation routine on an otherwise 16550 compatible UART hardware.
+
+	  If you have an Airoha based board and want to use the serial port,
+	  say Y to this option. If unsure, say N.
+
 config SERIAL_8250_BCM2835AUX
 	tristate "BCM2835 auxiliar mini UART support"
 	depends on ARCH_BCM2835 || COMPILE_TEST
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 6d21402b4435..83257696ea8a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
+obj-$(CONFIG_SERIAL_8250_AIROHA)	+= 8250_airoha.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
-- 
2.53.0

