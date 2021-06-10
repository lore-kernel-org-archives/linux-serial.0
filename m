Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC18C48BCD
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45CB61407
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFJJEp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:04:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJJEp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 05:04:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BBF1D21A57;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623315768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AzY5aKAyUxEh8Iy+wlacgGEXj9oXE6OjdWt5CY8gls=;
        b=r2tMQ8POvO1nORramHc2h27E1Loa/6gbtoDIoOcNkiR202pXY4aHmja6dl7OEUN19Q849E
        kvCwO2SeimHzmxLQ5czP63oEIYcrKWRzRtfz5a3oOYXyHPc17j/NB1pXv1x/hF9AvNHBJz
        elWrBoI0bm8Xcjy0d24QIvEy6sGHjTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623315768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AzY5aKAyUxEh8Iy+wlacgGEXj9oXE6OjdWt5CY8gls=;
        b=50tZfTcgM7ReM7v8LKe+UCNrrQpowzigHC3SKEQOlqq+4a9Q/QYl2YO/Z1XUae0uNyHoW9
        Yeux4UO1mKSqyHBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9284FA3B8B;
        Thu, 10 Jun 2021 09:02:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v3 2/4] mxs-auart: redefine AUART_LINECTRL_WLEN to accept bits count
Date:   Thu, 10 Jun 2021 11:02:45 +0200
Message-Id: <20210610090247.2593-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610090247.2593-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210610090247.2593-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's a bit illogical to take magic constants in AUART_LINECTRL_WLEN.
Like in auart_console_get_options(), 2 means 7 bits. Switch
AUART_LINECTRL_WLEN to accept bit length, i.e. let it subtract 5 from
the parameter before doing the logic.

This will ease conversion from CSIZE to bits in mxs_auart_settermios()
in the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mxs-auart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index f414d6acad69..7b4b6bb75424 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -87,7 +87,7 @@
 #define AUART_LINECTRL_BAUD_DIVFRAC(v)		(((v) & 0x3f) << 8)
 #define AUART_LINECTRL_SPS			(1 << 7)
 #define AUART_LINECTRL_WLEN_MASK		0x00000060
-#define AUART_LINECTRL_WLEN(v)			(((v) & 0x3) << 5)
+#define AUART_LINECTRL_WLEN(v)			((((v) - 5) & 0x3) << 5)
 #define AUART_LINECTRL_FEN			(1 << 4)
 #define AUART_LINECTRL_STP2			(1 << 3)
 #define AUART_LINECTRL_EPS			(1 << 2)
@@ -973,16 +973,16 @@ static void mxs_auart_settermios(struct uart_port *u,
 	/* byte size */
 	switch (cflag & CSIZE) {
 	case CS5:
-		bm = 0;
+		bm = 5;
 		break;
 	case CS6:
-		bm = 1;
+		bm = 6;
 		break;
 	case CS7:
-		bm = 2;
+		bm = 7;
 		break;
 	case CS8:
-		bm = 3;
+		bm = 8;
 		break;
 	default:
 		return;
@@ -1403,7 +1403,7 @@ auart_console_get_options(struct mxs_auart_port *s, int *baud,
 			*parity = 'o';
 	}
 
-	if ((lcr_h & AUART_LINECTRL_WLEN_MASK) == AUART_LINECTRL_WLEN(2))
+	if ((lcr_h & AUART_LINECTRL_WLEN_MASK) == AUART_LINECTRL_WLEN(7))
 		*bits = 7;
 	else
 		*bits = 8;
-- 
2.32.0

