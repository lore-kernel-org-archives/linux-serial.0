From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date: Thu, 14 Feb 2019 11:33:24 +0100
Message-ID: <20190214103324.viexpifsyons5qya@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
 <20190213154541.wvft64nf352vghou@pathway.suse.cz>
 <87pnrvs707.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87pnrvs707.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed 2019-02-13 22:39:20, John Ogness wrote:
> On 2019-02-13, Petr Mladek <pmladek@suse.com> wrote:
> >> +/*
> >> + * prb_unlock: Perform a processor-reentrant spin unlock.
> >> + * @cpu_lock: A pointer to the lock object.
> >> + * @cpu_store: A "flags" object storing lock status information.
> >> + *
> >> + * Release the lock. The calling processor must be the owner of the lock.
> >> + *
> >> + * It is safe to call this function from any context and state.
> >> + */
> >> +void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
> >> +{
> >> +	unsigned long *flags;
> >> +	unsigned int cpu;
> >> +
> >> +	cpu = atomic_read(&cpu_lock->owner);
> >> +	atomic_set_release(&cpu_lock->owner, cpu_store);
> >> +
> >> +	if (cpu_store == -1) {
> >> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> >> +		local_irq_restore(*flags);
> >> +	}
> >
> > cpu_store looks like an implementation detail. The caller
> > needs to remember it to handle the nesting properly.
> 
> It's really no different than "flags" in irqsave/irqrestore.
> 
> > We could achieve the same with a recursion counter hidden
> > in struct prb_lock.
> 
> The only way I see how that could be implemented is if the cmpxchg
> encoded the cpu owner and counter into a single integer. (Upper half as
> counter, lower half as cpu owner.) Both fields would need to be updated
> with a single cmpxchg. The critical cmpxchg being the one where the CPU
> becomes unlocked (counter goes from 1 to 0 and cpu owner goes from N to
> -1).

The atomic operations are tricky. I feel other lost in them.
Well, I still think that it might easier to detect nesting
on the same CPU, see below.

Also there is no need to store irq flags in per-CPU variable.
Only the first owner of the lock need to store the flags. The others
are spinning or nested.

struct prb_cpulock {
	atomic_t		owner;
	unsigned int		flags;
	int			nesting; /* intialized to 0 */
};

void prb_lock(struct prb_cpulock *cpu_lock)
{
	unsigned int flags;
	int cpu;

	/*
	 * The next condition might be valid only when
	 * we are nested on the same CPU. It means
	 * the IRQs are already disabled and no
	 * memory barrier is needed.
	 */
	if (cpu_lock->owner == smp_processor_id()) {
		cpu_lock->nested++;
		return;
	}

	/* Not nested. Take the lock */
	local_irq_save(flags);
	cpu = smp_processor_id();

	for (;;) {
		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
					       -1, cpu)) {
			cpu_lock->flags = flags;
			break;
		}

		cpu_relax();
	}
}

void prb_unlock(struct prb_cpulock *cpu_lock)
{
	unsigned int flags;

	if (cpu_lock->nested)
		cpu_lock->nested--;
		return;
	}

	/* We must be the first lock owner */
	flags = cpu_lock->flags;
	atomic_set_release(&cpu_lock->owner, -1);
	local_irq_restore(flags);
}

Or do I miss anything?

Best Regards,
Petr
