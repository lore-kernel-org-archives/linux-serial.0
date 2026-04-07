Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4153019BA
	for <linux-serial@vger.kernel.org>; Tue,  7 Apr 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559110; cv=none; b=PfT3MfqC7PdPbNK2I3IquRFeHn0UnF+a/Lj92Dt4/cNXVe/y8p0XiecHGYQqXF8lmIadihZQSqdaAGnj/zQ5el1EVeLR26FcpLSIZ9Ad9pZv06BY+0bxa9HDtICvJzkoVqerx64jOfHEEwYUbBshEVZqd4iPIAlCxFxrG61rTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559110; c=relaxed/simple;
	bh=jfqNBk+ygMsRyhmE8CRzZUa1qBCTQiZtxu6mTxJaBsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEnPjWagYt0y9Hu5twzjSfGUqPr96sTSYR4WoygilgrJWJFWRXwTZ4kTrM43anfiRVNXnyU15HipTu2F+t2ti/wTOg1bmovBCITaLdzh/nDWq3RUHdC11ZiMtHcJfJjSUNO5N8m0OlYJETkr/SctDFalX6w76VIQOtcH7dGqYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3GpnU1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=96uAvwyv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3GpnU1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=96uAvwyv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3GpnU1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96uAvwyv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3GpnU1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="96uAvwyv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 62D674E3F6;
	Tue,  7 Apr 2026 10:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775559107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApOXEwcWW8mSNxBVkVRmRKj5n58n2wASOfLCei43M+Y=;
	b=y3GpnU1QYOHAUaZE+FKRr1MvjdltTdBHfw0F2VezJZFvxBGBfPbnKfpzgFhcqv+9U4vddv
	2kn5JkUQ+qiWKAsDzTd7uzXQvN7QYHw4Umpt8+xphn6P59ySInPIy62i+7kXxGw0KqZgNb
	+QfCxRXujb/UB8oNfrAASoHIxlD1AeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775559107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApOXEwcWW8mSNxBVkVRmRKj5n58n2wASOfLCei43M+Y=;
	b=96uAvwyvQj5i85ZlmssfkhlivXd8FR3OmE3sYjWVUcGgDv0RBe6UQWIDLAwDWkXj4NRH/W
	RezuNbeSBSs8ZQAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775559107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApOXEwcWW8mSNxBVkVRmRKj5n58n2wASOfLCei43M+Y=;
	b=y3GpnU1QYOHAUaZE+FKRr1MvjdltTdBHfw0F2VezJZFvxBGBfPbnKfpzgFhcqv+9U4vddv
	2kn5JkUQ+qiWKAsDzTd7uzXQvN7QYHw4Umpt8+xphn6P59ySInPIy62i+7kXxGw0KqZgNb
	+QfCxRXujb/UB8oNfrAASoHIxlD1AeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775559107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ApOXEwcWW8mSNxBVkVRmRKj5n58n2wASOfLCei43M+Y=;
	b=96uAvwyvQj5i85ZlmssfkhlivXd8FR3OmE3sYjWVUcGgDv0RBe6UQWIDLAwDWkXj4NRH/W
	RezuNbeSBSs8ZQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E48C4A0B0;
	Tue,  7 Apr 2026 10:51:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c032EsPh1GmTMQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 07 Apr 2026 10:51:47 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] tty: serial: ip22zilog: Fix section mismatch warning
Date: Tue,  7 Apr 2026 12:51:43 +0200
Message-ID: <20260407105144.10018-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:mid,suse.de:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

ip22zilog_prepare() is now called by driver probe routine, so it
shouldn't be in the __init section any longer.

Fixes: 3fc36ae6abd2 ("tty: serial: ip22zilog: Use platform device for probing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604020945.c9jAvCPs-lkp@intel.com/
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
Changes in v2:
- Fixed typo in subject
- Added Acked-by from Randy

 drivers/tty/serial/ip22zilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 6e19c6713849..a12101dc0554 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -1025,7 +1025,7 @@ static struct uart_driver ip22zilog_reg = {
 #endif
 };
 
-static void __init ip22zilog_prepare(struct uart_ip22zilog_port *up)
+static void ip22zilog_prepare(struct uart_ip22zilog_port *up)
 {
 	unsigned char sysrq_on = IS_ENABLED(CONFIG_SERIAL_IP22_ZILOG_CONSOLE);
 	int brg;
-- 
2.43.0

