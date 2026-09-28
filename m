Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACD3CFF49;
	Mon, 28 Sep 2026 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585860; cv=none; b=UPSzQjUUnTgS87WU88KtnTQ3MNctZye/VDX4wRluj6xmB2ephm58s+skZUCfe6Uu5/H7fDMnIW0aY0CcsuE2x4A8meUHafCspce2I/lXn8CNE7lWVrnjYrK9adxuxvRPo27WR8pJvPzasoZgLwTQcGyWj/QJ4tgE7Idc4zTq/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585860; c=relaxed/simple;
	bh=EuBxRRAclVZ1OEpdYzHPMZPUWpMt3AhLv9o6zQHW3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb07KzH9w3PoGo6HGcZY4191/fmNxmnDqYp2Q2c6BbF38tr+G5GdrU3q1BI3rczv6EBG7r/VRqGp83f0VyOx1TI4UNPcws0c1yaaLkGyiobjGmwIIYGHPxHq1DhXYWumU10+QRZIN+vP34VD/ZlnX7/yAsCjHzabWctY1SRs2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rYuF5r+c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/OJIhvuW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wx5/O2Z4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uM3+8UHz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rYuF5r+c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OJIhvuW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wx5/O2Z4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uM3+8UHz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E732A21E32;
	Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=rYuF5r+cfGEXQ2Gz5djmi8Q/BHJfybVgcYyr/PRXbhzf83BFTwZLy4VVFsoAfyVEbchjfQ
	1WTpmyo3fuvirRGkvmFwGqiHx7J41sBUjMCZpCaNyLVDBCF2Ubj7o7NOZd8gbAceEfZ7F9
	J3C1SxzUATTEK6QgcSkjx1W07lbsiho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=/OJIhvuWf7yud9Ev2AFf4h0bI6fNAiOdxt4DpqAV+2hZM2/4S1/xliDYk6SJav4jiaurz4
	l+7ZbhjBR8eOrOCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wx5/O2Z4";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uM3+8UHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790585848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=wx5/O2Z4Vf6/VBKypkvCgay6HsboP9kIdhKGbxkHR3zmL2xSSOy7/7WURD3K1aH2J0aqK6
	x48Hedvuw3XnFwse0Lx9ph1n/PlaLt1kURJuIxqNZzEditxXC0CQLFY657ng9NF2dfnqLR
	hQB1mBv4bgLDpjvwqD17P6gjUdSYl+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790585848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=uM3+8UHz/EA78xaUvg04AScjr7IidTIPROAS6D6kjasFukd6KmMn4chUOuMwGBwichc35X
	kuxabtGiS+InuSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860BE13418;
	Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kr86I/crumo3HwAAD6G6ig:T3
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
Subject: [PATCH v3 2/5] vgacon: Remove trailing whitespaces
Date: Mon, 28 Sep 2026 10:55:25 +0200
Message-ID: <20260928085724.41660-3-tzimmermann@suse.de>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E732A21E32
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,gmx.de:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -3.01

Fix coding style.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
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

