Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761894;
	b=t+iZh2cyFmDiesVpW4sEf1TCK+Lwn7pO038zVsrnZoWamf98gJfrf0EpwQNRDS9Ifqy2
	 HhXfGHCBr4T3KY+uPxbgkAeNvN+JUTodM5XDdFxqcmucBp6Z74tO4TAAUYnMT82yEdl9F
	 0TALwt7GH0N5lM12pa2x4+4vZ0gshdlHaIjpa+n0O+2ySgiYdJMR7KBrc8V9hYT+q6qBO
	 xJMyhZLkSQXEOBQRjb/dhBwNaJBUzjN5ljOhIjcwRroD2ZLijPL/Fb1YUaGQxU8iEzuXF
	 4O3t4O70qnP9HRpe3E0Tq/xm0r3rO63Q/2naj7i/QBHSmPnH5LhIMqfFFh4pC/SUgZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761894;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=HYWEkYXITRdxx8PJL4BELKv4UkAeNlUxpZyOSi0kIQo=;
	b=bLL0t10k/+19Cvwo8e6x5xOf86N88OIsXHU57knWakEP/LqCvhtuLPiesmnwu6Nk2rbe
	 0mgAQtivf0TZXP8ZVR86rZ8yDW7PiYzIS7m3aedpICbprAjyk2HjIyBHE/fZOseZV2Vie
	 HOPAt5NDtx3l9ITQNjzzUdJuoEU+dA9+uS6bwXnZDdPCxybJFCHet7UsSmVZJtyolOpWp
	 /Qsdm6HjvgSm1KPhG/AY+C5yz5G9Vt+DRh0J9B3Nu/WF7WA4rVHhGbtsJ03DL/KDwS0b9
	 xxobMyRJoyGQ2Djgu380P1TLNxfrIaKY+0saN2m7bmzPiktWQYlqKYIXis8TPTEXI+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FtAO877H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zhFGUzLM;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FtAO877H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zhFGUzLM;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E8606A322;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495E8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FtAO877H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zhFGUzLM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FtAO877H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zhFGUzLM
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A15922176;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYWEkYXITRdxx8PJL4BELKv4UkAeNlUxpZyOSi0kIQo=;
	b=FtAO877Hb5sRzaL/qHjYMnifaB7F7HpqwZoOVfW4L1CY+epUs5SM3Vb6KK91DvNe3x5Hc9
	RBGzt/dcuOsOug+KKbL385Q46cul2wX/ziIHy8gFnhMq02rD6BpSDhmQNjdNEfYSoNryMa
	xPRFOYF090nCTlPbDACiOzCVV57Zau8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYWEkYXITRdxx8PJL4BELKv4UkAeNlUxpZyOSi0kIQo=;
	b=zhFGUzLMuQ2zv+oEedfJodd+TpcAXa/qLTuUrvcpOaRNye+gpsHYW29yyva0ZvBoKOZVvX
	X8o03a4//ODemBDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYWEkYXITRdxx8PJL4BELKv4UkAeNlUxpZyOSi0kIQo=;
	b=FtAO877Hb5sRzaL/qHjYMnifaB7F7HpqwZoOVfW4L1CY+epUs5SM3Vb6KK91DvNe3x5Hc9
	RBGzt/dcuOsOug+KKbL385Q46cul2wX/ziIHy8gFnhMq02rD6BpSDhmQNjdNEfYSoNryMa
	xPRFOYF090nCTlPbDACiOzCVV57Zau8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYWEkYXITRdxx8PJL4BELKv4UkAeNlUxpZyOSi0kIQo=;
	b=zhFGUzLMuQ2zv+oEedfJodd+TpcAXa/qLTuUrvcpOaRNye+gpsHYW29yyva0ZvBoKOZVvX
	X8o03a4//ODemBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FBAF134E6;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:52 +0000
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
Subject: [PATCH v3 1/7] vt: Add con_unblank callback to struct consw
Date: Fri, 23 Oct 2026 15:16:11 +0200
Message-ID: <20261023132448.115747-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023132448.115747-1-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-15.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -15.80

Add struct consw.con_unblank as inverse operation to con_blank.

If implemented invoke con_blank to turn the console from blanked to
unblanked. Also update the semantics of con_blank in this case: The
blank parameter of con_blank receives a VESA blank mode from enum
vesa_blank_mode instead of the hybrid unblank/blank values it has
used so far.

With con_unblank not implemented, invoke con_blank for blanking and
unblanking as before.

The old semantics of con_blank will be removed when all consoles
implement con_unblank.

v3:
- fix typo in commit description (Helge)
- add mode_switch parameter to con_unblank

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c     | 30 +++++++++++++++++++++++-------
 include/linux/console.h | 10 +++++++---
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8415e274e4be..82885f357f76 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4788,7 +4788,10 @@ void do_blank_screen(int entering_gfx)
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
@@ -4797,7 +4800,10 @@ void do_blank_screen(int entering_gfx)
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
@@ -4818,8 +4824,12 @@ void do_blank_screen(int entering_gfx)
 
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
@@ -4870,9 +4880,15 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
-		/* Low-level driver cannot restore -> do it ourselves */
-		update_screen(vc);
+	if (vc->vc_sw->con_unblank) {
+		if (vc->vc_sw->con_unblank(vc, leaving_gfx))
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
index df23148987ee..cb8be9ea4a76 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -55,9 +55,12 @@ enum vc_intensity;
  *		Invoked by csi_M and printing to the console.
  * @con_switch: notifier about the console switch; it is supposed to return
  *		true if a redraw is needed.
- * @con_blank:  blank/unblank the console. The target mode is passed in @blank.
- *		@mode_switch is set if changing from/to text/graphics. The hook
- *		is supposed to return true if a redraw is needed.
+ * @con_blank:  blank the console. The preferred VESA blank mode is passed in
+ *		@blank. @mode_switch is set if changing from/to text/graphics.
+ *		The hook is supposed to return true if a redraw is needed.
+ * @con_unblank: unblank the console. The hook is supposed to return true if
+ *		a redraw is needed. @mode_switch is set if changing from/to
+ *		text/graphics.
  * @con_font_set: set console @vc font to @font with height @vpitch. @flags can
  *		be %KD_FONT_FLAG_DONT_RECALC. (optional)
  * @con_font_get: fetch the current font on @vc of height @vpitch into @font.
@@ -99,6 +102,7 @@ struct consw {
 	bool	(*con_switch)(struct vc_data *vc);
 	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
 			     bool mode_switch);
+	bool	(*con_unblank)(struct vc_data *vc, bool mode_switch);
 	int	(*con_font_set)(struct vc_data *vc,
 				const struct console_font *font,
 				unsigned int vpitch, unsigned int flags);
-- 
2.56.0

