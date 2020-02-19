Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E2BC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DC5208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSIlW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgBSIlW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A135ADA1;
        Wed, 19 Feb 2020 08:41:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/24] n_hdlc: remove tracing debug prints
Date:   Wed, 19 Feb 2020 09:40:55 +0100
Message-Id: <20200219084118.26491-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We can trace functions using ftrace, so there is no need for this
additional prints. Remove them.

We keep only those which print some additional info, not only function
name & "entry"/"exit".

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 27b506bf03ce..9e115ecf920d 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -232,10 +232,7 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
 {
 	struct tty_struct *tty = n_hdlc2tty (n_hdlc);
 	struct n_hdlc_buf *buf;
-	
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_release() called\n",__FILE__,__LINE__);
-		
+
 	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
 	wake_up_interruptible (&tty->read_wait);
 	wake_up_interruptible (&tty->write_wait);
@@ -287,9 +284,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_close() called\n",__FILE__,__LINE__);
-		
 	if (n_hdlc != NULL) {
 		if (n_hdlc->magic != HDLC_MAGIC) {
 			printk (KERN_WARNING"n_hdlc: trying to close unopened tty!\n");
@@ -309,10 +303,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 			n_hdlc_release (n_hdlc);
 		}
 	}
-	
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_close() success\n",__FILE__,__LINE__);
-		
 }	/* end of n_hdlc_tty_close() */
 
 /**
@@ -353,10 +343,7 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 	
 	/* flush receive data from driver */
 	tty_driver_flush_buffer(tty);
-		
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_open() success\n",__FILE__,__LINE__);
-		
+
 	return 0;
 	
 }	/* end of n_tty_hdlc_open() */
@@ -376,8 +363,6 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_send_frames() called\n",__FILE__,__LINE__);
  check_again:
 		
  	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
@@ -447,10 +432,6 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	
         if (n_hdlc->woke_up)
 	  goto check_again;
-
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_send_frames() exit\n",__FILE__,__LINE__);
-		
 }	/* end of n_hdlc_send_frames() */
 
 /**
@@ -463,9 +444,6 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_wakeup() called\n",__FILE__,__LINE__);
-		
 	if (!n_hdlc)
 		return;
 
@@ -564,9 +542,6 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	struct n_hdlc_buf *rbuf;
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_read() called\n",__FILE__,__LINE__);
-		
 	/* Validate the pointers */
 	if (!n_hdlc)
 		return -EIO;
@@ -802,9 +777,6 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	__poll_t mask = 0;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_poll() called\n",__FILE__,__LINE__);
-		
 	if (n_hdlc && n_hdlc->magic == HDLC_MAGIC && tty == n_hdlc->tty) {
 		/* queue current process into any wait queue that */
 		/* may awaken in the future (read and write) */
-- 
2.25.0

