Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3FC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF86761269
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhKRHe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46338 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243829AbhKRHe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E235F218A8;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ee23+1ODnSdU/mKkgNL86qDgAQnmnZfSSHFlZkxlS0=;
        b=pKAk0YLLQwvXALQWicJR2QT9yCd9Q877o373+kvK54S2m95B4LoLhl9WINsGyMKe58xi4C
        ddteZu/Uz/81G8iCxTYRi4lQGmZDp4Cut+M1Q112CGnYnPut3psvhKEjdOFiVD9CXvI2vW
        v4H1W9rIIrQbBpuop8OohXfTfVyO+io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ee23+1ODnSdU/mKkgNL86qDgAQnmnZfSSHFlZkxlS0=;
        b=6tgsk5qwEZ3ZBZGv6EisY9+JsLdzzD0T2xPd+cZOAgXPmKHHTMWNXk8BBXum6memIeWV1S
        DZ9Ooxrbz7/fm4Bg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9EC5A3B83;
        Thu, 18 Nov 2021 07:31:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/19] mxser: rename mxser_close_port() to mxser_stop_rx()
Date:   Thu, 18 Nov 2021 08:31:08 +0100
Message-Id: <20211118073125.12283-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As it is the only thing it does now. This is one of the future
serial_core hooks.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f9615245a60a..e9248d39879c 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -874,16 +874,13 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 	tty_wakeup(tty);
 }
 
-
-static void mxser_close_port(struct tty_port *port)
+/*
+ * To stop accepting input, we disable the receive line status interrupts, and
+ * tell the interrupt driver to stop checking the data ready bit in the line
+ * status register.
+ */
+static void mxser_stop_rx(struct mxser_port *info)
 {
-	struct mxser_port *info = container_of(port, struct mxser_port, port);
-	/*
-	 * At this point we stop accepting input.  To do this, we
-	 * disable the receive line status interrupts, and tell the
-	 * interrupt driver to stop checking the data ready bit in the
-	 * line status register.
-	 */
 	info->IER &= ~UART_IER_RLSI;
 	if (info->board->must_hwid)
 		info->IER &= ~MOXA_MUST_RECV_ISR;
@@ -908,7 +905,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 		return;
 	info->closing = 1;
 	mutex_lock(&port->mutex);
-	mxser_close_port(port);
+	mxser_stop_rx(info);
 	mxser_flush_buffer(tty);
 	if (tty_port_initialized(port) && C_HUPCL(tty))
 		tty_port_lower_dtr_rts(port);
-- 
2.33.1

