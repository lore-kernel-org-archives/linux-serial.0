From: John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v1 03/25] printk-rb: define ring buffer struct and initializer
Date: Tue, 12 Feb 2019 15:29:41 +0100
Message-ID: <20190212143003.48446-4-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

See Documentation/printk-ringbuffer.txt for details about the
initializer arguments.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
index 75f5708ea902..0e6e8dd0d01e 100644
--- a/include/linux/printk_ringbuffer.h
+++ b/include/linux/printk_ringbuffer.h
@@ -10,6 +10,20 @@ struct prb_cpulock {
 	unsigned long __percpu *irqflags;
 };
 
+struct printk_ringbuffer {
+	void *buffer;
+	unsigned int size_bits;
+
+	u64 seq;
+
+	atomic_long_t tail;
+	atomic_long_t head;
+	atomic_long_t reserve;
+
+	struct prb_cpulock *cpulock;
+	atomic_t ctx;
+};
+
 #define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
 static DEFINE_PER_CPU(unsigned long, _##name##_percpu_irqflags);	\
 static struct prb_cpulock name = {					\
@@ -17,6 +31,20 @@ static struct prb_cpulock name = {					\
 	.irqflags = &_##name##_percpu_irqflags,				\
 }
 
+#define DECLARE_STATIC_PRINTKRB(name, szbits, cpulockptr)		\
+static char _##name##_buffer[1 << (szbits)]				\
+	__aligned(__alignof__(long));					\
+static struct printk_ringbuffer name = {				\
+	.buffer = &_##name##_buffer[0],					\
+	.size_bits = szbits,						\
+	.seq = 0,							\
+	.tail = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
+	.head = ATOMIC_LONG_INIT(-111 * sizeof(long)),			\
+	.reserve = ATOMIC_LONG_INIT(-111 * sizeof(long)),		\
+	.cpulock = cpulockptr,						\
+	.ctx = ATOMIC_INIT(0),						\
+}
+
 /* utility functions */
 void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
 void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
-- 
2.11.0
