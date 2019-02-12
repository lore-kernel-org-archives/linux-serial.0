From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v1 14/25] printk: do boot_delay_msec inside printk_delay
Date: Tue, 12 Feb 2019 15:29:52 +0100
Message-ID: <20190212143003.48446-15-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Both functions needed to be called one after the other, so just
integrate boot_delay_msec into printk_delay for simplification.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ebd9aac06323..897219f34cab 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1453,6 +1453,21 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+int printk_delay_msec __read_mostly;
+
+static inline void printk_delay(int level)
+{
+	boot_delay_msec(level);
+	if (unlikely(printk_delay_msec)) {
+		int m = printk_delay_msec;
+
+		while (m--) {
+			mdelay(1);
+			touch_nmi_watchdog();
+		}
+	}
+}
+
 static void print_console_dropped(struct console *con, u64 count)
 {
 	char text[64];
@@ -1534,20 +1549,6 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 	}
 }
 
-int printk_delay_msec __read_mostly;
-
-static inline void printk_delay(void)
-{
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
-
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
-}
-
 /* FIXME: no support for LOG_CONT */
 #if 0
 /*
@@ -2506,10 +2507,8 @@ static int printk_kthread_func(void *data)
 		console_lock();
 		call_console_drivers(master_seq, ext_text,
 				     ext_len, text, len);
-		if (len > 0 || ext_len > 0) {
-			boot_delay_msec(msg->level);
-			printk_delay();
-		}
+		if (len > 0 || ext_len > 0)
+			printk_delay(msg->level);
 		console_unlock();
 	}
 
-- 
2.11.0
