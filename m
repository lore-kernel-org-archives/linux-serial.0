Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3060FC34051
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C45208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgBSIl0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgBSIl0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9EE78B031;
        Wed, 19 Feb 2020 08:41:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/24] n_hdlc: switch tbusy and woke_up to bools
Date:   Wed, 19 Feb 2020 09:41:11 +0100
Message-Id: <20200219084118.26491-17-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

They are in fact bools, so save some bytes (8B on x86_64). Also describe
@woke_up as we know what it is.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 615abe582cac..c4fe09124185 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -125,7 +125,7 @@ struct n_hdlc_buf_list {
  * struct n_hdlc - per device instance data structure
  * @magic - magic value for structure
  * @tbusy - reentrancy flag for tx wakeup code
- * @woke_up - FIXME: describe this field
+ * @woke_up - tx wakeup needs to be run again as it was called while @tbusy
  * @tx_buf_list - list of pending transmit frame buffers
  * @rx_buf_list - list of received frame buffers
  * @tx_free_buf_list - list unused transmit frame buffers
@@ -133,8 +133,8 @@ struct n_hdlc_buf_list {
  */
 struct n_hdlc {
 	int			magic;
-	int			tbusy;
-	int			woke_up;
+	bool			tbusy;
+	bool			woke_up;
 	struct n_hdlc_buf_list	tx_buf_list;
 	struct n_hdlc_buf_list	rx_buf_list;
 	struct n_hdlc_buf_list	tx_free_buf_list;
@@ -275,12 +275,12 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		
  	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
 	if (n_hdlc->tbusy) {
-		n_hdlc->woke_up = 1;
- 		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+		n_hdlc->woke_up = true;
+		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 		return;
 	}
-	n_hdlc->tbusy = 1;
-	n_hdlc->woke_up = 0;
+	n_hdlc->tbusy = true;
+	n_hdlc->woke_up = false;
 	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
@@ -332,7 +332,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 	
 	/* Clear the re-entry flag */
 	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
-	n_hdlc->tbusy = 0;
+	n_hdlc->tbusy = false;
 	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags); 
 	
         if (n_hdlc->woke_up)
-- 
2.25.0

