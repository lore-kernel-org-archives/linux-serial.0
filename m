Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C2C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDFE6120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhFRGSO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhFRGRp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B80D521B70;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JyG/W9XCxU1xTrSTE7jAFbgVcFxPfOrOkYTmv9owc4=;
        b=CLeMMGfOPe9xQDDy5r3frnti0QwvHz9ALlwzRHrpDt2/FOeRb3LKzhROSVs6QsWKa3LjBV
        FeLNsvF+KWHFu5i4sTPiPWPNzOf6Wh8HMC0jlIYrsKbdzwDKAmlpnSSLVDH4AosQwqig7W
        yIQJRF3N7WHCYyaJpbWyAo226Dp8ebQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JyG/W9XCxU1xTrSTE7jAFbgVcFxPfOrOkYTmv9owc4=;
        b=qsQbni0DoG/SQA3m9CUIWNyajTM1oFVwPHVkoIRAC5I7B/6UyDA4JhXNjPZGKp17etiYiW
        nKiHksMSwu+C3hBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 901B1A3B9E;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 31/70] mxser: remove cnt from mxser_receive_chars
Date:   Fri, 18 Jun 2021 08:14:37 +0200
Message-Id: <20210618061516.662-32-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous ioctls removal, cnt is needed only in
mxser_receive_chars_old now. So remove it from mxser_receive_chars and
mxser_receive_chars_new and account only in mxser_receive_chars_old.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 586fa3575673..d354c80083fd 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1743,7 +1743,7 @@ static int mxser_rs_break(struct tty_struct *tty, int break_state)
 }
 
 static bool mxser_receive_chars_new(struct tty_struct *tty,
-		struct mxser_port *port, u8 status, int *cnt)
+		struct mxser_port *port, u8 status)
 {
 	enum mxser_must_hwid hwid = port->board->must_hwid;
 	u8 gdl;
@@ -1767,19 +1767,19 @@ static bool mxser_receive_chars_new(struct tty_struct *tty,
 	while (gdl--) {
 		u8 ch = inb(port->ioaddr + UART_RX);
 		tty_insert_flip_char(&port->port, ch, 0);
-		(*cnt)++;
 	}
 
 	return true;
 }
 
 static u8 mxser_receive_chars_old(struct tty_struct *tty,
-		                struct mxser_port *port, u8 status, int *cnt)
+		                struct mxser_port *port, u8 status)
 {
 	enum mxser_must_hwid hwid = port->board->must_hwid;
 	int recv_room = tty->receive_room;
 	int ignored = 0;
 	int max = 256;
+	int cnt = 0;
 	u8 ch;
 
 	do {
@@ -1814,8 +1814,8 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 				}
 			}
 			tty_insert_flip_char(&port->port, ch, flag);
-			(*cnt)++;
-			if (*cnt >= recv_room) {
+			cnt++;
+			if (cnt >= recv_room) {
 				if (!port->ldisc_stop_rx)
 					mxser_stoprx(tty);
 				break;
@@ -1835,13 +1835,11 @@ static u8 mxser_receive_chars_old(struct tty_struct *tty,
 static u8 mxser_receive_chars(struct tty_struct *tty,
 		struct mxser_port *port, u8 status)
 {
-	int cnt = 0;
-
 	if (tty->receive_room == 0 && !port->ldisc_stop_rx)
 		mxser_stoprx(tty);
 
-	if (!mxser_receive_chars_new(tty, port, status, &cnt))
-		status = mxser_receive_chars_old(tty, port, status, &cnt);
+	if (!mxser_receive_chars_new(tty, port, status))
+		status = mxser_receive_chars_old(tty, port, status);
 
 	tty_flip_buffer_push(&port->port);
 
-- 
2.32.0

