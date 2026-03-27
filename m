Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD613ECBF6
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616704; cv=none; b=Q6YIpzGfaQ7FN7MZv1IApsJen2q/WCwulblZaDSRZtbBN9/9OsP5CcpBbc+7TK83l8k0ghKPScaKuudGqX/nLWs1NRy3rJH4Jfk/GR68GIrVVgTviUv6hLgqVznDRQuXE+vHiEP1JBfU/54ehsfpwUUC/DPRT37ynj/WUPANGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616704; c=relaxed/simple;
	bh=nVdgDbZb8tmD06udRURI81bPSo70ic+a3xXeWwPo2eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhahVdEXP0sKXA4kY4FQrZsZEr9TGf2VuQGDv1QSz/8vBHY8FIN+O/Btkl7fRk9XrcYz0BwDHw99R4fDORyc7YHPM56C34KjNAvpHEhsRAcJ/tmcBhlu4doOXMJBvFs1HMnD1lgMyoK6++Ioml2JWowDr6oICnkiRw0QA7NwKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 035D34D39F;
	Fri, 27 Mar 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B44294A0B1;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIjRKmWAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/10] lib/fonts: Refactor glyph-rotation helpers
Date: Fri, 27 Mar 2026 13:49:40 +0100
Message-ID: <20260327130431.59481-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 035D34D39F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

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
index cfaf5b98f49a..f1e441a931ab 100644
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

