From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 7/8] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Sat, 13 May 2017 16:50:02 +0300
Message-ID: <CAHp75VemXiTDMtn62=tE0Da69G2gAoCTWvgjw3bh_+o8pzF47A@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <49df8cbd7204a5f145834715ab353f03f417e1f8.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <49df8cbd7204a5f145834715ab353f03f417e1f8.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
> rest is required to operate the UART. To allow modeling this case,
> use device properties to specify a (consecutive) pin subset for
> exporting by the gpio-exar driver.

> @@ -123,6 +132,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         struct exar_gpio_chip *exar_gpio;
>         void __iomem *p;
>         int index, ret;
> +       u32 val;
>
>         if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
>                 return -ENODEV;
> @@ -152,9 +162,12 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         exar_gpio->gpio_chip.get = exar_get_value;
>         exar_gpio->gpio_chip.set = exar_set_value;
>         exar_gpio->gpio_chip.base = -1;
> -       exar_gpio->gpio_chip.ngpio = 16;

> +       device_property_read_u32(&pdev->dev, "ngpio", &val);
> +       exar_gpio->gpio_chip.ngpio = val;

You have to check return code, otherwise you might end up with
uninitialized data.

>         exar_gpio->regs = p;
>         exar_gpio->index = index;
> +       device_property_read_u32(&pdev->dev, "first_gpio", &val);
> +       exar_gpio->first_gpio = val;

Ditto.

>  #include <linux/string.h>
>  #include <linux/tty.h>
>  #include <linux/8250_pci.h>

> +#include <linux/property.h>

Alphabetical order, please.

>  static void *
> -xr17v35x_register_gpio(struct pci_dev *pcidev)
> +xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
> +                      unsigned int ngpio)
>  {
> +       struct property_entry properties[] = {

> +               PROPERTY_ENTRY_U32("first_gpio", first_gpio),

This should be documented in device tree bindings, otherwise it's a
linux software hook and I'm not sure it's the best what we can do
here.

> +               PROPERTY_ENTRY_U32("ngpio", ngpio),

This should be a registered property name (I see "ngpios" in the bindings).

> +               { }
> +       };
>         struct platform_device *pdev;
>
>         pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);


>         /*
> -        * platform_device_add_data kmemdups the data, therefore we can safely
> -        * pass a stack reference.
> +        * platform_device_add_data and platform_device_add_properties copy
> +        * the data, therefore we can safely pass a stack references.
>          */

Can you formulate this in an order to reduce ping-ponging lines across
the series?

-- 
With Best Regards,
Andy Shevchenko
