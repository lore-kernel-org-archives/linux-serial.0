Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BFCC34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2120E21D56
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBSImO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:44300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSIl0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D88CAF22;
        Wed, 19 Feb 2020 08:41:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/24] n_hdlc: move tty_ldisc_ops to the bottom
Date:   Wed, 19 Feb 2020 09:41:10 +0100
Message-Id: <20200219084118.26491-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This makes forward declarations unnecessary. So drop them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 46 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 4276931fd071..615abe582cac 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -157,22 +157,6 @@ static struct n_hdlc *n_hdlc_alloc (void);
 /* max frame size for memory allocations */
 static int maxframe = 4096;
 
-/* TTY callbacks */
-
-static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
-			   __u8 __user *buf, size_t nr);
-static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
-			    const unsigned char *buf, size_t nr);
-static int n_hdlc_tty_ioctl(struct tty_struct *tty, struct file *file,
-			    unsigned int cmd, unsigned long arg);
-static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
-				    poll_table *wait);
-static int n_hdlc_tty_open(struct tty_struct *tty);
-static void n_hdlc_tty_close(struct tty_struct *tty);
-static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
-			       char *fp, int count);
-static void n_hdlc_tty_wakeup(struct tty_struct *tty);
-
 static void flush_rx_queue(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
@@ -191,21 +175,6 @@ static void flush_tx_queue(struct tty_struct *tty)
 		n_hdlc_buf_put(&n_hdlc->tx_free_buf_list, buf);
 }
 
-static struct tty_ldisc_ops n_hdlc_ldisc = {
-	.owner		= THIS_MODULE,
-	.magic		= TTY_LDISC_MAGIC,
-	.name		= "hdlc",
-	.open		= n_hdlc_tty_open,
-	.close		= n_hdlc_tty_close,
-	.read		= n_hdlc_tty_read,
-	.write		= n_hdlc_tty_write,
-	.ioctl		= n_hdlc_tty_ioctl,
-	.poll		= n_hdlc_tty_poll,
-	.receive_buf	= n_hdlc_tty_receive,
-	.write_wakeup	= n_hdlc_tty_wakeup,
-	.flush_buffer   = flush_rx_queue,
-};
-
 static void n_hdlc_free_buf_list(struct n_hdlc_buf_list *list)
 {
 	struct n_hdlc_buf *buf;
@@ -810,6 +779,21 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 	return buf;
 }	/* end of n_hdlc_buf_get() */
 
+static struct tty_ldisc_ops n_hdlc_ldisc = {
+	.owner		= THIS_MODULE,
+	.magic		= TTY_LDISC_MAGIC,
+	.name		= "hdlc",
+	.open		= n_hdlc_tty_open,
+	.close		= n_hdlc_tty_close,
+	.read		= n_hdlc_tty_read,
+	.write		= n_hdlc_tty_write,
+	.ioctl		= n_hdlc_tty_ioctl,
+	.poll		= n_hdlc_tty_poll,
+	.receive_buf	= n_hdlc_tty_receive,
+	.write_wakeup	= n_hdlc_tty_wakeup,
+	.flush_buffer   = flush_rx_queue,
+};
+
 static int __init n_hdlc_init(void)
 {
 	int status;
-- 
2.25.0

