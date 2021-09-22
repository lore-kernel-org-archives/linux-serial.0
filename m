Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66EC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FB611C9
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhIVIBM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34554 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6E13C201BF;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eNhrsKLfHba5f7FTtrJ7Ml7fJtnV/kwE/HvvTUi05Y=;
        b=d5Wrma4fJbAZhYMY6GkjElUusGnQAl70oqhb/cJsih5xwVyJnQ6z5lrUGJQNIICk5ARDqf
        R/LvdX2B7RkUhW8TVc5vpA7AoreQQzL1EDFW+BnXeGfe5KyXn2ERpRL3185z95C4oqCwmG
        tCkEYAA0UzfF3BRLNBW7YBDawae9Y4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eNhrsKLfHba5f7FTtrJ7Ml7fJtnV/kwE/HvvTUi05Y=;
        b=5T3IyPgyz47gtw2Fk/Vu+nqlr5cr/tSzrqo1DoCSDilWWd1IA2HZj4Di1IPpzKV7+Cv2az
        +HpylQ5sKOqxqsCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F8CAA3B8D;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] mxser: simplify FCR computation in mxser_change_speed()
Date:   Wed, 22 Sep 2021 09:59:35 +0200
Message-Id: <20210922075938.31390-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Provided FIFO is always enabled for MUST chips, move its FCR setting out
of PORT_8250/PORT_16450 special case in mxser_change_speed(). Now, we
can pre-set fcr to zero and invert the condition of the 'if'.

This makes the code more readable (no functional change intended).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 47 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 309acf3f1ec3..c194a96bb14e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -600,33 +600,26 @@ static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_term
 	if (cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
 
-	if ((info->type == PORT_8250) || (info->type == PORT_16450)) {
-		if (info->board->must_hwid) {
-			fcr = UART_FCR_ENABLE_FIFO;
-			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
-			mxser_set_must_fifo_value(info);
-		} else
-			fcr = 0;
-	} else {
-		fcr = UART_FCR_ENABLE_FIFO;
-		if (info->board->must_hwid) {
-			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
-			mxser_set_must_fifo_value(info);
-		} else {
-			switch (info->rx_high_water) {
-			case 1:
-				fcr |= UART_FCR_TRIGGER_1;
-				break;
-			case 4:
-				fcr |= UART_FCR_TRIGGER_4;
-				break;
-			case 8:
-				fcr |= UART_FCR_TRIGGER_8;
-				break;
-			default:
-				fcr |= UART_FCR_TRIGGER_14;
-				break;
-			}
+	fcr = 0;
+	if (info->board->must_hwid) {
+		fcr |= UART_FCR_ENABLE_FIFO |
+			MOXA_MUST_FCR_GDA_MODE_ENABLE;
+		mxser_set_must_fifo_value(info);
+	} else if (info->type != PORT_8250 && info->type != PORT_16450) {
+		fcr |= UART_FCR_ENABLE_FIFO;
+		switch (info->rx_high_water) {
+		case 1:
+			fcr |= UART_FCR_TRIGGER_1;
+			break;
+		case 4:
+			fcr |= UART_FCR_TRIGGER_4;
+			break;
+		case 8:
+			fcr |= UART_FCR_TRIGGER_8;
+			break;
+		default:
+			fcr |= UART_FCR_TRIGGER_14;
+			break;
 		}
 	}
 
-- 
2.33.0

