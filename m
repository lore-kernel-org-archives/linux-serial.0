Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D1C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756A8611C9
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhIVIBN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE0A8201C3;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWKicJrcp85MwAS6GIvsxnSe5JQ/IEeheZQNsIaTEME=;
        b=1X9GecDMRiasJ6/Dnd8sl0yFVlQMyp76ZJT0t+jXViFvRtFCLEeIH/brkgsL5NdXs75aOD
        9qXo/1Hq/EMrxjXjqN8RMxduvOsjXtvhQUai8Cv6LK+o4ibV/G31h8RYKNagGPXnYD2kf9
        eas8giVjVbqnkFrKzGEe2Ieefb7cQnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWKicJrcp85MwAS6GIvsxnSe5JQ/IEeheZQNsIaTEME=;
        b=6kCHZKtp8MVjJNupJqbJ9iTttLKTGOfBYjqrOWkBeglikUpAQwEfwzMMuD3NhJzsS52n01
        k4vgE9I6h1A2dXDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B737AA3B8D;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/7] mxser: don't read from UART_FCR
Date:   Wed, 22 Sep 2021 09:59:37 +0200
Message-Id: <20210922075938.31390-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART_FCR register is write-only. When reading it, one gets contents
of (read-only) UART_IIR instead as they are shared. This mistake was
performed in mxser_flush_buffer() to clear FIFOs.

Actually FCR handling throughout the driver is completely broken. On
many places, it respects neither mu860 settings, nor FIFO (16450 vs
16550) setting. This patch doesn't help to fix this, it actually does
the same. We will introduce a mxser_port::FCR in the next patch to fix
this issue.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6913a1caa6f0..4ce21cdb1ea5 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -859,17 +859,14 @@ static int mxser_open(struct tty_struct *tty, struct file *filp)
 static void mxser_flush_buffer(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	char fcr;
 	unsigned long flags;
 
 
 	spin_lock_irqsave(&info->slock, flags);
 	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
 
-	fcr = inb(info->ioaddr + UART_FCR);
-	outb((fcr | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT),
+	outb(UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		info->ioaddr + UART_FCR);
-	outb(fcr, info->ioaddr + UART_FCR);
 
 	spin_unlock_irqrestore(&info->slock, flags);
 
-- 
2.33.0

