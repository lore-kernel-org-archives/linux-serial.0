From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 22:41:04 +0530
Message-ID: <20151220171104.GA8471@sudip-laptop>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75Vfn_mr0hW71xsTCvDGX87ktPaN2E1TVTNjdbxR83-nxcg@mail.gmail.com>
 <20151220144722.GA26499@sudip-pc>
 <20151220164131.46fb25ee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151220164131.46fb25ee@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 04:41:31PM +0000, One Thousand Gnomes wrote:
> On Sun, 20 Dec 2015 20:17:22 +0530
> Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> 
> > On Sun, Dec 20, 2015 at 04:18:17PM +0200, Andy Shevchenko wrote:
> > > On Sun, Dec 20, 2015 at 3:24 PM, Sudip Mukherjee
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> > > > can be controlled using gpio interface.
> > > > Add support to use these pins and select GPIO_SYSFS also so that these
> > > > pins can be used from the userspace through sysfs.
> > > >
> > > > Tested-by: Rob Groner <rgroner@rtd.com>
> > > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > 
> > Hi Andy,
> > Thanks for the review. Just a few doubts below.
> > 
> > > > @@ -0,0 +1,261 @@
> > > > +/*
> > > > + * GPIO driver for Exar XR17V35X chip
> > > > + *
> > > > + * Copyright (C) 2015 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > <snip>
> > > > +
> > > > +err_destroy:
> > > > +       mutex_unlock(&exar_mtx);
> > > > +       mutex_destroy(&exar_gpio->lock);
> > > > +err_unmap:
> > > > +       iounmap(p);
> > > 
> > > pci_iounmap?
> > 
> > I thought about pci_iounmap but I saw that most of the code in
> > 8250_pci.c is using iounmap, so i went in favor of the majority.
> > Will change it.
> > 
> > > 
> > > > +       return ret;
> > > > +}
> > > > +EXPORT_SYMBOL(xr17v35x_gpio_init);
> > > > +
> > > 
> > > > +static void __exit exar_gpio_exit(void)
> > > > +{
> > > > +}
> > > > +
> > > > +module_exit(exar_gpio_exit);
> > > > +
> > > > +static int __init exar_gpio_init(void)
> > > > +{
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +module_init(exar_gpio_init);
> > > > +
> > > 
> > > Useless for now. You are using it as a library.
> > 
> > Main doubt here. If I do not give the module_init() and module_exit()
> > then what entry do i keep in the Kconfig? In this v3, it is kept as
> > tristate. Should that be bool then? 
> 
> If you are linking it into the driver you don't need the module_init/exit
> gpio_init/exit methods. Your Kconfig becomes a bool and you combine the
> file into the driver based upon that bool.

But isn't it better to have the gpio code separete from the 8250 code?
But how do i combine a file? is it like:

#ifdef SERIAL_8250_EXAR_GPIO
#include "8250_gpio.c"
#endif

or should it be:

#ifdef SERIAL_8250_EXAR_GPIO

all c code

#endif

regards
sudip


> 
> Alan
