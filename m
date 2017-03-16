From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Thu, 16 Mar 2017 13:36:35 +0300
Message-ID: <19bad64a-f334-05f7-fb92-520ffc5c0b90@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170315102854.1763-4-aleksey.makarov@linaro.org>
 <20170315165858.GJ3977@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315165858.GJ3977@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 03/15/2017 07:58 PM, Petr Mladek wrote:
> On Wed 2017-03-15 13:28:52, Aleksey Makarov wrote:
>> If a console was specified by ACPI SPCR table _and_ command line
>> parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
>> then log messages appear twice.
>>
>> The root cause is that the code traverses the list of specified
>> consoles (the `console_cmdline` array) and stops at the first match.
>> But it may happen that the same console is referred by the elements
>> of this array twice:
>>
>> 	pl011,mmio,0x87e024000000,115200 -- from SPCR
>> 	ttyAMA0 -- from command line
>>
>> but in this case `preferred_console` points to the second entry and
>> the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
>>
>> To fix that, introduce an invariant "The last non-braille console
>> is always the preferred one" on the entries of the console_cmdline
>> array and don't try to check for double entries.  Then traverse it
>> in reverse order to be sure that if the console is preferred then
>> it will be the first matching entry.
>>
>> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  kernel/printk/printk.c | 45 +++++++++++++++++++++++++++++----------------
>>  1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index fd752f0c8ef1..7dc53b2831fb 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1902,20 +1902,25 @@ static int __add_preferred_console(char *name, int idx, char *options,
>>  	int i;
>>  
>>  	/*
>> -	 *	See if this tty is not yet registered, and
>> -	 *	if we have a slot free.
>> +	 * Don't check if the console has already been registered, because it is
>> +	 * pointless.  After all, we can not check if two entries refer to
>> +	 * the same console if one is matched with console->match(), and another
>> +	 * by name/index:
>> +	 *
>> +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
>> +	 *	ttyAMA0 -- added from command line
>> +	 *
>> +	 * Also this allows to maintain an invariant that will help to find if
>> +	 * the matching console is preferred, see register_console():
> 
> It is an interesting idea.
> 
> I just wonder if the check for duplicates was there for a serious
> reason. It is hard to say because it was already in the initial git
> commit. In each case, MAX_CMDLINECONSOLES is 8. There is not much
> space for duplicates.
> 
> Note that add_preferred_console() is called also from _probe() calls,
> see
> 
>    uart_add_one_port() -> of_console_check()
>    sunserial_console_match() -> add_preferred_console()
> 
> I wonder they might be called repeatedly, for example because
> of suspend/restore, hotplug, module load/unload.
> 
> I would feel more comfortable if we keep the check for
> duplicates here.

Now I see the problem, thank you.

> It is a pity that the console->match() calls have side effects.
> I still wonder if the 4th version might be more safe. 

I pushed v4 to the linaro git server:

https://git.linaro.org/people/aleksey.makarov/linux.git/commit/?h=amakarov/console2.19.v4&id=47a8227e37ca54d9cc7051abe9b3c2d072f4f75f

The problem with that approach is again a side effect.
Function match_console_name() can change newcon->index.
But it can be called in the very first pass that looks for braille console
and if the call to _braille_register_console() fails,
this newcon with changed index is passed to newcon->match().

This can be fixed by introducing a predicate that checks if the
console_cmdline entry has braille options and calling match_console_name()
only for such consoles, but I think that the code is too convoluted
and the v5 approach is better.

I am going to fix v5 preserving both the check for duplicates
and the invariant, but tell me please if you prefer the v4 approach.

> The
> newcon->setup() call is called only when the console matches.
> AFAIK, there is only one braille console. We should be on
> the safe side if this one does not implement the match()
> callback. Or is it even more complicated?

As you can see from the original code, the check for braille console
was performed in that branch of code where we missed newcon->match(),
so yes, it looks like braille console(s) does not have the match() method.
I used that in v4 to factor out matching for braille from the loop.

Thank you
Aleksey Makarov

> To be honest, I am not much familiar with the console registration
> code. I am still trying to get a better picture. It is pity that
> many function have unexpected side effects.
> 
> Best Regards,
> Petr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
