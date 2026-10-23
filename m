Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761895;
	b=y1eJwYiedWEoZ8UoEjzXjU+dROGEdSfZD+Ht0tZWPEEl766KWn1Iv4c22uDtuvZ1Fe4t
	 DTQMF76rdW6G6sIBTwE7koovsGaRaznjiOs1ZiiYFZ/qqzhqmr6+bf52NjU9uXGruZb0d
	 dIxQ5cwUrw8h5MDIw38RtPgJGipf8g2VqxH1lmL8/7HeTXv5r5SqcFSA8xHGCQj3zLaCB
	 TgCzQroezcpMuZY20P0ghU/rfFjAe6vMGdDCdeDEHy5PY8x/jB5VOwZiL4Zul+LMzbbHa
	 e1qiF0gTNWTPSN9GsObNphy582cmtS/OOmS6Q7EZHj0RAO+PNe2LdKqMQWdZb1vypcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761895;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=zsy/5GiIOgtWnUTVUh8k11pMUOrV3Tn2LNwaNfHWL5M=;
	b=RXeuiYvTLwHh+1/PNzel0tV4tx0sMkCY3GUu3DYXk0JSH6wCTIgYpsltXehLch09wjG2
	 7nQwbfkJvOdW9OgwRzjmm+VPvKQK6iZTif5TOdsOoYabE78BiEtQ1OuXLc0lAvC63Hnnb
	 ZAcHlfs9j+nL8jMmI8lGMcRbjTD9mvEpKty1nB+H60cp3Q9N0AFJo9FoRLvM/4taUjqlN
	 SiXWvKJ5SPrk8B4gQRJccrkPbiTXHktoSzipbZLUVqOAoe/1ViiShHLZ/VcVn+HQgdX9R
	 liJXSM38ZDvEH3xKrfGDMDZF8knkaJDo8NffeykS/DsnSV33pij/2wtdmv2OBINAyow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="h/vayfyT";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/rwx4Xrc";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="h/vayfyT";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="/rwx4Xrc";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF2606A31F;
	Fri, 23 Oct 2026 13:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DCF2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h/vayfyT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/rwx4Xrc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h/vayfyT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/rwx4Xrc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6893121E11;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsy/5GiIOgtWnUTVUh8k11pMUOrV3Tn2LNwaNfHWL5M=;
	b=h/vayfyTiXWBRhwmyCh1telj0C0nf4djJMFQ7Afpw2uWw5ojLpSLLR5udvmFlplKSOZG76
	OZZWyuKR+baRw7XqHNiEats+WSRbaf+tTnqzODRKufx3NQiYFt8ENypoafBgrgCZfgGWg2
	sGlXWrTtARMAxMrBlnMA+cTewyoaePc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsy/5GiIOgtWnUTVUh8k11pMUOrV3Tn2LNwaNfHWL5M=;
	b=/rwx4XrcNmxxQCApeAEQD77xUv7ZpLvVV9K1w40LcRmL+qVmCtD0Dj6Da8Wo2NxIkPvLhz
	/UAtMTvEMCfTcuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792761892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsy/5GiIOgtWnUTVUh8k11pMUOrV3Tn2LNwaNfHWL5M=;
	b=h/vayfyTiXWBRhwmyCh1telj0C0nf4djJMFQ7Afpw2uWw5ojLpSLLR5udvmFlplKSOZG76
	OZZWyuKR+baRw7XqHNiEats+WSRbaf+tTnqzODRKufx3NQiYFt8ENypoafBgrgCZfgGWg2
	sGlXWrTtARMAxMrBlnMA+cTewyoaePc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792761892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsy/5GiIOgtWnUTVUh8k11pMUOrV3Tn2LNwaNfHWL5M=;
	b=/rwx4XrcNmxxQCApeAEQD77xUv7ZpLvVV9K1w40LcRmL+qVmCtD0Dj6Da8Wo2NxIkPvLhz
	/UAtMTvEMCfTcuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D29AF133F6;
	Fri, 23 Oct 2026 13:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:51 +0000
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
Subject: [PATCH v3 0/7] vt: Simplify console-blanking interface
Date: Fri, 23 Oct 2026 15:16:10 +0200
Message-ID: <20261023132448.115747-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -11.80

Update con_blank from struct consw to use enum vesa_blank_mode according
to its intended semantics. Handle unblanking in the separate new callback
con_unblank. Update all consoles.

Some background: the vt subsystem calls con_blank with what at first
appears to be nonsensical arguments: the blank value and the type of the
blank parameter do not match. con_blank mixes up console blank state and
monitor DPMS levels for power saving in the same argument. The
implementation of con_blank in various consoles suffers from a similar
problem: their interpretation of the given blank value often disagrees
with what the value's type suggests.

Patch 1 adds a new helper con_unblank, which handles all unblanking. This
allows for changing con_blank to only handle blanking. There's support
for both semantics while consoles are being converted.

Patches 2 to 6 implement con_unblank for the individual consoles. With
this, con_blank changes to its new semantics. Each console gets a single
callback for blanking and a single callback for unblanking.

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

Future directions: console blanking helper currently handle switching a
console between text and graphics mode. The mode_switch parameter indicates
this to the console. As suggested in earlier reviews, a later series might
rework the mode switching entirely.

v3:
- avoid possible regressions by adding back mode_switch
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

 drivers/tty/vt/vt.c                 | 11 +++---
 drivers/video/console/dummycon.c    | 12 +++++++
 drivers/video/console/newport_con.c | 24 +++++++------
 drivers/video/console/sticon.c      | 20 ++++++-----
 drivers/video/console/vgacon.c      | 46 +++++++++++++-----------
 drivers/video/fbdev/core/fbcon.c    | 55 ++++++++++++++++++++---------
 include/linux/console.h             | 10 ++++--
 7 files changed, 114 insertions(+), 64 deletions(-)


base-commit: 5b9ee97c47574138633a1cb70a32d118b6860a43
-- 
2.56.0

