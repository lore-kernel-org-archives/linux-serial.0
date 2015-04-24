From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] drivers/tty/serial/sh-sci.h: remove dead reference on ARCH_SH7372
Date: Fri, 24 Apr 2015 10:54:11 +0200
Message-ID: <CAMuHMdWK0Nf7-pk=H1nt_WyARcDv=ZHXrOVi9WgUMorTd+YF+g@mail.gmail.com>
References: <1428747979-20455-1-git-send-email-valentinrothberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1428747979-20455-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Valentin,

On Sat, Apr 11, 2015 at 12:26 PM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> The Kconfig option ARCH_SH7372 has been removed by commit 59b89af1d555
> ("ARM: shmobile: sh7372: Remove Legacy C SoC code").  This patch removes
> the last reference on this Kconfig option.
>
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>

Thanks for your patch!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
> I found this issue with ./scripts/checkkconfigsymbols.py
> ---
>  drivers/tty/serial/sh-sci.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
> index d5db81a0a430..350717404507 100644
> --- a/drivers/tty/serial/sh-sci.h
> +++ b/drivers/tty/serial/sh-sci.h
> @@ -15,7 +15,6 @@
>      defined(CONFIG_CPU_SUBTYPE_SH7720) || \
>      defined(CONFIG_CPU_SUBTYPE_SH7721) || \
>      defined(CONFIG_ARCH_SH73A0) || \
> -    defined(CONFIG_ARCH_SH7372) || \
>      defined(CONFIG_ARCH_R8A7740)
>  # define SCxSR_RDxF_CLEAR(port)         (serial_port_in(port, SCxSR) & 0xfffc)

There are more things wrong with the above:
  1. It's not multi-platform safe: any ARM kernel with sh73a0 or r8a7740
     support will treat all SCIFs and HSCIFs as SCIFA/Bs.
  2. It wasn't updated for newer SoCs, e.g.
       - r8a73a4 has SCIFA/B, too,
       - R-Car Gen2 has all of SCIF, HSCIF, SCIFA, SCIFB, which isn't
         supported by the current logic at all.

Looking into it...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
