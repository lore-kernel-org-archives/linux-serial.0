From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Mon, 27 Mar 2017 16:14:33 +0200
Message-ID: <20170327141432.GH2846@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170320100302.8656-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon 2017-03-20 13:03:00, Aleksey Makarov wrote:
> If a console was specified by ACPI SPCR table _and_ command line
> parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> then log messages appear twice.
> 
> The root cause is that the code traverses the list of specified
> consoles (the `console_cmdline` array) and stops at the first match.
> But it may happen that the same console is referred by the elements
> of this array twice:
> 
> 	pl011,mmio,0x87e024000000,115200 -- from SPCR
> 	ttyAMA0 -- from command line
> 
> but in this case `preferred_console` points to the second entry and
> the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
> 
> To fix that, introduce an invariant "The last non-braille console
> is always the preferred one" on the entries of the console_cmdline
> array.  Then traverse it in reverse order to be sure that if
> the console is preferred then it will be the first matching entry.

Sigh, I am afraid that we need to go this way. I hate the side
effects of the match() functions. It would be great to get
rid of them. But it is non-trivial and out of scope for this fix.


> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fd752f0c8ef1..462036e7a767 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1909,8 +1909,28 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>  	     i++, c++) {
>  		if (strcmp(c->name, name) == 0 && c->index == idx) {
> -			if (!brl_options)
> -				preferred_console = i;
> +			int last;
> +
> +			if (brl_options)
> +				return 0;
> +
> +			/*
> +			 * Maintain an invariant that will help to find if
> +			 * the matching console is preferred, see
> +			 * register_console():
> +			 *
> +			 * The last non-braille console is always
> +			 * the preferred one.
> +			 */
> +			for (last = MAX_CMDLINECONSOLES - 1;
> +			     last >= 0 && !console_cmdline[last].name[0];
> +			     last--)
> +				;

This is a rather non-trivial code to find the last element.
I might make sense to count it in a global variable.
Then we might remove the check for console_cmdline[i].name[0]
also in the other for cycles and make them better readable.

> +
> +			if (i != last)
> +				swap(console_cmdline[i], console_cmdline[last]);

I was not aware of the swap() function. It is great to know ;-)

Otherwise, I am find with this approach.

Best Regards,
Petr
