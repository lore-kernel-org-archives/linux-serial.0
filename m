From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Date: Wed, 13 Mar 2019 19:06:53 +0900
Message-ID: <20190313100653.GA23478@jagdpanzerIV>
References: <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
 <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
 <20190313092759.GA10060@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190313092759.GA10060@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/13/19 18:27), Sergey Senozhatsky wrote:
> > Does this mean we keep irq_work part or we bury it and solve it by other
> > means?
>
> That's a very good question. Because if we add console_trylock()
> to printk(), then we can't invoke ->atomic() consoles when console_sem
> is already locked, because one of the registered drivers is currently
> being modified by a 3rd party and printk(), thus, must stay away.
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    one of the drivers or the list itself.

	-ss
