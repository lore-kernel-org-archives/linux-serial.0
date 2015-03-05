From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH -next 04/12] of: earlycon: Add options string handling
Date: Thu, 5 Mar 2015 10:28:23 -0600
Message-ID: <CAL_JsqJ6j5z8MOy7GKGscKfmgLc7X_S-633=VC-qoKYAcTsD3g@mail.gmail.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com> <1425489871-22415-5-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-5-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 4, 2015 at 11:24 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> commit 7914a7c5651a5 ("of: support passing console options with
> stdout-path") added options string support to the stdout-path property.
>
> Handle the options string for earlycon as well.
>
> Requires: "libfdt: Teach fdt_path_offset() about ':' path separator"
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c              | 8 ++++++--
>  drivers/tty/serial/earlycon.c | 9 +++++++--
>  include/linux/serial_core.h   | 3 ++-
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 5b67c6a..bdb74a8 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -765,7 +765,7 @@ extern struct of_device_id __earlycon_of_table[];
>  int __init early_init_dt_scan_chosen_serial(void)
>  {
>         int offset;
> -       const char *p;
> +       const char *p, *options;
>         int l;
>         const struct of_device_id *match = __earlycon_of_table;
>         const void *fdt = initial_boot_params;
> @@ -782,6 +782,10 @@ int __init early_init_dt_scan_chosen_serial(void)
>         if (!p || !l)
>                 return -ENOENT;
>
> +       options = strchr(p, ':');
> +       if (options)
> +               options++;
> +
>         /* Get the node specified by stdout-path */
>         offset = fdt_path_offset(fdt, p);
>         if (offset < 0)
> @@ -798,7 +802,7 @@ int __init early_init_dt_scan_chosen_serial(void)
>                 if (!addr)
>                         return -ENXIO;
>
> -               of_setup_earlycon(addr, match);
> +               of_setup_earlycon(addr, match, options);
>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 04aa22c..436ac88 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -218,7 +218,8 @@ static int __init param_setup_earlycon(char *buf)
>  early_param("earlycon", param_setup_earlycon);
>
>  int __init of_setup_earlycon(unsigned long addr,
> -                            const struct of_device_id *match)
> +                            const struct of_device_id *match,
> +                            const char *options)
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
> @@ -229,8 +230,12 @@ int __init of_setup_earlycon(unsigned long addr,
>         port->uartclk = BASE_BAUD * 16;
>         port->membase = earlycon_map(addr, SZ_4K);
>
> +       if (options) {
> +               strlcpy(early_console_dev.options, options,
> +                       sizeof(early_console_dev.options));
> +       }
>         earlycon_init(&early_console_dev, match->name);
> -       err = setup(&early_console_dev, NULL);
> +       err = setup(&early_console_dev, options);
>         if (err < 0)
>                 return err;
>         if (!early_console_dev.con->write)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index a2db5bd..ebbcd43 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -346,7 +346,8 @@ struct earlycon_id {
>
>  extern int setup_earlycon(char *buf);
>  extern int of_setup_earlycon(unsigned long addr,
> -                            const struct of_device_id *match);
> +                            const struct of_device_id *match,
> +                            const char *options);
>
>  #define EARLYCON_DECLARE(_name, func)                                  \
>         static const struct earlycon_id __earlycon_##_name              \
> --
> 2.3.1
>
