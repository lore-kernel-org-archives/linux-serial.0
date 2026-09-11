Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5C3A7595;
	Fri, 11 Sep 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119936; cv=none; b=tpnCHLF9Omyi5esFqY6bAREj6hBe4OUoUL1TNEqQK87TG2raSeLUPHAJjM59nYwOqU/8JWraXZlOO0t4gzPSkhgFwRvrHK/FzHmGTytQpmFnRPvXvy4/hgxWDhiWup2LBBi9VG1/kB33G0OIBftLuHcZ5lIwO8t3hCbf3vQVPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119936; c=relaxed/simple;
	bh=//4hGNEzoNa0b5RtguD+rpvoGtJU1tXGtcgqnYs4vgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPMyrAM79fx5yMtXo5e4SkjU7gW9XSgt8cKjRV6A2ZIDcnpRH6F+mv/lOHHfhno33dZVa96/z1p7JTEKPwh6VJqH9U/KuWwF54tsjAzPrMLYAj+6/NinrIca9pZM+n7JgcVXgpSRaS10RBmv+PTFp7wIteaVRuAMV/HV+ZFk3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=StqQb9T1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iQVWe45S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BABrW6+5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YrMAQXKx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="StqQb9T1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iQVWe45S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BABrW6+5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YrMAQXKx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A7C41FF15;
	Fri, 11 Sep 2026 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdjEg2eWlhMJZoAURIJBvulfou7UVuG4+e0IIq6Xjlc=;
	b=StqQb9T1IwlEOoueKWPA1hkzCYSMu70iNfKMHN4gHoedZsTpUQl6Ccr+cWjjR8y1nCu/S2
	2tRwScTDV2Euf0bJG2k+s6XhIvp1pUT3gSXW8ggIpdb//T2kUy7X1dmA+NJb+QO1A7zjV9
	/pP7VY2h+acMtlvQML8WX9bQfHrUreU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdjEg2eWlhMJZoAURIJBvulfou7UVuG4+e0IIq6Xjlc=;
	b=iQVWe45SDQqx890pSX6EdgupQlcOsddEg3SzXp0yuo6ut+mWIrc2FPGFWlnHLXD+fCPGf0
	q7mcbVe4pipT4zAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdjEg2eWlhMJZoAURIJBvulfou7UVuG4+e0IIq6Xjlc=;
	b=BABrW6+5fCaJj3F+8eyQeUkkRIsX6A8OxLzw9AhOxQ4aiMWCrMPpYRMZVFVFEnq956GKux
	fLxorFwAiQFp5uKMohIR7qiGgZyy3T7ewK2BwS5zkUp0pHlb+ypMeEKGljo9MebCv9JxaE
	hRj9an6YGn+z1uXJi5Kfsw8pst1mtek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdjEg2eWlhMJZoAURIJBvulfou7UVuG4+e0IIq6Xjlc=;
	b=YrMAQXKxrZyYF9Utwio61GJd6jsNNVQFNXztEEVn7I5mruqSs38uyRsCkjQssbG9GeeBZG
	iG4iXQus9mKf7yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEE3E13770;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YJ15KbPNo2oFVgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Sep 2026 09:45:23 +0000
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
Subject: [PATCH 2/5] vgacon: Remove trailing whitespaces
Date: Fri, 11 Sep 2026 11:25:20 +0200
Message-ID: <20260911094518.78093-3-tzimmermann@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Fix coding style.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/vgacon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 37bd18730fe0..536e7fe4d142 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -881,14 +881,14 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 	/* First, the Sequencer */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
 	/* CPU writes only to map 2 */
-	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);	
+	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);
 	/* Sequential addressing */
-	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);	
+	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);
 	/* Clear synchronous reset */
 	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
 
 	/* Now, the graphics controller, select map 2 */
-	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x02);		
+	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x02);
 	/* disable odd-even addressing */
 	vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x00);
 	/* map start at A000:0000 */
@@ -930,7 +930,7 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 
 	raw_spin_lock_irq(&vga_lock);
 	/* First, the sequencer, Synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);	
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);
 	/* CPU writes to maps 0 and 1 */
 	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x03);
 	/* odd-even addressing */
@@ -959,7 +959,7 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 		/* Wilton (1987) mentions the following; I don't know what
 		   it means, but it works, and it appears necessary */
 		inb_p(video_port_status);
-		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
+		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);
 		clear_attribs = true;
 	}
 	raw_spin_unlock_irq(&vga_lock);
-- 
2.55.0

