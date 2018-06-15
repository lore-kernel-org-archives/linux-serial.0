From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 2/6] tty: add tty_port locking helpers
Date: Fri, 15 Jun 2018 18:39:15 +0900
Message-ID: <20180615093919.559-3-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

TTY port spin_lock is one of the locks that can cause a
printk-recursion deadlock, thus we need to lock it from
printk_safe context. E.g.

ioctl()
 tty_ioctl()
  spin_lock(&tty_port->lock)
   printk()
    call_console_drivers()
     foo_console_write()
      spin_lock(&uart_port->lock)
       tty_wakeup()
        spin_lock(&tty_port->lock)    << deadlock

This patch adds tty_port->lock helper macros which take care
of printk_safe context and redirect potentially unsafe printk()
calls to per-CPU buffers, which we flush later from safe a
context. The helper macros will turn the above mentioned deadlock
scenario into:

ioctl()
 tty_ioctl()
  printk_safe_enter()
   spin_lock(&tty_port->lock)
    printk()
     printk_safe_log_store()
      irq_work_queue()
   spin_unlock(&tty_port->lock)
  printk_safe_exit()

 IRQ
  printk_safe_flush_buffer()
   vprintk_deferred()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/tty.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e3978b00f..828f91ab680b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -252,6 +252,30 @@ struct tty_port {
 	void 			*client_data;
 };
 
+#define tty_port_lock_irq(lock)				\
+	do {						\
+		printk_safe_enter_irq();		\
+		spin_lock(lock);			\
+	} while (0)
+
+#define tty_port_unlock_irq(lock)			\
+	do {						\
+		spin_unlock(lock);			\
+		printk_safe_exit_irq();			\
+	} while (0)
+
+#define tty_port_lock_irqsave(lock, flags)		\
+	do {						\
+		printk_safe_enter_irqsave(flags);	\
+		spin_lock(lock);			\
+	} while (0)
+
+#define tty_port_unlock_irqrestore(lock, flags)		\
+	do {						\
+		spin_unlock(lock);			\
+		printk_safe_exit_irqrestore(flags);	\
+	} while (0)
+
 /* tty_port::iflags bits -- use atomic bit ops */
 #define TTY_PORT_INITIALIZED	0	/* device is initialized */
 #define TTY_PORT_SUSPENDED	1	/* device is suspended */
-- 
2.17.1
