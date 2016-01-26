From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH] 8250: uniphier: allow modular build with 8250 console
Date: Tue, 26 Jan 2016 10:48:53 +0900
Message-ID: <CAK7LNAQoqS0mwkyR9pTJVEDjWYDuhWQYqrMJxWSRQ-bwk51FXw@mail.gmail.com>
References: <3965359.aMgb8o9MaG@wuerfel>
	<CAK7LNATVtLk6UTh+r9JTZrKq-veEXetDdRutZ_=zQOd-WyAO0g@mail.gmail.com>
	<4548262.MV5j98YUVi@wuerfel>
	<CAL_JsqKCnxenDN-5OP1yqAyyW1-cuhs47CeosAj12hr89e6CrA@mail.gmail.com>
	<CAK7LNARo+rpKVDAY_h9vPKh_1vteYgjNS=nf0ukz2ThzPNxvmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNARo+rpKVDAY_h9vPKh_1vteYgjNS=nf0ukz2ThzPNxvmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Just for clarification:

The build error was fixed by another patch
(https://patchwork.kernel.org/patch/8082931/)

So, this one is unneeded.



2016-01-22 1:50 GMT+09:00 Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:
> Hi Rob.
>
>
> 2016-01-21 23:09 GMT+09:00 Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> On Thu, Jan 21, 2016 at 6:21 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>>> On Thursday 21 January 2016 20:39:03 Masahiro Yamada wrote:
>>>> 2016-01-14 7:33 GMT+09:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>>> > The recently added uniphier 8250 port driver supports early console
>>>> > probing, and it supports being built as a module, but the combination
>>>> > of the two fails to link:
>>>> >
>>>> > ERROR: "early_serial8250_setup" [drivers/tty/serial/8250/8250_uniphier.ko] undefined!
>>>> >
>>>> > Given that earlycon support in a loadable module makes no sense,
>>>> > making that code conditional on 'MODULE' is a correct solution.
>>>> >
>>>> > Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>>> > Fixes: b8d20e06eaad ("serial: 8250_uniphier: add earlycon support")
>>>> >
>>>> > diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
>>>> > index bab6b3ae2540..1b7bd26555b7 100644
>>>> > --- a/drivers/tty/serial/8250/8250_uniphier.c
>>>> > +++ b/drivers/tty/serial/8250/8250_uniphier.c
>>>> > @@ -35,7 +35,7 @@ struct uniphier8250_priv {
>>>> >         spinlock_t atomic_write_lock;
>>>> >  };
>>>> >
>>>> > -#ifdef CONFIG_SERIAL_8250_CONSOLE
>>>> > +#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
>>>> >  static int __init uniphier_early_console_setup(struct earlycon_device *device,
>>>> >                                                const char *options)
>>>> >  {
>>>> >
>>>> >
>>>>
>>>>
>>>> If my patch (https://patchwork.kernel.org/patch/8029331/) is accepted,
>>>> this build error will be fixed as well.  But I doubt it is accepted soon...
>>>>
>>>> So, I am OK with this workaround to fix "make allmodconfig".
>>>>
>>>> Acked-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
>>>>
>>>
>>> Good point. Adding the DT maintainers to Cc. Guys, any chance of you
>>> picking up Masahiro's patch for 4.5?
>>
>> I will if you can update the commit log with the details here about it
>> fixing an actual problem.
>
> I did so in v2.
>
> Thanks!
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
