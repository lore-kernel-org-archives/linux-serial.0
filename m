Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018D48F848;
	Tue, 15 Sep 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475606; cv=none; b=K6wJdb55+AqBuIYVYl+r9fQEbeA+iH457dXbYsjSRp/AVxr3bxk4HSDjQZ/+kPgq6cjpkJW5vZn1948tpZQAsE8MLgYrYJhgNdLhH0mgr8EKO5FFgEdZeQqeKOrus3qwYcp3T/PkabXRJYWo2ilCk7iz5QfPrH380yvgc35sRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475606; c=relaxed/simple;
	bh=kIWPvN1xdzI0vvk+cqAjZuQ+NiStAVELpv+YNHXuDug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1fErIczcxf+hFopZ4+eDcidv2H43UyUg6lBs8baiDkaUqWATzAXOsMgrMQP3re6oIB4lrK6WerfWCdbDmSYe64ksWE3wHU643SzoiUa11OVqwrWBCP8MeeQ0xBQa2uHZ891sB/iYv3FV3PuHAdCF+DtpM4qMJI6FhAjTy/32iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wk+Z2uyG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3yff601G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DqhIbfZO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5gjA+gKf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wk+Z2uyG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3yff601G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DqhIbfZO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5gjA+gKf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72B4921CC2;
	Tue, 15 Sep 2026 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=wk+Z2uyGFC6qDO21ZjS++lx7jilujfsdI+x0j1v2MyrzilMhCR4GJNHdbu52HyhOxj/aST
	AH3S7rTb3YaW/5DN/3QPJZCE8lBOgKHC6DnAqfk7WYD/U1greyHjJj41U+Zqp1ku1MLTmW
	ho+3D2ltSl7ONUUphTpCGz0ncEvrRGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=3yff601GGsb8DvipYSKeaKf4CjgRWetAAloJsRTuvop6rgEnthr86tgVWOu5TJowu4tGqz
	MUnOsvIIM92SXmDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=DqhIbfZON2/emEyH+IKEAd9QkILbNy80eklYrfp+xh74cEU0+vWV1Oq4cEfDOZIzjG9YcQ
	n5p22g0FQRwaO+04X3h3gH90KgQJ15TGFPpbdSpBqsVJd+RlzuKEjZbW+0P2NJL+/0KX7Y
	oGZTxzoRkGyPkzXJD4nVQDFeaGMCC+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONdTxhedLm8ux4WYa6nJOCgvg99wnIBGvzLaX70z8pc=;
	b=5gjA+gKf6WbEQl7jDsLYMPFrsFhtAQn4tTUDqPh2SNIXQ77DY/rjsmiAi5sjHx8TkMaOW7
	NMd1Kb0td2n67VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A6DD13806;
	Tue, 15 Sep 2026 12:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COmnAwk7qWpGNQAAD6G6ig:T4
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Sep 2026 12:33:14 +0000
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
Subject: [PATCH v2 3/5] vgacon: Use vt_cursor_{start,end}()
Date: Tue, 15 Sep 2026 14:29:14 +0200
Message-ID: <20260915123304.1027277-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915123304.1027277-1-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,gmx.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

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

