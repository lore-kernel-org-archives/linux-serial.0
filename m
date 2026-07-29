Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB129AB1A;
	Wed, 29 Jul 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326683; cv=none; b=FRt891T3PIz3P+MQr0fbrm8/jGOnKLtL9Ijd8rL6SY38dnsCetKKMr74k4b2RiTwzlCr8S99iMHXL40FMloqFFCoPjCzilkT6LZQWIM3mS2Z9EvDmeN8IT4Yw0O2f84EEsNXjIgNG8P7uyFz+1/l+pCMEJ6B88GQ4TIT7fP8P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326683; c=relaxed/simple;
	bh=0QZyc0qzYmO+4dITNXYqw4CCvP58n98O1cW6JqEQMVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zex8tf+E0jNnetxSzzkrgYgxSUfqCelTTWAFnMB+K6oaHaNUh2KWWNke+u/DR8vt8ojtxzqst55BtK+8oecqSLpOCtBtBoI8Jc5med2MKF9WhnyrfkolvrZOPIdltzsJjc0p+vXZIZAtVlDDjMJcqIupg6Hk2bwMZcz1BueVTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QOKXlXcR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwafFq/E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QOKXlXcR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwafFq/E"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785326680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsCbjrv/IXG8CsNJ6EQpd9RrwpIgkMskUxpGnEfYzoc=;
	b=QOKXlXcRPGts3TPe3eAAoOtvPhqLFdT3Z2NWAC+hvOd/tyOEWOSbwYfLY3qdaTUje5ove6
	yTE1tDaFhUAjCZTvQr8w0+LJoCWr6Yqs58NuXuRl/09KdoeNHpWuMN7I03FWJAXfI9VOAy
	BMthfATQHOI54JHUatcZkCQRBWWQDSM7UTiuOKK2a5EZC9t+rMQp8wtFklmg7wy6vwM/8G
	lXsLgy9d4oyeXNUT6p+0mBX6OjSS3yZOk55wG9Zgq/2PqNPeHg91PrsVEdgwC1v3PxUS/5
	1n8Ecq49GgZytPNKonGfUxr4AgmweuD4L/VrxhVMuqs1A9JGHIzab1QXBhqbvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785326680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EsCbjrv/IXG8CsNJ6EQpd9RrwpIgkMskUxpGnEfYzoc=;
	b=VwafFq/EBaEfp9+ob7k8I2bxrmuyp5CTf19P3lZZSV63UsH4qh8z8R8wAn6l2gVyUq4FgN
	rMHicESgjWiuqtAg==
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
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v11 0/2] Convert 8250 to NBCON, take 2
Date: Wed, 29 Jul 2026 14:10:32 +0206
Message-ID: <20260729120439.281252-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v11 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v10 of this series is here [0].

Note that v5 was pulled into the 6.14 merge window, but was
then reverted before the 6.14-rc1 release due to kernel test
robot problems. It turned out that the problems were related
to general 8250 driver issues. Those issues have now been
addressed mainline, paving the way for a second take at
converting the 8250 driver to NBCON.

The changes since v10:

- Change the main write functions to be helper functions:

  serial8250_console_fifo_write() -> __serial8250_console_fifo_write()
  serial8250_console_byte_write() -> __serial8250_console_byte_write()

  These functions take additional char array and size arguments for
  text to write. This allows the functions to be used for special
  text. In particular, writing the extra '\n' after a
  handover/takeover.

- Add new serial8250_console_fifo_write() and
  serial8250_console_byte_write() functions that are simple wrappers
  for the respective helpers.

- Add a __serial8250_console_write() function to handle calling the
  appropriate write functions for the various use_fifo/!use_fifo and
  console_line_ended/!console_line_ended scenarios. This not only
  fixes a possible FIFO overrun pointed out by Sashiko for the
  "use_fifo && !console_line_ended" case, but also also consolidates
  all the actual writing code into a single helper.

- Toggle unsafe after 2 potentially large delays in the post-write
  part of serial8250_console_write(). This reduces the likelihood of
  corruption in panic output by providing more points to recognize
  ownership transfer.

John Ogness

[0] https://lore.kernel.org/lkml/20260727145332.231949-1-john.ogness@linutronix.de

John Ogness (2):
  serial: 8250: Switch to nbcon console, take 2
  Revert "serial: 8250: drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  65 ++++++--
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 245 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 +-
 5 files changed, 277 insertions(+), 55 deletions(-)


base-commit: a5339effdd523b4b3502fba5358d44e83c76a565
-- 
2.47.3

