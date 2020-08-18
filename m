Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24AEC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36132067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHRI5K (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:37862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgHRI5J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E83F1B02C;
        Tue, 18 Aug 2020 08:57:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/16] vc: propagate "viewed as bool" from screenpos up
Date:   Tue, 18 Aug 2020 10:56:53 +0200
Message-Id: <20200818085706.12163-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

viewed is used as a flag, i.e. bool. So treat is as such in most of the
places. vcs_vc is handled in the next patch.

Note: the last parameter of invert_screen was misnamed in the
declaration since 1.1.92.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/accessibility/speakup/main.c |  4 ++--
 drivers/tty/vt/selection.c           |  2 +-
 drivers/tty/vt/vt.c                  | 18 ++++++++++--------
 include/linux/selection.h            |  6 +++---
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index ddfd12afe3b9..be79b2135fac 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -257,7 +257,7 @@ static struct notifier_block vt_notifier_block = {
 
 static unsigned char get_attributes(struct vc_data *vc, u16 *pos)
 {
-	pos = screen_pos(vc, pos - (u16 *)vc->vc_origin, 1);
+	pos = screen_pos(vc, pos - (u16 *)vc->vc_origin, true);
 	return (scr_readw(pos) & ~vc->vc_hi_font_mask) >> 8;
 }
 
@@ -465,7 +465,7 @@ static u16 get_char(struct vc_data *vc, u16 *pos, u_char *attribs)
 		u16 w;
 		u16 c;
 
-		pos = screen_pos(vc, pos - (u16 *)vc->vc_origin, 1);
+		pos = screen_pos(vc, pos - (u16 *)vc->vc_origin, true);
 		w = scr_readw(pos);
 		c = w & 0xff;
 
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 8e74654c1b27..f245a5acf7e9 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -54,7 +54,7 @@ static struct vc_selection {
 /* set reverse video on characters s-e of console with selection. */
 static inline void highlight(const int s, const int e)
 {
-	invert_screen(vc_sel.cons, s, e-s+2, 1);
+	invert_screen(vc_sel.cons, s, e-s+2, true);
 }
 
 /* use complementary color to show the pointer */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a0da7771c327..0f7064d41e92 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -284,7 +284,7 @@ static inline bool con_should_update(const struct vc_data *vc)
 }
 
 static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
-		int viewed)
+		bool viewed)
 {
 	unsigned short *p;
 	
@@ -544,7 +544,7 @@ int vc_uniscr_check(struct vc_data *vc)
  * This must be preceded by a successful call to vc_uniscr_check() once
  * the console lock has been taken.
  */
-void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, int viewed,
+void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
 	struct uni_screen *uniscr = get_vc_uniscr(vc);
@@ -753,7 +753,7 @@ static void update_attr(struct vc_data *vc)
 }
 
 /* Note: inverting the screen twice should revert to the original state */
-void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
+void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 {
 	unsigned short *p;
 
@@ -812,7 +812,7 @@ void complement_pos(struct vc_data *vc, int offset)
 
 	if (old_offset != -1 && old_offset >= 0 &&
 	    old_offset < vc->vc_screenbuf_size) {
-		scr_writew(old, screenpos(vc, old_offset, 1));
+		scr_writew(old, screenpos(vc, old_offset, true));
 		if (con_should_update(vc))
 			vc->vc_sw->con_putc(vc, old, oldy, oldx);
 		notify_update(vc);
@@ -824,7 +824,7 @@ void complement_pos(struct vc_data *vc, int offset)
 	    offset < vc->vc_screenbuf_size) {
 		unsigned short new;
 		unsigned short *p;
-		p = screenpos(vc, offset, 1);
+		p = screenpos(vc, offset, true);
 		old = scr_readw(p);
 		new = old ^ vc->vc_complement_mask;
 		scr_writew(new, p);
@@ -1885,7 +1885,9 @@ static void set_mode(struct vc_data *vc, int on_off)
 			case 5:			/* Inverted screen on/off */
 				if (vc->vc_decscnm != on_off) {
 					vc->vc_decscnm = on_off;
-					invert_screen(vc, 0, vc->vc_screenbuf_size, 0);
+					invert_screen(vc, 0,
+							vc->vc_screenbuf_size,
+							false);
 					update_attr(vc);
 				}
 				break;
@@ -4743,7 +4745,7 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 /* used by selection */
 u16 screen_glyph(const struct vc_data *vc, int offset)
 {
-	u16 w = scr_readw(screenpos(vc, offset, 1));
+	u16 w = scr_readw(screenpos(vc, offset, true));
 	u16 c = w & 0xff;
 
 	if (w & vc->vc_hi_font_mask)
@@ -4763,7 +4765,7 @@ u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 EXPORT_SYMBOL_GPL(screen_glyph_unicode);
 
 /* used by vcs - note the word offset */
-unsigned short *screen_pos(const struct vc_data *vc, int w_offset, int viewed)
+unsigned short *screen_pos(const struct vc_data *vc, int w_offset, bool viewed)
 {
 	return screenpos(vc, 2 * w_offset, viewed);
 }
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 15e36e7ef869..170ef28ff26b 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -34,11 +34,11 @@ extern unsigned char default_grn[];
 extern unsigned char default_blu[];
 
 extern unsigned short *screen_pos(const struct vc_data *vc, int w_offset,
-		int viewed);
+		bool viewed);
 extern u16 screen_glyph(const struct vc_data *vc, int offset);
 extern u32 screen_glyph_unicode(const struct vc_data *vc, int offset);
 extern void complement_pos(struct vc_data *vc, int offset);
-extern void invert_screen(struct vc_data *vc, int offset, int count, int shift);
+extern void invert_screen(struct vc_data *vc, int offset, int count, bool viewed);
 
 extern void getconsxy(const struct vc_data *vc, unsigned char xy[static 2]);
 extern void putconsxy(struct vc_data *vc, unsigned char xy[static const 2]);
@@ -49,7 +49,7 @@ extern void vcs_scr_updated(struct vc_data *vc);
 
 extern int vc_uniscr_check(struct vc_data *vc);
 extern void vc_uniscr_copy_line(const struct vc_data *vc, void *dest,
-				int viewed,
+				bool viewed,
 				unsigned int row, unsigned int col,
 				unsigned int nr);
 
-- 
2.28.0

