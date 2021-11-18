Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1720DC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014E361A62
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbhKRHen (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46376 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243857AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3C0221891;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvvzHaBwP25vZWCSj8PmdgQ1gXUuj2rwOUjItwZNQYY=;
        b=0DubX3fMxIL+odNyV8ocULVlMlC2N2SP+RHqkSKk0C/Uh4TDXKYKnI1giiD8hDO7a4IyYu
        uSXZuGAetdR77mAPf7Sg/JiK8KNUkFJSQD8xSnX0vmeA/rd/PxOce1W45uj3uZmOU9oH4+
        5JqJxGciLSzA6SREkqGaO1Jl7+y9i7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YvvzHaBwP25vZWCSj8PmdgQ1gXUuj2rwOUjItwZNQYY=;
        b=Jv9v9MK1+9IiEmP0St0gKjyXzrt/CYZY8WnV5m7j6yncf3+JMDoZ1K+lfuKiQSufAcmiBb
        0sw31ag9xaNewKAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97B83A3B84;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/19] mxser: extract TX empty check from mxser_wait_until_sent()
Date:   Thu, 18 Nov 2021 08:31:17 +0100
Message-Id: <20211118073125.12283-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

And move it to new mxser_tx_empty(), because:
1) it simplifies the code (esp. the locking), and
2) serial_core needs such a hook anyway, so have it ready.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6ab8899ada9c..fb26670b5a0b 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1402,6 +1402,18 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	}
 }
 
+static bool mxser_tx_empty(struct mxser_port *info)
+{
+	unsigned long flags;
+	u8 lsr;
+
+	spin_lock_irqsave(&info->slock, flags);
+	lsr = inb(info->ioaddr + UART_LSR);
+	spin_unlock_irqrestore(&info->slock, flags);
+
+	return !(lsr & UART_LSR_TEMT);
+}
+
 /*
  * mxser_wait_until_sent() --- wait until the transmitter is empty
  */
@@ -1409,8 +1421,6 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long orig_jiffies, char_time;
-	unsigned long flags;
-	int lsr;
 
 	if (info->type == PORT_UNKNOWN)
 		return;
@@ -1445,17 +1455,13 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (!timeout || timeout > 2 * info->timeout)
 		timeout = 2 * info->timeout;
 
-	spin_lock_irqsave(&info->slock, flags);
-	while (!((lsr = inb(info->ioaddr + UART_LSR)) & UART_LSR_TEMT)) {
-		spin_unlock_irqrestore(&info->slock, flags);
+	while (mxser_tx_empty(info)) {
 		schedule_timeout_interruptible(char_time);
-		spin_lock_irqsave(&info->slock, flags);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	spin_unlock_irqrestore(&info->slock, flags);
 	set_current_state(TASK_RUNNING);
 }
 
-- 
2.33.1

