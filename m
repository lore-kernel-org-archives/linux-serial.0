From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date: Thu, 7 Mar 2019 11:12:21 +0900
Message-ID: <20190307021221.GA9676@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-3-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
> +static bool __prb_trylock(struct prb_cpulock *cpu_lock,
> +			  unsigned int *cpu_store)
> +{
> +	unsigned long *flags;
> +	unsigned int cpu;
> +
> +	cpu = get_cpu();
> +
> +	*cpu_store = atomic_read(&cpu_lock->owner);
> +	/* memory barrier to ensure the current lock owner is visible */
> +	smp_rmb();
> +	if (*cpu_store == -1) {
> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> +		local_irq_save(*flags);
> +		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
> +					       cpu_store, cpu)) {
> +			return true;
> +		}
> +		local_irq_restore(*flags);
> +	} else if (*cpu_store == cpu) {
> +		return true;
> +	}
> +
> +	put_cpu();
> +	return false;
> +}
> +
> +/*
> + * prb_lock: Perform a processor-reentrant spin lock.
> + * @cpu_lock: A pointer to the lock object.
> + * @cpu_store: A "flags" pointer to store lock status information.
> + *
> + * If no processor has the lock, the calling processor takes the lock and
> + * becomes the owner. If the calling processor is already the owner of the
> + * lock, this function succeeds immediately. If lock is locked by another
> + * processor, this function spins until the calling processor becomes the
> + * owner.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
> +{
> +	for (;;) {
> +		if (__prb_trylock(cpu_lock, cpu_store))
> +			break;
> +		cpu_relax();
> +	}
> +}

Any chance to make it more fair? A ticket based lock, perhaps?

	-ss
