Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DA3CF211;
	Mon, 20 Jul 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543567; cv=none; b=EgZ0tlZ+u0iKrGBqjf5s9LGqn+u1kc/rtpsTTAoQhK4rjLUWItHNagPlhVmBIBfA2S1Hf/LyD1iJ7zWJpGfmEoIICv9nEuBPAQu4vZ10rWZ+AYMcuVJCJa0EDJNVidhsiCWFKc6XilC4Ctt6LLS3XWXxH7U7xZ6tp3Rs1YD6xlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543567; c=relaxed/simple;
	bh=UOjgz6+9TGtUXH39/Uem4K5kk8OKANFor2MvY43QKSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyE7Kn602lvp6EtJ7lZmmECsItfPGADd4Cbc5pN4r6RvbWq/UolcJ2pLZcy7z6CVxeDeBrQCn7HkBeZmyQ7XvEUKE9Tyx7SayTlQfyogXLcRbMwkajtgzalyL6679RhQyZ5UcnSBkQAibeMI/5+uEY50w7irv+MeK+9YCDSwCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tp6kD4ly; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWrpo4Jq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tp6kD4ly";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWrpo4Jq"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784543563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ALuNWnUOVvbjmf6kKTFj5ji5TEua2m8J7YFC0xbHMs=;
	b=Tp6kD4lyNtTSxuFPmcNqYnL8xx4sViSCcp9sW0ovuOwmXJxlBCXqtns57WUUHaHUifmwNl
	S7EdTVtp38CE49e1H2euNS1SM7GcBRecxsXKpdDJP62UHAPMJjkb2i07jhPTS1KoHzIBVh
	tKCWN2O4XeNiXSh+xHEV6rJIKpj0MCzIdUMOMXxl8OuqJcQsZm6G+wr+JGYmSM8VVrkCxl
	k5SRFTp7ektl4gjt4QROkmYD8s5K833qvq3qOlujWGNzTtRdLnucp61K3wmC0A3hoxEfJd
	bV3mOo7gm8nJ8rUoHz8fX/BiloL9F5K/JcrQmK9pqFLjOVkamD+Km6xaI3yGdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784543563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ALuNWnUOVvbjmf6kKTFj5ji5TEua2m8J7YFC0xbHMs=;
	b=FWrpo4Jqx5qo3vWOBQL2Kp3TaVOtfI4+k+cH+5nD1+d/jmGKl7MTVbt/m5bH7PhnkI5fkb
	cJqQyG0xbdNGyEBQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH tty v6 0/2] Convert 8250 to NBCON, take 2
Date: Mon, 20 Jul 2026 12:38:34 +0206
Message-ID: <20260720103242.7265-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v6 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v5 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

This time we have Sashiko, which is sure to provide some
insights that we oversaw with v5.

The changes since v5:

- A new @avoid_modem_status_work field is added to struct
  uart_8250_port in order to avoid handling modem control
  during the suspend/resume window.

- Handle any pending modem control on resume.

- Allow serial8250_fifo_wait_for_lsr_thre() to be called
  with wctxt=NULL since the helper is now used in
  dw8250_idle_enter().

John Ogness

[0] https://lore.kernel.org/lkml/20250107212702.169493-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  44 ++++++-
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 193 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 216 insertions(+), 43 deletions(-)


base-commit: 782f4dbd1794b4f30dc116a7ca42c5962c409be8
-- 
2.47.3

