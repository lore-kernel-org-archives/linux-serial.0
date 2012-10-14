From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 10/12] serial: clps711x: Disable "break"-state before port startup
Date: Sun, 14 Oct 2012 11:05:32 +0400
Message-ID: <1350198334-18737-10-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:46955 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:33 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   29 +++++++----------------------
 1 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 7cf3928..e715087 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -231,7 +231,6 @@ static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
 static int clps711xuart_startup(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	unsigned int syscon;
 	int ret;
 
 	s->tx_enabled[port->line] = 1;
@@ -248,37 +247,23 @@ static int clps711xuart_startup(struct uart_port *port)
 		return ret;
 	}
 
-	/*
-	 * enable the port
-	 */
-	syscon = clps_readl(SYSCON(port));
-	syscon |= SYSCON_UARTEN;
-	clps_writel(syscon, SYSCON(port));
+	/* Disable break */
+	clps_writel(clps_readl(UBRLCR(port)) & ~UBRLCR_BREAK, UBRLCR(port));
+
+	/* Enable the port */
+	clps_writel(clps_readl(SYSCON(port)) | SYSCON_UARTEN, SYSCON(port));
 
 	return 0;
 }
 
 static void clps711xuart_shutdown(struct uart_port *port)
 {
-	unsigned int ubrlcr, syscon;
-
 	/* Free the interrupts */
 	devm_free_irq(port->dev, TX_IRQ(port), port);
 	devm_free_irq(port->dev, RX_IRQ(port), port);
 
-	/*
-	 * disable the port
-	 */
-	syscon = clps_readl(SYSCON(port));
-	syscon &= ~SYSCON_UARTEN;
-	clps_writel(syscon, SYSCON(port));
-
-	/*
-	 * disable break condition and fifos
-	 */
-	ubrlcr = clps_readl(UBRLCR(port));
-	ubrlcr &= ~(UBRLCR_FIFOEN | UBRLCR_BREAK);
-	clps_writel(ubrlcr, UBRLCR(port));
+	/* Disable the port */
+	clps_writel(clps_readl(SYSCON(port)) & ~SYSCON_UARTEN, SYSCON(port));
 }
 
 static void
-- 
1.7.8.6

