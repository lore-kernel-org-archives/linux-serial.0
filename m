Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F63C49EA6
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC056120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhFRGSZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFRGRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B45B121B5D;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSErs93vjO9M14a4sDa8H3yI+ArnDl4hXOYzKvTJMWc=;
        b=y1qRsJk0A+/lCFs7tPs56/BekIXIH9DsPMumRjBGwd1+kYAYNG655P7DIJhttXH1eiID/e
        v9RFEpNBdxQc5VljkqBJweyAZmAXD82q1cSuc+tWdghhCQiKGP//mH0+AP8Tq4FECiHMHR
        YTwJRbWXzvcYLqNsiuhaQijA6GAy1jI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSErs93vjO9M14a4sDa8H3yI+ArnDl4hXOYzKvTJMWc=;
        b=TQiYyY9R+6DcqkL7jYV8xESxHYAVxiLwrVIWiQGaS0JoXLtL1PJ9aK86FhMcVkdjvMv9Ul
        SrREl7ZmGvgaisBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C34CA3B99;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 40/70] mxser: dedup mxser_must_set_enhance_mode
Date:   Fri, 18 Jun 2021 08:14:46 +0200
Message-Id: <20210618061516.662-41-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are multiple copies of setting the EFR register. Separate it to a
new universal function called __mxser_must_set_EFR. And use it in the
code by introducing mxser_must_set_enhance_mode instead of
mxser_disable_must_enchance_mode and mxser_enable_must_enchance_mode.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e082ae055c39..7caf369571f1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -314,34 +314,24 @@ struct mxser_board {
 static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
 
-static void mxser_enable_must_enchance_mode(unsigned long baseio)
+static u8 __mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set,
+		bool restore_LCR)
 {
-	u8 oldlcr;
-	u8 efr;
+	u8 oldlcr, efr;
 
 	oldlcr = inb(baseio + UART_LCR);
 	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
 
 	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr |= MOXA_MUST_EFR_EFRB_ENABLE;
+	efr &= ~clear;
+	efr |= set;
 
 	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
-}
-
-static void mxser_disable_must_enchance_mode(unsigned long baseio)
-{
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
 
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_EFRB_ENABLE;
+	if (restore_LCR)
+		outb(oldlcr, baseio + UART_LCR);
 
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
+	return oldlcr;
 }
 
 static void mxser_set_must_xon1_value(unsigned long baseio, u8 value)
@@ -431,6 +421,18 @@ static void mxser_get_must_hardware_id(unsigned long baseio, u8 *pId)
 	outb(oldlcr, baseio + UART_LCR);
 }
 
+static void mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set)
+{
+	__mxser_must_set_EFR(baseio, clear, set, true);
+}
+
+static void mxser_must_set_enhance_mode(unsigned long baseio, bool enable)
+{
+	mxser_must_set_EFR(baseio,
+			enable ? 0 : MOXA_MUST_EFR_EFRB_ENABLE,
+			enable ? MOXA_MUST_EFR_EFRB_ENABLE : 0);
+}
+
 static void SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(unsigned long baseio)
 {
 	u8 oldlcr;
@@ -514,7 +516,7 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 	int i;
 
 	outb(0, io + UART_LCR);
-	mxser_disable_must_enchance_mode(io);
+	mxser_must_set_enhance_mode(io, false);
 	oldmcr = inb(io + UART_MCR);
 	outb(0, io + UART_MCR);
 	mxser_set_must_xon1_value(io, 0x11);
@@ -2011,7 +2013,7 @@ static int mxser_initbrd(struct mxser_board *brd)
 
 		/* Enhance mode enabled here */
 		if (brd->must_hwid != MOXA_OTHER_UART)
-			mxser_enable_must_enchance_mode(info->ioaddr);
+			mxser_must_set_enhance_mode(info->ioaddr, true);
 
 		info->type = PORT_16550A;
 
-- 
2.32.0

