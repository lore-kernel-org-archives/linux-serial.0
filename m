Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E0C34050
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3257524671
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgBSImn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:44328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgBSIlY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1FBFAD88;
        Wed, 19 Feb 2020 08:41:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/24] n_hdlc: inline n_hdlc_release
Date:   Wed, 19 Feb 2020 09:41:06 +0100
Message-Id: <20200219084118.26491-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Put the body of n_hdlc_release into the only caller. It can be seen,
that the "if" is superfluous now -- the same happens few lines above in
n_hdlc_tty_close already. So drop it.

Drop also n_hdlc2tty macro as this was the only user.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 67162611af58..39a58febd896 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -175,8 +175,6 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
 			       char *fp, int count);
 static void n_hdlc_tty_wakeup(struct tty_struct *tty);
 
-#define n_hdlc2tty(n_hdlc)	((n_hdlc)->tty)
-
 static void flush_rx_queue(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
@@ -220,28 +218,6 @@ static void n_hdlc_free_buf_list(struct n_hdlc_buf_list *list)
 	} while (buf);
 }
 
-/**
- * n_hdlc_release - release an n_hdlc per device line discipline info structure
- * @n_hdlc - per device line discipline info structure
- */
-static void n_hdlc_release(struct n_hdlc *n_hdlc)
-{
-	struct tty_struct *tty = n_hdlc2tty (n_hdlc);
-
-	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
-	wake_up_interruptible (&tty->read_wait);
-	wake_up_interruptible (&tty->write_wait);
-
-	if (tty->disc_data == n_hdlc)
-		tty->disc_data = NULL;	/* Break the tty->n_hdlc link */
-
-	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
-	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
-	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
-	n_hdlc_free_buf_list(&n_hdlc->tx_buf_list);
-	kfree(n_hdlc);
-}	/* end of n_hdlc_release() */
-
 /**
  * n_hdlc_tty_close - line discipline close
  * @tty - pointer to tty info structure
@@ -266,7 +242,16 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 	tty->disc_data = NULL;
 	if (tty != n_hdlc->tty)
 		return;
-	n_hdlc_release (n_hdlc);
+
+	/* Ensure that the n_hdlcd process is not hanging on select()/poll() */
+	wake_up_interruptible(&tty->read_wait);
+	wake_up_interruptible(&tty->write_wait);
+
+	n_hdlc_free_buf_list(&n_hdlc->rx_free_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->tx_free_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->rx_buf_list);
+	n_hdlc_free_buf_list(&n_hdlc->tx_buf_list);
+	kfree(n_hdlc);
 }	/* end of n_hdlc_tty_close() */
 
 /**
-- 
2.25.0

