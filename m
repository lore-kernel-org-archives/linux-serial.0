From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/3] gpio: exar: add gpio for exar cards
Date: Thu, 5 Jan 2017 12:42:16 +0200
Message-ID: <CAHp75Ve1FnN9kvF-9_UCVTU1ABLFBBEg-ZQYAH5N-LrHCupGgA@mail.gmail.com>
References: <1483611602-5560-1-git-send-email-sudipm.mukherjee@gmail.com> <1483611602-5560-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1483611602-5560-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 5, 2017 at 12:20 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
>
> Add the gpio specific code.
>

My comments below


> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>

Alphabetical order?

> +
> +#define EXAR_OFFSET_MPIOLVL_LO 0x90
> +#define EXAR_OFFSET_MPIOSEL_LO 0x93
> +#define EXAR_OFFSET_MPIOLVL_HI 0x96
> +#define EXAR_OFFSET_MPIOSEL_HI 0x99
> +
> +static LIST_HEAD(exar_list);
> +static DEFINE_MUTEX(exar_list_mtx);
> +static struct ida ida_index;

> +static inline unsigned int read_exar_reg(struct exar_gpio_chip *chip,
> +                                        int offset)
> +{
> +       dev_dbg(chip->gpio_chip.parent, "%s regs=%p offset=%x\n",
> +               __func__, chip->regs, offset);

__func__ is redundant for *_dbg() in case of Dynamic Debug. Do you
have other case in mind?

> +
> +       return readb(chip->regs + offset);
> +}

> +static int gpio_exar_probe(struct platform_device *pdev)
> +{
> +       struct pci_dev *dev = platform_get_drvdata(pdev);
> +       struct exar_gpio_chip *exar_gpio, *exar_temp;
> +       void __iomem *p;
> +       int index = 1;
> +       int ret;
> +
> +       if (dev->vendor != PCI_VENDOR_ID_EXAR)
> +               return -ENODEV;
> +
> +       p = pci_ioremap_bar(dev, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       exar_gpio = devm_kzalloc(&dev->dev, sizeof(*exar_gpio), GFP_KERNEL);
> +       if (!exar_gpio) {
> +               ret = -ENOMEM;
> +               goto err_unmap;
> +       }
> +
> +       mutex_init(&exar_gpio->lock);
> +       INIT_LIST_HEAD(&exar_gpio->list);
> +
> +       index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +       mutex_lock(&exar_list_mtx);
> +
> +       sprintf(exar_gpio->name, "exar_gpio%d", index);
> +       exar_gpio->gpio_chip.label = exar_gpio->name;
> +       exar_gpio->gpio_chip.parent = &dev->dev;
> +       exar_gpio->gpio_chip.direction_output = exar_direction_output;
> +       exar_gpio->gpio_chip.direction_input = exar_direction_input;
> +       exar_gpio->gpio_chip.get_direction = exar_get_direction;
> +       exar_gpio->gpio_chip.get = exar_get_value;
> +       exar_gpio->gpio_chip.set = exar_set_value;
> +       exar_gpio->gpio_chip.base = -1;
> +       exar_gpio->gpio_chip.ngpio = 16;

> +       exar_gpio->gpio_chip.owner = THIS_MODULE;

Do we still need this?

> +       exar_gpio->regs = p;
> +       exar_gpio->index = index;
> +
> +       ret = gpiochip_add(&exar_gpio->gpio_chip);
> +       if (ret)
> +               goto err_destroy;
> +
> +       list_add_tail(&exar_gpio->list, &exar_list);
> +       mutex_unlock(&exar_list_mtx);
> +
> +       platform_set_drvdata(pdev, exar_gpio);
> +
> +       return 0;
> +
> +err_destroy:
> +       mutex_unlock(&exar_list_mtx);
> +       mutex_destroy(&exar_gpio->lock);
> +err_unmap:

> +       iounmap(p);

First of all, pci_iounmap_bar() (or how is it called?).
Second, question, when you get here is PCI device enabled or not? I
think it should be. Thus, is it enabled using PCI managed resources?
If so, you don't need this line and same in ->remove().

> +       return ret;
> +}
> +
> +static int gpio_exar_remove(struct platform_device *pdev)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_temp1, *exar_temp2;

*_eg1, *_eg2 ?

> +       struct pci_dev *pcidev;
> +       int index;
> +
> +       exar_gpio = platform_get_drvdata(pdev);
> +       pcidev = to_pci_dev(exar_gpio->gpio_chip.parent);
> +       index = exar_gpio->index;
> +
> +       mutex_lock(&exar_list_mtx);
> +       list_for_each_entry_safe(exar_temp1, exar_temp2, &exar_list, list) {
> +               if (exar_temp1->index == exar_gpio->index) {
> +                       list_del(&exar_temp1->list);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&exar_list_mtx);
> +
> +       gpiochip_remove(&exar_gpio->gpio_chip);
> +       mutex_destroy(&exar_gpio->lock);
> +       iounmap(exar_gpio->regs);
> +       ida_simple_remove(&ida_index, index);

> +       platform_set_drvdata(pdev, pcidev);

Not sure why it is here and in this form.

> +
> +       return 0;
> +}
> +
> +static struct platform_driver gpio_exar_driver = {
> +       .probe  = gpio_exar_probe,
> +       .remove = gpio_exar_remove,
> +       .driver = {
> +               .name = "gpio_exar",
> +       },
> +};
> +


> +static const struct platform_device_id gpio_exar_id[] = {
> +       { "gpio_exar", 0},
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(platform, gpio_exar_id);

Don't see how it's used.
Perhaps just

#define DRIVER_NAME "gpio_exar"

       .driver = {
               .name = DRIVER_NAME,
       },

MODULE_ALIAS("platform:" DRIVER_NAME);

?

> +static int __init exar_gpio_init(void)
> +{
> +       ida_init(&ida_index);
> +       platform_driver_register(&gpio_exar_driver);
> +       return 0;
> +}

> +
> +static void __exit exar_gpio_exit(void)
> +{
> +       platform_driver_unregister(&gpio_exar_driver);
> +       ida_destroy(&ida_index);
> +}
> +
> +module_init(exar_gpio_init);
> +module_exit(exar_gpio_exit);

Do you need ida_* calls there? If you will use DEFINE_IDA() macro I
think you don't need it.
Thus, module_platform_driver().

-- 
With Best Regards,
Andy Shevchenko
