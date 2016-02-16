From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO GPIOLIB support
Date: Tue, 16 Feb 2016 15:03:55 +0800
Message-ID: <56C2C9DB.8020302@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-3-git-send-email-hpeter+linux_kernel@gmail.com>
 <CACRpkdZ7DAP6a8scUSGxNBdAMHjtRUOcOYbEB15PK1QHBdQdUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ7DAP6a8scUSGxNBdAMHjtRUOcOYbEB15PK1QHBdQdUA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.com>, Peter H <peter_hong@fintek.com.tw>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, soeren.grunewald@desy.de, Wang YanQing <udknight@gmail.com>, Adam Lee <adam.lee@canonical.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.o
List-Id: linux-serial@vger.kernel.org

Hi Linus,

Linus Walleij =E6=96=BC 2016/2/10 =E4=B8=8B=E5=8D=88 05:08 =E5=AF=AB=E9=
=81=93:
> On Thu, Jan 28, 2016 at 10:20 AM, Peter Hung <hpeter@gmail.com> wrote=
:
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio.h>
>
> Drivers should just
> #include <linux/gpio/driver.h>

ok.

>> +static struct f81504_gpio_chip *gpio_to_f81504_chip(struct gpio_chi=
p *chip)
>> +{
>> +       return container_of(chip, struct f81504_gpio_chip, chip);
>> +}
>
> Avoid this construction in new code.
>
> Use gpiochip_get_data(chip) everywhere that gpio_to_f81504_chip()
> is used and register the gpiochip with gpiochip_add_data()
> and the code will be simpler.
>
> See any other driver in drivers/gpio for examples, I converted them
> all.

ok. I'll re-write this section.

>> +
>> +       if (tmp & BIT(offset))
>> +               return GPIOF_DIR_OUT;
>> +
>> +       return GPIOF_DIR_IN;
>> +}
>
> Do not use GPIOF* flags in driver code, these are for the consumer
> API. Just return 0/1.

ok

>> +       status =3D gpiochip_add(&gc->chip);
>
> As mentioned, use gpiochip_add_data(&gc->chip, gc);
>

ok.

>> +static struct platform_driver f81504_gpio_driver =3D {
>> +       .driver =3D {
>> +               .name   =3D F81504_GPIO_NAME,
>> +               .owner  =3D THIS_MODULE,
>
> I saw coccinelle was already complaining about this.
>
> Looking forward to v3!

I had sent V3 today to resolve the issue above.

Thanks for your advices.
--=20
With Best Regards,
Peter Hung
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
