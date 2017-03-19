From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Re: [PATCH] braille-console: Fix value returned by
 _braille_console_setup
Date: Sun, 19 Mar 2017 18:44:23 +0300
Message-ID: <0e1043b5-c585-5f4a-cde7-1afd60c0db56@linaro.org>
References: <20170319143726.p6motwasbc2lfdao@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170319143726.p6motwasbc2lfdao@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Ming Lei <ming.lei@canonical.com>, linux-serial@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/19/2017 05:37 PM, Samuel Thibault wrote:
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

Did you test the code on real braille hardware?
I am asking because there could also be other problems with the code
that have not been run for 3 years since it was changed.

Thank you
Aleksey Makarov

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
>  			*((*str)++) = 0;
> -	} else
> -		return NULL;
> +	}
>
> -	return *str;
> +	return 0;
>  }
>
>  int
> Index: linux-4.10/kernel/printk/braille.h
> ===================================================================
> --- linux-4.10.orig/kernel/printk/braille.h
> +++ linux-4.10/kernel/printk/braille.h
> @@ -9,7 +9,14 @@ braille_set_options(struct console_cmdli
>  	c->brl_options = brl_options;
>  }
>
> -char *
> +/*
> + * Setup console according to braille options.
> + * Return -EINVAL on syntax error, 0 on success (or no braille option was
> + * actually given).
> + * Modifies str to point to the serial options
> + * Sets brl_options to the parsed braille options.
> + */
> +int
>  _braille_console_setup(char **str, char **brl_options);
>
>  int
> @@ -25,10 +32,10 @@ braille_set_options(struct console_cmdli
>  {
>  }
>
> -static inline char *
> +static inline int
>  _braille_console_setup(char **str, char **brl_options)
>  {
> -	return NULL;
> +	return 0;
>  }
>
>  static inline int
>
