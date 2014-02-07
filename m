From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 5/6] serial: max310x: Add the loopback mode support
Date: Fri,  7 Feb 2014 18:16:07 +0400
Message-ID: <1391782568-19442-6-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.176.18]:59567 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbaBGOQl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:41 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback1.mail.ru (mPOP.Fallback_MX) with ESMTP id B100E33A7EFB
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:39 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch replaces loopback mode support from platform data to
dynamic setup with TIOCMSET ioctl.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c          | 25 ++++++++++++++++++-------
 include/linux/platform_data/max310x.h |  1 -
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 1fb3895..3c93814 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -283,6 +283,7 @@ struct max310x_devtype {
 struct max310x_one {
 	struct uart_port	port;
 	struct work_struct	tx_work;
+	struct work_struct	md_work;
 };
 
 struct max310x_port {
@@ -790,11 +791,21 @@ static unsigned int max310x_get_mctrl(struct uart_port *port)
 	return TIOCM_DSR | TIOCM_CAR;
 }
 
+static void max310x_md_proc(struct work_struct *ws)
+{
+	struct max310x_one *one = container_of(ws, struct max310x_one, md_work);
+
+	max310x_port_update(&one->port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_LOOPBACK_BIT,
+			    (one->port.mctrl & TIOCM_LOOP) ?
+			    MAX310X_MODE2_LOOPBACK_BIT : 0);
+}
+
 static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* DCD and DSR are not wired and CTS/RTS is hadnled automatically
-	 * so do nothing
-	 */
+	struct max310x_one *one = container_of(port, struct max310x_one, port);
+
+	schedule_work(&one->md_work);
 }
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
@@ -904,8 +915,6 @@ static int max310x_startup(struct uart_port *port)
 
 	/* Configure MODE2 register */
 	val = MAX310X_MODE2_RXEMPTINV_BIT;
-	if (s->pdata->uart_flags[line] & MAX310X_LOOPBACK)
-		val |= MAX310X_MODE2_LOOPBACK_BIT;
 	if (s->pdata->uart_flags[line] & MAX310X_ECHO_SUPRESS)
 		val |= MAX310X_MODE2_ECHOSUPR_BIT;
 
@@ -1176,8 +1185,7 @@ static int max310x_probe(struct device *dev, int is_spi,
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_MAX310X;
 		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
-		s->p[i].port.flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE |
-					  UPF_LOW_LATENCY;
+		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.iobase	= i * 0x20;
 		s->p[i].port.membase	= (void __iomem *)~0;
@@ -1193,6 +1201,8 @@ static int max310x_probe(struct device *dev, int is_spi,
 				    MAX310X_MODE1_IRQSEL_BIT);
 		/* Initialize queue for start TX */
 		INIT_WORK(&s->p[i].tx_work, max310x_wq_proc);
+		/* Initialize queue for changing mode */
+		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Register port */
 		uart_add_one_port(&s->uart, &s->p[i].port);
 		/* Go to suspend mode */
@@ -1244,6 +1254,7 @@ static int max310x_remove(struct device *dev)
 
 	for (i = 0; i < s->uart.nr; i++) {
 		cancel_work_sync(&s->p[i].tx_work);
+		cancel_work_sync(&s->p[i].md_work);
 		uart_remove_one_port(&s->uart, &s->p[i].port);
 		s->devtype->power(&s->p[i].port, 0);
 	}
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 5f4b35d..9d5f69b 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -46,7 +46,6 @@ struct max310x_pdata {
 #define MAX310X_EXT_CLK		(0x00000001)	/* External clock enable */
 	/* Flags global to UART port */
 	const u8		uart_flags[MAX310X_MAX_UARTS];
-#define MAX310X_LOOPBACK	(0x00000001)	/* Loopback mode enable */
 #define MAX310X_ECHO_SUPRESS	(0x00000002)	/* Enable echo supress */
 #define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction
 						 * control (RS-485)
-- 
1.8.3.2

