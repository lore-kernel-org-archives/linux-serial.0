Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24159C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBE8222D9
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgBSImA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgBSIl2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9165ADA1;
        Wed, 19 Feb 2020 08:41:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/24] n_hdlc: remove useless whitespace at line wraps
Date:   Wed, 19 Feb 2020 09:41:14 +0100
Message-Id: <20200219084118.26491-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Do
  s@[ \t]\+$@@
  s@ \+\t@\t@
on the file as there are many spaces at the begininning of lines and
many spaces/tabs at EOLs. And vim screamed.

git show -w is supposed to show no difference here.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 74 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 048e5a155bea..ee27573b0624 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -18,7 +18,7 @@
  * All HDLC data is frame oriented which means:
  *
  * 1. tty write calls represent one complete transmit frame of data
- *    The device driver should accept the complete frame or none of 
+ *    The device driver should accept the complete frame or none of
  *    the frame (busy) in the write method. Each write call should have
  *    a byte count in the range of 2-65535 bytes (2 is min HDLC frame
  *    with 1 addr byte and 1 ctrl byte). The max byte count of 65535
@@ -39,7 +39,7 @@
  *    tty read calls.
  *
  * 3. tty read calls returns an entire frame of data or nothing.
- *    
+ *
  * 4. all send and receive data is considered raw. No processing
  *    or translation is performed by the line discipline, regardless
  *    of the tty flags
@@ -104,7 +104,7 @@
 /*
  * Buffers for individual HDLC frames
  */
-#define MAX_HDLC_FRAME_SIZE 65535 
+#define MAX_HDLC_FRAME_SIZE 65535
 #define DEFAULT_RX_BUF_COUNT 10
 #define MAX_RX_BUF_COUNT 60
 #define DEFAULT_TX_BUF_COUNT 3
@@ -234,24 +234,24 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 		pr_err("%s: tty already associated!\n", __func__);
 		return -EEXIST;
 	}
-	
+
 	n_hdlc = n_hdlc_alloc();
 	if (!n_hdlc) {
 		pr_err("%s: n_hdlc_alloc failed\n", __func__);
 		return -ENFILE;
 	}
-		
+
 	tty->disc_data = n_hdlc;
 	tty->receive_room = 65536;
-	
+
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
-	
+
 	/* flush receive data from driver */
 	tty_driver_flush_buffer(tty);
 
 	return 0;
-	
+
 }	/* end of n_tty_hdlc_open() */
 
 /**
@@ -269,9 +269,9 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
 
- check_again:
-		
- 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
+check_again:
+
+	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	if (n_hdlc->tbusy) {
 		n_hdlc->woke_up = true;
 		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
@@ -299,7 +299,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		/* pretending it was accepted by driver */
 		if (actual < 0)
 			actual = tbuf->count;
-		
+
 		if (actual == tbuf->count) {
 			pr_debug("%s(%d)frame %p completed\n",
 					__FILE__, __LINE__, tbuf);
@@ -309,7 +309,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 			/* wait up sleeping writers */
 			wake_up_interruptible(&tty->write_wait);
-	
+
 			/* get next pending transmit buffer */
 			tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 		} else {
@@ -324,17 +324,17 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			break;
 		}
 	}
-	
+
 	if (!tbuf)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	
+
 	/* Clear the re-entry flag */
 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	n_hdlc->tbusy = false;
-	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags); 
-	
-        if (n_hdlc->woke_up)
-	  goto check_again;
+	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+
+	if (n_hdlc->woke_up)
+		goto check_again;
 }	/* end of n_hdlc_send_frames() */
 
 /**
@@ -375,14 +375,14 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 				__FILE__, __LINE__);
 		return;
 	}
-	
+
 	if ( count>maxframe ) {
 		pr_debug("%s(%d) rx count>maxframesize, data discarded\n",
 				__FILE__, __LINE__);
 		return;
 	}
 
-	/* get a free HDLC buffer */	
+	/* get a free HDLC buffer */
 	buf = n_hdlc_buf_get(&n_hdlc->rx_free_buf_list);
 	if (!buf) {
 		/* no buffers in free list, attempt to allocate another rx buffer */
@@ -391,20 +391,20 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 			buf = kmalloc(struct_size(buf, buf, maxframe),
 				      GFP_ATOMIC);
 	}
-	
+
 	if (!buf) {
 		pr_debug("%s(%d) no more rx buffers, data discarded\n",
 				__FILE__, __LINE__);
 		return;
 	}
-		
+
 	/* copy received data to HDLC buffer */
 	memcpy(buf->buf,data,count);
 	buf->count=count;
 
 	/* add HDLC buffer to list of received frames */
 	n_hdlc_buf_put(&n_hdlc->rx_buf_list, buf);
-	
+
 	/* wake up any blocked reads and perform async signalling */
 	wake_up_interruptible (&tty->read_wait);
 	if (tty->fasync != NULL)
@@ -418,7 +418,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
  * @file - pointer to open file object
  * @buf - pointer to returned data buffer
  * @nr - size of returned data buffer
- * 	
+ *
  * Returns the number of bytes returned or error code.
  */
 static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
@@ -468,7 +468,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 				n_hdlc_buf_put(&n_hdlc->rx_free_buf_list, rbuf);
 			break;
 		}
-			
+
 		/* no data */
 		if (tty_io_nonblock(tty, file)) {
 			ret = -EAGAIN;
@@ -487,7 +487,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	__set_current_state(TASK_RUNNING);
 
 	return ret;
-	
+
 }	/* end of n_hdlc_tty_read() */
 
 /**
@@ -496,7 +496,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
  * @file - pointer to file object data
  * @data - pointer to transmit data (one frame)
  * @count - size of transmit frame in bytes
- * 		
+ *
  * Returns the number of bytes written (or error code).
  */
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
@@ -519,12 +519,12 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				__func__, count, maxframe);
 		count = maxframe;
 	}
-	
+
 	add_wait_queue(&tty->write_wait, &wait);
 
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-	
+
 		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
 		if (tbuf)
 			break;
@@ -544,7 +544,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tty->write_wait, &wait);
 
-	if (!error) {		
+	if (!error) {
 		/* Retrieve the user's buffer */
 		memcpy(tbuf->buf, data, count);
 
@@ -555,7 +555,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	}
 
 	return error;
-	
+
 }	/* end of n_hdlc_tty_write() */
 
 /**
@@ -623,7 +623,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 	}
 	return error;
-	
+
 }	/* end of n_hdlc_tty_ioctl() */
 
 /**
@@ -631,7 +631,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
  * @tty - pointer to tty instance data
  * @filp - pointer to open file object for device
  * @poll_table - wait queue for operations
- * 
+ *
  * Determine which operations (read/write) will not block and return info
  * to caller.
  * Returns a bit mask containing info on which ops will not block.
@@ -712,7 +712,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	n_hdlc->magic  = HDLC_MAGIC;
 
 	return n_hdlc;
-	
+
 }	/* end of n_hdlc_alloc() */
 
 /**
@@ -754,7 +754,7 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 /**
  * n_hdlc_buf_get - remove and return an HDLC buffer from list
  * @buf_list - pointer to HDLC buffer list
- * 
+ *
  * Remove and return an HDLC buffer from the head of the specified HDLC buffer
  * list.
  * Returns a pointer to HDLC buffer if available, otherwise %NULL.
@@ -808,7 +808,7 @@ static int __init n_hdlc_init(void)
 				status);
 
 	return status;
-	
+
 }	/* end of init_module() */
 
 static void __exit n_hdlc_exit(void)
-- 
2.25.0

