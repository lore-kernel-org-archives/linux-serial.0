Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D762212D1B;
	Tue,  5 Nov 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835925; cv=none; b=elvenZHYQhs10Y/pVkb2qxz0Da8ye8uHABzUCNZFHDtH5BwBeHr2Rl9FM7fPlgthmqo/rhtMDmHNxeyPm5XPYrV5V9Gy8naLc9g9eSbvAcFohen++tKS6fg6zd42rEf+TEChDEuyDIJfKs9CcJDnXFTMvuw4n0wUueVdDl/v6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835925; c=relaxed/simple;
	bh=+uo+oOme1CmB+5q1MaRBiCVlq4P8kWEEAkNPOmwqjhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JIJgdAZiPetEwJh5E4n2t2HaBfqoPL2ULacUF97ExXBcsoFOoEzJf/ZShcJ1YFld4AkhxhwEuX4lHnrEd23F3XsZCir44ahzF5uQXm69NtErlakfVo8CnSC9mFC4OScQmzWCGThCEyqoq6xvLpr9g+FA9Wt1Gg1WmVlFDtHzx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hts3+1cO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hts3+1cO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hts3+1cO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hts3+1cO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 274E221C47;
	Tue,  5 Nov 2024 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fMzs0oF1vJx8lm3wAkmwj3i+sa0jFwrWXBRSF2GMRk4=;
	b=hts3+1cOTTX8dmhQIXPanc/s9/tu5atrKCBDB8D9g85OPw7K0oATY6s1GBVZ8LFar3Z/Vz
	NgR48TIjShlG5zpl5n3hVPNFy/Ug8wIIh2yYrjAGw3He0KBLYTHE3YbORKUFtwQ5CAp/fD
	9QwAwjDKcyQEfCGwMImg9lCohKpPTxE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hts3+1cO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730835921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fMzs0oF1vJx8lm3wAkmwj3i+sa0jFwrWXBRSF2GMRk4=;
	b=hts3+1cOTTX8dmhQIXPanc/s9/tu5atrKCBDB8D9g85OPw7K0oATY6s1GBVZ8LFar3Z/Vz
	NgR48TIjShlG5zpl5n3hVPNFy/Ug8wIIh2yYrjAGw3He0KBLYTHE3YbORKUFtwQ5CAp/fD
	9QwAwjDKcyQEfCGwMImg9lCohKpPTxE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A439613964;
	Tue,  5 Nov 2024 19:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YAiKGtB1KmdhAQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Tue, 05 Nov 2024 19:45:20 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/2] printk: Add force_con printk flag to not suppress
 sysrq header msgs
Date: Tue, 05 Nov 2024 16:45:07 -0300
Message-Id: <20241105-printk-loud-con-v2-0-bd3ecdf7b0e4@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMN1KmcC/3WNyw6CMBBFf4XM2jF9QBNd+R+EBdCpTNSWtNBoC
 P9uZe/ynOSeu0GiyJTgWm0QKXPi4AuoUwXj1Ps7IdvCoISqpZAG58h+eeAzrBbH4FHoQV+0bZx
 xA5TVHMnx+yi2XeGJ0xLi5zjI8mf/t7JEgcI0VNveGqPVLa2JzmN4Qbfv+xcinka4rQAAAA==
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730835918; l=1588;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=+uo+oOme1CmB+5q1MaRBiCVlq4P8kWEEAkNPOmwqjhE=;
 b=GANmkBkyIGRuGsy6J/6rBaJXRo6nCdmHngg5RfZ3ZTGCTOzCZgjQdmok+NCKcLiFYr0AxrR/e
 QpPVQ383NWRBLNiG2/UiikXyZAXdsxlyCZ0zTid0PmYkYkjXJZ4JR9c
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Queue-Id: 274E221C47
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hello,

This is the second version of the patchset. It now addresses comments
from John and Petr, while also mentioning that the current work solves
one issue on handle_sysrq when the printk messages are deferred.

The original cover-letter in is the v1.

Please review!

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v2:
- Mentioned that it fixes a bug related to loglevel= dance (suggested by John)
- Changed to loud_con to FORCE_CON (John, Petr)
- Don't skip printk delay if FORCE_CON is specified (John)
- Set FORCE_CON when LOG_CONT is handled (John)
- Changed force_con from a per-CPU variable to a global variable because
  we can't disable migration on the callsites. (John, Petr)
- Used is_printk_force_console() on boot_delay_msec(), since it's used
  when the message is stored, instead of setting is as an argument.
- Link to v1: https://lore.kernel.org/r/20241016-printk-loud-con-v1-0-065e4dad6632@suse.com

---
Marcos Paulo de Souza (2):
      printk: Introduce FORCE_CON flag
      tty: sysrq: Use printk_force_console context on __handle_sysrq

 drivers/tty/sysrq.c         | 18 ++++++++----------
 include/linux/printk.h      |  3 +++
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      | 21 ++++++++++++++++-----
 kernel/printk/printk_safe.c | 18 ++++++++++++++++++
 5 files changed, 48 insertions(+), 15 deletions(-)
---
base-commit: d9f4b813ae5c9bcdc9fcbaa1f4c9829bdc272532
change-id: 20241016-printk-loud-con-03b393d5f6fb

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>

