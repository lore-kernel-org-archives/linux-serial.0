Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFE3A4F35
	for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2026 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553996; cv=none; b=fTxMqyfJ8HEw4ER7hWvY7G70a9k3eJcwSyTKyla0EE5P6l+ZfIBfHVH0PS3xK6QS8ZrvO9quPNaaVQelf+qO8OtvDDOC/2WI8oy4QmtBZxXv+MkyDkx9XrYrnfH2xvEDpb9/OIFs/UCkIdxsTY45zI/4YqmwZawGBG3qotGQ/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553996; c=relaxed/simple;
	bh=sofMrLVaRJmHnvOi/WZ5dFviNY/Uz7j8i1kFmDfvWb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb1w8DYtwleuyhn6ErymW9PnLK3Qae82y0zPbib4ZmQYY3os6U/GviLoTAHIQkl5gvaQJM9hDdTm115tMp3PHpQh0+7Xt11o27wXnX7c6hDMg07GFuDo/T4lt5IeWpfRLQ09C1VTP/oA9ml+oFwFsoA2yponxgI3dwcryR96Fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VRUh9Pu4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f2PBLy9Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VRUh9Pu4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f2PBLy9Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VRUh9Pu4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f2PBLy9Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VRUh9Pu4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f2PBLy9Q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEE1F4E3A7;
	Tue,  7 Apr 2026 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775553962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCDCXBTApxJH1hMKkIqxFlk34L2bDMI+B4Yn1SPG6x8=;
	b=VRUh9Pu4nPuT0+fqL7252IVmy/67zz8WbsIjC0T/lHmerDDqlEq0LTrhghsfE9HDukxNPd
	XrKkR7oBkWg8wOSf6CtWClCQhzkzuGh6hbwam8CjS2lXklwwMWelHIcBvC2mejSXJZaQi8
	x8iqwa1m0IpML/K5fs0QJpORJMj+884=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775553962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCDCXBTApxJH1hMKkIqxFlk34L2bDMI+B4Yn1SPG6x8=;
	b=f2PBLy9QFyHaNXvGyoFOmZqiztopXPastvaMT95Ki9u/8a4opgT7g9m1A+A5MONLgrp/6V
	vImn70S5btaeF4AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775553962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCDCXBTApxJH1hMKkIqxFlk34L2bDMI+B4Yn1SPG6x8=;
	b=VRUh9Pu4nPuT0+fqL7252IVmy/67zz8WbsIjC0T/lHmerDDqlEq0LTrhghsfE9HDukxNPd
	XrKkR7oBkWg8wOSf6CtWClCQhzkzuGh6hbwam8CjS2lXklwwMWelHIcBvC2mejSXJZaQi8
	x8iqwa1m0IpML/K5fs0QJpORJMj+884=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775553962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCDCXBTApxJH1hMKkIqxFlk34L2bDMI+B4Yn1SPG6x8=;
	b=f2PBLy9QFyHaNXvGyoFOmZqiztopXPastvaMT95Ki9u/8a4opgT7g9m1A+A5MONLgrp/6V
	vImn70S5btaeF4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75DB04A0B1;
	Tue,  7 Apr 2026 09:26:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8OeTG6rN1GmDVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 09:26:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert@linux-m68k.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 07/10] lib/fonts: Refactor glyph-rotation helpers
Date: Tue,  7 Apr 2026 11:23:18 +0200
Message-ID: <20260407092555.58816-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407092555.58816-1-tzimmermann@suse.de>
References: <20260407092555.58816-1-tzimmermann@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,linux-m68k.org,ffwll.ch,ravnborg.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Change the signatures of the glyph-rotation helpers to match their
public interfaces. Drop the inline qualifier.

Rename several variables to better match their meaning. Especially
rename variables to bit_pitch (or a variant thereof) if they store
a pitch value in bits per scanline. The original code is fairly
confusing about this. Move the calculation of the bit pitch into the
new helper font_glyph_bit_pitch().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font_rotate.c | 85 ++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index d79ec5eef712..09f6218e036f 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -15,6 +15,12 @@
 
 #include "font.h"
 
+/* number of bits per line */
+static unsigned int font_glyph_bit_pitch(unsigned int width)
+{
+	return round_up(width, 8);
+}
+
 static unsigned int __font_glyph_pos(unsigned int x, unsigned int y, unsigned int bit_pitch,
 				     unsigned int *bit)
 {
@@ -44,18 +50,21 @@ static void font_glyph_set_bit(unsigned char *glyph, unsigned int x, unsigned in
 	glyph[i] |= bit;
 }
 
-static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_90(const unsigned char *glyph,
+				   unsigned int width, unsigned int height,
+				   unsigned char *out)
 {
-	int i, j, h = height, w = width;
-	int shift = (8 - (height % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, height - 1 - i - shift, j, height);
+	unsigned int x, y;
+	unsigned int shift = (8 - (height % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+	unsigned int out_bit_pitch = font_glyph_bit_pitch(height);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch)) {
+				font_glyph_set_bit(out, out_bit_pitch - 1 - y - shift, x,
+						   out_bit_pitch);
+			}
 		}
 	}
 }
@@ -79,22 +88,24 @@ void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsign
 {
 	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
 
-	rotate_cw(glyph, out, width, height);
+	__font_glyph_rotate_90(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_90);
 
-static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_180(const unsigned char *glyph,
+				    unsigned int width, unsigned int height,
+				    unsigned char *out)
 {
-	int i, j;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-
-	for (i = 0; i < height; i++) {
-		for (j = 0; j < width - shift; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, width - (1 + j + shift),
-						   height - (1 + i), width);
+	unsigned int x, y;
+	unsigned int shift = (8 - (width % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch)) {
+				font_glyph_set_bit(out, width - (1 + x + shift), height - (1 + y),
+						   bit_pitch);
+			}
 		}
 	}
 }
@@ -115,22 +126,24 @@ void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsig
 {
 	memset(out, 0, font_glyph_size(width, height));
 
-	rotate_ud(glyph, out, width, height);
+	__font_glyph_rotate_180(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_180);
 
-static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
+static void __font_glyph_rotate_270(const unsigned char *glyph,
+				    unsigned int width, unsigned int height,
+				    unsigned char *out)
 {
-	int i, j, h = height, w = width;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (font_glyph_test_bit(in, j, i, width))
-				font_glyph_set_bit(out, i, width - 1 - j - shift, height);
+	unsigned int x, y;
+	unsigned int shift = (8 - (width % 8)) & 7;
+	unsigned int bit_pitch = font_glyph_bit_pitch(width);
+	unsigned int out_bit_pitch = font_glyph_bit_pitch(height);
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			if (font_glyph_test_bit(glyph, x, y, bit_pitch))
+				font_glyph_set_bit(out, y, bit_pitch - 1 - x - shift,
+						   out_bit_pitch);
 		}
 	}
 }
@@ -154,6 +167,6 @@ void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsig
 {
 	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
 
-	rotate_ccw(glyph, out, width, height);
+	__font_glyph_rotate_270(glyph, width, height, out);
 }
 EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
-- 
2.53.0

