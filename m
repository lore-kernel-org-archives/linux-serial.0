Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3DDC3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490FC21D56
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgBSIlZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:44346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgBSIlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 42387AEC5;
        Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/24] n_hdlc: remove cached tty
Date:   Wed, 19 Feb 2020 09:41:07 +0100
Message-Id: <20200219084118.26491-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's not needed, as now it's clear, that it's always the same as the one
passed from the tty layer.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 39a58febd896..2ac702974b57 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -124,7 +124,6 @@ struct n_hdlc_buf_list {
 /**
  * struct n_hdlc - per device instance data structure
  * @magic - magic value for structure
- * @tty - ptr to TTY structure
  * @tbusy - reentrancy flag for tx wakeup code
  * @woke_up - FIXME: describe this field
  * @tx_buf_list - list of pending transmit frame buffers
@@ -134,7 +133,6 @@ struct n_hdlc_buf_list {
  */
 struct n_hdlc {
 	int			magic;
-	struct tty_struct	*tty;
 	int			tbusy;
 	int			woke_up;
 	struct n_hdlc_buf_list	tx_buf_list;
@@ -240,8 +238,6 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	clear_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
 #endif
 	tty->disc_data = NULL;
-	if (tty != n_hdlc->tty)
-		return;
 
 	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
 	wake_up_interruptible(&tty->read_wait);
@@ -280,7 +276,6 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 	}
 		
 	tty->disc_data = n_hdlc;
-	n_hdlc->tty    = tty;
 	tty->receive_room = 65536;
 	
 #if defined(TTY_NO_WRITE_SPLIT)
@@ -391,11 +386,6 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 	if (!n_hdlc)
 		return;
 
-	if (tty != n_hdlc->tty) {
-		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-		return;
-	}
-
 	n_hdlc_send_frames (n_hdlc, tty);
 		
 }	/* end of n_hdlc_tty_wakeup() */
@@ -420,7 +410,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 			__FILE__, __LINE__, __func__, count);
 
 	/* This can happen if stuff comes in on the backup tty */
-	if (!n_hdlc || tty != n_hdlc->tty)
+	if (!n_hdlc)
 		return;
 		
 	/* verify line is using HDLC discipline */
@@ -461,8 +451,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	
 	/* wake up any blocked reads and perform async signalling */
 	wake_up_interruptible (&tty->read_wait);
-	if (n_hdlc->tty->fasync != NULL)
-		kill_fasync (&n_hdlc->tty->fasync, SIGIO, POLL_IN);
+	if (tty->fasync != NULL)
+		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
 
 }	/* end of n_hdlc_tty_receive() */
 
@@ -598,8 +588,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		schedule();
 			
 		n_hdlc = tty->disc_data;
-		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || 
-		    tty != n_hdlc->tty) {
+		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC) {
 			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
 			error = -EIO;
 			break;
@@ -712,7 +701,7 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	__poll_t mask = 0;
 
-	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || tty != n_hdlc->tty)
+	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
 		return 0;
 
 	/*
-- 
2.25.0

