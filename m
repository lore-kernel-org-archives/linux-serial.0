Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DF7421250;
	Fri, 24 Jul 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889418; cv=none; b=XtxZImWAV1q0xaSlTxjIbw/aehQcKG+/02x609nr7pmqcSwaPUqYkhV7yUd12OAcieGE3+zyWaMGKMoS47mzXiJzkLNbOECmn7S/qORCI+27MrnAnhvBPBL6k/Tr3SOhkXYYtgezxY/hdTHKKXKV0WiNIjSrWrUNzCbOOEHEFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889418; c=relaxed/simple;
	bh=LQcjeeLJ39vdfPP33ll1a+8ey7fixGi8PHjR1d17Md8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxqvmR0EKSaY6GUkfOy0H81QacstJTZow+r31HQE22uzrnviFPUjN9emx1JT9OnOTCA+eC/o9CLuNX8Vr5+ZU2YwWzQf65yulsWve5zZ6uiLEE7aeahyLyo2pR9yzRGIyPEeGV10gU57VjJL3d6JBYFB0QwkcrqsZFQWKcbC8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwPt2/cR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmFBaDg0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwPt2/cR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmFBaDg0"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XlLlE4+TmBUbjHuNrfQsn/ME+JqbJOfmhw62Ehbfgq4=;
	b=NwPt2/cREq8LR27Xzrti9JoEBpxpUoBsTZ7iLfSOoY8jfmPYk98UVgirtm4VbEEyCeZAld
	nd7aMOkNcQfkzYlilBHa6r2vgjCHswnDUnzniGN78tzxcT/kTOBSmHbX7j2kRe/wvwYcqX
	J9X8dupml7o/yr+G4/8qyW5I70xA8JuwbFRia0IkXoirZLX7wtLw9Z3m8Lk4axFoB9aGsh
	kDNc+yN7AVtLhQS5igHciWURVKqe502p3jjFuguY4kpcLh5ZgYZ7onAoaLnwBGgdHIhhBZ
	APJhWFmBZKmezGkEvb8rmEmmQRVMjfT07h9ZaTFjHq5batZ8BskLdOGNJ/ecOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XlLlE4+TmBUbjHuNrfQsn/ME+JqbJOfmhw62Ehbfgq4=;
	b=AmFBaDg0ggqIvE4SJHze+iHIii7cY1pLZV7gZFAsi7yX4t9l+f0xzpHgO5MQ5vE1MiEsWF
	wBWURfyM6o8aebBQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH tty v9 0/2] Convert 8250 to NBCON, take 2
Date: Fri, 24 Jul 2026 12:42:50 +0206
Message-ID: <20260724103654.133654-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v9 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v8 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

The changes since v8:

- In serial8250_suspend_port() and serial8250_resume_port(),
  acquire the port->lock using the _irq() variant instead of
  _irqsave() since these callbacks are always invoked from task
  context

- In serial8250_fifo_wait_for_lsr_thre(), enter and exit an
  unsafe section for each wait_for_lsr() in the loop since
  wait_for_lsr() uses serial_lsr_in(), which performs RMW
  updates to uart_8250_port->lsr_saved_flags. Without an unsafe
  section, a context could race with another higher priority
  context during the RMW update.

- Change single-sentence comments to not have a trailing period

John Ogness

[0] https://lore.kernel.org/lkml/20260722110925.74387-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  Revert "serial: 8250: drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  65 +++++++--
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 204 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 240 insertions(+), 51 deletions(-)


base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

