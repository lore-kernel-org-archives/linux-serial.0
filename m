Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D62C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B461154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhFRGRr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhFRGRa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E702321AB2;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf0c8AA+WJx652FcNRZ4b2mKiWtF7sdoLMBJ0Alo48k=;
        b=vfPrh/+SIYqPT1W9SCU55eZGuuBwY1HQ+VaNtgVlRpq98rZQIVGN6NPo5P//b1j1+nFCeY
        8eWfmBhz27/HWAP44t2An8s+eLAU872goGmkUzK5jVwPzJuP3UDVujUqw4LrIakBq0vamM
        dehYB5FnMgBzxZiQ0bT6WXEvVkENfJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf0c8AA+WJx652FcNRZ4b2mKiWtF7sdoLMBJ0Alo48k=;
        b=4erSWj+frJATVHr3KJqItVXsaINsB3zHTPijFc9j60AyadtFMjCIL3XuvgXXIipxfUocQL
        DLyAoygLtBO6GDAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C01F2A3BCB;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/70] mxser: extract port ISR
Date:   Fri, 18 Jun 2021 08:14:19 +0200
Message-Id: <20210618061516.662-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ISR is terrible mix of letters. Let's extract the proper per-port
handling to a separate function called mxser_port_isr. This way, we can
actually see what both mxser_interrupt and mxser_port_isr do now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 119 ++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 55 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 9ba3af4626c6..555b9b37b52f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2203,18 +2203,78 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	}
 }
 
+static bool mxser_port_isr(struct mxser_port *port)
+{
+	struct tty_struct *tty;
+	u8 iir, msr, status;
+	bool error = false;
+
+	iir = inb(port->ioaddr + UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return true;
+
+	iir &= MOXA_MUST_IIR_MASK;
+	tty = tty_port_tty_get(&port->port);
+	if (!tty || port->closing || !tty_port_initialized(&port->port)) {
+		status = inb(port->ioaddr + UART_LSR);
+		outb(0x27, port->ioaddr + UART_FCR);
+		inb(port->ioaddr + UART_MSR);
+
+		error = true;
+		goto put_tty;
+	}
+
+	status = inb(port->ioaddr + UART_LSR);
+
+	if (status & UART_LSR_PE)
+		port->err_shadow |= NPPI_NOTIFY_PARITY;
+	if (status & UART_LSR_FE)
+		port->err_shadow |= NPPI_NOTIFY_FRAMING;
+	if (status & UART_LSR_OE)
+		port->err_shadow |= NPPI_NOTIFY_HW_OVERRUN;
+	if (status & UART_LSR_BI)
+		port->err_shadow |= NPPI_NOTIFY_BREAK;
+
+	if (port->board->must_hwid) {
+		if (iir == MOXA_MUST_IIR_GDA ||
+		    iir == MOXA_MUST_IIR_RDA ||
+		    iir == MOXA_MUST_IIR_RTO ||
+		    iir == MOXA_MUST_IIR_LSR)
+			status = mxser_receive_chars(tty, port, status);
+	} else {
+		status &= port->read_status_mask;
+		if (status & UART_LSR_DR)
+			status = mxser_receive_chars(tty, port, status);
+	}
+
+	msr = inb(port->ioaddr + UART_MSR);
+	if (msr & UART_MSR_ANY_DELTA)
+		mxser_check_modem_status(tty, port, msr);
+
+	if (port->board->must_hwid) {
+		if (iir == 0x02 && (status & UART_LSR_THRE))
+			mxser_transmit_chars(tty, port);
+	} else {
+		if (status & UART_LSR_THRE)
+			mxser_transmit_chars(tty, port);
+	}
+
+put_tty:
+	tty_kref_put(tty);
+
+	return error;
+}
+
 /*
  * This is the serial driver's generic interrupt routine
  */
 static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 {
-	int status, iir, i;
 	struct mxser_board *brd = dev_id;
 	struct mxser_port *port;
-	int max, irqbits, bits, msr;
 	unsigned int int_cnt, pass_counter = 0;
+	int max, irqbits, bits, i;
 	int handled = IRQ_NONE;
-	struct tty_struct *tty;
 
 	max = brd->info->nports;
 	while (pass_counter++ < MXSER_ISR_PASS_LIMIT) {
@@ -2233,59 +2293,8 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 			int_cnt = 0;
 			spin_lock(&port->slock);
 			do {
-				iir = inb(port->ioaddr + UART_IIR);
-				if (iir & UART_IIR_NO_INT)
-					break;
-				iir &= MOXA_MUST_IIR_MASK;
-				tty = tty_port_tty_get(&port->port);
-				if (!tty || port->closing ||
-				    !tty_port_initialized(&port->port)) {
-					status = inb(port->ioaddr + UART_LSR);
-					outb(0x27, port->ioaddr + UART_FCR);
-					inb(port->ioaddr + UART_MSR);
-					tty_kref_put(tty);
+				if (mxser_port_isr(port))
 					break;
-				}
-
-				status = inb(port->ioaddr + UART_LSR);
-
-				if (status & UART_LSR_PE)
-					port->err_shadow |= NPPI_NOTIFY_PARITY;
-				if (status & UART_LSR_FE)
-					port->err_shadow |= NPPI_NOTIFY_FRAMING;
-				if (status & UART_LSR_OE)
-					port->err_shadow |=
-						NPPI_NOTIFY_HW_OVERRUN;
-				if (status & UART_LSR_BI)
-					port->err_shadow |= NPPI_NOTIFY_BREAK;
-
-				if (port->board->must_hwid) {
-					if (iir == MOXA_MUST_IIR_GDA ||
-					    iir == MOXA_MUST_IIR_RDA ||
-					    iir == MOXA_MUST_IIR_RTO ||
-					    iir == MOXA_MUST_IIR_LSR)
-						status = mxser_receive_chars(tty,
-								port, status);
-
-				} else {
-					status &= port->read_status_mask;
-					if (status & UART_LSR_DR)
-						status = mxser_receive_chars(tty,
-								port, status);
-				}
-				msr = inb(port->ioaddr + UART_MSR);
-				if (msr & UART_MSR_ANY_DELTA)
-					mxser_check_modem_status(tty, port, msr);
-
-				if (port->board->must_hwid) {
-					if (iir == 0x02 && (status &
-								UART_LSR_THRE))
-						mxser_transmit_chars(tty, port);
-				} else {
-					if (status & UART_LSR_THRE)
-						mxser_transmit_chars(tty, port);
-				}
-				tty_kref_put(tty);
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
 			spin_unlock(&port->slock);
 		}
-- 
2.32.0

