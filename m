From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 01/25] printk-rb: add printk ring buffer
 documentation
Date: Tue, 12 Feb 2019 15:45:51 +0100
Message-ID: <20190212144551.GA17291@kroah.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-2-john.ogness@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-2-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 12, 2019 at 03:29:39PM +0100, John Ogness wrote:
> The full documentation file for the printk ring buffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  Documentation/printk-ringbuffer.txt | 377 ++++++++++++++++++++++++++++++++++++

Nit, shouldn't this be in .rst format and tied into the "build the
kernel documentation" process somehow?

thanks,

greg k-h
