Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761895;
	b=TEvx+epFvcJAO1h1VvtmeFbiyfW8ASvfRGMcgsr+hqN/xJy7Yik1alrxHHDIHkeWL9kK
	 aPil3YlghLjNzTs9ycKDcXI/vjUQGZySaYVnrC7HD+MD02s6urmfJcu9ngaq8nKZtPyjQ
	 TPW09CMlHKNE9C/PzItmNozeEpEiE86UAFCPq8lxRF6qmdwrtbYFng6PH3wz/1bjJMCJa
	 S/qEUQsLt8x3F6GnU0Y4ecmecC6eqCcd9sCxHa8UY6eCnsIqD3mwcxRbzDv1GIPGowal0
	 MlfhtavwvgxIeZy5UflK5StPZlhvRx1/D901yWB1Mj4VBfsz/ktqGuKMpD+tPIsNj0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761895;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=nP2grGeBdBaPLC2SQS523z5VUq05brk6Jf3ACXr4PSs=;
	b=oODOsW2NAd1nD9TaPf53L4aQFwDmB/LP7cuBdfSKAtdJxacgTeog06rrXLFSHzVOf354
	 IhaQz45kM9VMUF90VQ+iIkvR8o9xNSf7PkgxPg7H2dGOtzfrFOfvSgP/s/sOnt+cfgTl0
	 sWWNoCWvJisXe/QlXVN/Z8vvBW10gZ1fYjH1vqKIi7diW/ocqrB6Wg34IMyqIQUC4Nm3W
	 Xpy7PG44S92OMqaiwqLWjGrHzazZ1mCZR7zCTWUz3kURxiVbgtePm3nVt2sxppjGUDtoS
	 4Uo8XoWSysWOwqtbuVjsUDZhd5FmBXODwfa1Ux599RUKK6IQKqYezNRy5NkpmlY8Lag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9022606A326;
	Fri, 23 Oct 2026 13:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9022606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E092D1F391;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FE75133F6;
	Fri, 23 Oct 2026 13:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kolmHiNg22qfRQAAD6G6ig:T3
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Oct 2026 13:24:52 +0000
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
Subject: [PATCH v3 2/7] dummycon: Implement struct consw.con_unblank
Date: Fri, 23 Oct 2026 15:16:12 +0200
Message-ID: <20261023132448.115747-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023132448.115747-1-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: E092D1F391
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Implement con_unblank from struct consw as a duplicate of con_blank.
As dummycon does not do anything, the implementation only returns
true or false to trigger a redraw (or not).

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/console/dummycon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 7d02470f19b9..44856df84d99 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -86,6 +86,11 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 	return true;
 }
 
+static bool dummycon_unblank(struct vc_data *vc, bool mode_switch)
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
+static bool dummycon_unblank(struct vc_data *vc, bool mode_switch)
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
2.56.0

