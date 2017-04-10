From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Mon, 10 Apr 2017 21:00:35 +0300
Message-ID: <0514db53-4f8b-fa08-f461-902de85777ee@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170410142214.GA3452@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410142214.GA3452@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 04/10/2017 05:22 PM, Petr Mladek wrote:
> On Wed 2017-04-05 23:20:00, Aleksey Makarov wrote:
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
>> array.  Then traverse it in reverse order to be sure that if
>> the console is preferred then it will be the first matching entry.
>> Introduce variable console_cmdline_cnt that keeps the number
>> of elements of the console_cmdline array (Petr Mladek).  It helps
>> to get rid of the loop that searches for the end of this array.
>>
>> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> 
> This version looks fine to me. Just a small nitpick below.
> Anyway:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thank you for review.  Can you (or anybody else) ACK it?
I am going to resend the whole series without those empty lines.
May I add your Acked-by:?

Thank you
Aleksey Makarov

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index fd752f0c8ef1..be657af45758 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -269,6 +269,7 @@ static struct console *exclusive_console;
>>   #define MAX_CMDLINECONSOLES 8
>>   
>>   static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
>> +static int console_cmdline_cnt;
>>   
>>   static int preferred_console = -1;
>>   int console_set_on_cmdline;
>> @@ -1905,12 +1906,26 @@ static int __add_preferred_console(char *name, int idx, char *options,
>>   	 *	See if this tty is not yet registered, and
>>   	 *	if we have a slot free.
>>   	 */
>> -	for (i = 0, c = console_cmdline;
>> -	     i < MAX_CMDLINECONSOLES && c->name[0];
>> -	     i++, c++) {
>> +	for (i = 0, c = console_cmdline; i < console_cmdline_cnt; i++, c++) {
>>   		if (strcmp(c->name, name) == 0 && c->index == idx) {
>> -			if (!brl_options)
>> -				preferred_console = i;
>> +
> 
> This extra new line is non-standard and looks slightly weird to me.
> I just point it out. I personally do not mind ;-)
> 
> 
>> +			if (brl_options)
>> +				return 0;
>> +
>> +			/*
>> +			 * Maintain an invariant that will help to find if
>> +			 * the matching console is preferred, see
>> +			 * register_console():
>> +			 *
>> +			 * The last non-braille console is always
>> +			 * the preferred one.
>> +			 */
>> +			if (i != console_cmdline_cnt - 1)
>> +				swap(console_cmdline[i],
>> +				     console_cmdline[console_cmdline_cnt - 1]);
>> +
>> +			preferred_console = console_cmdline_cnt - 1;
>> +
>>   			return 0;
>>   		}
>>   	}
>> @@ -2457,12 +2473,24 @@ void register_console(struct console *newcon)
>>   	}
>>   
>>   	/*
>> -	 *	See if this console matches one we selected on
>> -	 *	the command line.
>> +	 * See if this console matches one we selected on the command line.
>> +	 *
>> +	 * There may be several entries in the console_cmdline array matching
>> +	 * with the same console, one with newcon->match(), another by
>> +	 * name/index:
>> +	 *
>> +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
>> +	 *	ttyAMA0 -- added from command line
>> +	 *
>> +	 * Traverse the console_cmdline array in reverse order to be
>> +	 * sure that if this console is preferred then it will be the first
>> +	 * matching entry.  We use the invariant that is maintained in
>> +	 * __add_preferred_console().
>>   	 */
>> -	for (i = 0, c = console_cmdline;
>> -	     i < MAX_CMDLINECONSOLES && c->name[0];
>> -	     i++, c++) {
>> +	for (i = console_cmdline_cnt - 1; i >= 0; i--) {
>> +
> 
> Same here.
> 
>> +		c = console_cmdline + i;
>> +
>>   		if (!newcon->match ||
>>   		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
>>   			/* default matching */
> 
> Best Regards,
> Petr
> 
