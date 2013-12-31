From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: clps711x: Add support for N_IRDA line discipline
Date: Tue, 31 Dec 2013 20:49:41 +0400
Message-ID: <1388508582-13094-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp45.i.mail.ru ([94.100.177.105]:48668 "EHLO smtp45.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab3LaQty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Dec 2013 11:49:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch replace custom handling of IrDA feature with N_IRDA
line discipline, so IrDA mode can be used with irtty driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/serial/cirrus,clps711x-uart.txt         |  1 -
 drivers/tty/serial/clps711x.c                        | 20 ++++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
index 8bbdd21..12f3cf8 100644
--- a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
+++ b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
@@ -9,7 +9,6 @@ Required properties:
 
 Optional properties:
 - uart-use-ms: Indicate the UART has modem signal (DCD, DSR, CTS).
-- uart-use-irda: Indicate the UART use IRDA mode.
 
 Note: Each UART port should have an alias correctly numbered
 in "aliases" node.
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 4f59f1c..5a931f9 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -232,6 +232,16 @@ static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
 	writel_relaxed(ubrlcr, port->membase + UBRLCR_OFFSET);
 }
 
+static void uart_clps711x_set_ldisc(struct uart_port *port, int ld)
+{
+	if (!port->line) {
+		struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+		regmap_update_bits(s->syscon, SYSCON_OFFSET, SYSCON1_SIREN,
+				   (ld == N_IRDA) ? SYSCON1_SIREN : 0);
+	}
+}
+
 static int uart_clps711x_startup(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
@@ -342,6 +352,7 @@ static const struct uart_ops uart_clps711x_ops = {
 	.stop_rx	= uart_clps711x_nop_void,
 	.enable_ms	= uart_clps711x_nop_void,
 	.break_ctl	= uart_clps711x_break_ctl,
+	.set_ldisc	= uart_clps711x_set_ldisc,
 	.startup	= uart_clps711x_startup,
 	.shutdown	= uart_clps711x_shutdown,
 	.set_termios	= uart_clps711x_set_termios,
@@ -482,15 +493,8 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 		if (IS_ERR(s->syscon))
 			return PTR_ERR(s->syscon);
 
-		if (!index) {
-			bool use_irda;
-
+		if (!index)
 			s->use_ms = of_property_read_bool(np, "uart-use-ms");
-			use_irda = of_property_read_bool(np, "uart-use-irda");
-			regmap_update_bits(s->syscon, SYSCON_OFFSET,
-					   SYSCON1_SIREN,
-					   use_irda ? SYSCON1_SIREN : 0);
-		}
 	}
 
 	s->port.line		= index;
-- 
1.8.3.2

