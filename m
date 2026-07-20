Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1F3BB111;
	Mon, 20 Jul 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555651; cv=none; b=IjzIHnVLJ/fxnd6iQgULeCvibrMqwYgFsRvYm8/2RMROodm5aA0j5fpw1dG77j8j1pccyf5ZzRNZoZBM7bhNFhg6Bj5wTYefqAsUbSH86dPTIMsTE+LWWJKG2MydUZiYg6wlXCxH4jpBimVBuuz8PKqNzzLB+YjFTnrdzljctdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555651; c=relaxed/simple;
	bh=kdZIuqjdU6X6pEp+O8SwzE74CPmCZ30ygTkustTpHwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkf0+QwibvnQ6oIXslaByHSr4ajGZFyA+CIP4cXceZvk7tMPLHJRTRiFq7DrMYjPWc2EOiYkaKU6qT+MpIq00EqVFXMehHakXElPvsWn4TTt8uX4e7JO4MVZiprfR6o6xId3z+K47ytzyvR/Hb9qIvERIcjmZ5S4BG3LLhVnxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQdafAvf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkC3oN8K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQdafAvf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkC3oN8K"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784555647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+4+l5UWHO8Z9YG2yQdk9Zrp047EJzCFUpszyUQoQt4=;
	b=jQdafAvfZhEWLfyMSy+4YIEd7gveNXjsuy+bs4HMvTrTEyO7ToAd+HEoAoshAOZMS97H89
	OPiHExOyPm7xMy81AUge5Vz58CwvwvQdNdbw8viUnOYrMRqUNdACyeyGhtzS8JB4ZdymfB
	zLMxvT7geD8SHw+yfIj2Pt8qZ0BcVW2wkR8TRSbloAUNdedVS1po4dGhpqET+l3F9aQ02y
	W6JQUMpXPxvgPLUtc3hCV1Jf04d1G7Uu+AJlo0YBkLFc8Ow2Mdl4dMHFe/143JOuR9DeTY
	2/Ghebxi+RN4kw9IMTGg0fW7mH+Upnnfr8SECDmFEvPbozKigwIeQSRNymspmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784555647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+4+l5UWHO8Z9YG2yQdk9Zrp047EJzCFUpszyUQoQt4=;
	b=MkC3oN8KiW72K1AbiK2O9wgqIJlpIyEzA1lEn0faK94OGUhxWkaRbwlKNamWoMhI1WBZJl
	oaWymv+lNrYiWYAw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-serial@vger.kernel.org,
	Jacques Nilo <jnilo@free.fr>,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH tty v7 0/2] Convert 8250 to NBCON, take 2
Date: Mon, 20 Jul 2026 16:00:02 +0206
Message-ID: <20260720135407.3925-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v7 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v6 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

Based on Sashiko feedback, the changes since v6:

- Add irq_work_sync() calls to make sure there is no pending
  modem status work when suspending or unregistering the
  console.

- In the put_poll_char() callback, use __serial8250_clear_IER()
  because KDB/KGDB do not acquire the port lock to print.

- In serial8250_console_write(), re-enter unsafe section after
  printing text, even if ownership was _not_ lost. The final
  actions need to be performed within an unsafe section.

John Ogness

[0] https://lore.kernel.org/lkml/20260720103242.7265-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  45 ++++++-
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 200 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 222 insertions(+), 45 deletions(-)


base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

