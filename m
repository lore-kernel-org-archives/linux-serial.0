From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] serial: 8250: add gpio support to exar
Date: Mon, 18 Jan 2016 15:39:01 +0200
Message-ID: <CAHp75VdSbd-OSLNyX3mmqC-_tdRNQqR33BPVY1PHibAODNVwRA@mail.gmail.com>
References: <1453119038-11741-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453119038-11741-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 18, 2016 at 2:10 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs whic=
h
> can be controlled using gpio interface.
> Add support to use these pins.

Looks better, but=E2=80=A6

>  drivers/gpio/Kconfig                |   7 ++
>  drivers/gpio/Makefile               |   1 +

Why is it here?

>  drivers/tty/serial/8250/8250_gpio.c | 243 ++++++++++++++++++++++++++=
++++++++++



>  drivers/tty/serial/8250/8250_pci.c  |  41 +++++-
>  4 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/tty/serial/8250/8250_gpio.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b18bea0..1294d8d 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -983,6 +983,13 @@ config GPIO_SODAVILLE
>         help
>           Say Y here to support Intel Sodaville GPIO.
>
> +config GPIO_EXAR
> +       tristate "Support for GPIO pins on XR17V352/354/358"
> +       depends on SERIAL_8250_PCI
> +       help
> +         Selecting this option will enable handling of GPIO pins pre=
sent
> +         on Exar XR17V352/354/358 chips.
> +
>  endmenu
>
>  menu "SPI GPIO expanders"
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 986dbd8..68efdb5 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_DWAPB)      +=3D gpio-dwapb.o
>  obj-$(CONFIG_GPIO_EM)          +=3D gpio-em.o
>  obj-$(CONFIG_GPIO_EP93XX)      +=3D gpio-ep93xx.o
>  obj-$(CONFIG_GPIO_ETRAXFS)     +=3D gpio-etraxfs.o

> +obj-$(CONFIG_GPIO_EXAR)                +=3D gpio-exar.o

And this file is exactly where?

>  obj-$(CONFIG_GPIO_F7188X)      +=3D gpio-f7188x.o
>  obj-$(CONFIG_GPIO_GE_FPGA)     +=3D gpio-ge.o
>  obj-$(CONFIG_GPIO_GRGPIO)      +=3D gpio-grgpio.o
> diff --git a/drivers/tty/serial/8250/8250_gpio.c b/drivers/tty/serial=
/8250/8250_gpio.c
> new file mode 100644
> index 0000000..44511de
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_gpio.c

Name is too generic for the more specific case.

> @@ -0,0 +1,243 @@
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
> +       dev_dbg(chip->gpio_chip.dev, "%s regs=3D%p offset=3D%x\n", __=
func__,
> +               chip->regs, offset);
> +       return readb(chip->regs + offset);
> +}
> +
> +static inline void write_exar_reg(struct exar_gpio_chip *chip, int o=
ffset,
> +                                 int value)
> +{
> +       dev_dbg(chip->gpio_chip.dev,
> +               "%s regs=3D%p value=3D%x offset=3D%x\n", __func__, ch=
ip->regs,
> +               value, offset);
> +       writeb(value, chip->regs + offset);
> +}
> +
> +void xr17v35x_gpio_exit(struct uart_8250_port *port)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_pos_e, *exar_temp_e;
> +
> +       if (!port || !port->port.private_data)
> +               return;
> +
> +       exar_gpio =3D port->port.private_data;
> +       mutex_lock(&exar_mtx);
> +       list_for_each_entry_safe(exar_pos_e, exar_temp_e, &exar_list,=
 list) {
> +               if (exar_pos_e->index =3D=3D exar_gpio->index) {
> +                       list_del(&exar_pos_e->list);
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
> +static void exar_set(struct gpio_chip *chip, unsigned int reg,
> +                    unsigned int offset, int val)
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
> +       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);
> +       int value;
> +
> +       if (!exar_gpio)
> +               return -ENODEV;
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
> +       int value;
> +
> +       if (offset < 8) {
> +               value =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_LO);
> +       } else {
> +               value =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_HI);
> +               offset -=3D 8;
> +       }
> +
> +       if (value > 0) {
> +               value >>=3D offset;
> +               value &=3D 0x01;
> +       }
> +
> +       return value;
> +}
> +
> +static int exar_get_value(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       int value;
> +
> +       if (offset < 8) {
> +               value =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_LO);
> +       } else {
> +               value =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_HI);
> +               offset -=3D 8;
> +       }
> +
> +       if (value > 0) {
> +               value >>=3D offset;
> +               value &=3D 0x01;
> +       }
> +
> +       return value;
> +}
> +
> +static void exar_set_value(struct gpio_chip *chip, unsigned int offs=
et,
> +                          int value)
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
> +       void __iomem *p;
> +       int index =3D 1;
> +       int ret;
> +
> +       if (idx !=3D 0)
> +               return 0;
> +
> +       if (dev->vendor !=3D PCI_VENDOR_ID_EXAR)
> +               return 0;
> +
> +       exar_gpio =3D devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP=
_KERNEL);
> +       if (!exar_gpio)
> +               return -ENOMEM;
> +
> +       p =3D pci_ioremap_bar(dev, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       mutex_init(&exar_gpio->lock);
> +       INIT_LIST_HEAD(&exar_gpio->list);
> +
> +       mutex_lock(&exar_mtx);
> +       /* find the first unused index */
> +       list_for_each_entry(exar_temp, &exar_list, list) {
> +               if (exar_temp->index =3D=3D index)
> +                       index++;
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

Is it still needed?

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
> +       pci_iounmap(dev, p);
> +       return ret;
> +}
> +EXPORT_SYMBOL(xr17v35x_gpio_init);
> +
> +MODULE_DESCRIPTION("Exar GPIO driver");
> +MODULE_AUTHOR("Sudip Mukherjee <sudipm.mukherjee@gmail.com>");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS("platform:" DRIVER_NAME);
Where DRIVER_NAME defined above as something sane.

> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index 4097f3f..5c03d5c 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1764,12 +1764,25 @@ xr17v35x_has_slave(struct serial_private *pri=
v)
>                 (dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
>  }
>
> +static void pci_xr17v35x_exit(struct pci_dev *dev)
> +{
> +       struct serial_private *priv =3D pci_get_drvdata(dev);
> +       struct uart_8250_port *port =3D serial8250_get_port(priv->lin=
e[0]);
> +       struct platform_device *pdev =3D port->port.private_data;
> +
> +       if (pdev) {
> +               platform_device_unregister(pdev);
> +               port->port.private_data =3D NULL;
> +       }
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
> @@ -1807,7 +1820,28 @@ pci_xr17v35x_setup(struct serial_private *priv=
,
>         writeb(128, p + UART_EXAR_RXTRG);
>         iounmap(p);
>
> -       return pci_default_setup(priv, board, port, idx);
> +       ret =3D pci_default_setup(priv, board, port, idx);
> +       if (ret)
> +               return ret;
> +
> +       if (idx =3D=3D 0) {
> +               struct platform_device *device;
> +
> +               device =3D platform_device_alloc("gpio_exar",
> +                                              PLATFORM_DEVID_AUTO);
> +               if (!device)
> +                       return -ENOMEM;
> +
> +               if (platform_device_add(device) < 0) {
> +                       platform_device_put(device);
> +                       return -ENODEV;
> +               }
> +
> +               port->port.private_data =3D device;
> +               platform_set_drvdata(device, priv->dev);
> +       }
> +
> +       return 0;
>  }
>
>  #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
> @@ -2407,6 +2441,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2414,6 +2449,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2421,6 +2457,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2428,6 +2465,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },
>         {
>                 .vendor =3D PCI_VENDOR_ID_EXAR,
> @@ -2435,6 +2473,7 @@ static struct pci_serial_quirk pci_serial_quirk=
s[] __refdata =3D {
>                 .subvendor      =3D PCI_ANY_ID,
>                 .subdevice      =3D PCI_ANY_ID,
>                 .setup          =3D pci_xr17v35x_setup,
> +               .exit           =3D pci_xr17v35x_exit,
>         },

Okay, why not to:
1) split out exar bits of 8250_pci.c (see 8250_mid.c case);
2) add gpio code either in place or separate file with sane and more
specific name?

--=20
With Best Regards,
Andy Shevchenko
