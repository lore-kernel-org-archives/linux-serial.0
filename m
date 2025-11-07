Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56480283FC8
	for <linux-serial@vger.kernel.org>; Fri,  7 Nov 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525580; cv=none; b=uEKIzCIgW1SDOOyMTeLxew0/NbT9EoRSNybWdt6fz4nOBqAOQ7MieAWKlAbNfdDkYG3olDTm1o57Q2lEic1wwqqqP+vLTn5w6o9fNP6qndYtmeifKBIHQGUPmn8c8H0I/cg1SKvdvnJ7lrgaYOdSmPBbtY5f21cySSQtZmDM+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525580; c=relaxed/simple;
	bh=Mp6IA0zVDdtxAntfke1mCamOvq+n2Yu7GJc3q2oM9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRUUShuhfO8rQwvdUMu1D7azbBirThP0K0AvEwBhao0fsoeI9PyDL2400EzYMKS4S5b0SnJrmSd6Wthqfq6aSetY5TVW6TTYZKtX4OFuuBb5qBR1hYtZANyg7n+g36JvEfNbt/+qpmA4AAY9fzlPCvopfZG5CoBIlpmJL6K9AI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pQ/dg+jg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rszn3W2+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pQ/dg+jg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rszn3W2+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQ/dg+jg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rszn3W2+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pQ/dg+jg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rszn3W2+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 822A01F395;
	Fri,  7 Nov 2025 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762525576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xmQwIoRc7TlHSgfQQifkqcsWbo9+VSI/CRM1jkwOePk=;
	b=pQ/dg+jgtwHf9uexU0fAQyokEYRtH7YMpY2fxgdyVyjXrv/HkRB7gvrwtPUMPjHS/VGPUh
	J5djd/FCtoOa6Wx3oKBXgpKS2ZmIPcRyw4RHvwNa86csuy+/C3HheyEoTSN9sV4a2erqyZ
	249MbUauGlvJj1Kpucm85Bf8tqWpTXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762525576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xmQwIoRc7TlHSgfQQifkqcsWbo9+VSI/CRM1jkwOePk=;
	b=rszn3W2+SfJKCZ+7vuckDJ4q0RY+8PMDC+zPocEGwtfl8NszPAw3jTFrrZhA3Slzp8JioB
	J1rjKlksZz1tglAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pQ/dg+jg";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rszn3W2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762525576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xmQwIoRc7TlHSgfQQifkqcsWbo9+VSI/CRM1jkwOePk=;
	b=pQ/dg+jgtwHf9uexU0fAQyokEYRtH7YMpY2fxgdyVyjXrv/HkRB7gvrwtPUMPjHS/VGPUh
	J5djd/FCtoOa6Wx3oKBXgpKS2ZmIPcRyw4RHvwNa86csuy+/C3HheyEoTSN9sV4a2erqyZ
	249MbUauGlvJj1Kpucm85Bf8tqWpTXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762525576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xmQwIoRc7TlHSgfQQifkqcsWbo9+VSI/CRM1jkwOePk=;
	b=rszn3W2+SfJKCZ+7vuckDJ4q0RY+8PMDC+zPocEGwtfl8NszPAw3jTFrrZhA3Slzp8JioB
	J1rjKlksZz1tglAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 334C81395F;
	Fri,  7 Nov 2025 14:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4pVVC4gBDmkaLgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 07 Nov 2025 14:26:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] drm/client: Wire up sysrq for all clients and update drm_log
Date: Fri,  7 Nov 2025 15:19:24 +0100
Message-ID: <20251107142612.467817-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 822A01F395
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,gmail.com,kernel.org,linux.intel.com,linuxfoundation.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

DRM's fbdev emulation has long supported SysRq+v to bring up the
framebuffer console for emergency output. Wire up sysrq for all
DRM clients and make it work with drm_log.

Patch 1 and 2 set up DRM client functionality for sysrq. The patches
adopt existing conventions from fbdev emulation, so that there's no
visible change to users. Invoke SysRq+v to bring up the in-kernel DRM
client.

Patch 3 adds restore functionality to drm_log. This enables SysRq, but
also brings back drm_log when the user-space releases control of the
display.

Tested on amdgpu and bochs.

Thomas Zimmermann (3):
  drm/client: Pass force parameter to client restore
  drm/client: Support emergency restore via sysrq for all clients
  drm/client: log: Implement struct drm_client_funcs.restore

 drivers/gpu/drm/Makefile                   |  3 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c |  6 +-
 drivers/gpu/drm/clients/drm_log.c          | 13 ++++
 drivers/gpu/drm/drm_client.c               |  1 +
 drivers/gpu/drm/drm_client_event.c         |  4 +-
 drivers/gpu/drm/drm_client_sysrq.c         | 65 ++++++++++++++++++++
 drivers/gpu/drm/drm_drv.c                  |  3 +
 drivers/gpu/drm/drm_fb_helper.c            | 69 +++-------------------
 drivers/gpu/drm/drm_file.c                 |  2 +-
 drivers/gpu/drm/drm_internal.h             | 11 ++++
 include/drm/drm_client.h                   |  8 ++-
 include/drm/drm_client_event.h             |  4 +-
 include/drm/drm_device.h                   |  8 +++
 include/drm/drm_fb_helper.h                |  8 +--
 14 files changed, 126 insertions(+), 79 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_client_sysrq.c

-- 
2.51.1

