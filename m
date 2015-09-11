From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 3/5] acpi/serial: add DBG2 earlycon support
Date: Fri, 11 Sep 2015 00:43:48 -0500
Message-ID: <CAL_JsqJwdSA=NJ5x4RXhh3H2um_56XmJgg+P-6hJEK7J-a4iyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <al.stone-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <torez-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 8, 2015 at 12:03 PM, Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Sep 08, 2015 at 02:09:51PM +0100, Mark Rutland wrote:
>> On Tue, Sep 08, 2015 at 01:43:35PM +0100, Leif Lindholm wrote:
>> > The ACPI DBG2 table defines a debug console. Add support for parsing it
>> > and using it to select earlycon destination when no arguments provided.
>> >
>> > Signed-off-by: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> [...]
>>
>> > diff --git a/drivers/acpi/console.c b/drivers/acpi/console.c
>> > new file mode 100644
>> > index 0000000..a985890
>> > --- /dev/null
>> > +++ b/drivers/acpi/console.c
>> > @@ -0,0 +1,103 @@
>> > +/*
>> > + * Copyright (c) 2012, Intel Corporation
>> > + * Copyright (c) 2015, Linaro Ltd.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + *
>> > + */
>> > +
>> > +#define DEBUG
>>
>> Why?
>
> Kept around from Lv Zheng's 2012 set. Will drop.
>
>> > +#define pr_fmt(fmt) "ACPI: " KBUILD_MODNAME ": " fmt
>> > +
>> > +#include <linux/acpi.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/serial_core.h>
>> > +
>> > +#define NUM_ELEMS(x) (sizeof(x) / sizeof(*x))
>>
>> Use ARRAY_SIZE (from kernel.h).
>
> I was sure there was something like that, but my grep-fu failed me.
> Will fix.
>
>> > +
>> > +#ifdef CONFIG_SERIAL_EARLYCON
>> > +static int use_earlycon __initdata;
>> > +static int __init setup_acpi_earlycon(char *buf)
>> > +{
>> > +   if (!buf)
>> > +           use_earlycon = 1;
>> > +
>> > +   return 0;
>> > +}
>> > +early_param("earlycon", setup_acpi_earlycon);
>>
>> It seems a shame to add this after folding the OF case into the earlycon
>> code. What necessitates this being a separate early_param? Why is it too
>> early to parse DBG2?
>
> Currently, we don't even know where our ACPI tables are  at this point
> (efi_init() is called two functions after parse_early_param() in
> setup_arch). More specifically, because acpi_boot_table_init() is
> called even later than that.
>
> If we moved both of those earlier, we could drop the extra earlycon
> param handling for ACPI. That would of course reduce the ability to
> have dynamically configurable debug messages for both of these.

Personally, I liked that we don't have to have the early_param
handling globally located. I'm not sure I see the benefit of
centralizing it especially if it doesn't even help for your case.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
