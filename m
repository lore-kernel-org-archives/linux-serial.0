From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/8] gpio: exar: Fix passing in of parent PCI device
Date: Sat, 13 May 2017 16:25:36 +0300
Message-ID: <CAHp75VfCd4feKeHOe4QMM88nMQ5wnP4yk7iDJMXN7LcygXVObw@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <20f1d241d134f9f4932a26e4bd873ffc250affce.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20f1d241d134f9f4932a26e4bd873ffc250affce.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> This fixes reloading of the driver for the same device: First of all,
> the driver sets drvdata to its own value during probing and does not
> restore the original value on exit. But this won't help anyway as the
> core clears drvdata after the driver left.
>
> Use stable platform_data instead.

>From the above I didn't clearly get what device you are talking about.
GPIO?

Can you provide step by step what you did and what bug you got?

Regarding below it looks to me a bit hackish.

>  static int gpio_exar_probe(struct platform_device *pdev)
>  {
> -       struct pci_dev *pcidev = platform_get_drvdata(pdev);
> +       struct pci_dev *pcidev = *(struct pci_dev **)pdev->dev.platform_data;
>         struct exar_gpio_chip *exar_gpio;
>         void __iomem *p;
>         int index, ret;
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index b4fa585156c7..2d056d1eeca3 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -196,8 +196,12 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
>         if (!pdev)
>                 return NULL;
>
> -       platform_set_drvdata(pdev, pcidev);
> -       if (platform_device_add(pdev) < 0) {
> +       /*
> +        * platform_device_add_data kmemdups the data, therefore we can safely
> +        * pass a stack reference.
> +        */
> +       if (platform_device_add_data(pdev, &pcidev, sizeof(pcidev)) < 0 ||
> +           platform_device_add(pdev) < 0) {
>                 platform_device_put(pdev);
>                 return NULL;

-- 
With Best Regards,
Andy Shevchenko
