From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Thu, 27 Jul 2017 11:28:25 +0200
Message-ID: <20170727092825.GC3799@pathway.suse.cz>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170714220626.GB10437@tigerII.localdomain>
 <20170721143253.GA26877@pathway.suse.cz>
 <20170724020356.GA515@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170724020356.GA515@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon 2017-07-24 11:03:56, Sergey Senozhatsky wrote:
> Hello,
> 
> On (07/21/17 16:32), Petr Mladek wrote:
> [..]
> > > sort of a problem here is that the next time anyone adds a new ->foo()
> > > callback to struct console, that person also needs to remember to update
> > > printk_late_init().
> > 
> > I am not super happy with this as well. Any hint how to do it better
> > or more secure is welcome. But I do not see a beter solution at the moment.
> > 
> > Note that there are only 3 commits in the git history that change this
> > structure. Neither of them invalidates this check!
> 
> well, the console output is far from perfect, so I can imagine future
> changes ;)

Sure and we will need to deal with it. Anyway, I still thing that this
check is better than nothing. Even if we "fix" all consoles and move
them out of init section then this check will be useful to catch at least
some future mistakes.


> to fix the rootcause of the problem, and not its aftershock, we still
> need to either:
> 	a) move consoles to normal section
> or
> 	b) move consoles to a special section
> 
> I don't mind that warning, but I think we also need to tweak the
> affected consoles. otherwise, upon maintainer's request to keep
> bootcon, a user can just report back "uses init memory and must
> be disabled even before the real one is ready" warning, yet the
> kernel still would crash (a theoretical case, but for some reason
> someone wanted to keep bootcon after all).

I would leave this to the maintainers and developers of the respective
architectures. It would be nice to fix it now but I am not sure if
I would be able to do and test the changes properly and effectively.

Also it might be hard to sell. Note that it makes sense to keep early
con in the init section when the related real console is registered
during kernel initialization (no deferred probe) before late init
calls.


> > Instead it would make sense to move all these consoles into the normal
> > section. But it is not strictly needed if the normal console is
> > registered using an init call (always in time). In this case, it is "enough"
> > to mention the real console as the last one on the command line.
> 
> let's move. to normal section, or to special section. depending on how
> much space we can saved unloading the consoles.

I agree. We will do or suggest this when anyone see the warning
and ask for help.

Best Regards,
Petr
