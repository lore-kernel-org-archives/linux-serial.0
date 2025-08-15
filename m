Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686A2857CC
	for <linux-serial@vger.kernel.org>; Fri, 15 Aug 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257618; cv=none; b=DXQfk8sWFhr8hTpAHX+FimiMLziCDtNriC5NgBoOd9w8Hqijq67U3oowIthXO8vFchFwK2CWveMxRrfFAhHKiINnfTm74JQk+Gys+uC5VQFhamTzVBmyKNmrR15WO4MLuCuDxrZDhj6D6z+CV6zGxakV8SfhL6i5yu0SVm+Htkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257618; c=relaxed/simple;
	bh=9oDjtyDt5EJbwhsh3gZIG0RVajVKgHnyrfDJlO6eaec=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+tYSUCIukoA36V9ybe4ZoYebsmIv7vojqMh5NxjkVr8YvO1Bx0BU5KQ2jP7nj0Qdp17hYprEs6hmxbi1C+Mh7okrYOWR5H/MvDCdUTCzfRk29dTewidawS0g1B7erC+f2ClKagLkRdIfH/IN2nC68bNI7YFTQ2DhQ73xf/Ez8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPurUWsc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5XmK2lc6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xPurUWsc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5XmK2lc6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPurUWsc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5XmK2lc6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xPurUWsc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5XmK2lc6"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFD2D1F83C;
	Fri, 15 Aug 2025 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755257608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDHlB238DMOoqzjCGx6+MZYPKvDLXTivDPn8V8OQS5o=;
	b=xPurUWsclpUEOiXQygn6iHfHsaeL+xkBwLRkbtkJmXME8ku0JywkxhW54cI3um0iw0F7yx
	fwyuk4Qo00jRWFNidG9np9FcMKlKSgNLJHVsinPJqtOevSk4AXpgacIJNlIHsB/e/i89wF
	Qih7amPjBb3hrjQ9zaqma93hlC6QcJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755257608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDHlB238DMOoqzjCGx6+MZYPKvDLXTivDPn8V8OQS5o=;
	b=5XmK2lc6PZlnpYpAgTzXXeRZOGTMpvvq1qBAgGiU5epilaUyTCo4SkVgLxSrG8UhwS7JSY
	5DPn3/fQ3024A6Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xPurUWsc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5XmK2lc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755257608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDHlB238DMOoqzjCGx6+MZYPKvDLXTivDPn8V8OQS5o=;
	b=xPurUWsclpUEOiXQygn6iHfHsaeL+xkBwLRkbtkJmXME8ku0JywkxhW54cI3um0iw0F7yx
	fwyuk4Qo00jRWFNidG9np9FcMKlKSgNLJHVsinPJqtOevSk4AXpgacIJNlIHsB/e/i89wF
	Qih7amPjBb3hrjQ9zaqma93hlC6QcJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755257608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDHlB238DMOoqzjCGx6+MZYPKvDLXTivDPn8V8OQS5o=;
	b=5XmK2lc6PZlnpYpAgTzXXeRZOGTMpvvq1qBAgGiU5epilaUyTCo4SkVgLxSrG8UhwS7JSY
	5DPn3/fQ3024A6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2A5B1368C;
	Fri, 15 Aug 2025 11:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YrIzKwgbn2jQUAAAD6G6ig
	(envelope-from <fvogt@suse.de>); Fri, 15 Aug 2025 11:33:28 +0000
From: Fabian Vogt <fvogt@suse.de>
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: hvc_console: Call hvc_kick in hvc_write unconditionally
Date: Fri, 15 Aug 2025 13:33:28 +0200
Message-ID: <2011735.PYKUYFuaPT@fvogt-thinkpad>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BFD2D1F83C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,opensuse.org:url]
X-Spam-Score: -3.51

After hvc_write completes, call hvc_kick also in the case the output
buffer has been drained, to ensure tty_wakeup gets called.

This fixes that functions which wait for a drained buffer got stuck
occasionally.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.opensuse.org/show_bug.cgi?id=1230062
Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
 drivers/tty/hvc/hvc_console.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cd1f657f782d..13c663a154c4 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -543,10 +543,10 @@ static ssize_t hvc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	}
 
 	/*
-	 * Racy, but harmless, kick thread if there is still pending data.
+	 * Kick thread to flush if there's still pending data
+	 * or to wakeup the write queue.
 	 */
-	if (hp->n_outbuf)
-		hvc_kick();
+	hvc_kick();
 
 	return written;
 }
-- 
2.50.1






