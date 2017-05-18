From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Thu, 18 May 2017 19:33:24 +0300
Message-ID: <CAHp75VewiaiYq6esGTiTV8kG30krhuXLQgLFGn10jmjkooXGPA@mail.gmail.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com> <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 5:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
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
>
> Co-developed with Sascha Weisenberger.

Few nits below and one comment that should be addressed.

> +#define UART_EXAR_RS485_DLY(x) (x << 4)

((x) << 4)

> +static bool is_iot2040;

No, please, use driver data of DMI and hide this in corresponding structure.
Or even assign  port->port.rs485_config in the callback function.

Moreover, can't you use port->port.rs485_config != NULL instead?

> +
>  struct exar8250;
>
>  /**
> @@ -212,6 +252,82 @@ xr17v35x_register_gpio(struct pci_dev *pcidev, unsigned int first_gpio,
>         return pdev;
>  }
>
> +static int iot2040_rs485_config(struct uart_port *port,
> +                               struct serial_rs485 *rs485)
> +{
> +       u8 __iomem *p = port->membase;
> +       u8 mask = IOT2040_UART1_MASK;
> +       u8 mode, value;

> +       bool is_rs485 = false;
> +
> +       if (rs485->flags & SER_RS485_ENABLED) {
> +               is_rs485 = true;

bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);

if (is_rs485) {
...
} else {
...
}

> +       return 0;
> +}

> +static int iot2040_match(const struct dmi_system_id *dmi)
> +{
> +       is_iot2040 = true;
> +       return 1;
> +}

See above.

> +
> +static const struct dmi_system_id exar_platforms[] = {
> +       {
> +               .callback = iot2040_match,
> +               .ident = "IOT2040",
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
> +                       DMI_MATCH(DMI_BOARD_ASSET_TAG, "6ES7647-0AA00-1YA2"),
> +               },
> +       }
> +};

-- 
With Best Regards,
Andy Shevchenko
