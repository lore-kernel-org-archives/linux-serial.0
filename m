From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/7] serdev: add dev_pm_domain_attach|detach()
Date: Wed, 27 Jun 2018 10:00:08 +0200
Message-ID: <CAPDyKFp4kESPH4hcqgATYWBt3Kz3FhAOCpnrCc5PRSkMkBikEg@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com> <ed497b2a9751df3b2f84cc9db6d6834816a6027f.1530004712.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed497b2a9751df3b2f84cc9db6d6834816a6027f.1530004712.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 27 June 2018 at 07:43,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> In order to open up the required power gate before any operation can be
> effectively performed over the serial bus between CPU and serdev, it's
> clearly essential to add common attach functions for PM domains to serdev
> at the probe phase.
>
> Similarly, the relevant dettach function for the PM domains should be
> properly and reversely added at the remove phase.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/tty/serdev/core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index df93b72..8096138 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/serdev.h>
>  #include <linux/slab.h>
>
> @@ -330,8 +331,17 @@ EXPORT_SYMBOL_GPL(serdev_device_set_tiocm);
>  static int serdev_drv_probe(struct device *dev)
>  {
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
> +       int ret;
>
> -       return sdrv->probe(to_serdev_device(dev));
> +       ret = dev_pm_domain_attach(dev, true);
> +       if (ret)
> +               return ret;
> +
> +       ret = sdrv->probe(to_serdev_device(dev));
> +       if (ret)
> +               dev_pm_domain_detach(dev, true);
> +
> +       return ret;
>  }
>
>  static int serdev_drv_remove(struct device *dev)
> @@ -339,6 +349,9 @@ static int serdev_drv_remove(struct device *dev)
>         const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
>         if (sdrv->remove)
>                 sdrv->remove(to_serdev_device(dev));
> +
> +       dev_pm_domain_detach(dev, true);
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
