Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66AC433E2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BEF82067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgFOHvJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:39998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbgFOHtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06BA1AFD4;
        Mon, 15 Jun 2020 07:49:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/38] vc: move translation out of do_con_write
Date:   Mon, 15 Jun 2020 09:48:48 +0200
Message-Id: <20200615074910.19267-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that we reordered the code and the label, we can eliminate the
translation into a separate function. We call it vc_translate here.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 93ad7e004900..0f61dc360067 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2658,6 +2658,19 @@ static int vc_translate_unicode(struct vc_data *vc, int c, bool *rescan)
 	return -1;
 }
 
+static int vc_translate(struct vc_data *vc, int *c, bool *rescan)
+{
+	/* Do no translation at all in control states */
+	if (vc->vc_state != ESnormal)
+		return *c;
+
+	if (vc->vc_utf && !vc->vc_disp_ctrl)
+		return *c = vc_translate_unicode(vc, *c, rescan);
+
+	/* no utf or alternate charset mode */
+	return vc_translate_ascii(vc, *c);
+}
+
 static inline unsigned char vc_invert_attr(const struct vc_data *vc)
 {
 	if (!vc->vc_can_do_color)
@@ -2726,16 +2739,9 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 		inverse = false;
 		width = 1;
 
-		/* Do no translation at all in control states */
-		if (vc->vc_state != ESnormal) {
-			tc = c;
-		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
-			tc = c = vc_translate_unicode(vc, c, &rescan);
-			if (tc == -1)
-				continue;
-		} else {	/* no utf or alternate charset mode */
-			tc = vc_translate_ascii(vc, c);
-		}
+		tc = vc_translate(vc, &c, &rescan);
+		if (tc == -1)
+			continue;
 
 		param.c = tc;
 		if (atomic_notifier_call_chain(&vt_notifier_list, VT_PREWRITE,
-- 
2.27.0

