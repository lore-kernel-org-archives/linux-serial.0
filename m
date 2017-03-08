From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v3 3/3] printk: fix double printing with earlycon
Date: Wed, 8 Mar 2017 13:59:46 +0100
Message-ID: <dd963e8e-e2f7-30a7-13ac-ccd58c53aaa3@gmail.com>
References: <20170302131153.22733-4-aleksey.makarov@linaro.org>
 <20170303154946.15399-1-aleksey.makarov@linaro.org>
 <20170306145933.GB425@tigerII.localdomain>
 <563502ae-1560-9dca-fe5b-4ec627c567f8@gmail.com>
 <20170308053337.GA6776@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308053337.GA6776@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org



On 03/08/2017 06:33 AM, Sergey Senozhatsky wrote:
> Hello,
>
> sorry for the delay.
>
> On (03/07/17 15:54), Aleksey Makarov wrote:
>> On 03/06/2017 03:59 PM, Sergey Senozhatsky wrote:
>>> On (03/03/17 18:49), Aleksey Makarov wrote:
>>> [..]
>>>> +static enum { CONSOLE_MATCH, CONSOLE_MATCH_RETURN, CONSOLE_MATCH_NEXT }
>>>> +match_console(struct console *newcon, struct console_cmdline *c)
>>>
>>> that enum in function return is interesting :)
>>> can we make it less hackish?
>> We probably can, but I can not figure out how to do that.
>> Suggestions will be appreciated.
>> We should signal 3 different outcomes.
>> I thought that using standard errnos is not quite desciptive.
>
> no problems with the enum on its own. errnos probably can also do
> the trick.
>
> the way it's defined, however, is a bit unusual and may be
> inconvenient - we can add, say, 5 more CONSOLE_MATCH_FOO someday
> in the future and match_console() function definition thus will be:
>
> static enum { CONSOLE_MATCH, CONSOLE_MATCH_RETURN, CONSOLE_MATCH_NEXT,
> 		CONSOLE_MATCH_FOO1, CONSOLE_MATCH_FOO2,
> 		CONSOLE_MATCH_FOO3, CONSOLE_MATCH_FOO4,
> 		CONSOLE_MATCH_FOO5}
> match_console(struct console *newcon, struct console_cmdline *c)
> {
> 	...
> }
>
> or something like this
>
> static enum { CONSOLE_MATCH,
> 	CONSOLE_MATCH_RETURN,
> 	CONSOLE_MATCH_NEXT,
> 	CONSOLE_MATCH_FOO1,
> 	CONSOLE_MATCH_FOO2,
> 	CONSOLE_MATCH_FOO3,
> 	CONSOLE_MATCH_FOO4,
> 	CONSOLE_MATCH_FOO5 }
> match_console(struct console *newcon, struct console_cmdline *c)
> {
> 	..
> }
>
> or anything else. which is, to my admittedly imperfect taste, slightly
> "unpretty".

I agree that this enum thing does not look good and I have an idea how to
get rid of it completely.  The idea is to factor out the braille
code to a separate pass.  That way the match function can return a boolean
value.    

I am traveling now so I will need some time to
send a new version of this patch.

Thank you
Aleksey Makarov

>
> [..]
>>>> +	/*
>>>>  	 *	See if this console matches one we selected on
>>>>  	 *	the command line.
>>>>  	 */
>>>>  	for (i = 0, c = console_cmdline;
>>>>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>>>>  	     i++, c++) {
>>>> -		if (!newcon->match ||
>>>> -		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
>>>> -			/* default matching */
>>>> -			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
>>>> -			if (strcmp(c->name, newcon->name) != 0)
>>>> -				continue;
>>>> -			if (newcon->index >= 0 &&
>>>> -			    newcon->index != c->index)
>>>> -				continue;
>>>> -			if (newcon->index < 0)
>>>> -				newcon->index = c->index;
>>>> -
>>>> -			if (_braille_register_console(newcon, c))
>>>> -				return;
>>>>
>>>> -			if (newcon->setup &&
>>>> -			    newcon->setup(newcon, c->options) != 0)
>>>> -				break;
>>>> -		}
>>>> +		if (preferred_console == i)
>>>> +			continue;
>>>>
>>>> -		newcon->flags |= CON_ENABLED;
>>>> -		if (i == preferred_console) {
>>>> -			newcon->flags |= CON_CONSDEV;
>>>> -			has_preferred = true;
>>>> +		switch (match_console(newcon, c)) {
>>>> +		case CONSOLE_MATCH:
>>>> +			goto match;
>>>> +		case CONSOLE_MATCH_RETURN:
>>>> +			return;
>>>> +		default:
>>>> +			break;
>>>
>>> sorry, it was a rather long for me today. need to look more at this.
>>> for what is now CONSOLE_MATCH_NEXT we used to have continue,
>>
>> CONSOLE_MATCH is for the case when the console matches against the description,
>> CONSOLE_MATCH_NEXT - it does not, we should try next,
>
> my bad, sorry. I misread the patch: there was another `break' right after
> that switch, that you have removed; and I just wrongly concluded that
> CONSOLE_MATCH_NEXT would now 'break' from 'default' label *and* `break'
> from the console_cmdline loop right after it.
>
> bikeshedding:
> may be explicit CONSOLE_MATCH_NEXT test will save us from problems (in
> case if match_console() will return more codes someday), may be it won't.
> hard to say. 'default: continue' is probably OK. or may be can do without
> that 'match' label at all. something like this (_may be_)
>
> 	for (i = 0, c = console_cmdline; ... ) {
> 		if (preferred_console == i)
> 			continue;
>
> 		match = match_console(newcon, c);
> 		if (match == CONSOLE_MATCH_NEXT)
> 			continue;
> 		if (match == CONSOLE_MATCH_FOUND)
> 			break;
> 		if (match == CONSOLE_MATCH_STOP)
> 			return;
> 	}
> 	...
>
>
>
> CONSOLE_MATCH_RETURN  -  basically means that we should stop matching.
> can we thus rename it to CONSOLE_MATCH_STOP, or similar?
>
> 	match_console() returned CONSOLE_MATCH_STOP
>
> is a bit better than
>
> 	match_console() returned CONSOLE_MATCH_RETURN.
>
> isn't it? :)
>
>
> // I also used CONSOLE_MATCH_FOUND in the example above instead of
> // CONSOLE_MATCH. not insisting that CONSOLE_MATCH_FOUND is much
> // better than CONSOLE_MATCH though.
>
> 	-ss
>
