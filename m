Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87B37418C
	for <linux-serial@vger.kernel.org>; Thu,  2 Apr 2026 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125319; cv=none; b=XJkG2T/n/2enVa9s4k9XYnFa7ndgUNzt/tg2DopDzZ32n3qoWKRpnqYLj96cIysCdEr659aNOlz4VudhdaYCwGo2zun5XYtqWfubzx8ANP0PtUXFrpAB+TZm9687yXaXsBLo5w9kTVa100ckROxtkUOTSUlxXk7TwkiFLCpW+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125319; c=relaxed/simple;
	bh=YryMHYCFuuwJlS6pLqRsYYXWLXs9jUxPT34QtasqlTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYKzGiWB2Mt5IJXA5KgorfE+GH6bxqm+TllQer6FycPiap2noVftNv15c39dW4SR++ME/eLr8zrqyQ6tw8V8YmN+njKYrkd2NZQZP2ioudGORo1+3LHFUR4aatAY6wxL/YbomggDdLOUFi8GBEJq+VHTCNX5qyVO+euejFWEikI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BqChznbs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pihZ0s4k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BqChznbs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pihZ0s4k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BqChznbs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pihZ0s4k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BqChznbs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pihZ0s4k"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A7814D320;
	Thu,  2 Apr 2026 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775125316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga0X7RimFKh+RqVAM+aIK3ELJMMQzQHeTnAKGlp6IMs=;
	b=BqChznbspX3DboKuTDDeAXCx6tDc8GI24wSDUX3GHa3l6FeWQduWiwkWDiGvzys1t0rc8e
	KiaNrIGSEzEe3C1aRb+Jo7cfOtpuCw2AYqt3jGv4yJwKh5rgTWWu3Nw19xUVqXO6YvDPBk
	422aRz7yDSNLD9XhXZ29vZIZ+2riAg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775125316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga0X7RimFKh+RqVAM+aIK3ELJMMQzQHeTnAKGlp6IMs=;
	b=pihZ0s4kug4mJDs50ZxR9uthRfwKT75myHsL97ptvNQ2IRLe9FXHLfgtm2L3YhfW7SuPr3
	EGtY/XIkmYVWOCDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BqChznbs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pihZ0s4k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775125316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga0X7RimFKh+RqVAM+aIK3ELJMMQzQHeTnAKGlp6IMs=;
	b=BqChznbspX3DboKuTDDeAXCx6tDc8GI24wSDUX3GHa3l6FeWQduWiwkWDiGvzys1t0rc8e
	KiaNrIGSEzEe3C1aRb+Jo7cfOtpuCw2AYqt3jGv4yJwKh5rgTWWu3Nw19xUVqXO6YvDPBk
	422aRz7yDSNLD9XhXZ29vZIZ+2riAg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775125316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ga0X7RimFKh+RqVAM+aIK3ELJMMQzQHeTnAKGlp6IMs=;
	b=pihZ0s4kug4mJDs50ZxR9uthRfwKT75myHsL97ptvNQ2IRLe9FXHLfgtm2L3YhfW7SuPr3
	EGtY/XIkmYVWOCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 903B94A0B0;
	Thu,  2 Apr 2026 10:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8MMI0RDzmnEHQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Thu, 02 Apr 2026 10:21:56 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH] tty: serial: ip22zilog: Fix section mispatch warning
Date: Thu,  2 Apr 2026 12:21:53 +0200
Message-ID: <20260402102154.136620-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A7814D320

ip22zilog_prepare() is now called by driver probe routine, so it
shouldn't be in the __init section any longer.

Fixes: 3fc36ae6abd2 ("tty: serial: ip22zilog: Use platform device for probing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604020945.c9jAvCPs-lkp@intel.com/
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
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

