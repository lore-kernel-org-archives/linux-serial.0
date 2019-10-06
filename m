From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH V2 1/2] serial: mctrl_gpio: Check for NULL pointer
Date: Sun, 6 Oct 2019 20:11:14 +0200
Message-ID: <CAGm1_kvC7745jhRawSinTtMr4LSbTFaE7-pnoar=tpjLD2nDcQ@mail.gmail.com>
References: <20191006163314.23191-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191006163314.23191-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vignesh R <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 6, 2019 at 6:33 PM Adam Ford <aford173@gmail.com> wrote:
>
> When using mctrl_gpio_to_gpiod, it dereferences gpios into a single
> requested GPIO.  This dereferencing can break if gpios is NULL,
> so this patch adds a NULL check before dereferencing it.  If
> gpios is NULL, this function will also return NULL.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> V2:  This patch is new to the V2 of this series, so patch 2/2 can
>      work without risking a NULL dereference
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index d9074303c88e..fb4781292d40 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -66,6 +66,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> +       if (gpios == NULL)
> +               return NULL;
> +
>         return gpios->gpio[gidx];
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
> --
> 2.17.1
>
