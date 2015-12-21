From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v3 1/3] ACPI: amba bus probing support
Date: Tue, 22 Dec 2015 01:54:47 +0200
Message-ID: <56789147.8070602@mleia.com>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org> <1450716100-13688-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450716100-13688-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 21.12.2015 18:41, Aleksey Makarov wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> On ARM64 some devices use the AMBA device and not the platform bus for
> probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
> does not have a suitable clock representation and to keep the core
> AMBA bus code unchanged between probing methods.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/acpi_amba.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/internal.h  |   5 ++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/acpi/acpi_amba.c
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 675eaf3..3cf732f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -43,6 +43,7 @@ acpi-y				+= pci_root.o pci_link.o pci_irq.o
>  acpi-y				+= acpi_lpss.o acpi_apd.o
>  acpi-y				+= acpi_platform.o
>  acpi-y				+= acpi_pnp.o
> +acpi-$(CONFIG_ARM_AMBA)	+= acpi_amba.o
>  acpi-y				+= int340x_thermal.o
>  acpi-y				+= power.o
>  acpi-y				+= event.o
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> new file mode 100644
> index 0000000..ebc8913
> --- /dev/null
> +++ b/drivers/acpi/acpi_amba.c
> @@ -0,0 +1,149 @@
> +
> +/*
> + * ACPI support for platform bus type.
> + *
> + * Copyright (C) 2015, Linaro Ltd
> + * Authors: Graeme Gregory <graeme.gregory@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/amba/bus.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "internal.h"
> +
> +static const struct acpi_device_id amba_id_list[] = {
> +	{"ARMH0011", 0}, /* PL011 SBSA Uart */
> +	{"ARMH0061", 0}, /* PL061 GPIO Device */
> +	{"", 0},
> +};
> +
> +static struct clk *amba_dummy_clk;
> +
> +static void amba_register_dummy_clk(void)
> +{
> +	struct clk *clk;
> +
> +	/* If clock already registered */
> +	if (amba_dummy_clk)
> +		return;
> +
> +	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
> +	clk_register_clkdev(clk, "apb_pclk", NULL);
> +
> +	amba_dummy_clk = clk;
> +}
> +
> +static int amba_handler_attach(struct acpi_device *adev,
> +				const struct acpi_device_id *id)
> +{
> +	struct amba_device *dev = NULL;
> +	struct acpi_device *acpi_parent;
> +	struct resource_entry *rentry;
> +	struct list_head resource_list;
> +	struct resource *resources = NULL;
> +	bool address_found = false;
> +	int ret, count, irq_no = 0;
> +
> +	/* If the ACPI node already has a physical device attached, skip it. */
> +	if (adev->physical_node_count)
> +		return 0;
> +
> +	amba_register_dummy_clk();

Since it is a single time dummy clock registration, may be it is better
to move it to acpi_amba_init() or somewhere else? I understand that
"apb_pclk" is wanted, but I'm not sure that this driver should serve as
a clock provider.

> +	dev = amba_device_alloc(NULL, 0, 0);
> +	if (!dev) {
> +		pr_err("%s(): amba_device_alloc() failed for %s\n",
> +		       __func__, dev_name(&adev->dev));
> +		return 0;
> +	}
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +	if (count < 0) {
> +		return 0;
> +	} else if (count > 0) {

if you return from one of two if-branches, please don't use if-else nesting
for another one.

> +		resources = kmalloc_array(count, sizeof(struct resource),
> +				    GFP_KERNEL);

resources is never used and it is never freed, why do you allocate it?

> +		if (!resources) {
> +			acpi_dev_free_resource_list(&resource_list);
> +			return 0;

return -ENOMEM; seems to be more appropriate here.

> +		}
> +		count = 0;
> +		list_for_each_entry(rentry, &resource_list, node) {
> +			switch (resource_type(rentry->res)) {
> +			case IORESOURCE_MEM:
> +				if (!address_found) {
> +					dev->res = *rentry->res;
> +					address_found = true;
> +				}
> +				break;
> +			case IORESOURCE_IRQ:
> +				if (irq_no < AMBA_NR_IRQS)
> +					dev->irq[irq_no++] = rentry->res->start;
> +				break;
> +			default:
> +				dev_warn(&adev->dev, "Invalid resource\n");
> +			}
> +		}
> +		acpi_dev_free_resource_list(&resource_list);
> +	}
> +
> +	/*
> +	 * If the ACPI node has a parent and that parent has a physical device
> +	 * attached to it, that physical device should be the parent of the
> +	 * platform device we are about to create.
> +	 */
> +	dev->dev.parent = NULL;
> +	acpi_parent = adev->parent;
> +	if (acpi_parent) {
> +		struct acpi_device_physical_node *entry;
> +		struct list_head *list;
> +
> +		mutex_lock(&acpi_parent->physical_node_lock);
> +		list = &acpi_parent->physical_node_list;
> +		if (!list_empty(list)) {
> +			entry = list_first_entry(list,
> +					struct acpi_device_physical_node,
> +					node);
> +			dev->dev.parent = entry->dev;
> +		}
> +		mutex_unlock(&acpi_parent->physical_node_lock);
> +	}
> +
> +	dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));
> +	ACPI_COMPANION_SET(&dev->dev, adev);
> +
> +	ret = amba_device_add(dev, &iomem_resource);
> +	if (ret) {
> +		pr_err("%s(): amba_device_add() failed (%d) for %s\n",
> +		       __func__, ret, dev_name(&adev->dev));
> +		goto err_free;
> +	}
> +
> +	return 1;
> +
> +err_free:
> +	amba_device_put(dev);
> +	return 0;
> +}
> +
> +static struct acpi_scan_handler amba_handler = {
> +	.ids = amba_id_list,
> +	.attach = amba_handler_attach,
> +};
> +
> +void __init acpi_amba_init(void)
> +{
> +	acpi_scan_add_handler(&amba_handler);
> +}
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 11d87bf..9d58f0c 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -29,6 +29,11 @@ void acpi_processor_init(void);
>  void acpi_platform_init(void);
>  void acpi_pnp_init(void);
>  void acpi_int340x_thermal_init(void);
> +#ifdef CONFIG_ARM_AMBA
> +void acpi_amba_init(void);
> +#else
> +static inline void acpi_amba_init(void) {}
> +#endif
>  int acpi_sysfs_init(void);
>  void acpi_container_init(void);
>  void acpi_memory_hotplug_init(void);
> 

--
With best wishes,
Vladimir
