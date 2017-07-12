From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Wed, 12 Jul 2017 13:11:17 +0200
Message-ID: <20170712111117.GD3393@pathway.suse.cz>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
 <20170707044537.GB7478@jagdpanzerIV.localdomain>
 <0212d098-e307-2ea1-cb41-1e81d545da56@imgtec.com>
 <20170711124308.GA3393@pathway.suse.cz>
 <86ff1193-8485-4b14-492f-627720c1d868@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86ff1193-8485-4b14-492f-627720c1d868@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue 2017-07-11 15:41:50, Matt Redfearn wrote:
> On 11/07/17 13:43, Petr Mladek wrote:
> >IMHO, the reasonable solution is to move early console code and data
> >out of the init sections. We should do this for the early consoles
> >where the corresponding real console is registered using a deferred
> >probe. Others should be already replaced by the real console when
> >printk_late_init() is called. At least this is how I understand it.
> 
> This seems like the most reasonable way forward to me as well,
> though sadly will lead to some post-init kernel bloat.
> 
> I still think, however, that this patch is a reasonable change to
> make.

The thing is that this patch "silently" makes the keep_bootcon
option almost unusable.

The remaining use in register_console() does not make much sense.
It keeps the boot console after the preferred real one was registered.


> My other patch, placing serial earlycon in the init section is then
> the wrong way round and we need to remove __init from e.g. early8250
> and so on.

Yup.

> >Matt, is there any chance that you look into this possibility?
> 
> Sure, I can look at fixing up console drivers which we use on the
> MIPS architecture.

I have discussed this with my colleagues. It seems that implementation
of keep_bootcon option is pretty broken. It allows to debug broken
system using unreliable consoles (already freed). Therefore enabling
the option adds more problems on its own.

It would be nice to fix it. But it looks rather complicated. There
are several possibilities that are more or less hacky. It is hard
to guess the best solution if we do not know who is using it, how
it helps or sucks for them.

Before we spend a lot of time on this. Let me first try to send an RFC
to remove the feature and put more people into CC. It will either
be accepted or we will get arguments that would justify the needed
changes to fix it.

Best Regards,
Petr


PS: If you already stared migrating some consoles from the init
section, I would be interested into feedback about what problems
you did meet so far.
