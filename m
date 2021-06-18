Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9606CC48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE8B611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhFRGS5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhFRGR4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0FC321AC6;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzoRpp5oKpyTVhgKESNf8IQ9VyNnVjv8sjeTYvfaoIc=;
        b=TdAVhe8ezkc8W5GR4dT3aFaMNq5M0G3eugQtR46weXzxA0GdC2+sOgFUJL4Dxjdv2+/wyG
        GUncEkvQuNImp+G2WzTQpq/leOT4CXIK94JNeXeeK+UlsfSNDYCaH1WIqtfLcyf56vTgti
        jDvYsiYKCsHzm8asEH/453Qe4wb9mTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EzoRpp5oKpyTVhgKESNf8IQ9VyNnVjv8sjeTYvfaoIc=;
        b=BPdpzOnO72b5wO4K6w+jEbhwaHtxMwVBFzo9grBn9xiqVprLUeIqZy39xMa8rF1c8TZMjx
        oYw/Y5RLzCrGUjAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E0C6A3B9F;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 59/70] mxser: introduce and use start/stop_tx helpers
Date:   Fri, 18 Jun 2021 08:15:05 +0200
Message-Id: <20210618061516.662-60-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Starting and stopping TX is performed on many places in the driver. It
is repeated outb and info->IER modification.  Create few helpers
(__mxser_start_tx, mxser_start_tx, __mxser_stop_tx) and use them in the
code instead of open coding.

This should be a base for an uart driver for this device in the future.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 80 +++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 00363d98277e..e46974e9421a 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -418,6 +418,28 @@ static void mxser_process_txrx_fifo(struct mxser_port *info)
 		}
 }
 
+static void __mxser_start_tx(struct mxser_port *info)
+{
+	outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
+	info->IER |= UART_IER_THRI;
+	outb(info->IER, info->ioaddr + UART_IER);
+}
+
+static void mxser_start_tx(struct mxser_port *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->slock, flags);
+	__mxser_start_tx(info);
+	spin_unlock_irqrestore(&info->slock, flags);
+}
+
+static void __mxser_stop_tx(struct mxser_port *info)
+{
+	info->IER &= ~UART_IER_THRI;
+	outb(info->IER, info->ioaddr + UART_IER);
+}
+
 static int mxser_carrier_raised(struct tty_port *port)
 {
 	struct mxser_port *mp = container_of(port, struct mxser_port, port);
@@ -516,12 +538,8 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 			tty->hw_stopped = 0;
 
 			if (info->type != PORT_16550A &&
-					!info->board->must_hwid) {
-				outb(info->IER & ~UART_IER_THRI,
-					info->ioaddr + UART_IER);
-				info->IER |= UART_IER_THRI;
-				outb(info->IER, info->ioaddr + UART_IER);
-			}
+					!info->board->must_hwid)
+				__mxser_start_tx(info);
 			tty_wakeup(tty);
 		}
 		return;
@@ -529,10 +547,8 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 		return;
 
 	tty->hw_stopped = 1;
-	if (info->type != PORT_16550A && !info->board->must_hwid) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->ioaddr + UART_IER);
-	}
+	if (info->type != PORT_16550A && !info->board->must_hwid)
+		__mxser_stop_tx(info);
 }
 
 /*
@@ -947,16 +963,9 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 	}
 
 	if (info->xmit_cnt && !tty->flow.stopped) {
-		if (!tty->hw_stopped ||
-				(info->type == PORT_16550A) ||
-				(info->board->must_hwid)) {
-			spin_lock_irqsave(&info->slock, flags);
-			outb(info->IER & ~UART_IER_THRI, info->ioaddr +
-					UART_IER);
-			info->IER |= UART_IER_THRI;
-			outb(info->IER, info->ioaddr + UART_IER);
-			spin_unlock_irqrestore(&info->slock, flags);
-		}
+		if (!tty->hw_stopped || info->type == PORT_16550A ||
+				info->board->must_hwid)
+			mxser_start_tx(info);
 	}
 	return total;
 }
@@ -985,20 +994,13 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 static void mxser_flush_chars(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
 	if (info->xmit_cnt <= 0 || tty->flow.stopped || !info->port.xmit_buf ||
 			(tty->hw_stopped && info->type != PORT_16550A &&
 			 !info->board->must_hwid))
 		return;
 
-	spin_lock_irqsave(&info->slock, flags);
-
-	outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
-	info->IER |= UART_IER_THRI;
-	outb(info->IER, info->ioaddr + UART_IER);
-
-	spin_unlock_irqrestore(&info->slock, flags);
+	mxser_start_tx(info);
 }
 
 static unsigned int mxser_write_room(struct tty_struct *tty)
@@ -1399,10 +1401,8 @@ static void mxser_stop(struct tty_struct *tty)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->IER & UART_IER_THRI) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->ioaddr + UART_IER);
-	}
+	if (info->IER & UART_IER_THRI)
+		__mxser_stop_tx(info);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
@@ -1412,11 +1412,8 @@ static void mxser_start(struct tty_struct *tty)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt && info->port.xmit_buf) {
-		outb(info->IER & ~UART_IER_THRI, info->ioaddr + UART_IER);
-		info->IER |= UART_IER_THRI;
-		outb(info->IER, info->ioaddr + UART_IER);
-	}
+	if (info->xmit_cnt && info->port.xmit_buf)
+		__mxser_start_tx(info);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
 
@@ -1659,8 +1656,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 			(tty->hw_stopped &&
 			(port->type != PORT_16550A) &&
 			(!port->board->must_hwid))) {
-		port->IER &= ~UART_IER_THRI;
-		outb(port->IER, port->ioaddr + UART_IER);
+		__mxser_stop_tx(port);
 		return;
 	}
 
@@ -1679,10 +1675,8 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->xmit_cnt < WAKEUP_CHARS)
 		tty_wakeup(tty);
 
-	if (port->xmit_cnt <= 0) {
-		port->IER &= ~UART_IER_THRI;
-		outb(port->IER, port->ioaddr + UART_IER);
-	}
+	if (port->xmit_cnt <= 0)
+		__mxser_stop_tx(port);
 }
 
 static bool mxser_port_isr(struct mxser_port *port)
-- 
2.32.0

