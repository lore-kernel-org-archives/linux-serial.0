Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C44779A1;
	Fri, 16 Oct 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143247; cv=none; b=EvThcPfYlXoZN7FwHGYRm3XJu8TukuDRdnEVPD1z+o9krMO7bnO7mbWu5VKiui0kJHwAOKt9fljxiTAEhELm6EekYqu02cApkJ4MX/Pk7npEg1EO6OUyRb+nPVPhspOINYKsRLUdjPV8muugRZReiT8QP6kf/QNIykbBiymrJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143247; c=relaxed/simple;
	bh=+BZjwTQKoce5W8KA91apqHd+1ZUJiSiSs9ry9E2d2zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYGYxY4ZnfbxIkXY0iEKJRqS2cmwKMpiRis+G6mXENlCMB3Y9MVOO5zVVMQNRV+Rzdb+4C8iJaVl0MVuuozvXP1UYCWfc2dY2w6Wa1iYC02cdecG/pTufdINfwmWRWZw7dMzPPGbTfewz6wSl5y+GkZyN7C1LtRvlPnme0UhKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U+bd1zAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ABh5Z2Xy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U+bd1zAD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ABh5Z2Xy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U+bd1zAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABh5Z2Xy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U+bd1zAD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABh5Z2Xy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACDEA21C45;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkhvUXcdvsPX4PpgetTa+/2BwrKVSWWqeF7gamXcI7w=;
	b=U+bd1zADy8BAa8moMTR/FwIxhTvh1RNHD5TT0bknEfanCA/rOFAOM0YvzELxc13DncpIn/
	lp2Y2O2xoa8MIQqXMLyVh24tneOLaZnnAlupcMOlHpexZM4H/s5LwVY626gbGTNmDaGap1
	O6BOoPj5l4pBxiuUEzDPkHycptEbJKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkhvUXcdvsPX4PpgetTa+/2BwrKVSWWqeF7gamXcI7w=;
	b=ABh5Z2XyIf8AeBHiw6bH+FSsagWxDfRDPRT9jPvB5zhHapnxxbfnfqhfY5UabPuIjJsU4W
	nyi+CpGUGGT/ZlDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkhvUXcdvsPX4PpgetTa+/2BwrKVSWWqeF7gamXcI7w=;
	b=U+bd1zADy8BAa8moMTR/FwIxhTvh1RNHD5TT0bknEfanCA/rOFAOM0YvzELxc13DncpIn/
	lp2Y2O2xoa8MIQqXMLyVh24tneOLaZnnAlupcMOlHpexZM4H/s5LwVY626gbGTNmDaGap1
	O6BOoPj5l4pBxiuUEzDPkHycptEbJKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkhvUXcdvsPX4PpgetTa+/2BwrKVSWWqeF7gamXcI7w=;
	b=ABh5Z2XyIf8AeBHiw6bH+FSsagWxDfRDPRT9jPvB5zhHapnxxbfnfqhfY5UabPuIjJsU4W
	nyi+CpGUGGT/ZlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5226C1378C;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:02 +0000
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
Subject: [PATCH v2 3/7] fbcon: Implement struct consw.con_unblank
Date: Fri, 16 Oct 2026 11:11:53 +0200
Message-ID: <20261016093357.33294-4-tzimmermann@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Implement con_unblank from struct consw with the !blank branches from
fbcon_blank(). The new function is called fbcon_unblank(). Remove the
duplicated code from fbcon_blank().

Fbcon tracks fbdev blank state in par->blank_state using fbdev's FB_BLANK
constants. In fbcon_unblank() the stored value is always FB_BLANK_UNBLANK.
In fbcon_blank(), the new blank state is 1 + plus the VESA blank mode
given in the parameter blank.

fbcon_blank() now disables the cursor worker unconditionally.

Unblanking while switching the console from graphics to text mode
requires setting the display with fb_set_var(). fbcon_unblank() does not
receive the mode_switch flag from its caller, so track the flag with the
par->graphics and vc->vc_num fields. A later update might add a mode-
switching callback to simplify this logic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 56 ++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 615fa596b7cc..6d564111ebd0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2293,32 +2293,53 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (mode_switch) {
-		struct fb_var_screeninfo var = info->var;
+	if (mode_switch)
+		par->graphics = true;
 
-		par->graphics = 1;
+	if (fbcon_is_active(vc, info)) {
+		int blank_state = 1 + blank; /* convert VESA to FB_BLANK constant */
 
-		if (!blank) {
-			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE |
-				FB_ACTIVATE_KD_TEXT;
-			fb_set_var(info, &var);
-			par->graphics = 0;
-			par->var = info->var;
+		if (par->blank_state != blank_state) {
+			par->blank_state = blank_state;
+			fbcon_cursor(vc, false);
+			par->cursor_flash = false;
+
+			if (fb_blank(info, blank_state))
+				fbcon_generic_blank(vc, info, true);
 		}
 	}
 
+	fbcon_del_cursor_work(info);
+
+	return false;
+}
+
+static bool fbcon_unblank(struct vc_data *vc)
+{
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
+	struct fbcon_par *par = info->fbcon_par;
+	bool mode_switch = par->graphics && vc->vc_mode == KD_TEXT;
+
+	if (mode_switch) {
+		struct fb_var_screeninfo var = info->var;
+
+		var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE | FB_ACTIVATE_KD_TEXT;
+		fb_set_var(info, &var);
+		par->graphics = false;
+		par->var = info->var;
+	}
+
 	if (fbcon_is_active(vc, info)) {
-		if (par->blank_state != blank) {
-			par->blank_state = blank;
-			fbcon_cursor(vc, !blank);
-			par->cursor_flash = (!blank);
+		if (par->blank_state != FB_BLANK_UNBLANK) {
+			par->blank_state = FB_BLANK_UNBLANK;
+			fbcon_cursor(vc, true);
+			par->cursor_flash = true;
 
-			if (fb_blank(info, blank))
-				fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, FB_BLANK_UNBLANK))
+				fbcon_generic_blank(vc, info, false);
 		}
 
-		if (!blank)
-			update_screen(vc);
+		update_screen(vc);
 	}
 
 	if (mode_switch || !fbcon_is_active(vc, info) || par->blank_state != FB_BLANK_UNBLANK)
@@ -3168,6 +3189,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_unblank		= fbcon_unblank,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.55.0

