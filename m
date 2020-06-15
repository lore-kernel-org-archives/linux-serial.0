Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E1C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9F220738
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgFOHvJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgFOHtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DAAC5AFB5;
        Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/38] vt: move rescan_last_byte label earlier
Date:   Mon, 15 Jun 2020 09:48:47 +0200
Message-Id: <20200615074910.19267-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This removes duplicated initialization of variables (after reordering
'c' initialization).

It will also allow for eliminating whole translation into a separate
function in the next patch.

Note that vc_state, vc_utf etc. are checked with every rescan now. But
they are immutable for non-control characters where rescan might be
only necessary.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index bf171bb1d2fd..93ad7e004900 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2717,10 +2717,11 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 
 	while (!tty->stopped && count) {
 		int orig = *buf;
-		c = orig;
 		buf++;
 		n++;
 		count--;
+rescan_last_byte:
+		c = orig;
 		rescan = false;
 		inverse = false;
 		width = 1;
@@ -2729,7 +2730,6 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		if (vc->vc_state != ESnormal) {
 			tc = c;
 		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
-rescan_last_byte:
 			tc = c = vc_translate_unicode(vc, c, &rescan);
 			if (tc == -1)
 				continue;
@@ -2834,13 +2834,9 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			if (inverse)
 				con_flush(vc, draw_from, draw_to, &draw_x);
 
-			if (rescan) {
-				rescan = false;
-				inverse = false;
-				width = 1;
-				c = orig;
+			if (rescan)
 				goto rescan_last_byte;
-			}
+
 			continue;
 		}
 		con_flush(vc, draw_from, draw_to, &draw_x);
-- 
2.27.0

