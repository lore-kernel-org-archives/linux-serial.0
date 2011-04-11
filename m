From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial/imx: read cts state only after acking cts change irq
Date: Mon, 11 Apr 2011 10:59:09 +0200
Message-ID: <1302512349-14923-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52635 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1DKI7V (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Apr 2011 04:59:21 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de

If cts changes between reading the level at the cts input (USR1_RTSS)
and acking the irq (USR1_RTSD) the last edge doesn't generate an irq an=
d
uart_handle_cts_change is called with a outdated value for cts.

The race was introduced by commit

	ceca629 ([ARM] 2971/1: i.MX uart handle rts irq)

Reported-by: Arwed Springer <Arwed.Springer@de.trumpf.com>
Tested-by: Arwed Springer <Arwed.Springer@de.trumpf.com>
Cc: stable@kernel.org # 2.6.14+
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dfcf4b1..0d66751 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -382,12 +382,13 @@ static void imx_start_tx(struct uart_port *port)
 static irqreturn_t imx_rtsint(int irq, void *dev_id)
 {
 	struct imx_port *sport =3D dev_id;
-	unsigned int val =3D readl(sport->port.membase + USR1) & USR1_RTSS;
+	unsigned int val;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&sport->port.lock, flags);
=20
 	writel(USR1_RTSD, sport->port.membase + USR1);
+	val =3D readl(sport->port.membase + USR1) & USR1_RTSS;
 	uart_handle_cts_change(&sport->port, !!val);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
=20
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
