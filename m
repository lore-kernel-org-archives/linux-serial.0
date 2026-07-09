Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F33E2ADB
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630635; cv=none; b=a5G0Du5eJY/R1UAx3DZeOV/FgMZaGjB3nMkR+Vvij/XaSHFV29A3Y+ukwtV02nVK4WXUfVtCp0fwH3paOKFltBLpKpOfzFRAivSoHcoCmpsOCxh86wvec4Hej9lCUpR6/w7r4/hNctTjO4aovTjgNYcYgJJbivZ+rABY3F4vMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630635; c=relaxed/simple;
	bh=35v9WAZmslUVWv+L4VkKhmIp0hoPZJnhQy7LFzDfiLA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laM7Mvey3SeESa4v3h9ghLbIMyi4CT+Nc85puVSA7KdzIEd8ig5uoTbB49GBJS28iKtOlE0gYfSIOIntieYEBaaw60L13aVwns3MzY4PiTP+wWys0e5+Rko1OiqHBTfiy3mv9jlAaRtkx4mEO8/T9LvhBeeykoR8csd7A484T1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOJDI1di; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOJDI1di"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-472326ca506so212152f8f.2
        for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630631; x=1784235431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SFQ9Eok0Wl4QiDdPnBH4n5fnWEcwO4nrRrZj/mbv1wM=;
        b=kOJDI1didZkq9C/8yqwDEH7+V4hRox71BZQFI3lpEFzb64G31TFD6XO3zq8ZSp1HWr
         tp1zKNgM0E/vvig8SosHri7C5RbvlOCJtZl/wieBy+gEHlVrPU6E1d+FMOeitkHhhnDq
         t59gWXhk+kb3XAqpbvhLLAjofP9Ub3Q1rv8kHOu8auvmWGMUbM8ypTViwtc+xgCBGnRi
         OSTWdMKkNfzg/vTbdL+JdJvXIzdr2+mSQEVl9BfoiWRQXolJgkVXqP1cuHB8mhptdsLt
         8a3/tlz6/Em9xfUCvMWBbgCzRofXRjuc9SV/5KKk2Zlt7BiAUNtO8LlcEW9GLbu3F7UI
         HDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630631; x=1784235431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SFQ9Eok0Wl4QiDdPnBH4n5fnWEcwO4nrRrZj/mbv1wM=;
        b=HMHURTCmW8Y8UIW41E64z8/+J5nbXnqtmn6Xnw0Or30iOEIQTF++rOyeH+rAkMvCAQ
         Ibd9ytC5cs1GiLNaV55ycTHQtO8+6poX9QYusqmjoYSIn0lLojOJuXRLnTsF8psJIZra
         EpODH5zUMREQxRSne0PC+b0fj5zi++aF6i22vQL8uKZ2G9MXtkg0jOOxBy11gbF4Otof
         el9mgy3FeJD8bAjXvSfPbFDBaXzbIb5NxjMMrGzoYmgkx2VLZSix+DhsWfDnZ65M2BWi
         WNhRra0aLKpOoiobAk5ROdkMseZFGgmy5xAXnvjIhFXtFU6Cfxa+Nq72lz61oOatG/Sz
         RX4w==
X-Forwarded-Encrypted: i=1; AHgh+RrN1SgI5qm0RmyMehDDbThcY3pdf2ZgjmX+k3xTPHmjeLiHyp02TvaE6K5t6ATvNJjditgVqIbt48t6/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGGDztgZGmxK/vWMRvg5wmvhDe50qC0n3YdGaJ2QWKL/CALcM
	A459+sFQgxpmcakXiGGglSPa01UGT2fLSFtSzZTh7r43D2pg5OsR3pZC
X-Gm-Gg: AfdE7ckKJssPXsNLPXBvkj4zRgSbWDgkegoggrVKtXkiiLLE4be+CfVCs1LGxCajX7V
	bdnxYkjY/gJxP0eeqj4DQBmNdDRZKlqeVURBgITHC+Ms5nUNG1+Hl+c0+5cClUCpBBd30TavpIE
	caj9t8DjQ9cZWDPnqYXaGn6Hmj4Ys0EI9PPEMzR4EbZtojcy97rtfneYnCwSo7lcm3FctuNb4ik
	ytGLvOYomt6+dw3lgdMZbvI05nzu+JG4nkjNRA2gi0iIGGH0IoOmp9WCtj3JDVuqNGsOnCFsz2x
	QSXvQKeeFB28H/b19mwa2Zxia2x1mZH39iquvdKc7UaTprNhkHiqNV7dyxRjwd2izHUvZiybX6R
	hN2OtKJFuGE44zc1N85ZTwZSPE/CVF/n0bgFhbC0s3w3sY0fIN4bWFAScnDICe04h/Z6Z/0cXWw
	vce9WKEu1Wb9MDixcT8lzBHkbCc4X5ygGumKaGu833d/je8wRla6NtiggLGHMqK39qILnsmknlF
	/eB4tAU
X-Received: by 2002:a05:6000:428a:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-47df074a29fmr9923731f8f.26.1783630631403;
        Thu, 09 Jul 2026 13:57:11 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm52894965f8f.6.2026.07.09.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:57:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Lukas Wunner <lukas@wunner.de>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 4/4] serial: 8250: Add Airoha SoC UART and HSUART support
Date: Thu,  9 Jul 2026 22:56:52 +0200
Message-ID: <20260709205656.319531-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709205656.319531-1-ansuelsmth@gmail.com>
References: <20260709205656.319531-1-ansuelsmth@gmail.com>
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
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/tty/serial/8250/8250.h        |   4 +
 drivers/tty/serial/8250/8250_airoha.c | 190 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c   |  16 +++
 drivers/tty/serial/8250/Kconfig       |  11 ++
 drivers/tty/serial/8250/Makefile      |   1 +
 5 files changed, 222 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 3a45f957d3a9..a0dec4161240 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -193,6 +193,10 @@ enum uart_port_type {
 	UART_PORT_SUNIX			= PORT_SUNIX,
 	UART_PORT_LINFLEXUART		= PORT_LINFLEXUART,
 	UART_PORT_SUNPLUS		= PORT_SUNPLUS, /* 123 */
+
+	/* Internal 8250 only */
+	UART_PORT_AIROHA		= 124,
+	UART_PORT_AIROHA_HS		= 125,
 };
 
 #define UART_CAP_FIFO	BIT(8)	/* UART has FIFO */
diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
new file mode 100644
index 000000000000..9ec98cd8de43
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_airoha.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Airoha UART driver
+ *
+ * Copyright (c) 2025 Genexis Sweden AB
+ * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
+ *	   Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/property.h>
+#include <linux/serial_reg.h>
+#include <linux/serial_8250.h>
+
+#include "8250.h"
+
+#define UART_AIROHA_BRDL	0
+#define UART_AIROHA_BRDH	1
+#define UART_AIROHA_XINCLKDR	10
+#define UART_AIROHA_XYD		11
+
+struct airoha_8250_priv {
+	int line;
+};
+
+struct airoha_8250_data {
+	unsigned int type;
+};
+
+struct airoha_8250_clk_div_info {
+	int div;
+	int mask;
+};
+
+#define UART_BRDL_20M		0x01
+#define UART_BRDH_20M		0x00
+
+#define XINDIV_CLOCK		20000000
+#define XYD_Y			65000
+
+static const struct airoha_8250_clk_div_info airoha_clk_div_info[] = {
+	{ .div = 10, .mask = BIT(2) },
+	{ .div = 4, .mask = BIT(1) },
+	{ .div = 2, .mask = BIT(0) },
+};
+
+static const int clock_div_tab[] = { 10, 4, 2};
+static const int clock_div_reg[] = {  4, 2, 1};
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
+static void airoha_set_termios(struct uart_port *port, struct ktermios *termios,
+			       const struct ktermios *old)
+{
+	const struct airoha_8250_clk_div_info *clk_div_info;
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int xyd_x, nom, denom;
+	unsigned int baud;
+	int i;
+
+	serial8250_do_set_termios(port, termios, old);
+
+	baud = serial8250_get_baud_rate(port, termios, old);
+
+	/* Set DLAB to access the baud rate divider registers (BRDH, BRDL) */
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+
+	/* Set baud rate calculation defaults (BRDIV ([BRDH,BRDL]) to 1) */
+	serial_port_out(port, UART_AIROHA_BRDL, UART_BRDL_20M);
+	serial_port_out(port, UART_AIROHA_BRDH, UART_BRDH_20M);
+
+	/*
+	 * Calculate XYD_x and XINCLKDR register by searching
+	 * through a table of crystal_clock divisors.
+	 */
+	for (i = 0 ; i < ARRAY_SIZE(airoha_clk_div_info) ; i++) {
+		clk_div_info = &airoha_clk_div_info[i];
+
+		denom = (XINDIV_CLOCK / 40) / clk_div_info->div;
+		nom = baud * (XYD_Y / 40);
+		xyd_x = ((nom / denom) << 4);
+		/* For the HSUART xyd_x needs to be scaled by a factor of 2 */
+		if (port->type == UART_PORT_AIROHA_HS)
+			xyd_x = xyd_x >> 1;
+		if (xyd_x < XYD_Y)
+			break;
+	}
+
+	serial_port_out(port, UART_AIROHA_XINCLKDR, clk_div_info->mask);
+	serial_port_out(port, UART_AIROHA_XYD, (xyd_x << 16) | XYD_Y);
+
+	/* unset DLAB */
+	serial_port_out(port, UART_LCR, up->lcr);
+}
+
+static int airoha_8250_probe(struct platform_device *pdev)
+{
+	const struct airoha_8250_data *data;
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
+	data = device_get_match_data(dev);
+
+	uart.port.dev = dev;
+	uart.port.type = data->type;
+	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT |
+			  UPF_FIXED_TYPE | UPF_IOREMAP;
+	uart.port.set_termios = airoha_set_termios;
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
+static const struct airoha_8250_data en7523_data = {
+	.type = UART_PORT_AIROHA,
+};
+
+static const struct airoha_8250_data an7581_hs_data = {
+	.type = UART_PORT_AIROHA_HS,
+};
+
+static const struct of_device_id airoha_8250_dt_ids[] = {
+	{ .compatible = "airoha,en7523-uart", .data = &en7523_data, },
+	{ .compatible = "airoha,an7581-hsuart", .data = &an7581_hs_data, },
+	{ },
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
+
+module_platform_driver(airoha_8250_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Airoha UART driver");
+MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a0b80324a559..29f0245264ec 100644
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
+		.rxtrig_bytes	= {1, 4},
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

