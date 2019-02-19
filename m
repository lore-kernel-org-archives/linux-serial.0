From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 09/25] printk: remove exclusive console hack
Date: Tue, 19 Feb 2019 15:03:18 +0100
Message-ID: <20190219140318.wnk2dbgvf3i5qdsb@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-10-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-10-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:29:47, John Ogness wrote:
> In order to support printing the printk log history when new
> consoles are registered, a global exclusive_console variable is
> temporarily set. This only works because printk runs with
> preemption disabled.
> 
> When console printing is moved to a fully preemptible dedicated
> kthread, this hack no longer works.

We need to keep this functionality. Otherwise, people would miss
the beginning of the log on some consoles. Kernel does not know
what console is important for monitoring or debugging.

Fortunately, it should be easy to implement this with
the new ring buffer a much cleaner way. Anyway, you
need to switch to the new implementation in a single
patch to avoid regression.

I would personally postpone this into a separate patchset.

Best Regards,
Petr
