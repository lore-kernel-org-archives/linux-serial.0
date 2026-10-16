Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A42474267;
	Fri, 16 Oct 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143247; cv=none; b=c03musRb9CAugRtrJgxmb3cWBccMgvmNevYpXUyqfkbp72V7ZHi6VJuw9DfrTzJLVBbpvKYyt9DNfG39WKZGql4XaiglyFoYcYVXbnBE05s0SmXrI3kc4FuYmeAwg0L4PZ18f8bVTnMyxMI+libnAwIW8ew72+XXzqdlgs2qTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143247; c=relaxed/simple;
	bh=FaWgWoU9Un82PF9FqUteJYdzGCF+h4X8Bo/PdFW3FvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UunI1c7gJf2tP398RB6zG04PtrGwJ+kOwXyC+ehh5fUNPAcGXmKp6W7h3m09SbYJMQCXlhbYmGPq4GO1ixCs/G1arkhV8Bkiogi1IO448JvWMQErcsvzfKE3ixEumQgumy6GwrblYVT6H1Rgnp3OzeYuaGCzKEazJ3hp4U5V4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6glRfbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/91ZHD94; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6glRfbo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/91ZHD94; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6glRfbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/91ZHD94";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6glRfbo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/91ZHD94"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C6D121C3B;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n092qEIt5lu1n1zdbRRlUEJXpJh5+ndryNlt1jTyVQs=;
	b=L6glRfboaFGzzc1BRaBIljQYPEaNKqhubWyrG4kr0k3BJ4JjK6ZKAaH+XAbFFl9fPULhvZ
	F30nxznoeQI1xLXnXRpdU73t3szarNYrYOtTgCDHCcNJMT36zP+CiC8kFv336z9Ay6Ldan
	RgYaZHG7y9nK0xI1Rc4vs4gn1mYKUqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n092qEIt5lu1n1zdbRRlUEJXpJh5+ndryNlt1jTyVQs=;
	b=/91ZHD94ml6QBk+z9ejZpGYjgq4EKkv6jcjfeY5BdHFuo0yDfrNRcKzctxs7f/FSMHI4gv
	BlDxkzYyBQJgCdBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L6glRfbo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/91ZHD94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n092qEIt5lu1n1zdbRRlUEJXpJh5+ndryNlt1jTyVQs=;
	b=L6glRfboaFGzzc1BRaBIljQYPEaNKqhubWyrG4kr0k3BJ4JjK6ZKAaH+XAbFFl9fPULhvZ
	F30nxznoeQI1xLXnXRpdU73t3szarNYrYOtTgCDHCcNJMT36zP+CiC8kFv336z9Ay6Ldan
	RgYaZHG7y9nK0xI1Rc4vs4gn1mYKUqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n092qEIt5lu1n1zdbRRlUEJXpJh5+ndryNlt1jTyVQs=;
	b=/91ZHD94ml6QBk+z9ejZpGYjgq4EKkv6jcjfeY5BdHFuo0yDfrNRcKzctxs7f/FSMHI4gv
	BlDxkzYyBQJgCdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E459A1378C;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T6
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	deller@gmx.de,
	James.Bottomley@HansenPartnership.com,
	simona@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 5/7] sticon: Implement struct consw.con_unblank
Date: Fri, 16 Oct 2026 11:11:55 +0200
Message-ID: <20261016093357.33294-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016093357.33294-1-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4C6D121C3B
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Implement con_unblank from struct consw. The new function is called
sticon_unblank(). Remove the related code from sticon_blank().

Sticon uses the global state vga_is_gfx in several places to test if
the console runs in text or graphics mode. Track the mode switches in
sticon_blank() and sticon_unblank(). As sticon_unblank() does not have
a mode_switch parameter, derive the value from vga_is_gfx and vc_mode.

There is no display unblanking in sticon: only return true to redraw
the console.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/sticon.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 6f58e6a9e76a..0d882ea6b37f 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -302,17 +302,22 @@ static bool sticon_switch(struct vc_data *conp)
 static bool sticon_blank(struct vc_data *c, enum vesa_blank_mode blank,
 			 bool mode_switch)
 {
-    if (blank == VESA_NO_BLANKING) {
+	sti_clear(sticon_sti, 0, 0, c->vc_rows, c->vc_cols, BLANK, font_data[c->vc_num]);
+
 	if (mode_switch)
-	    vga_is_gfx = 0;
+		vga_is_gfx = 1;
+
 	return true;
-    }
-    sti_clear(sticon_sti, 0, 0, c->vc_rows, c->vc_cols, BLANK,
-	      font_data[c->vc_num]);
-    if (mode_switch)
-	vga_is_gfx = 1;
+}
 
-    return true;
+static bool sticon_unblank(struct vc_data *c)
+{
+	bool mode_switch = vga_is_gfx && c->vc_mode == KD_TEXT;
+
+	if (mode_switch)
+		vga_is_gfx = 0;
+
+	return true;
 }
 
 static u8 sticon_build_attr(struct vc_data *conp, u8 color,
@@ -356,6 +361,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_unblank		= sticon_unblank,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
-- 
2.55.0

