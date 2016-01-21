From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] 8250: uniphier: allow modular build with 8250 console
Date: Thu, 21 Jan 2016 20:39:03 +0900
Message-ID: <CAK7LNATVtLk6UTh+r9JTZrKq-veEXetDdRutZ_=zQOd-WyAO0g@mail.gmail.com>
References: <3965359.aMgb8o9MaG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3965359.aMgb8o9MaG@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,


2016-01-14 7:33 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The recently added uniphier 8250 port driver supports early console
> probing, and it supports being built as a module, but the combination
> of the two fails to link:
>
> ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!
>
> Given that earlycon support in a loadable module makes no sense,
> making that code conditional on 'MODULE' is a correct solution.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b8d20e06eaad ("serial: 8250_uniphier: add earlycon support")
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index bab6b3ae2540..1b7bd26555b7 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -35,7 +35,7 @@ struct uniphier8250_priv {
>         spinlock_t atomic_write_lock;
>  };
>
> -#ifdef CONFIG_SERIAL_8250_CONSOLE
> +#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
>  static int __init uniphier_early_console_setup(struct earlycon_device *device,
>                                                const char *options)
>  {
>
>


If my patch (https://patchwork.kernel.org/patch/8029331/) is accepted,
this build error will be fixed as well.  But I doubt it is accepted soon...

So, I am OK with this workaround to fix "make allmodconfig".

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
