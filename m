From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Mon, 24 Jul 2017 11:03:56 +0900
Message-ID: <20170724020356.GA515@jagdpanzerIV.localdomain>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170714220626.GB10437@tigerII.localdomain>
 <20170721143253.GA26877@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170721143253.GA26877@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello,

On (07/21/17 16:32), Petr Mladek wrote:
[..]
> > sort of a problem here is that the next time anyone adds a new ->foo()
> > callback to struct console, that person also needs to remember to update
> > printk_late_init().
> 
> I am not super happy with this as well. Any hint how to do it better
> or more secure is welcome. But I do not see a beter solution at the moment.
> 
> Note that there are only 3 commits in the git history that change this
> structure. Neither of them invalidates this check!

well, the console output is far from perfect, so I can imagine future
changes ;)

> > a completely crazy idea,
> > can we have a dedicated "console init" section which we will not offload
> > if we see keep_bootcon?
> 
> I though about this as well. But this will not avoid the above
> problem. We still would need to make sure that the consoles
> use the special section. Or do I miss anything?

you don't miss anything.

to fix the rootcause of the problem, and not its aftershock, we still
need to either:
	a) move consoles to normal section
or
	b) move consoles to a special section

I don't mind that warning, but I think we also need to tweak the
affected consoles. otherwise, upon maintainer's request to keep
bootcon, a user can just report back "uses init memory and must
be disabled even before the real one is ready" warning, yet the
kernel still would crash (a theoretical case, but for some reason
someone wanted to keep bootcon after all).

[..]
> It means that less than 25% of early consoles are located in the init
> code. I am not sure if it is worth introducing a new section.

ok, good.

> Instead it would make sense to move all these consoles into the normal
> section. But it is not strictly needed if the normal console is
> registered using an init call (always in time). In this case, it is "enough"
> to mention the real console as the last one on the command line.

let's move. to normal section, or to special section. depending on how
much space we can saved unloading the consoles.

> > or... even crazier... disable bootmem offloading (do not offload init
> > section) at all if we see keep_bootcon? keep_bootcon is a purely debugging
> > option which people enable when things are bad and unclear, no one should
> > be using it otherwise, so may be that idea can be a way to go.
> 
> I have talked about this with my colleagues. They told me that it
> would be pity. The keep_bootcon option might be useful to debug
> problems related to freeing the init memory.

agree.

	-ss
