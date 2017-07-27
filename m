From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Thu, 27 Jul 2017 18:52:22 +0900
Message-ID: <20170727095222.GB653@jagdpanzerIV.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170714220626.GB10437@tigerII.localdomain>
 <20170721143253.GA26877@pathway.suse.cz>
 <20170724020356.GA515@jagdpanzerIV.localdomain>
 <20170727092825.GC3799@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727092825.GC3799@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (07/27/17 11:28), Petr Mladek wrote:
> > well, the console output is far from perfect, so I can imagine future
> > changes ;)
> 
> Sure and we will need to deal with it. Anyway, I still thing that this
> check is better than nothing. Even if we "fix" all consoles and move
> them out of init section then this check will be useful to catch at least
> some future mistakes.

yep, let's keep it.

[..]
> > let's move. to normal section, or to special section. depending on how
> > much space we can saved unloading the consoles.
> 
> I agree. We will do or suggest this when anyone see the warning
> and ask for help.

works for me.

	-ss
