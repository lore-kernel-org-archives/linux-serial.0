Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B8C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923492075E
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHRI6R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:37846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgHRI5K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A169EABF4;
        Tue, 18 Aug 2020 08:57:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/16] vt: make vc_data pointers const in selection.h
Date:   Tue, 18 Aug 2020 10:56:51 +0200
Message-Id: <20200818085706.12163-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are many functions declared in selection.h which only read from
struct vc_data passed as a parameter. Make all those uses const to hint
the compiler a bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c      |  2 +-
 drivers/tty/vt/vt.c              | 15 ++++++++-------
 drivers/video/console/sticon.c   |  2 +-
 drivers/video/fbdev/core/fbcon.c |  2 +-
 include/linux/console.h          |  2 +-
 include/linux/consolemap.h       |  3 ++-
 include/linux/selection.h        | 14 ++++++++------
 7 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5947b54d92be..5d5a5fd2dce7 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -268,7 +268,7 @@ unsigned short *set_translate(int m, struct vc_data *vc)
  *    was active.
  * Still, it is now possible to a certain extent to cut and paste non-ASCII.
  */
-u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode)
+u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode)
 {
 	struct uni_pagedir *p;
 	int m;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ccb533fd00a2..8f283221330e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -283,7 +283,8 @@ static inline bool con_should_update(const struct vc_data *vc)
 	return con_is_visible(vc) && !console_blanked;
 }
 
-static inline unsigned short *screenpos(struct vc_data *vc, int offset, int viewed)
+static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
+		int viewed)
 {
 	unsigned short *p;
 	
@@ -543,7 +544,7 @@ int vc_uniscr_check(struct vc_data *vc)
  * This must be preceded by a successful call to vc_uniscr_check() once
  * the console lock has been taken.
  */
-void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
+void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, int viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
@@ -4740,7 +4741,7 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
  */
 
 /* used by selection */
-u16 screen_glyph(struct vc_data *vc, int offset)
+u16 screen_glyph(const struct vc_data *vc, int offset)
 {
 	u16 w = scr_readw(screenpos(vc, offset, 1));
 	u16 c = w & 0xff;
@@ -4751,7 +4752,7 @@ u16 screen_glyph(struct vc_data *vc, int offset)
 }
 EXPORT_SYMBOL_GPL(screen_glyph);
 
-u32 screen_glyph_unicode(struct vc_data *vc, int n)
+u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 {
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
 
@@ -4762,13 +4763,13 @@ u32 screen_glyph_unicode(struct vc_data *vc, int n)
 EXPORT_SYMBOL_GPL(screen_glyph_unicode);
 
 /* used by vcs - note the word offset */
-unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed)
+unsigned short *screen_pos(const struct vc_data *vc, int w_offset, int viewed)
 {
 	return screenpos(vc, 2 * w_offset, viewed);
 }
 EXPORT_SYMBOL_GPL(screen_pos);
 
-void getconsxy(struct vc_data *vc, unsigned char *p)
+void getconsxy(const struct vc_data *vc, unsigned char *p)
 {
 	/* clamp values if they don't fit */
 	p[0] = min(vc->state.x, 0xFFu);
@@ -4782,7 +4783,7 @@ void putconsxy(struct vc_data *vc, unsigned char *p)
 	set_cursor(vc);
 }
 
-u16 vcs_scr_readw(struct vc_data *vc, const u16 *org)
+u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org)
 {
 	if ((unsigned long)org == vc->vc_pos && softcursor_original != -1)
 		return softcursor_original;
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 21a5c280c8c9..e21147e8a14e 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -236,7 +236,7 @@ static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
     return 1;
 }
 
-static u16 *sticon_screen_pos(struct vc_data *conp, int offset)
+static u16 *sticon_screen_pos(const struct vc_data *conp, int offset)
 {
     int line;
     unsigned long p;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8a31fc2b2258..6068845d98f2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2765,7 +2765,7 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	fb_set_cmap(&palette_cmap, info);
 }
 
-static u16 *fbcon_screen_pos(struct vc_data *vc, int offset)
+static u16 *fbcon_screen_pos(const struct vc_data *vc, int offset)
 {
 	unsigned long p;
 	int line;
diff --git a/include/linux/console.h b/include/linux/console.h
index 0670d3491e0e..4b1e26c4cb42 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -74,7 +74,7 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	u16    *(*con_screen_pos)(struct vc_data *vc, int offset);
+	u16    *(*con_screen_pos)(const struct vc_data *vc, int offset);
 	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
 			int *px, int *py);
 	/*
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 254246673390..bcfce748c9d8 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -17,7 +17,8 @@
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
 struct vc_data;
 
-extern u16 inverse_translate(struct vc_data *conp, int glyph, int use_unicode);
+extern u16 inverse_translate(const struct vc_data *conp, int glyph,
+		int use_unicode);
 extern unsigned short *set_translate(int m, struct vc_data *vc);
 extern int conv_uni_to_pc(struct vc_data *conp, long ucs);
 extern u32 conv_8bit_to_uni(unsigned char c);
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 5b890ef5b59f..34404a019ebf 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -33,21 +33,23 @@ extern unsigned char default_red[];
 extern unsigned char default_grn[];
 extern unsigned char default_blu[];
 
-extern unsigned short *screen_pos(struct vc_data *vc, int w_offset, int viewed);
-extern u16 screen_glyph(struct vc_data *vc, int offset);
-extern u32 screen_glyph_unicode(struct vc_data *vc, int offset);
+extern unsigned short *screen_pos(const struct vc_data *vc, int w_offset,
+		int viewed);
+extern u16 screen_glyph(const struct vc_data *vc, int offset);
+extern u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
 extern void complement_pos(struct vc_data *vc, int offset);
 extern void invert_screen(struct vc_data *vc, int offset, int count, int shift);
 
-extern void getconsxy(struct vc_data *vc, unsigned char *p);
+extern void getconsxy(const struct vc_data *vc, unsigned char *p);
 extern void putconsxy(struct vc_data *vc, unsigned char *p);
 
-extern u16 vcs_scr_readw(struct vc_data *vc, const u16 *org);
+extern u16 vcs_scr_readw(const struct vc_data *vc, const u16 *org);
 extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 extern void vcs_scr_updated(struct vc_data *vc);
 
 extern int vc_uniscr_check(struct vc_data *vc);
-extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest, int viewed,
+extern void vc_uniscr_copy_line(const struct vc_data *vc, void *dest,
+				int viewed,
 				unsigned int row, unsigned int col,
 				unsigned int nr);
 
-- 
2.28.0

