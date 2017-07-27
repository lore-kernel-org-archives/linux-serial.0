From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Thu, 27 Jul 2017 18:51:01 +0900
Message-ID: <20170727095100.GA653@jagdpanzerIV.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170726130804.GB2173@jagdpanzerIV.localdomain>
 <20170727092957.GD3799@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727092957.GD3799@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (07/27/17 11:29), Petr Mladek wrote:
[..]
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Thanks for the review. I am going to push the two patches into
> for-4.14 branch so that we could get some testing via linux-next.

good. agree.

how do you think,

would pr_warn() be enough for people to notice the wrongdoing or
shall we put WARN_ON() there for a while at least? (assuming that
people pay more attention to backtraces).

	-ss
