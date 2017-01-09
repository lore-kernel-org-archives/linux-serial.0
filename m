From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 1/3] gpio: exar: add gpio for exar cards
Date: Mon, 9 Jan 2017 11:35:51 +0100
Message-ID: <CACRpkdaBJteocVSUazhz0zYtXeBKSVekEkxGfpDNAoqN04A77Q@mail.gmail.com>
References: <1483833469-11422-1-git-send-email-sudipm.mukherjee@gmail.com> <1483833469-11422-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483833469-11422-2-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 8, 2017 at 12:57 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:

> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
>
> Add the gpio specific code.
>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Will I be able to merge this independently to the GPIO trees
once we are done with review? (Looks like so...)

> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Is this really useful?

> +#include <linux/device.h>
> +#include <linux/gpio.h>

No use:
#include <linux/gpio/driver.h>
ONLY

> +static LIST_HEAD(exar_list);
> +static DEFINE_MUTEX(exar_list_mtx);
> +DEFINE_IDA(ida_index);

What is this? A local list? I can understand the IDA index but in
general, follow the state container pattern instead:
Documentation/driver-model/design-patterns.txt

> +#define to_exar_chip(n) container_of(n, struct exar_gpio_chip, gpio_chip)

Don't do this, use
gpiochip_get_data()

> +static inline unsigned int read_exar_reg(struct exar_gpio_chip *chip,
> +                                        int offset)
> +{
> +       dev_dbg(chip->gpio_chip.parent, "regs=%p offset=%x\n",
> +               chip->regs, offset);
> +
> +       return readb(chip->regs + offset);
> +}
> +
> +static inline void write_exar_reg(struct exar_gpio_chip *chip, int offset,
> +                                 int value)
> +{
> +       dev_dbg(chip->gpio_chip.parent,
> +               "regs=%p value=%x offset=%x\n", chip->regs, value,
> +               offset);
> +       writeb(value, chip->regs + offset);
> +}


I don't see why these need their own accessor functions, just inline
the readb()/writeb() calls.

> +static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
> +                       unsigned int offset)
> +{
> +       struct exar_gpio_chip *exar_gpio = to_exar_chip(chip);

So just:

struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);

> +       int temp;
> +
> +       mutex_lock(&exar_gpio->lock);
> +       temp = read_exar_reg(exar_gpio, reg);
> +       temp &= ~(1 << offset);
> +       temp |= val << offset;

Use:
#include <linux/bitops.h>

temp &= BIT(offset);
if (val)
  temp |= BIT(offset);

> +static int exar_get(struct gpio_chip *chip, unsigned int reg)
> +{
> +       struct exar_gpio_chip *exar_gpio = to_exar_chip(chip);
> +       int value;
> +
> +       mutex_lock(&exar_gpio->lock);
> +       value = read_exar_reg(exar_gpio, reg);
> +       mutex_unlock(&exar_gpio->lock);
> +
> +       return value;

Please use:

return !!value;

To clamp to bool.

> +static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       int val;
> +
> +       if (offset < 8)
> +               val = exar_get(chip, EXAR_OFFSET_MPIOSEL_LO) >> offset;
> +       else
> +               val = exar_get(chip, EXAR_OFFSET_MPIOSEL_HI) >>
> +                              (offset - 8);
> +
> +       return val & 0x01;

Just

return !!val;

or something.

> +static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
> +{
> +       int val;
> +
> +       if (offset < 8)
> +               val = exar_get(chip, EXAR_OFFSET_MPIOLVL_LO) >> offset;
> +       else
> +               val = exar_get(chip, EXAR_OFFSET_MPIOLVL_HI) >>
> +                              (offset - 8);
> +       return val & 0x01;
> +}

Dito.

> +static int gpio_exar_probe(struct platform_device *pdev)
> +{
> +       struct pci_dev *dev = platform_get_drvdata(pdev);
> +       struct exar_gpio_chip *exar_gpio;
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
> +       if (!exar_gpio)
> +               return -ENOMEM;
> +
> +       mutex_init(&exar_gpio->lock);
> +       INIT_LIST_HEAD(&exar_gpio->list);
> +
> +       index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +       mutex_lock(&exar_list_mtx);

This looks overkill.

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
> +       exar_gpio->regs = p;
> +       exar_gpio->index = index;
> +       exar_gpio->pcidev = dev;
> +
> +       ret = gpiochip_add(&exar_gpio->gpio_chip);

Use devm_gpiochip_add_data(dev, &exar_gpio->gpio_chip, exar_gpio)

So you can later use gpiochip_get_data()

> +static int gpio_exar_remove(struct platform_device *pdev)
> +{
> +       struct exar_gpio_chip *exar_gpio, *exar_temp;
> +       struct pci_dev *pcidev;
> +       int index;
> +
> +       pcidev = platform_get_drvdata(pdev);
> +
> +       mutex_lock(&exar_list_mtx);
> +       list_for_each_entry_safe(exar_gpio, exar_temp, &exar_list, list) {
> +               if (exar_gpio->pcidev == pcidev) {
> +                       list_del(&exar_gpio->list);
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&exar_list_mtx);

Looks convoluted.

Set the platform_drvdata to exar_gpio instead and just free it.

Yours,
Linus Wallleij
