From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHv2 0/4] less deadlock prone serial consoles
Date: Tue, 16 Oct 2018 09:23:28 +0200
Message-ID: <20181016072328.GA4030@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 02:04:24PM +0900, Sergey Senozhatsky wrote:
> 	Hello,
> 
> 
> 	RFC
> 
> 
> 	The patch set reduces the number of ways serial consoles
> can deadlock the system, including the recently reported deadlock
> in panic().

That's what I use early_printk for... :-)
