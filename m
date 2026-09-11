Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C135C696;
	Fri, 11 Sep 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119935; cv=none; b=lRBa3OMLpNlrlD+ufDu/s1dpYevhZGsPSFdSQJv2U9YCJdFCN7QudFmOr7fOSC2a0pPI2fFd2hesgbPdwU+mRE8LUo57ajcP1nvGccdeY7Qry4abMRYjcCMMe6Sixg1eHR4Vyg4qhwYV/mbelTlOIly0WTArpVHMdy9hms702y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119935; c=relaxed/simple;
	bh=m1syCuCNmUfzvUhlMWIo1QoGLFQDLr53vhALqDnKKLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7feUpRtkxCX2uWkHImabtYfZ6m3CKxDkZNzcbmbwIwV9psrsJ+SgcbxQHYBSh7/vT4c7w9TJ8bsBLRzRL2ThvVNo3G2ezyeP4FR9Hpn6ABDVduBedhPQJ8a6AO63yCLdKW+ZZxzVZqbmwO2CGZuSDG/CwnjQjMVy3EvoBxhOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T7LTexW8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oksVHAuo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=REEsxIfs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlw530WX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T7LTexW8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oksVHAuo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="REEsxIfs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlw530WX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8382C21DB2;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RW3KvYWf1BLKivNco5rnWkvmVoFRz7feTXnHS7SEToo=;
	b=T7LTexW8pBnL1hylfeAYyi9pTPWsnQhMsnmpyA+kjfTX4BW4KZ3ZhhzZzqib+mB8KOMo29
	xV5a9Fxjl3UvEJcPiv+CRgonLGuIb7Qfdfh7dr51mLenCGQK6aJ3VTn1dmdC5fnPoSmqol
	ctkPFprO3yor4h+IcVa/9k7bAQxUh8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RW3KvYWf1BLKivNco5rnWkvmVoFRz7feTXnHS7SEToo=;
	b=oksVHAuogFb3/mrUI6PhzCf8ofWJeRtAPrZUvgICeOGQ/UnQymM3lP/ep96hKpw2+8QmJ5
	1D5VhxOMBhW1CXAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789119923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RW3KvYWf1BLKivNco5rnWkvmVoFRz7feTXnHS7SEToo=;
	b=REEsxIfsq5+oZHmrE+EeqI+V0nzlHX7HxkVaRDtQnVkZptqBawlTKi2sxdJSavi4WuJEyj
	UT7pA2WtsyKImk8I1YIByGu79guP4qyidaoarChL9yBXsROKhd2fLHUJqqRzXqu/8TQZAt
	WwgyIU9Ga5zJFA2s/0EE3Y6HpNM1Fu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789119923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RW3KvYWf1BLKivNco5rnWkvmVoFRz7feTXnHS7SEToo=;
	b=wlw530WXmdDmBNRpnlZZbcCQvJ2gk27Mcpk6jCJxH3eMdYyUdgXoaoaNrl7OzYWUlyYJgS
	LCjL/+jqS5FbGqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21399136ED;
	Fri, 11 Sep 2026 09:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +XFOBLPNo2oFVgAAD6G6ig
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
Subject: [PATCH 0/5] fbcon,vgacon,vt: Share helpers for text cursors
Date: Fri, 11 Sep 2026 11:25:18 +0200
Message-ID: <20260911094518.78093-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

VT consoles fbcon and vgacon implement various cursor sizes (i.e.,
underline, block, half-block, etc). Share related code and harmonize
the look and behaviour.

In patches 1 to 3, move VT cursor-size calculations to the VT subsystem
and use the new helpers from vgacon. Replace similar code in the console.
The new helpers also take VT's default cursor size into account. Fbcon
will be updated in patch 5. Other consoles (newport_con, sticon) don't
support cursor sizes, so leave them as-is. 

Fbcon implments a custom helper that creates a cursor glyph for the
given cursor size. In patches 4 and 5, move the code into the font
library and update fbcon to use the new helper. The cursor-glyph shape
rendering is tried to font in use. Hence move them next to each other.
Also update fbcon to use the shared cursor-size helpers.

Tested with fbcon under bochs (qemu) and with vgacon on an old SiS
6202 VGA card.

Thomas Zimmermann (5):
  vt: Add cursor-size helpers
  vgacon: Remove trailing whitespaces
  vgacon: Use vt_font_cursor_{start,end}()
  lib/fonts: Add font_glyph_cursor() helper
  fbcon: Replace fbcon_fill_cursor_mask() with fbcon_cursor_glyph()

 drivers/tty/vt/vt.c                  | 90 ++++++++++++++++++++++++++++
 drivers/video/console/vgacon.c       | 46 ++++----------
 drivers/video/fbdev/core/bitblit.c   |  3 +-
 drivers/video/fbdev/core/fbcon.c     | 44 ++++----------
 drivers/video/fbdev/core/fbcon.h     |  2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |  3 +-
 drivers/video/fbdev/core/fbcon_cw.c  |  3 +-
 drivers/video/fbdev/core/fbcon_ud.c  |  3 +-
 include/linux/console_struct.h       |  2 +
 include/linux/font.h                 |  4 ++
 lib/fonts/Makefile                   |  3 +-
 lib/fonts/font_cursor.c              | 56 +++++++++++++++++
 12 files changed, 180 insertions(+), 79 deletions(-)
 create mode 100644 lib/fonts/font_cursor.c


base-commit: cf3f6830cd1a44f792534b4f5695c5ca7a69943d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
prerequisite-patch-id: 6f645bbd39e5c6af230c94ecaf78db518a8e2e10
-- 
2.55.0

