From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCHv2 1/4] panic: avoid deadlocks in re-entrant console
 drivers
Date: Tue, 23 Oct 2018 13:07:51 +0200
Message-ID: <20181023110751.un2u67bc7dpo4ska@pathway.suse.cz>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2018-10-16 14:04:25, Sergey Senozhatsky wrote:
> >From printk()/serial console point of view panic() is special, because
> it may force CPU to re-enter printk() or/and serial console driver.
> Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:
> 
> serial8250_console_write()
> {
>         if (port->sysrq)
>                 locked = 0;
>         else if (oops_in_progress)
>                 locked = spin_trylock_irqsave(&port->lock, flags);
>         else
>                 spin_lock_irqsave(&port->lock, flags);
> 	...
> }
> 
> panic() does set oops_in_progress via bust_spinlocks(1), so in theory
> we should be able to re-enter serial console driver from panic():
> 
> 	CPU0
> 	<NMI>
> 	uart_console_write()
> 	serial8250_console_write()		// if (oops_in_progress)
> 						//    spin_trylock_irqsave()
> 	call_console_drivers()
> 	console_unlock()
> 	console_flush_on_panic()
> 	bust_spinlocks(1)			// oops_in_progress++
> 	panic()
> 	<NMI/>
> 	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
> 	serial8250_console_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	...
> 
> However, this does not happen and we deadlock in serial console on
> port->lock spinlock. And the problem is that console_flush_on_panic()
> called after bust_spinlocks(0):
> 
> void panic(const char *fmt, ...)
> {
>         bust_spinlocks(1);
> ...
>         bust_spinlocks(0);
>         console_flush_on_panic();
> ...
> }
> 
> bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
> can go back to zero. Thus even re-entrant console drivers will simply
> spin on port->lock spinlock. Given that port->lock may already be
> locked either by a stopped CPU, or by the very same CPU we execute
> panic() on (for instance, NMI panic() on printing CPU) the system
> deadlocks and does not reboot.

The idea makes sense to me. You are right that we already called
printk/console with busted spinlock many times in panic().
Therefore it should not be worse.


> Fix this by setting oops_in_progress before console_flush_on_panic(),
> so re-entrant console drivers will trylock the port->lock instead of
> spinning on it forever.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/panic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index f6d549a29a5c..a0e60ccf3031 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -237,7 +237,13 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> +	/*
> +	 * Decrement oops_in_progress and let bust_spinlocks() to
> +	 * unblank_screen(), console_unblank() and wake_up_klogd()
> +	 */
>  	bust_spinlocks(0);
> +	/* Set oops_in_progress, so we can reenter serial console driver */
> +	bust_spinlocks(1);

Though this looks a bit weird.

I have just realized that console_unblank() is called by
bust_spinlocks(0) and does basically the same as
console_flush_on_panic(). Also it does not make much
sense wake_up_klogd() there. Finally, it seems to be
too late to disable lockdep there.

I would suggest something like:

diff --git a/kernel/panic.c b/kernel/panic.c
index 8b2e002d52eb..c78e3df8dd58 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -233,17 +233,14 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	bust_spinlocks(0);
-
 	/*
 	 * We may have ended up stopping the CPU holding the lock (in
-	 * smp_send_stop()) while still having some valuable data in the console
-	 * buffer.  Try to acquire the lock then release it regardless of the
-	 * result.  The release will also print the buffers out.  Locks debug
-	 * should be disabled to avoid reporting bad unlock balance when
-	 * panic() is not being callled from OOPS.
+	 * smp_send_stop()) while still having some valuable data in
+	 * the console buffer. Try hard to see them.
 	 */
-	debug_locks_off();
+#ifdef CONFIG_VT
+	unblank_screen();
+#endif
 	console_flush_on_panic();
 
 	if (!panic_blink)
diff --git a/lib/bust_spinlocks.c b/lib/bust_spinlocks.c
index ab719495e2cb..e42d2fcd6453 100644
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -20,6 +20,12 @@
 void __attribute__((weak)) bust_spinlocks(int yes)
 {
 	if (yes) {
+		/*
+		 * Some locks might get ignored in the Oops situation
+		 * to get an important work done. Locks debug should
+		 * be disabled to avoid reporting bad unlock balance.
+		 */
+		debug_locks_off();
 		++oops_in_progress;
 	} else {
 #ifdef CONFIG_VT
