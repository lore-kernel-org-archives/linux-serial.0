From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v5 3/6] mfd: at91-usart: added mfd driver for usart
Date: Mon, 11 Jun 2018 16:55:28 +0200
Message-ID: <CAFqH_52gx_As_BE+WV8mUS5Ajab_4XN9EW_8K4hrwKqUHzSYSQ@mail.gmail.com>
References: <20180604165943.31381-1-radu.pirea@microchip.com> <20180604165943.31381-4-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604165943.31381-4-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: radu.pirea@microchip.com
Cc: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Lee Jones <lee.jones@linaro.org>, richard.genoud@gmail.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-spi@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Radu,

Some few feedback in a hope to help you.

Missatge de Radu Pirea <radu.pirea@microchip.com> del dia dl., 4 de
juny 2018 a les 19:03:
>
> This mfd driver is just a wrapper over atmel_serial driver and
> spi-at91-usart driver. Selection of one of the drivers is based on a
> property from device tree. If the property is not specified, the default
> driver is atmel_serial.
>
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/Kconfig      |  9 ++++++
>  drivers/mfd/Makefile     |  1 +
>  drivers/mfd/at91-usart.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 drivers/mfd/at91-usart.c
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..a886672b960d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -99,6 +99,15 @@ config MFD_AAT2870_CORE
>           additional drivers must be enabled in order to use the
>           functionality of the device.
>
> +config MFD_AT91_USART
> +       tristate "AT91 USART Driver"
> +       select MFD_CORE
> +       help
> +         Select this to get support for AT91 USART IP. This is a wrapper
> +         over at91-usart-serial driver and usart-spi-driver. Only one function
> +         can be used at a time. The choice is done at boot time by the probe
> +         function of this MFD driver according to a device tree property.
> +
>  config MFD_ATMEL_FLEXCOM
>         tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
>         select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d9d2cf0d32ef..db1332aa96db 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC) += qcom-spmi-pmic.o
>  obj-$(CONFIG_TPS65911_COMPARATOR)      += tps65911-comparator.o
>  obj-$(CONFIG_MFD_TPS65090)     += tps65090.o
>  obj-$(CONFIG_MFD_AAT2870_CORE) += aat2870-core.o
> +obj-$(CONFIG_MFD_AT91_USART)   += at91-usart.o
>  obj-$(CONFIG_MFD_ATMEL_FLEXCOM)        += atmel-flexcom.o
>  obj-$(CONFIG_MFD_ATMEL_HLCDC)  += atmel-hlcdc.o
>  obj-$(CONFIG_MFD_ATMEL_SMC)    += atmel-smc.o
> diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
> new file mode 100644
> index 000000000000..262e7affba22
> --- /dev/null
> +++ b/drivers/mfd/at91-usart.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0+

This means GPL-2.0 or later ...

> +/*
> + * Driver for AT91 USART
> + *
> + * Copyright (C) 2018 Microchip Technology
> + *
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + *
> + */
> +
> +#include <dt-bindings/mfd/at91-usart.h>
> +
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/property.h>
> +
> +static struct mfd_cell at91_usart_spi_subdev = {
> +               .name = "at91_usart_spi",
> +               .of_compatible = "microchip,at91sam9g45-usart-spi",
> +       };
> +
> +static struct mfd_cell at91_usart_serial_subdev = {
> +               .name = "atmel_usart_serial",
> +               .of_compatible = "atmel,at91rm9200-usart-serial",
> +       };
> +
> +static int at91_usart_mode_probe(struct platform_device *pdev)
> +{
> +       struct mfd_cell cell;
> +       u32 opmode;
> +       int err;
> +
> +       err = device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> +

The returned value is not checked (and probably has no sense to
check), so I think you can just remove the err variable.

> +       switch (opmode) {
> +       case AT91_USART_MODE_SPI:
> +               cell = at91_usart_spi_subdev;
> +               break;
> +       case AT91_USART_MODE_SERIAL:
> +       default:
> +               cell = at91_usart_serial_subdev;
> +       }
> +
> +       return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
> +                             NULL, 0, NULL);
> +}
> +
> +static const struct of_device_id at91_usart_mode_of_match[] = {
> +       { .compatible = "atmel,at91rm9200-usart" },
> +       { .compatible = "atmel,at91sam9260-usart" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_flexcom_of_match);
> +
> +static struct platform_driver at91_usart_mfd = {
> +       .probe  = at91_usart_mode_probe,
> +       .driver = {
> +               .name           = "at91_usart_mode",
> +               .of_match_table = at91_usart_mode_of_match,
> +       },
> +};
> +
> +module_platform_driver(at91_usart_mfd);
> +
> +MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
> +MODULE_DESCRIPTION("AT91 USART MFD driver");
> +MODULE_LICENSE("GPL v2");

And this means GPL-2.0-only, so there is a mismatch. The SPDX
identifier should be GPL-2.0 or the module license should be GPL.

> --
> 2.17.1
>
Cheers,
  Enric
