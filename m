From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Thu, 16 Mar 2017 14:54:22 +0100
Message-ID: <20170316135422.GK3977@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170315102854.1763-4-aleksey.makarov@linaro.org>
 <20170315165858.GJ3977@pathway.suse.cz>
 <19bad64a-f334-05f7-fb92-520ffc5c0b90@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19bad64a-f334-05f7-fb92-520ffc5c0b90@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2017-03-16 13:36:35, Aleksey Makarov wrote:
> 
> 
> On 03/15/2017 07:58 PM, Petr Mladek wrote:
> > On Wed 2017-03-15 13:28:52, Aleksey Makarov wrote:
> >> If a console was specified by ACPI SPCR table _and_ command line
> >> parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> >> then log messages appear twice.
> >>
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index fd752f0c8ef1..7dc53b2831fb 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -1902,20 +1902,25 @@ static int __add_preferred_console(char *name, int idx, char *options,
> >>  	int i;
> >>  
> >>  	/*
> >> -	 *	See if this tty is not yet registered, and
> >> -	 *	if we have a slot free.
> >> +	 * Don't check if the console has already been registered, because it is
> >> +	 * pointless.  After all, we can not check if two entries refer to
> >> +	 * the same console if one is matched with console->match(), and another
> >> +	 * by name/index:
> >> +	 *
> >> +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
> >> +	 *	ttyAMA0 -- added from command line
> >> +	 *
> >> +	 * Also this allows to maintain an invariant that will help to find if
> >> +	 * the matching console is preferred, see register_console():
> > 
> > It is an interesting idea.
> > 
> > I just wonder if the check for duplicates was there for a serious
> > reason. It is hard to say because it was already in the initial git
> > commit. In each case, MAX_CMDLINECONSOLES is 8. There is not much
> > space for duplicates.
> > 
> > Note that add_preferred_console() is called also from _probe() calls,
> > see
> > 
> >    uart_add_one_port() -> of_console_check()
> >    sunserial_console_match() -> add_preferred_console()
> > 
> > I wonder they might be called repeatedly, for example because
> > of suspend/restore, hotplug, module load/unload.
> > 
> > I would feel more comfortable if we keep the check for
> > duplicates here.
> 
> Now I see the problem, thank you.
> 
> > It is a pity that the console->match() calls have side effects.
> > I still wonder if the 4th version might be more safe. 
> 
> I pushed v4 to the linaro git server:
> 
> https://git.linaro.org/people/aleksey.makarov/linux.git/commit/?h=amakarov/console2.19.v4&id=47a8227e37ca54d9cc7051abe9b3c2d072f4f75f
> 
> The problem with that approach is again a side effect.
> Function match_console_name() can change newcon->index.
> But it can be called in the very first pass that looks for braille console
> and if the call to _braille_register_console() fails,
> this newcon with changed index is passed to newcon->match().

I see. We need to make sure that newcon->match() will not get called
when checking for the braille console.


> This can be fixed by introducing a predicate that checks if the
> console_cmdline entry has braille options and calling match_console_name()
> only for such consoles, but I think that the code is too convoluted
> and the v5 approach is better.

I personally prefer v4. The braille console adds an unexpected
twist into the code because it skips the rest of the function.
IMHO, it is better when it is is tested separately with clear
conditions and comments.

I would personally add the following into
kernel/printk/console_cmdline.h

#define for_each_console_cmdline(c, i) \
	for (i = 0, c = console_cmdline;		\
	     i < MAX_CMDLINECONSOLES && c->name[0];	\
	     i++, c++)

It can be used in both __add_preferred_console()
and register_console().

Also I would add the following into kernel/printk/braille.h

static inline bool
is_braille_console(struct console_cmdline *c)
{
	return !!c->brl_options;
}

Then the braille-specific code in register_console() might
look like:

	/*
	 * Braille console is handled a very special way.
	 * Is is not listed in the console_drivers list.
	 * Instead it registers its own keyboard and vt notifiers.
	 *
	 * Be careful and avoid calling c->match() here
	 * because it might have side effects!
	 */
	if (is_braille_console(c) &&
	    match_console_name(newcon, c) &&
	    _braille_register_console(newcon, c))
		return;


Finally, I would prefer to move

	newcon->flags |= CON_ENABLED;

outside the match_console() function. The function will still
have side effects because of the c->match() calls. But we should
not make it worse. In fact, it would be great to remove side effects
from the c->match() functions in the long term (not in this patch set).

> I am going to fix v5 preserving both the check for duplicates
> and the invariant, but tell me please if you prefer the v4 approach.

I guess that you planed to shuffle console_cmdline entries to keep
the preferred console first/last. I am afraid that it won't be
a nice code either. But I might be wrong.


> > The
> > newcon->setup() call is called only when the console matches.
> > AFAIK, there is only one braille console. We should be on
> > the safe side if this one does not implement the match()
> > callback. Or is it even more complicated?
> 
> As you can see from the original code, the check for braille console
> was performed in that branch of code where we missed newcon->match(),
> so yes, it looks like braille console(s) does not have the match() method.
> I used that in v4 to factor out matching for braille from the loop.

The check for blr_options is sufficient and better.

I suggest to wait at least two days until you spend to much time
on reshuffling the code. It is possible that others would prefer
v5 or suggest even other solution.

Best Regards,
Petr
