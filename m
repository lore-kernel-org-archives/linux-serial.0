From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Mon, 4 Mar 2019 19:00:44 +0900
Message-ID: <20190304100044.GC21004@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190304073856.GA552@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/04/19 16:38), Sergey Senozhatsky wrote:
> This, theoretically, creates a whole new world of possibilities for
> console drivers. Now they can do GFP_KERNEL allocations and stall
> printk_kthread during OOM; or they can explicitly reschedule from
> ->write() callback (via console_conditional_schedule()) because
> console_lock() sets console_may_schedule.

To demonstrate what kind of damage preemptible printk can do, some
of the reports I have in my inbox:

> ** 45 printk messages dropped ** [ 2637.275312] i2c-msm-v2 7af5000.i2c: NACK: slave not responding, ensure its powered: msgs(n:1 cur:0 tx) bc(rx:0 tx:2) mode:FIFO slv_addr:0x68 MSTR_STS:0x011363c8 OPER:0x00000090
> ** 59 printk messages dropped ** [ 2637.294937] i2c-msm-v2 7af5000.i2c: NACK: slave not responding, ensure its powered: msgs(n:1 cur:0 tx) bc(rx:0 tx:2) mode:FIFO slv_addr:0x68 MSTR_STS:0x011363c8 OPER:0x00000090
> ** 54 printk messages dropped ** ...

or

[..]
> ** 2499 printk messages dropped ** [   60.095515] CPU: 1 PID: 7148 Comm: syz-executor5 Tainted: G    B           4.4.104-ged884eb #2
> ** 5042 printk messages dropped ** [   60.107433]  [<ffffffff82564f65>] sg_finish_rem_req+0x255/0x2f0
> ** 3861 printk messages dropped ** [   60.116522] 	entry_SYSCALL_64_fastpath+0x16/0x76
> ** 3313 printk messages dropped ** [   60.124312] Object ffff8800b903e960: 00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> ** 5311 printk messages dropped ** [   60.136772] INFO: Freed in fasync_free_rcu+0x14/0x20 age=624 cpu=0 pid=3
> ** 4200 printk messages dropped ** [   60.146612] 	__slab_free+0x18c/0x2b0
> ** 2864 printk messages dropped ** [   60.153322] Object ffff8800b903e990: 00 50 8b 83 ff ff ff ff 01 46 00 00 07 00 00 00  .P.......F......
> ** 5323 printk messages dropped ** [   60.165806] Object ffff8800b903e980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> ** 5308 printk messages dropped ** [   60.178233] 	entry_SYSCALL_64_fastpath+0x16/0x76
> ** 3313 printk messages dropped ** [   60.186014] Object ffff8800b903e960: 00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
> ** 5306 printk messages dropped ** [   60.198451] 	kmem_cache_alloc+0x155/0x290
[..]

One can lose tens, hundreds or even thousands of messages between
consecutive call_console_drivers(). These reports are back from the
days when printk used to be preemptible. I don't see that many dropped
messages starting from 4.15 (when we disabled preemption), at least not
in those syzbot reports which I have.

Some of those lost messages are probably going to be handled by ->atomic
path (depending on the loglevel), assuming that ->atomic console is
available. At the same time we might see a notable conversion of some
pr_foo-s to "a more safer emergency levels".

But in general, channels which depend on preemptible printk will become
totally useless in some cases.

	-ss
