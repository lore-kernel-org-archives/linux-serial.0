Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B643327C18;
	Mon, 28 Sep 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585861; cv=none; b=J64swL5r5fgY8uR6BYMi+ziFANJO53QcN5AZXX1/ytnYTHldhiBwdG0dAsmdBKbquJtxGsVcjLfs0LtfCLNgSSmGdeCOS569HzdSrzT2WCKDqauS9zjkuPo3MKLLWQaJdoIxju2gtcfbyJ3eH4S4wqkTO4/7OLsedFe8nyX+uTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585861; c=relaxed/simple;
	bh=kIWPvN1xdzI0vvk+cqAjZuQ+NiStAVELpv+YNHXuDug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6k7NECc5CAuyhegAk/AncONQB3/6W8a7Cizvwnps0ENa/ujFempRHSHfqVQILzSCegZNhoMcQTN/JSPmt1wpRpnKcsS+7CxpRzMoKkyomQXhkOucFLxM/VxkU68Sxof3OqSfhzTWS7PcpnXTVb273PblpUiwXg1LTrFt3+NgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qWp65NFR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6se3jsvH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q9OmmGc0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=llGOmrpI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qWp65NFR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6se3jsvH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q9OmmGc0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="llGOmrpI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B734220B6;
	Mon, 28 Sep 2026 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=qWp65NFR+vY/TlfE3G2E9yzErJ8gN1VZZ4sjd9CAGIcVYFEYdecYxGAEwIUSYf/sNejUyt
	1NEZ34Ouet4YXs4YPqz4SV7yaApdvFUb/nOwrwLr6P77lovT/Yf42QILsXI7HIZIdCEiKA
	SrmWScWD7gdgKMla0F6KLzFdabtu2ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=6se3jsvHqYMFYuFAHH5iKiz1zRcNhy4pf8WnT5X5trLlsESyfNUe6yZTZF5YIWWb6mSQPl
	tvAQf9LI/kdwWcCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q9OmmGc0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=llGOmrpI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=q9OmmGc0bCLKGK4oQTKLiuEstTwijD7275NUcCCIRUKTcF7BYRnmmI1JWefVqXvkS+DT0t
	P9STS4tXzv6QEGp/ANUiqPG8822X4qN6X+9qV9ZeOU8DWk2gJFAJ3hjIAiyADr4uHM0UfL
	Bp4wjSie2cYBnlW47g1YXZDguFEBZBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=llGOmrpISnY8kkEv83RzY3DmplLzFpq32E2+t/P54brogM+HACiayLrT/25gnNg+JHH6jm
	XvsHrFDUOplaRuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDD8713419;
	Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kr86I/crumo3HwAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 08:57:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-serial@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/5] vgacon: Use vt_cursor_{start,end}()
Date: Mon, 28 Sep 2026 10:55:26 +0200
Message-ID: <20260928085724.41660-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928085724.41660-1-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 3B734220B6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
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
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,gmx.de:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Replace vgacon's custom cursor metrics with the shared helpers
vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
function returns the index of the scanline below the cursor, while
VGA hardware expects the cursor's final scanline. Hence vgacon
subtracts 1 from the end value.

The cursor shapes remain mostly unchanged, except that non-underline
cursors now also use the glyph's top-most and bottom-most scanline.
This follows the style used by fbcon.

v2:
- restore use of vc_cell_height (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 drivers/video/console/vgacon.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 536e7fe4d142..b1408bb5e265 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -506,6 +506,7 @@ static void vgacon_set_cursor_size(int from, int to)
 static void vgacon_cursor(struct vc_data *c, bool enable)
 {
 	unsigned int c_height;
+	unsigned int c_size;
 
 	if (c->vc_mode != KD_TEXT)
 		return;
@@ -513,10 +514,11 @@ static void vgacon_cursor(struct vc_data *c, bool enable)
 	vgacon_restore_screen(c);
 
 	c_height = c->vc_cell_height;
+	c_size = CUR_SIZE(c->vc_cursor_type);
 
 	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
 
-	if (!enable) {
+	if (!enable || c_size == CUR_NONE) {
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
 			vgacon_set_cursor_size(31, 30);
 		else
@@ -524,33 +526,8 @@ static void vgacon_cursor(struct vc_data *c, bool enable)
 		return;
 	}
 
-	switch (CUR_SIZE(c->vc_cursor_type)) {
-	case CUR_UNDERLINE:
-		vgacon_set_cursor_size(c_height - (c_height < 10 ? 2 : 3),
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_TWO_THIRDS:
-		vgacon_set_cursor_size(c_height / 3,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_LOWER_THIRD:
-		vgacon_set_cursor_size(c_height * 2 / 3,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_LOWER_HALF:
-		vgacon_set_cursor_size(c_height / 2,
-				       c_height - (c_height < 10 ? 1 : 2));
-		break;
-	case CUR_NONE:
-		if (vga_video_type >= VIDEO_TYPE_VGAC)
-			vgacon_set_cursor_size(31, 30);
-		else
-			vgacon_set_cursor_size(31, 31);
-		break;
-	default:
-		vgacon_set_cursor_size(1, c_height);
-		break;
-	}
+	vgacon_set_cursor_size(vc_cursor_start(c_height, c_size),
+			       vc_cursor_end(c_height, c_size) - 1);
 }
 
 static void vgacon_doresize(struct vc_data *c,
-- 
2.55.0

