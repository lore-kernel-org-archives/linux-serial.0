Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F74C49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE4D613AA
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhFRGSc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhFRGRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3C0E421B64;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN4HxNMJTR2MUbn+I3zPnmQsF2Yg/Zns1X63Wa0iWdE=;
        b=geDS57rImcbSmyNRvGAOfVTrPAcp981/kOJj5kI5sJM7Pbhef7MEdKwQ5NkjyX0jBgSUGM
        euS2+YiPODDT15p83gzW1i1N5wgSagg5PRFC1cwf6khjpCtDHUBjV25nWMI0/RfC9evMf4
        WH+4jZdcWpM+7d/Trssbf6mSbL3T95A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN4HxNMJTR2MUbn+I3zPnmQsF2Yg/Zns1X63Wa0iWdE=;
        b=3/Bc0XPF9cP9nlsLpzT4GaK+PTvTJ5JqBpy2o/qE7VqiAupZFMKyqzjIaDcsTKOQHplRwR
        dzfvgRbyMciGdpCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0D58DA3B9E;
        Fri, 18 Jun 2021 06:15:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 42/70] mxser: clean up the rest of MUST helpers
Date:   Fri, 18 Jun 2021 08:14:48 +0200
Message-Id: <20210618061516.662-43-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Clean up the rest of MUST helpers. They all can use the newly added
mxser_must_set_EFR. And passing a bool instead of having two functions
(_enable+_disable) simplifies the code a lot too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 97 ++++++---------------------------------------
 1 file changed, 12 insertions(+), 85 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 392aee47c803..ff85a6e15d9d 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -391,81 +391,21 @@ static void mxser_must_set_enhance_mode(unsigned long baseio, bool enable)
 			enable ? MOXA_MUST_EFR_EFRB_ENABLE : 0);
 }
 
-static void SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(unsigned long baseio)
+static void mxser_must_no_sw_flow_control(unsigned long baseio)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_SF_MASK;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
-}
-
-static void mxser_enable_must_tx_software_flow_control(unsigned long baseio)
-{
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_SF_TX_MASK;
-	efr |= MOXA_MUST_EFR_SF_TX1;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
-}
-
-static void mxser_disable_must_tx_software_flow_control(unsigned long baseio)
-{
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_SF_TX_MASK;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
+	mxser_must_set_EFR(baseio, MOXA_MUST_EFR_SF_MASK, 0);
 }
 
-static void mxser_enable_must_rx_software_flow_control(unsigned long baseio)
+static void mxser_must_set_tx_sw_flow_control(unsigned long baseio, bool enable)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_SF_RX_MASK;
-	efr |= MOXA_MUST_EFR_SF_RX1;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
+	mxser_must_set_EFR(baseio, MOXA_MUST_EFR_SF_TX_MASK,
+			enable ? MOXA_MUST_EFR_SF_TX1 : 0);
 }
 
-static void mxser_disable_must_rx_software_flow_control(unsigned long baseio)
+static void mxser_must_set_rx_sw_flow_control(unsigned long baseio, bool enable)
 {
-	u8 oldlcr;
-	u8 efr;
-
-	oldlcr = inb(baseio + UART_LCR);
-	outb(MOXA_MUST_ENTER_ENCHANCE, baseio + UART_LCR);
-
-	efr = inb(baseio + MOXA_MUST_EFR_REGISTER);
-	efr &= ~MOXA_MUST_EFR_SF_RX_MASK;
-
-	outb(efr, baseio + MOXA_MUST_EFR_REGISTER);
-	outb(oldlcr, baseio + UART_LCR);
+	mxser_must_set_EFR(baseio, MOXA_MUST_EFR_SF_RX_MASK,
+			enable ? MOXA_MUST_EFR_SF_RX1 : 0);
 }
 
 static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
@@ -746,20 +686,8 @@ static void mxser_change_speed(struct tty_struct *tty)
 	if (info->board->must_hwid) {
 		mxser_set_must_xon1_value(info->ioaddr, START_CHAR(tty));
 		mxser_set_must_xoff1_value(info->ioaddr, STOP_CHAR(tty));
-		if (I_IXON(tty)) {
-			mxser_enable_must_rx_software_flow_control(
-					info->ioaddr);
-		} else {
-			mxser_disable_must_rx_software_flow_control(
-					info->ioaddr);
-		}
-		if (I_IXOFF(tty)) {
-			mxser_enable_must_tx_software_flow_control(
-					info->ioaddr);
-		} else {
-			mxser_disable_must_tx_software_flow_control(
-					info->ioaddr);
-		}
+		mxser_must_set_rx_sw_flow_control(info->ioaddr, I_IXON(tty));
+		mxser_must_set_tx_sw_flow_control(info->ioaddr, I_IXOFF(tty));
 	}
 
 
@@ -946,7 +874,7 @@ static void mxser_shutdown_port(struct tty_port *port)
 
 
 	if (info->board->must_hwid)
-		SET_MOXA_MUST_NO_SOFTWARE_FLOW_CONTROL(info->ioaddr);
+		mxser_must_no_sw_flow_control(info->ioaddr);
 
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -1585,8 +1513,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 
 		if (info->board->must_hwid) {
 			spin_lock_irqsave(&info->slock, flags);
-			mxser_disable_must_rx_software_flow_control(
-					info->ioaddr);
+			mxser_must_set_rx_sw_flow_control(info->ioaddr, false);
 			spin_unlock_irqrestore(&info->slock, flags);
 		}
 
-- 
2.32.0

