Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC240DB5D;
	Mon, 27 Jul 2026 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164016; cv=none; b=kT3py6a+FmM0AjWppzebstUHKeCpTy6Bvcgxu64SDyN0j/Wwty1LznEsrWpv9UHp+YYipLSz5RkoFtPdwwDEb4PfIMBN6I3qxQngeYpHsSi4Cf1qmL6xJRlmjIIRJo2/36WyZH5Gu8gpoPra0051M+AFKG5MYWlhRJstWKelAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164016; c=relaxed/simple;
	bh=sQ5lhq4RubF2RvFNlWVFfUt6fmxCekEgrr+/M2u+Ais=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCVPurXOk4SmvS2tTHhpj8A8xhdAQSQnqYiBCciEiBvzzyK4WsXWJY26hAATzIUX1lreLHqn14YjmEl3ZBO01364zxYGWbib96tfHbi8h+E6pUfnr87qgtAsXS3fSusx43TrQClW8xF5MT2cRLXEVr8dfvMOmA8NPzNjNnYI/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4cwZuge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAIDBxaM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4cwZuge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAIDBxaM"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785164012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fK+jiQ+0oqZHo2G4nOKhBwsrgQBQ7GEeqnc1zUtiBB8=;
	b=I4cwZugeFnFF37tpVKi+gWhh9OgV+XYtnxfeTWZJ+kBQeYk1dBKTP+UqMcF/aFnxHiNdt4
	2PIygniIF52XzSh7MI2BbRN3IKnYvPYGMZeQy2T9Xt1lwG8mXhd6Irs+ELj01zlsw8k9Wq
	gucWwpVMFwD3aV90NkIEx4Z7bUxvXdbuj/U+6n9dABQH+tiSfetdrPMNHa8J/fqajxZJT2
	VGO/GiwSSQsWW0vrp/9nDyiHhfqX/nBeOoc82UpX5bEAV4mUkTCVVOUJXW3bhb4D1Ff5vy
	o5lBGIuZ6QDU2g2oMgpdHn4kjQmDVfozAJYQ5oDXKHV0AxDEoWAtS+l8ILU97A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785164012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fK+jiQ+0oqZHo2G4nOKhBwsrgQBQ7GEeqnc1zUtiBB8=;
	b=lAIDBxaMaVv0Eh1oTVIpewQd1iT7RFrRS/WmVr3LUBzpsJaAp7pBgD18r7YChEv8+IEs2l
	q3MbDgftN3QdK8Dg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Jacques Nilo <jnilo@free.fr>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	linux-serial@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH tty v10 0/2] Convert 8250 to NBCON, take 2
Date: Mon, 27 Jul 2026 16:59:18 +0206
Message-ID: <20260727145332.231949-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v10 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v9 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

The changes since v9:

- In serial8250_fifo_wait_for_lsr_thre(), always exit the
  unsafe section, regardless of wait_for_lsr() results.

John Ogness

[0] https://lore.kernel.org/lkml/20260724103654.133654-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  Revert "serial: 8250: drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  65 +++++++--
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 210 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 245 insertions(+), 52 deletions(-)


base-commit: a5339effdd523b4b3502fba5358d44e83c76a565
-- 
2.47.3

