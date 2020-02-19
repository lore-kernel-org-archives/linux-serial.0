Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DAC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03C224658
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSImh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgBSIlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 923DBADA1;
        Wed, 19 Feb 2020 08:41:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/24] n_hdlc: expand tty2n_hdlc macro
Date:   Wed, 19 Feb 2020 09:41:05 +0100
Message-Id: <20200219084118.26491-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's simple tty->disc_data, but it obfuscates code. So expand it to all
locations and drop it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index ae6b9a45ae81..67162611af58 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -175,12 +175,11 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
 			       char *fp, int count);
 static void n_hdlc_tty_wakeup(struct tty_struct *tty);
 
-#define tty2n_hdlc(tty)	((struct n_hdlc *) ((tty)->disc_data))
 #define n_hdlc2tty(n_hdlc)	((n_hdlc)->tty)
 
 static void flush_rx_queue(struct tty_struct *tty)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	struct n_hdlc_buf *buf;
 
 	while ((buf = n_hdlc_buf_get(&n_hdlc->rx_buf_list)))
@@ -189,7 +188,7 @@ static void flush_rx_queue(struct tty_struct *tty)
 
 static void flush_tx_queue(struct tty_struct *tty)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	struct n_hdlc_buf *buf;
 
 	while ((buf = n_hdlc_buf_get(&n_hdlc->tx_buf_list)))
@@ -252,7 +251,7 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
  */
 static void n_hdlc_tty_close(struct tty_struct *tty)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 
 	if (!n_hdlc)
 		return;
@@ -278,7 +277,7 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
  */
 static int n_hdlc_tty_open (struct tty_struct *tty)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 
 	pr_debug("%s(%d)%s() called (device=%s)\n",
 			__FILE__, __LINE__, __func__, tty->name);
@@ -402,7 +401,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
  */
 static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 
 	if (!n_hdlc)
 		return;
@@ -429,7 +428,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
 static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 			       char *flags, int count)
 {
-	register struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
 
 	pr_debug("%s(%d)%s() called count=%d\n",
@@ -494,7 +493,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 			   __u8 __user *buf, size_t nr)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	int ret = 0;
 	struct n_hdlc_buf *rbuf;
 	DECLARE_WAITQUEUE(wait, current);
@@ -576,7 +575,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const unsigned char *data, size_t count)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	int error = 0;
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
@@ -613,7 +612,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		schedule();
 			
-		n_hdlc = tty2n_hdlc (tty);
+		n_hdlc = tty->disc_data;
 		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || 
 		    tty != n_hdlc->tty) {
 			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
@@ -656,7 +655,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 			    unsigned int cmd, unsigned long arg)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	int error = 0;
 	int count;
 	unsigned long flags;
@@ -725,7 +724,7 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
 static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 				    poll_table *wait)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty->disc_data;
 	__poll_t mask = 0;
 
 	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || tty != n_hdlc->tty)
-- 
2.25.0

