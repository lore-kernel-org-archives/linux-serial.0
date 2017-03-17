From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH v6 3/3] printk: fix double printing with earlycon
Date: Fri, 17 Mar 2017 16:34:49 +0300
Message-ID: <41e6e6c2-880d-0228-f912-1bf58cac1eb3@linaro.org>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170317114348.30215-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317114348.30215-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org



On 03/17/2017 02:43 PM, Aleksey Makarov wrote:

[..]

> @@ -2457,40 +2491,50 @@ void register_console(struct console *newcon)
>  	}
>  
>  	/*
> -	 *	See if this console matches one we selected on
> -	 *	the command line.
> +	 * See if this console matches one we selected on the command line.
> +	 * Do it in three steps:
> +	 *
> +	 * 1) check if it is a braille console..
>  	 */
> -	for (i = 0, c = console_cmdline;
> -	     i < MAX_CMDLINECONSOLES && c->name[0];
> -	     i++, c++) {
> -		if (!newcon->match ||
> -		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
> -			/* default matching */
> -			BUILD_BUG_ON(sizeof(c->name) != sizeof(newcon->name));
> -			if (strcmp(c->name, newcon->name) != 0)
> -				continue;
> -			if (newcon->index >= 0 &&
> -			    newcon->index != c->index)
> -				continue;
> -			if (newcon->index < 0)
> -				newcon->index = c->index;
> -
> -			if (_braille_register_console(newcon, c))
> -				return;
> -
> -			if (newcon->setup &&
> -			    newcon->setup(newcon, c->options) != 0)
> -				break;
> -		}
> +	for_each_console_cmdline(i, c)
> +		if (_braille_is_braille_console(c) &&
> +		    match_console_name(newcon, c) &&
> +		    _braille_register_console(newcon, c))
> +			return;

I am sorry to say that, but it looks like this does not work either.
newcon->index still can be changed here in match_console_name(), 
but (correctly implemented) _braille_register_console() may refuse
to register it, and the changed newcon is passed to newcon->match() below.

I tried the shuffle (i. e. v5) approach again and it seems I managed to
write quite nice code.  I am going to send it in a minute.

Thank you
Aleksey Makarov

> -		newcon->flags |= CON_ENABLED;
> -		if (i == preferred_console) {
> +	/*
> +	 * 2) check if this console was set as preferred by command line
> +	 * parameters or by call to add_preferred_console().  There may be
> +	 * several entries in the console_cmdline array matching with the same
> +	 * console, one with newcon->match(), another by name/index:
> +	 *
> +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
> +	 *	ttyAMA0 -- added from command line
> +	 *
> +	 * so we can not use the first match.  Instead check the
> +	 * entry pointed by preferred_console and then all other entries.
> +	 */
> +	if (preferred_console >= 0 &&
> +	    match_console(newcon, console_cmdline + preferred_console)) {
> +		if (newcon->flags & CON_ENABLED) {
>  			newcon->flags |= CON_CONSDEV;
>  			has_preferred = true;
>  		}
> -		break;
> +		goto match;
> +	}
> +
> +	/*
> +	 * 3) check other entries
> +	 */
> +	for_each_console_cmdline(i, c) {
> +		if (preferred_console == i || _braille_is_braille_console(c))
> +			continue;
> +
> +		if (match_console(newcon, c))
> +			goto match;
>  	}
>  
> +match:
>  	if (!(newcon->flags & CON_ENABLED))
>  		return;
>  
> 
