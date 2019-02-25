From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 12/25] printk: minimize console locking
 implementation
Date: Mon, 25 Feb 2019 14:44:32 +0100
Message-ID: <20190225134432.upiq6fuc42w4vfbg@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-13-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-13-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:50, John Ogness wrote:
> Since printing of the printk buffer is now handled by the printk
> kthread, minimize the console locking functions to just handle
> locking of the console.
> 
> NOTE: With this console_flush_on_panic will no longer flush.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 255 +------------------------------------------------
>  1 file changed, 1 insertion(+), 254 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 073ff9fd6872..ece54c24ea0d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -209,19 +209,7 @@ static int nr_ext_console_drivers;
>  
>  static int __down_trylock_console_sem(unsigned long ip)
>  {
> -	int lock_failed;
> -	unsigned long flags;
> -
> -	/*
> -	 * Here and in __up_console_sem() we need to be in safe mode,
> -	 * because spindump/WARN/etc from under console ->lock will
> -	 * deadlock in printk()->down_trylock_console_sem() otherwise.
> -	 */
> -	printk_safe_enter_irqsave(flags);
> -	lock_failed = down_trylock(&console_sem);
> -	printk_safe_exit_irqrestore(flags);
> -
> -	if (lock_failed)
> +	if (down_trylock(&console_sem))
>  		return 1;
>  	mutex_acquire(&console_lock_dep_map, 0, 1, ip);
>  	return 0;
> @@ -230,13 +218,9 @@ static int __down_trylock_console_sem(unsigned long ip)
>  
>  static void __up_console_sem(unsigned long ip)
>  {
> -	unsigned long flags;
> -
>  	mutex_release(&console_lock_dep_map, 1, ip);
>  
> -	printk_safe_enter_irqsave(flags);
>  	up(&console_sem);
> -	printk_safe_exit_irqrestore(flags);
>  }
>  #define up_console_sem() __up_console_sem(_RET_IP_)
>  

It might be obvious from the previous mails. But just to be sure.

I would remove printk_safe stuff in one patch after switching
to the new ring buffer implementation.


> @@ -1498,82 +1482,6 @@ static void format_text(struct printk_log *msg, u64 seq,
>  }
>  
>  /*
> - * Special console_lock variants that help to reduce the risk of soft-lockups.
> - * They allow to pass console_lock to another printk() call using a busy wait.
> - */
[...]
> -static void console_lock_spinning_enable(void)

The console waiter logic is another story. It can get removed only
after we have a reasonable alternative. That means an acceptable
offload that handles emergency situations and sudden death
reasonable well.

I would move this into a separate patchset.

Best Regards,
Petr
