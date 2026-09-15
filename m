Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9E4A263A;
	Tue, 15 Sep 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475606; cv=none; b=MnwoOq+TRiR7pZxzTFg7/ADYewtEAw+dkhX7zk1gQXcVJ7dFwIVnt/IO264H9s9bNSZeP3EGfHgr9bUMFWivPMQ9FkWiDHb78Jl0Hk/TUpzEZutNUGjeW46xQsaccZtItlOo5b5HuBNMmvXykVjqnrM6d2tK4G7LHUJnn+bH27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475606; c=relaxed/simple;
	bh=sVigcsA21mB17SxHKlgLAbDqBp4If2xiiuunqcUWBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOnvMg5lbsc5zErA0xkTc8G8nyymGLBsssFxeuj81SwJQSHPkQi+z2xOtYB8UOAgs+vE2HUS7W/xq1SIfU1no5OvQMQCS+JPZkCQBXTn7qGpBQpfdrZeoS19KMI80DktWvAFH5JhoBlHCMc6wm9NrXXFSjLcGUpNf7Tw1cIwve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T3j/ithe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1GFOx9n/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dHjsRbfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NdIiCbX+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T3j/ithe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1GFOx9n/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dHjsRbfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NdIiCbX+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9764921BD3;
	Tue, 15 Sep 2026 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2q5BXiOn3GZssHRrJbwJ6n52w/a81OdmkPOetzDBMRk=;
	b=T3j/itheMiKdMalcLDLmHVsYOgCGIZR8rbmdi38BpbwdOGVzIVDMKxGdeprhLq1oGXvEw6
	zGwO/jAQIHe2zi52/m8VnPxPqXVq1lpUicUY6MCXqMIdhaajpaBo2jqS1xdrXiF1JBR3/J
	r4J1W0O7dj26mF6sqpEuDaK8KJYfJu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2q5BXiOn3GZssHRrJbwJ6n52w/a81OdmkPOetzDBMRk=;
	b=1GFOx9n/sfS8Jl0bl/bScbUPFZL/SxDSk7GyJDOIS0N8/EReA7+cGrpg5jSkXDebNZr0Qs
	ef4/JeO6xLGYzyCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dHjsRbfL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NdIiCbX+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789475593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2q5BXiOn3GZssHRrJbwJ6n52w/a81OdmkPOetzDBMRk=;
	b=dHjsRbfLJR4Ffy0AAQfv+WyESwtfTTYhJeC+cQZ4GZWVWnilCC6w84Dhx/SNWlzZ658uSX
	fVhO9W6gcF4cUhBhZW2wHnHBjLFEiJM6kNXQOoVpoGAcRuJprrjtoa6oX9/2z9woErPP9D
	Uh7gDW3n4lvvc5W7WRjWlM8TFIPp+F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789475593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2q5BXiOn3GZssHRrJbwJ6n52w/a81OdmkPOetzDBMRk=;
	b=NdIiCbX+TS2+g0dEfdlLT26F4GP2WAlByIaU1bbA7gFHd2sZZZH3L78JQUIpR/GCrn4apc
	fyBtdYyfaLMHG8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E84B136A5;
	Tue, 15 Sep 2026 12:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id COmnAwk7qWpGNQAAD6G6ig
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
Subject: [PATCH v2 0/5] fbcon,vgacon,vt: Share helpers for text cursors
Date: Tue, 15 Sep 2026 14:29:11 +0200
Message-ID: <20260915123304.1027277-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 9764921BD3
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
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

VT consoles fbcon and vgacon implement various cursor sizes (i.e.,
underline, block, half-block, etc). Share related code and harmonize
the look and behaviour.

In patches 1 to 3, move VT cursor-size calculations to the VT subsystem
and use the new helpers from vgacon. Replace similar code in the console.
The new helpers also take VT's default cursor size into account.

Fbcon implments a custom helper that creates a cursor glyph for the
given cursor size. In patches 4 and 5, move the code into the font
library and update fbcon to use the new helper. The cursor-glyph shape
rendering is tied to the font in use. Hence move them next to each other.
Also update fbcon to use the shared cursor-size helpers.

Tested with fbcon under bochs (qemu) and with vgacon on an old SiS
6202 VGA card. Other consoles (newport_con, sticon) don't support cursor
sizes, so leave them as-is.

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

 drivers/tty/vt/vt.c                  | 93 ++++++++++++++++++++++++++++
 drivers/video/console/vgacon.c       | 43 +++----------
 drivers/video/fbdev/core/bitblit.c   |  3 +-
 drivers/video/fbdev/core/fbcon.c     | 45 ++++----------
 drivers/video/fbdev/core/fbcon.h     |  2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |  3 +-
 drivers/video/fbdev/core/fbcon_cw.c  |  3 +-
 drivers/video/fbdev/core/fbcon_ud.c  |  3 +-
 include/linux/console_struct.h       |  7 +++
 include/linux/font.h                 |  4 ++
 lib/fonts/Makefile                   |  3 +-
 lib/fonts/font_cursor.c              | 56 +++++++++++++++++
 12 files changed, 188 insertions(+), 77 deletions(-)
 create mode 100644 lib/fonts/font_cursor.c


base-commit: 2535e80aa0dd3d4269a43bf86a1686baddcf08d6
-- 
2.55.0

