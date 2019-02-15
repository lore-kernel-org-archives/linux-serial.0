From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date: Fri, 15 Feb 2019 11:56:15 +0100
Message-ID: <87y36hials.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-3-john.ogness@linutronix.de>
        <20190213154541.wvft64nf352vghou@pathway.suse.cz>
        <87pnrvs707.fsf@linutronix.de>
        <20190214103324.viexpifsyons5qya@pathway.suse.cz>
        <87y36ih8p7.fsf@linutronix.de>
        <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 15 Feb 2019 11:26:35 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-15, Petr Mladek <pmladek@suse.com> wrote:
>>> void prb_lock(struct prb_cpulock *cpu_lock)
>>> {
>>> 	unsigned int flags;
>>> 	int cpu;
>> 
>> I added an explicit preempt_disable here:
>> 
>>         cpu = get_cpu();
>
> It is superfluous. Preemption is not possible when interrupts
> are disabled.

Interrupts are not necessarily disabled here. They get disabled later if
the lock needs to be taken (i.e. we are not nested).

John Ogness
