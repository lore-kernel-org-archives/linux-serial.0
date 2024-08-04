Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAC11712;
	Sun,  4 Aug 2024 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753525; cv=none; b=KoiaLj/1AdFCoU0cTyyGfskKRmyDnImlfql4fRaLI0Q+TU7lQllKsHVJ8Qeblp3lih74MCf/3ky8YQpyNngX8c1r+UJm/6vKAufY5eZBAh9k77UsN9i/EwAJQoXCB3YU/Ed1RhJ6vRvw/R9LyqA7jYNmcaXvvAQdfbJmDsN9U3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753525; c=relaxed/simple;
	bh=yoPDnLVM27fwXbIiltLWTmZj0FW2IL7unSrVU7lOk5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd70eZY1Eoo1yOmYiAE3RKkYydB4qb4kjTuoqV50cs+0Ho2scw1rf7C4/Hi8kVX3Xy+fKZVuPR/FR7gpKYKO2loMF7F1U5rKYKlWB9zhyD080LrAoStUqePAzi27bkXt9zYIwnhUD75VYXePGsqxuoQvscFCfe9JSYDMmyo+ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.4.132])
	by gateway (Coremail) with SMTP id _____8DxSurxIa9m6GsHAA--.25734S3;
	Sun, 04 Aug 2024 14:38:41 +0800 (CST)
Received: from haword-linux.loongson.cn (unknown [10.20.4.132])
	by front1 (Coremail) with SMTP id qMiowMAxYeHuIa9mVqcCAA--.14675S3;
	Sun, 04 Aug 2024 14:38:41 +0800 (CST)
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
Subject: [PATCH v2 2/3] tty: serial: 8250: Add loongson uart driver support
Date: Sun,  4 Aug 2024 14:38:33 +0800
Message-ID: <20240804063834.70022-2-zhenghaowei@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804063834.70022-1-zhenghaowei@loongson.cn>
References: <20240804063834.70022-1-zhenghaowei@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxYeHuIa9mVqcCAA--.14675S3
X-CM-SenderInfo: x2kh0w5kdr4v3l6o00pqjv00gofq/1tbiAgETBGauHZgENgABsq
X-Coremail-Antispam: 1Uk129KBj93XoWxKryDCr1rXFyUJr17GF4xKrX_yoWfAFy7pF
	n0k390yrWjgF48u3y8Jr4YyF45ZwnFk342kFW7G34Ykr98t34kXrySkF90yr4kAFWkAryU
	ZF1UCFW7CF4UXrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
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

Presently, we have defined four parameters — 'fractional-division',
'invert-rts', 'invert-dtr', 'invert-cts', and 'invert-dsr' — which
will be employed as needed.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
---
 drivers/tty/serial/8250/8250_loongson.c | 208 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |   9 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   1 +
 5 files changed, 227 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c

diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
new file mode 100644
index 000000000000..eb16677f1dde
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2024 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/reset.h>
+
+#include "8250.h"
+
+struct loongson_uart_data {
+	struct reset_control *rst;
+	int line;
+	int mcr_invert;
+	int msr_invert;
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
+	port->flags		= UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	port->iotype		= UPIO_MEM;
+	port->regshift		= 0;
+	port->dev		= &pdev->dev;
+	port->type		= (unsigned long)device_get_match_data(&pdev->dev);
+	port->serial_in		= loongson_serial_in;
+	port->serial_out	= loongson_serial_out;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->membase = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!port->membase)
+		return -ENOMEM;
+
+	port->mapbase = res->start;
+	port->mapsize = resource_size(res);
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return -EINVAL;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	port->private_data = data;
+
+	if (device_property_read_bool(&pdev->dev, "fractional-division")) {
+		port->get_divisor = loongson_frac_get_divisor;
+		port->set_divisor = loongson_frac_set_divisor;
+	}
+
+	if (device_property_read_bool(&pdev->dev, "rts-invert"))
+		data->mcr_invert |= UART_MCR_RTS;
+
+	if (device_property_read_bool(&pdev->dev, "dtr-invert"))
+		data->mcr_invert |= UART_MCR_DTR;
+
+	if (device_property_read_bool(&pdev->dev, "cts-invert"))
+		data->msr_invert |= UART_MSR_CTS;
+
+	if (device_property_read_bool(&pdev->dev, "dsr-invert"))
+		data->msr_invert |= UART_MSR_DSR;
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
+	{.compatible = "loongson,ls7a-uart", .data = (void *)PORT_LOONGSON},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_platform_serial_table);
+
+static struct platform_driver loongson_uart_driver = {
+	.probe = loongson_uart_probe,
+	.remove = loongson_uart_remove,
+	.driver = {
+		.name = "ls7a-uart",
+		.pm = &loongson_uart_pm_ops,
+		.of_match_table = of_match_ptr(of_platform_serial_table),
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
index 47ff50763c04..a696afc4f8a8 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -568,6 +568,15 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_LOONGSON
+	tristate "Loongson 8250 serial port support"
+	default SERIAL_8250
+	depends on SERIAL_8250
+	depends on LOONGARCH || MIPS
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

