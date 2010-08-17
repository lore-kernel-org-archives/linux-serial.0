From: Michal Simek <monstr@monstr.eu>
Subject: [PATCH] serial: Add CONSOLE_POLL support for uartlite
Date: Tue, 17 Aug 2010 10:42:05 +0200
Message-ID: <1282034525-19207-2-git-send-email-monstr@monstr.eu>
References: <1282034525-19207-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282034525-19207-1-git-send-email-monstr@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Jason Wessel <jason.wessel@windriver.com>
List-Id: linux-serial@vger.kernel.org

CONSOLE_POLL support for uartlite enables
KGDB debugging over serial line.

Signed-off-by: Michal Simek <monstr@monstr.eu>
Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 drivers/serial/uartlite.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 9b03d7b..c0fae0d 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -322,6 +322,26 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int ulite_get_poll_char(struct uart_port *port)
+{
+	while (!(ioread32be(port->membase + ULITE_STATUS)
+						& ULITE_STATUS_RXVALID))
+		return NO_POLL_CHAR;
+
+	return ioread32be(port->membase + ULITE_RX);
+}
+
+static void ulite_put_poll_char(struct uart_port *port, unsigned char ch)
+{
+	while (ioread32be(port->membase + ULITE_STATUS) & ULITE_STATUS_TXFULL)
+		cpu_relax();
+
+	/* write char to device */
+	iowrite32be(ch, port->membase + ULITE_TX);
+}
+#endif
+
 static struct uart_ops ulite_ops = {
 	.tx_empty	= ulite_tx_empty,
 	.set_mctrl	= ulite_set_mctrl,
@@ -338,7 +358,11 @@ static struct uart_ops ulite_ops = {
 	.release_port	= ulite_release_port,
 	.request_port	= ulite_request_port,
 	.config_port	= ulite_config_port,
-	.verify_port	= ulite_verify_port
+	.verify_port	= ulite_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= ulite_get_poll_char,
+	.poll_put_char	= ulite_put_poll_char,
+#endif
 };
 
 /* ---------------------------------------------------------------------
-- 
1.5.5.6
