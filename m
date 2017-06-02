From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 10/11] gpio-exar/8250-exar: Make set of exported GPIOs configurable
Date: Fri, 2 Jun 2017 13:32:53 +0300
Message-ID: <CAHp75Vfd4bmFCEpE8B0cNgKcmYVrJ=KjijY6Qq2HVtPPzOxoLA@mail.gmail.com>
References: <cover.1496388533.git.jan.kiszka@siemens.com> <f8b03cad4ea23bf64f9e1fe29f38a1998b458293.1496388533.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <f8b03cad4ea23bf64f9e1fe29f38a1998b458293.1496388533.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 2, 2017 at 10:28 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On the SIMATIC, IOT2040 only a single pin is exportable as GPIO, the
> rest is required to operate the UART. To allow modeling this case,
> expand the platform device data structure to specify a (consecutive) pin
> subset for exporting by the gpio-exar driver.

> +       if (device_property_read_u32(&pdev->dev, "gpio-exar,first-pin",
> +                                    &first_pin) < 0 ||
> +           device_property_read_u32(&pdev->dev, "ngpios", &ngpios) < 0)
> +               return -EINVAL;

You shadow an error.

Please use
ret = device_property_...;
if (ret)
 return ret;

ret = ...
...

Moreover, I missed how you named first property, I would go rather
with "linux," prefix to show that is _internal_ / Linux only property.

Perhaps something like "linux,first-pin" ?

-- 
With Best Regards,
Andy Shevchenko
