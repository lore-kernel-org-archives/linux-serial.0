Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7D483BE1;
	Mon,  5 Oct 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207236; cv=none; b=q4uUpwGIFXWyJ0RO/GTGkHpkRzetjeuvtU2dO5o1tZ1RjEWTvB1vMaB/dk7Dsi+OGrrmC+tyfibkFUBlyRlB0g01v8HwDMNdY0JSlUrz3DtpTYcF1UDOXt5qLr5+Wxf+Y++PBASaCUlFHrhm0J4XXmHQAnd2Rd0rrfnMd7df61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207236; c=relaxed/simple;
	bh=RmRlKKdTtDDnUUNvQ5CXC6anH7HOnVsTMlj+mdtY6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmJFtI/v0gAL/d3U5hC3MdTWxNJ3vDI8CLUkFq9P8xBwBb2mL/9MPcOHVKAp8+LzB/YjC90LGQA+4Sk8zGqFdD2cFuQThfsG6uxyUcAa1EdgC6f0drGrravTgqDksHDqKmGQ+AS8BBMdlb+haeAzl08ua0d+ju9RAgTUvc72h7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tZSGkttq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1BADZGdG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTDO7T7B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h5QHGdPY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tZSGkttq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1BADZGdG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTDO7T7B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h5QHGdPY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC1681F7A9;
	Mon,  5 Oct 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJaCj6zCur74ln50HRD7doCPLGKvwWkvys2JxPGEC8s=;
	b=tZSGkttqzmdNWqvPTqJ4N+jFI0bWZFwdBAL5fNKEkC5hfgaE2xbCwwjcTvKZwMakYLUV9c
	Oaf8y02eyzs3gvB0fYw1sKq7k0HhAeoXSgy2J2X9GbmwEhuMXszAIr8da3yDEYZA/Z5NTe
	bF8+aUZI34VotUEcF+p8mMgTinMa9zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJaCj6zCur74ln50HRD7doCPLGKvwWkvys2JxPGEC8s=;
	b=1BADZGdGiBYZPFeH5hDpwWXBGZ5Pl4et5Hql/VnM17zD82l1lf8h4DkHTgpuK+Oeyz52CH
	Q5eGDWLHW7BjUOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJaCj6zCur74ln50HRD7doCPLGKvwWkvys2JxPGEC8s=;
	b=sTDO7T7BqC8q48IHwOanY7YLYdnnTS+if8Km1knuKzf9Ljev9W4FV2KhA6ARaMUVtPZUVa
	6ZWAATxCMEdvDS6fd0apUkmgsymlOgCz4L6d1tm9Z/z8q201GRBRBG0+DtDmRR3qzl+sXW
	wpNlwrbx3WqOLLwLpq70AmWLqoS8fA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJaCj6zCur74ln50HRD7doCPLGKvwWkvys2JxPGEC8s=;
	b=h5QHGdPYEosfIlhZzMKMZmSAZvorWUECrB01zhSkp3TmygaSKguQ7BioIQQlGsBbAtVsuT
	Lijl5bFJnrtCPQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5622813AEE;
	Mon,  5 Oct 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiqWKDanw2rDdQAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 13:33:43 +0000
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
Subject: [PATCH v4 1/5] vt: Add cursor-size helpers
Date: Mon,  5 Oct 2026 15:30:59 +0200
Message-ID: <20261005133335.344302-2-tzimmermann@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,gmx.de:email,imap1.dmz-prg2.suse.org:helo,pg.gda.pl:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

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

v4:
- replace goto with do-while loop (Jani)
- export size-validation helper for use in vgacon
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
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c            | 114 +++++++++++++++++++++++++++++++++
 include/linux/console_struct.h |   8 +++
 2 files changed, 122 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57edf37495a8..9f2a684029ac 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -71,6 +71,7 @@
  * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/sched/signal.h>
@@ -264,6 +265,119 @@ unsigned int vc_font_size(const struct vc_font *font)
 }
 EXPORT_SYMBOL_GPL(vc_font_size);
 
+/*
+ * Cursors
+ */
+
+/**
+ * vc_cursor_valid_size - Computes a valid cursor size from the given value
+ * @cursor_size: The size constant of cursor pattern
+ *
+ * The argument given in @cursor_size is one of the CUR_ constants, as stored
+ * in struct @vc_data.vc_cursor_type. For unknown values, the helper draws the
+ * default cursor or an underline dash.
+ *
+ * Returns:
+ * A valid cursor size for the given size value
+ */
+unsigned int vc_cursor_valid_size(unsigned int cursor_size)
+{
+	const unsigned int cursor_default_size = CUR_SIZE(READ_ONCE(cur_default));
+
+	do {
+		switch (cursor_size) {
+		case CUR_NONE:
+		case CUR_UNDERLINE:
+		case CUR_LOWER_THIRD:
+		case CUR_LOWER_HALF:
+		case CUR_TWO_THIRDS:
+		case CUR_BLOCK:
+			return cursor_size;
+		default:
+			pr_warn_once("Unknown cursor %u\n", cursor_size);
+			fallthrough;
+		case CUR_DEF:
+			/*
+			 * Use user-given default size, or underline if
+			 * the given default is invalid.
+			 */
+			if (cursor_size != cursor_default_size)
+				cursor_size = cursor_default_size;
+			else
+				cursor_size = CUR_UNDERLINE;
+		}
+	} while (true);
+}
+EXPORT_SYMBOL_GPL(vc_cursor_valid_size);
+
+/**
+ * vc_cursor_start - Calculates the cursor's first scanline within a character cell
+ * @cell_height: The overall height of the character cell
+ * @cursor_size: The size constant of cursor pattern
+ *
+ * The parameter @cell_height is the height of the character cell as
+ * displayed by the console. The argument given in @cursor_size is one
+ * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * valid cursor-size constant.
+ *
+ * Returns:
+ * The index of the cursor's first scanline within the character cell
+ */
+unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size)
+{
+	switch (cursor_size) {
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
+ * of the CUR_ constants. See vc_cursor_valid_size() for how to get a
+ * valid cursor-size constant.
+ *
+ * Returns:
+ * The index of the first scanline after the cursor within the character cell
+ */
+unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size)
+{
+	switch (cursor_size) {
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
index fe915afdece5..de9e91429a88 100644
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
@@ -222,6 +226,10 @@ extern void vc_SAK(struct work_struct *work);
 #define CUR_CHANGE(c)		 ((c) & 0x00ff00)
 #define CUR_SET(c)		(((c) & 0xff0000) >> 8)
 
+unsigned int vc_cursor_valid_size(unsigned int cursor_size);
+unsigned int vc_cursor_start(unsigned int cell_height, unsigned int cursor_size);
+unsigned int vc_cursor_end(unsigned int cell_height, unsigned int cursor_size);
+
 bool con_is_visible(const struct vc_data *vc);
 
 #endif /* _LINUX_CONSOLE_STRUCT_H */
-- 
2.55.0

