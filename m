From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date: Thu, 7 Mar 2019 15:51:06 +0900
Message-ID: <20190307065106.GB425@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
 <87r2bjbt47.fsf@linutronix.de>
 <87k1hbbq2m.fsf@linutronix.de>
 <20190307064152.GA425@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307064152.GA425@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (03/07/19 15:41), Sergey Senozhatsky wrote:
> This sounds concerning. IMHO, netconsole is too important to rely
> on preemptible printk and scheduler. Especially those netcons which
> run in "report only when oops_in_progress" mode. Sometimes netconsole
> is the fastest console available, but preemptible printk may turn it
> into the slowest one.

+ oops may end by the time kthread becomes active.

	-ss
