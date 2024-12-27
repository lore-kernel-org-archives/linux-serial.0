Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D580BFF;
	Fri, 27 Dec 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339532; cv=none; b=sZUQ7uqkpVHYywRbDYgMAUQ9X3fWRNVEqlCYYhxLusJNScHepQe5k2mg9P2wT8eBCPNyeA5G/fPc9EWYwZZteR70urvxa8eBdj9P1pqbg6pZ5dbft7eLX29nGo4bRQ4Ben+0gymnXu3H/JfzSf5Co2yHS581UMIIqH/1vUyq3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339532; c=relaxed/simple;
	bh=O33YSYtXgqXc0GtVduPaec6FhwXtK8kS8uZrc/TVatc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUB46EPRvlTaQSumywnSYbG+BOmANlXy2FCv9Yx08asS4H86V1UEEv489aKqiZCwXTd0a+IYXKFuCbHNqr0tO8JXAkSTvGpqtgdh+NVf1MkdwtlaLc7nQCPa7drsr0BBRMnOH7EwutZV+EP1fDdDl/gd3vel5WldUXFWVQYBVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yxy+X+LQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=coYk0RSi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yxy+X+LQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="coYk0RSi"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AU+OvOmPVS0Qfj6w2emgT2IVnoV9nyph0SjDWXQfu+k=;
	b=yxy+X+LQNTzces/KTsZ8rjBKxhO8UIC08KJByrPEqIIEVFjXbulBBvloejidTWtd7OYtzr
	lLsxGQNwADm2B5TlR0GOsiqLqcSC2/ymIt2wyNpY00mLgDt1u6RmHjcXSKJfAz7RuDA24L
	Z20ysMbPGpDGMgD28u43MJlLAWWdOW3AKBHd2+whubtlx4eGt9CoMOSR46So6qU9qZOm+l
	M6C16a2dxvi39tQT8agmzkygEmJXzRxyCFxwusd8xiELbwodG3LQjy76BpDN61FKDZ4e7i
	codwrS/t4oR8qiRvav97ioX+nV8l3XSzfMn901qOVcw+jJ4qVNphsUkEfTLB4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AU+OvOmPVS0Qfj6w2emgT2IVnoV9nyph0SjDWXQfu+k=;
	b=coYk0RSiNWl0CeOAXg0GxU63IELeK5oCDPQCfYG0iVFCYoluNCDxHPydMexRLPZv7b441l
	exTiXqRZK7P1y5AA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Matt Turner <mattst88@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH tty-next v4 0/6] convert 8250 to nbcon
Date: Fri, 27 Dec 2024 23:51:16 +0106
Message-Id: <20241227224523.28131-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of a series to convert the 8250 driver to an NBCON
console, providing both threaded and atomic printing
implementations. v3 of this series is here [0]. Additional
background information about NBCON consoles in general is
available in the cover letter of v2 [1].

The changes since v3:

- For callbacks ->rs485_stop_tx() and ->rs485_start_tx(),
  rename argument @in_con to @toggle_ier (inverts meaning).

- For univ8250_console_device_lock() and
  univ8250_console_device_unlock(), rename argument @con to @co.

- Do not introduce helpers __serial8250_stop_rx_mask_dr(),
  __serial8250_stop_rx_int(), __serial8250_start_rx_int().

- Use @frame_time to determine per-character timeout, fallback
  to 10ms if @frame_time not available.

- Use shorter code syntax when setting @console_line_ended.

- Introduce helper function fifo_wait_for_lsr() to wait for
  multiple characters.

- For serial8250_console_fifo_write() and
  serial8250_console_byte_write(), remove unnecessary
  READ_ONCE() usage.

- For serial8250_console_fifo_write() and
  serial8250_console_byte_write(), use nbcon_can_proceed()
  rather than repeatedly enter/exit unsafe regions.

- Initialize @modem_status_work using init_irq_work() rather
  than IRQ_WORK_INIT().

- Commit message and comment style cleanups as requested.

John Ogness

[0] https://lore.kernel.org/lkml/20241025105728.602310-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20240913140538.221708-1-john.ogness@linutronix.de

John Ogness (6):
  serial: 8250: Adjust the timeout for FIFO mode
  serial: 8250: Use frame rate to determine timeout
  serial: 8250: Use high-level writing function for FIFO
  serial: 8250: Provide flag for IER toggling for RS485
  serial: 8250: Switch to nbcon console
  serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()"

 drivers/tty/serial/8250/8250.h            |   4 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c |   4 +-
 drivers/tty/serial/8250/8250_core.c       |  35 +++-
 drivers/tty/serial/8250/8250_omap.c       |   2 +-
 drivers/tty/serial/8250/8250_port.c       | 223 +++++++++++++++++-----
 include/linux/serial_8250.h               |  12 +-
 6 files changed, 214 insertions(+), 66 deletions(-)


base-commit: 2c1fd53af21b8cb13878b054894d33d3383eb1f3
-- 
2.39.5

