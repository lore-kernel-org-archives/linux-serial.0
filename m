From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] braille-console: Fix value returned by
 _braille_console_setup
Date: Fri, 24 Mar 2017 17:41:24 +0100
Message-ID: <20170324164124.GD10306@pathway.suse.cz>
References: <20170319143726.p6motwasbc2lfdao@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170319143726.p6motwasbc2lfdao@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Steven Rostedt <rostedt@goodmis.org>, Ming Lei <ming.lei@canonical.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun 2017-03-19 15:37:26, Samuel Thibault wrote:
> commit bbeddf52adc1 ("printk: move braille console support into
> separate braille.[ch] files") introduced _braille_console_setup()
> to outline the braille initialization code.  There was however some
> confusion over the value it was supposed to return. commit 2cfe6c4ac7ee
> ("printk: Fix return of braille_register_console()") tried to fix it
> but failed to.
> 
> This fixes and documents the returned value according to the use
> in printk.c: non-zero return means a parsing error, and thus this
> console configuration should be ignored.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
> Cc: Joe Perches <joe@perches.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Petr Mladek <pmladek@suse.com>
> 
> Index: linux-4.10/kernel/printk/braille.c
> ===================================================================
> --- linux-4.10.orig/kernel/printk/braille.c
> +++ linux-4.10/kernel/printk/braille.c
> @@ -2,12 +2,13 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/console.h>
> +#include <linux/errno.h>
>  #include <linux/string.h>
>  
>  #include "console_cmdline.h"
>  #include "braille.h"
>  
> -char *_braille_console_setup(char **str, char **brl_options)
> +int _braille_console_setup(char **str, char **brl_options)
>  {
>  	if (!strncmp(*str, "brl,", 4)) {
>  		*brl_options = "";
> @@ -15,14 +16,15 @@ char *_braille_console_setup(char **str,
>  	} else if (!strncmp(*str, "brl=", 4)) {
>  		*brl_options = *str + 4;
>  		*str = strchr(*brl_options, ',');
> -		if (!*str)
> +		if (!*str) {
>  			pr_err("need port name after brl=\n");
> +			return -EINVAL;
> +		}
>  		else

This "else" has become superfluous because there is return now.

>  			*((*str)++) = 0;
> -	} else
> -		return NULL;
> +	}
>  
> -	return *str;
> +	return 0;
>  }

Otherwise, the patch looks fine to me. With it, the logic is
exactly the same as before the commit bbeddf52adc1b4207674ab
("printk: move braille console support into separate braille.[ch]
files") that broke it.

With the superfluous "else" removed:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
