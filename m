From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/6] ACPI: create setup_quirk in acpi_apd
Date: Mon, 4 Jan 2016 16:21:56 +0200
Message-ID: <CAHp75VeYAwF9yV-bjChpQJXbSV=5n-CobKkj8uWw1a8v6GZRkQ@mail.gmail.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
	<1451885501-2710-3-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-3-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wang Hongcheng <annie.wang@amd.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 4, 2016 at 7:31 AM, Wang Hongcheng <annie.wang@amd.com> wrote:
> The post_setup hook of AMD0020 device will create an amba device as
> the child of a previously created platform device.
>
> Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
> ---
>  drivers/acpi/acpi_apd.c | 131 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 121 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index a450e7a..9520daf 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -3,7 +3,8 @@
>   *
>   * Copyright (c) 2014,2015 AMD Corporation.
>   * Authors: Ken Xue <Ken.Xue@amd.com>
> - *     Wu, Jeff <Jeff.Wu@amd.com>
> + *          Jeff Wu <15618388108@163.com>
> + *          Wang Hongcheng <Annie.Wang@amd.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -17,6 +18,8 @@
>  #include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/pm.h>
> +#include <linux/amba/bus.h>
> +#include <linux/dma-mapping.h>
>
>  #include "internal.h"
>
> @@ -36,19 +39,23 @@ struct apd_private_data;
>   * @fixed_clk_rate: fixed rate input clock source for acpi device;
>   *                     0 means no fixed rate input clock source
>   * @setup: a hook routine to set device resource during create platform device
> - *
> + * @post_setup: an additional hook routine
>   * Device description defined as acpi_device_id.driver_data
>   */
>  struct apd_device_desc {
>         unsigned int flags;
>         unsigned int fixed_clk_rate;
> +       unsigned int base_offset;
> +       unsigned int periphid;
>         int (*setup)(struct apd_private_data *pdata);
> +       int (*post_setup)(struct apd_private_data *pdata);
>  };
>
>  struct apd_private_data {
>         struct clk *clk;
>         struct acpi_device *adev;
>         const struct apd_device_desc *dev_desc;
> +       struct platform_device *pdev;
>  };
>
>  #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
> @@ -71,6 +78,100 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
>         return 0;
>  }
>
> +#ifdef CONFIG_SERIAL_8250_AMD
> +static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
> +{
> +       struct amba_device *amba_dev = NULL;
> +       struct platform_device *pdev = pdata->pdev;
> +       struct resource *presource, *resource = NULL;
> +       int count = 0;
> +       int ret = 0;
> +       unsigned int i;
> +       unsigned int irq[AMBA_NR_IRQS];
> +       struct clk *clk = ERR_PTR(-ENODEV);
> +       char amba_devname[100];
> +
> +       resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> +       if (!resource)
> +               goto resource_alloc_err;
> +
> +       presource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       resource->parent = presource;
> +
> +       /*
> +        * The memory address of AMD pl330 has an offset of ACPI
> +        * mem resource.
> +        */
> +       resource->start += presource->start + pdata->dev_desc->base_offset;
> +       resource->end = presource->end;
> +
> +       presource = pdev->resource;
> +       for (i = 0; i < resource_size(presource); i++) {
> +               if (presource[i].flags & IORESOURCE_IRQ)
> +                       irq[count++] = presource[i].start;
> +       }
> +
> +       sprintf(amba_devname, "%s%s", dev_name(&pdev->dev), "DMA");
> +
> +       amba_dev = amba_device_alloc(amba_devname,
> +                                    resource->start,
> +                                    resource_size(resource));
> +
> +       if (!amba_dev)
> +               goto amba_alloc_err;
> +

struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);

?

> +       amba_dev->dev.coherent_dma_mask
> +               = acpi_dma_supported(ACPI_COMPANION(&pdev->dev)) ? DMA_BIT_MASK(64) : 0;
> +       amba_dev->dev.fwnode = acpi_fwnode_handle(ACPI_COMPANION(&pdev->dev));

^^^

> +
> +       amba_dev->dev.parent = &pdev->dev;
> +       amba_dev->periphid = pdata->dev_desc->periphid;
> +
> +       WARN_ON_ONCE(count > AMBA_NR_IRQS);
> +
> +       for (i = 0; i < count; i++)
> +               amba_dev->irq[i] = irq[i];

memcpy() ?

> +
> +       clk = clk_register_fixed_rate(&amba_dev->dev,
> +                                     dev_name(&amba_dev->dev),
> +                                     NULL, CLK_IS_ROOT,
> +                                     pdata->dev_desc->fixed_clk_rate);
> +       if (IS_ERR_OR_NULL(clk))
> +               goto amba_register_err;
> +
> +       ret = clk_register_clkdev(clk, "apb_pclk",
> +                                 dev_name(&amba_dev->dev));

clkdev_create()?

Or mention that driver shall not be unloaded, otherwise it will leak resources.

> +       if (ret)
> +               goto amba_register_err;
> +
> +       amba_dev->dev.init_name = NULL;
> +       ret = amba_device_add(amba_dev, resource);
> +       if (ret)
> +               goto amba_register_err;
> +
> +       kfree(resource);
> +       return 0;
> +
> +amba_register_err:
> +       amba_device_put(amba_dev);
> +
> +amba_alloc_err:
> +       kfree(resource);
> +
> +resource_alloc_err:
> +       dev_info(&pdev->dev, "AMBA device created failed.\n");

dev_err();

> +       return 0;

return ret;

> +}
> +
> +#else
> +
> +static int acpi_apd_setup_quirks(struct apd_private_data *pdata)
> +{
> +       return 0;
> +}
> +
> +#endif
> +
>  static struct apd_device_desc cz_i2c_desc = {
>         .setup = acpi_apd_setup,
>         .fixed_clk_rate = 133000000,
> @@ -78,7 +179,10 @@ static struct apd_device_desc cz_i2c_desc = {
>
>  static struct apd_device_desc cz_uart_desc = {
>         .setup = acpi_apd_setup,
> +       .post_setup = acpi_apd_setup_quirks,
>         .fixed_clk_rate = 48000000,
> +       .periphid = 0x00041330,
> +       .base_offset = SZ_4K,
>  };
>
>  #else
> @@ -88,11 +192,11 @@ static struct apd_device_desc cz_uart_desc = {
>  #endif /* CONFIG_X86_AMD_PLATFORM_DEVICE */
>
>  /**
> -* Create platform device during acpi scan attach handle.
> -* Return value > 0 on success of creating device.
> -*/
> + * Create platform device during acpi scan attach handle.
> + * Return value > 0 on success of creating device.
> + */

Separate change, doesn't belong to the topic.

>  static int acpi_apd_create_device(struct acpi_device *adev,
> -                                  const struct acpi_device_id *id)
> +                                 const struct acpi_device_id *id)

Ditto

>  {
>         const struct apd_device_desc *dev_desc = (void *)id->driver_data;
>         struct apd_private_data *pdata;
> @@ -118,14 +222,21 @@ static int acpi_apd_create_device(struct acpi_device *adev,
>         }
>
>         adev->driver_data = pdata;
> -       pdev = acpi_create_platform_device(adev);
> -       if (!IS_ERR_OR_NULL(pdev))
> -               return 1;
>
> +       pdev = acpi_create_platform_device(adev);
>         ret = PTR_ERR(pdev);
> -       adev->driver_data = NULL;
> +       if (IS_ERR_OR_NULL(pdev))
> +               goto err_out;
> +
> +       if (dev_desc->post_setup) {
> +               pdata->pdev = pdev;
> +               dev_desc->post_setup(pdata);
> +       }
> +
> +       return ret;
>
>   err_out:
> +       adev->driver_data = NULL;
>         kfree(pdata);
>         return ret;
>  }
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
