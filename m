Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F2C0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2C520674
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgCPGtO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgCPGtO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 02:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71A6EAEA6;
        Mon, 16 Mar 2020 06:49:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Joe Perches <joe@perches.com>
Subject: [PATCH] tty: n_hdlc, remove FILE and LINE from pr_debug
Date:   Mon, 16 Mar 2020 07:49:10 +0100
Message-Id: <20200316064910.4941-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As Joe suggests, dynamic debug can print module name and line number
along with message. So remove __FILE__ and __LINE__ from all those
pr_debug calls.

Out of curiosity, I measured the savings, 200 bytes of code are gone.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Suggested-by: Joe Perches <joe@perches.com>
---
 drivers/tty/n_hdlc.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index cd1319d26c45..991f49ee4026 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -226,8 +226,7 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	pr_debug("%s(%d)%s() called (device=%s)\n",
-			__FILE__, __LINE__, __func__, tty->name);
+	pr_debug("%s() called (device=%s)\n", __func__, tty->name);
 
 	/* There should not be an existing table for this slot. */
 	if (n_hdlc) {
@@ -283,8 +282,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
-		pr_debug("%s(%d)sending frame %p, count=%d\n",
-				__FILE__, __LINE__, tbuf, tbuf->count);
+		pr_debug("sending frame %p, count=%d\n", tbuf, tbuf->count);
 
 		/* Send the next block of data to device */
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -301,8 +299,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			actual = tbuf->count;
 
 		if (actual == tbuf->count) {
-			pr_debug("%s(%d)frame %p completed\n",
-					__FILE__, __LINE__, tbuf);
+			pr_debug("frame %p completed\n", tbuf);
 
 			/* free current transmit buffer */
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list, tbuf);
@@ -313,8 +310,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 			/* get next pending transmit buffer */
 			tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 		} else {
-			pr_debug("%s(%d)frame %p pending\n",
-					__FILE__, __LINE__, tbuf);
+			pr_debug("frame %p pending\n", tbuf);
 
 			/*
 			 * the buffer was not accepted by driver,
@@ -366,19 +362,16 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
 
-	pr_debug("%s(%d)%s() called count=%d\n",
-			__FILE__, __LINE__, __func__, count);
+	pr_debug("%s() called count=%d\n", __func__, count);
 
 	/* verify line is using HDLC discipline */
 	if (n_hdlc->magic != HDLC_MAGIC) {
-		pr_err("%s(%d) line not using HDLC discipline\n",
-				__FILE__, __LINE__);
+		pr_err("line not using HDLC discipline\n");
 		return;
 	}
 
 	if (count > maxframe) {
-		pr_debug("%s(%d) rx count>maxframesize, data discarded\n",
-				__FILE__, __LINE__);
+		pr_debug("rx count>maxframesize, data discarded\n");
 		return;
 	}
 
@@ -395,8 +388,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	}
 
 	if (!buf) {
-		pr_debug("%s(%d) no more rx buffers, data discarded\n",
-				__FILE__, __LINE__);
+		pr_debug("no more rx buffers, data discarded\n");
 		return;
 	}
 
@@ -509,8 +501,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
 
-	pr_debug("%s(%d)%s() called count=%zd\n", __FILE__, __LINE__, __func__,
-			count);
+	pr_debug("%s() called count=%zd\n", __func__, count);
 
 	if (n_hdlc->magic != HDLC_MAGIC)
 		return -EIO;
@@ -578,7 +569,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 	unsigned long flags;
 	struct n_hdlc_buf *buf = NULL;
 
-	pr_debug("%s(%d)%s() called %d\n", __FILE__, __LINE__, __func__, cmd);
+	pr_debug("%s() called %d\n", __func__, cmd);
 
 	/* Verify the status of the device */
 	if (n_hdlc->magic != HDLC_MAGIC)
@@ -677,8 +668,8 @@ static void n_hdlc_alloc_buf(struct n_hdlc_buf_list *list, unsigned int count,
 	for (i = 0; i < count; i++) {
 		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
 		if (!buf) {
-			pr_debug("%s(%d)%s(), kmalloc() failed for %s buffer %u\n",
-					__FILE__, __LINE__, __func__, name, i);
+			pr_debug("%s(), kmalloc() failed for %s buffer %u\n",
+					__func__, name, i);
 			return;
 		}
 		n_hdlc_buf_put(list, buf);
-- 
2.25.1

