From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/5] serial: sh-sci: Add support for GPIO-controlled
 modem lines
Date: Fri, 18 Mar 2016 09:23:22 +0100
Message-ID: <CAMuHMdVqS4CGKzFW1OR0Zn0VXba4b2EuNpO-oMSrx+zJgJhaDg@mail.gmail.com>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
	<1458222449-12324-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1458222449-12324-5-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 17, 2016 at 2:47 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -1829,15 +1831,36 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
>                                         serial_port_in(port, SCFCR) |
>                                         SCFCR_LOOP);
>         }
> +
> +       mctrl_gpio_set(to_sci_port(port)->gpios, mctrl);
>  }
>
>  static unsigned int sci_get_mctrl(struct uart_port *port)
>  {
> +       unsigned int mctrl = 0;
> +
> +       mctrl_gpio_get(to_sci_port(port)->gpios, &mctrl);
> +
>         /*
>          * CTS/RTS is handled in hardware when supported, while nothing
>          * else is wired up. Keep it simple and simply assert CTS/DSR/CAR.
>          */
> -       return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +       if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(to_sci_port(port)->gpios,
> +                                              UART_GPIO_CTS)))
> +               mctrl |= TIOCM_CTS;
> +       if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(to_sci_port(port)->gpios,
> +                                              UART_GPIO_DSR)))
> +               mctrl |= TIOCM_DSR;
> +       if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(to_sci_port(port)->gpios,
> +                                              UART_GPIO_CAR)))

Oops, something went wrong during rebase before sending: that should
have been "UART_GPIO_DCD".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
