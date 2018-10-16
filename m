From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk header
Date: Tue, 16 Oct 2018 14:04:26 +0900
Message-ID: <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make printk_safe_enter_irqsave()/etc macros available to the
rest of the kernel.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 include/linux/printk.h      | 40 +++++++++++++++++++++++++++++++++++++
 kernel/printk/internal.h    | 37 ----------------------------------
 kernel/printk/printk_safe.c |  6 ++++--
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccfe1543..75f99441fd54 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,6 +157,46 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+#ifdef CONFIG_PRINTK
+extern void printk_safe_enter(void);
+extern void printk_safe_exit(void);
+
+#define printk_safe_enter_irqsave(flags)	\
+	do {					\
+		local_irq_save(flags);		\
+		printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irqrestore(flags)	\
+	do {					\
+		printk_safe_exit();		\
+		local_irq_restore(flags);	\
+	} while (0)
+
+#define printk_safe_enter_irq()		\
+	do {					\
+		local_irq_disable();		\
+		printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irq()			\
+	do {					\
+		printk_safe_exit();		\
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
index 0f1898820cba..03c10f361a15 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -32,32 +32,6 @@ int vprintk_store(int facility, int level,
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
 
 void defer_console_output(void);
 
@@ -65,15 +39,4 @@ void defer_console_output(void);
 
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
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 0913b4d385de..367fcb2c39f0 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -359,16 +359,18 @@ static __printf(1, 0) int vprintk_safe(const char *fmt, va_list args)
 }
 
 /* Can be preempted by NMI. */
-void __printk_safe_enter(void)
+void printk_safe_enter(void)
 {
 	this_cpu_inc(printk_context);
 }
+EXPORT_SYMBOL_GPL(printk_safe_enter);
 
 /* Can be preempted by NMI. */
-void __printk_safe_exit(void)
+void printk_safe_exit(void)
 {
 	this_cpu_dec(printk_context);
 }
+EXPORT_SYMBOL_GPL(printk_safe_exit);
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
-- 
2.19.1
