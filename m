Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99946C49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843EA61154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhFRGRq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46210 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhFRGR3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B5A091FDF2;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLbdN2mwhZ8591LPEEpdqZp7i95lCMmmdxy9Xlgwj4k=;
        b=yJvW9qFMGrVc7fAWA3xPMFooOlrrxJO4BYfvbOAjll2ImbNZGavsAH2y7+pbSl3pGPr3VP
        pj6WVl1FumySsm9aGn/RHqy4NgTSZqzDDZ3EXhLfvXrG/tqKGdKSyImpCX8HdOu37iFGuB
        qwIQhILuvITG3O177UC7oVAYCADqJu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MLbdN2mwhZ8591LPEEpdqZp7i95lCMmmdxy9Xlgwj4k=;
        b=tWRt1pNsQH68063NspH0xv3Di+vjF/HuVpJYux5vpJ2iTdHvOq4StRf+ggk6kDwNAVNY0v
        FVY7vxDQlV2IB2DA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90C22A3BCA;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/70] mxser: cleanup LSR handling in mxser_receive_chars
Date:   Fri, 18 Jun 2021 08:14:18 +0200
Message-Id: <20210618061516.662-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_interrupt is a bit confusing as it passes a pointer to LSR
variable ("status") to mxser_receive_chars. That function can indeed
update the LCR variable. Make this clear by not passing a variable by
reference, instead, return updated status. And change its type
accordingly -- to u8.

Note that the next patches will rework ISR so that even the definition
of status will be u8 soon too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6602b2741271..9ba3af4626c6 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2056,8 +2056,8 @@ static int mxser_rs_break(struct tty_struct *tty, int break_state)
 	return 0;
 }
 
-static void mxser_receive_chars(struct tty_struct *tty,
-				struct mxser_port *port, int *status)
+static u8 mxser_receive_chars(struct tty_struct *tty,
+		struct mxser_port *port, u8 status)
 {
 	unsigned char ch, gdl;
 	int ignored = 0;
@@ -2070,12 +2070,12 @@ static void mxser_receive_chars(struct tty_struct *tty,
 		mxser_stoprx(tty);
 	if (port->board->must_hwid != MOXA_OTHER_UART) {
 
-		if (*status & UART_LSR_SPECIAL)
+		if (status & UART_LSR_SPECIAL)
 			goto intr_old;
 		if (port->board->must_hwid == MOXA_MUST_MU860_HWID &&
-				(*status & MOXA_MUST_LSR_RERR))
+				(status & MOXA_MUST_LSR_RERR))
 			goto intr_old;
-		if (*status & MOXA_MUST_LSR_RERR)
+		if (status & MOXA_MUST_LSR_RERR)
 			goto intr_old;
 
 		gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
@@ -2100,28 +2100,28 @@ static void mxser_receive_chars(struct tty_struct *tty,
 			break;
 
 		ch = inb(port->ioaddr + UART_RX);
-		if (port->board->must_hwid && (*status & UART_LSR_OE))
+		if (port->board->must_hwid && (status & UART_LSR_OE))
 			outb(0x23, port->ioaddr + UART_FCR);
-		*status &= port->read_status_mask;
-		if (*status & port->ignore_status_mask) {
+		status &= port->read_status_mask;
+		if (status & port->ignore_status_mask) {
 			if (++ignored > 100)
 				break;
 		} else {
 			char flag = 0;
-			if (*status & UART_LSR_SPECIAL) {
-				if (*status & UART_LSR_BI) {
+			if (status & UART_LSR_SPECIAL) {
+				if (status & UART_LSR_BI) {
 					flag = TTY_BREAK;
 					port->icount.brk++;
 
 					if (port->port.flags & ASYNC_SAK)
 						do_SAK(tty);
-				} else if (*status & UART_LSR_PE) {
+				} else if (status & UART_LSR_PE) {
 					flag = TTY_PARITY;
 					port->icount.parity++;
-				} else if (*status & UART_LSR_FE) {
+				} else if (status & UART_LSR_FE) {
 					flag = TTY_FRAME;
 					port->icount.frame++;
-				} else if (*status & UART_LSR_OE) {
+				} else if (status & UART_LSR_OE) {
 					flag = TTY_OVERRUN;
 					port->icount.overrun++;
 				} else
@@ -2140,8 +2140,8 @@ static void mxser_receive_chars(struct tty_struct *tty,
 		if (port->board->must_hwid)
 			break;
 
-		*status = inb(port->ioaddr + UART_LSR);
-	} while (*status & UART_LSR_DR);
+		status = inb(port->ioaddr + UART_LSR);
+	} while (status & UART_LSR_DR);
 
 end_intr:
 	mxvar_log.rxcnt[tty->index] += cnt;
@@ -2149,6 +2149,8 @@ static void mxser_receive_chars(struct tty_struct *tty,
 	port->mon_data.up_rxcnt += cnt;
 
 	tty_flip_buffer_push(&port->port);
+
+	return status;
 }
 
 static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port)
@@ -2262,14 +2264,14 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 					    iir == MOXA_MUST_IIR_RDA ||
 					    iir == MOXA_MUST_IIR_RTO ||
 					    iir == MOXA_MUST_IIR_LSR)
-						mxser_receive_chars(tty, port,
-								&status);
+						status = mxser_receive_chars(tty,
+								port, status);
 
 				} else {
 					status &= port->read_status_mask;
 					if (status & UART_LSR_DR)
-						mxser_receive_chars(tty, port,
-								&status);
+						status = mxser_receive_chars(tty,
+								port, status);
 				}
 				msr = inb(port->ioaddr + UART_MSR);
 				if (msr & UART_MSR_ANY_DELTA)
-- 
2.32.0

