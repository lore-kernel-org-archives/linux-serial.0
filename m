From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Date: Thu, 1 Nov 2018 10:48:21 +0900
Message-ID: <20181101014821.GB502@jagdpanzerIV>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
 <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (10/31/18 13:27), Petr Mladek wrote:
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> The patch makes sense to me. The locks should stay busted also for
> console_flush_on_panic().
> 
> With the added #include <linux/vt_kern.h>:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks!

Since there are no objections - how shall we route it? Via printk tree?
I'd also prefer this patch to be in -stable, it fixes a real issue after
all.

	-ss
