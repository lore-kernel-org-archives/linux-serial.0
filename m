From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Date: Mon, 28 Jan 2019 17:19:35 +0800
Message-ID: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 15a8c8d..1999e3b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -145,6 +145,10 @@ EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
 OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
 		    ingenic_early_console_setup);
 
+EARLYCON_DECLARE(x1000_uart, ingenic_early_console_setup);
+OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
+		    ingenic_early_console_setup);
+
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
 	int ier;
@@ -328,12 +332,18 @@ static const struct ingenic_uart_config jz4780_uart_config = {
 	.fifosize = 64,
 };
 
+static const struct ingenic_uart_config x1000_uart_config = {
+	.tx_loadsz = 32,
+	.fifosize = 64,
+};
+
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
+	{ .compatible = "ingenic,x1000-uart", .data = &x1000_uart_config },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match);
-- 
2.7.4
