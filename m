Return-Path: <SRS0=SZDA=AZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F09C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727C320890
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGNJaT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgGNJaT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jul 2020 05:30:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0AAC061755
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 02:30:19 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGR-0002gz-W0; Tue, 14 Jul 2020 11:30:15 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvHGR-0004KM-KJ; Tue, 14 Jul 2020 11:30:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Rafael Gago Castano <rgc@hms.se>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] serial: imx: implement rts delaying for rs485
Date:   Tue, 14 Jul 2020 11:30:11 +0200
Message-Id: <20200714093012.21621-2-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714093012.21621-1-uwe@kleine-koenig.org>
References: <20200714093012.21621-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

This adds support for delays between assertion of RTS (which is supposed
to enable the rs485 transmitter) and sending as well as between the last
send char and deassertionof RTS.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 157 ++++++++++++++++++++++++++++++---------
 1 file changed, 121 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1265e8d86d8a..35866c113931 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -188,6 +188,13 @@ struct imx_uart_data {
 	enum imx_uart_type devtype;
 };
 
+enum imx_tx_state {
+	OFF,
+	WAIT_AFTER_RTS,
+	SEND,
+	WAIT_AFTER_SEND,
+};
+
 struct imx_port {
 	struct uart_port	port;
 	struct timer_list	timer;
@@ -224,6 +231,11 @@ struct imx_port {
 	unsigned int		dma_tx_nents;
 	unsigned int            saved_reg[10];
 	bool			context_saved;
+
+	enum imx_tx_state	tx_state;
+	unsigned long		tx_state_next_change;
+	struct timer_list	trigger_start_tx;
+	struct timer_list	trigger_stop_tx;
 };
 
 struct imx_port_ucrs {
@@ -427,7 +439,10 @@ static void imx_uart_start_rx(struct uart_port *port)
 static void imx_uart_stop_tx(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr1;
+	u32 ucr1, ucr4, usr2;
+
+	if (sport->tx_state == OFF)
+		return;
 
 	/*
 	 * We are maybe in the SMP context, so if the DMA TX thread is running
@@ -439,21 +454,46 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	ucr1 = imx_uart_readl(sport, UCR1);
 	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
-	/* in rs485 mode disable transmitter if shifter is empty */
-	if (port->rs485.flags & SER_RS485_ENABLED &&
-	    imx_uart_readl(sport, USR2) & USR2_TXDC) {
-		u32 ucr2 = imx_uart_readl(sport, UCR2), ucr4;
-		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
-			imx_uart_rts_active(sport, &ucr2);
-		else
-			imx_uart_rts_inactive(sport, &ucr2);
-		imx_uart_writel(sport, ucr2, UCR2);
+	usr2 = imx_uart_readl(sport, USR2);
+	if (!(usr2 & USR2_TXDC)) {
+		/* The shifter is still busy, so retry once TC triggers */
+		return;
+	}
 
-		imx_uart_start_rx(port);
+	ucr4 = imx_uart_readl(sport, UCR4);
+	ucr4 &= ~UCR4_TCEN;
+	imx_uart_writel(sport, ucr4, UCR4);
 
-		ucr4 = imx_uart_readl(sport, UCR4);
-		ucr4 &= ~UCR4_TCEN;
-		imx_uart_writel(sport, ucr4, UCR4);
+	/* in rs485 mode disable transmitter */
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (sport->tx_state == SEND) {
+			sport->tx_state = WAIT_AFTER_SEND;
+			sport->tx_state_next_change =
+				jiffies + DIV_ROUND_UP(port->rs485.delay_rts_after_send * HZ, 1000);
+		}
+
+		if (sport->tx_state == WAIT_AFTER_RTS ||
+		    (sport->tx_state == WAIT_AFTER_SEND &&
+		     time_after_eq(jiffies, sport->tx_state_next_change))) {
+			u32 ucr2;
+
+			del_timer(&sport->trigger_start_tx);
+
+			ucr2 = imx_uart_readl(sport, UCR2);
+			if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+				imx_uart_rts_active(sport, &ucr2);
+			else
+				imx_uart_rts_inactive(sport, &ucr2);
+			imx_uart_writel(sport, ucr2, UCR2);
+
+			imx_uart_start_rx(port);
+
+			sport->tx_state = OFF;
+		} else if (sport->tx_state == WAIT_AFTER_SEND) {
+			mod_timer(&sport->trigger_stop_tx, sport->tx_state_next_change);
+		}
+	} else {
+		sport->tx_state = OFF;
 	}
 }
 
@@ -651,28 +691,53 @@ static void imx_uart_start_tx(struct uart_port *port)
 	if (!sport->port.x_char && uart_circ_empty(&port->state->xmit))
 		return;
 
+	/*
+	 * We cannot simply do nothing here if sport->tx_state == SEND already
+	 * because UCR1_TXMPTYEN might already have been cleared in
+	 * imx_uart_stop_tx(), but tx_state is still SEND.
+	 */
+
 	if (port->rs485.flags & SER_RS485_ENABLED) {
-		u32 ucr2;
+		if (sport->tx_state == OFF) {
+			u32 ucr2 = imx_uart_readl(sport, UCR2);
+			if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+				imx_uart_rts_active(sport, &ucr2);
+			else
+				imx_uart_rts_inactive(sport, &ucr2);
+			imx_uart_writel(sport, ucr2, UCR2);
 
-		ucr2 = imx_uart_readl(sport, UCR2);
-		if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
-			imx_uart_rts_active(sport, &ucr2);
-		else
-			imx_uart_rts_inactive(sport, &ucr2);
-		imx_uart_writel(sport, ucr2, UCR2);
+			if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+				imx_uart_stop_rx(port);
 
-		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-			imx_uart_stop_rx(port);
+			sport->tx_state = WAIT_AFTER_RTS;
+			sport->tx_state_next_change =
+				jiffies + DIV_ROUND_UP(port->rs485.delay_rts_before_send * HZ, 1000);
+		}
 
-		/*
-		 * Enable transmitter and shifter empty irq only if DMA is off.
-		 * In the DMA case this is done in the tx-callback.
-		 */
-		if (!sport->dma_is_enabled) {
-			u32 ucr4 = imx_uart_readl(sport, UCR4);
-			ucr4 |= UCR4_TCEN;
-			imx_uart_writel(sport, ucr4, UCR4);
+		if (sport->tx_state == WAIT_AFTER_SEND ||
+		    (sport->tx_state == WAIT_AFTER_RTS &&
+		     time_after_eq(jiffies, sport->tx_state_next_change))) {
+
+			del_timer(&sport->trigger_stop_tx);
+			/*
+			 * Enable transmitter and shifter empty irq only if DMA
+			 * is off.  In the DMA case this is done in the
+			 * tx-callback.
+			 */
+			if (!sport->dma_is_enabled) {
+				u32 ucr4 = imx_uart_readl(sport, UCR4);
+				ucr4 |= UCR4_TCEN;
+				imx_uart_writel(sport, ucr4, UCR4);
+			}
+
+			sport->tx_state = SEND;
+
+		} else if (sport->tx_state == WAIT_AFTER_RTS) {
+			mod_timer(&sport->trigger_start_tx, sport->tx_state_next_change);
+			return;
 		}
+	} else {
+		sport->tx_state = SEND;
 	}
 
 	if (!sport->dma_is_enabled) {
@@ -1630,7 +1695,6 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (termios->c_cflag & CRTSCTS)
 		ucr2 &= ~UCR2_IRTS;
-
 	if (termios->c_cflag & CSTOPB)
 		ucr2 |= UCR2_STPB;
 	if (termios->c_cflag & PARENB) {
@@ -1857,10 +1921,6 @@ static int imx_uart_rs485_config(struct uart_port *port,
 	struct imx_port *sport = (struct imx_port *)port;
 	u32 ucr2;
 
-	/* unimplemented */
-	rs485conf->delay_rts_before_send = 0;
-	rs485conf->delay_rts_after_send = 0;
-
 	/* RTS is required to control the transmitter */
 	if (!sport->have_rtscts && !sport->have_rtsgpio)
 		rs485conf->flags &= ~SER_RS485_ENABLED;
@@ -2223,6 +2283,28 @@ static void imx_uart_probe_pdata(struct imx_port *sport,
 		sport->have_rtscts = 1;
 }
 
+static void imx_trigger_start_tx(struct timer_list *t)
+{
+	struct imx_port *sport = from_timer(sport, t, trigger_start_tx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	if (sport->tx_state == WAIT_AFTER_RTS)
+		imx_uart_start_tx(&sport->port);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
+static void imx_trigger_stop_tx(struct timer_list *t)
+{
+	struct imx_port *sport = from_timer(sport, t, trigger_stop_tx);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	if (sport->tx_state == WAIT_AFTER_SEND)
+		imx_uart_stop_tx(&sport->port);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+}
+
 static int imx_uart_probe(struct platform_device *pdev)
 {
 	struct imx_port *sport;
@@ -2369,6 +2451,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(sport->clk_ipg);
 
+	timer_setup(&sport->trigger_start_tx, imx_trigger_start_tx, 0);
+	timer_setup(&sport->trigger_stop_tx, imx_trigger_stop_tx, 0);
+
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
 	 * chips only have one interrupt.
-- 
2.27.0

