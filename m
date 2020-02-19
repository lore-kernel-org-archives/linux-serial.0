Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA87C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16122465D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgBSImT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:42:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgBSIlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00C32AED8;
        Wed, 19 Feb 2020 08:41:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/24] n_hdlc: add helper for buffers allocation
Date:   Wed, 19 Feb 2020 09:41:09 +0100
Message-Id: <20200219084118.26491-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Given both rx and tx allocations do the same, add a new helper
(n_hdlc_alloc_buf) and use it for both of them. This cleans up
n_hdlc_alloc slightly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 2709d18364eb..4276931fd071 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -699,6 +699,23 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	return mask;
 }	/* end of n_hdlc_tty_poll() */
 
+static void n_hdlc_alloc_buf(struct n_hdlc_buf_list *list, unsigned int count,
+		const char *name)
+{
+	struct n_hdlc_buf *buf;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
+		if (!buf) {
+			pr_debug("%s(%d)%s(), kmalloc() failed for %s buffer %u\n",
+					__FILE__, __LINE__, __func__, name, i);
+			return;
+		}
+		n_hdlc_buf_put(list, buf);
+	}
+}
+
 /**
  * n_hdlc_alloc - allocate an n_hdlc instance data structure
  *
@@ -706,8 +723,6 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
  */
 static struct n_hdlc *n_hdlc_alloc(void)
 {
-	struct n_hdlc_buf *buf;
-	int i;
 	struct n_hdlc *n_hdlc = kzalloc(sizeof(*n_hdlc), GFP_KERNEL);
 
 	if (!n_hdlc)
@@ -723,26 +738,9 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	INIT_LIST_HEAD(&n_hdlc->rx_buf_list.list);
 	INIT_LIST_HEAD(&n_hdlc->tx_buf_list.list);
 
-	/* allocate free rx buffer list */
-	for(i=0;i<DEFAULT_RX_BUF_COUNT;i++) {
-		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
-		if (buf)
-			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list,buf);
-		else
-			pr_debug("%s(%d)%s(), kmalloc() failed for rx buffer %d\n",
-					__FILE__, __LINE__, __func__, i);
-	}
-	
-	/* allocate free tx buffer list */
-	for(i=0;i<DEFAULT_TX_BUF_COUNT;i++) {
-		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
-		if (buf)
-			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list,buf);
-		else
-			pr_debug("%s(%d)%s(), kmalloc() failed for tx buffer %d\n",
-					__FILE__, __LINE__, __func__, i);
-	}
-	
+	n_hdlc_alloc_buf(&n_hdlc->rx_free_buf_list, DEFAULT_RX_BUF_COUNT, "rx");
+	n_hdlc_alloc_buf(&n_hdlc->tx_free_buf_list, DEFAULT_TX_BUF_COUNT, "tx");
+
 	/* Initialize the control block */
 	n_hdlc->magic  = HDLC_MAGIC;
 
-- 
2.25.0

