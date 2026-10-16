Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A77483BEA;
	Fri, 16 Oct 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143251; cv=none; b=dHa1o7HpRyLP0L2dr3ul+NUv6+QeObNv728ivqHzFVcFL8zSlktyOtClDd1xT+p/5ggPS0divgrlB+dNLbMaNIBg6a7nix15jqFEidIWR+TAa2/0rjLIS6bRu+MTzNo2XYhQvhmIuV8cjXdft3ujBOIE0iGpfqQ7EScCZz/FIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143251; c=relaxed/simple;
	bh=Wrs+SVXb9uEFGBb5fL6xASMYt2gFmNuYucTNFgJL56k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my/fcGmaccZXcN2f6aE8f125gmzXwEw+htbMCyBtqKBhROfETrWRRxQbPZDhFaxsDrKn+djQDzpKof9BR9/Cy+dJqs2E610PA7O+AOZa0IgQHfEf4nHVkiKALjm3xlNueBzcWGKQmXSBF5gKn6xLXTxiRdbb+1SktGTKzV3KbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wrYcl0+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VH5OmjJm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wrYcl0+V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VH5OmjJm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wrYcl0+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VH5OmjJm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wrYcl0+V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VH5OmjJm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A300621C15;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeSoQiQ5ORlTqAZjMneFz0cgyP5LHbAOMi9jVF+Tpt0=;
	b=wrYcl0+VIfyk/dQrs4OIAmvDeZCYFPIFqA+2RRzdblF46il8iDgBThhIiAGMNjZFemo8Cd
	Qy4IuUU7BfbQs/kiALKDJVhNwHyXhksOW3ENxzIfQpl85WZS+DBgq6hOntR6kSYcxGOf5+
	Np4sHzDRcyhwacz9unXcUC0+vuDGVPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeSoQiQ5ORlTqAZjMneFz0cgyP5LHbAOMi9jVF+Tpt0=;
	b=VH5OmjJmER1RnQ9ceWtR/qaiB1psnXZ2MjGUNU3R8UR2STwZY9HvIbj9XuRD0Y0YhxkOK4
	2X8ThrwsiiZs5nDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wrYcl0+V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VH5OmjJm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeSoQiQ5ORlTqAZjMneFz0cgyP5LHbAOMi9jVF+Tpt0=;
	b=wrYcl0+VIfyk/dQrs4OIAmvDeZCYFPIFqA+2RRzdblF46il8iDgBThhIiAGMNjZFemo8Cd
	Qy4IuUU7BfbQs/kiALKDJVhNwHyXhksOW3ENxzIfQpl85WZS+DBgq6hOntR6kSYcxGOf5+
	Np4sHzDRcyhwacz9unXcUC0+vuDGVPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IeSoQiQ5ORlTqAZjMneFz0cgyP5LHbAOMi9jVF+Tpt0=;
	b=VH5OmjJmER1RnQ9ceWtR/qaiB1psnXZ2MjGUNU3R8UR2STwZY9HvIbj9XuRD0Y0YhxkOK4
	2X8ThrwsiiZs5nDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3958B138A5;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T7
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
Subject: [PATCH v2 6/7] vgacon: Implement struct consw.con_unblank
Date: Fri, 16 Oct 2026 11:11:56 +0200
Message-ID: <20261016093357.33294-7-tzimmermann@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: A300621C15
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Implement con_unblank from struct consw with the VESA_NO_BLANKING
case from vgacon_blank(). The new function is called vgacon_unblank().
Remove the duplicated code from vgacon_blank().

Vgacon uses the global state vga_is_gfx in several places to test if
the console runs on text or graphics mode. Track the mode switches in
vgacon_blank() and vga_unblank(). As vgacon_unblank() does not have
a mode_switch parameter, derive the value from vga_is_gfx and vc_mode.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/vgacon.c | 53 ++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 536e7fe4d142..7f52164c30af 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -800,39 +800,47 @@ static void vga_pal_blank(struct vgastate *state)
 static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
 			 bool mode_switch)
 {
+	if (mode_switch)
+		vga_is_gfx = true;
+
 	switch (blank) {
-	case VESA_NO_BLANKING:		/* Unblank */
-		if (vga_vesa_blanked) {
-			vga_vesa_unblank(&vgastate);
-			vga_vesa_blanked = VESA_NO_BLANKING;
-		}
-		if (vga_palette_blanked) {
-			vga_set_palette(c, color_table);
-			vga_palette_blanked = false;
-			return 0;
-		}
-		vga_is_gfx = false;
-		/* Tell console.c that it has to restore the screen itself */
-		return 1;
-	case VESA_VSYNC_SUSPEND:	/* Normal blanking */
+	case VESA_NO_BLANKING:	/* Normal blanking */
 		if (!mode_switch && vga_video_type == VIDEO_TYPE_VGAC) {
 			vga_pal_blank(&vgastate);
 			vga_palette_blanked = true;
-			return 0;
+			return false;
 		}
 		vgacon_set_origin(c);
-		scr_memsetw((void *) vga_vram_base, BLANK,
-			    c->vc_screenbuf_size);
-		if (mode_switch)
-			vga_is_gfx = true;
-		return 1;
+		scr_memsetw((void *)vga_vram_base, BLANK, c->vc_screenbuf_size);
+		return true;
 	default:		/* VESA blanking */
 		if (vga_video_type == VIDEO_TYPE_VGAC) {
-			vga_vesa_blank(&vgastate, blank - 1);
+			vga_vesa_blank(&vgastate, blank);
 			vga_vesa_blanked = blank;
 		}
-		return 0;
+		return false;
+	}
+}
+
+static bool vgacon_unblank(struct vc_data *c)
+{
+	bool mode_switch = vga_is_gfx && c->vc_mode == KD_TEXT;
+
+	if (mode_switch)
+		vga_is_gfx = false;
+
+	if (vga_vesa_blanked) {
+		vga_vesa_unblank(&vgastate);
+		vga_vesa_blanked = VESA_NO_BLANKING;
 	}
+
+	if (vga_palette_blanked) {
+		vga_set_palette(c, color_table);
+		vga_palette_blanked = false;
+		return false;
+	}
+
+	return true;
 }
 
 /*
@@ -1201,6 +1209,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_unblank = vgacon_unblank,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
-- 
2.55.0

