Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B638D01B;
	Fri, 11 Sep 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119932; cv=none; b=UCfG3fmYsfzEGsyF9d/BmifGl4cI5JOZvTFVGKxzDdxZLmuMwTb3P4mecV8kdQuxBZ9DjyrBQvAvB909yzxBi30vfb7Ng/vrPOA8oJ2TZ6NPHMr1l1j02oCqT1zPYPfORUSLtK+cdNKfLs9MzRJH61BKroTGPo5IUiR8MaVSmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119932; c=relaxed/simple;
	bh=4YkqMAKNK5V62YcY3AB9bibeBwrPu9ylYgq1rBqDGCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovRb9RX+NlsKhhfQBRwqXAvccTcXsXYvl/BUfiwhCzaXNQrmRc0+p99eUDdsXvy44vmPwUgmFtAQ2NHdxCNFmJ5ZHITJtuygYAjcVmqovnK7jHHucK3bhKVkvQYd/zx13GbAWNxXu6OotEyokr/VLc994Ni7Niqf7Tda40bERrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/A+Lw5u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09n1WuRv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/A+Lw5u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09n1WuRv"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE2191FF22;
	Fri, 11 Sep 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4PHXPBpIJvXQSo3h4iaInbMFWtFG1t8JHS7+nZkGzM=;
	b=V/A+Lw5uRCKJJJLsm0gdC3aU9JGD0kFc3whd0D0hqjY10MEgS8075KEt41VvSzIdW+xU4I
	hdlOrJrigqWBnivy6CdGdeJpva6A0HLh29cS1V7Ib9GOSSH1rTbjxiVvVKfhn1NeZWTOUI
	8hA+Yod3aXZIJ8RujrUhLYtt3SyxEQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4PHXPBpIJvXQSo3h4iaInbMFWtFG1t8JHS7+nZkGzM=;
	b=09n1WuRv28LuvnqoW9lSIqZsWh53IqaC/3tlp2slcQ38JN7nYap8w9mwr/c7VtGuArQJQH
	ipLvAmcY89d3qBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43555137CA;
	Fri, 11 Sep 2026 09:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAoED7TNo2oFVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 09:45:24 +0000
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
Subject: [PATCH 4/5] lib/fonts: Add font_glyph_cursor() helper
Date: Fri, 11 Sep 2026 11:25:22 +0200
Message-ID: <20260911094518.78093-5-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: CE2191FF22
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
As with the font_glyph_rotate_*() helpers, the caller has to provide the
output memory.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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

