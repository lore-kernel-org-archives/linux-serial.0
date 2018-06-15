From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 4/6] serial: add uart port locking helpers
Date: Fri, 15 Jun 2018 18:39:17 +0900
Message-ID: <20180615093919.559-5-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

UART port spin_lock is one of the locks that can cause a
printk-recursion deadlock, thus we need to lock it from
printk_safe context. An example of a possible deadlock:

   IRQ
   foo_console_handle_IRQ()
    spin_lock(&uart_port->lock)
     tty_wakeup()
      printk()
       call_console_drivers()
        foo_console_write()
         spin_lock(&uart_port->lock)  << deadlock

This patch adds uart_port->lock helper macros which take care
of printk_safe context and redirect potentially unsafe printk()
calls to per-CPU buffers, which we flush later from safe a
context. The helper macros will turn the above mentioned deadlock
scenario into:

   IRQ
   foo_console_handle_IRQ()
    printk_safe_enter()
    spin_lock(&uart_port->lock)
     tty_wakeup()
      printk()
       printk_safe_log_store()
        irq_work_queue()
    spin_unlock(&uart_port->lock)
    printk_safe_exit()
   iret

   IRQ
    printk_safe_flush_buffer()
     vprintk_deferred()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/serial_core.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 06ea4eeb09ab..deb464520946 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -256,6 +256,41 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+#define uart_port_lock_irq(lock)				\
+	do {							\
+		printk_safe_enter_irq();			\
+		spin_lock(lock);				\
+	} while (0)
+
+#define uart_port_unlock_irq(lock)				\
+	do {							\
+		spin_unlock(lock);				\
+		printk_safe_exit_irq();				\
+	} while (0)
+
+#define uart_port_lock_irqsave(lock, flags)			\
+	do {							\
+		printk_safe_enter_irqsave(flags);		\
+		spin_lock(lock);				\
+	} while (0)
+
+#define uart_port_trylock_irqsave(lock, flags)			\
+	({							\
+		int locked;					\
+								\
+		printk_safe_enter_irqsave(flags);		\
+		locked = spin_trylock(lock);			\
+		if (!locked)					\
+			printk_safe_exit_irqrestore(flags);	\
+		locked;						\
+	})
+
+#define uart_port_unlock_irqrestore(lock, flags)		\
+	do {							\
+		spin_unlock(lock);				\
+		printk_safe_exit_irqrestore(flags);		\
+	} while (0)
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.17.1
