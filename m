Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238A16BE33;
	Tue, 20 Aug 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135407; cv=none; b=G6NsFISwdh1pqyCmZxhasxSdIWhRSKxeO/iXi2lwgGqpkxFuEdenDjxV40WYt8EDHbSTDdJqAnGUe/9xewcP86v/9FxxwlukcE+5M69cta2RUvACL7HJke/Nk1jBUdow6Dx5FdZ8F2ssbA3fgpmYW61Zmp4VMNhu4f9RQU/R/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135407; c=relaxed/simple;
	bh=8oFbrSYGTGhZt5m85uZ8ee7tyGjdL/iH9l5SUZcF3Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fTBQmxbNeMwhRMRO1xm7a89Bqn7eslF6gP7D0aBO4t/7x6Qyiu4AaVt10VVqUX2mrBe3aH51Gg2qB+4o6ehxfFw5/xdB+8/MswEw5fQQ9yQVq/nFYPYtVWektzDTua9wzZj8zSnjYb2+zcYM9jx/9VUiv5H7qbJl58NPPmQXYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQE8zDvr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScEr4aXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQE8zDvr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScEr4aXP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m45s/Td4jR+0V/OeKstIC9euOEv681D5DpFPNTkkDUQ=;
	b=iQE8zDvrx30f5Ig7zHRlvAC4d4LsD8NSoWxuB+jB8Ol4+4Je64NDonQzMlxCOuIoKQX6RA
	eRfZR0L8yVklBCaTSYW8bb1Ox6RTccgiU2XW9+N3MzdL5cSfLnyOfdEhl6bcYNMWk8lgj7
	6DGWzUePIVJ4kWxZH3PkVZx3fTpMhxm/Mtx+NcCFbuZAboIPnE3dMv1wmO4kinLId97nP6
	LDUqCTvBm2wQpdbN1AvfiWFKjE5XUcFUph03lZ5iBTusy6lVlKAb5XO53ZDyqnUAruweY7
	3FD9WsIfgxkH4bybkaUCnzOQ52hQbTYPkTpfDQEu24oK7m66UiTnTNw44WLmvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m45s/Td4jR+0V/OeKstIC9euOEv681D5DpFPNTkkDUQ=;
	b=ScEr4aXP3RUmLO2CQuFB/YwTCd/yRpd2oxsavbDF/T0gSdrvvlJDmFTQ9UYSLmNo8BeaI7
	7vgqq+SWxyeWqBCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>,
	Feng Tang <feng.tang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH printk v8 00/35] wire up write_atomic() printing
Date: Tue, 20 Aug 2024 08:35:26 +0206
Message-Id: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v8 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v7 is here [0]. For information about the motivation
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

- Mark emergency sections. In these sections, every printk()
  call will attempt to directly flush to the consoles using the
  EMERGENCY priority.

This series does _not_ include threaded printing or nbcon
drivers. Those features will be added in separate follow-up
series.

The changes since v7:

- Change printk_get_console_flush_type() to set preferred flush
  types.

- Change printk_get_console_flush_type() to also check for
  legacy consoles before seting @legacy_direct.

- Change vprintk_emit() to hack the struct console_flush_type
  for LOGLEVEL_SCHED rather than using local variables.

- Change console_cpu_notify() to also flush nbcon atomic
  consoles.

- Remove unnecessary flush type check in
  nbcon_atomic_flush_pending_con(). It is not needed until the
  threaded series.

- Fix compiling issues related to @legacy_allow_panic_sync for
  !CONFIG_PRINTK.

John Ogness

[0] https://lore.kernel.org/lkml/20240804005138.3722656-1-john.ogness@linutronix.de
[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (30):
  printk: Add notation to console_srcu locking
  printk: nbcon: Consolidate alloc() and init()
  printk: nbcon: Clarify rules of the owner/waiter matching
  printk: nbcon: Remove return value for write_atomic()
  printk: nbcon: Add detailed doc for write_atomic()
  printk: nbcon: Add callbacks to synchronize with driver
  printk: nbcon: Use driver synchronization while (un)registering
  serial: core: Provide low-level functions to lock port
  serial: core: Introduce wrapper to set @uart_port->cons
  console: Improve console_srcu_read_flags() comments
  nbcon: Add API to acquire context for non-printing operations
  serial: core: Acquire nbcon context in port->lock wrapper
  printk: nbcon: Do not rely on proxy headers
  printk: Make console_is_usable() available to nbcon.c
  printk: Let console_is_usable() handle nbcon
  printk: Add @flags argument for console_is_usable()
  printk: nbcon: Add helper to assign priority based on CPU state
  printk: Track registered boot consoles
  printk: nbcon: Use nbcon consoles in console_flush_all()
  printk: Add is_printk_legacy_deferred()
  printk: nbcon: Flush new records on device_release()
  printk: Flush nbcon consoles first on panic
  printk: nbcon: Add unsafe flushing on panic
  printk: Avoid console_lock dance if no legacy or boot consoles
  printk: Track nbcon consoles
  printk: Coordinate direct printing in panic
  printk: Add helper for flush type logic
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
 include/linux/console.h             | 110 +++++-
 include/linux/printk.h              |  33 +-
 include/linux/serial_core.h         | 117 +++++-
 kernel/locking/lockdep.c            |  83 ++++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            | 137 ++++++-
 kernel/printk/nbcon.c               | 556 +++++++++++++++++++++++++---
 kernel/printk/printk.c              | 251 ++++++++++---
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  23 +-
 kernel/rcu/tree_exp.h               |   7 +
 kernel/rcu/tree_stall.h             |   9 +
 15 files changed, 1210 insertions(+), 151 deletions(-)


base-commit: bcc954c6caba01fca143162d5fbb90e46aa1ad80
-- 
2.39.2

