From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/8] gpio: exar: Allocate resources on behalf of the
 platform device
Date: Sat, 13 May 2017 16:26:50 +0300
Message-ID: <CAHp75VesZMm3536KOwAm-f1ttwzMa+42aQz7dWCXkN3Rxz==mQ@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <39cc60caa4f5c38d1449590b6c67cf026184306b.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <39cc60caa4f5c38d1449590b6c67cf026184306b.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> Do not allocate resources on behalf of the parent device but on our own.
> Otherwise, cleanup does not properly work if gpio-exar is removed but
> not the parent device.

This sounds to me like a good catch.
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/gpio/gpio-exar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index 0a2085faf271..9138ee087c5d 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -139,7 +139,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         if (!p)
>                 return -ENOMEM;
>
> -       exar_gpio = devm_kzalloc(&pcidev->dev, sizeof(*exar_gpio), GFP_KERNEL);
> +       exar_gpio = devm_kzalloc(&pdev->dev, sizeof(*exar_gpio), GFP_KERNEL);
>         if (!exar_gpio)
>                 return -ENOMEM;
>
> @@ -160,7 +160,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         exar_gpio->regs = p;
>         exar_gpio->index = index;
>
> -       ret = devm_gpiochip_add_data(&pcidev->dev,
> +       ret = devm_gpiochip_add_data(&pdev->dev,
>                                      &exar_gpio->gpio_chip, exar_gpio);
>         if (ret)
>                 goto err_destroy;
> --
> 2.12.0
>



-- 
With Best Regards,
Andy Shevchenko
