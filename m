Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBB2030B;
	Mon, 27 May 2024 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791900; cv=none; b=LlDVSEh5FdDKd4eVvSHKRpzhX135ZnQ6+PHb5xSU72x/OlYiJo6Lz4njCUfb26GsQY307GxieMIVpDKdrVFSaNIOZcr85peSF9676GZVZx9MKd0CLzzBjQ08cHV5pudfOe63xC5Ismgm82HWACBFpvZUlZQABBZH+FgK0t1EtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791900; c=relaxed/simple;
	bh=HAyKOh+NXTadzGoMJcYVzr6NcwccoLiWOrt7fHRczrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iE/8koUpyqhwS1TdfMVkO9msHTt/f8nq5Uqps90OfSkMmyhmpVpmiEpqAdItpxJ+vcNR3oleUeMxteA9R92EMnobM/iE5HxOy5giw38/qA4mT698ueBk/58rEgAcbBRnChiCDtLGdcONX6jdS6KdEsu7itWm3BpT58RF5lFz0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgsDt2AV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nzrh18+g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgsDt2AV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nzrh18+g"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnQvw5hbKGPn5hbjOpZYiGZWbU7Q2jFjvPJ2T+zTaAs=;
	b=bgsDt2AVFR9ZN6vU2R2BMA2SE44w8iH215AjE26rORTHWntjLadAaajvkQzQjvEz7Vrjc9
	0H/x2AsgefwmRmsfmuNFiaAJ88Bp1MeREOHXPTroQdvLoO4Dlzgf1SMekOoj310DWhC11a
	jEUxQ7RqYcjox2mgbB29rpCyWB6E7DYG+T/q64SFbvSle3xcDhAzsLATZd81WCMkdurQPH
	nijiHwp3aV1fCkwUpIKZXZF9+x0YbyNoZFsPYIXhVTdfLVVDCo9NRQkv5yRQKqi8+CB2Tv
	MBawCdz+/NIHRvYZ8meucLv6WLcPWKUhGskYAppQkH3KVjdVtdTIbne2FjucTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AnQvw5hbKGPn5hbjOpZYiGZWbU7Q2jFjvPJ2T+zTaAs=;
	b=Nzrh18+gGFfABUMUXKLvVSYmeHG/Yd23orl7BtSdGKuLXKDjQ8udE+DHKMfZ/ZxtnBu0Lj
	fMqi4uwH7LWWecDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fabio Estevam <festevam@denx.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH printk v6 00/30] wire up write_atomic() printing
Date: Mon, 27 May 2024 08:43:19 +0206
Message-Id: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v6 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v5 is here [0]. For information about the motivation
of the atomic consoles, please read the cover letter of v1 [1].

The main focus of this series:

- For nbcon consoles, always call write_atomic() directly from
  printk() caller context for the panic CPU.

- For nbcon consoles, call write_atomic() when unlocking the
  console lock.

- Only perform the console lock/unlock dance if legacy or boot
  consoles are registered.

- For legacy consoles, if nbcon consoles are registered, do not
  attempt to print from printk() caller context for the panic
  CPU until nbcon consoles have had a chance to print the most
  significant messages.

- Mark emergency sections. In these sections printk() calls
  will only store the messages. Upon exiting the emergency
  section, nbcon consoles are flushed directly. If legacy
  consoles cannot be flushed safely, an irq_work is triggered
  to do the legacy console flushing.

This series does _not_ include threaded printing or nbcon
drivers. Those features will be added in separate follow-up
series.

Note: With this series, a system with _only_ nbcon consoles
      registered will not perform console printing unless the
      console lock or nbcon port lock are used or on panic.
      This is on purpose. When nbcon kthreads are introduced,
      they will fill the gaps.

The changes since v5:

- In struct console, rename @nbcon_driver_ctxt to
  @nbcon_device_ctxt.

- Rename nbcon_driver_try_acquire() to
  nbcon_device_try_acquire().

- Rename nbcon_driver_release() to nbcon_device_release().

- Implement a helper function is_printk_deferred() for use in
  nbcon_cpu_emergency_exit(), nbcon_cpu_emergency_flush(),
  vprintk().

- In nbcon_cpu_emergency_exit(), for legacy consoles, try to
  flush directly if safe. If legacy flushing directly was
  successful, do not trigger the irq_work.

- In nbcon_cpu_emergency_exit(), do not decrement
  @cpu_emergency_nesting if it is zero (and WARN_ON_ONCE in
  this case).

- For register_console() and unregister_console_locked(), use a
  local variable @use_device_lock to track if locking is used
  so that the compiler knows that the lock and unlock match.

- For synchronize_rcu_expedited_wait(), move the
  nbcon_cpu_emergency_flush() after dump_cpu_task().

- Refactor nbcon_atomic_flush_pending_con() as suggested by
  pmladek. No functional change.

- Update various comments as suggested by pmladek.

- In nbcon_device_try_acquire(), add missing kerneldoc for the
  return value.

John Ogness

[0] https://lore.kernel.org/lkml/20240502213839.376636-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (25):
  printk: Add notation to console_srcu locking
  printk: nbcon: Remove return value for write_atomic()
  printk: nbcon: Add detailed doc for write_atomic()
  printk: nbcon: Add callbacks to synchronize with driver
  printk: nbcon: Use driver synchronization while (un)registering
  serial: core: Provide low-level functions to lock port
  serial: core: Introduce wrapper to set @uart_port->cons
  console: Improve console_srcu_read_flags() comments
  nbcon: Add API to acquire context for non-printing operations
  serial: core: Implement processing in port->lock wrapper
  printk: nbcon: Do not rely on proxy headers
  printk: nbcon: Fix kerneldoc for enums
  printk: Make console_is_usable() available to nbcon
  printk: Let console_is_usable() handle nbcon
  printk: Add @flags argument for console_is_usable()
  printk: nbcon: Add helper to assign priority based on CPU state
  printk: Track registered boot consoles
  printk: nbcon: Use nbcon consoles in console_flush_all()
  printk: nbcon: Add unsafe flushing on panic
  printk: Avoid console_lock dance if no legacy or boot consoles
  printk: Track nbcon consoles
  printk: Coordinate direct printing in panic
  panic: Mark emergency section in oops
  rcu: Mark emergency sections in rcu stalls
  lockdep: Mark emergency sections in lockdep splats

Petr Mladek (1):
  printk: Properly deal with nbcon consoles on seq init

Sebastian Andrzej Siewior (1):
  printk: Check printk_deferred_enter()/_exit() usage

Thomas Gleixner (3):
  printk: nbcon: Provide function to flush using write_atomic()
  printk: nbcon: Implement emergency sections
  panic: Mark emergency section in warn

 drivers/tty/serial/8250/8250_core.c |   6 +-
 drivers/tty/serial/amba-pl011.c     |   2 +-
 drivers/tty/serial/serial_core.c    |  16 +-
 include/linux/console.h             | 116 ++++++-
 include/linux/printk.h              |  33 +-
 include/linux/serial_core.h         | 117 ++++++-
 kernel/locking/lockdep.c            |  84 ++++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            |  73 +++-
 kernel/printk/nbcon.c               | 506 +++++++++++++++++++++++++++-
 kernel/printk/printk.c              | 307 +++++++++++++----
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  23 +-
 kernel/rcu/tree_exp.h               |   9 +
 kernel/rcu/tree_stall.h             |  11 +
 15 files changed, 1181 insertions(+), 133 deletions(-)


base-commit: 596ffa476e201ecbf7ea024f1b59d4f28e91060c
-- 
2.39.2

