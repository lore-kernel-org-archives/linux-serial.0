Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D235AC1C;
	Mon, 12 Oct 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798082; cv=none; b=LZu2reHTuGJgaUhjs2rdiN9ULvJd6Ab9uJNU8cF/0mKe0AX2auGryI3RL0W3HrpyLX1KWqS5VJOJM+A6Cuae7V2o230LztCqit4fhvSOUYnPikwVDzvT6zv4mw2pjYhf75dKUJ1Nq8RmdsgqJSDb3WZMJVAAPhOIERfCnNsEpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798082; c=relaxed/simple;
	bh=SiOHAZBqFV0Hqn7b7O+fryzY/wDj9loA8SWLFcgUP5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgUVsfXFuszM1Ym5Z9ZiKIkkPEFXMiMlup0pNkxLIVi2bxLTr0+JBdC0d/GDwkATShPhi0BMxVpES5aWELh6Q6OMU+GS19NIXGAEslr0l5+hSSuXNAiuMERDIUEj9Zv+uLa8RtVbmuKIuPgGu9tQpF0mElFxHmVbMjaTnUNHxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oRhJ2MDc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bq7Wh1Mf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oRhJ2MDc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bq7Wh1Mf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oRhJ2MDc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bq7Wh1Mf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oRhJ2MDc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bq7Wh1Mf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0D5521DFB;
	Mon, 12 Oct 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TL3RmCIVGPHzikpqeQy4EyRAhGOCipxTVLidp1fyLY=;
	b=oRhJ2MDcLBmKU/Cl7FVQGBbveURkLJWqLzfPq/djneZhAwGcjbpwhIdLhW5Eidtawxb2R/
	ODgBd/ItXk/h0t8rsBdjBd5vlOBJLFStccFkAwH3l6mhkjtBVk4yR4IESN2BuDe1qAEQJ3
	XcxxUIWLwadvYKx/6QOwzHyrMSaE0qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TL3RmCIVGPHzikpqeQy4EyRAhGOCipxTVLidp1fyLY=;
	b=Bq7Wh1Mf4IbfOX9vnCxkPqrTo/6ug28emFfsg4xX2hrTY3vsmlBUWneRe4zj+SGn1KNQyd
	q2UCmWx1zwjdfwCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oRhJ2MDc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bq7Wh1Mf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TL3RmCIVGPHzikpqeQy4EyRAhGOCipxTVLidp1fyLY=;
	b=oRhJ2MDcLBmKU/Cl7FVQGBbveURkLJWqLzfPq/djneZhAwGcjbpwhIdLhW5Eidtawxb2R/
	ODgBd/ItXk/h0t8rsBdjBd5vlOBJLFStccFkAwH3l6mhkjtBVk4yR4IESN2BuDe1qAEQJ3
	XcxxUIWLwadvYKx/6QOwzHyrMSaE0qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TL3RmCIVGPHzikpqeQy4EyRAhGOCipxTVLidp1fyLY=;
	b=Bq7Wh1Mf4IbfOX9vnCxkPqrTo/6ug28emFfsg4xX2hrTY3vsmlBUWneRe4zj+SGn1KNQyd
	q2UCmWx1zwjdfwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2012D139AF;
	Mon, 12 Oct 2026 09:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vPIGKD2rzGr6dgAAD6G6ig:T2
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
Subject: [PATCH 1/2] vt: Use boolean as parameter to do_blank_screen() and do_unblank_screen()
Date: Mon, 12 Oct 2026 11:27:38 +0200
Message-ID: <20261012094114.38549-2-tzimmermann@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B0D5521DFB
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -3.01

The parameters to do_blank_screen() and do_unblank_screen() signal
whether the call is part of a switch between text and graphics mode.
Convert to boolean. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c              | 20 ++++++++++----------
 drivers/tty/vt/vt_ioctl.c        | 12 ++++++------
 drivers/video/fbdev/core/fbcon.c |  4 ++--
 include/linux/vt_kern.h          |  5 +++--
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..9e7b4419b422 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3374,7 +3374,7 @@ static void console_callback(struct work_struct *ignored)
 		scrollback_delta = 0;
 	}
 	if (blank_timer_expired) {
-		do_blank_screen(0);
+		do_blank_screen(false);
 		blank_timer_expired = 0;
 	}
 	notify_update(vc_cons[fg_console].d);
@@ -3636,7 +3636,7 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 	case TIOCL_BLANKSCREEN:	/* until explicitly unblanked, not only poked */
 		scoped_guard(console_lock) {
 			ignore_poke = 1;
-			do_blank_screen(0);
+			do_blank_screen(false);
 		}
 		break;
 	case TIOCL_BLANKEDSCREEN:
@@ -4659,7 +4659,7 @@ static int set_vesa_blanking(u8 __user *mode_user)
 	return 0;
 }
 
-void do_blank_screen(int entering_gfx)
+void do_blank_screen(bool entering_gfx)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int i;
@@ -4671,7 +4671,7 @@ void do_blank_screen(int entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
+			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, false);
 		}
 		return;
 	}
@@ -4680,7 +4680,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
+		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, true);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4702,7 +4702,7 @@ void do_blank_screen(int entering_gfx)
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
 	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
-				 (vesa_blank_mode + 1), 0);
+				 (vesa_blank_mode + 1), false);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4721,7 +4721,7 @@ EXPORT_SYMBOL(do_blank_screen);
 /*
  * Called by timer as well as from vt_console_driver
  */
-void do_unblank_screen(int leaving_gfx)
+void do_unblank_screen(bool leaving_gfx)
 {
 	struct vc_data *vc;
 
@@ -4767,13 +4767,13 @@ EXPORT_SYMBOL(do_unblank_screen);
 
 /*
  * This is called by the outside world to cause a forced unblank, mostly for
- * oopses. Currently, I just call do_unblank_screen(0), but we could eventually
- * call it with 1 as an argument and so force a mode restore... that may kill
+ * oopses. Currently, I just call do_unblank_screen(false), but we could eventually
+ * call it with true as an argument and so force a mode restore... that may kill
  * X or at least garbage the screen but would also make the Oops visible...
  */
 static void unblank_screen(void)
 {
-	do_unblank_screen(0);
+	do_unblank_screen(false);
 }
 
 /*
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index ecefe4a666f2..1241b39d6e68 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -273,9 +273,9 @@ static int vt_kdsetmode(struct vc_data *vc, unsigned long mode)
 
 	/* explicitly blank/unblank the screen if switching modes */
 	if (mode == KD_TEXT)
-		do_unblank_screen(1);
+		do_unblank_screen(true);
 	else
-		do_blank_screen(1);
+		do_blank_screen(true);
 
 	return 0;
 }
@@ -1152,9 +1152,9 @@ static void complete_change_console(struct vc_data *vc)
 	 */
 	if (old_vc_mode != vc->vc_mode) {
 		if (vc->vc_mode == KD_TEXT)
-			do_unblank_screen(1);
+			do_unblank_screen(true);
 		else
-			do_blank_screen(1);
+			do_blank_screen(true);
 	}
 
 	/*
@@ -1182,9 +1182,9 @@ static void complete_change_console(struct vc_data *vc)
 
 			if (old_vc_mode != vc->vc_mode) {
 				if (vc->vc_mode == KD_TEXT)
-					do_unblank_screen(1);
+					do_unblank_screen(true);
 				else
-					do_blank_screen(1);
+					do_blank_screen(true);
 			}
 		}
 	}
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 615fa596b7cc..274f6bf6e165 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3051,9 +3051,9 @@ void fbcon_fb_blanked(struct fb_info *info, int blank)
 
 	if (con_is_visible(vc)) {
 		if (blank)
-			do_blank_screen(0);
+			do_blank_screen(false);
 		else
-			do_unblank_screen(0);
+			do_unblank_screen(false);
 	}
 	par->blank_state = blank;
 }
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d008c3d0a9bb..b4e3a2543777 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -10,6 +10,7 @@
 #include <linux/vt.h>
 #include <linux/kd.h>
 #include <linux/tty.h>
+#include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/console_struct.h>
 #include <linux/mm.h>
@@ -29,8 +30,8 @@ int __vc_resize(struct vc_data *vc, unsigned int cols, unsigned int lines,
 		bool from_user);
 struct vc_data *vc_deallocate(unsigned int console);
 void reset_palette(struct vc_data *vc);
-void do_blank_screen(int entering_gfx);
-void do_unblank_screen(int leaving_gfx);
+void do_blank_screen(bool entering_gfx);
+void do_unblank_screen(bool leaving_gfx);
 void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
 int con_set_cmap(unsigned char __user *cmap);
-- 
2.55.0

