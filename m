From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next 07/12] serial: earlycon: Common log banner for
 command line and DT
Date: Thu, 5 Mar 2015 13:02:54 +0100
Message-ID: <CAMuHMdUxiy9P+4adf77ZssRs7QauP6yO2z27d+VWC3NuoJEaSA@mail.gmail.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com>
	<1425489871-22415-8-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-8-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Wed, Mar 4, 2015 at 6:24 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -69,6 +69,7 @@ static void __init earlycon_init(struct earlycon_device *device,
>                                  const char *name)
>  {
>         struct console *earlycon = device->con;
> +       struct uart_port *port = &device->port;
>         const char *s;
>         size_t len;
>
> @@ -82,6 +83,16 @@ static void __init earlycon_init(struct earlycon_device *device,
>         len = s - name;
>         strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
>         earlycon->data = &early_console_dev;
> +
> +       if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
> +               pr_info("Early serial console at MMIO%s 0x%llx (options '%s')\n",
> +                       (port->iotype == UPIO_MEM32) ? "32" : "",
> +                       (unsigned long long)port->mapbase,

I know you're just moving this piece of code around, but mapbase is a
resource_size_t (it should actually be phys_addr_t, which probably didn't
exist in 2007), so it should be printed using %pa and passing a reference,
instead of %llx and using a cast.

> +                       device->options);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
