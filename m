Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CC37475C;
	Tue, 15 Sep 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475606; cv=none; b=VpfsTl9YvFdpJaM8PFXQmmtOzK/kvElB+Isd1ZEuaVHPWPTkXO4OSL1mUZdyPBgbF9V+ufNzeCe698oeV7BFDMNBP3HsQXOT1QTCuO47pQnGBxV7+5V1Vst0ORS9RxbAJBlh8tQKbcbhZKAU7UcRD3PNUdQZy+FyeRjAh47G0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475606; c=relaxed/simple;
	bh=EuBxRRAclVZ1OEpdYzHPMZPUWpMt3AhLv9o6zQHW3Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu8kk5rmBz8Qu3zBLp1Lj4LIU5+B9lXiCqhLVVmmVDatWRZkratPE3EOPSs6zoHYP6fEJ/tZ3syg8gPhJujpJp/ClC+Bh77mEEec+Gf8dWlGXJqiuadOpl3JfiDH0mWrTALdf//SkBkguyMz08IOe8LxOmAsxT4+n/VL2+lxSHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eStp4eP7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=24RC8duD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u3InYRJ+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sW/vYs+O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eStp4eP7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="24RC8duD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u3InYRJ+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sW/vYs+O"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 527BA21BFC;
	Tue, 15 Sep 2026 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=eStp4eP7a66SU2WSNvjtgqckI8mBA6ce8lkL+pIZ/bgxOistZ4gnFgeYqxDlUkuZXoqX2P
	fpZq9e9rQWh0NB3ltAzY9ZnMJWoThxOaGDfvjPVRNZ1MWYevSrm1Flgt6rxUUzsc1rqyZs
	fI11jKSDYv/nAuC8sjz60igB4QG/THo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=24RC8duDML6dg/7vjmTZY+EeSM9BOX3NDDPW8Y0dtzwB+B4BziO0NFH8FURlTOmKazY99K
	TeAj7gG2J0nCejDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u3InYRJ+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="sW/vYs+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=u3InYRJ+ISUh44XHpT0ce8vzmdA21mSDhzdr0prlhYRIqj8keN3utHB99FfpulxteEr9Za
	7DkkUndiVsBYuBbQCajQLaWwsTqCpAKXcIGkctbLIjbjpa7GjScVMXNyi5QiIiRy44ksDG
	Olj+I8EPDv2CBWOC1jcqIcMl6YhKW6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZvn8Te9OBjxjVjRJPfmv7Es1GTVimIYfVt9MlC/7gw=;
	b=sW/vYs+Oz3UvH9S155aUrdyYVwj04Rt44xppwf83h5D2/BE8rqn5q+qPa0+jvd4IwAI0H+
	poKPSwJGoWLpM0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A3E136E6;
	Tue, 15 Sep 2026 12:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COmnAwk7qWpGNQAAD6G6ig:T3
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
Subject: [PATCH v2 2/5] vgacon: Remove trailing whitespaces
Date: Tue, 15 Sep 2026 14:29:13 +0200
Message-ID: <20260915123304.1027277-3-tzimmermann@suse.de>
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
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 527BA21BFC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,gmx.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

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

