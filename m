Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F936F901;
	Mon, 28 Sep 2026 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585860; cv=none; b=E6u9Hn7UQlS5CzqMSJj/7V0DO+WiWR9kXjMf/rlAVVCn7HHHllowwwsYL3ie1BIqlt2bRdMdk60e1RnuX0bKGaFHu0dDpq1s2NEwBc8XIyeX7y5MhtB0FBUUAPHVPVgFs2YnXwHuvCYYCvD3A9S3azQhRW76zyCGczfkAI49OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585860; c=relaxed/simple;
	bh=lt+SBh254sJVd+UzdNsOal/Johte3FRUuA5Ynmp9foA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAddMH11oDfvY8engCa6zMAfnbWAKBzteN30j89nin0de+KCrE+iPAj0ikd/3qK48UD2cQUr16uUZVtzh1DtC/yV+sD32h3omyq3tC2GPhGWVql2yxvtqTvCUNeMXKZ2WnuWJf85ZMaUqsK6yRcC9HcR8XAb4bnjhcEKS3o1nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=spTWnqdv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GMzJCZst; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=scaEI+eB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LDOmMdSR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="spTWnqdv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GMzJCZst";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="scaEI+eB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LDOmMdSR"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E51621CFE;
	Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQjdBXgr3jXvCYcDmEchhgnZoUbkexHUu6Lf65gwds=;
	b=spTWnqdvdAGLzNrOc2SJCmyaoy8TdhlWh5R18wP+w9rufkeZP/VQDh6ngMHJBJD2GCwv30
	URSy9vRRDScEYqVGVllIqmZBKB+fnWafUFtsBBZGvKLz8oBfgn9cqPIHSA9GU4cydxvNs+
	OcvYlny9Xlp4rcs9qudasu+k/QjVV4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQjdBXgr3jXvCYcDmEchhgnZoUbkexHUu6Lf65gwds=;
	b=GMzJCZstROkI0wGwSYFeuQf+0AEkt5Zsf6GLofwzD3YVhwLvVQx0aCx2zQ2VQHwTmhNexB
	k/eoHKYQ7KF9uFCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQjdBXgr3jXvCYcDmEchhgnZoUbkexHUu6Lf65gwds=;
	b=scaEI+eBEP47KwpI/IDr6UYscXoYl7+HJkCLc8ED37eqOwtdXHq42wJeKhx3JOMsnIsJ2P
	pGlW3gsJqYbSIcpWEuzUDOXtEGRC22SbGU0CypGucytcQI/2waYL6HSX0WA8X9MeSEmfmB
	ocEOXl6o+93YDX+XSQ+dlSO1A9ugARM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYQjdBXgr3jXvCYcDmEchhgnZoUbkexHUu6Lf65gwds=;
	b=LDOmMdSRmRUNFwvEokM8u0fDvosNApFI6VGEfKvOFSOpuh0WYcvVHvY9PftaGRtzUx7UbS
	Sb+ZfGRdak3vTzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5F3133F3;
	Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kr86I/crumo3HwAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 08:57:28 +0000
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
Subject: [PATCH v3 1/5] vt: Add cursor-size helpers
Date: Mon, 28 Sep 2026 10:55:24 +0200
Message-ID: <20260928085724.41660-2-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pg.gda.pl:email,gmx.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Cursors in the VT subsystem are blocks within a character cell that are
filled with the foreground color. The new helpers vc_cursor_start() and
vc_cursor_end() return the scanlines in which the cursor block starts rsp.
ends. This is compatible with VGA hardware.

In terms of cursor design, the new cursor-size helpers follow established
styles in fbcon. The only exception is in underline cursors for fonts with
a size larger than 10. The underlining dash is now one pixel closer to
the font-glyph data, so that the cursor looks less detached. This follows
the style used by vgacon.

Users control the cursor size with the vt module's parameter cur_default
or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
case of an invalid setting, the new helpers fall back to cur_default and
then underline cursors; in this order.

Similar code in vgacon and fbcon ignores the cursor's default size stored
in vt.cur_default. The consoles default to full-block cursors, while vt
defaults to underline cursors. VGA BIOSes also tend to use underline by.
default. Upon initialization vt applies its default to the console, but
each console might fall back to it own default. For example, running the
ESC code from above with the invalid constant of 8 magically flips the
cursor from underline to block size on vgacon. Another call with N set
to 0 (i.e., default) magically flips it back to underlyine. Making
underline the new default everywhere harmonizes vt, fbcon and most VGA
BIOSes.

v3:
- mention user interfaces to control cursor size in commit message (GregKH)
- elaborate defaults (GregKH)
- move retry logic into helper
- handle CUR_DEF
v2:
- export non-font interface for vgacon
- avoid interference from concurrent user space (Sashiko)
- fix function docs (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 drivers/tty/vt/vt.c            | 104 +++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |   7 +++
 2 files changed, 111 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..8141296ccad0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -71,6 +71,7 @@
  * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
@@ -264,6 +265,109 @@ unsigned int vc_font_size(const struct vc_font *font)
 }
 EXPORT_SYMBOL_GPL(vc_font_size);
 
+/*
+ * Cursors
+ */
+
+static unsigned int vc_cursor_size(unsigned int cursor_size)
+{
+	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
+
+retry:
+	switch (cursor_size) {
+	case CUR_NONE:
+	case CUR_UNDERLINE:
+	case CUR_LOWER_THIRD:
+	case CUR_LOWER_HALF:
+	case CUR_TWO_THIRDS:
+	case CUR_BLOCK:
+		return cursor_size;
+	default:
+		pr_warn_once("Unknown cursor %u\n", cursor_size);
+		fallthrough;
+	case CUR_DEF:
+		/*
+		 * Use user-given default size, or underline if
+		 * the given default is invalid.
+		 */
+		if (cursor_size != cursor_default_size)
+			cursor_size = cursor_default_size;
+		else
+			cursor_size = CUR_UNDERLINE;
+		goto retry;
+	}
+}
+
+/**
+ * vc_cursor_start - Calculates the cursor's first scanline within a character cell
+ * @cell_height: The overall height of the character cell
+ * @cursor_size: The size constant of cursor pattern
+ *
+ * The parameter @cell_height is the height of the character cell as
+ * displayed by the console. The argument given in @cursor_size is one
+ * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
+ * For unknown values, the helper draws the default cursor or an underline
+ * dash.
+ *
+ * Returns:
+ * The index of the cursor's first scanline within the character cell
+ */
+unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
+{
+	switch (vc_cursor_size(cursor_size)) {
+	case CUR_NONE:
+		return cell_height;
+	case CUR_UNDERLINE:
+	default:
+		if (cell_height < 10)
+			return cell_height - 1;
+		else
+			return cell_height - 3;
+	case CUR_LOWER_THIRD:
+		return cell_height - cell_height / 3;
+	case CUR_LOWER_HALF:
+		return cell_height - cell_height / 2;
+	case CUR_TWO_THIRDS:
+		return cell_height - (cell_height * 2) / 3;
+	case CUR_BLOCK:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(vc_cursor_start);
+
+/**
+ * vc_cursor_end - Calculates the first scanline after the cursor within a character cell
+ * @cell_height: The overall height of the character cell
+ * @cursor_size: The size constant of cursor pattern
+ *
+ * The parameter @cell_height is the height of the character cell as
+ * displayed by the console. The argument given in @cursor_size is one
+ * of the CUR_ constants, as stored in struct @vc_data.vc_cursor_type.
+ * For unknown values, the helper draws the default cursor or an underline
+ * dash.
+ *
+ * Returns:
+ * The index of the first scanline after the cursor within the character cell
+ */
+unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size)
+{
+	switch (vc_cursor_size(cursor_size)) {
+	case CUR_UNDERLINE:
+	default:
+		if (cell_height < 10)
+			return cell_height;
+		else
+			return cell_height - 1;
+	case CUR_NONE:
+	case CUR_LOWER_THIRD:
+	case CUR_LOWER_HALF:
+	case CUR_TWO_THIRDS:
+	case CUR_BLOCK:
+		return cell_height;
+	}
+}
+EXPORT_SYMBOL_GPL(vc_cursor_end);
+
 /*
  * /sys/class/tty/tty0/
  *
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..1d37c7898ea0 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -204,6 +204,10 @@ struct vc {
 extern struct vc vc_cons [MAX_NR_CONSOLES];
 extern void vc_SAK(struct work_struct *work);
 
+/*
+ * Cursors
+ */
+
 #define CUR_MAKE(size, change, set)	((size) | ((change) << 8) |	\
 		((set) << 16))
 #define CUR_SIZE(c)		 ((c) & 0x00000f)
@@ -222,6 +226,9 @@ extern void vc_SAK(struct work_struct *work);
 #define CUR_CHANGE(c)		 ((c) & 0x00ff00)
 #define CUR_SET(c)		(((c) & 0xff0000) >> 8)
 
+unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size);
+unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size);
+
 bool con_is_visible(const struct vc_data *vc);
 
 #endif /* _LINUX_CONSOLE_STRUCT_H */
-- 
2.55.0

