Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BDC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2D52067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgFOHve (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgFOHtQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8288B019;
        Mon, 15 Jun 2020 07:49:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/38] vt: move vc_translate to vt.c and rename it
Date:   Mon, 15 Jun 2020 09:48:42 +0200
Message-Id: <20200615074910.19267-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

vc_translate is used only in vt.c, so move the definition from a header
there. Also, it used to be a macro, so be modern and make a static
inline from it. This makes the code actually readable.

And as a preparation for next patches, rename it to vc_translate_ascii.
vc_translate will be a wrapper for both unicode and this one.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c     | 14 +++++++++++++-
 include/linux/vt_kern.h |  3 ---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8d9e532f050a..b86639351dd2 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2560,6 +2560,18 @@ static void con_flush(struct vc_data *vc, unsigned long draw_from,
 	*draw_x = -1;
 }
 
+static inline int vc_translate_ascii(const struct vc_data *vc, int c)
+{
+	if (IS_ENABLED(CONFIG_CONSOLE_TRANSLATIONS)) {
+		if (vc->vc_toggle_meta)
+			c |= 0x80;
+
+		return vc->vc_translate[c];
+	}
+
+	return c;
+}
+
 /* acquires console_lock */
 static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
@@ -2687,7 +2699,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			c = 0xfffd;
 		    tc = c;
 		} else {	/* no utf or alternate charset mode */
-		    tc = vc_translate(vc, c);
+			tc = vc_translate_ascii(vc, c);
 		}
 
 		param.c = tc;
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index abf5bccf906a..349e39c3ab60 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -74,8 +74,6 @@ int con_set_default_unimap(struct vc_data *vc);
 void con_free_unimap(struct vc_data *vc);
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc);
 
-#define vc_translate(vc, c) ((vc)->vc_translate[(c) |			\
-					((vc)->vc_toggle_meta ? 0x80 : 0)])
 #else
 static inline int con_set_trans_old(unsigned char __user *table)
 {
@@ -124,7 +122,6 @@ int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 	return 0;
 }
 
-#define vc_translate(vc, c) (c)
 #endif
 
 /* vt.c */
-- 
2.27.0

