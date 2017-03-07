From: Aleksey Makarov <amakarov.linux@gmail.com>
Subject: Re: [PATCH v3 3/3] printk: fix double printing with earlycon
Date: Tue, 7 Mar 2017 15:54:43 +0100
Message-ID: <563502ae-1560-9dca-fe5b-4ec627c567f8@gmail.com>
References: <20170302131153.22733-4-aleksey.makarov@linaro.org>
 <20170303154946.15399-1-aleksey.makarov@linaro.org>
 <20170306145933.GB425@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170306145933.GB425@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org



On 03/06/2017 03:59 PM, Sergey Senozhatsky wrote:
> On (03/03/17 18:49), Aleksey Makarov wrote:
> [..]
>> +static enum { CONSOLE_MATCH, CONSOLE_MATCH_RETURN, CONSOLE_MATCH_NEXT }
>> +match_console(struct console *newcon, struct console_cmdline *c)
>
> that enum in function return is interesting :)
> can we make it less hackish?

We probably can, but I can not figure out how to do that.
Suggestions will be appreciated.
We should signal 3 different outcomes.
I thought that using standard errnos is not quite desciptive.

>> +	if (!newcon->match ||
>> +	    newcon->match(newcon, c->name, c->index, c->options) != 0) {
>> +		/* default matching */
>> +		BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
>> +		if (strcmp(c->name, newcon->name) != 0)
>> +			return CONSOLE_MATCH_NEXT;
>> +		if (newcon->index >= 0 && newcon->index != c->index)
>> +			return CONSOLE_MATCH_NEXT;
>
> who is checking CONSOLE_MATCH_NEXT?

The caller checks two other values,  this one goes under the default case.
Should I check it explicitly?

>> +		if (newcon->index < 0)
>> +			newcon->index = c->index;
>> +
>> +		if (_braille_register_console(newcon, c))
>> +			return CONSOLE_MATCH_RETURN;
>> +
>> +		if (newcon->setup &&
>> +		    newcon->setup(newcon, c->options) != 0)
>> +			return CONSOLE_MATCH;
>> +	}
>> +
>> +	newcon->flags |= CON_ENABLED;
>> +	return CONSOLE_MATCH;
>> +}
>> +
>>  /*
>>   * The console driver calls this routine during kernel initialization
>>   * to register the console printing procedure with printk() and to
>> @@ -2454,40 +2480,50 @@ void register_console(struct console *newcon)
>>  	}
>>
>>  	/*
>> +	 * Check if this console was set as preferred by command line parameters
>> +	 * or by call to add_preferred_console().  There may be several entries
>> +	 * in the console_cmdline array matching with the same console so we
>> +	 * can not just use the first match.  Instead check the entry pointed
>> +	 * by preferred_console and then all other entries.
>> +	 */
>> +	if (preferred_console >= 0) {
>> +		switch (match_console(newcon,
>> +				      console_cmdline + preferred_console)) {
>> +		case CONSOLE_MATCH:
>> +			if (newcon->flags | CON_ENABLED) {
>
> 			newcon->flags & CON_ENABLED  ?

Sure.  Thank you.

>> +				newcon->flags |= CON_CONSDEV;
>> +				has_preferred = true;
>> +			}
>> +			goto match;
>> +		case CONSOLE_MATCH_RETURN:
>> +			return;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	/*
>>  	 *	See if this console matches one we selected on
>>  	 *	the command line.
>>  	 */
>>  	for (i = 0, c = console_cmdline;
>>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>>  	     i++, c++) {
>> -		if (!newcon->match ||
>> -		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
>> -			/* default matching */
>> -			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
>> -			if (strcmp(c->name, newcon->name) != 0)
>> -				continue;
>> -			if (newcon->index >= 0 &&
>> -			    newcon->index != c->index)
>> -				continue;
>> -			if (newcon->index < 0)
>> -				newcon->index = c->index;
>> -
>> -			if (_braille_register_console(newcon, c))
>> -				return;
>>
>> -			if (newcon->setup &&
>> -			    newcon->setup(newcon, c->options) != 0)
>> -				break;
>> -		}
>> +		if (preferred_console == i)
>> +			continue;
>>
>> -		newcon->flags |= CON_ENABLED;
>> -		if (i == preferred_console) {
>> -			newcon->flags |= CON_CONSDEV;
>> -			has_preferred = true;
>> +		switch (match_console(newcon, c)) {
>> +		case CONSOLE_MATCH:
>> +			goto match;
>> +		case CONSOLE_MATCH_RETURN:
>> +			return;
>> +		default:
>> +			break;
>
> sorry, it was a rather long for me today. need to look more at this.
> for what is now CONSOLE_MATCH_NEXT we used to have continue,

CONSOLE_MATCH is for the case when the console matches against the description,
CONSOLE_MATCH_NEXT - it does not, we should try next,
CONSOLE_MATCH_RETURN - we should return as the braille console is registered now.

> and now we break out of the loop?

`goto match` or just when we have seen all the entries

Thank you
Aleksey Makarov

>
> 	-ss
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
