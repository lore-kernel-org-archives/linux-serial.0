From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 10/10] serial: exar: Add support for IOT2040 device
Date: Sat, 27 May 2017 16:52:28 +0300
Message-ID: <CAHp75VeH-3+k+xvMw--vk1DBtYj6Qdnczh7z77H3fboDzMScRQ@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <8d2c0204ee4ab6040787cb953b30284940eaa2bc.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <8d2c0204ee4ab6040787cb953b30284940eaa2bc.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 7:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> This implements the setup of RS232 and the switch-over to RS485 or RS422
> for the Siemens IOT2040. That uses an EXAR XR17V352 with external logic
> to switch between the different modes. The external logic is controlled
> via MPIO pins of the EXAR controller.
>
> Only pin 10 can be exported as GPIO on the IOT2040. It is connected to
> an LED.
>
> As the XR17V352 used on the IOT2040 is not equipped with an external
> EEPROM, it cannot present itself as IOT2040-variant via subvendor/
> subdevice IDs. Thus, we have to check via DMI for the target platform.

>  static void *
> -xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_pin,
> -                      unsigned int npins)
> +__xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_pin,
> +                        unsigned int npins)

> +static int xr17v35x_register_gpio(struct pci_dev *pcidev,
> +                                 struct uart_8250_port *port)
> +{
> +       if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
> +               port->port.private_data =
> +                       __xr17v35x_register_gpio(pcidev, 0, 16);
> +
> +       return 0;
> +}

> -               if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
> -                       port->port.private_data =
> -                               xr17v35x_register_gpio(pcidev, 0, 16);
> +               ret = platform->register_gpio(pcidev, port);
>         }

Can't you move at least some of this to the patch where you move the check?

-- 
With Best Regards,
Andy Shevchenko
