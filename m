From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 1/6] printk: move printk_safe macros to printk header
Date: Mon, 18 Jun 2018 15:27:31 +0900
Message-ID: <20180618062731.GB27996@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180615093919.559-2-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615093919.559-2-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (06/15/18 18:39), Sergey Senozhatsky wrote:
> Make printk_safe_enter_irqsave()/etc macros available to the
> rest of the kernel, so we can use them in TTY and UART code.

Sorry, this patch is incomplete. Since we are going to use printk_safe()
API in modules (serial console drivers) printk_safe() functions [enter and
exit] must be exported via EXPORT_SYMBOL_GPL().

	-ss
