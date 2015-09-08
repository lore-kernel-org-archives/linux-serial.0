From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 2/5] of/serial: move earlycon early_param handling to serial
Date: Tue, 8 Sep 2015 13:52:45 +0100
Message-ID: <20150908125245.GC20562@leverpostej>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-3-git-send-email-leif.lindholm@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441716217-23786-3-git-send-email-leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 08, 2015 at 01:43:34PM +0100, Leif Lindholm wrote:
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one. This means the earlycon early_param handler does
> not just return success if no options are specified.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/of/fdt.c              | 11 +----------
>  drivers/tty/serial/earlycon.c |  4 +++-
>  include/linux/of_fdt.h        |  1 +
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 6e82bc42..fcfc4c7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -793,7 +793,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
>  #ifdef CONFIG_SERIAL_EARLYCON
>  extern struct of_device_id __earlycon_of_table[];
>  
> -static int __init early_init_dt_scan_chosen_serial(void)
> +int __init early_init_dt_scan_chosen_serial(void)
>  {
>  	int offset;
>  	const char *p;
> @@ -834,15 +834,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
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
> index f096360..2bda09a 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -17,6 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/of_fdt.h>
>  #include <linux/serial_core.h>
>  #include <linux/sizes.h>
>  #include <linux/mod_devicetable.h>
> @@ -187,7 +188,8 @@ static int __init param_setup_earlycon(char *buf)
>  	 * don't generate a warning from parse_early_params() in that case
>  	 */
>  	if (!buf || !buf[0])
> -		return 0;
> +		if (IS_ENABLED(CONFIG_OF_FLATTREE))
> +			return early_init_dt_scan_chosen_serial();
>  
>  	err = setup_earlycon(buf);
>  	if (err == -ENOENT || err == -EALREADY)
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index df9ef38..772c47c 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -63,6 +63,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  				     int depth, void *data);
>  extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
>  				     int depth, void *data);
> +extern int early_init_dt_scan_chosen_serial(void);

I think you need a static inline stub to prevent link errors in
!CONFIG_OF_FLATTREE kernels, as we do for
early_init_fdt_scan_reserved_mem and friends.

Mark.

>  extern void early_init_fdt_scan_reserved_mem(void);
>  extern void early_init_fdt_reserve_self(void);
>  extern void early_init_dt_add_memory_arch(u64 base, u64 size);
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
