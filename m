From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
Date: Thu, 31 Mar 2016 09:32:03 -0700
Message-ID: <20160331163203.GC10256@kroah.com>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459431629-27934-2-git-send-email-aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Graeme Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 31, 2016 at 04:40:23PM +0300, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
> 
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c
> 
> Signed-off-by: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/of/fdt.c              | 11 +----------
>  drivers/tty/serial/earlycon.c |  2 +-
>  include/linux/of_fdt.h        |  2 ++
>  3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 3349d2a..b50f775 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -805,7 +805,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
>  
> -static int __init early_init_dt_scan_chosen_serial(void)
> +int __init early_init_dt_scan_chosen_stdout(void)
>  {
>  	int offset;
>  	const char *p, *q, *options = NULL;
> @@ -849,15 +849,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
>  	}
>  	return -ENODEV;
>  }
> -
> -static int __init setup_of_earlycon(char *buf)
> -{
> -	if (buf)
> -		return 0;
> -
> -	return early_init_dt_scan_chosen_serial();
> -}
> -early_param("earlycon", setup_of_earlycon);
>  #endif
>  
>  /**
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 067783f..7aae655 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -209,7 +209,7 @@ static int __init param_setup_earlycon(char *buf)
>  	 * don't generate a warning from parse_early_params() in that case
>  	 */
>  	if (!buf || !buf[0])
> -		return 0;
> +		return early_init_dt_scan_chosen_stdout();
>  
>  	err = setup_earlycon(buf);
>  	if (err == -ENOENT || err == -EALREADY)
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 2fbe868..5cfe322 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -63,6 +63,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  				     int depth, void *data);
>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>  				     int depth, void *data);
> +extern int early_init_dt_scan_chosen_stdout(void);
>  extern void early_init_fdt_scan_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
> @@ -91,6 +92,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
>  extern u64 of_flat_dt_translate_address(unsigned long node);
>  extern void of_fdt_limit_memory(int limit);
>  #else /* CONFIG_OF_FLATTREE */
> +static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }

Doesn't this change the default logic?  Today you are returning 0 if you
don't have this config option set, and now you return -ENODEV, did you
test this out?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
