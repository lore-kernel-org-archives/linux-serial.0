From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH 1/2] printk: Unconditionally unregister boot consoles if
 in init section
Date: Tue, 11 Jul 2017 15:41:50 +0100
Message-ID: <86ff1193-8485-4b14-492f-627720c1d868@imgtec.com>
References: <1499337481-19397-1-git-send-email-matt.redfearn@imgtec.com>
 <20170707044537.GB7478@jagdpanzerIV.localdomain>
 <0212d098-e307-2ea1-cb41-1e81d545da56@imgtec.com>
 <20170711124308.GA3393@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711124308.GA3393@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Petr,


On 11/07/17 13:43, Petr Mladek wrote:
> Hi all,
>
> let's first make sure that we understand the code the same way.
>
> On Fri 2017-07-07 08:58:01, Matt Redfearn wrote:
>> On 07/07/17 05:45, Sergey Senozhatsky wrote:
>>> On (07/06/17 11:38), Matt Redfearn wrote:
>>>> Commit 4c30c6f566c0 ("kernel/printk: do not turn off bootconsole in
>>>> printk_late_init() if keep_bootcon") added a check on keep_bootcon to
>>>> ensure that boot consoles were kept around until the real console is
>>>> registered.
>>>>
>>>> This can lead to problems if the boot console data and code are in the
>>>> init section, since it can be freed before the boot console is
>>>> deregistered.
> Yes.
>
>>>> This was fixed by commit 81cc26f2bd11 ("printk: only
>>>> unregister boot consoles when necessary").
> This does not make sense to me in this context. This commit has an
> effect only when keep_bootcon is false. While the commit 4c30c6f566c0
> ("kernel/printk: do not turn off boot console in printk_late_init()
> if keep_bootcon") _causes problems only_ when keep_bootcon is true.
>
> What I want to say is that the two commits have effect when
> keep_bootcon has different value. Therefore they could not fix
> each other.

Yeah, what I meant was the situation of the boot console being freed 
while still active (if keep_bootcon is false) was fixed by 81cc26f2bd11. 
After 4c30c6f566c0, if keep_bootcon is true, then you run in to the 
issue I had. The boot console is still active. It's code & data are 
freed and poisoned with the SLAB poison. Some of that section is then 
executed when the boot console is accessed. By happy coincidence(!), on 
MIPS, the poison value 0xCCCCCCCC happens to be a valid opcode with no 
side effect (it's a memory prefetch), so the CPU merrily runs off into 
the weeds executing Mb's worth of them before finally executing 
something that causes an exception of some kind. You get a kernel panic 
with a cause and address that make no sense and have to backtrack trying 
to figure out at what point the actual error occurred, and get nicely 
sidetracked form the issue you were actually trying to debug that 
necessitated keep_bootcon ;-).

>
>>>> The keep_bootcon flag prevents the unregistration of a boot console,
>>>> even if it's data and code reside in the init section and are about to
>>>> be freed. This can lead to crashes and weird panics when the bootconsole
>>>> is accessed after free, especially if page poisoning is in use and the
>>>> code / data have been overwritten with a poison value.
>>>> To prevent this, always free the boot console if it is within the init
>>>> section.
>>> if someone asked to `keep_bootcon' but we actually don't keep it, then
>>> what's the purpose of the flag and
>>> 	pr_info("debug: skip boot console de-registration.\n")?
> Exactly. The important information is in the commit 7bf693951a8e5f7e
> ("console: allow to retain boot console via boot option keep_bootcon"):
>
>      On some architectures, the boot process involves de-registering the boot
>      console (early boot), initialize drivers and then re-register the console.
>
>      This mechanism introduces a window in which no printk can happen on the
>      console and messages are buffered and then printed once the new console is
>      available.
>
>      If a kernel crashes during this window, all it's left on the boot console
>      is "console [foo] enabled, boot console disabled" making debug of the crash
>      rather 'interesting'.
>
>
>>> keeping `early_printk' sometimes can be helpful and people even want to
>>> use `early_printk' as a panic() console fallback (because of those nasty
>>> deadlocks that spoil printk->call_console_drivers()).
>>>
>> Sure, but as a user, how are you supposed to know that?
> Good point! I wonder if the authors of the keep_bootcon option
> actually knew about it. I do not see this risk mentioned anywhere
> and the early consoles might work long enough by chance.
>
> One problem is that real consoles might be registered much later
> when it is done using an async probe calls. It might open a big window
> when there is no visible output and debugging is "impossible".
>
> I am not comfortable with removing the only way to debug some type
> of bugs. But the current state is broken as well.
>
> IMHO, the reasonable solution is to move early console code and data
> out of the init sections. We should do this for the early consoles
> where the corresponding real console is registered using a deferred
> probe. Others should be already replaced by the real console when
> printk_late_init() is called. At least this is how I understand it.

This seems like the most reasonable way forward to me as well, though 
sadly will lead to some post-init kernel bloat.

I still think, however, that this patch is a reasonable change to make. 
Though perhaps some warning (if keep_bootcon is active?) would be 
appropriate so that a user knows that the boot console is being 
unregistered (because it may no longer be functional after being freed) 
and therefore silence can be expected - and we know that a driver needs 
fixing. We can then proceed as you suggest and migrate away from placing 
early console drivers which will not already have an active real console 
in the init section.
My other patch, placing serial earlycon in the init section is then the 
wrong way round and we need to remove __init from e.g. early8250 and so on.

>
> Matt, is there any chance that you look into this possibility?

Sure, I can look at fixing up console drivers which we use on the MIPS 
architecture.

Thanks,
Matt

>
> Best Regards,
> Petr
