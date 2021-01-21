Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D6C433E6
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D24239D3
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 09:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbhAUJB1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 04:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbhAUJBX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 04:01:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3501239D0;
        Thu, 21 Jan 2021 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611219642;
        bh=+2580XlyPCygFJqth8dGxcLiiQqLEF1UMdMIvlK7pWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOI1cB82otEZ70vMnPGHq/AfSutnn1P/d9wyhIgXT8We/5toGZy5qxP6l+/BgE6WO
         lCHh6RboQxAQ6kjFJzd6liVS0MQkFDUhJSX9s48rBkPC9OHntuEk3mY+xvoG8PmlTl
         sQAalWu26Q446KYbGDmqShBeRbumfFM81xo4T3Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jirislaby@kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hch@lst.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, ohw.giles@gmail.com,
        r.karszniewicz@phytec.de,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/6] tty: implement read_iter
Date:   Thu, 21 Jan 2021 10:00:17 +0100
Message-Id: <20210121090020.3147058-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

Now that the ldisc read() function takes kernel pointers, it's fairly
straightforward to make the tty file operations use .read_iter() instead
of .read().

That automatically gives us vread() and friends, and also makes it
possible to do .splice_read() on ttys again.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Reported-by: Oliver Giles <ohw.giles@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/tty/tty_io.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a34f8bcf875e..8846d3b99845 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -142,7 +142,7 @@ LIST_HEAD(tty_drivers);			/* linked list of tty drivers */
 /* Mutex to protect creating and releasing a tty */
 DEFINE_MUTEX(tty_mutex);
 
-static ssize_t tty_read(struct file *, char __user *, size_t, loff_t *);
+static ssize_t tty_read(struct kiocb *, struct iov_iter *);
 static ssize_t tty_write(struct kiocb *, struct iov_iter *);
 ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 static __poll_t tty_poll(struct file *, poll_table *);
@@ -476,8 +476,9 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 
 static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
-	.read		= tty_read,
+	.read_iter	= tty_read,
 	.write_iter	= tty_write,
+	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
@@ -490,8 +491,9 @@ static const struct file_operations tty_fops = {
 
 static const struct file_operations console_fops = {
 	.llseek		= no_llseek,
-	.read		= tty_read,
+	.read_iter	= tty_read,
 	.write_iter	= redirected_tty_write,
+	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.poll		= tty_poll,
 	.unlocked_ioctl	= tty_ioctl,
@@ -844,16 +846,17 @@ static void tty_update_time(struct timespec64 *time)
  * data or clears the cookie. The cookie may be something that the
  * ldisc maintains state for and needs to free.
  */
-static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct file *file,
-		char __user *buf, size_t count)
+static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
+		struct file *file, struct iov_iter *to)
 {
 	int retval = 0;
 	void *cookie = NULL;
 	unsigned long offset = 0;
 	char kernel_buf[64];
+	size_t count = iov_iter_count(to);
 
 	do {
-		int size, uncopied;
+		int size, copied;
 
 		size = count > sizeof(kernel_buf) ? sizeof(kernel_buf) : count;
 		size = ld->ops->read(tty, file, kernel_buf, size, &cookie, offset);
@@ -869,10 +872,9 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct
 			return size;
 		}
 
-		uncopied = copy_to_user(buf+offset, kernel_buf, size);
-		size -= uncopied;
-		offset += size;
-		count -= size;
+		copied = copy_to_iter(kernel_buf, size, to);
+		offset += copied;
+		count -= copied;
 
 		/*
 		 * If the user copy failed, we still need to do another ->read()
@@ -880,7 +882,7 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct
 		 *
 		 * But make sure size is zeroed.
 		 */
-		if (unlikely(uncopied)) {
+		if (unlikely(copied != size)) {
 			count = 0;
 			retval = -EFAULT;
 		}
@@ -907,10 +909,10 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty, struct
  *	read calls may be outstanding in parallel.
  */
 
-static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
-			loff_t *ppos)
+static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int i;
+	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct tty_struct *tty = file_tty(file);
 	struct tty_ldisc *ld;
@@ -923,11 +925,9 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 	/* We want to wait for the line discipline to sort out in this
 	   situation */
 	ld = tty_ldisc_ref_wait(tty);
-	if (!ld)
-		return hung_up_tty_read(file, buf, count, ppos);
 	i = -EIO;
-	if (ld->ops->read)
-		i = iterate_tty_read(ld, tty, file, buf, count);
+	if (ld && ld->ops->read)
+		i = iterate_tty_read(ld, tty, file, to);
 	tty_ldisc_deref(ld);
 
 	if (i > 0)
@@ -2927,7 +2927,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 
 static int this_tty(const void *t, struct file *file, unsigned fd)
 {
-	if (likely(file->f_op->read != tty_read))
+	if (likely(file->f_op->read_iter != tty_read))
 		return 0;
 	return file_tty(file) != t ? 0 : fd + 1;
 }
-- 
2.30.0

