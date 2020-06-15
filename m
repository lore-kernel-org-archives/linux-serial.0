Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7527CC433E3
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5075B2067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgFOHvJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgFOHtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF44FB028;
        Mon, 15 Jun 2020 07:49:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/38] vt: extract attribute inversion to vc_invert_attr
Date:   Mon, 15 Jun 2020 09:48:46 +0200
Message-Id: <20200615074910.19267-14-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We continue cleaning up do_con_write. This (hopefully) makes the
inversion code obvious.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5004242d601b..bf171bb1d2fd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2658,6 +2658,21 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 	return -1;
 }
 
+static inline unsigned char vc_invert_attr(const struct vc_data *vc)
+{
+	if (!vc->vc_can_do_color)
+		return vc->vc_attr ^ 0x08;
+
+	if (vc->vc_hi_font_mask == 0x100)
+		return   (vc->vc_attr & 0x11) |
+			((vc->vc_attr & 0xe0) >> 4) |
+			((vc->vc_attr & 0x0e) << 4);
+
+	return   (vc->vc_attr & 0x88) |
+		((vc->vc_attr & 0x70) >> 4) |
+		((vc->vc_attr & 0x07) << 4);
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
@@ -2776,14 +2791,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			if (!inverse) {
 				vc_attr = vc->vc_attr;
 			} else {
-				/* invert vc_attr */
-				if (!vc->vc_can_do_color) {
-					vc_attr = (vc->vc_attr) ^ 0x08;
-				} else if (vc->vc_hi_font_mask == 0x100) {
-					vc_attr = ((vc->vc_attr) & 0x11) | (((vc->vc_attr) & 0xe0) >> 4) | (((vc->vc_attr) & 0x0e) << 4);
-				} else {
-					vc_attr = ((vc->vc_attr) & 0x88) | (((vc->vc_attr) & 0x70) >> 4) | (((vc->vc_attr) & 0x07) << 4);
-				}
+				vc_attr = vc_invert_attr(vc);
 				con_flush(vc, draw_from, draw_to, &draw_x);
 			}
 
-- 
2.27.0

