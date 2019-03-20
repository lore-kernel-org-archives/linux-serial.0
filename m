From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Date: Wed, 20 Mar 2019 16:37:29 +0100
Message-ID: <20190320153729.6cl77kdck22vc4rv@pathway.suse.cz>
References: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
 <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Calvin Owens <calvinowens@fb.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu 2019-03-14 23:12:49, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > It might be even more straightforward when the per-console value
> > defines the effective console level. I mean the following semantic:
> > 
> >    + "console_loglevel" would define the default loglevel used
> >      by consoles at runtime.
> > 
> >    + the per-console loglevel could override the default
> >      console_loglevel.
> > 
> >    + We would need a custom handler for the sysctl "console_loglevel".
> >      It would write the given value to the global console_loglevel
> >      variable and for all already registered consoles (con->loglevel).
> 
> But some functions change console_loglevel without sysctl (e.g.
> console_verbose() when reporting hung tasks and panic()). Should
> con->loglevel be changed (which might result in too much messages to
> slow consoles) when console_loglevel changes?

It is about the semantic. We either want to set a hard limit
for each console or we want to set per-console loglevel that
will get used in normal situations.

I prefer the 2nd semantic. IMHO, console_verbose() should be
used only in situations when people really want to see all
lines, for example, panic, sysrq output when the machine
looks deadlocked, ignore_loglevel is set. I believe that they
want to see them even on the slow consoles that are
there exactly for debugging these critical situations.

Best Regards,
Petr
