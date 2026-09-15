Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E603C4562;
	Tue, 15 Sep 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475613; cv=none; b=lR4y4+O79wZDSVAzZDUUE6JRoMB1nz+yTmh+oYGwSltswokTi7dXknaCqSn3uurOtLPzDSQD+qW3R5NbYE5XVTzCeNEBwg6czdvnDD7sTyn1HNsn9uFTbLlGQczW58Zp53F++U6ot4SwjrZRiET0ZRgcFOj3yJvo76RvIGaHQNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475613; c=relaxed/simple;
	bh=jkKRVsVxzvZc/aXuTG0+nE3avJAc+mjEPbhFhYPHFcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBkeLAkHfbznAvVvYDTbb1QBwkH6PK52DdXH/LT//S7/JS0PsSH9k7AhLFedBw1riZEtX8voyrd2QA5302oQou0maJzLMbrxGHPY/OrgZDv4mgxiSfJhO9fLKcYcRWwYt8l78LZWF9WHUfCT7oIr/Uyjkyrzny7LcDv2IgHEZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hevYXOHI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r3wYPLul; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bc0gPQCH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CBQWObV3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hevYXOHI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r3wYPLul";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bc0gPQCH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CBQWObV3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5F1B1FF4F;
	Tue, 15 Sep 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idqundGVxc+hDEeHHfaZ5fn99f5AR2I7AkBnsZ8niRg=;
	b=hevYXOHIWsnkIU8d/8nEkgZ16jtm98s4ZVKdI1o7samRYLByaGiNnmYbo3+SorDSXjZayI
	E2GkhuGDZx0JoXVhBYJ1FcPi38ZUtipWh+6iE3i205AOEaSaCRlLN27FIYKtR31VbTDSH9
	gY6BPxDjQxYSD727mAySihkM++Av2gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idqundGVxc+hDEeHHfaZ5fn99f5AR2I7AkBnsZ8niRg=;
	b=r3wYPLulwf7V86rF0VnLJpVVgxlXOKWWj7WPCWnGhsF9qviLMRUVqSFsBu3y0EqY8Z45oT
	Yh3wU7dJAPdas8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bc0gPQCH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CBQWObV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idqundGVxc+hDEeHHfaZ5fn99f5AR2I7AkBnsZ8niRg=;
	b=Bc0gPQCHXNGg8otlol0UPBYVdWE2vIvpwBk8QbHtkZYJBdUrTwGtHlqodxpAJvDBTPEp+p
	EvbcK48V60pPo3UE11cWioBdLPALNVHnQyhhwekr38Ic8aAH2LNjV9cQmR45n5COP+riAY
	xGumKnRe3rsg5Nm26Cgd2m3qaCzhBJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idqundGVxc+hDEeHHfaZ5fn99f5AR2I7AkBnsZ8niRg=;
	b=CBQWObV3CnI4klsyWL8eJEYanlf1K9fDiiYVhIWFA6zM0S/odVZD5kvcCZj0XCJKzPL3+H
	T2EitFOFj+0tKVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7785F136D1;
	Tue, 15 Sep 2026 12:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COmnAwk7qWpGNQAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Sep 2026 12:33:13 +0000
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
Subject: [PATCH v2 1/5] vt: Add cursor-size helpers
Date: Tue, 15 Sep 2026 14:29:12 +0200
Message-ID: <20260915123304.1027277-2-tzimmermann@suse.de>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E5F1B1FF4F
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gmx.de:email,pg.gda.pl:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Cursors in the VT subsystem are blocks within a character cell that are
filled with the foreground color. The new helpers vc_cursor_start() and
vc_cursor_end() return the scanlines in which the cursor block starts rsp.
ends. This is compatible with VGA hardware

In terms of cursor design, the new cursor-size helpers follow established
styles in fbcon. The only exception is in underline cursors for fonts with
a size larger than 10. The underlining dash is now one pixel closer to
the font-glyph data, so that the cursor looks less detached. This follows
the style used by vgacon.

Similar code in vgacon and fbcon ignores the cursor's default size stored
in vt.cur_default. The consoles default to full-block cursors, while vt
defaults to underline cursors. The new helper fall back to cur_default and
then underline cursors; in this order.

v2:
- export non-font interface for vgacon
- avoid interference from concurrent user space (Sashiko)
- fix function docs (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
---
 drivers/tty/vt/vt.c            | 93 ++++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |  7 +++
 2 files changed, 100 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..5d2583cd6e79 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -71,6 +71,7 @@
  * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
@@ -264,6 +265,98 @@ unsigned int vc_font_size(const struct vc_font *font)
 }
 EXPORT_SYMBOL_GPL(vc_font_size);
 
+/*
+ * Cursors
+ */
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
+	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
+
+retry:
+	switch (cursor_size) {
+	case CUR_NONE:
+		return cell_height;
+	case CUR_UNDERLINE:
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
+	default:
+		pr_warn_once("Unknown cursor %u\n", cursor_size);
+		if (cursor_size != cursor_default_size)
+			cursor_size = cursor_default_size;
+		else
+			cursor_size = CUR_UNDERLINE;
+		goto retry;
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
+	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
+
+retry:
+	switch (cursor_size) {
+	case CUR_UNDERLINE:
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
+	default:
+		pr_warn_once("Unknown cursor %u\n", cursor_size);
+		if (cursor_size != cursor_default_size)
+			cursor_size = cursor_default_size;
+		else
+			cursor_size = CUR_UNDERLINE;
+		goto retry;
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

