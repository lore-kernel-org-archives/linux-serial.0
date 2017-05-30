From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 8/9] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Tue, 30 May 2017 21:35:49 +0300
Message-ID: <CAHp75VciA5F7y8u_uyia8MDWzU1DAXkbmdBbMoORO0PW33XttQ@mail.gmail.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com> <0dc397840e180777e412158f8e7057c313e75b34.1496127684.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0dc397840e180777e412158f8e7057c313e75b34.1496127684.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
> rest is required to operate the UART. To allow modeling this case,
> expand the platform device data structure to specify a (consecutive) pin
> subset for exporting by the gpio-exar driver.

>  static void *
> -xr17v35x_register_gpio(struct pci_dev *pcidev)

> +xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_pin,
> +                      unsigned int ngpios)

I would rather to provide properties here as a parameter...

>  {
> +       struct property_entry properties[] = {
> +               PROPERTY_ENTRY_U32("gpio-exar,first-pin", first_pin),
> +               PROPERTY_ENTRY_U32("ngpios", ngpios),
> +               { }
> +       };

>                 if (pcidev->vendor == PCI_VENDOR_ID_EXAR)

...while defining them somewhere here.

>                         port->port.private_data =
> -                               xr17v35x_register_gpio(pcidev);
> +                               xr17v35x_register_gpio(pcidev, 0, 16);

-- 
With Best Regards,
Andy Shevchenko
