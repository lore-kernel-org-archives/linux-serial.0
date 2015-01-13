From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] serial: sh-sci: Remove overrun message
Date: Tue, 13 Jan 2015 08:57:48 +0100
Message-ID: <CAMuHMdW6uLoVhyHahWnJrqOe31gfQU9jMipKP7Yrm-o=m=6D=Q@mail.gmail.com>
References: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 15, 2014 at 3:13 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Since the driver cannot return from overrun error if characters
> are output during overrun process, the error message of overrun
> is removed.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
> tree.
>
>  drivers/tty/serial/sh-sci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index fccebbd..fe2bb08 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -858,7 +858,6 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>                 tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>                 tty_flip_buffer_push(tport);
>
> -               dev_notice(port->dev, "overrun error\n");
>                 copied++;
>         }

What about replacing it by a call to dev_dbg() instead?
That way it won't be printed during normal use, but depending on the
system's setting it can still be logged in syslog.

Or do you think it's sufficient to have it in the statistics only?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
