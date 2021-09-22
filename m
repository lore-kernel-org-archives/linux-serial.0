Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB6C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C9961247
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhIVIBL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6704201C1;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YP87oq4aMkE18Ix2OtVroKl3jYiFfi+eGATswpt4AI=;
        b=BeDPaaqIcCQU0NQPApqLQfUI4qpff6zc1F0NgzSBix7YB8LUWxy+6uQ9DvV5lmJYpBPB7q
        hx9busWgNk3guFfpZpD1JCK+BalbBTVDAmLHXqFjUOGnuGHSYUlBFIwQ57//DD6Vk2s6hN
        yLGLK/dY1w1sPeLIYimxpz1jEIqEz74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YP87oq4aMkE18Ix2OtVroKl3jYiFfi+eGATswpt4AI=;
        b=gga3ZtL+0nHzSl9yLXMspSa9QDSNOxXjqVSRLbNIrLTWNVvuqSX6Lsguwlo5dexhlqt8md
        sPNOwbqyG+b8T5Dw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E4B4A3B8B;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/7] mxser: move FIFO clearing to mxser_disable_and_clear_FIFO()
Date:   Wed, 22 Sep 2021 09:59:36 +0200
Message-Id: <20210922075938.31390-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This code is used on two places, make a helper for disabling and
clearing FIFOs. And demangle the too complicated 'if' by using a local
variable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index c194a96bb14e..6913a1caa6f0 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -706,6 +706,16 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 		mxser_handle_cts(tty, port, status);
 }
 
+static void mxser_disable_and_clear_FIFO(struct mxser_port *info)
+{
+	u8 fcr = UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
+
+	if (info->board->must_hwid)
+		fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
+
+	outb(fcr, info->ioaddr + UART_FCR);
+}
+
 static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct mxser_port *info = container_of(port, struct mxser_port, port);
@@ -730,13 +740,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	 * Clear the FIFO buffers and disable them
 	 * (they will be reenabled in mxser_change_speed())
 	 */
-	if (info->board->must_hwid)
-		outb((UART_FCR_CLEAR_RCVR |
-			UART_FCR_CLEAR_XMIT |
-			MOXA_MUST_FCR_GDA_MODE_ENABLE), info->ioaddr + UART_FCR);
-	else
-		outb((UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
-			info->ioaddr + UART_FCR);
+	mxser_disable_and_clear_FIFO(info);
 
 	/*
 	 * At this point there's no way the LSR could still be 0xFF;
@@ -824,13 +828,7 @@ static void mxser_shutdown_port(struct tty_port *port)
 	outb(0x00, info->ioaddr + UART_IER);
 
 	/* clear Rx/Tx FIFO's */
-	if (info->board->must_hwid)
-		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT |
-				MOXA_MUST_FCR_GDA_MODE_ENABLE,
-				info->ioaddr + UART_FCR);
-	else
-		outb(UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-			info->ioaddr + UART_FCR);
+	mxser_disable_and_clear_FIFO(info);
 
 	/* read data port to reset things */
 	(void) inb(info->ioaddr + UART_RX);
-- 
2.33.0

