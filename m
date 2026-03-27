Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A23E868A
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616699; cv=none; b=QL/AapVZj8O2Zc5f3GZmSDOQWCbCtba/ywYk9VvYv5tkmXjHgDWv2QPp9R6OEQVq4ZqV/O8K11YtF312AAr53Ek0q7YerrRFUqIj+7vtb4fT2AZ8IWVyVwgFX21Mlg9J7hKjRjaYTL8vO7p64k7q5xC1h8f3aZIfB6CU3FYTWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616699; c=relaxed/simple;
	bh=SbQU8AAmc66jXISs63Ig5qeDNO69QwvMItcyRRibDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVs2VwH2Poj286sP8nZqC60zQCBqfvtxEGncMLJZx4C8HlhrfgH1N+yDLi4JWtvzFsJObUcQpq077cfdG24N30Ub/FYaGpGL3pBcbmVLvXIRyy55rLqQF+JS3o1UC0k8Iv0e0dmXpUefELL01jEAeYxE4jSQKO6hD97cyGqMpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 958BC5BE54;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53AAD4A0B1;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJr9EmaAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/10] fbcon: Fill cursor mask in helper function
Date: Fri, 27 Mar 2026 13:49:42 +0100
Message-ID: <20260327130431.59481-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 958BC5BE54
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Fbcon creates a cursor shape on the fly from the user-configured
settings. The logic to create a glyph with the cursor's bitmap mask
is duplicated in four places. In the cases that involve console
rotation, the implementation further rotates the cursor glyph for
displaying.

Consolidate all cursor-mask creation in a single helper. Update the
callers accordingly. For console rotation, use the glyph helpers to
rotate the created cursor glyph to the correct orientation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   | 35 ++-----------------
 drivers/video/fbdev/core/fbcon.c     | 40 ++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h     |  2 ++
 drivers/video/fbdev/core/fbcon_ccw.c | 51 ++++++----------------------
 drivers/video/fbdev/core/fbcon_cw.c  | 51 ++++++----------------------
 drivers/video/fbdev/core/fbcon_ud.c  | 50 +++++++--------------------
 6 files changed, 78 insertions(+), 151 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 7478accea8ec..65681dcc5930 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -329,46 +329,17 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    vc->vc_cursor_type != par->p->cursor_shape ||
 	    par->cursor_state.mask == NULL ||
 	    par->cursor_reset) {
-		char *mask = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
-		int cur_height, size, i = 0;
-		u8 msk = 0xff;
+		unsigned char *mask = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
 
 		if (!mask)
 			return;
+		fbcon_fill_cursor_mask(par, vc, mask);
 
 		kfree(par->cursor_state.mask);
-		par->cursor_state.mask = mask;
+		par->cursor_state.mask = (const char *)mask;
 
 		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
-
-		switch (CUR_SIZE(par->p->cursor_shape)) {
-		case CUR_NONE:
-			cur_height = 0;
-			break;
-		case CUR_UNDERLINE:
-			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-			break;
-		case CUR_LOWER_THIRD:
-			cur_height = vc->vc_font.height/3;
-			break;
-		case CUR_LOWER_HALF:
-			cur_height = vc->vc_font.height >> 1;
-			break;
-		case CUR_TWO_THIRDS:
-			cur_height = (vc->vc_font.height << 1)/3;
-			break;
-		case CUR_BLOCK:
-		default:
-			cur_height = vc->vc_font.height;
-			break;
-		}
-		size = (vc->vc_font.height - cur_height) * w;
-		while (size--)
-			mask[i++] = ~msk;
-		size = cur_height * w;
-		while (size--)
-			mask[i++] = msk;
 	}
 
 	par->cursor_state.enable = enable && !use_sw;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8641b0b3edc4..345d9aa193f0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -446,6 +446,46 @@ static void fbcon_del_cursor_work(struct fb_info *info)
 	cancel_delayed_work_sync(&par->cursor_work);
 }
 
+void fbcon_fill_cursor_mask(struct fbcon_par *par, struct vc_data *vc, unsigned char *mask)
+{
+	static const unsigned char pattern = 0xff;
+	unsigned int pitch = vc_font_pitch(&vc->vc_font);
+	unsigned int cur_height, size;
+
+	switch (CUR_SIZE(vc->vc_cursor_type)) {
+	case CUR_NONE:
+		cur_height = 0;
+		break;
+	case CUR_UNDERLINE:
+		if (vc->vc_font.height < 10)
+			cur_height = 1;
+		else
+			cur_height = 2;
+		break;
+	case CUR_LOWER_THIRD:
+		cur_height = vc->vc_font.height / 3;
+		break;
+	case CUR_LOWER_HALF:
+		cur_height = vc->vc_font.height / 2;
+		break;
+	case CUR_TWO_THIRDS:
+		cur_height = (vc->vc_font.height * 2) / 3;
+		break;
+	case CUR_BLOCK:
+	default:
+		cur_height = vc->vc_font.height;
+		break;
+	}
+
+	size = (vc->vc_font.height - cur_height) * pitch;
+	while (size--)
+		*mask++ = (unsigned char)~pattern;
+
+	size = cur_height * pitch;
+	while (size--)
+		*mask++ = pattern;
+}
+
 #ifndef MODULE
 static int __init fb_console_setup(char *this_opt)
 {
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1793f34a6c84..bb0727b70631 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -192,6 +192,8 @@ extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info);
 extern void fbcon_set_bitops_ur(struct fbcon_par *par);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
+void fbcon_fill_cursor_mask(struct fbcon_par *par, struct vc_data *vc, unsigned char *mask);
+
 #define FBCON_ATTRIBUTE_UNDERLINE 1
 #define FBCON_ATTRIBUTE_REVERSE   2
 #define FBCON_ATTRIBUTE_BOLD      4
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 72453a2aaca8..723d9a33067f 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -296,57 +296,26 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    vc->vc_cursor_type != par->p->cursor_shape ||
 	    par->cursor_state.mask == NULL ||
 	    par->cursor_reset) {
-		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
-						 GFP_ATOMIC);
-		int cur_height, size, i = 0;
-		int width = font_glyph_pitch(vc->vc_font.width);
+		unsigned char *tmp, *mask;
 
-		if (!mask)
+		tmp = kmalloc_array(vc->vc_font.height, vc_font_pitch(&vc->vc_font), GFP_ATOMIC);
+		if (!tmp)
 			return;
+		fbcon_fill_cursor_mask(par, vc, tmp);
 
-		tmp = kmalloc_array(width, vc->vc_font.height, GFP_ATOMIC);
-
-		if (!tmp) {
-			kfree(mask);
+		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
+		if (!mask) {
+			kfree(tmp);
 			return;
 		}
+		font_glyph_rotate_270(tmp, vc->vc_font.width, vc->vc_font.height, mask);
+		kfree(tmp);
 
 		kfree(par->cursor_state.mask);
-		par->cursor_state.mask = mask;
+		par->cursor_state.mask = (const char *)mask;
 
 		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
-
-		switch (CUR_SIZE(par->p->cursor_shape)) {
-		case CUR_NONE:
-			cur_height = 0;
-			break;
-		case CUR_UNDERLINE:
-			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-			break;
-		case CUR_LOWER_THIRD:
-			cur_height = vc->vc_font.height/3;
-			break;
-		case CUR_LOWER_HALF:
-			cur_height = vc->vc_font.height >> 1;
-			break;
-		case CUR_TWO_THIRDS:
-			cur_height = (vc->vc_font.height << 1)/3;
-			break;
-		case CUR_BLOCK:
-		default:
-			cur_height = vc->vc_font.height;
-			break;
-		}
-
-		size = (vc->vc_font.height - cur_height) * width;
-		while (size--)
-			tmp[i++] = 0;
-		size = cur_height * width;
-		while (size--)
-			tmp[i++] = 0xff;
-		font_glyph_rotate_270(tmp, vc->vc_font.width, vc->vc_font.height, mask);
-		kfree(tmp);
 	}
 
 	par->cursor_state.enable = enable && !use_sw;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 5690fc1d7854..732d093d462f 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -279,57 +279,26 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    vc->vc_cursor_type != par->p->cursor_shape ||
 	    par->cursor_state.mask == NULL ||
 	    par->cursor_reset) {
-		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
-						 GFP_ATOMIC);
-		int cur_height, size, i = 0;
-		int width = font_glyph_pitch(vc->vc_font.width);
+		unsigned char *tmp, *mask;
 
-		if (!mask)
+		tmp = kmalloc_array(vc->vc_font.height, vc_font_pitch(&vc->vc_font), GFP_ATOMIC);
+		if (!tmp)
 			return;
+		fbcon_fill_cursor_mask(par, vc, tmp);
 
-		tmp = kmalloc_array(width, vc->vc_font.height, GFP_ATOMIC);
-
-		if (!tmp) {
-			kfree(mask);
+		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
+		if (!mask) {
+			kfree(tmp);
 			return;
 		}
+		font_glyph_rotate_90(tmp, vc->vc_font.width, vc->vc_font.height, mask);
+		kfree(tmp);
 
 		kfree(par->cursor_state.mask);
-		par->cursor_state.mask = mask;
+		par->cursor_state.mask = (const char *)mask;
 
 		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
-
-		switch (CUR_SIZE(par->p->cursor_shape)) {
-		case CUR_NONE:
-			cur_height = 0;
-			break;
-		case CUR_UNDERLINE:
-			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-			break;
-		case CUR_LOWER_THIRD:
-			cur_height = vc->vc_font.height/3;
-			break;
-		case CUR_LOWER_HALF:
-			cur_height = vc->vc_font.height >> 1;
-			break;
-		case CUR_TWO_THIRDS:
-			cur_height = (vc->vc_font.height << 1)/3;
-			break;
-		case CUR_BLOCK:
-		default:
-			cur_height = vc->vc_font.height;
-			break;
-		}
-
-		size = (vc->vc_font.height - cur_height) * width;
-		while (size--)
-			tmp[i++] = 0;
-		size = cur_height * width;
-		while (size--)
-			tmp[i++] = 0xff;
-		font_glyph_rotate_90(tmp, vc->vc_font.width, vc->vc_font.height, mask);
-		kfree(tmp);
 	}
 
 	par->cursor_state.enable = enable && !use_sw;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index f7cd89c42b01..a1981fa4701a 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -326,50 +326,26 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	    vc->vc_cursor_type != par->p->cursor_shape ||
 	    par->cursor_state.mask == NULL ||
 	    par->cursor_reset) {
-		char *mask = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
-		int cur_height, size, i = 0;
-		u8 msk = 0xff;
+		unsigned char *tmp, *mask;
 
-		if (!mask)
+		tmp = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
+		if (!tmp)
 			return;
+		fbcon_fill_cursor_mask(par, vc, tmp);
+
+		mask = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
+		if (!mask) {
+			kfree(tmp);
+			return;
+		}
+		font_glyph_rotate_180(tmp, vc->vc_font.width, vc->vc_font.height, mask);
+		kfree(tmp);
 
 		kfree(par->cursor_state.mask);
-		par->cursor_state.mask = mask;
+		par->cursor_state.mask = (const char *)mask;
 
 		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
-
-		switch (CUR_SIZE(par->p->cursor_shape)) {
-		case CUR_NONE:
-			cur_height = 0;
-			break;
-		case CUR_UNDERLINE:
-			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-			break;
-		case CUR_LOWER_THIRD:
-			cur_height = vc->vc_font.height/3;
-			break;
-		case CUR_LOWER_HALF:
-			cur_height = vc->vc_font.height >> 1;
-			break;
-		case CUR_TWO_THIRDS:
-			cur_height = (vc->vc_font.height << 1)/3;
-			break;
-		case CUR_BLOCK:
-		default:
-			cur_height = vc->vc_font.height;
-			break;
-		}
-
-		size = cur_height * w;
-
-		while (size--)
-			mask[i++] = msk;
-
-		size = (vc->vc_font.height - cur_height) * w;
-
-		while (size--)
-			mask[i++] = ~msk;
 	}
 
 	par->cursor_state.enable = enable && !use_sw;
-- 
2.53.0

