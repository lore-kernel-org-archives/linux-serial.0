Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA2C43334
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 06:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiGAGTH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Jul 2022 02:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiGAGSm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Jul 2022 02:18:42 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63646366BB
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 23:18:40 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20220701061840dbbb3418a156e8de11
        for <linux-serial@vger.kernel.org>;
        Fri, 01 Jul 2022 08:18:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hjQl0FPxrMUetA3a87IYFksbJSaLl9xsI+je70cRZqM=;
 b=WwJWY+AqJ0yszhDL22wqIFPKl5UAOQQTnzWqffkXOsTLHjPiI2OR+aQFxoX9q/2GZFg5Po
 tEWt6MCAtRgcM6SR2sYje5/c065qDJ4bwBI/73xJ2676DJqNsHKWtw5FmxV5Z/YbInU2eiZ2
 iK3N6/xJdFApzl4QSm1lk0vdD9770=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 9/9] tty: n_gsm: fix race condition in gsmld_write()
Date:   Fri,  1 Jul 2022 08:16:52 +0200
Message-Id: <20220701061652.39604-9-daniel.starke@siemens.com>
In-Reply-To: <20220701061652.39604-1-daniel.starke@siemens.com>
References: <20220701061652.39604-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The function may be used by the user directly and also by the n_gsm
internal functions. They can lead into a race condition which results in
interleaved frames if both are writing at the same time. The receiving side
is not able to decode those interleaved frames correctly.

Add a lock around the low side tty write to avoid race conditions and frame
interleaving between user originated writes and n_gsm writes.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

Stable backport remark has been removed compared to v3. No other changes applied.

Link: https://lore.kernel.org/all/20220530144512.2731-9-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b0b093e8e9d9..afd179a8481d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2999,11 +2999,24 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
-	int space = tty_write_room(tty);
+	struct gsm_mux *gsm = tty->disc_data;
+	unsigned long flags;
+	int space;
+	int ret;
+
+	if (!gsm)
+		return -ENODEV;
+
+	ret = -ENOBUFS;
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	space = tty_write_room(tty);
 	if (space >= nr)
-		return tty->ops->write(tty, buf, nr);
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	return -ENOBUFS;
+		ret = tty->ops->write(tty, buf, nr);
+	else
+		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	return ret;
 }
 
 /**
-- 
2.34.1

