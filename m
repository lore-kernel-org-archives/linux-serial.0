Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF746C4AD;
	Mon, 28 Sep 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585861; cv=none; b=mMJ68HqVyvU4Nt34b8uXJRi82k84m7ZHlq12Mt8MedKJvQWpTAORWixdy14OFQjTJ+7ONz29UWRAWoJP5F4qnEwGIyrINngT7gyhc+rFyizpO9u9xooQfYz5lZVTNDgKsueOZkb5e/TZGHzqGi8IJay8Gzxk3AK2sJMzcqkYHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585861; c=relaxed/simple;
	bh=fW5WQRnGUu5NNryVooiTdlNVXAc8inzeidnxQnNJ2f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2Vq2HsJAd8e4hgtg9RKBQ0SUEbCqdRIWEjyePmqSst2cjg7s68Qwa0+arNaa6TTbgLW0+3ZKrun0Syrde/GH5KbsZMeEuYCOHApVD3DHUSiZfvLXAZY/CP6XjkpvYcB0BGLz33WBlSv3vgp3C8KlHGJAYA+pZ+GtMbrZMXxhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tnwlpq2m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yIFw6wYs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hhfZPS5u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oQ1/IqzU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tnwlpq2m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yIFw6wYs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hhfZPS5u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oQ1/IqzU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84A23201CD;
	Mon, 28 Sep 2026 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=tnwlpq2mNG3vKumCGRhXR/p6NmJc6Bqr69qAlC4ZPKoBeCZCVRNhSsIKEwV04yd8Z8tLxl
	WNqvT3Ssn4kIbYxya4zmozf1HJBRoUpyZns34qHPF+DLllktPtursTBQwusPLZJl3P3RnI
	OH+QiOaXrK/ShvZeGNWE7PwBzgF0MBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=yIFw6wYsi1Km+4hQ0d7cBdYRFOeFOz3MmWc6xxHMDo7otPESpopxrI1tOjPWm1G7VPMtTe
	memZVEE87t4fRLDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hhfZPS5u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="oQ1/IqzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=hhfZPS5uyIcCdv2zfavF1ezcw4bDjASNzQToOe6M12JRy5n30ssp0OKx7gZXa16MFnLwxa
	dUYUGjRCgt91Lv9fNzIkvmEICIOfxiOLlQORIIN3etpXfiyUSQZNUe5t23u0zeWXubCYyi
	hun0BcTN72b4HMmI1zoG7ASsqZColcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIXnK9BJ5o0Bs3piDf5cl5Uw0ez1OiaSndJYSF7vOE=;
	b=oQ1/IqzUp3b+NdqjlRxPgguAo/C6Sh/BUG69DpupaiNqk5fNbFj+/uHMhBnb2w+kw0LMYO
	hvmLxziQlfkxeCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23CF31342D;
	Mon, 28 Sep 2026 08:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kr86I/crumo3HwAAD6G6ig:T5
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 08:57:29 +0000
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
Subject: [PATCH v3 4/5] lib/fonts: Add font_glyph_cursor() helper
Date: Mon, 28 Sep 2026 10:55:27 +0200
Message-ID: <20260928085724.41660-5-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 84A23201CD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,gmx.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

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

