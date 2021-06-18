Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E8C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617EA61260
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhFRGSP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhFRGRq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9206221B5C;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NT3diBbYcYFtW5DOa7+5OM7X7wD11otVgCQ/9tJnmsw=;
        b=hDutgZwhOJyDeKGgGMpqDd8O1bkJuiT1SePJATJOtLKQuA4yiNvnLJ9IbHf46LCO+xvAPa
        Kj2SLP/3P3B8IGRhXo06fKWbZC8m/fL0eC71SYLwWr9lVSTOU+cLwPKvnR1yY1FVcSo9Hh
        5E+1nwuinnAQUCquc4uVhs2qglGEMGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NT3diBbYcYFtW5DOa7+5OM7X7wD11otVgCQ/9tJnmsw=;
        b=anxs/sGDxO+61xFHguFS+u3tJPvKlQpQSaOZ5fLge/GHRHU9Mq8Wl5VlhinoJvODmZpk78
        s7S0WWrkBuQSGIDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72693A3B9E;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 35/70] mxser: drop mxser_port::baud_base
Date:   Fri, 18 Jun 2021 08:14:41 +0200
Message-Id: <20210618061516.662-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's an once-set constant, so define a macro for the constant
(MXSER_BAUD_BASE) and use it in the code instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index b47b17ec1f12..204b71c4d1ae 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -156,6 +156,8 @@
 
 #define WAKEUP_CHARS		256
 
+#define MXSER_BAUD_BASE		921600
+
 #define PCI_DEVICE_ID_POS104UL	0x1044
 #define PCI_DEVICE_ID_CB108	0x1080
 #define PCI_DEVICE_ID_CP102UF	0x1023
@@ -274,7 +276,6 @@ struct mxser_port {
 
 	u8 rx_high_water;
 	u8 rx_low_water;
-	int baud_base;		/* max. speed */
 	int type;		/* UART type */
 
 	unsigned char x_char;	/* xon/xoff character */
@@ -584,13 +585,13 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 		return -1;
 
 	if (newspd == 134) {
-		quot = 2 * info->baud_base / 269;
+		quot = 2 * MXSER_BAUD_BASE / 269;
 		tty_encode_baud_rate(tty, 134, 134);
 	} else if (newspd) {
-		quot = info->baud_base / newspd;
+		quot = MXSER_BAUD_BASE / newspd;
 		if (quot == 0)
 			quot = 1;
-		baud = info->baud_base/quot;
+		baud = MXSER_BAUD_BASE / quot;
 		tty_encode_baud_rate(tty, baud, baud);
 	} else {
 		quot = 0;
@@ -601,7 +602,7 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	 * u64 domain
 	 */
 	timeout = (u64)info->xmit_fifo_size * HZ * 10 * quot;
-	do_div(timeout, info->baud_base);
+	do_div(timeout, MXSER_BAUD_BASE);
 	info->timeout = timeout + HZ / 50; /* Add .02 seconds of slop */
 
 	if (quot) {
@@ -623,7 +624,7 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 
 #ifdef BOTHER
 	if (C_BAUD(tty) == BOTHER) {
-		quot = info->baud_base % newspd;
+		quot = MXSER_BAUD_BASE % newspd;
 		quot *= 8;
 		if (quot % newspd > newspd / 2) {
 			quot /= newspd;
@@ -1222,7 +1223,7 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	ss->port = info->ioaddr,
 	ss->irq = info->board->irq,
 	ss->flags = info->port.flags,
-	ss->baud_base = info->baud_base,
+	ss->baud_base = MXSER_BAUD_BASE,
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
 	ss->custom_divisor = info->custom_divisor,
@@ -1263,7 +1264,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		closing_wait = msecs_to_jiffies(closing_wait * 10);
 
 	if (!capable(CAP_SYS_ADMIN)) {
-		if ((ss->baud_base != info->baud_base) ||
+		if ((ss->baud_base != MXSER_BAUD_BASE) ||
 				(close_delay != info->port.close_delay) ||
 				(closing_wait != info->port.closing_wait) ||
 				((ss->flags & ~ASYNC_USR_MASK) != (info->port.flags & ~ASYNC_USR_MASK))) {
@@ -1282,7 +1283,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		port->close_delay = close_delay;
 		port->closing_wait = closing_wait;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_CUST &&
-				(ss->baud_base != info->baud_base ||
+				(ss->baud_base != MXSER_BAUD_BASE ||
 				ss->custom_divisor !=
 				info->custom_divisor)) {
 			if (ss->custom_divisor == 0) {
@@ -2018,7 +2019,7 @@ static int mxser_initbrd(struct mxser_board *brd)
 
 		process_txrx_fifo(info);
 
-		info->custom_divisor = info->baud_base * 16;
+		info->custom_divisor = MXSER_BAUD_BASE * 16;
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
 		spin_lock_init(&info->slock);
@@ -2127,10 +2128,6 @@ static int mxser_probe(struct pci_dev *pdev,
 		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
 	}
 
-	for (i = 0; i < brd->info->nports; i++) {
-		brd->ports[i].baud_base = 921600;
-	}
-
 	/* mxser_initbrd will hook ISR. */
 	retval = mxser_initbrd(brd);
 	if (retval)
-- 
2.32.0

