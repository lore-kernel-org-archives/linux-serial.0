Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C9C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D83208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSIlX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:44278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgBSIlX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45DFFAF22;
        Wed, 19 Feb 2020 08:41:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/24] n_hdlc: simplify freeing of buffer list
Date:   Wed, 19 Feb 2020 09:41:01 +0100
Message-Id: <20200219084118.26491-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

n_hdlc_release contains four loops to free each buffer list. Create a
helper (n_hdlc_free_buf_list) and call it for every list instead. It
makes n_hdlc_release more readable.

We are switching from "for (;;)" to "do {} while (buf)" which avoids the
"if (buf)" completely -- kfree is a nop for NULL pointers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 45 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index a713a98fea2e..07ba42badd7a 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -215,6 +215,16 @@ static struct tty_ldisc_ops n_hdlc_ldisc = {
 	.flush_buffer   = flush_rx_queue,
 };
 
+static void n_hdlc_free_buf_list(struct n_hdlc_buf_list *list)
+{
+	struct n_hdlc_buf *buf;
+
+	do {
+		buf = n_hdlc_buf_get(list);
+		kfree(buf);
+	} while (buf);
+}
+
 /**
  * n_hdlc_release - release an n_hdlc per device line discipline info structure
  * @n_hdlc - per device line discipline info structure
@@ -222,7 +232,6 @@ static struct tty_ldisc_ops n_hdlc_ldisc = {
 static void n_hdlc_release(struct n_hdlc *n_hdlc)
 {
 	struct tty_struct *tty = n_hdlc2tty (n_hdlc);
-	struct n_hdlc_buf *buf;
 
 	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
 	wake_up_interruptible (&tty->read_wait);
@@ -231,37 +240,11 @@ static void n_hdlc_release(struct n_hdlc *n_hdlc)
 	if (tty->disc_data == n_hdlc)
 		tty->disc_data = NULL;	/* Break the tty->n_hdlc link */
 
-	/* Release transmit and receive buffers */
-	for(;;) {
-		buf = n_hdlc_buf_get(&n_hdlc->rx_free_buf_list);
-		if (buf) {
-			kfree(buf);
-		} else
-			break;
-	}
-	for(;;) {
-		buf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
-		if (buf) {
-			kfree(buf);
-		} else
-			break;
-	}
-	for(;;) {
-		buf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
-		if (buf) {
-			kfree(buf);
-		} else
-			break;
-	}
-	for(;;) {
-		buf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
-		if (buf) {
-			kfree(buf);
-		} else
-			break;
-	}
+	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->tx_buf_list);
 	kfree(n_hdlc);
-	
 }	/* end of n_hdlc_release() */
 
 /**
-- 
2.25.0

