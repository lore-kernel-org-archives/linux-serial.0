Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC13C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C077617E3
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbhKRHep (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 31FE91FD3A;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjnWMWGIfoPwUUlnn6KHn1yJDyNJ5XWkVE80iGAbOzY=;
        b=NBroRiGaVBAnwvsuMsQMPfxZPuK63QZp5Irq3cK2v03K/cvD2NSbf6bQjPzRVPkBM6I93g
        QeQsHtsJCFA50K7QITiD4q7RQg0KBpKJL58fmF5WuISl0cpCfkqYzUZkdw2y+9Abeyq4Gy
        yiEK1gq87BXI2LFncTLGPB7NYILFkRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjnWMWGIfoPwUUlnn6KHn1yJDyNJ5XWkVE80iGAbOzY=;
        b=DtIgzRgd/zCdWlR3WGGubvm9rD4nD9/vxbzHhVHyOVxt0LJLdjaWpbCUg701Fjlnm8NslS
        1QGJAKltxQZxBLBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 091BAA3B84;
        Thu, 18 Nov 2021 07:31:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/19] mxser: clean up timeout handling in mxser_wait_until_sent()
Date:   Thu, 18 Nov 2021 08:31:19 +0100
Message-Id: <20211118073125.12283-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

timeout cannot be zero at the point of use. So no need to check for
zero. Also precompute the expiration time (into expire) and use it. This
makes the code more clear.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index b3ae3b105af0..c3f262dc936d 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1420,7 +1420,7 @@ static bool mxser_tx_empty(struct mxser_port *info)
 static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long orig_jiffies, char_time;
+	unsigned long expire, char_time;
 
 	if (info->type == PORT_UNKNOWN)
 		return;
@@ -1428,7 +1428,6 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (info->xmit_fifo_size == 0)
 		return;		/* Just in case.... */
 
-	orig_jiffies = jiffies;
 	/*
 	 * Set the check interval to be 1/5 of the estimated time to
 	 * send a single character, and make it at least 1.  The check
@@ -1458,11 +1457,13 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 	if (!timeout || timeout > 2 * info->timeout)
 		timeout = 2 * info->timeout;
 
+	expire = jiffies + timeout;
+
 	while (mxser_tx_empty(info)) {
 		msleep_interruptible(char_time);
 		if (signal_pending(current))
 			break;
-		if (timeout && time_after(jiffies, orig_jiffies + timeout))
+		if (time_after(jiffies, expire))
 			break;
 	}
 }
-- 
2.33.1

