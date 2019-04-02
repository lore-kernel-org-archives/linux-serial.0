From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 14/99] panic: avoid deadlocks in re-entrant console
 drivers
Date: Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.529644269@decadent.org.uk>
References: <lsq.1554212307.17110877@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Wang <wonderfly@google.com>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Feiner <pfeiner@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-serial@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

commit c7c3f05e341a9a2bd1a92993d4f996cfd6e7348e upstream.

=46romprintk()/serial console point of view panic() is special, because
it may force CPU to re-enter printk() or/and serial console driver.
Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:

serial8250_console_write()
{
	if (port->sysrq)
		locked = 0;
	else if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);
	else
		spin_lock_irqsave(&port->lock, flags);
	...
}

panic() does set oops_in_progress via bust_spinlocks(1), so in theory
we should be able to re-enter serial console driver from panic():

	CPU0
	<NMI>
	uart_console_write()
	serial8250_console_write()		// if (oops_in_progress)
						//    spin_trylock_irqsave()
	call_console_drivers()
	console_unlock()
	console_flush_on_panic()
	bust_spinlocks(1)			// oops_in_progress++
	panic()
	<NMI/>
	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
	serial8250_console_write()
	call_console_drivers()
	console_unlock()
	printk()
	...

However, this does not happen and we deadlock in serial console on
port->lock spinlock. And the problem is that console_flush_on_panic()
called after bust_spinlocks(0):

void panic(const char *fmt, ...)
{
	bust_spinlocks(1);
	...
	bust_spinlocks(0);
	console_flush_on_panic();
	...
}

bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
can go back to zero. Thus even re-entrant console drivers will simply
spin on port->lock spinlock. Given that port->lock may already be
locked either by a stopped CPU, or by the very same CPU we execute
panic() on (for instance, NMI panic() on printing CPU) the system
deadlocks and does not reboot.

Fix this by removing bust_spinlocks(0), so oops_in_progress is always
set in panic() now and, thus, re-entrant console drivers will trylock
the port->lock instead of spinning on it forever, when we call them
from console_flush_on_panic().

Link: http://lkml.kernel.org/r/20181025101036.6823-1-sergey.senozhatsky@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Wang <wonderfly@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Feiner <pfeiner@google.com>
Cc: linux-serial@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/panic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -13,6 +13,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/kallsyms.h>
 #include <linux/notifier.h>
+#include <linux/vt_kern.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/ftrace.h>
@@ -178,7 +179,10 @@ void panic(const char *fmt, ...)
 	 */
 	crash_kexec(NULL);
 
-	bust_spinlocks(0);
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
+	console_unblank();
 
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
