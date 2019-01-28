From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Date: Mon, 28 Jan 2019 11:53:27 +0100
Message-ID: <CAMuHMdWgYgMWD=oE6vCZtb1_-K5y19AHwn1WptLhJ47hc6Ah+g@mail.gmail.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com> <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>
Cc: linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Paul Burton <paul.burton@mips.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

Hi Zhou,

On Mon, Jan 28, 2019 at 10:23 AM Zhou Yanjie <zhouyanjie@zoho.com> wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

Thanks for your patch!

> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -145,6 +145,10 @@ EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
>  OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
>                     ingenic_early_console_setup);
>
> +EARLYCON_DECLARE(x1000_uart, ingenic_early_console_setup);
> +OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
> +                   ingenic_early_console_setup);

As of commit 2eaa790989e03900 ("earlycon: Use common framework for
earlycon declarations") it is no longer needer to specify both
EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
