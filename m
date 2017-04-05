From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Thu, 6 Apr 2017 00:57:13 +0300
Message-ID: <CAHp75Ve1n7iK0zrUOdjkKxrj-ggbJXpau=CG8dam+1DkDL_fyw@mail.gmail.com>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org> <20170405202006.18234-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170405202006.18234-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Apr 5, 2017 at 11:20 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> If a console was specified by ACPI SPCR table _and_ command line
> parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> then log messages appear twice.
>
> The root cause is that the code traverses the list of specified
> consoles (the `console_cmdline` array) and stops at the first match.
> But it may happen that the same console is referred by the elements
> of this array twice:
>
>         pl011,mmio,0x87e024000000,115200 -- from SPCR
>         ttyAMA0 -- from command line
>
> but in this case `preferred_console` points to the second entry and
> the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
>
> To fix that, introduce an invariant "The last non-braille console
> is always the preferred one" on the entries of the console_cmdline
> array.  Then traverse it in reverse order to be sure that if
> the console is preferred then it will be the first matching entry.
> Introduce variable console_cmdline_cnt that keeps the number
> of elements of the console_cmdline array (Petr Mladek).  It helps
> to get rid of the loop that searches for the end of this array.

>  #define MAX_CMDLINECONSOLES 8
>
>  static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
> +static int console_cmdline_cnt;

This should be equal to -1 at the beginning, am I right?

>  static int preferred_console = -1;
>  int console_set_on_cmdline;
> @@ -1905,12 +1906,26 @@ static int __add_preferred_console(char *name, int idx, char *options,
>          *      See if this tty is not yet registered, and
>          *      if we have a slot free.
>          */
> -       for (i = 0, c = console_cmdline;
> -            i < MAX_CMDLINECONSOLES && c->name[0];
> -            i++, c++) {
> +       for (i = 0, c = console_cmdline; i < console_cmdline_cnt; i++, c++) {
>                 if (strcmp(c->name, name) == 0 && c->index == idx) {
> -                       if (!brl_options)
> -                               preferred_console = i;
> +

> +                       if (brl_options)
> +                               return 0;

Is it invariant or brl_options may appear while looping?

> +
> +                       /*
> +                        * Maintain an invariant that will help to find if
> +                        * the matching console is preferred, see
> +                        * register_console():
> +                        *
> +                        * The last non-braille console is always
> +                        * the preferred one.
> +                        */
> +                       if (i != console_cmdline_cnt - 1)
> +                               swap(console_cmdline[i],
> +                                    console_cmdline[console_cmdline_cnt - 1]);

i'm wondering if you can iterate from the end to beginning as you do below.
It would simplify things.

> +
> +                       preferred_console = console_cmdline_cnt - 1;
> +
>                         return 0;
>                 }
>         }
> @@ -1923,6 +1938,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
>         braille_set_options(c, brl_options);
>
>         c->index = idx;
> +       console_cmdline_cnt++;
>         return 0;
>  }
>  /*
> @@ -2457,12 +2473,24 @@ void register_console(struct console *newcon)
>         }
>
>         /*
> -        *      See if this console matches one we selected on
> -        *      the command line.
> +        * See if this console matches one we selected on the command line.
> +        *
> +        * There may be several entries in the console_cmdline array matching
> +        * with the same console, one with newcon->match(), another by
> +        * name/index:
> +        *
> +        *      pl011,mmio,0x87e024000000,115200 -- added from SPCR
> +        *      ttyAMA0 -- added from command line
> +        *
> +        * Traverse the console_cmdline array in reverse order to be
> +        * sure that if this console is preferred then it will be the first
> +        * matching entry.  We use the invariant that is maintained in
> +        * __add_preferred_console().
>          */
> -       for (i = 0, c = console_cmdline;
> -            i < MAX_CMDLINECONSOLES && c->name[0];
> -            i++, c++) {

> +       for (i = console_cmdline_cnt - 1; i >= 0; i--) {



> +
> +               c = console_cmdline + i;
> +
>                 if (!newcon->match ||
>                     newcon->match(newcon, c->name, c->index, c->options) != 0) {
>                         /* default matching */
> --
> 2.12.1
>



-- 
With Best Regards,
Andy Shevchenko
