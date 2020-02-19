Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B9C34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3407208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBSIl3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:44278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgBSIl2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CEB2AD88;
        Wed, 19 Feb 2020 08:41:26 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/24] n_hdlc: fix whitespace around binary operators
Date:   Wed, 19 Feb 2020 09:41:17 +0100
Message-Id: <20200219084118.26491-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 7ae4347a946f..b74a8ecc65b5 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -376,7 +376,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 		return;
 	}
 
-	if ( count>maxframe ) {
+	if (count > maxframe) {
 		pr_debug("%s(%d) rx count>maxframesize, data discarded\n",
 				__FILE__, __LINE__);
 		return;
@@ -400,7 +400,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 
 	/* copy received data to HDLC buffer */
 	memcpy(buf->buf, data, count);
-	buf->count=count;
+	buf->count = count;
 
 	/* add HDLC buffer to list of received frames */
 	n_hdlc_buf_put(&n_hdlc->rx_buf_list, buf);
@@ -514,7 +514,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		return -EIO;
 
 	/* verify frame size */
-	if (count > maxframe ) {
+	if (count > maxframe) {
 		pr_debug("%s: truncating user packet from %zu to %d\n",
 				__func__, count, maxframe);
 		count = maxframe;
-- 
2.25.0

