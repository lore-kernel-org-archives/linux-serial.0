From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 1/6] printk: move printk_safe macros to printk header
Date: Fri, 15 Jun 2018 18:39:14 +0900
Message-ID: <20180615093919.559-2-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make printk_safe_enter_irqsave()/etc macros available to the
rest of the kernel, so we can use them in TTY and UART code.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/printk.h   | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h | 37 -------------------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800affd8..8b4e1e667919 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -153,6 +153,46 @@ static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
 #endif /* PRINTK_NMI */
 
+#ifdef CONFIG_PRINTK
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+
+#define printk_safe_enter_irqsave(flags)	\
+	do {					\
+		local_irq_save(flags);		\
+		__printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irqrestore(flags)	\
+	do {					\
+		__printk_safe_exit();		\
+		local_irq_restore(flags);	\
+	} while (0)
+
+#define printk_safe_enter_irq()		\
+	do {					\
+		local_irq_disable();		\
+		__printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irq()			\
+	do {					\
+		__printk_safe_exit();		\
+		local_irq_enable();		\
+	} while (0)
+#else
+/*
+ * On !PRINTK builds we still export console output related locks
+ * and some functions (console_unlock()/tty/etc.), so printk-safe
+ * must preserve the existing local IRQ guarantees.
+ */
+#define printk_safe_enter_irqsave(flags) local_irq_save(flags)
+#define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
+
+#define printk_safe_enter_irq() local_irq_disable()
+#define printk_safe_exit_irq() local_irq_enable()
+#endif
+
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a7d04049af4..cf4f85e53cc2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -27,46 +27,9 @@ extern raw_spinlock_t logbuf_lock;
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
-void __printk_safe_enter(void);
-void __printk_safe_exit(void);
-
-#define printk_safe_enter_irqsave(flags)	\
-	do {					\
-		local_irq_save(flags);		\
-		__printk_safe_enter();		\
-	} while (0)
-
-#define printk_safe_exit_irqrestore(flags)	\
-	do {					\
-		__printk_safe_exit();		\
-		local_irq_restore(flags);	\
-	} while (0)
-
-#define printk_safe_enter_irq()		\
-	do {					\
-		local_irq_disable();		\
-		__printk_safe_enter();		\
-	} while (0)
-
-#define printk_safe_exit_irq()			\
-	do {					\
-		__printk_safe_exit();		\
-		local_irq_enable();		\
-	} while (0)
 
 #else
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
 
-/*
- * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
- * semaphore and some of console functions (console_unlock()/etc.), so
- * printk-safe must preserve the existing local IRQ guarantees.
- */
-#define printk_safe_enter_irqsave(flags) local_irq_save(flags)
-#define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
-
-#define printk_safe_enter_irq() local_irq_disable()
-#define printk_safe_exit_irq() local_irq_enable()
-
 #endif /* CONFIG_PRINTK */
-- 
2.17.1
