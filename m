From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Sat, 15 Jul 2017 06:54:41 +0900
Message-ID: <20170714215441.GA10437@tigerII.localdomain>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
 <20170707044537.GB7478@jagdpanzerIV.localdomain>
 <0212d098-e307-2ea1-cb41-1e81d545da56@imgtec.com>
 <20170711124308.GA3393@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170711124308.GA3393@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

sorry, I'm on a sick leave and can't check emails that often.

On (07/11/17 14:43), Petr Mladek wrote:
[..]
> > >>The keep_bootcon flag prevents the unregistration of a boot console,
> > >>even if it's data and code reside in the init section and are about to
> > >>be freed. This can lead to crashes and weird panics when the bootconsole
> > >>is accessed after free, especially if page poisoning is in use and the
> > >>code / data have been overwritten with a poison value.
> > >>To prevent this, always free the boot console if it is within the init
> > >>section.
> 
> > >if someone asked to `keep_bootcon' but we actually don't keep it, then
> > >what's the purpose of the flag and
> > >	pr_info("debug: skip boot console de-registration.\n")?
> 
> Exactly. The important information is in the commit 7bf693951a8e5f7e
> ("console: allow to retain boot console via boot option keep_bootcon"):
> 
>     On some architectures, the boot process involves de-registering the boot
>     console (early boot), initialize drivers and then re-register the console.
> 
>     This mechanism introduces a window in which no printk can happen on the
>     console and messages are buffered and then printed once the new console is
>     available.
> 
>     If a kernel crashes during this window, all it's left on the boot console
>     is "console [foo] enabled, boot console disabled" making debug of the crash
>     rather 'interesting'.

sure. no objections here.
I probably mis-worded my thoughts. I agree with Matt's conclusions and
he made valid points I just disagree with the fix.

> > >keeping `early_printk' sometimes can be helpful and people even want to
> > >use `early_printk' as a panic() console fallback (because of those nasty
> > >deadlocks that spoil printk->call_console_drivers()).
> > >
> > 
> > Sure, but as a user, how are you supposed to know that?
> 
> Good point! I wonder if the authors of the keep_bootcon option
> actually knew about it. I do not see this risk mentioned anywhere
> and the early consoles might work long enough by chance.
> 
> One problem is that real consoles might be registered much later
> when it is done using an async probe calls. It might open a big window
> when there is no visible output and debugging is "impossible".

yes. besides, Peter wants to have early consoles as panic fallback.

> I am not comfortable with removing the only way to debug some type
> of bugs. But the current state is broken as well.

yes and yes.

> IMHO, the reasonable solution is to move early console code and data
> out of the init sections. We should do this for the early consoles
> where the corresponding real console is registered using a deferred
> probe. Others should be already replaced by the real console when
> printk_late_init() is called. At least this is how I understand it.

so I was thinking about two options:

a) do not keep consoles in init section

b) have a special init section for consoles code and avoid offloading
   the corresponding pages when we see that keep flag


"b" seems like a crazy idea at glance, but it kinda makes some sense at
the same time. dunno.

	-ss
