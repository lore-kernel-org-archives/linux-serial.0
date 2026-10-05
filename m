Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73D484888;
	Mon,  5 Oct 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207236; cv=none; b=pmIIUBZUmuFmadjDOBYavRJpbij+q6FPLI3oM8iQG3wDQ1I2sRJoz9mdm1RsbjwEER5LjOjM1PEAqQODqwCkC0pGrlGanQugoiQX1KMikUP2JBKmKqY2CShsDaU5wSmM+YwJj2O0VpNYxrkHo7LbGc3SFSUcOovV77QxadfJhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207236; c=relaxed/simple;
	bh=EuBxRRAclVZ1OEpdYzHPMZPUWpMt3AhLv9o6zQHW3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvujAB89T1L965Ui3c6gmnVkM7rcl2Dpc3ojV4DfSikObStxnJ+aMrFhnEWLt7/zeZlsfAaHeqbDtsjhoxzOnQnFQjeEkpk0ExcybDltpCtbK0Mr8ckQEg35rzEWqf7DN7AKF31ahzfnNQeGvo9bTwv+px0KWI7Ye25aEAsBX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kIpBb0ne; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QVAAfoUJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d4nR6vC0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y8OaOdQz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kIpBb0ne";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QVAAfoUJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d4nR6vC0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y8OaOdQz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11A1A21E81;
	Mon,  5 Oct 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=kIpBb0nej8lM+t53cSvdECFkSefnI9OS1dy0VCvpCtJeFs3t9CPAtHK4s6VCGaldsWYsrA
	fc3c56OlL+lPvOuq/JBWvPufvZ6jIsOJsMi10BphHdoFawqqEPKI5SUMrAa7WIkbnMyUTS
	8YbN58bNlV6weLGAUK/GWPmyJOvtwq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=QVAAfoUJJFmJ4jN3hnF1Or7m2jQK82xPXuHnLckVRyWweMWuguqAqSMkMAY7FnNA0cr/nX
	xJ36BcmWDb1WzkCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=d4nR6vC0aOC7FD+5FisrGfosAleLz/BypCnvATELHMBG9qTYelGMJCU3P2Btdth187BC+1
	C/HxQJwtOmVFa+moBUwOqmIcELqPL5XSTGqICBMHjNKXY9hWwB18w7D3KqiDfbWHvzBjAy
	4peo9zesOSQ50b6N8RXMt9k4e/YsAgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=y8OaOdQz6Ca/da6ZiAGaC6IHaC/ON3QgNMKPOvgU7MMkTGPpQ0u3AUNPCGJAt2SAnjq3fo
	EFzAbG/J1uOnzHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A29D113AEF;
	Mon,  5 Oct 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiqWKDanw2rDdQAAD6G6ig:T3
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
Subject: [PATCH v4 2/5] vgacon: Remove trailing whitespaces
Date: Mon,  5 Oct 2026 15:31:00 +0200
Message-ID: <20261005133335.344302-3-tzimmermann@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,gmx.de:email,suse.de:email,suse.de:mid];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,linux.intel.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

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

