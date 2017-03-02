From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] printk: fix name and type of some variables
Date: Wed, 1 Mar 2017 21:24:35 -0500
Message-ID: <20170301212435.79db12c6@grimm.local.home>
References: <20170301161347.4202-1-aleksey.makarov@linaro.org>
        <20170301161347.4202-2-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301161347.4202-2-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed,  1 Mar 2017 19:13:45 +0300
Aleksey Makarov <aleksey.makarov@linaro.org> wrote:

> The variable preferred_console is used only inside register_console()
> and its semantics is boolean.  It is negative when no console has been
> made preferred.
> 
> The variable selected_console holds an index into the console_cmdline
> array, pointing to the console that was made preferred.
> 
> Rename the variables:
> selected_console -> preferred_console
> preferred_console -> has_preferred
> and make the new has_preferred local static bool.

I like the conversion to the boolean, but I'm thinking I prefer
selected_console. The console command line is always confusing about
which one it uses (I can't remember if it's the first or the last one),
thus it may not really be preferred, and just selected ;-)

That said, I'm fine with the patch. What do others think? Keep
"selected_console" over "preferred_console". Not to mention, that
rename makes reviewing this patch a bit more complex.

If anything, perhaps break this patch up into two. The
non-controversial boolean change, and then the rename of
selected_console to preferred_console. That way we can ack one and nak
the other ;-)

-- Steve

> 
> Renaming was suggested by Peter Hurley
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Tested-by: Christopher Covington <cov@codeaurora.org>
> ---
>  kernel/printk/printk.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 34da86e73d00..ed2a9b31f214 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -267,7 +267,6 @@ static struct console *exclusive_console;
>  
>  static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
>  
> -static int selected_console = -1;
>  static int preferred_console = -1;
>  int console_set_on_cmdline;
>  EXPORT_SYMBOL(console_set_on_cmdline);
> @@ -1908,14 +1907,14 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	     i++, c++) {
>  		if (strcmp(c->name, name) == 0 && c->index == idx) {
>  			if (!brl_options)
> -				selected_console = i;
> +				preferred_console = i;
>  			return 0;
>  		}
>  	}
>  	if (i == MAX_CMDLINECONSOLES)
>  		return -E2BIG;
>  	if (!brl_options)
> -		selected_console = i;
> +		preferred_console = i;
>  	strlcpy(c->name, name, sizeof(c->name));
>  	c->options = options;
>  	braille_set_options(c, brl_options);
> @@ -2406,6 +2405,7 @@ void register_console(struct console *newcon)
>  	unsigned long flags;
>  	struct console *bcon = NULL;
>  	struct console_cmdline *c;
> +	static bool has_preferred;
>  
>  	if (console_drivers)
>  		for_each_console(bcon)
> @@ -2432,15 +2432,15 @@ void register_console(struct console *newcon)
>  	if (console_drivers && console_drivers->flags & CON_BOOT)
>  		bcon = console_drivers;
>  
> -	if (preferred_console < 0 || bcon || !console_drivers)
> -		preferred_console = selected_console;
> +	if (!has_preferred || bcon || !console_drivers)
> +		has_preferred = preferred_console >= 0;
>  
>  	/*
>  	 *	See if we want to use this console driver. If we
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
>  	 */
> -	if (preferred_console < 0) {
> +	if (!has_preferred) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
>  		if (newcon->setup == NULL ||
> @@ -2448,7 +2448,7 @@ void register_console(struct console *newcon)
>  			newcon->flags |= CON_ENABLED;
>  			if (newcon->device) {
>  				newcon->flags |= CON_CONSDEV;
> -				preferred_console = 0;
> +				has_preferred = true;
>  			}
>  		}
>  	}
> @@ -2481,9 +2481,9 @@ void register_console(struct console *newcon)
>  		}
>  
>  		newcon->flags |= CON_ENABLED;
> -		if (i == selected_console) {
> +		if (i == preferred_console) {
>  			newcon->flags |= CON_CONSDEV;
> -			preferred_console = selected_console;
> +			has_preferred = true;
>  		}
>  		break;
>  	}
