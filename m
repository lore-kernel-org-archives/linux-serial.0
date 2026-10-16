Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C14476CF0;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143247; cv=none; b=pNCnO4NTm0y/d+IJ26ZghPgRBRj/crFH1V1Z5K4uBmDiC6oMpJ0QGZfASY5gqdPztEDt6vYd+/DWFgcbxmIE41SXADb1rQ2cqU81dwWnRHnl+BF4dQTNIvrkqpMygzU0MMckIMfRflPc+uUMOwDPqe1jscXqzP9TC2MnS1yw/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143247; c=relaxed/simple;
	bh=HhKN5/ZE5M6Z4IogRh1s58U3adiBNPVe+d5c5WrVs8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgHwoAmrZg3VM2rz9IPyyogkUQG7vN8ng00SYZxjjSvwMpewVx//WPuJwVgasj4n6VK2/QOx+QAZR1KSwkBLL6rywY1ekMpceiSsdMd1ZZP5Ny2H14BnXSZ/GbirpCabZAvkM4hjdpluqaH8Vkqud8gO1d4iA41RUsf54JLS4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aaWRJM7+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tzde3crK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aaWRJM7+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Tzde3crK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aaWRJM7+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tzde3crK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aaWRJM7+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Tzde3crK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 243A321C42;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TQbfpXbtqsudY3tk8jPfj48kGoRqjEbBQkXhoJPYB8=;
	b=aaWRJM7+Msyc0ROXW2+EfY8eq9G0IHDQ3ok9h584tBeW3IckS5FIuvW1/mKKHBg2lJhYWG
	E4iHxYvUkU8GKOO4/vdkgau4rWWeLcV8QUo8SFQe+nAh79xrgPgKMitBevHnB+59wkUUsF
	PUip3Vbaplo8AhHjWyzQKIoXrUoztpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TQbfpXbtqsudY3tk8jPfj48kGoRqjEbBQkXhoJPYB8=;
	b=Tzde3crKTOPt7T5jutW7711uGKWbhF2Vw9jPXxm4iBWalLb/UMGGe18Hix4Ye2IJTmt2kw
	2gEYYD2o1Mv4rlBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TQbfpXbtqsudY3tk8jPfj48kGoRqjEbBQkXhoJPYB8=;
	b=aaWRJM7+Msyc0ROXW2+EfY8eq9G0IHDQ3ok9h584tBeW3IckS5FIuvW1/mKKHBg2lJhYWG
	E4iHxYvUkU8GKOO4/vdkgau4rWWeLcV8QUo8SFQe+nAh79xrgPgKMitBevHnB+59wkUUsF
	PUip3Vbaplo8AhHjWyzQKIoXrUoztpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TQbfpXbtqsudY3tk8jPfj48kGoRqjEbBQkXhoJPYB8=;
	b=Tzde3crKTOPt7T5jutW7711uGKWbhF2Vw9jPXxm4iBWalLb/UMGGe18Hix4Ye2IJTmt2kw
	2gEYYD2o1Mv4rlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5AB0138A5;
	Fri, 16 Oct 2026 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:01 +0000
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
Subject: [PATCH v2 1/7] vt: Add con_unblank callback to struct consw
Date: Fri, 16 Oct 2026 11:11:51 +0200
Message-ID: <20261016093357.33294-2-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Add struct consw.con_unblank as inverse operation to con_black.

If implemented invoke con_blank to turn the console from blanked to
unblanked. Also update the semantics of con_blank in this case: The
blank parameter of con_blank receives a VESA blank mode from enum
vesa_blank_mode instead of the hybrid unblank/blank values it has
used so far.

With con_unblank not implemented, invoke con_blank for blanking and
unblanking as before.

The old semantics of con_blank will be removed when all consoles
implement con_unblank.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c     | 30 +++++++++++++++++++++++-------
 include/linux/console.h |  9 ++++++---
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..04e28166b78d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4671,7 +4671,10 @@ void do_blank_screen(int entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
+			if (vc->vc_sw->con_unblank)
+				vc->vc_sw->con_blank(vc, vesa_blank_mode, 0);
+			else
+				vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
 		}
 		return;
 	}
@@ -4680,7 +4683,10 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
+		if (vc->vc_sw->con_unblank)
+			vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, 1);
+		else
+			vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4701,8 +4707,12 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
-				 (vesa_blank_mode + 1), 0);
+	if (vc->vc_sw->con_unblank)
+		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_NO_BLANKING :
+					 vesa_blank_mode, 0);
+	else
+		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
+					 (vesa_blank_mode + 1), 0);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4753,9 +4763,15 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
-		/* Low-level driver cannot restore -> do it ourselves */
-		update_screen(vc);
+	if (vc->vc_sw->con_unblank) {
+		if (vc->vc_sw->con_unblank(vc))
+			/* Low-level driver cannot restore -> do it ourselves */
+			update_screen(vc);
+	} else {
+		if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
+			/* Low-level driver cannot restore -> do it ourselves */
+			update_screen(vc);
+	}
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(vc);
diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..aadcb6053cb0 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -55,9 +55,11 @@ enum vc_intensity;
  *		Invoked by csi_M and printing to the console.
  * @con_switch: notifier about the console switch; it is supposed to return
  *		true if a redraw is needed.
- * @con_blank:  blank/unblank the console. The target mode is passed in @blank.
- *		@mode_switch is set if changing from/to text/graphics. The hook
- *		is supposed to return true if a redraw is needed.
+ * @con_blank:  blank the console. The preferred VESA blank mode is passed in
+ *		@blank. @mode_switch is set if changing from/to text/graphics.
+ *		The hook is supposed to return true if a redraw is needed.
+ * @con_unblank:  unblank the console. The hook is supposed to return true if
+ *		a redraw is needed.
  * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
  *		be %KD_FONT_FLAG_DONT_RECALC. (optional)
  * @con_font_get: fetch the current font on @vc of height @vpitch into @font.
@@ -99,6 +101,7 @@ struct consw {
 	bool	(*con_switch)(struct vc_data *vc);
 	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
 			     bool mode_switch);
+	bool	(*con_unblank)(struct vc_data *vc);
 	int	(*con_font_set)(struct vc_data *vc,
 				const struct console_font *font,
 				unsigned int vpitch, unsigned int flags);
-- 
2.55.0

