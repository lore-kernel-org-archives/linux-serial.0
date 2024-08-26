Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87929CE3;
	Mon, 26 Aug 2024 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640439; cv=none; b=ig0z0/yT0mNHbBcOXGxkf3+V5CGbB3Mln+eBhS3xiMTEv71G1CldomFUeVU1S4cN0B6mtYeR60+9BhQ5bkuTbsQhe+EmHg8i6BBfzUQH+EGrYfpqw6OEJcw4FlYzYNGzL+pqmv4TjdVKrgxjw9VmSN1AzdhO9zNaXhcB4pLj48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640439; c=relaxed/simple;
	bh=pSMrwPY+kKbQ/tbNpHRK8IwTjngp316VUC8cRaxX1jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QONhYAfaN9+kOw6872fwHmQYe2I5pmbQMxGODsfCtQPu6AkzEomnhwxkK51VYkzP14JQOsRYciGZ9/4295q4LrFUH17ClorruLSZw9g85ACk/pK3T1OosyVujU0QNCDaxNfvLW27Di5Pbsb1nxIZnuJDD9Yz2Mz22+1EFMmB894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8Dxupqy7Mtm4_ofAA--.28951S3;
	Mon, 26 Aug 2024 10:47:14 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMCxC2er7MtmDH4iAA--.51899S4;
	Mon, 26 Aug 2024 10:47:12 +0800 (CST)
From: zhenghaowei@loongson.cn
To: zhenghaowei@loongson.cn,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	p.zabel@pengutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v3 2/3] tty: serial: 8250: Add loongson uart driver support
Date: Mon, 26 Aug 2024 10:47:04 +0800
Message-ID: <20240826024705.55474-3-zhenghaowei@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826024705.55474-1-zhenghaowei@loongson.cn>
References: <20240826024705.55474-1-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2er7MtmDH4iAA--.51899S4
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAQEBBGbLHfYELAAAsr
X-Coremail-Antispam: 1Uk129KBj93XoW3CFyfGrW5Cw4DKrW5ZFWDGFX_yoWDZw4DpF
	1qy390krW0gF4Y93ykJrWYkF45Z3saka47KFW7G34Ykr98t3s5Xw1SkFyayr4jyryDJry7
	ZFWrCFW2kF4UX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4PfQUUUUU=

From: Haowei Zheng <zhenghaowei@loongson.cn>

Due to certain hardware design challenges, we have opted to
utilize a dedicated UART driver to probe the UART interface.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
---
 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_loongson.c | 228 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |   9 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   1 +
 6 files changed, 254 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c

Changes in V2:

- Correct the schema formatting errors.

- file name changed from 'loongson-uart.yaml' to 'loongson,ls7a-uart.yaml'

- Replace 'loongson,loongson-uart' with 'loongson,ls7a-uart'.

Changes in V3:

- Add 'LOONGSON UART DRIVER' description in MAINTAINERS.

- Use 'UPF_IOREMAP' instead of 'devm_ioremap()'.

- Use 'loongson_uart_config' to distinguish specific SoC.

- Call reset_control_assert() when err_unprepare occurs.

- Handle compilation errors.

diff --git a/MAINTAINERS b/MAINTAINERS
index 878dcd23b331..03024e9589bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13191,6 +13191,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
 
+LOONGSON UART DRIVER
+M:	Haowei Zheng <zhenghaowei@loongson.cn>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/loongson,uart.yaml
+F:	drivers/tty/serial/8250/8250_loongson.c
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
new file mode 100644
index 000000000000..88205fed4fd3
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
+ */
+
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/reset.h>
+
+#include "8250.h"
+
+/* Flags */
+#define LOONGSON_UART_FRAC         BIT(0)
+
+/* Quirks */
+#define LOONGSON_UART_QUIRK_MCR    BIT(0)
+#define LOONGSON_UART_QUIRK_MSR    BIT(1)
+
+struct loongson_uart_config {
+	unsigned int flags;
+	unsigned int quirks;
+};
+
+struct loongson_uart_data {
+	struct reset_control *rst;
+	int line;
+	int mcr_invert;
+	int msr_invert;
+	const struct loongson_uart_config *config;
+};
+
+static const struct loongson_uart_config ls3a5000_uart_config = {
+	.flags = 0,
+	.quirks = LOONGSON_UART_QUIRK_MCR
+};
+
+static const struct loongson_uart_config ls7a_uart_config = {
+	.flags = 0,
+	.quirks = LOONGSON_UART_QUIRK_MCR | LOONGSON_UART_QUIRK_MSR
+};
+
+static const struct loongson_uart_config ls2k2000_uart_config = {
+	.flags = LOONGSON_UART_FRAC,
+	.quirks = LOONGSON_UART_QUIRK_MCR
+};
+
+static unsigned int serial_fixup(struct uart_port *p, unsigned int offset, unsigned int val)
+{
+	struct loongson_uart_data *data = p->private_data;
+
+	if (offset == UART_MCR)
+		val ^= data->mcr_invert;
+	if (offset == UART_MSR)
+		val ^= data->msr_invert;
+
+	return val;
+}
+
+static unsigned int loongson_serial_in(struct uart_port *p, int offset)
+{
+	unsigned int val, offset0 = offset;
+
+	offset = offset << p->regshift;
+	val = readb(p->membase + offset);
+
+	return serial_fixup(p, offset0, val);
+}
+
+static void loongson_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset = offset << p->regshift;
+	writeb(serial_fixup(p, offset, value), p->membase + offset);
+}
+
+static unsigned int loongson_frac_get_divisor(struct uart_port *port,
+		unsigned int baud,
+		unsigned int *frac)
+{
+	unsigned int quot;
+
+	quot = DIV_ROUND_CLOSEST((port->uartclk << 4), baud);
+	*frac = quot & 0xff;
+
+	return quot >> 8;
+}
+
+static void loongson_frac_set_divisor(struct uart_port *port, unsigned int baud,
+		unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+
+	serial_dl_write(up, quot);
+
+	serial_port_out(port, 0x2, quot_frac);
+}
+
+static int loongson_uart_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct loongson_uart_data *data;
+	struct uart_port *port;
+	struct resource *res;
+	int ret;
+
+	port = &uart.port;
+	spin_lock_init(&port->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_IOREMAP;
+	port->iotype = UPIO_MEM;
+	port->regshift = 0;
+	port->dev = &pdev->dev;
+	port->type = PORT_LOONGSON;
+	port->mapbase = res->start;
+	port->mapsize = resource_size(res);
+	port->serial_in = loongson_serial_in;
+	port->serial_out = loongson_serial_out;
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return -EINVAL;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->config = device_get_match_data(&pdev->dev);
+
+	port->private_data = data;
+
+	if (data->config->flags & LOONGSON_UART_FRAC) {
+		port->get_divisor = loongson_frac_get_divisor;
+		port->set_divisor = loongson_frac_set_divisor;
+	}
+
+	if (data->config->quirks & LOONGSON_UART_QUIRK_MCR)
+		data->mcr_invert |= (UART_MCR_RTS | UART_MCR_DTR);
+
+	if (data->config->quirks & LOONGSON_UART_QUIRK_MSR)
+		data->msr_invert |= (UART_MSR_CTS | UART_MSR_DSR);
+
+	data->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(data->rst))
+		return PTR_ERR(data->rst);
+
+	device_property_read_u32(&pdev->dev, "clock-frequency", &port->uartclk);
+
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		goto err_unprepare;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		goto err_unprepare;
+
+	platform_set_drvdata(pdev, data);
+	data->line = ret;
+
+	return 0;
+
+err_unprepare:
+	reset_control_assert(data->rst);
+
+	return ret;
+}
+
+static void loongson_uart_remove(struct platform_device *pdev)
+{
+	struct loongson_uart_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	reset_control_assert(data->rst);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int loongson_uart_suspend(struct device *dev)
+{
+	struct loongson_uart_data *data = dev_get_drvdata(dev);
+
+	serial8250_suspend_port(data->line);
+
+	return 0;
+}
+
+static int loongson_uart_resume(struct device *dev)
+{
+	struct loongson_uart_data *data = dev_get_drvdata(dev);
+
+	serial8250_resume_port(data->line);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops loongson_uart_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(loongson_uart_suspend, loongson_uart_resume)
+};
+
+static const struct of_device_id of_platform_serial_table[] = {
+	{.compatible = "loongson,ls7a-uart", .data = &ls7a_uart_config},
+	{.compatible = "loongson,ls3a5000-uart", .data = &ls3a5000_uart_config},
+	{.compatible = "loongson,ls2k2000-uart", .data = &ls2k2000_uart_config},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_platform_serial_table);
+
+static struct platform_driver loongson_uart_driver = {
+	.probe = loongson_uart_probe,
+	.remove = loongson_uart_remove,
+	.driver = {
+		.name = "loongson-uart",
+		.pm = &loongson_uart_pm_ops,
+		.of_match_table = of_platform_serial_table,
+	},
+};
+
+module_platform_driver(loongson_uart_driver);
+
+MODULE_DESCRIPTION("LOONGSON 8250 Driver");
+MODULE_AUTHOR("Haowei Zheng <zhenghaowei@loongson.cn>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 2786918aea98..60b72c785028 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_LOONGSON] = {
+		.name		= "Loongson",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes   = {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 47ff50763c04..ca828e94719a 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -568,6 +568,15 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_LOONGSON
+	tristate "Loongson 8250 serial port support"
+	default SERIAL_8250
+	depends on SERIAL_8250
+	depends on LOONGARCH
+	help
+	  If you have machine with Loongson and want to use this serial driver,
+	  say Y to this option. If unsure, say N.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 1516de629b61..e9587bf69f65 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -51,5 +51,6 @@ obj-$(CONFIG_SERIAL_8250_RT288X)	+= 8250_rt288x.o
 obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
 obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
+obj-$(CONFIG_SERIAL_8250_LOONGSON)	+= 8250_loongson.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..9e316b9295e5 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -31,6 +31,7 @@
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
 #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
 #define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
+#define PORT_LOONGSON   31      /* Loongson 16550 UART*/
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
2.43.0

