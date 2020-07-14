Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C5C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22772075F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgGNJaU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgGNJaT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 05:30:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E65C061794
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 02:30:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGS-0002h3-4X; Tue, 14 Jul 2020 11:30:16 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGR-0004KP-Qr; Tue, 14 Jul 2020 11:30:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Rafael Gago Castano <rgc@hms.se>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH 2/2] serial: imx: use hrtimers for rs485 delays
Date:   Tue, 14 Jul 2020 11:30:12 +0200
Message-Id: <20200714093012.21621-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714093012.21621-1-uwe@kleine-koenig.org>
References: <20200714093012.21621-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

This patch imitates 6e0a5de213 ("serial: 8250: Use hrtimers for
rs485 delays") in replacing the previously used classic timers
with hrtimers. The old way provided a too coarse resolution on
systems with configs of less than 1000 HZ.

Use of hrtimers addresses this and can be easily extended to
support microsecond resolution in future when support
for this arrives upstream.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/tty/serial/imx.c | 62 +++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 35866c113931..c67dd77dfbc1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -20,6 +20,7 @@
 #include <linux/serial.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/ktime.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
@@ -233,9 +234,8 @@ struct imx_port {
 	bool			context_saved;
 
 	enum imx_tx_state	tx_state;
-	unsigned long		tx_state_next_change;
-	struct timer_list	trigger_start_tx;
-	struct timer_list	trigger_stop_tx;
+	struct hrtimer		trigger_start_tx;
+	struct hrtimer		trigger_stop_tx;
 };
 
 struct imx_port_ucrs {
@@ -412,6 +412,15 @@ static void imx_uart_rts_inactive(struct imx_port *sport, u32 *ucr2)
 	mctrl_gpio_set(sport->gpios, sport->port.mctrl);
 }
 
+static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
+{
+       long sec = msec / MSEC_PER_SEC;
+       long nsec = (msec % MSEC_PER_SEC) * 1000000;
+       ktime_t t = ktime_set(sec, nsec);
+
+       hrtimer_start(hrt, t, HRTIMER_MODE_REL);
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_start_rx(struct uart_port *port)
 {
@@ -468,16 +477,16 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		if (sport->tx_state == SEND) {
 			sport->tx_state = WAIT_AFTER_SEND;
-			sport->tx_state_next_change =
-				jiffies + DIV_ROUND_UP(port->rs485.delay_rts_after_send * HZ, 1000);
+			start_hrtimer_ms(&sport->trigger_stop_tx,
+					 port->rs485.delay_rts_after_send);
+			return;
 		}
 
 		if (sport->tx_state == WAIT_AFTER_RTS ||
-		    (sport->tx_state == WAIT_AFTER_SEND &&
-		     time_after_eq(jiffies, sport->tx_state_next_change))) {
+		    sport->tx_state == WAIT_AFTER_SEND) {
 			u32 ucr2;
 
-			del_timer(&sport->trigger_start_tx);
+			hrtimer_try_to_cancel(&sport->trigger_start_tx);
 
 			ucr2 = imx_uart_readl(sport, UCR2);
 			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
@@ -489,8 +498,6 @@ static void imx_uart_stop_tx(struct uart_port *port)
 			imx_uart_start_rx(port);
 
 			sport->tx_state = OFF;
-		} else if (sport->tx_state == WAIT_AFTER_SEND) {
-			mod_timer(&sport->trigger_stop_tx, sport->tx_state_next_change);
 		}
 	} else {
 		sport->tx_state = OFF;
@@ -710,15 +717,16 @@ static void imx_uart_start_tx(struct uart_port *port)
 				imx_uart_stop_rx(port);
 
 			sport->tx_state = WAIT_AFTER_RTS;
-			sport->tx_state_next_change =
-				jiffies + DIV_ROUND_UP(port->rs485.delay_rts_before_send * HZ, 1000);
+			start_hrtimer_ms(&sport->trigger_start_tx,
+					 port->rs485.delay_rts_before_send);
+			return;
 		}
 
-		if (sport->tx_state == WAIT_AFTER_SEND ||
-		    (sport->tx_state == WAIT_AFTER_RTS &&
-		     time_after_eq(jiffies, sport->tx_state_next_change))) {
+		if (sport->tx_state == WAIT_AFTER_SEND
+		    || sport->tx_state == WAIT_AFTER_RTS) {
+
+			hrtimer_try_to_cancel(&sport->trigger_stop_tx);
 
-			del_timer(&sport->trigger_stop_tx);
 			/*
 			 * Enable transmitter and shifter empty irq only if DMA
 			 * is off.  In the DMA case this is done in the
@@ -731,10 +739,6 @@ static void imx_uart_start_tx(struct uart_port *port)
 			}
 
 			sport->tx_state = SEND;
-
-		} else if (sport->tx_state == WAIT_AFTER_RTS) {
-			mod_timer(&sport->trigger_start_tx, sport->tx_state_next_change);
-			return;
 		}
 	} else {
 		sport->tx_state = SEND;
@@ -2283,26 +2287,30 @@ static void imx_uart_probe_pdata(struct imx_port *sport,
 		sport->have_rtscts = 1;
 }
 
-static void imx_trigger_start_tx(struct timer_list *t)
+static enum hrtimer_restart imx_trigger_start_tx(struct hrtimer *t)
 {
-	struct imx_port *sport = from_timer(sport, t, trigger_start_tx);
+	struct imx_port *sport = container_of(t, struct imx_port, trigger_start_tx);
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->tx_state == WAIT_AFTER_RTS)
 		imx_uart_start_tx(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
-static void imx_trigger_stop_tx(struct timer_list *t)
+static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 {
-	struct imx_port *sport = from_timer(sport, t, trigger_stop_tx);
+	struct imx_port *sport = container_of(t, struct imx_port, trigger_stop_tx);
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	if (sport->tx_state == WAIT_AFTER_SEND)
 		imx_uart_stop_tx(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 static int imx_uart_probe(struct platform_device *pdev)
@@ -2451,8 +2459,10 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(sport->clk_ipg);
 
-	timer_setup(&sport->trigger_start_tx, imx_trigger_start_tx, 0);
-	timer_setup(&sport->trigger_stop_tx, imx_trigger_stop_tx, 0);
+	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	sport->trigger_start_tx.function = imx_trigger_start_tx;
+	sport->trigger_stop_tx.function = imx_trigger_stop_tx;
 
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
-- 
2.27.0

