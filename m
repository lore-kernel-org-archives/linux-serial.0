Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98608481FC8;
	Mon,  5 Oct 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207235; cv=none; b=NOwBe8UGSuDh2ZDfBYvkn6hPfNziqt/HdMydtMqACveyPyNqbSFyYTZy8nsAAFEKaSxepBYrmjbfGu/+bjgM5crflAb6KcKRKc+e3GlxSzDds7hDnO/MoCPHX84DsVJ+LQSXIi9pODK4M7HesTCIsOym9YZJ4odD3nVsfT5r37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207235; c=relaxed/simple;
	bh=xXxvTRREvfhbQ+VD11Pc4f3VlBwUrDOZVw9L4PW18SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGi5UF6WKRF63T4f6z70B96xTI6DMKuyAN5oRc++GrpbZb/I8MFiH2Az6+sgAmCNYV9D2zYl4a2RmIJBgr8hFGA2dFHWFHfxoPhZCfD3Onr/dtdlnJ/oku0WBZskF4orlrU3Jz3PGPQUNc5jsRrapyafGlhd6uh4bZ6/zshXfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7ogps4X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gVm6KZ8F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F3I+aHhs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MVnK4QIu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7ogps4X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gVm6KZ8F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F3I+aHhs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MVnK4QIu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 713E01F789;
	Mon,  5 Oct 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gNOokBpjhXFRQxScEItGBiMsBbFOJv2CVZ4EUczuiSc=;
	b=k7ogps4XwkaukfawTmnpIhq5iMBeOB+BZtiyO5ea9RjMa+0eQ6kkMyQpnY1MgttsqinMiS
	8q7RUfe5BddPpbJ8aNvnsgs1EDNCl234CKbfPMKZpssZxfl+kMMOLCsm4lx4fyGbAhP26H
	9R67jEYJq1dxlFxx27nvVK646aW+YT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gNOokBpjhXFRQxScEItGBiMsBbFOJv2CVZ4EUczuiSc=;
	b=gVm6KZ8F+TwQPYZvwiFMmrvfylWLGeBJzju2R/gzxTOTAuDU6ojEzr2+U0FgJGN8ocfJFy
	4hRE3QtGyanZ9eAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791207223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gNOokBpjhXFRQxScEItGBiMsBbFOJv2CVZ4EUczuiSc=;
	b=F3I+aHhsbLO77RAdSJelspDc8xUXQfPbNS2bjYwaLcjpqr1KfAVefFvFlN0lbHUVld6G9t
	c2Y0M7RXLY6iujyoR2vUN+trVBN86Vr5uRcY6RE7EQJhRSGYFnmdtOh6kJYdk/OjffNQQS
	+TFoNmea0lHf9vk+HSQtLPPYXIMMLLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791207223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gNOokBpjhXFRQxScEItGBiMsBbFOJv2CVZ4EUczuiSc=;
	b=MVnK4QIuviVhqUPAeEq0M2vAsEDcBmsEn08qhbQr/ps3ho5BJmmnfrfKSxVCNLvNIoPpIw
	52fxldSouuB94OAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE6013AED;
	Mon,  5 Oct 2026 13:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiqWKDanw2rDdQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 13:33:42 +0000
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
Subject: [PATCH v4 0/5] fbcon,vgacon,vt: Share helpers for text cursors
Date: Mon,  5 Oct 2026 15:30:58 +0200
Message-ID: <20261005133335.344302-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,linux.intel.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

VT consoles fbcon and vgacon implement various cursor sizes (i.e.,
underline, block, half-block, etc). Share related code and harmonize
the look and behaviour.

In patches 1 to 3, move VT cursor-size calculations to the VT subsystem
and use the new helpers from vgacon. Replace similar code in the console.
The new helpers also take VT's default cursor size into account.

Fbcon implements a custom helper that creates a cursor glyph for the
given cursor size. In patches 4 and 5, move the code into the font
library and update fbcon to use the new helper. The cursor-glyph shape
rendering is tied to the font in use. Hence move them next to each other.
Also update fbcon to use the shared cursor-size helpers.

Tested with fbcon under bochs (qemu) and with vgacon on an old SiS
6202 VGA card. Other consoles (newport_con, sticon) don't support cursor
sizes, so leave them as-is.

v4:
- vgacon: validate size before handlign CUR_NONE
- use do-while over goto (Jani)
v3:
- mention user interfaces to control cursor size in commit message (GregKH)
- elaborate defaults (GregKH)
- move retry logic into helper
- handle CUR_DEF
v2:
- restore vc_cell_height in vgacon
- avoid interference from concurrent user space
- fix docs

Thomas Zimmermann (5):
  vt: Add cursor-size helpers
  vgacon: Remove trailing whitespaces
  vgacon: Use vt_cursor_{start,end}()
  lib/fonts: Add font_glyph_cursor() helper
  fbcon: Replace fbcon_fill_cursor_mask() with fbcon_cursor_glyph()

 drivers/tty/vt/vt.c                  | 114 +++++++++++++++++++++++++++
 drivers/video/console/vgacon.c       |  43 +++-------
 drivers/video/fbdev/core/bitblit.c   |   3 +-
 drivers/video/fbdev/core/fbcon.c     |  45 +++--------
 drivers/video/fbdev/core/fbcon.h     |   2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |   3 +-
 drivers/video/fbdev/core/fbcon_cw.c  |   3 +-
 drivers/video/fbdev/core/fbcon_ud.c  |   3 +-
 include/linux/console_struct.h       |   8 ++
 include/linux/font.h                 |   4 +
 lib/fonts/Makefile                   |   3 +-
 lib/fonts/font_cursor.c              |  56 +++++++++++++
 12 files changed, 210 insertions(+), 77 deletions(-)
 create mode 100644 lib/fonts/font_cursor.c


base-commit: b0bd9fb9e92aae2a653efa1d0407daa2aabe99d0
-- 
2.55.0

