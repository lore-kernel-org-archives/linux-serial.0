Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4F47A0D8;
	Fri, 16 Oct 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143250; cv=none; b=qOZRAqdUPpAbRQnece+itm2bp49kkb34iVICrSJGekMjBSTzmEbSyY27pLwm2daKdbiTrt87PgZBvAsUhyoMNLOzSJ6hjVyJdU539chfao/3iypwQ7yLLbA0eLPcgedzP/bHm/KZPFo/DU+dCYqnenulWoR6FeCp+d3/po9UG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143250; c=relaxed/simple;
	bh=fUaQxUAO8WxWlvzYtz5OC8a14UMk7HHl1sPwZs7TuAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKoJHn9rjU39VXJDcd/TUBdUYLfuXtOY9wexTwHiR7QX92EGXUisOeXMqGSjZLPQSz/7cBSmG4GLimBmLGJacQeZ0rIrxni865HBpYEHzOgWQokcDZxDB/zYLiL2ajW/LbKRxFXNiYzZvEEiWZh03OO+7jXq8C+PohWmDO6OpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I7xlTaay; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IAkgqAFo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FUR4YSRu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mxQnw/Ok; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I7xlTaay";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IAkgqAFo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FUR4YSRu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mxQnw/Ok"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F06111F45F;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2OrmPdVI+OdKn0/Us9DCGQuA7/h86+coZ2zjXGkDcE=;
	b=I7xlTaayxjJx/Nu74NgFNiw1rrcE4hdtLGYol9tVCeR1Q4XcWseCfcgKzxMfw3tEYe66cl
	WvFG7K450mhiKITSIn8xW4sPv+XJk02DEjz23HHngdA89sMCgne4TSLBgycK6pwMyEscJs
	Goei1NFs5TCv6Ci2PcoHIHlI00B2iNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2OrmPdVI+OdKn0/Us9DCGQuA7/h86+coZ2zjXGkDcE=;
	b=IAkgqAFow4D61JJE1b1+PWliFDEIATo/BN72aumQ4yN7X57Zebd1SywDvRw94BtUW9bL8M
	SSXdeZq5FTWAuVDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FUR4YSRu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="mxQnw/Ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2OrmPdVI+OdKn0/Us9DCGQuA7/h86+coZ2zjXGkDcE=;
	b=FUR4YSRugnZzmrGao6vZchbkHBfEQd/AOCNT5uhyhIs+mXSWzOdAiFFA0FMpeDd3ZfcSdl
	9VqFaAwFxneBz2k6JnqfPNIc+DIZDgkQQx0gQ+eZENNwUAOrRpnDf3kc8g25csLv/dyGHd
	/tLSPHIEr8ykujeR7fAPjEkfe3zHARo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2OrmPdVI+OdKn0/Us9DCGQuA7/h86+coZ2zjXGkDcE=;
	b=mxQnw/Ok98c43vj+PFg9DgaMqJNWVpL0Ze98mbQVTdb0yntKBQpZk3FTeorgm9fWL0rvUm
	3lS4WknnIo19zGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829E51378C;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T8
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:03 +0000
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
Subject: [PATCH v2 7/7] vt: Remove old-style con_blank
Date: Fri, 16 Oct 2026 11:11:57 +0200
Message-ID: <20261016093357.33294-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016093357.33294-1-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Rspamd-Queue-Id: F06111F45F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

All consoles implement the new con_blank plus con_unblank. Remove
the old semantics from con_blank. Always pass a VESA blank mode to
the blank parameter. Remove the mode_switch parameter. For unblanking
call con_unblank unconditionally.

Most consoles handle switches from text to graphics mode in their
con_blank callback. With the mode_switch parameter removed, detect
mode switches from console state plus vc_mode. A later change might
add a callback for switching modes to struct consw.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c                 | 29 ++++++-----------------------
 drivers/video/console/dummycon.c    |  6 ++----
 drivers/video/console/newport_con.c |  3 +--
 drivers/video/console/sticon.c      |  5 +++--
 drivers/video/console/vgacon.c      |  7 ++++---
 drivers/video/fbdev/core/fbcon.c    |  4 ++--
 include/linux/console.h             |  7 +++----
 7 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 04e28166b78d..13914b582cef 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4671,10 +4671,7 @@ void do_blank_screen(int entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			if (vc->vc_sw->con_unblank)
-				vc->vc_sw->con_blank(vc, vesa_blank_mode, 0);
-			else
-				vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
+			vc->vc_sw->con_blank(vc, vesa_blank_mode);
 		}
 		return;
 	}
@@ -4683,10 +4680,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		if (vc->vc_sw->con_unblank)
-			vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, 1);
-		else
-			vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
+		vc->vc_sw->con_blank(vc, VESA_NO_BLANKING);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4707,12 +4701,7 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	if (vc->vc_sw->con_unblank)
-		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_NO_BLANKING :
-					 vesa_blank_mode, 0);
-	else
-		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
-					 (vesa_blank_mode + 1), 0);
+	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_NO_BLANKING : vesa_blank_mode);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4763,15 +4752,9 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_unblank) {
-		if (vc->vc_sw->con_unblank(vc))
-			/* Low-level driver cannot restore -> do it ourselves */
-			update_screen(vc);
-	} else {
-		if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
-			/* Low-level driver cannot restore -> do it ourselves */
-			update_screen(vc);
-	}
+	if (vc->vc_sw->con_unblank(vc))
+		/* Low-level driver cannot restore -> do it ourselves */
+		update_screen(vc);
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(vc);
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index ea34a7e84472..a206a3de9f4d 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -79,8 +79,7 @@ static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
 
-static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
-			   bool mode_switch)
+static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank)
 {
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return true;
@@ -104,8 +103,7 @@ static void dummycon_putc(struct vc_data *vc, u16 c, unsigned int y,
 			  unsigned int x) { }
 static void dummycon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 			   unsigned int ypos, unsigned int xpos) { }
-static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
-			   bool mode_switch)
+static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank)
 {
 	return false;
 }
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index c617a9a27e4c..5b2d927fccbc 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -476,8 +476,7 @@ static bool newport_switch(struct vc_data *vc)
 	return true;
 }
 
-static bool newport_blank(struct vc_data *c, enum vesa_blank_mode blank,
-			  bool mode_switch)
+static bool newport_blank(struct vc_data *c, enum vesa_blank_mode blank)
 {
 	unsigned short treg;
 
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 0d882ea6b37f..fb0a8aa4c2bc 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -299,9 +299,10 @@ static bool sticon_switch(struct vc_data *conp)
     return true;	/* needs refreshing */
 }
 
-static bool sticon_blank(struct vc_data *c, enum vesa_blank_mode blank,
-			 bool mode_switch)
+static bool sticon_blank(struct vc_data *c, enum vesa_blank_mode blank)
 {
+	bool mode_switch = !vga_is_gfx && c->vc_mode == KD_GRAPHICS;
+
 	sti_clear(sticon_sti, 0, 0, c->vc_rows, c->vc_cols, BLANK, font_data[c->vc_num]);
 
 	if (mode_switch)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7f52164c30af..6463fb7676c5 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -797,15 +797,16 @@ static void vga_pal_blank(struct vgastate *state)
 	}
 }
 
-static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
-			 bool mode_switch)
+static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank)
 {
+	bool mode_switch = !vga_is_gfx && c->vc_mode == KD_GRAPHICS;
+
 	if (mode_switch)
 		vga_is_gfx = true;
 
 	switch (blank) {
 	case VESA_NO_BLANKING:	/* Normal blanking */
-		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
+		if (c->vc_mode == KD_TEXT && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&vgastate);
 			vga_palette_blanked = true;
 			return false;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 6d564111ebd0..c9a8fb49c06b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2287,11 +2287,11 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
-			bool mode_switch)
+static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
+	bool mode_switch = !par->graphics && vc->vc_mode == KD_GRAPHICS;
 
 	if (mode_switch)
 		par->graphics = true;
diff --git a/include/linux/console.h b/include/linux/console.h
index aadcb6053cb0..b59b6ac0c01e 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -56,8 +56,8 @@ enum vc_intensity;
  * @con_switch: notifier about the console switch; it is supposed to return
  *		true if a redraw is needed.
  * @con_blank:  blank the console. The preferred VESA blank mode is passed in
- *		@blank. @mode_switch is set if changing from/to text/graphics.
- *		The hook is supposed to return true if a redraw is needed.
+ *		@blank. The hook is supposed to return true if a redraw is
+ *		needed.
  * @con_unblank:  unblank the console. The hook is supposed to return true if
  *		a redraw is needed.
  * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
@@ -99,8 +99,7 @@ struct consw {
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
 	bool	(*con_switch)(struct vc_data *vc);
-	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
-			     bool mode_switch);
+	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank);
 	bool	(*con_unblank)(struct vc_data *vc);
 	int	(*con_font_set)(struct vc_data *vc,
 				const struct console_font *font,
-- 
2.55.0

