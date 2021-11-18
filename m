Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D8EC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F5761875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbhKRHeh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46362 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243850AbhKRHe2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AE52F218B8;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4aNQefhj5XEAEAyqJuzjWaLNlqg+b5sTu5A6txTL58=;
        b=ysCu4SPKATgF9ffio1RHqwgL6RBrSmlFrB5ZtTFzweonetAhIWgG7krUsrPTSJ1bxAPZR3
        Sxp2XjPVODleT//A3WAQurWb5LX8IvvNgnLRQOh752HXDJ0mwzSKckuPl4p35cOGOoIvQd
        iUu493oi6kFVfIBbhwKKWLJYMSxrlZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4aNQefhj5XEAEAyqJuzjWaLNlqg+b5sTu5A6txTL58=;
        b=Sa7+fOZlFvqLNcwvsjmsYAWRgxAA5Kys7Qjcbtn20FaCFWsnR/Wh/oYTt56dpAJ8Orgfol
        0SO4lyfqTPZbnbDA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85DD0A3B83;
        Thu, 18 Nov 2021 07:31:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/19] mxser: remove pointless xmit_buf checks
Date:   Thu, 18 Nov 2021 08:31:12 +0100
Message-Id: <20211118073125.12283-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

xmit_buf is supposed to exist in all these functions. I.e. from
tty_port_operations::activate() to ::shutdown(). So remove these checks.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index eb5fb4fb2aef..6e5e1c74bf3e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -929,9 +929,6 @@ static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int cou
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!info->port.xmit_buf)
-		return 0;
-
 	while (1) {
 		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					  SERIAL_XMIT_SIZE - info->xmit_head));
@@ -962,9 +959,6 @@ static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-	if (!info->port.xmit_buf)
-		return 0;
-
 	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1)
 		return 0;
 
@@ -982,7 +976,7 @@ static void mxser_flush_chars(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
-	if (!info->xmit_cnt || tty->flow.stopped || !info->port.xmit_buf ||
+	if (!info->xmit_cnt || tty->flow.stopped ||
 			(tty->hw_stopped && !mxser_16550A_or_MUST(info)))
 		return;
 
@@ -1397,7 +1391,7 @@ static void mxser_start(struct tty_struct *tty)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	if (info->xmit_cnt && info->port.xmit_buf)
+	if (info->xmit_cnt)
 		__mxser_start_tx(info);
 	spin_unlock_irqrestore(&info->slock, flags);
 }
@@ -1631,9 +1625,6 @@ static void mxser_transmit_chars(struct tty_struct *tty, struct mxser_port *port
 		return;
 	}
 
-	if (port->port.xmit_buf == NULL)
-		return;
-
 	if (!port->xmit_cnt || tty->flow.stopped ||
 			(tty->hw_stopped && !mxser_16550A_or_MUST(port))) {
 		__mxser_stop_tx(port);
-- 
2.33.1

