Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761914;
	b=E7hWp3RyVEgi7kTogBDNCYE6GWxDXKDS+FTz66pd1hFKaM6Ub0BHVeapPE/AZJrQ9bH3
	 v0EGUEX7J6Ss681bUGfGdcgDzz/oiS3+g/QcGv+iP75LEt4D5GBJ2UAZ9TW2IicKYqE57
	 3tLANHr7hwQKlDHoPAwg8yEbC0KKjO7pREBczXex42yr9R6Hvp9Fsmc2FWcZQi77trJOq
	 rgslcX33OfzVwjGBBq6hgQyDEhcNkqMOmMKVZp6Obq7tA6Q8cVeEtN9iLjVnk4q2yyMHL
	 9bI4mcxSJAzeoWlskxA2Oj/6mtvCH+NTTilPjX1fBUelZsKN6/pZ0tRz4ijGsKBaf0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761914;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=IcIDlGk0MsS2m3wJnJpyvorgRoOp2iBdRw5Yw+AtQMU=;
	b=byHmQT8bMDw0heLlJMHv/QaqPa80uO5D5DrXq/W7g7i4h6jsG4fudqLV2e1u7JSx7tou
	 ybwPoTBX1m6qCMEzQFGIfTclX/t89+fmfY9JdzlaLTDIO9IAluWzDIrvAzLDdzcD3CrSf
	 I/VzH++ZjqqKAFLFknACNDgwU8LmRETneO65T6+OFEmO5txLEkNWF9fJelL00jF94REkW
	 xdODT4IaIH5b8RJOmP5PKTEBWBf/Kc6SflyRP9KRydQHTU2oWPR2+UDkYvsL6qRb6fRXy
	 iuatDS8KZkZFXL5QpXGfcRNCa1AdIvKdiEOvzdVKrWAioEcWfWk2awJAYk/KsLAfl7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cR1N76og;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SCA8i6+Z;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cR1N76og;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SCA8i6+Z;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D64606A338;
	Fri, 23 Oct 2026 13:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D64606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cR1N76og;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SCA8i6+Z;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cR1N76og;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SCA8i6+Z
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89AAC21FC7;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcIDlGk0MsS2m3wJnJpyvorgRoOp2iBdRw5Yw+AtQMU=;
	b=cR1N76ogpdWP7f2HVIYNiszECcj2df5exjPWb58bwwLm23OyIMNm+vdOGIVN8lD4gkhxQ4
	5VKNBsebuOOdgMSKSTPEe1+NW4ngmhm39ouff6WrtXV7YF4OYBLiJ/w4WUa4z7HowlwlwM
	LY8JgeMdK+vJyp8llzCniYBClTqLrzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcIDlGk0MsS2m3wJnJpyvorgRoOp2iBdRw5Yw+AtQMU=;
	b=SCA8i6+ZQXM6EhePbnWoiCgpd2FfchYIwxCwk0xbWZyQnp7VM1yrFM4od+KrZq7ZRioPp5
	LGdMtwowIt7IINBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcIDlGk0MsS2m3wJnJpyvorgRoOp2iBdRw5Yw+AtQMU=;
	b=cR1N76ogpdWP7f2HVIYNiszECcj2df5exjPWb58bwwLm23OyIMNm+vdOGIVN8lD4gkhxQ4
	5VKNBsebuOOdgMSKSTPEe1+NW4ngmhm39ouff6WrtXV7YF4OYBLiJ/w4WUa4z7HowlwlwM
	LY8JgeMdK+vJyp8llzCniYBClTqLrzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcIDlGk0MsS2m3wJnJpyvorgRoOp2iBdRw5Yw+AtQMU=;
	b=SCA8i6+ZQXM6EhePbnWoiCgpd2FfchYIwxCwk0xbWZyQnp7VM1yrFM4od+KrZq7ZRioPp5
	LGdMtwowIt7IINBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23E2E134E6;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig:T8
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:54 +0000
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
Subject: [PATCH v3 7/7] vt: Remove old-style con_blank
Date: Fri, 23 Oct 2026 15:16:17 +0200
Message-ID: <20261023132448.115747-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023132448.115747-1-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-15.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
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
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -15.80
X-Spam-Level: 
X-Spam-Flag: NO

All consoles implement the new con_blank plus con_unblank. Remove
the old semantics from con_blank. Always pass a VESA blank mode to
the blank parameter.

v3:
- keep con_blank's mode_switch parameter

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/tty/vt/vt.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 82885f357f76..7dbc0072a40a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4788,10 +4788,7 @@ void do_blank_screen(int entering_gfx)
 	if (console_blanked) {
 		if (blank_state == blank_vesa_wait) {
 			blank_state = blank_off;
-			if (vc->vc_sw->con_unblank)
-				vc->vc_sw->con_blank(vc, vesa_blank_mode, 0);
-			else
-				vc->vc_sw->con_blank(vc, vesa_blank_mode + 1, 0);
+			vc->vc_sw->con_blank(vc, vesa_blank_mode, false);
 		}
 		return;
 	}
@@ -4800,10 +4797,7 @@ void do_blank_screen(int entering_gfx)
 	if (entering_gfx) {
 		hide_cursor(vc);
 		save_screen(vc);
-		if (vc->vc_sw->con_unblank)
-			vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, 1);
-		else
-			vc->vc_sw->con_blank(vc, VESA_VSYNC_SUSPEND, 1);
+		vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, true);
 		console_blanked = fg_console + 1;
 		blank_state = blank_off;
 		set_origin(vc);
@@ -4824,12 +4818,9 @@ void do_blank_screen(int entering_gfx)
 
 	save_screen(vc);
 	/* In case we need to reset origin, blanking hook returns 1 */
-	if (vc->vc_sw->con_unblank)
-		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_NO_BLANKING :
-					 vesa_blank_mode, 0);
-	else
-		i = vc->vc_sw->con_blank(vc, vesa_off_interval ? VESA_VSYNC_SUSPEND :
-					 (vesa_blank_mode + 1), 0);
+	i = vc->vc_sw->con_blank(vc,
+				 vesa_off_interval ? VESA_NO_BLANKING : vesa_blank_mode,
+				 false);
 	console_blanked = fg_console + 1;
 	if (i)
 		set_origin(vc);
@@ -4880,15 +4871,9 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_unblank) {
-		if (vc->vc_sw->con_unblank(vc, leaving_gfx))
-			/* Low-level driver cannot restore -> do it ourselves */
-			update_screen(vc);
-	} else {
-		if (vc->vc_sw->con_blank(vc, VESA_NO_BLANKING, leaving_gfx))
-			/* Low-level driver cannot restore -> do it ourselves */
-			update_screen(vc);
-	}
+	if (vc->vc_sw->con_unblank(vc, leaving_gfx))
+		/* Low-level driver cannot restore -> do it ourselves */
+		update_screen(vc);
 	if (console_blank_hook)
 		console_blank_hook(0);
 	set_palette(vc);
-- 
2.56.0

