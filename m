Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6BC49EA3
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957916112D
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhFRGTC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59718 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbhFRGR6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E64BA21B54;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baw5roJpOwqfmTLddGrLxyNGNpRq+vYnG/7O8sjdo7U=;
        b=IoUFE5MfSGs3p1/j3wZJOOh8vdxw66YzsnmGiVlNAlq9wtAhTD4Pzx40hkLaz8iv5V/aqp
        obLimFJodK8Q/VnCNz9zjXsTone+R5zh81gBXKkaFKfTw1TGJwuyyqSUlBQwZGCs8Crsv8
        bxYfByQi9KRwJOMpCg8jnZaTXSP2FF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baw5roJpOwqfmTLddGrLxyNGNpRq+vYnG/7O8sjdo7U=;
        b=ZMZtdTflz1XBd/Yl2H8JSwl9wfinJl6Jj6aIxTTOtdkz7t5GmkNJIqZgrCWBplm+8VWCpV
        7vF58FQh4rrOhBDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEC7CA3B9F;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 60/70] mxser: remove xmit_cnt < 0 tests
Date:   Fri, 18 Jun 2021 08:15:06 +0200
Message-Id: <20210618061516.662-61-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_port::xmit_cnt is unsigned, it cannot be negative. Therefore
remove all the xmit_cnt < 0 tests.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index e46974e9421a..1a8698e58b1c 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -995,7 +995,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
-	if (info->xmit_cnt <= 0 || tty->flow.stopped || !info->port.xmit_buf ||
+	if (!info->xmit_cnt || tty->flow.stopped || !info->port.xmit_buf ||
 			(tty->hw_stopped && info->type != PORT_16550A &&
 			 !info->board->must_hwid))
 		return;
@@ -1652,7 +1652,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->port.xmit_buf == NULL)
 		return;
 
-	if (port->xmit_cnt <= 0 || tty->flow.stopped ||
+	if (!port->xmit_cnt || tty->flow.stopped ||
 			(tty->hw_stopped &&
 			(port->type != PORT_16550A) &&
 			(!port->board->must_hwid))) {
@@ -1666,7 +1666,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		outb(port->port.xmit_buf[port->xmit_tail++],
 			port->ioaddr + UART_TX);
 		port->xmit_tail = port->xmit_tail & (SERIAL_XMIT_SIZE - 1);
-		if (--port->xmit_cnt <= 0)
+		if (!--port->xmit_cnt)
 			break;
 	} while (--count > 0);
 
@@ -1675,7 +1675,7 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 	if (port->xmit_cnt < WAKEUP_CHARS)
 		tty_wakeup(tty);
 
-	if (port->xmit_cnt <= 0)
+	if (!port->xmit_cnt)
 		__mxser_stop_tx(port);
 }
 
-- 
2.32.0

