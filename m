From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date: Thu, 14 Feb 2019 13:10:28 +0100
Message-ID: <87y36ih8p7.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-3-john.ogness@linutronix.de>
        <20190213154541.wvft64nf352vghou@pathway.suse.cz>
        <87pnrvs707.fsf@linutronix.de>
        <20190214103324.viexpifsyons5qya@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214103324.viexpifsyons5qya@pathway.suse.cz> (Petr Mladek's
        message of "Thu, 14 Feb 2019 11:33:24 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-14, Petr Mladek <pmladek@suse.com> wrote:
>>> cpu_store looks like an implementation detail. The caller
>>> needs to remember it to handle the nesting properly.
>>> 
>>> We could achieve the same with a recursion counter hidden
>>> in struct prb_lock.
>
> The atomic operations are tricky. I feel other lost in them.
> Well, I still think that it might easier to detect nesting
> on the same CPU, see below.
>
> Also there is no need to store irq flags in per-CPU variable.
> Only the first owner of the lock need to store the flags. The others
> are spinning or nested.
>
> struct prb_cpulock {
> 	atomic_t		owner;
> 	unsigned int		flags;
> 	int			nesting; /* intialized to 0 */
> };
>
> void prb_lock(struct prb_cpulock *cpu_lock)
> {
> 	unsigned int flags;
> 	int cpu;

I added an explicit preempt_disable here:

        cpu = get_cpu();

> 	/*
> 	 * The next condition might be valid only when
> 	 * we are nested on the same CPU. It means
> 	 * the IRQs are already disabled and no
> 	 * memory barrier is needed.
> 	 */
> 	if (cpu_lock->owner == smp_processor_id()) {
> 		cpu_lock->nested++;
> 		return;
> 	}
>
> 	/* Not nested. Take the lock */
> 	local_irq_save(flags);
> 	cpu = smp_processor_id();
>
> 	for (;;) {

With fixups so it builds/runs:

                unsigned int prev_cpu = -1;

> 		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
 					       &prev_cpu, cpu)) {
> 			cpu_lock->flags = flags;
> 			break;
> 		}
>
> 		cpu_relax();
> 	}
> }
>
> void prb_unlock(struct prb_cpulock *cpu_lock)
> {
> 	unsigned int flags;
>
> 	if (cpu_lock->nested)
> 		cpu_lock->nested--;

And the matching preempt_enable().

                goto out;

> 	}
>
> 	/* We must be the first lock owner */
> 	flags = cpu_lock->flags;
> 	atomic_set_release(&cpu_lock->owner, -1);
> 	local_irq_restore(flags);

out:
        put_cpu();

> }
>
> Or do I miss anything?

It looks great. I've run my stress tests on it and everything is running
well.

Thanks for simplifying this!

John Ogness
