From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new
 ringbuffer
Date: Mon, 25 Feb 2019 13:11:07 +0100
Message-ID: <20190225121106.oig7s6odqikcn4xw@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-11-john.ogness@linutronix.de>
 <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
 <8736oijgpf.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8736oijgpf.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed 2019-02-20 22:25:00, John Ogness wrote:
> On 2019-02-20, Petr Mladek <pmladek@suse.com> wrote:
> >> vprintk_emit and vprintk_store are the main functions that all printk
> >> variants eventually go through. Change these to store the message in
> >> the new printk ring buffer that the printk kthread is reading.
> >
> > Please, are there any candidates or plans to reuse the new ring
> > buffer implementation?
> 
> As you pointed out below, this patch already uses the ring buffer
> implementation for a totally different purpose: NMI safe dynamic memory
> allocation.

I have found an alternative solution. We could calculate the length
of the formatted string without any buffer:

	va_list args_copy;

	va_copy(args_copy, args);
	len = vscprintf(NULL, fmt, args_copy);
	va_end(args_copy);

This vsprintf() mode was implemented for exactly this purpose.

Best Regards,
Petr
