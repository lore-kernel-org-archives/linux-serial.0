From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Thu, 27 Jul 2017 12:08:27 +0200
Message-ID: <20170727100827.GF3799@pathway.suse.cz>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170726130804.GB2173@jagdpanzerIV.localdomain>
 <20170727092957.GD3799@pathway.suse.cz>
 <20170727095100.GA653@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727095100.GA653@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu 2017-07-27 18:51:01, Sergey Senozhatsky wrote:
> On (07/27/17 11:29), Petr Mladek wrote:
> [..]
> > > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > 
> > Thanks for the review. I am going to push the two patches into
> > for-4.14 branch so that we could get some testing via linux-next.
> 
> good. agree.
> 
> how do you think,
> 
> would pr_warn() be enough for people to notice the wrongdoing or
> shall we put WARN_ON() there for a while at least? (assuming that
> people pay more attention to backtraces).

I would keep pr_warn(). The warning is interesting only when people
want to debug and the real console does not appear in time.
Then this will be the last but one message on the early console.

Best Regards,
Petr
