From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 2/2] serial: atmel: add support for new UART version
Date: Mon, 25 Jan 2016 18:38:02 +0100
Message-ID: <93f5f783fd232d9dfe99e7d6f1fdc6c92adb7c46.1453743308.git.nicolas.ferre@atmel.com>
References: <198abfa682d5a39758599d34d1c5b9fd2858cedc.1453743308.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <198abfa682d5a39758599d34d1c5b9fd2858cedc.1453743308.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, davidm@egauge.net, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-serial@vger.kernel.org

Starting with sama5d2, the new UART revision has an hardware timer. So, add it
to the IP detection code and set the "has_hw_timer" property for it.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reported-by: David Mosberger <davidm@egauge.net>
---
 drivers/tty/serial/atmel_serial.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index de5d32c31179..fab135824679 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1714,11 +1714,12 @@ static void atmel_get_ip_name(struct uart_port *port)
 	/* ASCII decoding for IP version */
 	usart = 0x55534152;	/* USAR(T) */
 	dbgu_uart = 0x44424755;	/* DBGU */
+	new_uart = 0x55415254;	/* UART */
 
 	atmel_port->has_hw_timer = false;
 
-	if (name == usart) {
-		dev_dbg(port->dev, "Usart with hw timer\n");
+	if (name == usart || name == new_uart) {
+		dev_dbg(port->dev, "Usart or uart with hw timer\n");
 		atmel_port->has_hw_timer = true;
 	} else if (name == dbgu_uart) {
 		dev_dbg(port->dev, "Dbgu or uart without hw timer\n");
-- 
2.1.3
