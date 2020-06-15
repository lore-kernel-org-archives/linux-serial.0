Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D0C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE922067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgFOHvJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgFOHtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A950B01C;
        Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/38] vt: use modern types in do_con_write
Date:   Mon, 15 Jun 2020 09:48:43 +0200
Message-Id: <20200615074910.19267-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use bools for rescan and inverse. And true/false accordingly.

Use u8 for width instead of uint8_t.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b86639351dd2..a9e4924fa675 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2581,10 +2581,10 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vc_data *vc;
 	unsigned char vc_attr;
 	struct vt_notifier_param param;
-	uint8_t rescan;
-	uint8_t inverse;
-	uint8_t width;
 	u16 himask, charmask;
+	u8 width;
+	bool rescan;
+	bool inverse;
 
 	if (in_interrupt())
 		return count;
@@ -2620,8 +2620,8 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		buf++;
 		n++;
 		count--;
-		rescan = 0;
-		inverse = 0;
+		rescan = false;
+		inverse = false;
 		width = 1;
 
 		/* Do no translation at all in control states */
@@ -2660,7 +2660,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			/* Single ASCII byte or first byte of a sequence received */
 			if (vc->vc_utf_count) {
 			    /* Continuation byte expected */
-			    rescan = 1;
+			    rescan = true;
 			    vc->vc_utf_count = 0;
 			    c = 0xfffd;
 			} else if (c > 0x7f) {
@@ -2746,7 +2746,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 				    /* Display U+FFFD. If it's not found, display an inverse question mark. */
 				    tc = conv_uni_to_pc(vc, 0xfffd);
 				    if (tc < 0) {
-					inverse = 1;
+					inverse = true;
 					tc = conv_uni_to_pc(vc, '?');
 					if (tc < 0) tc = '?';
 				    }
@@ -2807,8 +2807,8 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 				con_flush(vc, draw_from, draw_to, &draw_x);
 
 			if (rescan) {
-				rescan = 0;
-				inverse = 0;
+				rescan = false;
+				inverse = false;
 				width = 1;
 				c = orig;
 				goto rescan_last_byte;
-- 
2.27.0

