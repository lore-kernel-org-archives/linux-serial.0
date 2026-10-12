Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EC34EEEE;
	Mon, 12 Oct 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798083; cv=none; b=o4v+jWQrzbRdYimR18ZTwas44ynE8FMeh8q91F6u5Cgqr5f8+QNxvXo2r5BsTUUYFNNsO/V1+h6hZ5h+3rcnLwTI3Omrkpj745QlM94gY+T4+BGy9+ubtCkQrDskMjOE1zT4n+mK5Uyiw3OWsYAtxZzH0c7IFCK5ppm7kL3Yhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798083; c=relaxed/simple;
	bh=pXrtYxHmiro9JBT4aUg+cLeimZFMsHTHKshBSEbcQmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3fuieRvwHpOGfijZKpq+j4JrXC98ZNmofPMwM6xYXAmhW1Rkgl1oAY2LpKtO37qRo8OaumonuHNo5uvxWaX9+d8UIwxfVD6QyuBgt9PE8noWmYlpsj5hj8Bgz1RF7gPFpmY5sF61D6swUoQkjRkycRsmJz9fzC9e06hJV5kjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b50S5vfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4We06Ar0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b50S5vfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4We06Ar0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b50S5vfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4We06Ar0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b50S5vfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4We06Ar0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2B4821E69;
	Mon, 12 Oct 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0iODFkuYRmj0jeuiVHk+xppSK1jEbAaNPxjpNdcyGw=;
	b=b50S5vfVvP/bWltspX7IYudmcYlnfBPOJ2bYO4+W5wBuV/bkVUdWG0MUX0aHlIOfQPbbyB
	L6sdGenNKjJXliWU5hzYIUOv2oAmx/7CV3rmIED0vTJYr2PJ1eZrZie3ASvBgaDSItQnRY
	2oIAaqlmNpXHAlFrGNe9oPXGlFWitsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0iODFkuYRmj0jeuiVHk+xppSK1jEbAaNPxjpNdcyGw=;
	b=4We06Ar0o6q1lDpKRDYgXIWHg+nsxJun4izEe8pozfElpf4Kt6Efr+tc7RSJPJSV0CRJNp
	nHZ+Vz5h7KoN0FCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0iODFkuYRmj0jeuiVHk+xppSK1jEbAaNPxjpNdcyGw=;
	b=b50S5vfVvP/bWltspX7IYudmcYlnfBPOJ2bYO4+W5wBuV/bkVUdWG0MUX0aHlIOfQPbbyB
	L6sdGenNKjJXliWU5hzYIUOv2oAmx/7CV3rmIED0vTJYr2PJ1eZrZie3ASvBgaDSItQnRY
	2oIAaqlmNpXHAlFrGNe9oPXGlFWitsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0iODFkuYRmj0jeuiVHk+xppSK1jEbAaNPxjpNdcyGw=;
	b=4We06Ar0o6q1lDpKRDYgXIWHg+nsxJun4izEe8pozfElpf4Kt6Efr+tc7RSJPJSV0CRJNp
	nHZ+Vz5h7KoN0FCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71375139B0;
	Mon, 12 Oct 2026 09:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vPIGKD2rzGr6dgAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Oct 2026 09:41:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	deller@gmx.de,
	James.Bottomley@HansenPartnership.com,
	simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] vt: Distinguish between blanking and VESA blank mode in con_blank
Date: Mon, 12 Oct 2026 11:27:39 +0200
Message-ID: <20261012094114.38549-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012094114.38549-1-tzimmermann@suse.de>
References: <20261012094114.38549-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

The con_blank callback in struct consw encodes blanking and display
blank mode in a single parameter named blank. Its semantics equal
the FB_BLANK constants from the fbdev subsystems. Yet it is of type
enum vesa_blank_mode, which describes VESA DPMS levels of the attached
monitor. Although related, this is something else.

For this reason, calls to con_blank fill the blank parameter with
values that appear non-sensical at first. For example, to blank the
console, but keep the monitor on, vt passes VESA_VSYNC_SUSPEND (eq '1').
This is because consoles interpret '1' as pixels-off-but-monitor-on.
The constant VESA_VSYNC_SUSPEND actually means monitor-vsync-off. And
the argument used for monitor-vsync-off is VESA_VSYNC_SUSPEND+1.

To fix this by splitting blank into two parameters, blank and blank_mode.
The new blank is a boolean to control the display blanking. If cleared,
the console creates display output, if set the console does not. The
new parameter blank_mode specifies the VESA blank mode for the monitor
and equals VESA DPMS levels. If blank is set, blank_mode gives a hint
to the console, on how to set up the signal to the monitor.

The actual interpretation is up to the console. Newportcon and sticon
only handle blank or not-blank. Fbcon and vgacon implement blank plus
the VESA DPMS handling. The implementation of both consoles is again
somewhat confusing because types and values do not match. Clean up
both with the new blank/blank_mode logic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c                 | 11 ++++----
 drivers/video/console/dummycon.c    |  4 +--
 drivers/video/console/newport_con.c |  4 +--
 drivers/video/console/sticon.c      |  4 +--
 drivers/video/console/vgacon.c      | 44 +++++++++++++++--------------
 drivers/video/fbdev/core/fbcon.c    | 19 +++++++------
 include/linux/console.h             |  9 ++++--
 7 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9e7b4419b422..f762c965351d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4671,7 +4671,7 @@ void do_blank_screen(bool entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, false);
+			vc->vc_sw->con_blank(vc, true, vesa_blank_mode, false);
 		}
 		return;
 	}
@@ -4680,7 +4680,7 @@ void do_blank_screen(bool entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, true);
+		vc->vc_sw->con_blank(vc, true, VESA_NO_BLANKING, true);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4701,8 +4701,9 @@ void do_blank_screen(bool entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
-				 (vesa_blank_mode + 1), false);
+	i = vc->vc_sw->con_blank(vc, true,
+				 vesa_off_interval ? VESA_NO_BLANKING : vesa_blank_mode,
+				 false);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4753,7 +4754,7 @@ void do_unblank_screen(bool leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
+	if (vc->vc_sw->con_blank(vc, false, VESA_NO_BLANKING, leaving_gfx))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(vc);
 	if (console_blank_hook)
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 7d02470f19b9..50aaccffcccf 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -79,7 +79,7 @@ static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
 
-static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+static bool dummycon_blank(struct vc_data *vc, bool blank, enum vesa_blank_mode blank_mode,
 			   bool mode_switch)
 {
 	/* Redraw, so that we get putc(s) for output done while blanked */
@@ -99,7 +99,7 @@ static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
 static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 			   unsigned int ypos, unsigned int xpos) { }
-static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+static bool dummycon_blank(struct vc_data *vc, bool blank, enum vesa_blank_mode blank_mode,
 			   bool mode_switch)
 {
 	return false;
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index ecbbe2e4e2a6..90e6d70f94bb 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -476,12 +476,12 @@ static bool newport_switch(struct vc_data *vc)
 	return true;
 }
 
-static bool newport_blank(struct vc_data *c, enum vesa_blank_mode blank,
+static bool newport_blank(struct vc_data *c, bool blank, enum vesa_blank_mode blank_mode,
 			  bool mode_switch)
 {
 	unsigned short treg;
 
-	if (blank == VESA_NO_BLANKING) {
+	if (!blank) {
 		/* unblank console */
 		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
 		newport_vc2_set(npregs, VC2_IREG_CONTROL,
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 6f58e6a9e76a..00e5f86dd35a 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -299,10 +299,10 @@ static bool sticon_switch(struct vc_data *conp)
     return true;	/* needs refreshing */
 }
 
-static bool sticon_blank(struct vc_data *c, enum vesa_blank_mode blank,
+static bool sticon_blank(struct vc_data *c, bool blank, enum vesa_blank_mode blank_mode,
 			 bool mode_switch)
 {
-    if (blank == VESA_NO_BLANKING) {
+    if (!blank) {
 	if (mode_switch)
 	    vga_is_gfx = 0;
 	return true;
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 536e7fe4d142..a3a45b6956df 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -797,11 +797,31 @@ static void vga_pal_blank(struct vgastate *state)
 	}
 }
 
-static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
+static bool vgacon_blank(struct vc_data *c, bool blank, enum vesa_blank_mode blank_mode,
 			 bool mode_switch)
 {
-	switch (blank) {
-	case VESA_NO_BLANKING:		/* Unblank */
+	if (blank) {
+		switch (blank_mode) {
+		case VESA_NO_BLANKING:	/* Normal blanking */
+			if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
+				vga_pal_blank(&vgastate);
+				vga_palette_blanked = true;
+				return 0;
+			}
+			vgacon_set_origin(c);
+			scr_memsetw((void *)vga_vram_base, BLANK,
+				    c->vc_screenbuf_size);
+			if (mode_switch)
+				vga_is_gfx = true;
+			return 1;
+		default:		/* VESA blanking */
+			if (vga_video_type == VIDEO_TYPE_VGAC) {
+				vga_vesa_blank(&vgastate, blank_mode);
+				vga_vesa_blanked = blank_mode;
+			}
+			return 0;
+		}
+	} else { /* Unblank */
 		if (vga_vesa_blanked) {
 			vga_vesa_unblank(&vgastate);
 			vga_vesa_blanked = VESA_NO_BLANKING;
@@ -814,24 +834,6 @@ static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
 		vga_is_gfx = false;
 		/* Tell console.c that it has to restore the screen itself */
 		return 1;
-	case VESA_VSYNC_SUSPEND:	/* Normal blanking */
-		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
-			vga_pal_blank(&vgastate);
-			vga_palette_blanked = true;
-			return 0;
-		}
-		vgacon_set_origin(c);
-		scr_memsetw((void *) vga_vram_base, BLANK,
-			    c->vc_screenbuf_size);
-		if (mode_switch)
-			vga_is_gfx = true;
-		return 1;
-	default:		/* VESA blanking */
-		if (vga_video_type == VIDEO_TYPE_VGAC) {
-			vga_vesa_blank(&vgastate, blank - 1);
-			vga_vesa_blanked = blank;
-		}
-		return 0;
 	}
 }
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 274f6bf6e165..7f75b4f5da74 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2287,18 +2287,19 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
+static bool fbcon_blank(struct vc_data *vc, bool blank, enum vesa_blank_mode blank_mode,
 			bool mode_switch)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
+	int blank_state = !blank ? FB_BLANK_UNBLANK : blank_mode + 1;
 
 	if (mode_switch) {
 		struct fb_var_screeninfo var = info->var;
 
 		par->graphics = 1;
 
-		if (!blank) {
+		if (!blank_state) {
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE |
 				FB_ACTIVATE_KD_TEXT;
 			fb_set_var(info, &var);
@@ -2308,16 +2309,16 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	}
 
 	if (fbcon_is_active(vc, info)) {
-		if (par->blank_state != blank) {
-			par->blank_state = blank;
-			fbcon_cursor(vc, !blank);
-			par->cursor_flash = (!blank);
+		if (par->blank_state != blank_state) {
+			par->blank_state = blank_state;
+			fbcon_cursor(vc, !blank_state);
+			par->cursor_flash = (!blank_state);
 
-			if (fb_blank(info, blank))
-				fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, blank_state))
+				fbcon_generic_blank(vc, info, blank_state);
 		}
 
-		if (!blank)
+		if (!blank_state)
 			update_screen(vc);
 	}
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..19f80556e9b2 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -56,8 +56,10 @@ enum vc_intensity;
  * @con_switch: notifier about the console switch; it is supposed to return
  *		true if a redraw is needed.
  * @con_blank:  blank/unblank the console. The target mode is passed in @blank.
- *		@mode_switch is set if changing from/to text/graphics. The hook
- *		is supposed to return true if a redraw is needed.
+ *		@blank_mode contains the requested level of power saving
+ *		if @blank is true. @mode_switch is set if changing from/to
+ *		text/graphics. The hook is supposed to return true if a redraw
+ *		is needed.
  * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
  *		be %KD_FONT_FLAG_DONT_RECALC. (optional)
  * @con_font_get: fetch the current font on @vc of height @vpitch into @font.
@@ -97,7 +99,8 @@ struct consw {
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
 	bool	(*con_switch)(struct vc_data *vc);
-	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
+	bool	(*con_blank)(struct vc_data *vc, bool blank,
+			     enum vesa_blank_mode blank_mode,
 			     bool mode_switch);
 	int	(*con_font_set)(struct vc_data *vc,
 				const struct console_font *font,
-- 
2.55.0

