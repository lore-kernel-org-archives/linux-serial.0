From: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 3/5] acpi/serial: add DBG2 earlycon support
Date: Tue, 8 Sep 2015 18:03:07 +0100
Message-ID: <20150908170307.GP10728@bivouac.eciton.net>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
 <1441716217-23786-4-git-send-email-leif.lindholm@linaro.org>
 <20150908130951.GE20562@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150908130951.GE20562@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 08, 2015 at 02:09:51PM +0100, Mark Rutland wrote:
> On Tue, Sep 08, 2015 at 01:43:35PM +0100, Leif Lindholm wrote:
> > The ACPI DBG2 table defines a debug console. Add support for parsing it
> > and using it to select earlycon destination when no arguments provided.
> > 
> > Signed-off-by: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> [...]
> 
> > diff --git a/drivers/acpi/console.c b/drivers/acpi/console.c
> > new file mode 100644
> > index 0000000..a985890
> > --- /dev/null
> > +++ b/drivers/acpi/console.c
> > @@ -0,0 +1,103 @@
> > +/*
> > + * Copyright (c) 2012, Intel Corporation
> > + * Copyright (c) 2015, Linaro Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + */
> > +
> > +#define DEBUG
> 
> Why?

Kept around from Lv Zheng's 2012 set. Will drop.

> > +#define pr_fmt(fmt) "ACPI: " KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/kernel.h>
> > +#include <linux/serial_core.h>
> > +
> > +#define NUM_ELEMS(x) (sizeof(x) / sizeof(*x))
> 
> Use ARRAY_SIZE (from kernel.h).

I was sure there was something like that, but my grep-fu failed me.
Will fix.

> > +
> > +#ifdef CONFIG_SERIAL_EARLYCON
> > +static int use_earlycon __initdata;
> > +static int __init setup_acpi_earlycon(char *buf)
> > +{
> > +	if (!buf)
> > +		use_earlycon = 1;
> > +
> > +	return 0;
> > +}
> > +early_param("earlycon", setup_acpi_earlycon);
> 
> It seems a shame to add this after folding the OF case into the earlycon
> code. What necessitates this being a separate early_param? Why is it too
> early to parse DBG2?

Currently, we don't even know where our ACPI tables are  at this point
(efi_init() is called two functions after parse_early_param() in
setup_arch). More specifically, because acpi_boot_table_init() is
called even later than that.

If we moved both of those earlier, we could drop the extra earlycon
param handling for ACPI. That would of course reduce the ability to
have dynamically configurable debug messages for both of these.

> [...]
> 
> > diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> > index 2bda09a..c063cbb 100644
> > --- a/drivers/tty/serial/earlycon.c
> > +++ b/drivers/tty/serial/earlycon.c
> > @@ -13,6 +13,7 @@
> >  
> >  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/console.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > @@ -184,12 +185,16 @@ static int __init param_setup_earlycon(char *buf)
> >  	int err;
> >  
> >  	/*
> > -	 * Just 'earlycon' is a valid param for devicetree earlycons;
> > -	 * don't generate a warning from parse_early_params() in that case
> > +	 * Just 'earlycon' is a valid param for devicetree or ACPI earlycons;
> > +	 * ACPI cannot be parsed yet, so return without action if enabled.
> > +	 * Otherwise, attempt initialization using DT.
> >  	 */
> > -	if (!buf || !buf[0])
> > -		if (IS_ENABLED(CONFIG_OF_FLATTREE))
> > +	if (!buf || !buf[0]) {
> > +		if (!acpi_disabled)
> > +			return 0;
> > +		else if (IS_ENABLED(CONFIG_OF_FLATTREE))
> >  			return early_init_dt_scan_chosen_serial();
> > +	}
> 
> It would be much nicer if we could handle the ACPI earlycon parsing in
> the same place. As above, I assume I'm missing something that prevents
> that.

I don't disagree.

/
    Leif

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
