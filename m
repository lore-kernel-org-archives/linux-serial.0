Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94409484248;
	Mon,  5 Oct 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207237; cv=none; b=YewL1VDpd5yhajJ5UEfCHEnvXmH/a9ykV7/ow/q9b1l/2emwfUwCVn6RA6Jdlg18uKa7/v/6DnQh0+STYppO2N9acv7jQR4oKi3znnWd71nwMYgx4oaEulBj4j6NZzD624FNZJN9rzPOCaeASYAY/PFlncoJ2V2RrMSfENAOHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207237; c=relaxed/simple;
	bh=wBKDWFFWihRLCSn0j6oEohmGY0edyNsiIeDIw9KrFr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y283vV/P65NpN87N1OeJPE6IETOea0Kl8Am+jeqYW+HkUZACdysbLx/dFw8X6wgvNN2VrIGfeVpzOyLi2O2fUhcPf4lCf/zILXkKFVp/DWTP93XLVfD+HSdgHzNvUcP9y/7wcx1UutK0WX+qTwDbTiRBx+s8bIhnpToGcJHU1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPkqW0qc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=33U5s9yk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QKUXgfmY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wXThMyB4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPkqW0qc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="33U5s9yk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QKUXgfmY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wXThMyB4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A7BB1F7AF;
	Mon,  5 Oct 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrkScWXxruld5mQAdB3Ht5B2DWyB7XrVwqd3l8W3Stw=;
	b=BPkqW0qc7ZVOMMGQz4AE971Gguo9o8tA6CwZO7fcYta/mI4uKXg1d/APMN6Lf/b5i9XMU6
	DcWBiOwVjnKqrSZrMg0jCiNyosehWeZ19utBRzbjwNGqyoZT6BN9nx6PbbEiTdmrVO1hqc
	sRAiVUul6zi47dgd044vILAPHZX8lR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrkScWXxruld5mQAdB3Ht5B2DWyB7XrVwqd3l8W3Stw=;
	b=33U5s9ykxrnJ+JDBE28exDtQDYid75XTfcS9EiQsyLziEX1XuncNJ2k6JMxbHPIy9M34Sg
	nYuU7Il306WksBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrkScWXxruld5mQAdB3Ht5B2DWyB7XrVwqd3l8W3Stw=;
	b=QKUXgfmY1suNiwE+NCGMu3AKvVFx8IHRCw5vIvJM/EJfwFNzoOQ8DbJoGyqm/ATphTY5Rq
	fegXz6l4lSHcUGRYZS39F0/7V1GhuV87Pz0Q7J8UTVsW5ihODVoytD/HIf4l0R7B4FTl2q
	e4LNY/c0MJ/KQu4UpbFsJxhTVYwiAFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrkScWXxruld5mQAdB3Ht5B2DWyB7XrVwqd3l8W3Stw=;
	b=wXThMyB4CPwlZ5ZXhBN3HDGpqBVUSd1TuXVXsM4kbvf0VSPd1AnWtQv+SlIhT49Q6JCPZP
	s9RFdtUlnVA9eVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBE113AF0;
	Mon,  5 Oct 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiqWKDanw2rDdQAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 13:33:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-serial@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 3/5] vgacon: Use vt_cursor_{start,end}()
Date: Mon,  5 Oct 2026 15:31:01 +0200
Message-ID: <20261005133335.344302-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005133335.344302-1-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO

Replace vgacon's custom cursor metrics with the shared helpers
vc_cursor_start() and vc_font_cursor_end(). Note that the _end()
function returns the index of the scanline below the cursor, while
VGA hardware expects the cursor's final scanline. Hence vgacon
subtracts 1 from the end value.

The cursor shapes remain mostly unchanged, except that non-underline
cursors now also use the glyph's top-most and bottom-most scanline.
This follows the style used by fbcon.

v4:
- disable if CUR_DEF maps to CUR_NONE
v2:
- restore use of vc_cell_height (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 drivers/video/console/vgacon.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 536e7fe4d142..2dcb1e38bd6b 100644
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
+	c_size = vc_cursor_valid_size(CUR_SIZE(c->vc_cursor_type));
 
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

