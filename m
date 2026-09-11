Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D847638D01B;
	Fri, 11 Sep 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119935; cv=none; b=B4E/WetlFPJSZwjddnFG2efs27gqn4ny4QjlM/csIiJrSDN4GSjqCCFG5u/3n82IGZZaj1w9uo73fAH5cHCDOHYNjM3cj1nxfkmsB9NwoyCqFiLK3gPMKDhdqfUXhXLSbDjDpfwtQMs6R+bexTRrF9lF+Xk6JbsTp5OvSBm0Dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119935; c=relaxed/simple;
	bh=8BC5WMVJQvXFFdwznUb1q4AXCCJhBEhvHprSVJ+Ci34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCZsCr4W14TDILyZS8WmcTLrD5S+OgaczSWgj7sqLaHj7NAoL5yxObZ3qMND6n6k8rZNaOCb0rjrC9hbRScDQg0nR3Ww1k3uRc4j2qVrUK0el8TsRaKuTG/o1bw8Usc05de73syGMU4pOVvE4Joje/NzRYj+/svG6pADBL8Wgo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=onWQlE7R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T4QyD/Ve; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sr7Met8P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q2zLlwZ2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="onWQlE7R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T4QyD/Ve";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sr7Met8P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q2zLlwZ2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C95D221C13;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgJD/24JgzG6HUPVmtTP5bvbzIrxAtdnQk+Wl9STOwI=;
	b=onWQlE7RpiuFiTQ33HGbTF2bpbn0ShbZUpNs8bBAMvkVt8rDYLc2YWy4bEU6WtEx8GgefA
	zY/FYOFv5JeGF3F6sPv6ihHbQKSksf984wN+G1f42vmdO8fgVcveLR+MSjE+EZUracuF4X
	PTI4Iay44p1tXYBxq/kWijGUAXHiq2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgJD/24JgzG6HUPVmtTP5bvbzIrxAtdnQk+Wl9STOwI=;
	b=T4QyD/VegLn2Z0r7TBfZWbEQuxc/Z1cpQ5LK4pEfxKTw0Spl58U2m9OI4ZeRWvq5drd/gh
	6cR9eD6snGV+98DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgJD/24JgzG6HUPVmtTP5bvbzIrxAtdnQk+Wl9STOwI=;
	b=Sr7Met8PyODH0KQ+WgSBpPfest+Qol318S3qnyxlU+k+y7CpDKILP/khEl+lfvRE10RyKe
	23Tj5XZWDcXzLRdOq/UQ0wjifOAdUp67rDQSL5pRRgaBwEydiCZrefzijwPLJGKJBHE/wU
	9xGSbKy7TvUZhsazBtcHub5SM3g1eFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgJD/24JgzG6HUPVmtTP5bvbzIrxAtdnQk+Wl9STOwI=;
	b=q2zLlwZ2XTChxtjbgdTNbiupAaiQ1EhKGh+1HDnWeHb1JvC4PQkpjf9Ozhq/TxrNPCVekz
	+OT1+iAOuT21hyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6994F13715;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0CmOGLPNo2oFVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 09:45:23 +0000
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
Subject: [PATCH 1/5] vt: Add cursor-size helpers
Date: Fri, 11 Sep 2026 11:25:19 +0200
Message-ID: <20260911094518.78093-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911094518.78093-1-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Cursors in the VT subsystem are blocks within a character cell that are
filled with the foreground color. The new helpers vc_font_cursor_start()
and vc_font_cursor_end() return the scanlines in which the cursor block
starts rsp. ends. This is compatible with VGA hardware

In terms of cursor design, the new cursor-size helpers follow established
styles in fbcon. The only exception is in underline cursors for fonts with
a size larger than 10. The underlining dash is now one pixel closer to
the font-glyph data, so that the cursor looks less detached. This follows
the style used by vgacon.

Similar code in vgacon and fbcon ignores the cursor's default size stored
in vt.cur_default. The consoles default to full-block cursors, while vt
defaults to underline cursors. The new helper fall back to cur_default and
then underline cursors; in this order.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c            | 90 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  2 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..87c4bc2ef495 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -264,6 +264,96 @@ unsigned int vc_font_size(const struct vc_font *font)
 }
 EXPORT_SYMBOL_GPL(vc_font_size);
 
+static unsigned int vc_cursor_start(unsigned int height, unsigned int cursor_size)
+{
+retry:
+	switch (cursor_size) {
+	case CUR_NONE:
+		return height;
+	case CUR_UNDERLINE:
+		if (height < 10)
+			return height - 1;
+		else
+			return height - 3;
+	case CUR_LOWER_THIRD:
+		return height - height / 3;
+	case CUR_LOWER_HALF:
+		return height - height / 2;
+	case CUR_TWO_THIRDS:
+		return height - (height * 2) / 3;
+	case CUR_BLOCK:
+		return 0;
+	default:
+		pr_warn_once("Unknown cursor %u\n", cursor_size);
+		if (cursor_size != CUR_SIZE(cur_default))
+			cursor_size = CUR_SIZE(cur_default);
+		else
+			cursor_size = CUR_UNDERLINE;
+		goto retry;
+	}
+}
+
+/**
+ * vc_font_cursor_start - Calculates the cursor's first scanline within a glyph
+ * @font: The VC font
+ * @cursor_type: The type of cursor pattern
+ *
+ * The parameter @font is an initialized font. The argument in @cursor_type
+ * is one of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type. For
+ * unknown values, the helper draws an underline dash.
+ *
+ * Returns:
+ * The index of the cursor's first scanline within the glyph
+ */
+unsigned int vc_font_cursor_start(const struct vc_font *font, unsigned int cursor_type)
+{
+	return vc_cursor_start(font->height, CUR_SIZE(cursor_type));
+}
+EXPORT_SYMBOL_GPL(vc_font_cursor_start);
+
+static unsigned int vc_cursor_end(unsigned int height, unsigned int cursor_size)
+{
+retry:
+	switch (cursor_size) {
+	case CUR_UNDERLINE:
+		if (height < 10)
+			return height;
+		else
+			return height - 1;
+	case CUR_NONE:
+	case CUR_LOWER_THIRD:
+	case CUR_LOWER_HALF:
+	case CUR_TWO_THIRDS:
+	case CUR_BLOCK:
+		return height;
+	default:
+		pr_warn_once("Unknown cursor %u\n", cursor_size);
+		if (cursor_size != CUR_SIZE(cur_default))
+			cursor_size = CUR_SIZE(cur_default);
+		else
+			cursor_size = CUR_UNDERLINE;
+		goto retry;
+	}
+}
+
+/**
+ * vc_font_cursor_end - Calculates the first scanline after the cursor within a glyph
+ * @font: The VC font
+ * @cursor_type: The type of cursor pattern
+ *
+ * The parameter @font is an initialized font. The argument in @cursor_type
+ * is one of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type. For
+ * unknown values, the helper draws an underline dash.
+ *
+ * Returns:
+ * The index of the first scanline after the cursor within the glyph
+ */
+unsigned int vc_font_cursor_end(const struct vc_font *font, unsigned int cursor_type)
+{
+	return vc_cursor_end(font->height, CUR_SIZE(cursor_type));
+}
+EXPORT_SYMBOL_GPL(vc_font_cursor_end);
+
 /*
  * /sys/class/tty/tty0/
  *
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..6f30f209e1b0 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -84,6 +84,8 @@ struct vc_font {
 
 unsigned int vc_font_pitch(const struct vc_font *font);
 unsigned int vc_font_size(const struct vc_font *font);
+unsigned int vc_font_cursor_start(const struct vc_font *font, unsigned int cursor_type);
+unsigned int vc_font_cursor_end(const struct vc_font *font, unsigned int cursor_type);
 
 /*
  * Example: vc_data of a console that was scrolled 3 lines down.
-- 
2.55.0

