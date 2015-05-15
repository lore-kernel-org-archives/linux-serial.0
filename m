From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] serial: 8250: add LPC18xx/43xx UART driver
Date: Fri, 15 May 2015 20:29:14 +0200
Message-ID: <1431714555-7063-2-git-send-email-manabian@gmail.com>
References: <1431714555-7063-1-git-send-email-manabian@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431714555-7063-1-git-send-email-manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Serial port driver for the 8250-based UART found on LPC18xx/43xx
devices. The UART is 16550A compatible with additional features
like RS485 support, synchronous mode, IrDA, and DMA.

For now only basic UART and RS485 operation is supported.

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 204 +++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig        |   8 ++
 drivers/tty/serial/8250/Makefile       |   1 +
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_lpc18xx.c

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
new file mode 100644
index 000000000000..207c9f04a335
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -0,0 +1,204 @@
+/*
+ * Serial port driver for NXP LPC18xx/43xx UART
+ *
+ * Copyright (C) 2014 Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * Based on 8250_mtk.c:
+ * Copyright (c) 2014 MundoReader S.L.
+ * Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+#include <linux/serial_reg.h>
+
+#include "8250.h"
+
+/* Additional LPC18xx/43xx 8250 registers and bits */
+#define LPC18XX_UART_RS485CTRL		(0x04c / sizeof(u32))
+#define  LPC18XX_UART_RS485CTRL_NMMEN	BIT(0)
+#define  LPC18XX_UART_RS485CTRL_DCTRL	BIT(4)
+#define  LPC18XX_UART_RS485CTRL_OINV	BIT(5)
+#define LPC18XX_UART_RS485DLY		(0x054 / sizeof(u32))
+#define  LPC18XX_UART_RS485DLY_MAX	255
+
+struct lpc18xx_uart_data {
+	struct clk *clk_uart;
+	struct clk *clk_reg;
+	int line;
+};
+
+static int lpc18xx_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 rs485_ctrl_reg = 0;
+	u32 rs485_dly_reg = 0;
+	unsigned baud_clk;
+
+	if (rs485->flags & SER_RS485_ENABLED)
+		memset(rs485->padding, 0, sizeof(rs485->padding));
+	else
+		memset(rs485, 0, sizeof(*rs485));
+
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+			SER_RS485_RTS_AFTER_SEND;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		rs485_ctrl_reg |= LPC18XX_UART_RS485CTRL_NMMEN |
+				  LPC18XX_UART_RS485CTRL_DCTRL;
+
+		if (rs485->flags & SER_RS485_RTS_ON_SEND) {
+			rs485_ctrl_reg |= LPC18XX_UART_RS485CTRL_OINV;
+			rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+		} else {
+			rs485->flags |= SER_RS485_RTS_AFTER_SEND;
+		}
+	}
+
+	if (rs485->delay_rts_after_send) {
+		baud_clk = port->uartclk / up->dl_read(up);
+		rs485_dly_reg = DIV_ROUND_UP(rs485->delay_rts_after_send
+						* baud_clk, MSEC_PER_SEC);
+
+		if (rs485_dly_reg > LPC18XX_UART_RS485DLY_MAX)
+			rs485_dly_reg = LPC18XX_UART_RS485DLY_MAX;
+
+		/* Calculate the resulting delay in ms */
+		rs485->delay_rts_after_send = (rs485_dly_reg * MSEC_PER_SEC)
+						/ baud_clk;
+	}
+
+	/* Delay RTS before send not supported */
+	rs485->delay_rts_before_send = 0;
+
+	serial_out(up, LPC18XX_UART_RS485CTRL, rs485_ctrl_reg);
+	serial_out(up, LPC18XX_UART_RS485DLY, rs485_dly_reg);
+
+	port->rs485 = *rs485;
+
+	return 0;
+}
+
+static int lpc18xx_serial_probe(struct platform_device *pdev)
+{
+	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	struct lpc18xx_uart_data *data;
+	struct uart_8250_port uart;
+	int ret;
+
+	if (!regs || !irq) {
+		dev_err(&pdev->dev, "no registers/irq defined\n");
+		return -EINVAL;
+	}
+
+	memset(&uart, 0, sizeof(uart));
+
+	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
+					 resource_size(regs));
+	if (!uart.port.membase)
+		return -ENOMEM;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->clk_uart = devm_clk_get(&pdev->dev, "uartclk");
+	if (IS_ERR(data->clk_uart)) {
+		dev_err(&pdev->dev, "uart clock not found\n");
+		return PTR_ERR(data->clk_uart);
+	}
+
+	data->clk_reg = devm_clk_get(&pdev->dev, "reg");
+	if (IS_ERR(data->clk_reg)) {
+		dev_err(&pdev->dev, "reg clock not found\n");
+		return PTR_ERR(data->clk_reg);
+	}
+
+	ret = clk_prepare_enable(data->clk_reg);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable reg clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(data->clk_uart);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable uart clock\n");
+		goto dis_clk_reg;
+	}
+
+	ret = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (ret >= 0)
+		uart.port.line = ret;
+
+	spin_lock_init(&uart.port.lock);
+	uart.port.dev = &pdev->dev;
+	uart.port.irq = irq->start;
+	uart.port.mapbase = regs->start;
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.regshift = 2;
+	uart.port.type = PORT_16550A;
+	uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SKIP_TEST;
+	uart.port.uartclk = clk_get_rate(data->clk_uart);
+	uart.port.private_data = data;
+	uart.port.rs485_config = lpc18xx_rs485_config;
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to register 8250 port\n");
+		goto dis_uart_clk;
+	}
+
+	data->line = ret;
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+
+dis_uart_clk:
+	clk_disable_unprepare(data->clk_uart);
+dis_clk_reg:
+	clk_disable_unprepare(data->clk_reg);
+	return ret;
+}
+
+static int lpc18xx_serial_remove(struct platform_device *pdev)
+{
+	struct lpc18xx_uart_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	clk_disable_unprepare(data->clk_uart);
+	clk_disable_unprepare(data->clk_reg);
+
+	return 0;
+}
+
+static const struct of_device_id lpc18xx_serial_match[] = {
+	{ .compatible = "nxp,lpc1850-uart" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_serial_match);
+
+static struct platform_driver lpc18xx_serial_driver = {
+	.probe  = lpc18xx_serial_probe,
+	.remove = lpc18xx_serial_remove,
+	.driver = {
+		.name = "lpc18xx-uart",
+		.of_match_table = lpc18xx_serial_match,
+	},
+};
+module_platform_driver(lpc18xx_serial_driver);
+
+MODULE_AUTHOR("Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("Serial port driver NXP LPC18xx/43xx devices");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index c35070356528..46f25fb8fbab 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -336,6 +336,14 @@ config SERIAL_8250_FINTEK
 	  LPC to 4 UART. This device has some RS485 functionality not available
 	  through the PNP driver. If unsure, say N.
 
+config SERIAL_8250_LPC18XX
+	bool "NXP LPC18xx/43xx serial port support"
+	depends on SERIAL_8250 && OF && (ARCH_LPC18XX || COMPILE_TEST)
+	default ARCH_LPC18XX
+	help
+	  If you have a LPC18xx/43xx based board and want to use the
+	  serial port, say Y to this option. If unsure, say Y.
+
 config SERIAL_8250_MT6577
 	bool "Mediatek serial port support"
 	depends on SERIAL_8250 && ARCH_MEDIATEK
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 31e7cdc6865c..74d7c311cf4f 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -22,4 +22,5 @@ obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
 obj-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
+obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
 obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
