From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: possible deadlock in console_unlock
Date: Tue, 19 Jun 2018 17:08:12 +0900
Message-ID: <20180619080812.GC405@jagdpanzerIV>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
 <20180607140100.GA398@tigerII.localdomain>
 <20180608081855.ctqakvwmg27aydby@pathway.suse.cz>
 <20180615083804.GB8964@jagdpanzerIV>
 <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619080412.zkdanx6bmq5qm3dz@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

On (06/19/18 10:04), Petr Mladek wrote:
> > > 
> > > We could allow nesting. It is just a matter of how many bits we
> > > reserve for it in printk_context variable.
> > [..]
> > > In each case, I would like to keep the printk_safe context usage
> > > at minimum. It has its own problems caused by limited per-cpu buffers
> > > and the need to flush them.
> > 
> > May be. Every new printk_safe flavour comes with increasing memory
> > usage.
> 
> This must be a misunderstanding. My intention was to introduce
> printk_deferred() context. Where any printk() called in this
> context would behave like printk_deferred(). It does not need
> any extra buffers.

Ah, got it. Yes, this can work.

	-ss
