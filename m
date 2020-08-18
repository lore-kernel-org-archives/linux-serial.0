Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC63C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FB42067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHRI5L (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgHRI5I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C33DBAC48;
        Tue, 18 Aug 2020 08:57:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/16] vt: declare xy for get/putconsxy properly
Date:   Tue, 18 Aug 2020 10:56:52 +0200
Message-Id: <20200818085706.12163-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

That is:
1) call the parameter 'xy' to denote what it really is, not generic 'p'
2) tell the compiler and users that we expect an array:
   * with at least 2 chars (static 2)
   * which we don't modify in putconsxy (const)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c       | 10 +++++-----
 include/linux/selection.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f283221330e..a0da7771c327 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4769,17 +4769,17 @@ unsigned short *screen_pos(const struct vc_data *vc, int w_offset, int viewed)
 }
 EXPORT_SYMBOL_GPL(screen_pos);
 
-void getconsxy(const struct vc_data *vc, unsigned char *p)
+void getconsxy(const struct vc_data *vc, unsigned char xy[static 2])
 {
 	/* clamp values if they don't fit */
-	p[0] = min(vc->state.x, 0xFFu);
-	p[1] = min(vc->state.y, 0xFFu);
+	xy[0] = min(vc->state.x, 0xFFu);
+	xy[1] = min(vc->state.y, 0xFFu);
 }
 
-void putconsxy(struct vc_data *vc, unsigned char *p)
+void putconsxy(struct vc_data *vc, unsigned char xy[static const 2])
 {
 	hide_cursor(vc);
-	gotoxy(vc, p[0], p[1]);
+	gotoxy(vc, xy[0], xy[1]);
 	set_cursor(vc);
 }
 
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 34404a019ebf..15e36e7ef869 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -40,8 +40,8 @@ extern u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
 extern void complement_pos(struct vc_data *vc, int offset);
 extern void invert_screen(struct vc_data *vc, int offset, int count, int shift);
 
-extern void getconsxy(const struct vc_data *vc, unsigned char *p);
-extern void putconsxy(struct vc_data *vc, unsigned char *p);
+extern void getconsxy(const struct vc_data *vc, unsigned char xy[static 2]);
+extern void putconsxy(struct vc_data *vc, unsigned char xy[static const 2]);
 
 extern u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
 extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
-- 
2.28.0

