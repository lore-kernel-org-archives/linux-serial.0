From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Fri, 17 Mar 2017 13:32:23 +0300
Message-ID: <a22a7007-1781-399e-4d75-2696db2d2e02@gmail.com>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170315102854.1763-4-aleksey.makarov@linaro.org>
 <20170315165858.GJ3977@pathway.suse.cz>
 <19bad64a-f334-05f7-fb92-520ffc5c0b90@linaro.org>
 <20170316135422.GK3977@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316135422.GK3977@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 03/16/2017 04:54 PM, Petr Mladek wrote:
> On Thu 2017-03-16 13:36:35, Aleksey Makarov wrote:
>>
>>
>> On 03/15/2017 07:58 PM, Petr Mladek wrote:
>>> On Wed 2017-03-15 13:28:52, Aleksey Makarov wrote:

[..]

> I personally prefer v4. The braille console adds an unexpected
> twist into the code because it skips the rest of the function.
> IMHO, it is better when it is is tested separately with clear
> conditions and comments.
> 
> I would personally add the following into
> kernel/printk/console_cmdline.h
> 
> #define for_each_console_cmdline(c, i) \
> 	for (i = 0, c = console_cmdline;		\
> 	     i < MAX_CMDLINECONSOLES && c->name[0];	\
> 	     i++, c++)
> 
> It can be used in both __add_preferred_console()
> and register_console().

Ok

> Also I would add the following into kernel/printk/braille.h
> 
> static inline bool
> is_braille_console(struct console_cmdline *c)
> {
> 	return !!c->brl_options;
> }
> 
> Then the braille-specific code in register_console() might
> look like:
> 
> 	/*
> 	 * Braille console is handled a very special way.
> 	 * Is is not listed in the console_drivers list.
> 	 * Instead it registers its own keyboard and vt notifiers.
> 	 *
> 	 * Be careful and avoid calling c->match() here
> 	 * because it might have side effects!
> 	 */
> 	if (is_braille_console(c) &&
> 	    match_console_name(newcon, c) &&
> 	    _braille_register_console(newcon, c))
> 		return;

Yes, this is exactly what I was going to do.

> Finally, I would prefer to move
> 
> 	newcon->flags |= CON_ENABLED;
> 
> outside the match_console() function. The function will still
> have side effects because of the c->match() calls. But we should
> not make it worse. In fact, it would be great to remove side effects
> from the c->match() functions in the long term (not in this patch set).

I see the motivation but I am afraid this is not possible until
side effects are removed from newcon->match() and match_console().
The point is that match_console() also calls newcon->setup() (side effect)
and this CON_ENABLED flag indicates if this call was successful.

>> I am going to fix v5 preserving both the check for duplicates
>> and the invariant, but tell me please if you prefer the v4 approach.
> 
> I guess that you planed to shuffle console_cmdline entries to keep
> the preferred console first/last. I am afraid that it won't be
> a nice code either. But I might be wrong.

You are right, I tried that, the code was awful.

Thank you
Aleksey Makarov

>>> The
>>> newcon->setup() call is called only when the console matches.
>>> AFAIK, there is only one braille console. We should be on
>>> the safe side if this one does not implement the match()
>>> callback. Or is it even more complicated?
>>
>> As you can see from the original code, the check for braille console
>> was performed in that branch of code where we missed newcon->match(),
>> so yes, it looks like braille console(s) does not have the match() method.
>> I used that in v4 to factor out matching for braille from the loop.
> 
> The check for blr_options is sufficient and better.
> 
> I suggest to wait at least two days until you spend to much time
> on reshuffling the code. It is possible that others would prefer
> v5 or suggest even other solution.
> 
> Best Regards,
> Petr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
