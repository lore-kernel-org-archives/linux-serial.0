From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 16:18:17 +0200
Message-ID: <CAHp75Vfn_mr0hW71xsTCvDGX87ktPaN2E1TVTNjdbxR83-nxcg@mail.gmail.com>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 3:24 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs whic=
h
> can be controlled using gpio interface.
> Add support to use these pins and select GPIO_SYSFS also so that thes=
e
> pins can be used from the userspace through sysfs.
>
> Tested-by: Rob Groner <rgroner@rtd.com>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

> @@ -0,0 +1,261 @@
> +/*
> + * GPIO driver for Exar XR17V35X chip
> + *
> + * Copyright (C) 2015 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>
> +#include "8250.h"
> +
> +#define EXAR_OFFSET_MPIOLVL_LO 0x90
> +#define EXAR_OFFSET_MPIOSEL_LO 0x93
> +#define EXAR_OFFSET_MPIOLVL_HI 0x96
> +#define EXAR_OFFSET_MPIOSEL_HI 0x99
> +
> +static LIST_HEAD(exar_list);
> +static DEFINE_MUTEX(exar_mtx); /* lock while manipulating the list *=
/
> +
> +struct exar_gpio_chip {
> +       struct gpio_chip gpio_chip;
> +       struct mutex lock;
> +       struct uart_8250_port *port;
> +       struct list_head list;
> +       int index;
> +       void __iomem *regs;
> +       char name[16];
> +};
> +
> +#define to_exar_chip(n) container_of(n, struct exar_gpio_chip, gpio_=
chip)
> +
> +static inline unsigned int read_exar_reg(struct exar_gpio_chip *chip=
,
> +                                        int offset)
> +{
> +       pr_debug("%s regs=3D%p offset=3D%x\n", __func__, chip->regs, =
offset);

dev_dbg()

> +       return readb(chip->regs + offset);
> +}
> +
> +static inline void write_exar_reg(struct exar_gpio_chip *chip, int o=
ffset,
> +                                 int value)
> +{
> +       pr_debug("%s regs=3D%p value=3D%x offset=3D%x\n", __func__, c=
hip->regs,
> +                value, offset);

Ditto.

> +       writeb(value, chip->regs + offset);
> +}
> +
> +void xr17v35x_gpio_exit(struct uart_8250_port *port)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_temp1, *exar_temp2;

I would suggest to use *e, *_e for temporary variables.

> +
> +       if (!port)
> +               return;
> +
> +       exar_gpio =3D port->port.private_data;
> +       if (!exar_gpio)
> +               return;

Maybe
       if (!port || !port->port.private_data)
              return;

       exar_gpio =3D port->port.private_data;
       mutex_lock(&exar_mtx);

> +       list_for_each_entry_safe(exar_temp1, exar_temp2, &exar_list, =
list) {
> +               if (exar_temp1->index =3D=3D exar_gpio->index) {
> +                       list_del(&exar_temp1->list);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&exar_mtx);
> +
> +       gpiochip_remove(&exar_gpio->gpio_chip);
> +       mutex_destroy(&exar_gpio->lock);
> +       iounmap(exar_gpio->regs);
> +}
> +EXPORT_SYMBOL(xr17v35x_gpio_exit);
> +
> +static void exar_set(struct gpio_chip *chip, unsigned int reg, int v=
al,
> +                    unsigned int offset)

Perhaps =E2=80=A6, unsigned int offset, int val)

> +{
> +       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);
> +       int temp;
> +
> +       mutex_lock(&exar_gpio->lock);
> +       temp =3D read_exar_reg(exar_gpio, reg);
> +       temp &=3D ~(1 << offset);
> +       temp |=3D val << offset;
> +       write_exar_reg(exar_gpio, reg, temp);
> +       mutex_unlock(&exar_gpio->lock);
> +}
> +
> +static int exar_direction_output(struct gpio_chip *chip, unsigned in=
t offset,
> +                                int value)
> +{
> +       if (offset < 8)
> +               exar_set(chip, EXAR_OFFSET_MPIOSEL_LO, 0, offset);
> +       else
> +               exar_set(chip, EXAR_OFFSET_MPIOSEL_HI, 0, offset - 8)=
;
> +       return 0;
> +}
> +
> +static int exar_direction_input(struct gpio_chip *chip, unsigned int=
 offset)
> +{
> +       if (offset < 8)
> +               exar_set(chip, EXAR_OFFSET_MPIOSEL_LO, 1, offset);
> +       else
> +               exar_set(chip, EXAR_OFFSET_MPIOSEL_HI, 1, offset - 8)=
;
> +       return 0;
> +}
> +
> +static int exar_get(struct gpio_chip *chip, unsigned int reg)
> +{
> +       int value;
> +       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);

Perhaps exchange positions of the lines to be assignment first,
uninitialized =E2=80=94 second.

> +
> +       if (!exar_gpio) {
> +               pr_err("%s exar_gpio is NULL\n", __func__);

I doubt it's useful message.

> +               return -ENOMEM;
> +       }
> +
> +       mutex_lock(&exar_gpio->lock);
> +       value =3D read_exar_reg(exar_gpio, reg);
> +       mutex_unlock(&exar_gpio->lock);
> +
> +       return value;
> +}
> +
> +static int exar_get_direction(struct gpio_chip *chip, unsigned int o=
ffset)
> +{
> +       int val;

int value; like you have elsewhere.

> +
> +       if (offset < 8) {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_LO);
> +       } else {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_HI);
> +               offset -=3D 8;
> +       }
> +
> +       if (val > 0) {
> +               val >>=3D offset;
> +               val &=3D 0x01;
> +       }
> +
> +       return val;
> +}
> +
> +static int exar_get_value(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       int val;

Ditto.

> +
> +       if (offset < 8) {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_LO);
> +       } else {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_HI);
> +               offset -=3D 8;
> +       }
> +       val >>=3D offset;
> +       val &=3D 0x01;
> +
> +       return val;
> +}
> +
> +static void exar_set_value(struct gpio_chip *chip, unsigned int offs=
et,
> +                          int value)

Yep, offset before value!

> +{
> +       if (offset < 8)
> +               exar_set(chip, EXAR_OFFSET_MPIOLVL_LO, value, offset)=
;
> +       else
> +               exar_set(chip, EXAR_OFFSET_MPIOLVL_HI, value, offset =
- 8);
> +}
> +
> +int xr17v35x_gpio_init(struct pci_dev *dev, struct uart_8250_port *p=
ort,
> +                      int idx)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_temp;
> +       int ret;
> +       void __iomem *p;
> +       int index =3D 1;

It looks better if you move int ret; to be a last in this block.

> +
> +       if (idx !=3D 0)
> +               return 0;
> +
> +       if (dev->vendor !=3D PCI_VENDOR_ID_EXAR)
> +               return 0;
> +
> +       p =3D pci_ioremap_bar(dev, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       exar_gpio =3D devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP=
_KERNEL);
> +       if (!exar_gpio) {
> +               ret =3D -ENOMEM;
> +               goto err_unmap;
> +       }

You may do this before ioremap which makes less lines of code.

> +
> +       mutex_init(&exar_gpio->lock);
> +       INIT_LIST_HEAD(&exar_gpio->list);
> +
> +       mutex_lock(&exar_mtx);
> +       /* find the first unused index */
> +       list_for_each_entry(exar_temp, &exar_list, list) {
> +               if (exar_temp->index =3D=3D index) {
> +                       index++;

> +                       continue;

Useless.

> +               }
> +       }
> +
> +       sprintf(exar_gpio->name, "exar_gpio%d", index);
> +       exar_gpio->gpio_chip.label =3D exar_gpio->name;
> +       exar_gpio->gpio_chip.dev =3D &dev->dev;
> +       exar_gpio->gpio_chip.direction_output =3D exar_direction_outp=
ut;
> +       exar_gpio->gpio_chip.direction_input =3D exar_direction_input=
;
> +       exar_gpio->gpio_chip.get_direction =3D exar_get_direction;
> +       exar_gpio->gpio_chip.get =3D exar_get_value;
> +       exar_gpio->gpio_chip.set =3D exar_set_value;
> +       exar_gpio->gpio_chip.base =3D -1;
> +       exar_gpio->gpio_chip.ngpio =3D 16;

> +       exar_gpio->gpio_chip.owner =3D THIS_MODULE;

Check if GPIO subsystem does that for you.

> +       exar_gpio->regs =3D p;
> +       exar_gpio->index =3D index;
> +
> +       ret =3D gpiochip_add(&exar_gpio->gpio_chip);
> +       if (ret)
> +               goto err_destroy;
> +
> +       exar_gpio->port =3D port;
> +       port->port.private_data =3D exar_gpio;
> +
> +       list_add_tail(&exar_gpio->list, &exar_list);
> +       mutex_unlock(&exar_mtx);
> +
> +       return 0;
> +
> +err_destroy:
> +       mutex_unlock(&exar_mtx);
> +       mutex_destroy(&exar_gpio->lock);
> +err_unmap:
> +       iounmap(p);

pci_iounmap?

> +       return ret;
> +}
> +EXPORT_SYMBOL(xr17v35x_gpio_init);
> +

> +static void __exit exar_gpio_exit(void)
> +{
> +}
> +
> +module_exit(exar_gpio_exit);
> +
> +static int __init exar_gpio_init(void)
> +{
> +       return 0;
> +}
> +
> +module_init(exar_gpio_init);
> +

Useless for now. You are using it as a library.

> +MODULE_DESCRIPTION("Exar GPIO driver");
> +MODULE_AUTHOR("Sudip Mukherjee <sudipm.mukherjee@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index 4097f3f..2a73c47 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1764,12 +1764,20 @@ xr17v35x_has_slave(struct serial_private *pri=
v)
>                 (dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
>  }
>
> +static void pci_xr17v35x_exit(struct pci_dev *dev)
> +{
> +       struct serial_private *priv =3D pci_get_drvdata(dev);
> +
> +       xr17v35x_gpio_exit(serial8250_get_port(priv->line[0]));
> +}
> +
>  static int
>  pci_xr17v35x_setup(struct serial_private *priv,
>                   const struct pciserial_board *board,
>                   struct uart_8250_port *port, int idx)
>  {
>         u8 __iomem *p;
> +       int ret;
>
>         p =3D pci_ioremap_bar(priv->dev, 0);
>         if (p =3D=3D NULL)
> @@ -1807,7 +1815,11 @@ pci_xr17v35x_setup(struct serial_private *priv=
,
>         writeb(128, p + UART_EXAR_RXTRG);
>         iounmap(p);
>
> -       return pci_default_setup(priv, board, port, idx);
> +       ret =3D pci_default_setup(priv, board, port, idx);
> +       if (ret)
> +               return ret;
> +
> +       return xr17v35x_gpio_init(priv->dev, port, idx);
>  }
>
>  #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
> @@ -2407,6 +2419,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2414,6 +2427,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2421,6 +2435,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2428,6 +2443,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2435,6 +2451,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         /*
>          * Xircom cards
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/825=
0/Kconfig
> index b03cb517..852f1d2 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -386,3 +386,11 @@ config SERIAL_OF_PLATFORM
>           are probed through devicetree, including Open Firmware base=
d
>           PowerPC systems and embedded systems on architectures using=
 the
>           flattened device tree format.
> +
> +config SERIAL_8250_EXAR_GPIO
> +       tristate "Support for GPIO pins on XR17V352/354/358"
> +       depends on SERIAL_8250_PCI && GPIOLIB
> +       select GPIO_SYSFS
> +       help
> +         Selecting this option will enable handling of GPIO pins pre=
sent
> +         on Exar XR17V352/354/358 chips.
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/82=
50/Makefile
> index 4ecb80d..bcf5f14 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -29,5 +29,6 @@ obj-$(CONFIG_SERIAL_8250_UNIPHIER)    +=3D 8250_uni=
phier.o
>  obj-$(CONFIG_SERIAL_8250_INGENIC)      +=3D 8250_ingenic.o
>  obj-$(CONFIG_SERIAL_8250_MID)          +=3D 8250_mid.o
>  obj-$(CONFIG_SERIAL_8250_OF)           +=3D 8250_of.o
> +obj-$(CONFIG_SERIAL_8250_EXAR_GPIO)    +=3D 8250_gpio.o
>
>  CFLAGS_8250_ingenic.o +=3D -I$(srctree)/scripts/dtc/libfdt
> diff --git a/include/linux/8250_pci.h b/include/linux/8250_pci.h
> index b24ff08..803e55c 100644
> --- a/include/linux/8250_pci.h
> +++ b/include/linux/8250_pci.h
> @@ -35,3 +35,18 @@ pciserial_init_ports(struct pci_dev *dev, const st=
ruct pciserial_board *board);
>  void pciserial_remove_ports(struct serial_private *priv);
>  void pciserial_suspend_ports(struct serial_private *priv);
>  void pciserial_resume_ports(struct serial_private *priv);
> +
> +struct uart_8250_port;


> +
> +#ifdef CONFIG_SERIAL_8250_EXAR_GPIO
> +int xr17v35x_gpio_init(struct pci_dev *, struct uart_8250_port *, in=
t);
> +void xr17v35x_gpio_exit(struct uart_8250_port *);
> +#else /* CONFIG_SERIAL_8250_EXAR_GPIO */
> +static inline int xr17v35x_gpio_init(struct pci_dev *dev,
> +                                    struct uart_8250_port *port, int=
 idx)
> +{
> +               return 0;
> +}
> +
> +static inline void xr17v35x_gpio_exit(struct uart_8250_port *port) {=
 }
> +#endif /* CONFIG_SERIAL_8250_EXAR_GPIO */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
