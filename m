From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 16 Oct 2018 14:38:37 +0200
Message-ID: <20181016123837.GC2537@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016122734.GA1259@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> On (10/16/18 09:27), Peter Zijlstra wrote:
> > 
> > So I really _really_ hate all this. Utterly detest it.
> 
> I learned a new word today - detest. I can haz re-entrant consoles now please?

early_serial_write() not haz a lock anywhere.
