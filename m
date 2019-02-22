From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH v1 11/25] printk_safe: remove printk safe code
Date: Fri, 22 Feb 2019 14:38:28 +0100
Message-ID: <87h8cwymcr.fsf@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-12-john.ogness@linutronix.de>
        <20190222103732.zkcvjijtdcfu4vbt@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222103732.zkcvjijtdcfu4vbt@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 22 Feb 2019 11:37:32 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 2019-02-22, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
>> index 15ca78e1c7d4..77bf84987cda 100644
>> --- a/lib/nmi_backtrace.c
>> +++ b/lib/nmi_backtrace.c
>> @@ -75,12 +75,6 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>>  		touch_softlockup_watchdog();
>>  	}
>>  
>> -	/*
>> -	 * Force flush any remote buffers that might be stuck in IRQ context
>> -	 * and therefore could not run their irq_work.
>> -	 */
>> -	printk_safe_flush();
>> -
>>  	clear_bit_unlock(0, &backtrace_flag);
>>  	put_cpu();
>>  }
>
> This reminds me that we need to add back the locking that was
> removed in the commit 03fc7f9c99c1e7ae2925d45 ("printk/nmi:
> Prevent deadlock when accessing the main log buffer in NMI").

No, that commit is needed. You cannot have NMIs waiting on other CPUs.

> Otherwise, backtraces from different CPUs would get mixed.

A later patch (#17) adds CPU IDs to the printk messages so that this
isn't a problem. (That patch is actually obsolete now because Sergey has
already merged work for linux-next that includes this information.)

John Ogness
