Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2247986C;
	Fri, 16 Oct 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143247; cv=none; b=G0A+eOTprsyxp+5dSJFtD12VV/jseZDzFIszH7e4DykrR1aUrfLusngvhKuaGAsjAZ6aT8DjWjP5proElI4mXjxBN9587wIRua9Nq/3MOeeqNt60rKL2gxas3w8AejW8dI1eCjL/4S7wwKfV5k39ehJqyWqRZUwsFkGtRXMRfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143247; c=relaxed/simple;
	bh=bOyGjoPIbOks8WYHHpwb2f13LO8DKaget4Trz3CLi30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnHsE2YvBFqjimDlTCJJZ0Bj2FiRH+jrTTDOTcB1woXN1A6q87v0sRm4Fdo/37TLzJ+ZMrqPShCk1KS6bRNkqdtglvCdgXhuXK7sKG2hH7UMWSPNPJzomFZHyfuHTYUBLc7LhPLplitNDnzrTDJAKQD/Fqy9xOTO2/HiYwbiNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E1n8e1m5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iy96SymE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E1n8e1m5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iy96SymE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E1n8e1m5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iy96SymE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E1n8e1m5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iy96SymE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01CA91F444;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yQt1fYHAp2PmlQxz0r+idqd+AylK6h70zxVKhJiTq4=;
	b=E1n8e1m5v5h10LCSSsIQ1e5yRVW5Hir/f7ypcjrTM3o/ElZP1LHgNvYLyERW1DGCtGLiNZ
	ci37cqGvcU/k0ruFBvSYMAoIcJEaEe1G5Am85FU6AuVrExdNQ2w/PrmDAsmvsDWTjOLS1e
	A8Ed/MwEK8lr0erQuyzAIGUkAaSfXy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yQt1fYHAp2PmlQxz0r+idqd+AylK6h70zxVKhJiTq4=;
	b=iy96SymEN2/yxCp6mi8lIkUgombIPZRF5/aRgOJj2wh9nFbsg8O6EGPUW0bpct8sx26mnY
	u356h5WsBAOXbRCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yQt1fYHAp2PmlQxz0r+idqd+AylK6h70zxVKhJiTq4=;
	b=E1n8e1m5v5h10LCSSsIQ1e5yRVW5Hir/f7ypcjrTM3o/ElZP1LHgNvYLyERW1DGCtGLiNZ
	ci37cqGvcU/k0ruFBvSYMAoIcJEaEe1G5Am85FU6AuVrExdNQ2w/PrmDAsmvsDWTjOLS1e
	A8Ed/MwEK8lr0erQuyzAIGUkAaSfXy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0yQt1fYHAp2PmlQxz0r+idqd+AylK6h70zxVKhJiTq4=;
	b=iy96SymEN2/yxCp6mi8lIkUgombIPZRF5/aRgOJj2wh9nFbsg8O6EGPUW0bpct8sx26mnY
	u356h5WsBAOXbRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B33A139B6;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T5
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
Subject: [PATCH v2 4/7] newport_con: Implement struct consw.con_unblank
Date: Fri, 16 Oct 2026 11:11:54 +0200
Message-ID: <20261016093357.33294-5-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Implement con_unblank from struct consw with the VESA_NO_BLANKING
branch from newport_blank(). Remove that code from the blank helper.

Both helpers, newport_blank() and newport_unbank(), clear or set
a single flag in a hardware register. No further VESA DPMS blanking
is supported.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/newport_con.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index ecbbe2e4e2a6..c617a9a27e4c 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -481,17 +481,18 @@ static bool newport_blank(struct vc_data *c, enum vesa_blank_mode blank,
 {
 	unsigned short treg;
 
-	if (blank == VESA_NO_BLANKING) {
-		/* unblank console */
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg | VC2_CTRL_EDISP));
-	} else {
-		/* blank console */
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg & ~(VC2_CTRL_EDISP)));
-	}
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg & ~(VC2_CTRL_EDISP)));
+
+	return true;
+}
+
+static bool newport_unblank(struct vc_data *c)
+{
+	unsigned short treg;
+
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg | VC2_CTRL_EDISP));
 
 	return true;
 }
@@ -666,6 +667,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_unblank	  = newport_unblank,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
-- 
2.55.0

