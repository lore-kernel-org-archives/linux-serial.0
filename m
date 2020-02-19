Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69012C34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F912208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBSIl1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgBSIl0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 467EEB03B;
        Wed, 19 Feb 2020 08:41:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/24] n_hdlc: use __func__ and pr_ print helpers
Date:   Wed, 19 Feb 2020 09:41:13 +0100
Message-Id: <20200219084118.26491-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* we mark the message in n_hdlc_tty_receive as error
* we use __func__ instead of explicit function name
* we switch the remaining prints to pr_* helpers

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index cf8485beaccd..048e5a155bea 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -197,7 +197,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
 	if (n_hdlc->magic != HDLC_MAGIC) {
-		printk(KERN_WARNING "n_hdlc: trying to close unopened tty!\n");
+		pr_warn("n_hdlc: trying to close unopened tty!\n");
 		return;
 	}
 #if defined(TTY_NO_WRITE_SPLIT)
@@ -231,13 +231,13 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 
 	/* There should not be an existing table for this slot. */
 	if (n_hdlc) {
-		printk (KERN_ERR"n_hdlc_tty_open:tty already associated!\n" );
+		pr_err("%s: tty already associated!\n", __func__);
 		return -EEXIST;
 	}
 	
 	n_hdlc = n_hdlc_alloc();
 	if (!n_hdlc) {
-		printk (KERN_ERR "n_hdlc_alloc failed\n");
+		pr_err("%s: n_hdlc_alloc failed\n", __func__);
 		return -ENFILE;
 	}
 		
@@ -371,8 +371,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 
 	/* verify line is using HDLC discipline */
 	if (n_hdlc->magic != HDLC_MAGIC) {
-		printk("%s(%d) line not using HDLC discipline\n",
-			__FILE__,__LINE__);
+		pr_err("%s(%d) line not using HDLC discipline\n",
+				__FILE__, __LINE__);
 		return;
 	}
 	
@@ -431,8 +431,8 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 
 	/* verify user access to buffer */
 	if (!access_ok(buf, nr)) {
-		printk(KERN_WARNING "%s(%d) n_hdlc_tty_read() can't verify user "
-		"buffer\n", __FILE__, __LINE__);
+		pr_warn("%s(%d) %s() can't verify user buffer\n",
+				__FILE__, __LINE__, __func__);
 		return -EFAULT;
 	}
 
-- 
2.25.0

