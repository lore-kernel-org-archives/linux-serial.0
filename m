Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C263E8C7D
	for <linux-serial@vger.kernel.org>; Fri, 27 Mar 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616693; cv=none; b=kERydheXLosBz47tjhtL7BsvPcXa3cp6UifqJdN+thNqPyr05vpVe3tm1A2bSbGV2xuwCbWiuMQCtQvPaNod2VBoLa3I1qUp3FcsGPZyT2iJGK7RDc2pdott/PQuR66Cvv43k6MBUQKoNoa2VdXY7KqKwh+1jkd1Qr79mRy+fUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616693; c=relaxed/simple;
	bh=Olc3nRBtwIXKASdckSPHhCbwBLHg8+YGP/umsNIqLxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkDzy5i26SSH6I0C1VKaSR+QEIXfHAANJgsuNYZcRm/mP7ayZ/aTU+CosZvsNWfWhbyQrSr5LTvXxARmlJ3u2LpuFpU/lAeif9aSB6eCzKef1CGGTV1crufQqnsCIasUfm01c/MYj/Rh7ewotFo+mDigi1jvNB7wcSEpf2E7vdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Cs3+3U8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=csVaRRQS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Cs3+3U8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=csVaRRQS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Cs3+3U8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="csVaRRQS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Cs3+3U8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="csVaRRQS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C8D04D38E;
	Fri, 27 Mar 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fVGtzGvjoY/rs1Dx30cKvv6gx94IsqDKYHw12bNUsA=;
	b=0Cs3+3U8x3pLxINPh1x0/3anTyofn2dKKIn55y8+S2jEN89hI0oNIcTo73hvQdWy1m6R9W
	Pp+qqYbkhxs4QK0zRJ6ivjItkJV7FFaGg4Kgz9obHDANTnceNN12UT2ikUIIFwHAOZ+Uyd
	lyWXr3Q52yUqC6rNP8aZSWmd+aSqtzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fVGtzGvjoY/rs1Dx30cKvv6gx94IsqDKYHw12bNUsA=;
	b=csVaRRQSKjW6wkRagZWHKOHETOYnvVJvtC/KqKkmOj2JJq9eAjXpM85C+Ixd2tBqRoD8az
	QGKH1DjrWWIjlhDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774616677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fVGtzGvjoY/rs1Dx30cKvv6gx94IsqDKYHw12bNUsA=;
	b=0Cs3+3U8x3pLxINPh1x0/3anTyofn2dKKIn55y8+S2jEN89hI0oNIcTo73hvQdWy1m6R9W
	Pp+qqYbkhxs4QK0zRJ6ivjItkJV7FFaGg4Kgz9obHDANTnceNN12UT2ikUIIFwHAOZ+Uyd
	lyWXr3Q52yUqC6rNP8aZSWmd+aSqtzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774616677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fVGtzGvjoY/rs1Dx30cKvv6gx94IsqDKYHw12bNUsA=;
	b=csVaRRQSKjW6wkRagZWHKOHETOYnvVJvtC/KqKkmOj2JJq9eAjXpM85C+Ixd2tBqRoD8az
	QGKH1DjrWWIjlhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDB534A0A2;
	Fri, 27 Mar 2026 13:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHgDMWSAxmmweQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:04:36 +0000
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
Subject: [PATCH 04/10] lib/fonts: Clean up Makefile
Date: Fri, 27 Mar 2026 13:49:37 +0100
Message-ID: <20260327130431.59481-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327130431.59481-1-tzimmermann@suse.de>
References: <20260327130431.59481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch,ravnborg.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
order. Done in preparation for supporting optional font rotation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/Makefile | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index 30a85a4292fa..3268d344c0a1 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -1,23 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 # Font handling
 
-font-objs := fonts.o
+font-y := fonts.o
 
-font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
-font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
-font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
-font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
-font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
-font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
-font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
-font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
-font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
-font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
-font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
-font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
-font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
-font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
+# Built-in fonts
+font-$(CONFIG_FONT_10x18)     += font_10x18.o
+font-$(CONFIG_FONT_6x10)      += font_6x10.o
+font-$(CONFIG_FONT_6x11)      += font_6x11.o
+font-$(CONFIG_FONT_6x8)       += font_6x8.o
+font-$(CONFIG_FONT_7x14)      += font_7x14.o
+font-$(CONFIG_FONT_8x16)      += font_8x16.o
+font-$(CONFIG_FONT_8x8)       += font_8x8.o
+font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
+font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
+font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
+font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
+font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
+font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
+font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
 
-font-objs += $(font-objs-y)
-
-obj-$(CONFIG_FONT_SUPPORT)         += font.o
+obj-$(CONFIG_FONT_SUPPORT) += font.o
-- 
2.53.0

