From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 03/25] printk-rb: define ring buffer struct and
 initializer
Date: Thu, 14 Feb 2019 13:46:27 +0100
Message-ID: <20190214124627.pmvsw3hsgvywmn32@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-4-john.ogness@linutronix.de>
 <20190212144640.GB17291@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212144640.GB17291@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2019-02-12 15:46:40, Greg Kroah-Hartman wrote:
> On Tue, Feb 12, 2019 at 03:29:41PM +0100, John Ogness wrote:
> > See Documentation/printk-ringbuffer.txt for details about the
> > initializer arguments.
> 
> You can put that documentation here in the .h file and have it pulled
> out automatically into the documentation files when they are created.
> That way you always keep everything in sync properly.

Yes, please, move the documentation into the sources.

It is so easy to get the info via editor+cscope support
than via an external text file that many people do not
know about ;-)

For example, see include/linux/livepatch.h for inspiration.

Best Regards,
Petr
