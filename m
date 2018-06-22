From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Date: Fri, 22 Jun 2018 18:39:04 +0200
Message-ID: <20180622163904.GP2494@hirez.programming.kicks-ass.net>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180619223447.4369748b@vmware.local.home>
 <CA+55aFwpcbNO6FS4=O-BrsC4vMBaT3JeFG-_D9WtgmW+Dof3iA@mail.gmail.com>
 <20180622172100.2293b5e5@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180622172100.2293b5e5@alans-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, SergeySenozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 22, 2018 at 05:21:00PM +0100, Alan Cox wrote:
> Really that's all that you need - log the message to whichever console
> targets you can currently safely do so. If it's none well there was
> always the proposed morse code keyboard light driver 8)

Only if your keyboard still has blinky lights on.. (mine doesn't)
