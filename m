Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534192DECA3;
	Mon, 12 Oct 2026 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798082; cv=none; b=qQT8bklU9ToxKJvdAVJeWOvJUjSlO81DXSQJcRzsNtJ1+6OPW4DNlncMVIUrRAMqBqFWypeZ4tj7xwarPDXXNeMzYfguyOsMFGflHWVKNrL5nK99AH7ji33UL1y0EWqw9DLyMPNnXF8PN1AC696LY4DLBFpTUhlasoRSpAEvb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798082; c=relaxed/simple;
	bh=PdlP18nBDjAvBRvvus9niiB+c4f4AJsdjcgnqSheA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teox3NZxsXKSPIey17ou5J6KIMucPp/Kem3PF1wsT8LqIY/9lUDBQwucI+8cnz4WHghDT9SvgSmqkh2VeefdnlXPbKVHGX4sqLgUyEDkm7McM9cKvacJpemMFSJMNdZhoLgFqTSpHLu1BH1HNrlPgYjVMDMr2W2H11SrmngRB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fXjw5plW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XcwjQeiB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fXjw5plW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XcwjQeiB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fXjw5plW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XcwjQeiB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fXjw5plW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XcwjQeiB"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36E9F1F76C;
	Mon, 12 Oct 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bJNeydmS+Bv5T0KGL6oxtmcxHWfJHOsLHVT649w3VS4=;
	b=fXjw5plWuJzANw3j/2tiwepo4C6KajON2cNmDs4mKXYym7X6gS54MZstFxJUKxDpkMvGud
	6939hb//vvYE0hXf8P0nTI8zTrG5zA9QXto5xAPt9Px6lH9YXTghf512yDqdKipZL3dh/4
	hn8W4PSuf69B8W30dNSZ35PWWaVPEBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bJNeydmS+Bv5T0KGL6oxtmcxHWfJHOsLHVT649w3VS4=;
	b=XcwjQeiB47qMxcY2WRJBRbpCynk4T3r3dDcpdkaJv3KQTd1Hh0GffH8Mo48aLIX1N4YLiD
	sm6hvKp0oFnc5nDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fXjw5plW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XcwjQeiB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791798078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bJNeydmS+Bv5T0KGL6oxtmcxHWfJHOsLHVT649w3VS4=;
	b=fXjw5plWuJzANw3j/2tiwepo4C6KajON2cNmDs4mKXYym7X6gS54MZstFxJUKxDpkMvGud
	6939hb//vvYE0hXf8P0nTI8zTrG5zA9QXto5xAPt9Px6lH9YXTghf512yDqdKipZL3dh/4
	hn8W4PSuf69B8W30dNSZ35PWWaVPEBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791798078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bJNeydmS+Bv5T0KGL6oxtmcxHWfJHOsLHVT649w3VS4=;
	b=XcwjQeiB47qMxcY2WRJBRbpCynk4T3r3dDcpdkaJv3KQTd1Hh0GffH8Mo48aLIX1N4YLiD
	sm6hvKp0oFnc5nDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B2D13314;
	Mon, 12 Oct 2026 09:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vPIGKD2rzGr6dgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Oct 2026 09:41:17 +0000
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
Subject: [PATCH 0/2] vt: Simplify console-blanking interface
Date: Mon, 12 Oct 2026 11:27:37 +0200
Message-ID: <20261012094114.38549-1-tzimmermann@suse.de>
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
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Rspamd-Queue-Id: 36E9F1F76C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The vt subsystem calls con_blank with what appears to be non-sensical
value. This is because the values and the type of the blank argument
do not match: it mixes up console blank state and monitor DPMS levels
for powersaving. The implmentations of con_blank in various consoles
suffer from the same problem. Update con_blank to a clearer interface.
Also update the consoles.

Patch 1 does a bit of preparation. It converts a boolean parameter
from int to bool, so that its meaning is clearer.

Patch 2 updates con_blank. The callback's blank parameter now controls
blanking in general. The new blank_mode parameter controls the monitor
status and related powersaving.

Tested with vgacon on a SiS 6202 VGA and with fbcon on a Matrox G200
VGA device. The latter also ran fbcon via DRM fbdev emulation. Its easy
to test this with setterm, like this

  setterm --blank force                        # blank
  setterm --blank poke                         # unblank
  setterm --blank force --powersave powerdown  # blank and turn off monitor

Blanking and unblanking still works in all tested cases.

Thomas Zimmermann (2):
  vt: Use boolean as parameter to do_blank_screen() and
    do_unblank_screen()
  vt: Distinguish between blanking and VESA blank mode in con_blank

 drivers/tty/vt/vt.c                 | 25 ++++++++--------
 drivers/tty/vt/vt_ioctl.c           | 12 ++++----
 drivers/video/console/dummycon.c    |  4 +--
 drivers/video/console/newport_con.c |  4 +--
 drivers/video/console/sticon.c      |  4 +--
 drivers/video/console/vgacon.c      | 44 +++++++++++++++--------------
 drivers/video/fbdev/core/fbcon.c    | 23 +++++++--------
 include/linux/console.h             |  9 ++++--
 include/linux/vt_kern.h             |  5 ++--
 9 files changed, 69 insertions(+), 61 deletions(-)


base-commit: b0bd9fb9e92aae2a653efa1d0407daa2aabe99d0
-- 
2.55.0

