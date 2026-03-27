Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AC3E9F76
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616699; cv=none; b=pEGPcbfkdxS/UV6bzmjSEUHeQV6bIjDP5QAZP3SynLGC8MeQzoKQPlfY047h7QgwIYKZM8DP43PjfQakI8+9NKtGVo+aPEGWmbg9j3XVvax4mCKsFFGqgUm4EuMlKZEp7oEdLJoJXv5CfIHmEXaksUOICabTDHXzRJILjd1oHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616699; c=relaxed/simple;
	bh=SwyFcBTtjprZ6cZs5AKJ5D4ZGP++skRWaDNUudjAcrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkMrtUIpc0+JzLtkX45acFDBL3QeVlFQiOrcY3uHM6leVr2ymwmK5VLkDmQqeCT1AI1kohJraa7dkr4eCgDuvqG51s+KK4hNUyVuXTNL+KYfgDW9oFrdTfvS/anUkn1KTO/WfxVCnvG1QETcCFS+ZwiF+OsZtnIE8DNUB1mh5sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b11CVxWD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZYegzk9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b11CVxWD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XZYegzk9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b11CVxWD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZYegzk9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b11CVxWD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XZYegzk9"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACF214D395;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VcpVHM73mKA2ZM9jxQN+8VqSFFJcUK690qm6q5lkVM=;
	b=b11CVxWDf/kD1SSDdBCmx+N4l016RPUCA1mHO5f3fVsYKfi5DZ0h9Qky8l2EMBwg5QpeSl
	iIm0QHA7bUOVKUhuwP5E6j5NPjRTXwWYt///SOruU8ajrBPc1BbvnF5buW610vaNejYx0O
	wW4LPI1WQxeMZAGDglbV7Zm/NrsUGW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VcpVHM73mKA2ZM9jxQN+8VqSFFJcUK690qm6q5lkVM=;
	b=XZYegzk9hsQvA0PqhQGn3HWsFR3A9RCTgce1S2lYxngpj6J/sukYCS7AUh99nKNDfk1P3e
	nOnc2NyC/OBkz1Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VcpVHM73mKA2ZM9jxQN+8VqSFFJcUK690qm6q5lkVM=;
	b=b11CVxWDf/kD1SSDdBCmx+N4l016RPUCA1mHO5f3fVsYKfi5DZ0h9Qky8l2EMBwg5QpeSl
	iIm0QHA7bUOVKUhuwP5E6j5NPjRTXwWYt///SOruU8ajrBPc1BbvnF5buW610vaNejYx0O
	wW4LPI1WQxeMZAGDglbV7Zm/NrsUGW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VcpVHM73mKA2ZM9jxQN+8VqSFFJcUK690qm6q5lkVM=;
	b=XZYegzk9hsQvA0PqhQGn3HWsFR3A9RCTgce1S2lYxngpj6J/sukYCS7AUh99nKNDfk1P3e
	nOnc2NyC/OBkz1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CF624A0A2;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WA9mGWWAxmmweQAAD6G6ig
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
Subject: [PATCH 06/10] lib/fonts: Refactor glyph-pattern helpers
Date: Fri, 27 Mar 2026 13:49:39 +0100
Message-ID: <20260327130431.59481-7-tzimmermann@suse.de>
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
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Change the signatures of the pattern helpers to align them with other
font-glyph helpers: use the font_glyph_ prefix and pass the glyph
buffer first.

Calculating the position of the involved bit is somewhat obfuscated
in the original implementation. Move it into the new helper
__font_glphy_pos() and use the result as array index and bit position.

Note that these bit helpers use a bit pitch, while other code uses a
byte pitch. This is intentional an required here.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/font_rotate.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index 3e0a19c889f3..cfaf5b98f49a 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -15,21 +15,33 @@
 
 #include "font.h"
 
-static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
+static unsigned int __font_glyph_pos(unsigned int x, unsigned int y, unsigned int bit_pitch,
+				     unsigned int *bit)
 {
-	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
+	unsigned int off = y * bit_pitch + x;
+	unsigned int bit_shift = off % 8;
 
-	pat += index;
-	return (*pat) & (0x80 >> bit);
+	*bit = 0x80 >> bit_shift; /* MSB has position 0, LSB has position 7 */
+
+	return off / 8;
 }
 
-static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
+static bool font_glyph_test_bit(const unsigned char *glyph, unsigned int x, unsigned int y,
+				unsigned int bit_pitch)
 {
-	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
+	unsigned int bit;
+	unsigned int i = __font_glyph_pos(x, y, bit_pitch, &bit);
+
+	return glyph[i] & bit;
+}
 
-	pat += index;
+static void font_glyph_set_bit(unsigned char *glyph, unsigned int x, unsigned int y,
+			       unsigned int bit_pitch)
+{
+	unsigned int bit;
+	unsigned int i = __font_glyph_pos(x, y, bit_pitch, &bit);
 
-	(*pat) |= 0x80 >> bit;
+	glyph[i] |= bit;
 }
 
 static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
@@ -42,9 +54,8 @@ static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
 
 	for (i = 0; i < h; i++) {
 		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(height - 1 - i - shift, j,
-						height, out);
+			if (font_glyph_test_bit(in, j, i, width))
+				font_glyph_set_bit(out, height - 1 - i - shift, j, height);
 		}
 	}
 }
@@ -81,10 +92,9 @@ static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
 
 	for (i = 0; i < height; i++) {
 		for (j = 0; j < width - shift; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(width - (1 + j + shift),
-						height - (1 + i),
-						width, out);
+			if (font_glyph_test_bit(in, j, i, width))
+				font_glyph_set_bit(out, width - (1 + j + shift),
+						   height - (1 + i), width);
 		}
 	}
 }
@@ -119,9 +129,8 @@ static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
 
 	for (i = 0; i < h; i++) {
 		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(i, width - 1 - j - shift,
-						height, out);
+			if (font_glyph_test_bit(in, j, i, width))
+				font_glyph_set_bit(out, i, width - 1 - j - shift, height);
 		}
 	}
 }
-- 
2.53.0

