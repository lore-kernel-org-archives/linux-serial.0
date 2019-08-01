From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: mctrl_gpio: Avoid probe failures in case of
 missing gpiolib
Date: Thu, 1 Aug 2019 10:19:45 -0300
Message-ID: <CAOMZO5BPRNDQG_6PunUTxK7P=NF1DqjxvM+xEVMzX+rGd=h9hA@mail.gmail.com>
References: <20190801124446.15703-1-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801124446.15703-1-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Cc: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Hi Schrempf,

On Thu, Aug 1, 2019 at 9:47 AM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
> mctrl_gpio_init_noauto() will currently return an error pointer with
> -ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
> check for this condition to allow continue probing.
>
> To avoid the need for this check in each driver, we return NULL
> instead, as all the mctrl_gpio_*() functions are skipped anyway.
> We also adapt mctrl_gpio_to_gpiod() to be in line with this change.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Looks good to me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Also adding Geert on Cc as the patch touches sh-sci.

Thanks


> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>  drivers/tty/serial/serial_mctrl_gpio.h | 6 +++---
>  drivers/tty/serial/sh-sci.c            | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index 2b400189be91..54c43e02e375 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -61,6 +61,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> +       if (gpios == NULL)
> +               return NULL;
> +
>         return gpios->gpio[gidx];
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
> index b7d3cca48ede..1b2ff503b2c2 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.h
> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
> @@ -114,19 +114,19 @@ static inline
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
>  struct mctrl_gpios *mctrl_gpio_init(struct uart_port *port, unsigned int idx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
>  struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
>  {
> -       return ERR_PTR(-ENOSYS);
> +       return NULL;
>  }
>
>  static inline
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d18c680aa64b..249325b65ee0 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3287,7 +3287,7 @@ static int sci_probe_single(struct platform_device *dev,
>                 return ret;
>
>         sciport->gpios = mctrl_gpio_init(&sciport->port, 0);
> -       if (IS_ERR(sciport->gpios) && PTR_ERR(sciport->gpios) != -ENOSYS)
> +       if (IS_ERR(sciport->gpios))
>                 return PTR_ERR(sciport->gpios);
>
>         if (sciport->has_rtscts) {
> --
> 2.17.1
