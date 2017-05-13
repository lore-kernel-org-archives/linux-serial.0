From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/8] gpio: exar: Fix reading of directions and values
Date: Sat, 13 May 2017 16:36:23 +0300
Message-ID: <CAHp75Vdxoro-FoJY-t+FVk_9J6OBZMhJ9P9qjhq5a2bMOJMW9A@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <1891081c09747965173fb03a7305e1c73033dac0.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1891081c09747965173fb03a7305e1c73033dac0.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> First, the logic for translating a register bit to the return code of
> exar_get_direction and exar_get_value were wrong. And second, there was
> a flip regarding the register bank in exar_get_direction.

Again, I wish it was tested in the first place.

After addressing below:
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> @@ -68,7 +68,7 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
>         value = readb(exar_gpio->regs + reg);
>         mutex_unlock(&exar_gpio->lock);
>
> -       return !!value;
> +       return value;

This one is correct.

> @@ -80,7 +80,7 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
>         addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
>         val = exar_get(chip, addr) >> (offset % 8);
>
> -       return !!val;
> +       return val & 1;

It should be rather

        val = exar_get(chip, addr) & BIT(offset % 8);

>  }
>
>  static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
> @@ -89,10 +89,10 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
>         unsigned int addr;
>         int val;
>
> -       addr = bank ? EXAR_OFFSET_MPIOLVL_LO : EXAR_OFFSET_MPIOLVL_HI;
> +       addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;

Good catch!

>         val = exar_get(chip, addr) >> (offset % 8);
>
> -       return !!val;
> +       return val & 1;

Ditto (see above).

-- 
With Best Regards,
Andy Shevchenko
