From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 1/3] gpio: exar: add gpio for exar cards
Date: Sun, 15 Jan 2017 16:57:32 +0200
Message-ID: <CAHp75VfcUr-1sjh+xySHMaeNEi7QxHANvqbHGwt9=uWeOvMCJQ@mail.gmail.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 15, 2017 at 12:50 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
>
> Add the gpio specific code.

Thanks for an updated code.
Briefly looking into first two patches v10 would be needed.

Here one important line is missed, nevertheless I'll go to comment
some minor stuff as well.
Overall looks good!

> name[16] should be enough. Maximum of 12 char will be used.

Better to use enough space, otherwise there is a room for a bug.
So, you need to understand that kernel might crash in such cases,
though it's minor for now.

> +++ b/drivers/gpio/gpio-exar.c
> @@ -0,0 +1,199 @@

> +static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
> +                       unsigned int offset)
> +{
> +       struct exar_gpio_chip *exar_gpio = gpiochip_get_data(chip);
> +       int temp;
> +
> +       mutex_lock(&exar_gpio->lock);
> +       temp = readb(exar_gpio->regs + reg);
> +       temp &= ~BIT(offset);

> +       if (val)
> +               temp |= BIT(offset);

You would do this in one line, but I dunno which style Linus prefers more

temp |= val ? BIT(...) : 0;

> +{
> +       unsigned int addr;
> +
> +       addr = offset / 8 ? EXAR_OFFSET_MPIOSEL_HI :
> +                               EXAR_OFFSET_MPIOSEL_LO;

Would it be one line?

Also you can consider

unsigned int bank = offset / 8;
unsigned int addr;

addr = bank ? _HI : _LO;

Same amount of lines, but a bit more readable. All other places as well.

> +static int gpio_exar_probe(struct platform_device *pdev)
> +{
> +       struct pci_dev *pcidev = platform_get_drvdata(pdev);
> +       struct exar_gpio_chip *exar_gpio;
> +       void __iomem *p;
> +       int index, ret;
> +
> +       if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
> +               return -ENODEV;
> +
> +       /*
> +        * Map the pci device to get the register addresses
> +        * We will need to read and write those registers to control
> +        * the GPIO pins.
> +        * Using managed functions will save us from unmaping on exit.

Yes, and "we may do that because UART driver enables managed functions".

> +        */

> +

Redundant empty line.

> +       p = pcim_iomap(pcidev, 0, 0);
> +       if (!p)
> +               return -ENOMEM;
> +
> +       exar_gpio = devm_kzalloc(&pcidev->dev, sizeof(*exar_gpio), GFP_KERNEL);
> +       if (!exar_gpio)
> +               return -ENOMEM;
> +
> +       mutex_init(&exar_gpio->lock);
> +
> +       index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +
> +       sprintf(exar_gpio->name, "exar_gpio%d", index);
> +       exar_gpio->gpio_chip.label = exar_gpio->name;
> +       exar_gpio->gpio_chip.parent = &pcidev->dev;
> +       exar_gpio->gpio_chip.direction_output = exar_direction_output;
> +       exar_gpio->gpio_chip.direction_input = exar_direction_input;
> +       exar_gpio->gpio_chip.get_direction = exar_get_direction;
> +       exar_gpio->gpio_chip.get = exar_get_value;
> +       exar_gpio->gpio_chip.set = exar_set_value;
> +       exar_gpio->gpio_chip.base = -1;
> +       exar_gpio->gpio_chip.ngpio = 16;
> +       exar_gpio->regs = p;
> +       exar_gpio->index = index;
> +
> +       ret = devm_gpiochip_add_data(&pcidev->dev,
> +                                    &exar_gpio->gpio_chip, exar_gpio);
> +       if (ret)
> +               goto err_destroy;
> +
> +       platform_set_drvdata(pdev, exar_gpio);
> +
> +       return 0;
> +
> +err_destroy:

> +       mutex_destroy(&exar_gpio->lock);

Important!
You missed ida_simple_remove(); here

And as side effect you might overflow name and crash kernel due to this bug.

> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
