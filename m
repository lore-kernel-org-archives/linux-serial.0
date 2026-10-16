Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63D45C710;
	Fri, 16 Oct 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143246; cv=none; b=jmvYy4+pYl9lvxXBSHChut3q1StRu45YcAFhU1tEfl8TrYHAOPITB/bvpphOx47j9S7BIv+Rl+vOxgE+5/0G1R6/ZrM0S4flCOBNASdbQMvMk4oUIBm/KXO7yn+oP84pX6EgkAvfbZgJm8bqsrnfxRma1o5Rp6rYOR+B9bK6kDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143246; c=relaxed/simple;
	bh=/cUVJL5EkNK4mse670+TpGXtPIGd005ezGt4PVFIRNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1A+B28aELPRu3MVEaT2v+4e4lYBZpEHxSyul5UfatNIzg+XdxO8EycdI4kK5G5+16YLKjEZCPcPXIAauK5Z4/89RBFcuM3ZlhN9m0yKRoe0CIxcBp3QaQRIfOeMg0HbjNP+zCElBQu4aFzxiKCk1jPio/bemPj8icoojTD91UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPDw+9IV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgLLYI39; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPDw+9IV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgLLYI39; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPDw+9IV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgLLYI39";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPDw+9IV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgLLYI39"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65BD521C38;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4mf/6pVpViQxzS54dN9DpNOvY2B9d8S/tB94Et6fNA=;
	b=lPDw+9IVGEB1MALmCrCZgCXdD/A8RPqZ4ZjOpYiO2UA6he43Mlw+lLiceM4OZGH6KOxjFl
	H2rkhUniFcxFfOTeZVCD4d0SJC1nXWvP5BWxkr1ULlnC0SJq2QarzduuDnmyodnFjM23rL
	K2TYnsEeXqQje/0MKJ0Kh10E1dgwGis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4mf/6pVpViQxzS54dN9DpNOvY2B9d8S/tB94Et6fNA=;
	b=CgLLYI39eyeHTrU7KuCmuCBWSS4kgkxGB3T8nQ9/MOEBz8CdnvF34EcV1vFmrTMTZXITJr
	/aGSktR86S49bUDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792143242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4mf/6pVpViQxzS54dN9DpNOvY2B9d8S/tB94Et6fNA=;
	b=lPDw+9IVGEB1MALmCrCZgCXdD/A8RPqZ4ZjOpYiO2UA6he43Mlw+lLiceM4OZGH6KOxjFl
	H2rkhUniFcxFfOTeZVCD4d0SJC1nXWvP5BWxkr1ULlnC0SJq2QarzduuDnmyodnFjM23rL
	K2TYnsEeXqQje/0MKJ0Kh10E1dgwGis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792143242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4mf/6pVpViQxzS54dN9DpNOvY2B9d8S/tB94Et6fNA=;
	b=CgLLYI39eyeHTrU7KuCmuCBWSS4kgkxGB3T8nQ9/MOEBz8CdnvF34EcV1vFmrTMTZXITJr
	/aGSktR86S49bUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08D65139B6;
	Fri, 16 Oct 2026 09:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8cgiBonv0WqmHQAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 09:34:02 +0000
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
Subject: [PATCH v2 2/7] dummycon: Implement struct consw.con_unblank
Date: Fri, 16 Oct 2026 11:11:52 +0200
Message-ID: <20261016093357.33294-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016093357.33294-1-tzimmermann@suse.de>
References: <20261016093357.33294-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmx.de,HansenPartnership.com,ffwll.ch];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]

Implement con_unblank from struct consw as a duplicate of con_blank.
As dummycon does not do anything, the implementation only returns
true or false to trigger a redraw (or not).

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/dummycon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 7d02470f19b9..ea34a7e84472 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -86,6 +86,11 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	return true;
 }
 
+static bool dummycon_unblank(struct vc_data *vc)
+{
+	return true;
+}
+
 static bool dummycon_switch(struct vc_data *vc)
 {
 	/*
@@ -104,6 +109,12 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 {
 	return false;
 }
+
+static bool dummycon_unblank(struct vc_data *vc)
+{
+	return false;
+}
+
 static bool dummycon_switch(struct vc_data *vc)
 {
 	return false;
@@ -155,5 +166,6 @@ const struct consw dummy_con = {
 	.con_scroll =	dummycon_scroll,
 	.con_switch =	dummycon_switch,
 	.con_blank =	dummycon_blank,
+	.con_unblank =	dummycon_unblank,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
-- 
2.55.0

