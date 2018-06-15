From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v3 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Fri, 15 Jun 2018 10:30:05 +0800
Message-ID: <1529029805.29697.27.camel@mtkswgap22>
References: <cover.1528960095.git.sean.wang@mediatek.com>
         <e338118bb6b9f560560887eb974eb250a6c89984.1528960095.git.sean.wang@mediatek.com>
         <CAPDyKFqVpfhJf3R3jbXtjGgXf+0pg=9dgALBnxM_bSyBQrQQDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqVpfhJf3R3jbXtjGgXf+0pg=9dgALBnxM_bSyBQrQQDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2018-06-14 at 10:58 +0200, Ulf Hansson wrote:
> On Thu, 14 Jun 2018 at 09:14, <sean.wang@mediatek.com> wrote:
> >
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > In order to open up the required power gate before any operation can be
> > effectively performed over the serial bus between CPU and serdev, it's
> > clearly essential to add common attach functions for PM domains to serdev
> > at the probe phase.
> >
> > Similarly, the relevant dettach function for the PM domains should be
> > properly and reversely added at the remove phase.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: linux-serial@vger.kernel.org
> > ---
> >  drivers/tty/serdev/core.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index df93b72..c93d8ee 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/serdev.h>
> >  #include <linux/slab.h>
> >
> > @@ -330,8 +331,16 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
> >  static int serdev_drv_probe(struct device *dev)
> >  {
> >         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> > +       int ret;
> > +
> > +       ret = dev_pm_domain_attach(dev, true);
> > +       if (ret != -EPROBE_DEFER) {
> 
> From 4.18 rc1 via commit 919b7308fcc4, dev_pm_domain_attach() will
> return better error codes.
> 
> I suggest to change the above error path to:
> if (ret)
>      return ret;
> 
> Then continue with the probing below.

Thanks for sharing me the information. I'll happily respin using the
patch because it makes the most sense.

> 
> > +               ret = sdrv->probe(to_serdev_device(dev));
> > +               if (ret)
> > +                       dev_pm_domain_detach(dev, true);
> > +       }
> >
> > -       return sdrv->probe(to_serdev_device(dev));
> > +       return ret;
> >  }
> >
> >  static int serdev_drv_remove(struct device *dev)
> > @@ -339,6 +348,9 @@ static int serdev_drv_remove(struct device *dev)
> >         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> >         if (sdrv->remove)
> >                 sdrv->remove(to_serdev_device(dev));
> > +
> > +       dev_pm_domain_detach(dev, true);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.7.4
> >
> 
> Otherwise, this makes sense to me!
> 

really thanks for your review!

> Kind regards
> Uffe
