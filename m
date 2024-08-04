Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB8A2A;
	Sun,  4 Aug 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732709; cv=none; b=ltjOuQnieX/jcLX3/qGxFlrpRnCj8dd9c9rArW5qL/m6vToKYxPUXqerJMprtzBw39XEL2+cJmDWUpSV9iBytjAOoM/0Qfxa/GTdM1GlTOLiw/DLh/8zrLZago51PRoR6RzFA7jFIeNnlUmHP/x4FCR6ABfi009qgsr0/U1IY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732709; c=relaxed/simple;
	bh=BElM5kN4NGcPM6CIbpKvwy3muagmkVeZTOOo4gZkdzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=h1+Nn2NXn+HGLbHlqu5K4vzh9CYfFsHMwL5tN9vIgJcb49iRK+oPIDnp3M1AcEEfaCQkBdLAGAEpwceAD9QYqwiuDYp4dS3C63QyKgtxYO7dWyBjlJUK13nJ+5hOZhvvlyRGsv9blDzZNK9vQtOMReuBMS58Yi3MK7OhAlh5zGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vn9Sgbe+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BJemqaWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vn9Sgbe+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BJemqaWo"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XTIdufvm6rkgNOfIjWBy6iG2aYC9jWJdtdOC9sZs9Zg=;
	b=Vn9Sgbe+p35tZSmGeTuTz52Z6yOHhsFLeUTJAK15GUQJqVkkHjn9vwgNLxgFkcQKXzYXt3
	t2sAxAoiDvUQKQD+NUhFljYvQErdo9T07WkbrQCSMmZs2p2yP0RONPvGLtOk7lxaPWU+Pe
	E05qDDMtHR0LKOkMGcB8Yxge8s+VpH9uly/G498fSndh4Oy0A0C29S/T2ABRu38xWpqcNn
	TLxNGP4DlpPINnbP71whVJWFd2me/l4F8mkZAqtSWlom5T/E4mbAxW/366Zd4XsCjCGOWt
	3hQ0+3s60O0tFNI8EIsB5CkrALfBZeHEIXqhPZ+6G0GLpNI/CaHDiWpALji5dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XTIdufvm6rkgNOfIjWBy6iG2aYC9jWJdtdOC9sZs9Zg=;
	b=BJemqaWofWYkWVNno/Mt7ZiS9edxmbIUpZfC4SjSsv94WFqyHImNljYP5sPt/M/SxPqgJA
	xS3vyRgCQ/PdBkDQ==
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
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Joel Granados <j.granados@samsung.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
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
Subject: [PATCH printk v7 00/35] wire up write_atomic() printing
Date: Sun,  4 Aug 2024 02:57:03 +0206
Message-Id: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v7 of a series to wire up the nbcon consoles so that
they actually perform printing using their write_atomic()
callback. v6 is here [0]. For information about the motivation
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

The changes since v6:

- When a CPU is in an emergency state, printk() calls will now
  flush directly to all consoles using the EMERGENCY priority.

- Remove usage and implementation of
  nbcon_cpu_emergency_flush().

- Add printk_get_console_flush_type() to query available flush
  types and use it at all flushing call sites.

- In vprintk_emit(), always use nbcon_atomic flushing if it is
  available.

- When exiting nbcon_device_release(), flush using the legacy
  loop if nbcon_atomic flushing is not available.

- In console_flush_on_panic(), make sure nbcon_atomic flushing
  is allowed before flushing.

- In pr_flush(), always take the console_lock because there is
  no synchronization against register_console() and legacy
  consoles could register while waiting.

- In __wake_up_klogd(), remove check if PENDING_OUTPUT is
  needed. If PENDING_OUTPUT is set, it is needed.

- Rename is_printk_deferred() to is_printk_legacy_deferred().

- Remove nbcon_init(), consolidate it into nbcon_alloc().

- Improve documentation about nbcon owner/waiter matching
  rules.

- Allow nbcon_get_cpu_emergency_nesting() to run without
  migration disabled.

- Clarify that nbcon_get_default_prio() can run without
  migration disabled.

John Ogness

[0] https://lore.kernel.org/lkml/20240527063749.391035-1-john.ogness@linutronix.de
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
 kernel/locking/lockdep.c            |  83 +++-
 kernel/panic.c                      |   9 +
 kernel/printk/internal.h            | 130 ++++++-
 kernel/printk/nbcon.c               | 565 +++++++++++++++++++++++++---
 kernel/printk/printk.c              | 250 +++++++++---
 kernel/printk/printk_ringbuffer.h   |   2 +
 kernel/printk/printk_safe.c         |  23 +-
 kernel/rcu/tree_exp.h               |   7 +
 kernel/rcu/tree_stall.h             |   9 +
 15 files changed, 1211 insertions(+), 151 deletions(-)


base-commit: 8bf100092d60bf586bbc1a3a2cd833bb212d9d53
-- 
2.39.2

