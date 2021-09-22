Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC116C43219
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A967E611C9
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhIVIBN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1AFF922261;
        Wed, 22 Sep 2021 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0q7yta0dPvXTe8HzO2yLvnyzlwGpdh2LoFXBcGlV3c=;
        b=r7mjDzabnrB+JaqK57dVxijGBX6OAV80D6eh+nuz4KeywDTdcoJZxJbksWUYk45yYW71jc
        UMXGUO5VUbb8HoJH2S0HjPSj42gj4aOHG7QXTXt97/kNs6dpV5DV7vdhLr+jaPSLfZYqwR
        gqAl4P35JgOJ08+QPPIdnREmqn1HJ6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297580;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0q7yta0dPvXTe8HzO2yLvnyzlwGpdh2LoFXBcGlV3c=;
        b=WQ4ltOiZz4qKYT15UasvdZYne+JoxVjubrymug92LlVIs3Rv7/j6xEZKmlQE8FwoFlzvHp
        f2QNAs4mLqqOvFCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFBAFA3B8B;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] mxser: store FCR state in mxser_port::FCR
Date:   Wed, 22 Sep 2021 09:59:38 +0200
Message-Id: <20210922075938.31390-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We force the FCR contents on many places in the code instead of writing
what was actually set in mxser_change_speed() (by ->activate() or
->set_serial_info()).

So introduce mxser_port::FCR to hold the proper contents and bitwise-OR
the value to what needs to be set on all those locations. That is,
clearing RX and/or TX FIFOs. Those flags are self-clearing, so no need
to set them to mxser_port::FCR.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4ce21cdb1ea5..93a95a135a71 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -249,6 +249,7 @@ struct mxser_port {
 	unsigned char x_char;	/* xon/xoff character */
 	u8 IER;			/* Interrupt Enable Register */
 	u8 MCR;			/* Modem control register */
+	u8 FCR;			/* FIFO control register */
 
 	bool ldisc_stop_rx;
 
@@ -562,7 +563,7 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned cflag, cval, fcr;
+	unsigned cflag, cval;
 
 	cflag = tty->termios.c_cflag;
 
@@ -600,25 +601,25 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	if (cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
 
-	fcr = 0;
+	info->FCR = 0;
 	if (info->board->must_hwid) {
-		fcr |= UART_FCR_ENABLE_FIFO |
+		info->FCR |= UART_FCR_ENABLE_FIFO |
 			MOXA_MUST_FCR_GDA_MODE_ENABLE;
 		mxser_set_must_fifo_value(info);
 	} else if (info->type != PORT_8250 && info->type != PORT_16450) {
-		fcr |= UART_FCR_ENABLE_FIFO;
+		info->FCR |= UART_FCR_ENABLE_FIFO;
 		switch (info->rx_high_water) {
 		case 1:
-			fcr |= UART_FCR_TRIGGER_1;
+			info->FCR |= UART_FCR_TRIGGER_1;
 			break;
 		case 4:
-			fcr |= UART_FCR_TRIGGER_4;
+			info->FCR |= UART_FCR_TRIGGER_4;
 			break;
 		case 8:
-			fcr |= UART_FCR_TRIGGER_8;
+			info->FCR |= UART_FCR_TRIGGER_8;
 			break;
 		default:
-			fcr |= UART_FCR_TRIGGER_14;
+			info->FCR |= UART_FCR_TRIGGER_14;
 			break;
 		}
 	}
@@ -679,7 +680,7 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	}
 
 
-	outb(fcr, info->ioaddr + UART_FCR);	/* set fcr */
+	outb(info->FCR, info->ioaddr + UART_FCR);
 	outb(cval, info->ioaddr + UART_LCR);
 }
 
@@ -865,7 +866,7 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 	spin_lock_irqsave(&info->slock, flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
-	outb(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+	outb(info->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		info->ioaddr + UART_FCR);
 
 	spin_unlock_irqrestore(&info->slock, flags);
@@ -1572,8 +1573,7 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 
 		ch = inb(port->ioaddr + UART_RX);
 		if (hwid && (status & UART_LSR_OE))
-			outb(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
-					MOXA_MUST_FCR_GDA_MODE_ENABLE,
+			outb(port->FCR | UART_FCR_CLEAR_RCVR,
 					port->ioaddr + UART_FCR);
 		status &= port->read_status_mask;
 		if (status & port->ignore_status_mask) {
@@ -1685,8 +1685,7 @@ static bool mxser_port_isr(struct mxser_port *port)
 	tty = tty_port_tty_get(&port->port);
 	if (!tty || port->closing || !tty_port_initialized(&port->port)) {
 		status = inb(port->ioaddr + UART_LSR);
-		outb(MOXA_MUST_FCR_GDA_MODE_ENABLE | UART_FCR_ENABLE_FIFO |
-				UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		outb(port->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 				port->ioaddr + UART_FCR);
 		inb(port->ioaddr + UART_MSR);
 
-- 
2.33.0

