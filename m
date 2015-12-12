From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v5 3/3] tty: 8250_omap: Use software emulated RS485 direction control
Date: Sat, 12 Dec 2015 14:23:36 +0300
Message-ID: <1449919416-1980-4-git-send-email-matwey@sai.msu.ru>
References: <1449919416-1980-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449919416-1980-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use software emulated RS485 direction control to provide RS485 API existed in
omap_serial driver. Note that 8250_omap issues interrupt on shift register
empty which is single prerequesite for using software emulated RS485.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_omap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 826c5c4..323c0a4 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -698,6 +698,23 @@ static void omap_8250_throttle(struct uart_port *port)
 	pm_runtime_put_autosuspend(port->dev);
 }
 
+static int omap_8250_rs485_config(struct uart_port *port, struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (rs485->flags & SER_RS485_ENABLED && !serial8250_em485_enabled(up)) {
+		port->rs485 = *rs485;
+		return serial8250_em485_init(up);
+	}
+
+	if (serial8250_em485_enabled(up) && !(rs485->flags & SER_RS485_ENABLED))
+		serial8250_em485_destroy(up);
+
+	port->rs485 = *rs485;
+
+	return 0;
+}
+
 static void omap_8250_unthrottle(struct uart_port *port)
 {
 	unsigned long flags;
@@ -1144,6 +1161,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.shutdown = omap_8250_shutdown;
 	up.port.throttle = omap_8250_throttle;
 	up.port.unthrottle = omap_8250_unthrottle;
+	up.port.rs485_config = omap_8250_rs485_config;
 
 	if (pdev->dev.of_node) {
 		const struct of_device_id *id;
-- 
2.6.3
