From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 07/10] gpio-exar/8250-exar: Rearrange gpiochip parenthood
Date: Sat, 27 May 2017 16:43:02 +0300
Message-ID: <CAHp75VcBUn0FKyEoxOS9tkvP6yZ2cEQ=OAa_Mr8+2-98zgEYnA@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <375d76dc3fe344f5168e8155211422de59f0efa0.1495814557.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <375d76dc3fe344f5168e8155211422de59f0efa0.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, May 26, 2017 at 7:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Set the parent of the exar gpiochip to its platform device, like other
> gpiochips are doing it. In order to keep the relationship discoverable
> for ACPI systems, set the platform device companion to the PCI device.
>

Setting companion is a right thing to do (like it's done in other similar cases)

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/gpio/gpio-exar.c            | 2 +-
>  drivers/tty/serial/8250/8250_exar.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index f3585a184f39..1a629831d45b 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -142,7 +142,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
>
>         sprintf(exar_gpio->name, "exar_gpio%d", index);
>         exar_gpio->gpio_chip.label = exar_gpio->name;
> -       exar_gpio->gpio_chip.parent = &pcidev->dev;
> +       exar_gpio->gpio_chip.parent = &pdev->dev;
>         exar_gpio->gpio_chip.direction_output = exar_direction_output;
>         exar_gpio->gpio_chip.direction_input = exar_direction_input;
>         exar_gpio->gpio_chip.get_direction = exar_get_direction;
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 0f4b236d7e68..ee4b142f3ed0 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -9,6 +9,7 @@
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License.
>   */
> +#include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -204,6 +205,7 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
>                 return NULL;
>
>         pdev->dev.parent = &pcidev->dev;
> +       ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
>
>         if (platform_device_add(pdev) < 0) {
>                 platform_device_put(pdev);
> --
> 2.12.0
>



-- 
With Best Regards,
Andy Shevchenko
