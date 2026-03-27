Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CE3E6DCF
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616686; cv=none; b=uB4CQXqJXS5Ypn5Fdd7hXR+yxM+9QoKL8nOVXF0ZSViiZ7AYZyUcAwtzUTs1XnMGHdb/hRpfKfH5vGFqp6/Gr/02l4ZwAJ3nFXi3UoBfdhqJyKZlQo0UqJW2XUT+B747QPutkvStpXZTf2dCLeyTN2CXe4Jod4b46Qknvk31uZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616686; c=relaxed/simple;
	bh=7SWK6+xforbO9ObuX1tAwg0BTEZ2KvUbTuIZ961ycCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwylmNAO6OMuuXB0AbJjLHT0efpjRMbWzf9sMg7Ema8WjBg+IHwJD9NM5fvxmrKpFaqRLPWul5cv0QdLBT+g9sybZeGvamQub79iLOwpXLQ9hDw5Klh+A28Uj1h/1VPIustuiHUFZThMCfjIFg7pAgfN2937QDAc+HgN9NvGBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdH5OOOS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTO/JAbr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mdH5OOOS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTO/JAbr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdH5OOOS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTO/JAbr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mdH5OOOS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTO/JAbr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DE095BE3D;
	Fri, 27 Mar 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76Lu2FhyqR0U2rrMx7Vy0WuE3C2Dk7OvXdlLMk2AL6M=;
	b=mdH5OOOSREPZ1IUJSb0PHSMI6D07zcchroWeh1RULvFETSTOy8Zctx0EPhSYK0LUgrXiKU
	aEWJ6MkUygguz6UWy88RpArUJTBHRqefM2wDG9ateaZ8rbByYX9u4IKHQiIlSRPr4S6QkE
	Kcg7aExVoZAfmXGv6+RKD+zQsVy4u4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76Lu2FhyqR0U2rrMx7Vy0WuE3C2Dk7OvXdlLMk2AL6M=;
	b=zTO/JAbrljkCciSwQQrq2EvPiiq7b8Q29FLA+coRxxeOGmGo6IWdyC0w42VvV7S3eIsoGd
	Ha9p/a5XAuJjN8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76Lu2FhyqR0U2rrMx7Vy0WuE3C2Dk7OvXdlLMk2AL6M=;
	b=mdH5OOOSREPZ1IUJSb0PHSMI6D07zcchroWeh1RULvFETSTOy8Zctx0EPhSYK0LUgrXiKU
	aEWJ6MkUygguz6UWy88RpArUJTBHRqefM2wDG9ateaZ8rbByYX9u4IKHQiIlSRPr4S6QkE
	Kcg7aExVoZAfmXGv6+RKD+zQsVy4u4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76Lu2FhyqR0U2rrMx7Vy0WuE3C2Dk7OvXdlLMk2AL6M=;
	b=zTO/JAbrljkCciSwQQrq2EvPiiq7b8Q29FLA+coRxxeOGmGo6IWdyC0w42VvV7S3eIsoGd
	Ha9p/a5XAuJjN8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E1D64A0A2;
	Fri, 27 Mar 2026 13:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Dn3DWSAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:36 +0000
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
Subject: [PATCH 02/10] vt: Implement helpers for struct vc_font in source file
Date: Fri, 27 Mar 2026 13:49:35 +0100
Message-ID: <20260327130431.59481-3-tzimmermann@suse.de>
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
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Move the helpers vc_font_pitch() and vc_font_size() from the VT
header file into source file. They are not called very often, so
there's no benefit in keeping them in the headers. Also avoids
including <liux/math.h> from the header.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c            | 35 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h | 30 ++---------------------------
 2 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e2df99e3d458..3d89d30c9596 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -71,6 +71,7 @@
  * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
@@ -230,6 +231,40 @@ enum {
 	blank_vesa_wait,
 };
 
+/*
+ * struct vc_font
+ */
+
+/**
+ * vc_font_pitch - Calculates the number of bytes between two adjacent scanlines
+ * @font: The VC font
+ *
+ * Returns:
+ * The number of bytes between two adjacent scanlines in the font data
+ */
+unsigned int vc_font_pitch(const struct vc_font *font)
+{
+	return DIV_ROUND_UP(font->width, 8);
+}
+EXPORT_SYMBOL_GPL(vc_font_pitch);
+
+/**
+ * vc_font_size - Calculates the size of the font data in bytes
+ * @font: The VC font
+ *
+ * vc_font_size() calculates the number of bytes of font data in the
+ * font specified by @font. The function calculates the size from the
+ * font parameters.
+ *
+ * Returns:
+ * The size of the font data in bytes.
+ */
+unsigned int vc_font_size(const struct vc_font *font)
+{
+	return font->height * vc_font_pitch(font) * font->charcount;
+}
+EXPORT_SYMBOL_GPL(vc_font_size);
+
 /*
  * /sys/class/tty/tty0/
  *
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 6ce498b31855..fe915afdece5 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -13,7 +13,6 @@
 #ifndef _LINUX_CONSOLE_STRUCT_H
 #define _LINUX_CONSOLE_STRUCT_H
 
-#include <linux/math.h>
 #include <linux/vt.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -83,33 +82,8 @@ struct vc_font {
 	const unsigned char *data;
 };
 
-/**
- * vc_font_pitch - Calculates the number of bytes between two adjacent scanlines
- * @font: The VC font
- *
- * Returns:
- * The number of bytes between two adjacent scanlines in the font data
- */
-static inline unsigned int vc_font_pitch(const struct vc_font *font)
-{
-	return DIV_ROUND_UP(font->width, 8);
-}
-
-/**
- * vc_font_size - Calculates the size of the font data in bytes
- * @font: The VC font
- *
- * vc_font_size() calculates the number of bytes of font data in the
- * font specified by @font. The function calculates the size from the
- * font parameters.
- *
- * Returns:
- * The size of the font data in bytes.
- */
-static inline unsigned int vc_font_size(const struct vc_font *font)
-{
-	return font->height * vc_font_pitch(font) * font->charcount;
-}
+unsigned int vc_font_pitch(const struct vc_font *font);
+unsigned int vc_font_size(const struct vc_font *font);
 
 /*
  * Example: vc_data of a console that was scrolled 3 lines down.
-- 
2.53.0

