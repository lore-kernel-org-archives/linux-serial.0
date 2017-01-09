From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v8 1/3] gpio: exar: add gpio for exar cards
Date: Mon, 9 Jan 2017 02:30:28 +0200
Message-ID: <CAHp75VegVQBFfdRHykvLTSc5LfoKxQ40c2O84efxoQy3xDXCAA@mail.gmail.com>
References: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1483914727-6076-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 9, 2017 at 12:32 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
> can be controlled using gpio interface.
>
> Add the gpio specific code.W

Few comments since it will be v9.

> +#define DRIVER_NAME "gpio_exar"
> +
> +static LIST_HEAD(exar_list);
> +static DEFINE_MUTEX(exar_list_mtx);

> +DEFINE_IDA(ida_index);

Should be static?

> +
> +struct exar_gpio_chip {
> +       struct gpio_chip gpio_chip;
> +       struct pci_dev *pcidev;
> +       struct mutex lock;
> +       struct list_head list;
> +       int index;
> +       void __iomem *regs;
> +       char name[16];

Since you are using %d + 7 characters 16 wouldn't be enough.

> +};


> +static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       int val;
> +
> +       if (offset < 8)
> +               val = exar_get(chip, EXAR_OFFSET_MPIOSEL_LO) >> offset;
> +       else
> +               val = exar_get(chip, EXAR_OFFSET_MPIOSEL_HI) >>
> +                              (offset - 8);

By the way, does it support up to 16 pins only?

You might consider something like this instead

addr = offset / 8 ? HI : LO;

op(addr) >> (offset % 8);

Similar for the rest of functions.

> +static int gpio_exar_probe(struct platform_device *pdev)
> +{
> +       struct pci_dev *dev = platform_get_drvdata(pdev);
> +       struct exar_gpio_chip *exar_gpio;
> +       void __iomem *p;

> +       int index = 1;

Redundant assignment

> +       int ret;
> +
> +       if (dev->vendor != PCI_VENDOR_ID_EXAR)
> +               return -ENODEV;
> +
> +       p = pci_ioremap_bar(dev, 0);

I would make it clear by using pcim_iomap(dev, 0, 0);
And put a comment that explains why we are using managed function here.

-- 
With Best Regards,
Andy Shevchenko
