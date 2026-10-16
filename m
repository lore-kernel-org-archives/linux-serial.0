Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BA476694;
	Fri, 16 Oct 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143245; cv=none; b=E/r3eiQVmtWInKan3IbkFQ3+fGfln/fWAvrXAhXtxWWUJ4nI5xTbSPzgiCFE2BksptzuF1Hv2DmwEENopfg5Lk+t/Bds/A5suKN0m94AYsjLo42pivCmSsc4TGdaMQFCn8nB3chnxklmrUFgMI8AZYqulrOltsNB5zY9o2jc0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143245; c=relaxed/simple;
	bh=eBs996wBU0kHSX2CSIOffRXsknCa60ssG5k6VBPzbmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jq3cLZQ4AQdep85xrmLvtoqQOEkHjG33pEdyYE/evug90PcJxFlCALuQVXkFkx2ip8BSCU303pHyfk6P47r5J8MYPUn/1EqeqnYoc4nMOGvVGhPc7dNDtIp28zdH/Q69frTZ+20YaQ0NfCSjUmMjWJcocXiqSAsSiw2NFQXa3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r1GG8J9p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l2fn96kt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r1GG8J9p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l2fn96kt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r1GG8J9p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l2fn96kt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r1GG8J9p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l2fn96kt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4C2121C3C;
	Fri, 16 Oct 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvfh66KwNzqqMN3+fq9Vnd/nlxD4pr4qkY+Ybb0vHOA=;
	b=r1GG8J9pxxr4ZDQtWgzuoI8uxqRWq+I4PZ34qOZE3DuyDiXlcu1NpomfVKo5zMsjqhk7XC
	YbltweODGpWoKJrcE4KeWGTzAD37k9KKDU8G/Og3NrYfMBligfkLAtZ/OzBHSgqHu9I6qs
	YiUlABFAmY7Y1A6qTCLwqqf5oiPUROk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvfh66KwNzqqMN3+fq9Vnd/nlxD4pr4qkY+Ybb0vHOA=;
	b=l2fn96ktXtk4IIKPfptBrgRMx7xM65uuiSzCC3EUAP8gEIpn101i/hKp5r9YVOD8j902ge
	5wMm1VT1TSQQZcCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r1GG8J9p;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l2fn96kt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvfh66KwNzqqMN3+fq9Vnd/nlxD4pr4qkY+Ybb0vHOA=;
	b=r1GG8J9pxxr4ZDQtWgzuoI8uxqRWq+I4PZ34qOZE3DuyDiXlcu1NpomfVKo5zMsjqhk7XC
	YbltweODGpWoKJrcE4KeWGTzAD37k9KKDU8G/Og3NrYfMBligfkLAtZ/OzBHSgqHu9I6qs
	YiUlABFAmY7Y1A6qTCLwqqf5oiPUROk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cvfh66KwNzqqMN3+fq9Vnd/nlxD4pr4qkY+Ybb0vHOA=;
	b=l2fn96ktXtk4IIKPfptBrgRMx7xM65uuiSzCC3EUAP8gEIpn101i/hKp5r9YVOD8j902ge
	5wMm1VT1TSQQZcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 691031378C;
	Fri, 16 Oct 2026 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:01 +0000
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
Subject: [PATCH v2 0/7] vt: Simplify console-blanking interface
Date: Fri, 16 Oct 2026 11:11:50 +0200
Message-ID: <20261016093357.33294-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Rspamd-Queue-Id: D4C2121C3C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Update con_blank from struct consw to use enum vesa_blank_mode according
to its intented semantics. Handle unblanking in the separate new callback
con_unblank. Update all consoles.

Some background: the vt subsystem calls con_blank with what at first
appears to be non-sensical value. This is because the blank value and the
type of the blank parameter do not match: con_blank mixes up console blank
state and monitor DPMS levels for power saving in the same argument.
The implementation of con_blank in various consoles suffers from a similar
problem: their interpretation of the given blank value often disagrees with
what the value's type suggests.

Patch 1 adds a new helper con_unblank, which handles all unblanking. This
allows for changing con_blank to only handle blanking. There's support
for both semantics while consoles are being converted.

Patches 2 to 6 implement con_unblank for the individual consoles. With
this, con_blank changes to its new semantics. Each console gets a single
callback for blanking and a single callback for unblanking. Switching a
console between text and graphics mode is currently tied to the blanking
helpers. The mode_switch parameter controls this. As suggested in the
earlier reviews, rather detect a mode switch from the existing state.
The mode_switch parameter is deprecated. A later series might rework the
mode switching entirely.

With all consoles updated, patch 7 removes the old semantics and the
mode_switch parameter.

Tested with vgacon on a SiS 6202 VGA and with fbcon on a Matrox G200
VGA device. The latter also ran fbcon via DRM fbdev emulation. It's easy
to test this with setterm, like this:

  setterm --blank force          # blank
  setterm --blank poke           # unblank
  setterm --powersave powerdown  # set VESA DPMS level 3
  setterm --blank force          # blank and turn off monitor
  setterm --blank poke           # unblank

Blanking and unblanking still works in all tested cases.

Newport and sticon are built-only, due to a lack of test equipment.

v2:
- rewrite series with con_unblank (GregKH)
- drop mode_switch from console implementations

Thomas Zimmermann (7):
  vt: Add con_unblank callback to struct consw
  dummycon: Implement struct consw.con_unblank
  fbcon: Implement struct consw.con_unblank
  newport_con: Implement struct consw.con_unblank
  sticon: Implement struct consw.con_unblank
  vgacon: Implement struct consw.con_unblank
  vt: Remove old-style con_blank

 drivers/tty/vt/vt.c                 |  9 ++---
 drivers/video/console/dummycon.c    | 18 +++++++--
 drivers/video/console/newport_con.c | 27 ++++++-------
 drivers/video/console/sticon.c      | 27 ++++++++-----
 drivers/video/console/vgacon.c      | 60 +++++++++++++++++------------
 drivers/video/fbdev/core/fbcon.c    | 60 ++++++++++++++++++++---------
 include/linux/console.h             | 12 +++---
 7 files changed, 132 insertions(+), 81 deletions(-)


base-commit: b0bd9fb9e92aae2a653efa1d0407daa2aabe99d0
-- 
2.55.0

