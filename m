Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2E4854E6;
	Mon,  5 Oct 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207240; cv=none; b=DRdMzrm+7+rHOs7zG5JdZmzxdpZZKuVCe122rtte7qjO6JV6Iedl4LATookLzvU+96Cuh34AGxYzUa+jzNnHZfkslQxAl/Hk6Mfs2vpeqBRD0A6U6kO2uYty3LbrTZx4vyBlP1Cw3EOL+Mb2Rn+l4+erA+Zdsz1CBg/rdcfXGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207240; c=relaxed/simple;
	bh=fW5WQRnGUu5NNryVooiTdlNVXAc8inzeidnxQnNJ2f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtiQAWE0e9JtD1zDcjeeYLOTKGMdoLZBU4D65eGlCYmFmkK7ICGvRN/ZPaVrBEYuzLaaenHU6tAz36I0WvBUNR/mlJbzKrd4hmCm8l1/yk7CHR4wCckByKE8FvdC0yN1A7fjKLrDprtRfQaeOWyk2nPZPpm4+hnrquIZPy8o20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MbaoMmFb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKo3oZsB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J+p3yCEF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aNhCyHee; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MbaoMmFb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKo3oZsB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+p3yCEF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aNhCyHee"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B27D021E97;
	Mon,  5 Oct 2026 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=MbaoMmFblnvJBpKVpeG7sJdUwRKrXZtRCrxb3nog7dUkCQNIISOR64hvkTxneSBsGvge4t
	DzP2f/pGUbo7f3V9EyAJuDKzIGkkQxZxLtj9NqJXXYIiae0ZSRReTpvnCHOIM3TE08EkGy
	cALhEFkp3QpSOC0+cwMuFicHIdrRe7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=HKo3oZsBhrATi1uT2Qn9+YItEBqIvAr6X3xUZmaM4DERvCexR9aWp2RsrGIE5QLpil+Lsl
	ZE4JSxwb/vybG6Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=J+p3yCEFZxkl0h6Z9N/c7QoyfEzQ6fLS2D3ETtPVeQy1FBOkI5oSPG6yJkZiCtWDec+n+t
	Bjv1OuVTAe4NmE3bcFv8opWaPYfl/HfoAAEotp6cdyGjX4cv2MyQjZxwYnItzu+ly6f5Aw
	KEhcfmaTLkwlW3ECbyEpZTg65AaYb/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=aNhCyHeehgEMd0fOKlllPh2JfoADQaXhY2TGzVzUoUM+YyLSroSde9Uel+ebT9rFECdDOo
	QfRUaUYTiXhni3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4380313AF1;
	Mon,  5 Oct 2026 13:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiqWKDanw2rDdQAAD6G6ig:T5
	(envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 13:33:44 +0000
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
Subject: [PATCH v4 4/5] lib/fonts: Add font_glyph_cursor() helper
Date: Mon,  5 Oct 2026 15:31:02 +0200
Message-ID: <20261005133335.344302-5-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,gmx.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
As with the font_glyph_rotate_*() helpers, the caller has to provide the
output memory.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 include/linux/font.h    |  4 +++
 lib/fonts/Makefile      |  3 ++-
 lib/fonts/font_cursor.c | 56 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 lib/fonts/font_cursor.c

diff --git a/include/linux/font.h b/include/linux/font.h
index 5e1cf9830084..be1a26ff8ae9 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -109,6 +109,10 @@ const unsigned char *font_data_glyph_buf(font_data_t *fd,
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
 
+/* font_cursor.c */
+void font_glyph_cursor(unsigned int width, unsigned int height,
+		       unsigned int from, unsigned int to, unsigned char *out);
+
 /* font_rotate.c */
 void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsigned int height,
 			  unsigned char *out);
diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index 7202a70a56ef..bc08bf8ea3f8 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Font handling
 
-font-y := fonts.o
+font-y := fonts.o \
+	  font_cursor.o
 font-$(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION) += font_rotate.o
 
 # Built-in fonts; sorted by Family-Size in ascending order
diff --git a/lib/fonts/font_cursor.c b/lib/fonts/font_cursor.c
new file mode 100644
index 000000000000..7f4d587669aa
--- /dev/null
+++ b/lib/fonts/font_cursor.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/string.h>
+
+#include "font.h"
+
+/**
+ * font_glyph_cursor - Create a cursor glyph
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @start: The first scanline of the cursor block
+ * @end: The first scanline after the cursor block
+ * @out: The cursor-glyph bitmap
+ *
+ * The parameters @width and @height refer to the glyph size. The caller
+ * has to provide the output buffer @out of sufficient size to hold the
+ * cursor glyph. The arguments in @start and @end describe the number of
+ * scanlines occupied by the cursor block; counting from the top of the
+ * glyph. The helper fills these scanlines with a pattern and clears the
+ * remaining scanlines.
+ */
+void font_glyph_cursor(unsigned int width, unsigned int height,
+		       unsigned int start, unsigned int end, unsigned char *out)
+{
+	unsigned int pitch = font_glyph_pitch(width);
+	const unsigned char *out_end = out + height * pitch;
+	unsigned int size;
+
+	if (WARN_ON_ONCE(start > height))
+		start = height;
+	if (WARN_ON_ONCE(end > height))
+		end = height;
+
+	if (end < start)
+		end = start;
+
+	/* clear scanlines before cursor block */
+	size = start * pitch;
+	memset(out, 0x00, size);
+	out += size;
+
+	/* set cursor block */
+	size = (end - start) * pitch;
+	memset(out, 0xff, size);
+	out += size;
+
+	/* clear scanlines below cursor block */
+	size = (height - end) * pitch;
+	memset(out, 0x00, size);
+	out += size;
+
+	WARN_ON_ONCE(out != out_end);
+}
+EXPORT_SYMBOL_GPL(font_glyph_cursor);
-- 
2.55.0

