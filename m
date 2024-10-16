Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EA143744;
	Wed, 16 Oct 2024 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098202; cv=none; b=NKgYuIZkWmK1AaF5/79VKIl2Gyz6oFKgUpuvBJP6hME2KtUXlOcfJTOX7Ww5+9/VtjcTCoQGfbIQBoPvotxiptVLYnZR8yM/z9sDFnEN/x23piVRM45fe0AepCWBOMOhWrvDOZX2AjjfAQNhFTUhxGBGhBzF09hF7wpZ5cwUp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098202; c=relaxed/simple;
	bh=N2OrnNXHJSt9SlJS5auj5drejqaZ8o9LzRdJhBAyTjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y4YCIUC33wzQuKc75aHHSZ6xT9EMZK6R/ClgUlCQnDsz05ZDtd+Tk6wv5tqLnpNREJmpFA9UM6YXmYs97lfGA75+KVyKI+bAN0xnYW3S8xXza8atRs7sM51ZlxaGLnAf4XqiyOpP6KPZ8JCwsTJTg+Odt4auZioHrDEWDPyKfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H3CyoI/j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H3CyoI/j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H3CyoI/j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H3CyoI/j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3276421ED2;
	Wed, 16 Oct 2024 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729098199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zyu12PFVdaB02ogwAHdKPb6epsSzU0qDOHTEvmFyPs0=;
	b=H3CyoI/jC+CjcKmQ5G+V9WMImHF2CsL25IGCcpnW21HwgsA0n1gUxz1VjzivzQ0sTXyqvu
	dONCI+7tqjfs/Law2YwpvHp1xMxNjQAWXcUh4+6D2lr/KIHwPykvR4yjWRPY38VGZzowyd
	MDT73Th7bF7o2jYbQ/5XYD+59lUnPrw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729098199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zyu12PFVdaB02ogwAHdKPb6epsSzU0qDOHTEvmFyPs0=;
	b=H3CyoI/jC+CjcKmQ5G+V9WMImHF2CsL25IGCcpnW21HwgsA0n1gUxz1VjzivzQ0sTXyqvu
	dONCI+7tqjfs/Law2YwpvHp1xMxNjQAWXcUh4+6D2lr/KIHwPykvR4yjWRPY38VGZzowyd
	MDT73Th7bF7o2jYbQ/5XYD+59lUnPrw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC58E13433;
	Wed, 16 Oct 2024 17:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1JcvHNbxD2dkTQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 16 Oct 2024 17:03:18 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] printk: Add loud_console printk flag to not suppress
 sysrq header msgs
Date: Wed, 16 Oct 2024 14:03:00 -0300
Message-Id: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTxD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3YKizLySbN2c/NIU3eT8PF0D4yRjS+MU0zSztCQloK6CotS0zAq
 widGxtbUAH/hpYGEAAAA=
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729098195; l=1038;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=N2OrnNXHJSt9SlJS5auj5drejqaZ8o9LzRdJhBAyTjY=;
 b=zE5FqlexQm4uCQ63ak0/ZWu06AFG9YuBUY4cPa/iEdkSkQwVc8X+NoYKWY7DVcBeQj0SS+sNl
 1LJRENgFofvAtup8nDG75R+lndFn1fYHmdTZ3pxg8bdRLUsRa43xI83
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

These two patches will change printk_context to store a new context,
called loud console. By using this context it would be possible to have
printk messages that are never suppressed by loglevel filtering.

This is useful on __handle_sysrq that currently uses a workaround to
make sure that sysrq header message are not suppressed.

Please review!

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (2):
      printk: Introduce LOUD_CON flag
      tty: sysrq: Use printk_loud_console context on __handle_sysrq

 drivers/tty/sysrq.c         | 18 ++++++++----------
 include/linux/printk.h      |  3 +++
 kernel/printk/internal.h    |  3 +++
 kernel/printk/printk.c      |  8 +++++++-
 kernel/printk/printk_safe.c | 27 +++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 13 deletions(-)
---
base-commit: 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
change-id: 20241016-printk-loud-con-03b393d5f6fb

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>

