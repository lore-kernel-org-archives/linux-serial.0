From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v1 15/25] printk: print history for new consoles
Date: Tue, 12 Feb 2019 15:29:53 +0100
Message-ID: <20190212143003.48446-16-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

When new consoles register, they currently print how many messages
they have missed. However, many (or all) of those messages may still
be in the ring buffer. Add functionality to print as much of the
history as available. This is a clean replacement of the old
exclusive console hack.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 7fa06a058339..633fb741e871 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -154,6 +154,7 @@ struct console {
 	short	index;
 	int	cflag;
 	unsigned long printk_seq;
+	int	wrote_history;
 	void	*data;
 	struct	 console *next;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 897219f34cab..6c875abd7b17 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1506,6 +1506,77 @@ static void format_text(struct printk_log *msg, u64 seq,
 	}
 }
 
+static void printk_write_history(struct console *con, u64 master_seq)
+{
+	struct prb_iterator iter;
+	bool time = printk_time;
+	static char *ext_text;
+	static char *text;
+	static char *buf;
+	u64 seq;
+
+	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
+	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!ext_text || !text || !buf)
+		return;
+
+	if (!(con->flags & CON_ENABLED))
+		goto out;
+
+	if (!con->write)
+		goto out;
+
+	if (!cpu_online(raw_smp_processor_id()) &&
+	    !(con->flags & CON_ANYTIME))
+		goto out;
+
+	prb_iter_init(&iter, &printk_rb, NULL);
+
+	for (;;) {
+		struct printk_log *msg;
+		size_t ext_len;
+		size_t len;
+		int ret;
+
+		ret = prb_iter_next(&iter, buf, PRINTK_RECORD_MAX, &seq);
+		if (ret == 0) {
+			break;
+		} else if (ret < 0) {
+			prb_iter_init(&iter, &printk_rb, NULL);
+			continue;
+		}
+
+		if (seq > master_seq)
+			break;
+
+		con->printk_seq++;
+		if (con->printk_seq < seq) {
+			print_console_dropped(con, seq - con->printk_seq);
+			con->printk_seq = seq;
+		}
+
+		msg = (struct printk_log *)buf;
+		format_text(msg, master_seq, ext_text, &ext_len, text,
+			    &len, time);
+
+		if (len == 0 && ext_len == 0)
+			continue;
+
+		if (con->flags & CON_EXTENDED)
+			con->write(con, ext_text, ext_len);
+		else
+			con->write(con, text, len);
+
+		printk_delay(msg->level);
+	}
+out:
+	con->wrote_history = 1;
+	kfree(ext_text);
+	kfree(text);
+	kfree(buf);
+}
+
 /*
  * Call the console drivers, asking them to write out
  * log_buf[start] to log_buf[end - 1].
@@ -1524,6 +1595,10 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 	for_each_console(con) {
 		if (!(con->flags & CON_ENABLED))
 			continue;
+		if (!con->wrote_history) {
+			printk_write_history(con, seq);
+			continue;
+		}
 		if (!con->write)
 			continue;
 		if (!cpu_online(raw_smp_processor_id()) &&
-- 
2.11.0
