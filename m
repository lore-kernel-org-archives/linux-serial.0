Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BAC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D608B21D56
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBSImU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgBSIlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9ACC1AEAC;
        Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/24] n_hdlc: remove checking of n_hdlc
Date:   Wed, 19 Feb 2020 09:41:08 +0100
Message-Id: <20200219084118.26491-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We got rid of backup_tty recently. Also, the tty layer ensures not to
call other ldisc hooks after ldisc close. That means, all those tests
are superfluous now so remove them.

Note that we remove the magic check in write after schedule too. The tty
cannot change during schedule.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 2ac702974b57..2709d18364eb 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -227,9 +227,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	if (!n_hdlc)
-		return;
-
 	if (n_hdlc->magic != HDLC_MAGIC) {
 		printk(KERN_WARNING "n_hdlc: trying to close unopened tty!\n");
 		return;
@@ -383,11 +380,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 
-	if (!n_hdlc)
-		return;
-
 	n_hdlc_send_frames (n_hdlc, tty);
-		
 }	/* end of n_hdlc_tty_wakeup() */
 
 /**
@@ -409,10 +402,6 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	pr_debug("%s(%d)%s() called count=%d\n",
 			__FILE__, __LINE__, __func__, count);
 
-	/* This can happen if stuff comes in on the backup tty */
-	if (!n_hdlc)
-		return;
-		
 	/* verify line is using HDLC discipline */
 	if (n_hdlc->magic != HDLC_MAGIC) {
 		printk("%s(%d) line not using HDLC discipline\n",
@@ -473,10 +462,6 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 	struct n_hdlc_buf *rbuf;
 	DECLARE_WAITQUEUE(wait, current);
 
-	/* Validate the pointers */
-	if (!n_hdlc)
-		return -EIO;
-
 	/* verify user access to buffer */
 	if (!access_ok(buf, nr)) {
 		printk(KERN_WARNING "%s(%d) n_hdlc_tty_read() can't verify user "
@@ -558,10 +543,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 	pr_debug("%s(%d)%s() called count=%zd\n", __FILE__, __LINE__, __func__,
 			count);
 
-	/* Verify pointers */
-	if (!n_hdlc)
-		return -EIO;
-
 	if (n_hdlc->magic != HDLC_MAGIC)
 		return -EIO;
 
@@ -586,14 +567,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			break;
 		}
 		schedule();
-			
-		n_hdlc = tty->disc_data;
-		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC) {
-			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
-			error = -EIO;
-			break;
-		}
-			
+
 		if (signal_pending(current)) {
 			error = -EINTR;
 			break;
@@ -638,7 +612,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 	pr_debug("%s(%d)%s() called %d\n", __FILE__, __LINE__, __func__, cmd);
 
 	/* Verify the status of the device */
-	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
+	if (n_hdlc->magic != HDLC_MAGIC)
 		return -EBADF;
 
 	switch (cmd) {
@@ -701,7 +675,7 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	__poll_t mask = 0;
 
-	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
+	if (n_hdlc->magic != HDLC_MAGIC)
 		return 0;
 
 	/*
-- 
2.25.0

