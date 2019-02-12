From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v1 13/25] printk: track seq per console
Date: Tue, 12 Feb 2019 15:29:51 +0100
Message-ID: <20190212143003.48446-14-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Allow each console to track which seq record was last printed. This
simplifies identifying dropped records.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 30 +++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..7fa06a058339 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -153,6 +153,7 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
+	unsigned long printk_seq;
 	void	*data;
 	struct	 console *next;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ece54c24ea0d..ebd9aac06323 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1453,6 +1453,16 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+static void print_console_dropped(struct console *con, u64 count)
+{
+	char text[64];
+	int len;
+
+	len = sprintf(text, "** %llu printk message%s dropped **\n",
+		      count, count > 1 ? "s" : "");
+	con->write(con, text, len);
+}
+
 static void format_text(struct printk_log *msg, u64 seq,
 			char *ext_text, size_t *ext_len,
 			char *text, size_t *len, bool time)
@@ -1486,7 +1496,7 @@ static void format_text(struct printk_log *msg, u64 seq,
  * log_buf[start] to log_buf[end - 1].
  * The console_lock must be held.
  */
-static void call_console_drivers(const char *ext_text, size_t ext_len,
+static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 				 const char *text, size_t len)
 {
 	struct console *con;
@@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		if (!cpu_online(raw_smp_processor_id()) &&
 		    !(con->flags & CON_ANYTIME))
 			continue;
+		if (con->printk_seq >= seq)
+			continue;
+
+		con->printk_seq++;
+		if (con->printk_seq < seq) {
+			print_console_dropped(con, seq - con->printk_seq);
+			con->printk_seq = seq;
+		}
+
+		/* for supressed messages, only seq is updated */
+		if (len == 0 && ext_len == 0)
+			continue;
+
 		if (con->flags & CON_EXTENDED)
 			con->write(con, ext_text, ext_len);
 		else
@@ -1738,7 +1761,7 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
 static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *dict, size_t dict_len,
 				  char *text, size_t text_len) { return 0; }
-static void call_console_drivers(const char *ext_text, size_t ext_len,
+static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
@@ -2481,8 +2504,9 @@ static int printk_kthread_func(void *data)
 			    &len, printk_time);
 
 		console_lock();
+		call_console_drivers(master_seq, ext_text,
+				     ext_len, text, len);
 		if (len > 0 || ext_len > 0) {
-			call_console_drivers(ext_text, ext_len, text, len);
 			boot_delay_msec(msg->level);
 			printk_delay();
 		}
-- 
2.11.0
