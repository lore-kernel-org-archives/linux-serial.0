From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh-sci: SysRq support on EARLYCON
Date: Wed, 25 May 2016 15:24:51 +0200
Message-ID: <CAMuHMdVGimv1zAOqUCA95x2aGVHA=_LEnf-xWUp2jAK+kWHCaQ@mail.gmail.com>
References: <1461772153-6785-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461772153-6785-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Sato-san,

CC linux-serial

On Wed, Apr 27, 2016 at 5:49 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add missing flag condition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Unfortunately magic SysRq only works if CONFIG_SERIAL_SH_SCI_DMA=n.

> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 0130feb..5a73620 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -18,7 +18,9 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> -#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#if (defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
> +     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)) && \
> +       defined(CONFIG_MAGIC_SYSRQ)
>  #define SUPPORT_SYSRQ
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
