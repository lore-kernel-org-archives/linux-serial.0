From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5] serial: 8250: add gpio support to exar
Date: Tue, 19 Jan 2016 12:09:08 +0200
Message-ID: <CAHp75VdopyRUcwSFY=qowoiq6Twkg686oQHed8WU5Ep8QQtL+A@mail.gmail.com>
References: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Hung <hpeter@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 8:06 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs whic=
h
> can be controlled using gpio interface.
> Add support to use these pins.

+ Peter Hung.

Seems Fintek HW is going similar way you, guys, have to decide how to
proceed in general. I like this way Sudip made here, though I still
few comments below.

=46irst of all, can we split it to two patches like cooking GPIO driver
first, then extend Exar piece of serial driver?

I also would like to vote for splitting out first Exar parts from
8250_pci like Peter did for Fintek.

> +++ b/drivers/gpio/gpio-exar.c
> @@ -0,0 +1,255 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>
> +
> +#define EXAR_OFFSET_MPIOLVL_LO 0x90
> +#define EXAR_OFFSET_MPIOSEL_LO 0x93
> +#define EXAR_OFFSET_MPIOLVL_HI 0x96
> +#define EXAR_OFFSET_MPIOSEL_HI 0x99
> +
> +static LIST_HEAD(exar_list);
> +static DEFINE_MUTEX(exar_mtx); /* lock while manipulating the list *=
/

I don't think it's a useful comment, though you may rename
exar_mtx to exar_list_mutex. It will be enough I guess.

> +
> +struct exar_gpio_chip {
> +       struct gpio_chip gpio_chip;
> +       struct mutex lock;
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

> +static void exar_set(struct gpio_chip *chip, unsigned int reg, int v=
al,
> +                    unsigned int offset)

This one by implementation looks like exar_update()

> +{
> +       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);
> +       int temp;

Looks like value -> val, maybe temp -> tmp?
It's minor, up to you.

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

Maybe

static int exar_set_direction(struct gpio_chip *chip, int direction,
unsigned int offset)
{
       if (offset < 8)
               exar_set(chip, EXAR_OFFSET_MPIOSEL_LO, direction, offset=
 - 0);
       else
               exar_set(chip, EXAR_OFFSET_MPIOSEL_HI, direction, offset=
 - 8);
       return 0;
}

static int exar_direction_output(struct gpio_chip *chip, unsigned int o=
ffset)
{
   return exar_set_direction(chip, 0, offset);
}

static int exar_direction_input(struct gpio_chip *chip, unsigned int of=
fset)
{
   return exar_set_direction(chip, 1, offset);
}

?

> +
> +static int exar_get(struct gpio_chip *chip, unsigned int reg)
> +{
> +       int value;
> +       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);

       struct exar_gpio_chip *exar_gpio =3D to_exar_chip(chip);
       int value;

> +       if (!exar_gpio) {
> +               pr_err("%s exar_gpio is NULL\n", __func__);

I don't think this is useful message and even entire condition. How is
it possible that you get it NULL?

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
> +
> +       if (offset < 8) {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_LO);

               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_LO) >> offset=
;

> +       } else {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_HI);

               val =3D exar_get(chip, EXAR_OFFSET_MPIOSEL_HI) >> (offse=
t - 8);

> +               offset -=3D 8;
> +       }
> +
> +       if (val > 0) {
> +               val >>=3D offset;
> +               val &=3D 0x01;
> +       }
> +
> +       return val;

return val & 0x01;

(Assume you have no error values returned)

> +}
> +
> +static int exar_get_value(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       int val;
> +
> +       if (offset < 8) {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_LO);
> +       } else {
> +               val =3D exar_get(chip, EXAR_OFFSET_MPIOLVL_HI);
> +               offset -=3D 8;
> +       }
> +       val >>=3D offset;
> +       val &=3D 0x01;

Ditto

> +
> +       return val;
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
> +static int gpio_exar_probe(struct platform_device *pdev)
> +{
> +       struct pci_dev *dev =3D platform_get_drvdata(pdev);
> +       struct exar_gpio_chip *exar_gpio, *exar_temp;
> +       void __iomem *p;
> +       int index =3D 1;
> +       int ret;
> +
> +       if (dev->vendor !=3D PCI_VENDOR_ID_EXAR)
> +               return -ENODEV;
> +
> +       p =3D pci_ioremap_bar(dev, 0);

So, if it would be separate driver for 8250_exar.c (by the way what is
8250_exar_st16c554.c?) you will use managed functions here=E2=80=A6

> +       if (!p)
> +               return -ENOMEM;
> +
> +       exar_gpio =3D devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP=
_KERNEL);
> +       if (!exar_gpio) {
> +               ret =3D -ENOMEM;
> +               goto err_unmap;

=E2=80=A6and thus no need to free resources explicitly.

> +       }
> +
> +       mutex_init(&exar_gpio->lock);
> +       INIT_LIST_HEAD(&exar_gpio->list);
> +
> +       mutex_lock(&exar_mtx);
> +       /* find the first unused index */
> +       list_for_each_entry(exar_temp, &exar_list, list) {
> +               if (exar_temp->index =3D=3D index) {
> +                       index++;

Shouldn't be ida/idr value?

> +                       continue;
> +               }
> +       }
> +
> +       sprintf(exar_gpio->name, "exar_gpio%d", index);
> +       exar_gpio->gpio_chip.label =3D exar_gpio->name;
> +       exar_gpio->gpio_chip.parent =3D &dev->dev;
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

Does core set it for you?

> +       exar_gpio->regs =3D p;
> +       exar_gpio->index =3D index;
> +
> +       ret =3D gpiochip_add(&exar_gpio->gpio_chip);
> +       if (ret)
> +               goto err_destroy;
> +
> +       list_add_tail(&exar_gpio->list, &exar_list);
> +       mutex_unlock(&exar_mtx);
> +
> +       platform_set_drvdata(pdev, exar_gpio);
> +
> +       return 0;
> +
> +err_destroy:

> +       mutex_unlock(&exar_mtx);
> +       mutex_destroy(&exar_gpio->lock);

I think it would be done in other way if you use IDR framework.

> +err_unmap:
> +       iounmap(p);
> +       return ret;
> +}
> +
> +static int gpio_exar_remove(struct platform_device *pdev)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_temp1, *exar_temp2;
> +
> +       exar_gpio =3D platform_get_drvdata(pdev);
> +
> +       mutex_lock(&exar_mtx);
> +       list_for_each_entry_safe(exar_temp1, exar_temp2, &exar_list, =
list) {
> +               if (exar_temp1->index =3D=3D exar_gpio->index) {
> +                       list_del(&exar_temp1->list);
> +                       break;

Ditto.

> +               }
> +       }
> +       mutex_unlock(&exar_mtx);
> +
> +       gpiochip_remove(&exar_gpio->gpio_chip);
> +       mutex_destroy(&exar_gpio->lock);
> +       iounmap(exar_gpio->regs);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver gpio_exar_driver =3D {
> +       .probe  =3D gpio_exar_probe,
> +       .remove =3D gpio_exar_remove,
> +       .driver =3D {
> +               .name =3D "gpio_exar",

DRIVER_NAME

> +       },
> +};
> +

> +static const struct platform_device_id gpio_exar_id[] =3D {

> +       { "gpio_exar", 0},

This is default fallback. I don't think you need this at all (example
in my mind is dw_dmac driver, where you can't find such line). But
please recheck.

> +       { },
> +};


> +
> +MODULE_DEVICE_TABLE(platform, gpio_exar_id);
> +
> +module_platform_driver(gpio_exar_driver)
> +
> +MODULE_DESCRIPTION("Exar GPIO driver");
> +MODULE_AUTHOR("Sudip Mukherjee <sudipm.mukherjee@gmail.com>");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS("platform:" DRIVER_NAME);
where DRIVER_NAME is defined somewhere on top.


--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
