From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
Date: Tue, 12 Mar 2019 11:51:28 +0900
Message-ID: <20190312025128.GC4146@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-20-john.ogness@linutronix.de>
 <20190307073029.GA489@jagdpanzerIV>
 <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
 <87k1h5zkfn.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87k1h5zkfn.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/11/19 13:04), John Ogness wrote:
> > Great catch!
> 
> Yes, thanks!
> 
> > I think that it is doable to guard the list using RCU.
> 
> I think it would be enough to take the prb_cpulock when modifying the
> console linked list. That will keep printk_emergency() out until the
> list has been updated. (registering/unregistering consoles is not
> something that happens often.)

console_sem can be a bit more than just registering/unregistering.
Especially when it comes to VT, fbcon and ioctls.

$ git grep console_lock drivers/tty/ | wc -l
82

$ git grep console_lock drivers/video/fbdev/ | wc -l
80

	-ss
