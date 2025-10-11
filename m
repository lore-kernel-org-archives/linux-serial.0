Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79121CC51
	for <linux-serial@vger.kernel.org>; Sat, 11 Oct 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167042; cv=none; b=OBmPQ/2utgbLRS36E3jSuuZc3ijgv+l8i+mmaLag/Ttc7lDoxY2Xgsd47Qx6M6IaCXjwgtEjuB/ReT92Mrp1Gu+6r/OAIFwxoJJ345ZadWLME93yu4Fw6N2Sru/nUP2f///uQmcDuEZKE31hIRJA394BKuWesNw0BTZO6j9i8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167042; c=relaxed/simple;
	bh=L2W4jn/TOs30IRp30XtiERjk0rrz8NdnrRtbIayjSBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suAzA8d/UotMfU48MqigX+tEjy5b4oACGmUL7ExW55qSRHnRyaPs+9Ys7YOxV62JAfKKKbq9XkC2SsJeJ5s2mXerwB8Q+jydQcXv69sbrya04aDX9SPgGCWOJpK4wE6ZiCjna4PZZDi8SNbsadm+iHjipa4tW9cGXqRaduZGSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8AxSNF4BOpoWvkUAA--.45476S3;
	Sat, 11 Oct 2025 15:17:12 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxaMBwBOpo1ebZAA--.1011S4;
	Sat, 11 Oct 2025 15:17:11 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	ilpo.jarvinen@linux.intel.com,
	linux-serial@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v6 2/3] serial: 8250: Add Loongson uart driver support
Date: Sat, 11 Oct 2025 15:16:48 +0800
Message-ID: <2c2a01a276b9250efea0c7aa190efecdfd6fdf5a.1760166651.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1760166651.git.zhoubinbin@loongson.cn>
References: <cover.1760166651.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaMBwBOpo1ebZAA--.1011S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEMCGjp8aoA9wAAsp
X-Coremail-Antispam: 1Uk129KBj93XoW3Xry8XrWfXrWxuw15KryDArc_yoWfCrWrpF
	n0y398trWUtF409aykArWYyF45Zw13KF9rtFW7Gw1fKr9xt34kXryfKF90yr48AFyDJry5
	ZayjkFW8CF4UWagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r4j6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UN6p9UUUUU=

Add the driver for on-chip UART used on Loongson family chips.

The hardware is similar to NS16550A, but there are the following
differences:
 - Some chips (such as Loongson-2K2000) have added a fractional division
   register to obtain the required baud rate accurately, so the
   {get,set}_divisor callback is overridden.
 - Due to hardware defects, quirk handling is required for
   UART_MCR/UART_MSR.

Co-developed-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/tty/serial/8250/8250_loongson.c | 238 ++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig         |  10 +
 drivers/tty/serial/8250/Makefile        |   1 +
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c

diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
new file mode 100644
index 000000000000..53153a116c01
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Serial Port driver for Loongson family chips
+ *
+ * Copyright (C) 2020-2025 Loongson Technology Corporation Limited
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/property.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/reset.h>
+
+#include "8250.h"
+
+/* Divisor Latch Fraction Register */
+#define LOONGSON_UART_DLF		0x2
+
+#define LOONGSON_QUOT_FRAC_MASK		GENMASK(7, 0)
+#define LOONGSON_QUOT_DIV_MASK		GENMASK(15, 8)
+
+struct loongson_uart_ddata {
+	bool has_frac;
+	u8 mcr_invert;
+	u8 msr_invert;
+};
+
+static const struct loongson_uart_ddata ls2k0500_uart_data = {
+	.has_frac = false,
+	.mcr_invert = UART_MCR_RTS | UART_MCR_DTR,
+	.msr_invert = UART_MSR_CTS | UART_MSR_DSR,
+};
+
+static const struct loongson_uart_ddata ls2k1500_uart_data = {
+	.has_frac = true,
+	.mcr_invert = UART_MCR_RTS | UART_MCR_DTR,
+	.msr_invert = 0,
+};
+
+struct loongson_uart_priv {
+	int line;
+	struct clk *clk;
+	struct resource *res;
+	struct reset_control *rst;
+	const struct loongson_uart_ddata *ddata;
+};
+
+static u8 serial_fixup(struct uart_port *p, unsigned int offset, u8 val)
+{
+	struct loongson_uart_priv *priv = p->private_data;
+
+	switch (offset) {
+	case UART_MCR:
+		return val ^ priv->ddata->mcr_invert;
+	case UART_MSR:
+		return val ^ priv->ddata->msr_invert;
+	default:
+		return val;
+	}
+}
+
+static u32 loongson_serial_in(struct uart_port *p, unsigned int offset)
+{
+	u8 val;
+
+	val = readb(p->membase + (offset << p->regshift));
+
+	return serial_fixup(p, offset, val);
+}
+
+static void loongson_serial_out(struct uart_port *p, unsigned int offset, unsigned int value)
+{
+	u8 val;
+
+	offset <<= p->regshift;
+	val = serial_fixup(p, offset, value);
+	writeb(val, p->membase + offset);
+}
+
+static unsigned int loongson_frac_get_divisor(struct uart_port *port, unsigned int baud,
+					      unsigned int *frac)
+{
+	unsigned int quot;
+
+	quot = DIV_ROUND_CLOSEST((port->uartclk << 4), baud);
+	*frac = FIELD_GET(LOONGSON_QUOT_FRAC_MASK, quot);
+
+	return FIELD_GET(LOONGSON_QUOT_DIV_MASK, quot);
+}
+
+static void loongson_frac_set_divisor(struct uart_port *port, unsigned int baud,
+				      unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
+	serial_dl_write(up, quot);
+	serial_port_out(port, LOONGSON_UART_DLF, quot_frac);
+}
+
+static int loongson_uart_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = {};
+	struct loongson_uart_priv *priv;
+	struct uart_port *port;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ddata = device_get_match_data(dev);
+
+	port = &uart.port;
+	spin_lock_init(&port->lock);
+	port->flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_IOREMAP;
+	port->iotype = UPIO_MEM;
+	port->regshift = 0;
+	port->dev = dev;
+	port->type = PORT_16550A;
+	port->private_data = priv;
+
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &priv->res);
+	if (!port->membase)
+		return -ENOMEM;
+
+	port->mapbase = priv->res->start;
+	port->mapsize = resource_size(priv->res);
+	port->serial_in = loongson_serial_in;
+	port->serial_out = loongson_serial_out;
+
+	if (priv->ddata->has_frac) {
+		port->get_divisor = loongson_frac_get_divisor;
+		port->set_divisor = loongson_frac_set_divisor;
+	}
+
+	ret = uart_read_port_properties(port);
+	if (ret)
+		return ret;
+
+	if (!port->uartclk) {
+		priv->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(priv->clk))
+			return dev_err_probe(dev, PTR_ERR(priv->clk),
+					     "Unable to determine clock frequency!\n");
+		port->uartclk = clk_get_rate(priv->clk);
+	}
+
+	priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		return ret;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0) {
+		reset_control_assert(priv->rst);
+		return ret;
+	}
+
+	priv->line = ret;
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static void loongson_uart_remove(struct platform_device *pdev)
+{
+	struct loongson_uart_priv *priv = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(priv->line);
+	reset_control_assert(priv->rst);
+}
+
+static int loongson_uart_suspend(struct device *dev)
+{
+	struct loongson_uart_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+
+	serial8250_suspend_port(priv->line);
+
+	if (!uart_console(&up->port) || console_suspend_enabled)
+		clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int loongson_uart_resume(struct device *dev)
+{
+	struct loongson_uart_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	int ret;
+
+	if (!uart_console(&up->port) || console_suspend_enabled) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret)
+			return ret;
+	}
+
+	serial8250_resume_port(priv->line);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(loongson_uart_pm_ops, loongson_uart_suspend,
+				loongson_uart_resume);
+
+static const struct of_device_id loongson_uart_of_ids[] = {
+	{ .compatible = "loongson,ls2k0500-uart", .data = &ls2k0500_uart_data },
+	{ .compatible = "loongson,ls2k1500-uart", .data = &ls2k1500_uart_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, loongson_uart_of_ids);
+
+static struct platform_driver loongson_uart_driver = {
+	.probe = loongson_uart_probe,
+	.remove = loongson_uart_remove,
+	.driver = {
+		.name = "loongson-uart",
+		.pm = pm_ptr(&loongson_uart_pm_ops),
+		.of_match_table = loongson_uart_of_ids,
+	},
+};
+
+module_platform_driver(loongson_uart_driver);
+
+MODULE_DESCRIPTION("Loongson UART driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f64ef0819cd4..98236b3bec10 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -468,6 +468,16 @@ config SERIAL_8250_OMAP_TTYO_FIXUP
 	  not booting kernel because the serial console remains silent in case
 	  they forgot to update the command line.
 
+config SERIAL_8250_LOONGSON
+	tristate "Loongson 8250 based serial port"
+	depends on SERIAL_8250
+	depends on LOONGARCH || COMPILE_TEST
+	help
+	  If you have a machine based on LoongArch CPU you can enable
+	  its onboard serial ports by enabling this option. The option
+	  is applicable to both devicetree and ACPI, say Y to this option.
+	  If unsure, say N.
+
 config SERIAL_8250_LPC18XX
 	tristate "NXP LPC18xx/43xx serial port support"
 	depends on SERIAL_8250 && OF && (ARCH_LPC18XX || COMPILE_TEST)
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 513a0941c284..e318a3240789 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
+obj-$(CONFIG_SERIAL_8250_LOONGSON)	+= 8250_loongson.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
-- 
2.47.3

