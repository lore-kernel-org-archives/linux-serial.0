From: G Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v3 1/3] ACPI: amba bus probing support
Date: Mon, 21 Dec 2015 21:11:42 +0000
Message-ID: <CAGCh1+kA4tiHb3Nxxfa3BSoU2XSYak7vRFLRr5fW9Lag2uhDtQ@mail.gmail.com>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
	<1450716100-13688-2-git-send-email-aleksey.makarov@linaro.org>
	<CAHp75VfOUgkJ1mXPZpHLMr7=bqFDqJSTxy6y+a5PqZZEVcCxYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfOUgkJ1mXPZpHLMr7=bqFDqJSTxy6y+a5PqZZEVcCxYg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On 21 December 2015 at 18:19, Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
> On Mon, Dec 21, 2015 at 6:41 PM, Aleksey Makarov
> <aleksey.makarov@linaro.org> wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> On ARM64 some devices use the AMBA device and not the platform bus f=
or
>> probing so add support for this. Uses a dummy clock for apb_pclk as =
ACPI
>> does not have a suitable clock representation and to keep the core
>> AMBA bus code unchanged between probing methods.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>> ---
>>  drivers/acpi/Makefile    |   1 +
>>  drivers/acpi/acpi_amba.c | 149 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  drivers/acpi/internal.h  |   5 ++
>>  3 files changed, 155 insertions(+)
>>  create mode 100644 drivers/acpi/acpi_amba.c
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 675eaf3..3cf732f 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -43,6 +43,7 @@ acpi-y                                +=3D pci_roo=
t.o pci_link.o pci_irq.o
>>  acpi-y                         +=3D acpi_lpss.o acpi_apd.o
>>  acpi-y                         +=3D acpi_platform.o
>>  acpi-y                         +=3D acpi_pnp.o
>> +acpi-$(CONFIG_ARM_AMBA)        +=3D acpi_amba.o
>>  acpi-y                         +=3D int340x_thermal.o
>>  acpi-y                         +=3D power.o
>>  acpi-y                         +=3D event.o
>> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
>> new file mode 100644
>> index 0000000..ebc8913
>> --- /dev/null
>> +++ b/drivers/acpi/acpi_amba.c
>> @@ -0,0 +1,149 @@
>> +
>> +/*
>> + * ACPI support for platform bus type.
>> + *
>> + * Copyright (C) 2015, Linaro Ltd
>> + * Authors: Graeme Gregory <graeme.gregory@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/amba/bus.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/ioport.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "internal.h"
>> +
>> +static const struct acpi_device_id amba_id_list[] =3D {
>> +       {"ARMH0011", 0}, /* PL011 SBSA Uart */
>> +       {"ARMH0061", 0}, /* PL061 GPIO Device */
>> +       {"", 0},
>> +};
>> +
>> +static struct clk *amba_dummy_clk;
>> +
>> +static void amba_register_dummy_clk(void)
>> +{
>> +       struct clk *clk;
>> +
>> +       /* If clock already registered */
>> +       if (amba_dummy_clk)
>> +               return;
>> +
>> +       clk =3D clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_=
IS_ROOT, 0);
>> +       clk_register_clkdev(clk, "apb_pclk", NULL);
>> +
>> +       amba_dummy_clk =3D clk;
>> +}
>> +
>> +static int amba_handler_attach(struct acpi_device *adev,
>> +                               const struct acpi_device_id *id)
>> +{
>> +       struct amba_device *dev =3D NULL;
>> +       struct acpi_device *acpi_parent;
>> +       struct resource_entry *rentry;
>> +       struct list_head resource_list;
>> +       struct resource *resources =3D NULL;
>> +       bool address_found =3D false;
>> +       int ret, count, irq_no =3D 0;
>> +
>> +       /* If the ACPI node already has a physical device attached, =
skip it. */
>> +       if (adev->physical_node_count)
>> +               return 0;
>> +
>> +       amba_register_dummy_clk();
>> +
>> +       dev =3D amba_device_alloc(NULL, 0, 0);
>> +       if (!dev) {
>> +               pr_err("%s(): amba_device_alloc() failed for %s\n",
>
> Can it be dev_err(&adev->dev, =E2=80=A6); ?
> Same for below cases.
>
Yes it probably can, I took the code directly from DT version and
didn't think of using adev->dev directly.

Graeme

>> +                      __func__, dev_name(&adev->dev));
>> +               return 0;
>> +       }
>> +
>> +       INIT_LIST_HEAD(&resource_list);
>
>> +       count =3D acpi_dev_get_resources(adev, &resource_list, NULL,=
 NULL);
>> +       if (count < 0) {
>> +               return 0;
>> +       } else if (count > 0) {
>> +               resources =3D kmalloc_array(count, sizeof(struct res=
ource),
>> +                                   GFP_KERNEL);
>> +               if (!resources) {
>> +                       acpi_dev_free_resource_list(&resource_list);
>> +                       return 0;
>> +               }
>> +               count =3D 0;
>> +               list_for_each_entry(rentry, &resource_list, node) {
>> +                       switch (resource_type(rentry->res)) {
>> +                       case IORESOURCE_MEM:
>> +                               if (!address_found) {
>> +                                       dev->res =3D *rentry->res;
>> +                                       address_found =3D true;
>> +                               }
>> +                               break;
>> +                       case IORESOURCE_IRQ:
>> +                               if (irq_no < AMBA_NR_IRQS)
>> +                                       dev->irq[irq_no++] =3D rentr=
y->res->start;
>> +                               break;
>> +                       default:
>> +                               dev_warn(&adev->dev, "Invalid resour=
ce\n");
>> +                       }
>> +               }
>> +               acpi_dev_free_resource_list(&resource_list);
>> +       }
>> +
>> +       /*
>> +        * If the ACPI node has a parent and that parent has a physi=
cal device
>> +        * attached to it, that physical device should be the parent=
 of the
>> +        * platform device we are about to create.
>> +        */
>> +       dev->dev.parent =3D NULL;
>> +       acpi_parent =3D adev->parent;
>> +       if (acpi_parent) {
>> +               struct acpi_device_physical_node *entry;
>> +               struct list_head *list;
>> +
>> +               mutex_lock(&acpi_parent->physical_node_lock);
>> +               list =3D &acpi_parent->physical_node_list;
>> +               if (!list_empty(list)) {
>> +                       entry =3D list_first_entry(list,
>> +                                       struct acpi_device_physical_=
node,
>> +                                       node);
>> +                       dev->dev.parent =3D entry->dev;
>> +               }
>> +               mutex_unlock(&acpi_parent->physical_node_lock);
>> +       }
>> +
>> +       dev_set_name(&dev->dev, "%s", dev_name(&adev->dev));
>> +       ACPI_COMPANION_SET(&dev->dev, adev);
>> +
>> +       ret =3D amba_device_add(dev, &iomem_resource);
>> +       if (ret) {
>> +               pr_err("%s(): amba_device_add() failed (%d) for %s\n=
",
>> +                      __func__, ret, dev_name(&adev->dev));
>> +               goto err_free;
>> +       }
>> +
>> +       return 1;
>> +
>> +err_free:
>> +       amba_device_put(dev);
>> +       return 0;
>> +}
>> +
>> +static struct acpi_scan_handler amba_handler =3D {
>> +       .ids =3D amba_id_list,
>> +       .attach =3D amba_handler_attach,
>> +};
>> +
>> +void __init acpi_amba_init(void)
>> +{
>> +       acpi_scan_add_handler(&amba_handler);
>> +}
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index 11d87bf..9d58f0c 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -29,6 +29,11 @@ void acpi_processor_init(void);
>>  void acpi_platform_init(void);
>>  void acpi_pnp_init(void);
>>  void acpi_int340x_thermal_init(void);
>> +#ifdef CONFIG_ARM_AMBA
>> +void acpi_amba_init(void);
>> +#else
>> +static inline void acpi_amba_init(void) {}
>> +#endif
>>  int acpi_sysfs_init(void);
>>  void acpi_container_init(void);
>>  void acpi_memory_hotplug_init(void);
>> --
>> 2.6.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
