From: Juergen Borleis <jbe@pengutronix.de>
Subject: [PATCH v4 1/2] serial: mxs-auart: use a function name to reflect what it really does
Date: Fri,  7 Aug 2015 12:47:03 +0200
Message-ID: <1438944424-9053-1-git-send-email-jbe@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

This function clears the reset the AUART unit is in after system start
to make it work.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 13cf773..7dc87a9 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -842,7 +842,7 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
-static void mxs_auart_reset(struct uart_port *u)
+static void mxs_auart_reset_deassert(struct uart_port *u)
 {
 	int i;
 	unsigned int reg;
@@ -1291,7 +1291,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	auart_port[s->port.line] = s;
 
-	mxs_auart_reset(&s->port);
+	mxs_auart_reset_deassert(&s->port);
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-- 
2.4.6
