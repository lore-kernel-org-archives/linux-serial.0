From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/8] gpio: exar: Fix iomap request
Date: Sat, 13 May 2017 16:28:10 +0300
Message-ID: <CAHp75VfXywxyxn7-=X4P7rbeY7429y_RLs97TvtdKYPgY1n7VQ@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <e477e2ec669b105e6d0f61c069b1361e134de593.1494660546.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e477e2ec669b105e6d0f61c069b1361e134de593.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> The UART driver already maps the resource for us. Trying to do this here
> only fails and leaves us with a non-working device.

I hoped this had been tested previously...
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/gpio/gpio-exar.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index 9138ee087c5d..d6ffb3d89b9c 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -128,14 +128,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
>                 return -ENODEV;
>
>         /*
> -        * Map the pci device to get the register addresses.
> -        * We will need to read and write those registers to control
> -        * the GPIO pins.
> -        * Using managed functions will save us from unmaping on exit.
> -        * As the device is enabled using managed functions by the
> -        * UART driver we can also use managed functions here.
> +        * The UART driver must have mapped region 0 prior to registering this
> +        * device - use it.
>          */
> -       p = pcim_iomap(pcidev, 0, 0);
> +       p = pcim_iomap_table(pcidev)[0];
>         if (!p)
>                 return -ENOMEM;
>
> --
> 2.12.0
>



-- 
With Best Regards,
Andy Shevchenko
