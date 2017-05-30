From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/9] gpio-exar/8250-exar: Do not even instantiate a
 GPIO device for Commtech cards
Date: Tue, 30 May 2017 21:33:35 +0300
Message-ID: <CAHp75Vc0t5t8O5cPaxX_oQJQKsN3OWNFfqnA_K3GW4qpfY+N5Q@mail.gmail.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com> <f7e7da1ae81aab7f53faa32260d4ee0f930048fe.1496127684.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f7e7da1ae81aab7f53faa32260d4ee0f930048fe.1496127684.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Commtech adapters need the MPIOs for internal purposes, and the
> gpio-exar driver already refused to pick them up. But there is actually
> no point in even creating the underlying platform device.

It still feels that partially you may do stuff here, like
renaming to
__xr17v35x_register_gpio()
and creating
xr17v35x_register_gpio() wrapper.

> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index 081076771217..006a9a67c2a4 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -124,9 +124,6 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         void __iomem *p;
>         int index, ret;
>
> -       if (pcidev->vendor != PCI_VENDOR_ID_EXAR)
> -               return -ENODEV;
> -
>         /*
>          * Map the pci device to get the register addresses.
>          * We will need to read and write those registers to control
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 8984e8b2d524..c29c7e675890 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -245,7 +245,9 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>                 /* Setup Multipurpose Input/Output pins. */
>                 setup_gpio(pcidev, p);
>
> -               port->port.private_data = xr17v35x_register_gpio(pcidev);
> +               if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
> +                       port->port.private_data =
> +                               xr17v35x_register_gpio(pcidev);
>         }
>
>         return 0;
> --
> 2.12.3
>



-- 
With Best Regards,
Andy Shevchenko
