From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Mon, 27 Mar 2017 19:28:07 +0300
Message-ID: <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
 <20170327141432.GH2846@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327141432.GH2846@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org



On 03/27/2017 05:14 PM, Petr Mladek wrote:
> On Mon 2017-03-20 13:03:00, Aleksey Makarov wrote:

[..]

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index fd752f0c8ef1..462036e7a767 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1909,8 +1909,28 @@ static int __add_preferred_console(char *name, int idx, char *options,
>>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>>  	     i++, c++) {
>>  		if (strcmp(c->name, name) == 0 && c->index == idx) {
>> -			if (!brl_options)
>> -				preferred_console = i;
>> +			int last;
>> +
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
>> +			for (last = MAX_CMDLINECONSOLES - 1;
>> +			     last >= 0 && !console_cmdline[last].name[0];
>> +			     last--)
>> +				;
>
> This is a rather non-trivial code to find the last element.
> I might make sense to count it in a global variable.
> Then we might remove the check for console_cmdline[i].name[0]
> also in the other for cycles and make them better readable.

Having an additional variable console_cmdline_last pointing to the last element
would require maintaining consistency between this variable and
contents of console_cmdline.  For the code we have it is not hard, but when code
is changed we need to check this.  Also there exists preferred_console that
has almost the same meaning but it points not to the last element, but to the
last non-braille element.  Also we need to have a special value (-1) for this
variable for empty array. So I personally would instead try to rewrite this:

	for (last = MAX_CMDLINECONSOLES - 1; last >= 0; last--)
		if (console_cmdline[last].name[0])
			break;

Is it better?  If not, I will send a version with console_cmdline_last.

>> +
>> +			if (i != last)
>> +				swap(console_cmdline[i], console_cmdline[last]);
>
> I was not aware of the swap() function. It is great to know ;-)

Yes, same for me.  Thanks to Sergey Senozhatsky.

Thank you for review
Aleksey Makarov
