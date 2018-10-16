From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCHv2 3/4] serial: introduce uart_port locking helpers
Date: Tue, 16 Oct 2018 14:04:27 +0900
Message-ID: <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

The patch introduces several macros which should make serial console
drivers less printk() deadlock prone.

There are several console driver entry points so we are looking at
several slightly different deadlock scenarios.

- The first entry point is console ->write() callback, which we call
  from printk(). A possible deadlock scenario there is:

  CPU0
	<NMI>
	spin_lock_irqsave(&port->lock, flags)      << deadlock
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	console_flush_on_panic()
	panic()
	<NMI/>
	spin_lock_irqsave(&port->lock, flags)
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	printk()
	...

  ->write() callback, generally speaking, must be re-entrant in two cases:
   1) sysrq
   2) panic (oops_in_progress)

  And this is what uart_port_lock_for_printk()/uart_port_unlock_after_printk()
  macros are for.

  Usage example:

	static serial_foo_write(...)
	{
		struct uart_port *port;
		unsigned long flags;
		bool locked;

		uart_port_lock_for_printk(port, flags, locked);
		uart_console_write(port, s, count, serial_foo_putchar);
		uart_port_unlock_after_printk(port, flags, locked);
	}

  Some of the serial drivers already use _some sort_ of
  uart_port_lock_for_printk(), some are not panic() re-entrant. This
  should address the issue.

- The rest (of entry points) requires a bit different handling.
  Let's take a look at the following backtrace:

  	CPU0
	<IRQ>
	spin_lock_irqsave(&port->lock, flags)      << deadlock
	serial_foo_write()
	call_console_drivers()
	console_unlock()
	printk()
	__queue_work()
	tty_flip_buffer_push()
	spin_lock_irqsave(&port->lock, flags)
	serial_foo_handle_IRQ()
	<IRQ/>

  Serial drivers invoke tons of core kernel functions - WQ, MM, etc. All
  of which may printk() in various cases. So we can't really just
  "remove those printk-s". The simples way to address this seems to be
  PRINTK_SAFE_CONTEXT_MASK.

  printk_safe() is a special printk() mode, which redirects recursive
  printk()-s to a secondary (per-CPU) buffer; so we don't re-enter
  printk() and serial console driver. The secondary (per-CPU) buffer is
  flushed and printed to the consoles later, from a safe context, when
  we know that we are not in printk()-recursion anymore.

  And this is what uart_port_lock_*()/uart_port_unlock_*() macros are
  for. With uart_port_lock_irqsave() the previous example would turn
  into:

	CPU0
	<IRQ>
	irq_work_queue()
	printk_safe_log_store()
	printk()
	__queue_work()
	tty_flip_buffer_push()
	uart_port_lock_irqsave(port, flags)
	serial_foo_handle_IRQ()
	<IRQ/>

  As of now, no consoles are re-entrant when printk() initiated by
  console's driver IRQ handler. This macro should address the issue.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/serial_core.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 047fa67d039b..acc6966fea8e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -266,6 +266,54 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+#define uart_port_lock_irq(p)						\
+	do {								\
+		printk_safe_enter_irq();				\
+		spin_lock(&(p)->lock);					\
+	} while (0)
+
+#define uart_port_unlock_irq(p)					\
+	do {								\
+		spin_unlock(&(p)->lock);				\
+		printk_safe_exit_irq();					\
+	} while (0)
+
+#define uart_port_lock_irqsave(p, flags)				\
+	do {								\
+		printk_safe_enter_irqsave(flags);			\
+		spin_lock(&(p)->lock);					\
+	} while (0)
+
+#define uart_port_unlock_irqrestore(p, flags)				\
+	do {								\
+		spin_unlock(&(p)->lock);				\
+		printk_safe_exit_irqrestore(flags);			\
+	} while (0)
+
+#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
+#define uart_port_in_sysrq(p)		p->sysrq
+#else
+#define uart_port_in_sysrq(p)		0
+#endif
+
+#define uart_port_lock_for_printk(p, flags, locked)			\
+	do {								\
+		locked = true;						\
+		if (uart_port_in_sysrq(p))				\
+			locked = false;					\
+		else if (oops_in_progress)				\
+			locked = spin_trylock_irqsave(&(p)->lock,	\
+						      flags);		\
+		else							\
+			spin_lock_irqsave(&(p)->lock, flags);		\
+	} while (0)
+
+#define uart_port_unlock_after_printk(p, flags, locked)		\
+	do {								\
+		if (locked)						\
+			spin_unlock_irqrestore(&(p)->lock, flags);	\
+	} while (0)
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.19.1
