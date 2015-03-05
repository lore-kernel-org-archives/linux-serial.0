From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH -next 06/12] of: earlycon: Move address translation to of_setup_earlycon()
Date: Thu, 5 Mar 2015 10:25:29 -0600
Message-ID: <CAL_JsqJe8r8LtkCr1pR=fMvxHogKjmWpVN72txv3pjsWTt377Q@mail.gmail.com>
References: <1425489871-22415-1-git-send-email-peter@hurleysoftware.com> <1425489871-22415-7-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425489871-22415-7-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 4, 2015 at 11:24 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Cleanup the early DT/earlycon separation; remove the 'addr' parameter
> from of_setup_earlycon() and get the uart phys addr directly with a
> new wrapper function, of_flat_dt_translate_addr(). Limit
> fdt_translate_address() to file scope.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/fdt.c              |  7 +------
>  drivers/of/fdt_address.c      | 11 ++++++++++-
>  drivers/tty/serial/earlycon.c | 11 +++++++----
>  include/linux/of_fdt.h        |  2 +-
>  include/linux/serial_core.h   |  3 +--
>  5 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index a732890..dd2baae 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -792,17 +792,12 @@ int __init early_init_dt_scan_chosen_serial(void)
>                 return -ENODEV;
>
>         while (match->compatible[0]) {
> -               unsigned long addr;
>                 if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
>                         match++;
>                         continue;
>                 }
>
> -               addr = fdt_translate_address(fdt, offset);
> -               if (!addr)
> -                       return -ENXIO;
> -
> -               of_setup_earlycon(addr, match, offset, options);
> +               of_setup_earlycon(match, offset, options);
>                 return 0;
>         }
>         return -ENODEV;
> diff --git a/drivers/of/fdt_address.c b/drivers/of/fdt_address.c
> index 8d3dc6f..dca8f9b 100644
> --- a/drivers/of/fdt_address.c
> +++ b/drivers/of/fdt_address.c
> @@ -161,7 +161,7 @@ static int __init fdt_translate_one(const void *blob, int parent,
>   * that can be mapped to a cpu physical address). This is not really specified
>   * that way, but this is traditionally the way IBM at least do things
>   */
> -u64 __init fdt_translate_address(const void *blob, int node_offset)
> +static u64 __init fdt_translate_address(const void *blob, int node_offset)
>  {
>         int parent, len;
>         const struct of_bus *bus, *pbus;
> @@ -239,3 +239,12 @@ u64 __init fdt_translate_address(const void *blob, int node_offset)
>   bail:
>         return result;
>  }
> +
> +/**
> + * of_flat_dt_translate_address - translate DT addr into CPU phys addr
> + * @node: node in the flat blob
> + */
> +u64 __init of_flat_dt_translate_address(unsigned long node)
> +{
> +       return fdt_translate_address(initial_boot_params, node);
> +}
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 019010f..b1a4bd1 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -221,8 +221,7 @@ static int __init param_setup_earlycon(char *buf)
>  }
>  early_param("earlycon", param_setup_earlycon);
>
> -int __init of_setup_earlycon(unsigned long addr,
> -                            const struct of_device_id *match,
> +int __init of_setup_earlycon(const struct of_device_id *match,
>                              unsigned long node,
>                              const char *options)
>  {
> @@ -232,9 +231,13 @@ int __init of_setup_earlycon(unsigned long addr,
>         const __be32 *val;
>
>         port->iotype = UPIO_MEM;
> -       port->mapbase = addr;
> +       port->mapbase = of_flat_dt_translate_address(node);
> +       if (!port->mapbase) {
> +               pr_warn("[%s] bad address\n", match->name);
> +               return -ENXIO;
> +       }
>         port->uartclk = BASE_BAUD * 16;
> -       port->membase = earlycon_map(addr, SZ_4K);
> +       port->membase = earlycon_map(port->mapbase, SZ_4K);
>
>         val = of_get_flat_dt_prop(node, "reg-offset", NULL);
>         if (val)
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 0ff360d..d31e6cb 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -85,7 +85,7 @@ extern void unflatten_device_tree(void);
>  extern void unflatten_and_copy_device_tree(void);
>  extern void early_init_devtree(void *);
>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
> -extern u64 fdt_translate_address(const void *blob, int node_offset);
> +extern u64 of_flat_dt_translate_address(unsigned long node);
>  extern void of_fdt_limit_memory(int limit);
>  #else /* CONFIG_OF_FLATTREE */
>  static inline void early_init_fdt_scan_reserved_mem(void) {}
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c8e4e8f..675d36f 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -345,8 +345,7 @@ struct earlycon_id {
>  };
>
>  extern int setup_earlycon(char *buf);
> -extern int of_setup_earlycon(unsigned long addr,
> -                            const struct of_device_id *match,
> +extern int of_setup_earlycon(const struct of_device_id *match,
>                              unsigned long node,
>                              const char *options);
>
> --
> 2.3.1
>
