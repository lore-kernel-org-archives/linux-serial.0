Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0CC49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B161260
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhFRGSa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhFRGRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0457521B62;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WunEcyMTZztXC8FBdz/qLCvbhxVKGm10rvI3aZg8xgc=;
        b=IKD9NjDXZG8hh2IhonUKapY1Yb4k2zOwhLougIhLgWFV508BMhDb+CNBxu/mMWo7QowoZe
        lp5m1GawWPTkSn6zxMuOgitgImfUIb2MD5qXsXJyKxXB3vEOBfZwco3OrVEwMLdzYjlWy9
        49ey0ZT3MhVTJiuHphfWUwtujEBYS2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WunEcyMTZztXC8FBdz/qLCvbhxVKGm10rvI3aZg8xgc=;
        b=phVwfOnheKJ8ILcn0sqy3LE/9n4JYFoZeoSay9Kzxwmdc4s8BQECj/Xx3EZprmFDh71wlf
        MJOJX3Dh1WUOISCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C7005A3B99;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 41/70] mxser: introduce mxser_must_select_bank and use it
Date:   Fri, 18 Jun 2021 08:14:47 +0200
Message-Id: <20210618061516.662-42-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Again, selecting a bank in the EFR register is duplicated many times.
Extract it to a separate function (mxser_must_select_bank) and use it on
all the places.

This cleans up most of the helpers. And mxser_get_must_hardware_id now
returns the HW ID directly, not via a by-reference parameter.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 74 ++++++++++-----------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 7caf369571f1..392aee47c803 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -334,53 +334,29 @@ static u8 __mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set,
 	return oldlcr;
 }
 
-static void mxser_set_must_xon1_value(unsigned long baseio, u8 value)
+static u8 mxser_must_select_bank(unsigned long baseio, u8 bank)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_BANK_MASK;
-	efr |= MOXA_MUST_EFR_BANK0;
+	return __mxser_must_set_EFR(baseio, MOXA_MUST_EFR_BANK_MASK, bank,
+			false);
+}
 
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
+static void mxser_set_must_xon1_value(unsigned long baseio, u8 value)
+{
+	u8 oldlcr = mxser_must_select_bank(baseio, MOXA_MUST_EFR_BANK0);
 	outb(value, baseio + MOXA_MUST_XON1_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
 }
 
 static void mxser_set_must_xoff1_value(unsigned long baseio, u8 value)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_BANK_MASK;
-	efr |= MOXA_MUST_EFR_BANK0;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
+	u8 oldlcr = mxser_must_select_bank(baseio, MOXA_MUST_EFR_BANK0);
 	outb(value, baseio + MOXA_MUST_XOFF1_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
 }
 
 static void mxser_set_must_fifo_value(struct mxser_port *info)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(info->ioaddr + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, info->ioaddr + UART_LCR);
-
-	efr = inb(info->ioaddr + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_BANK_MASK;
-	efr |= MOXA_MUST_EFR_BANK1;
-
-	outb(efr, info->ioaddr + MOXA_MUST_EFR_REGISTER);
+	u8 oldlcr = mxser_must_select_bank(info->ioaddr, MOXA_MUST_EFR_BANK1);
 	outb(info->rx_high_water, info->ioaddr + MOXA_MUST_RBRTH_REGISTER);
 	outb(info->rx_high_water, info->ioaddr + MOXA_MUST_RBRTI_REGISTER);
 	outb(info->rx_low_water, info->ioaddr + MOXA_MUST_RBRTL_REGISTER);
@@ -389,36 +365,18 @@ static void mxser_set_must_fifo_value(struct mxser_port *info)
 
 static void mxser_set_must_enum_value(unsigned long baseio, u8 value)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_BANK_MASK;
-	efr |= MOXA_MUST_EFR_BANK2;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
+	u8 oldlcr = mxser_must_select_bank(baseio, MOXA_MUST_EFR_BANK2);
 	outb(value, baseio + MOXA_MUST_ENUM_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
 }
 
-static void mxser_get_must_hardware_id(unsigned long baseio, u8 *pId)
+static u8 mxser_get_must_hardware_id(unsigned long baseio)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_BANK_MASK;
-	efr |= MOXA_MUST_EFR_BANK2;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	*pId = inb(baseio + MOXA_MUST_HWID_REGISTER);
+	u8 oldlcr = mxser_must_select_bank(baseio, MOXA_MUST_EFR_BANK2);
+	u8 id = inb(baseio + MOXA_MUST_HWID_REGISTER);
 	outb(oldlcr, baseio + UART_LCR);
+
+	return id;
 }
 
 static void mxser_must_set_EFR(unsigned long baseio, u8 clear, u8 set)
@@ -525,7 +483,7 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 		return MOXA_OTHER_UART;
 	}
 
-	mxser_get_must_hardware_id(io, &hwid);
+	hwid = mxser_get_must_hardware_id(io);
 	for (i = 1; i < UART_INFO_NUM; i++) /* 0 = OTHER_UART */
 		if (hwid == Gpci_uart_info[i].type)
 			return hwid;
-- 
2.32.0

