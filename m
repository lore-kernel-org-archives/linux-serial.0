From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 4/6] serial: 8250/uniphier: fix modular build
Date: Fri, 12 Feb 2016 18:37:08 +0900
Message-ID: <CAK7LNAR8fJWPubucjw28gAPpF-4yvVMWZZ0F3j6VN4whGF9Yhw@mail.gmail.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
	<1455205297-1021302-5-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-5-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,




2016-02-12 0:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The newly added uniphier serial port driver fails to build as
> a loadable module when the base 8250 driver is built-in and
> its console support enabled:
>
> ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!
>
> This changes the driver to only provide the early console support
> if it is built-in itself as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> --
> 2.7.0
>

I noticed commit 2eaa790989e03900298ad24f77f1086dbbc1aebd
revived this link error, but I am not happy with seeing
this patch again and again.


Can you check this patch?
https://patchwork.kernel.org/patch/8289231/



-- 
Best Regards
Masahiro Yamada
