Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7FFC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46713208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSInG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:43:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:44240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbgBSIlW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AB35AE5E;
        Wed, 19 Feb 2020 08:41:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/24] n_hdlc: convert debuglevel use to pr_debug
Date:   Wed, 19 Feb 2020 09:40:57 +0100
Message-Id: <20200219084118.26491-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

With pr_debug we have a fine-grained control about debugging prints. So
convert the use of global debuglevel variable and tests to a commonly
used pr_debug. And drop debuglevel completely.

This also implicitly adds a loglevel to the messages (KERN_DEBUG) as it
was missing on most of them.

And also use __func__ instead of function names explicitly typed.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 79 +++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 881da4d440c8..e37dab2528a1 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -160,10 +160,6 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *list);
 
 static struct n_hdlc *n_hdlc_alloc (void);
 
-/* debug level can be set by insmod for debugging purposes */
-#define DEBUG_LEVEL_INFO	1
-static int debuglevel;
-
 /* max frame size for memory allocations */
 static int maxframe = 4096;
 
@@ -310,11 +306,9 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_open() called (device=%s)\n",
-		__FILE__,__LINE__,
-		tty->name);
-		
+	pr_debug("%s(%d)%s() called (device=%s)\n",
+			__FILE__, __LINE__, __func__, tty->name);
+
 	/* There should not be an existing table for this slot. */
 	if (n_hdlc) {
 		printk (KERN_ERR"n_hdlc_tty_open:tty already associated!\n" );
@@ -372,10 +366,9 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
-			printk("%s(%d)sending frame %p, count=%d\n",
-				__FILE__,__LINE__,tbuf,tbuf->count);
-			
+		pr_debug("%s(%d)sending frame %p, count=%d\n",
+				__FILE__, __LINE__, tbuf, tbuf->count);
+
 		/* Send the next block of data to device */
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		actual = tty->ops->write(tty, tbuf->buf, tbuf->count);
@@ -391,10 +384,9 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			actual = tbuf->count;
 		
 		if (actual == tbuf->count) {
-			if (debuglevel >= DEBUG_LEVEL_INFO)	
-				printk("%s(%d)frame %p completed\n",
-					__FILE__,__LINE__,tbuf);
-					
+			pr_debug("%s(%d)frame %p completed\n",
+					__FILE__, __LINE__, tbuf);
+
 			/* free current transmit buffer */
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list, tbuf);
 
@@ -404,9 +396,8 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			/* get next pending transmit buffer */
 			tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 		} else {
-			if (debuglevel >= DEBUG_LEVEL_INFO)	
-				printk("%s(%d)frame %p pending\n",
-					__FILE__,__LINE__,tbuf);
+			pr_debug("%s(%d)frame %p pending\n",
+					__FILE__, __LINE__, tbuf);
 
 			/*
 			 * the buffer was not accepted by driver,
@@ -467,10 +458,9 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	register struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	register struct n_hdlc_buf *buf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_receive() called count=%d\n",
-			__FILE__,__LINE__, count);
-		
+	pr_debug("%s(%d)%s() called count=%d\n",
+			__FILE__, __LINE__, __func__, count);
+
 	/* This can happen if stuff comes in on the backup tty */
 	if (!n_hdlc || tty != n_hdlc->tty)
 		return;
@@ -483,9 +473,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	}
 	
 	if ( count>maxframe ) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
-			printk("%s(%d) rx count>maxframesize, data discarded\n",
-			       __FILE__,__LINE__);
+		pr_debug("%s(%d) rx count>maxframesize, data discarded\n",
+				__FILE__, __LINE__);
 		return;
 	}
 
@@ -500,9 +489,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	}
 	
 	if (!buf) {
-		if (debuglevel >= DEBUG_LEVEL_INFO)	
-			printk("%s(%d) no more rx buffers, data discarded\n",
-			       __FILE__,__LINE__);
+		pr_debug("%s(%d) no more rx buffers, data discarded\n",
+				__FILE__, __LINE__);
 		return;
 	}
 		
@@ -619,10 +607,9 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_write() called count=%zd\n",
-			__FILE__,__LINE__,count);
-		
+	pr_debug("%s(%d)%s() called count=%zd\n", __FILE__, __LINE__, __func__,
+			count);
+
 	/* Verify pointers */
 	if (!n_hdlc)
 		return -EIO;
@@ -632,11 +619,8 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 
 	/* verify frame size */
 	if (count > maxframe ) {
-		if (debuglevel & DEBUG_LEVEL_INFO)
-			printk (KERN_WARNING
-				"n_hdlc_tty_write: truncating user packet "
-				"from %lu to %d\n", (unsigned long) count,
-				maxframe );
+		pr_debug("%s: truncating user packet from %zu to %d\n",
+				__func__, count, maxframe);
 		count = maxframe;
 	}
 	
@@ -704,10 +688,8 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned long flags;
 	struct n_hdlc_buf *buf = NULL;
 
-	if (debuglevel >= DEBUG_LEVEL_INFO)	
-		printk("%s(%d)n_hdlc_tty_ioctl() called %d\n",
-			__FILE__,__LINE__,cmd);
-		
+	pr_debug("%s(%d)%s() called %d\n", __FILE__, __LINE__, __func__, cmd);
+
 	/* Verify the status of the device */
 	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
 		return -EBADF;
@@ -822,8 +804,9 @@ static struct n_hdlc *n_hdlc_alloc(void)
 		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list,buf);
-		else if (debuglevel >= DEBUG_LEVEL_INFO)	
-			printk("%s(%d)n_hdlc_alloc(), kalloc() failed for rx buffer %d\n",__FILE__,__LINE__, i);
+		else
+			pr_debug("%s(%d)%s(), kmalloc() failed for rx buffer %d\n",
+					__FILE__, __LINE__, __func__, i);
 	}
 	
 	/* allocate free tx buffer list */
@@ -831,8 +814,9 @@ static struct n_hdlc *n_hdlc_alloc(void)
 		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list,buf);
-		else if (debuglevel >= DEBUG_LEVEL_INFO)	
-			printk("%s(%d)n_hdlc_alloc(), kalloc() failed for tx buffer %d\n",__FILE__,__LINE__, i);
+		else
+			pr_debug("%s(%d)%s(), kmalloc() failed for tx buffer %d\n",
+					__FILE__, __LINE__, __func__, i);
 	}
 	
 	/* Initialize the control block */
@@ -960,6 +944,5 @@ module_exit(n_hdlc_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Fulghum paulkf@microgate.com");
-module_param(debuglevel, int, 0);
 module_param(maxframe, int, 0);
 MODULE_ALIAS_LDISC(N_HDLC);
-- 
2.25.0

