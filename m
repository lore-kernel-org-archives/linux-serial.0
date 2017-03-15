From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5 3/3] printk: fix double printing with earlycon
Date: Wed, 15 Mar 2017 17:58:58 +0100
Message-ID: <20170315165858.GJ3977@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170315102854.1763-4-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170315102854.1763-4-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed 2017-03-15 13:28:52, Aleksey Makarov wrote:
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
> array and don't try to check for double entries.  Then traverse it
> in reverse order to be sure that if the console is preferred then
> it will be the first matching entry.
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  kernel/printk/printk.c | 45 +++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fd752f0c8ef1..7dc53b2831fb 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1902,20 +1902,25 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	int i;
>  
>  	/*
> -	 *	See if this tty is not yet registered, and
> -	 *	if we have a slot free.
> +	 * Don't check if the console has already been registered, because it is
> +	 * pointless.  After all, we can not check if two entries refer to
> +	 * the same console if one is matched with console->match(), and another
> +	 * by name/index:
> +	 *
> +	 *	pl011,mmio,0x87e024000000,115200 -- added from SPCR
> +	 *	ttyAMA0 -- added from command line
> +	 *
> +	 * Also this allows to maintain an invariant that will help to find if
> +	 * the matching console is preferred, see register_console():

It is an interesting idea.

I just wonder if the check for duplicates was there for a serious
reason. It is hard to say because it was already in the initial git
commit. In each case, MAX_CMDLINECONSOLES is 8. There is not much
space for duplicates.

Note that add_preferred_console() is called also from _probe() calls,
see

   uart_add_one_port() -> of_console_check()
   sunserial_console_match() -> add_preferred_console()

I wonder they might be called repeatedly, for example because
of suspend/restore, hotplug, module load/unload.

I would feel more comfortable if we keep the check for
duplicates here.

It is a pity that the console->match() calls have side effects.
I still wonder if the 4th version might be more safe. The
newcon->setup() call is called only when the console matches.
AFAIK, there is only one braille console. We should be on
the safe side if this one does not implement the match()
callback. Or is it even more complicated?

To be honest, I am not much familiar with the console registration
code. I am still trying to get a better picture. It is pity that
many function have unexpected side effects.

Best Regards,
Petr
