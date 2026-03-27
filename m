Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAA3E4C8C
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616679; cv=none; b=KZO2Mgpm9uEcgVg91Ywvd6DCvUawlxMTIBvWX8tBMIytQh//GwghrKzNMdJzcjiC2yPhzGCypMh+NL0GQVUD+Y1dr7AitH6SH363f43uvB8LO9SJD72SeSPGMpQiQw9o2VCsRbE1QkJ7ywjcJGazB6esdK2u3LxRYCNapoFPkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616679; c=relaxed/simple;
	bh=YLV6gpQdQgXCKIz4I78MKC+0kD6rTqN8263YJkHfzEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhXgrKzFr41yp4YbnX2o2b6QoQpR4L2qplYfuOTWqKOJcdCeJUrnHM8bX6j60W7WfiredDX4zNzGmIK6XZ4P+qeIGSdt8Zw3mlUn6PSn6hgVC2jdDv1jHdQH0fNd6uKoEsPkKxf6HJDlr+whzFxwPyubvtbCJgNkawpQTgsKDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyqYfqlW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsBisbgK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xyqYfqlW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lsBisbgK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyqYfqlW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsBisbgK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xyqYfqlW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lsBisbgK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD6A05BE04;
	Fri, 27 Mar 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2C8hHMnUTYCA9akD32oKOSDh4tMrqaneJwSjLUM5rE=;
	b=xyqYfqlWJjZ3ZHZ5vsbsmzPtpmn4aoXQJKGzMm7dszje9Z7mkwgEt4rpgXZLM1usIrn8Yc
	WLdqiiPORw65XC92xZQcjMqGGuewXwzU/z9qMNiJXw/AqYKaQNLyK0wv311eP5kYIX9yHt
	9HJPx6tB2VSqgco9IYKDr4HCCiOOw6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2C8hHMnUTYCA9akD32oKOSDh4tMrqaneJwSjLUM5rE=;
	b=lsBisbgK2CEvjQwP6F/HXVcSFVgQRxiqph6Bzx2z7ziLMYmrEfZtC6FcDbvZv9Qug8fuK0
	sDkynJRsTiyAfeAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2C8hHMnUTYCA9akD32oKOSDh4tMrqaneJwSjLUM5rE=;
	b=xyqYfqlWJjZ3ZHZ5vsbsmzPtpmn4aoXQJKGzMm7dszje9Z7mkwgEt4rpgXZLM1usIrn8Yc
	WLdqiiPORw65XC92xZQcjMqGGuewXwzU/z9qMNiJXw/AqYKaQNLyK0wv311eP5kYIX9yHt
	9HJPx6tB2VSqgco9IYKDr4HCCiOOw6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2C8hHMnUTYCA9akD32oKOSDh4tMrqaneJwSjLUM5rE=;
	b=lsBisbgK2CEvjQwP6F/HXVcSFVgQRxiqph6Bzx2z7ziLMYmrEfZtC6FcDbvZv9Qug8fuK0
	sDkynJRsTiyAfeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BEEB4A0A2;
	Fri, 27 Mar 2026 13:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vTXjJGOAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/10] fbcon,fonts: Refactor framebuffer console rotation
Date: Fri, 27 Mar 2026 13:49:33 +0100
Message-ID: <20260327130431.59481-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

Refactor the framebuffer console rotation into individual components
for glyphs, fonts and the overall fbcon state. Right now this is mixed
up in fbcon_rotate.{c,h}. Also build cursor rotation on top of the new
interfaces.

Start with an OOB fix in patch 1. If buffer allocation fails, fbcon
currently uses a too-small glyph buffer for output. Avoid that.

Patches 2 to 4 make a number of small improvements to the font library
and its callers.

Patches 5 to 8 refactor the font rotation. Fbcon rotation rotates each
individual glphy in a font buffer and uses the rotated buffer's glyphs
for output. The result looks like the console buffer has been rotated
as a whole. Split this into helpers that rotate individual glyphs and
a helper that rotates the font buffer of these. Then reimplement fbcon
rotation on top. Document the public font helpers.

Patch 9 rebuilds cursor rotation on top of the new glyph helpers. The
fbcon cursor is itself a glyph that has to be rotated in sync with the
font.

Patch 10 moves the state of fbcon rotation into a single place and makes
is a build-time conditional.

Tested with fbcon under bochs on Qemu.

Built upon the fbcon changes at [1].

[1] https://lore.kernel.org/linux-fbdev/20260309141723.137364-1-tzimmermann@suse.de/

Thomas Zimmermann (10):
  fbcon: Avoid OOB font access if console rotation fails
  vt: Implement helpers for struct vc_font in source file
  lib/fonts: Provide helpers for calculating glyph pitch and size
  lib/fonts: Clean up Makefile
  lib/fonts: Implement glyph rotation
  lib/fonts: Refactor glyph-pattern helpers
  lib/fonts: Refactor glyph-rotation helpers
  lib/fonts: Implement font rotation
  fbcon: Fill cursor mask in helper function
  fbcon: Put font-rotation state into separate struct

 drivers/tty/vt/vt.c                     |  34 +++
 drivers/video/fbdev/core/bitblit.c      |  35 +--
 drivers/video/fbdev/core/fbcon.c        |  48 ++++-
 drivers/video/fbdev/core/fbcon.h        |  14 +-
 drivers/video/fbdev/core/fbcon_ccw.c    |  70 ++----
 drivers/video/fbdev/core/fbcon_cw.c     |  70 ++----
 drivers/video/fbdev/core/fbcon_rotate.c |  88 ++------
 drivers/video/fbdev/core/fbcon_rotate.h |  71 ------
 drivers/video/fbdev/core/fbcon_ud.c     |  67 ++----
 include/linux/console_struct.h          |  30 +--
 include/linux/font.h                    |  51 +++++
 lib/fonts/Makefile                      |  36 ++--
 lib/fonts/font_rotate.c                 | 275 ++++++++++++++++++++++++
 lib/fonts/fonts.c                       |   2 +-
 14 files changed, 525 insertions(+), 366 deletions(-)
 create mode 100644 lib/fonts/font_rotate.c

-- 
2.53.0

