Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC0C49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA923611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhFRGRu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhFRGRa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 822BB21B5A;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaN6R/IGB7HxBmyiOa/qSdAOPItu271CaB0Oj6+8+Mw=;
        b=KS19NaNplPYGKeIRGc1ik9PVXBGSwj3k95MsqTR5IKtM8Af41r2P9MK4pQBIG4y/oClWBg
        cGzN+hH87tqiZRr9OzGtXttNY4+cdq+z12JcHLwNlg24XDcNj4qXvxF9qiA5VkFTyg7a/E
        xJlamcD47N8DYixbQdh6Wr3KpA7BLdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaN6R/IGB7HxBmyiOa/qSdAOPItu271CaB0Oj6+8+Mw=;
        b=m0YvQApTQTn4NyEOox+hIoN8z/pF4cat+okRIVKkFTlm5+8nSZlsQiVKflBFI1zboTVxCz
        1saWzwRwqewI1XBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58EB0A3BBA;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/70] mxser: extract mxser_receive_chars_old
Date:   Fri, 18 Jun 2021 08:14:22 +0200
Message-Id: <20210618061516.662-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index a321aba24d58..6b8f2b0e0726 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2086,28 +2086,21 @@ static bool mxser_receive_chars_new(struct tty_struct *tty,
 	return true;
 }
 
-static u8 mxser_receive_chars(struct tty_struct *tty,
-		struct mxser_port *port, u8 status)
+static u8 mxser_receive_chars_old(struct tty_struct *tty,
+		                struct mxser_port *port, u8 status, int *cnt)
 {
-	unsigned char ch;
+	enum mxser_must_hwid hwid = port->board->must_hwid;
+	int recv_room = tty->receive_room;
 	int ignored = 0;
-	int cnt = 0;
-	int recv_room;
 	int max = 256;
-
-	recv_room = tty->receive_room;
-	if (recv_room == 0 && !port->ldisc_stop_rx)
-		mxser_stoprx(tty);
-
-	if (mxser_receive_chars_new(tty, port, status, &cnt))
-		goto end_intr;
+	u8 ch;
 
 	do {
 		if (max-- < 0)
 			break;
 
 		ch = inb(port->ioaddr + UART_RX);
-		if (port->board->must_hwid && (status & UART_LSR_OE))
+		if (hwid && (status & UART_LSR_OE))
 			outb(0x23, port->ioaddr + UART_FCR);
 		status &= port->read_status_mask;
 		if (status & port->ignore_status_mask) {
@@ -2135,8 +2128,8 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 					flag = TTY_BREAK;
 			}
 			tty_insert_flip_char(&port->port, ch, flag);
-			cnt++;
-			if (cnt >= recv_room) {
+			(*cnt)++;
+			if (*cnt >= recv_room) {
 				if (!port->ldisc_stop_rx)
 					mxser_stoprx(tty);
 				break;
@@ -2144,13 +2137,26 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 
 		}
 
-		if (port->board->must_hwid)
+		if (hwid)
 			break;
 
 		status = inb(port->ioaddr + UART_LSR);
 	} while (status & UART_LSR_DR);
 
-end_intr:
+	return status;
+}
+
+static u8 mxser_receive_chars(struct tty_struct *tty,
+		struct mxser_port *port, u8 status)
+{
+	int cnt = 0;
+
+	if (tty->receive_room == 0 && !port->ldisc_stop_rx)
+		mxser_stoprx(tty);
+
+	if (!mxser_receive_chars_new(tty, port, status, &cnt))
+		status = mxser_receive_chars_old(tty, port, status, &cnt);
+
 	mxvar_log.rxcnt[tty->index] += cnt;
 	port->mon_data.rxcnt += cnt;
 	port->mon_data.up_rxcnt += cnt;
-- 
2.32.0

