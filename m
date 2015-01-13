From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] tty: serial_mctrl_gpio: Add irqs helpers for
 input lines
Date: Tue, 13 Jan 2015 14:04:42 +0100
Message-ID: <CACQ1gAibCAwWavjhT8VW8WkjEq0qGobQ9qF=pNtHRu1WUaRigA@mail.gmail.com>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2015-01-10 15:32 GMT+01:00 Janusz Uzycki <j.uzycki@elproma.com.pl>:
> A driver using mctrl_gpio called gpiod_get_direction() to check if
> gpio is input line. However .get_direction callback is not available
> for all platforms. The patch allows to avoid the function.
> The patch introduces the following helpers:
> - mctrl_gpio_request_irqs
> - mctrl_gpio_free_irqs
> - mctrl_gpio_enable_ms
> - mctrl_gpio_disable_ms
> They allow to:
> - simplify drivers which use mctrl_gpio
> - hide irq table in mctrl_gpio
> - use default irq handler for gpios
> - better separate code for gpio modem lines from uart's code
> In addition mctrl_gpio_init() has been renamed to mctrl_gpio_init_dt()
> to focus DT usage. Also mctrl_gpio_init_dt() initializes irq table for
> gpios now and passes struct uart_port into struct mctrl_gpios.
> This resulted in changed mctrl_gpio_init_dt() parameter.
> It also requires port->dev is set before the function is called.
>
> There were also fixed:
> - irq = 0 means invalid/unused (-EINVAL no more used)
> - mctrl_gpio_request_irqs() doesn't use negative enum value
>   if request_irq() failed. It just calls mctrl_gpio_free_irqs().
>
> The mctrl_gpio_is_gpio() inline function is under discussion
> and likely it can replace exported mctrl_gpio_to_gpiod() function.
>
> IRQ_NOAUTOEN setting and request_irq() order was not commented
> but it looks right according to other drivers.
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> ---
>
> The patch requires to update the drivers which use mctrl_gpio:
> - atmel_serial
> - mxs-auart
> - clps711x
>
> Changes since RFC v1:
>  - patch renamed from:
>    ("serial: mctrl-gpio: Add irqs helpers for input lines")
>    to:
>    ("tty: serial_mctrl_gpio: Add irqs helpers for input lines")
>  - mctrl_gpio_request_irqs: changed mctrl_gpio_free_irqs() and
>    dev_err() order to make debug easier
>  - added patches for atmel_serial and clps711x serial drivers
>
> The patch applies to next (3.19.0-rc2) and was tested with mxs-auart
> using kernel 3.14 and 3.18. It wasn't tested on the next (only compiled).
>
> The patchset delivers patches for mxs-auart, atmel_serial and clps711x.
> atmel_serial and clps711x were not tested - only compile tests were done.
>
> ---
>  drivers/tty/serial/serial_mctrl_gpio.c | 109 ++++++++++++++++++++++++++++++++-
>  drivers/tty/serial/serial_mctrl_gpio.h |  59 +++++++++++++++++-
>  2 files changed, 163 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index a38596c..215b15c 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -19,11 +19,15 @@
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/termios.h>
> +#include <linux/irq.h>
>
>  #include "serial_mctrl_gpio.h"
>
>  struct mctrl_gpios {
> +       struct uart_port *port;
>         struct gpio_desc *gpio[UART_GPIO_MAX];
> +       int irq[UART_GPIO_MAX];
> +       unsigned int mctrl_prev;
>  };
>
>  static const struct {
> @@ -72,6 +76,12 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>
> +inline
> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_idx gidx)
> +{
> +       return !IS_ERR_OR_NULL(gpios->gpio[gidx]);
> +}
> +
>  unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
>  {
>         enum mctrl_gpio_idx i;
> @@ -96,8 +106,9 @@ unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mctrl)
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_get);
>
> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigned int idx)
>  {
> +       struct device *dev = port->dev;
>         struct mctrl_gpios *gpios;
>         enum mctrl_gpio_idx i;
>         int err;
> @@ -106,6 +117,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
>         if (!gpios)
>                 return ERR_PTR(-ENOMEM);
>
> +       gpios->port = port;
>         for (i = 0; i < UART_GPIO_MAX; i++) {
>                 gpios->gpio[i] = devm_gpiod_get_index(dev,
>                                                       mctrl_gpios_desc[i].name,
> @@ -128,11 +140,13 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
>                         devm_gpiod_put(dev, gpios->gpio[i]);
>                         gpios->gpio[i] = NULL;
>                 }
> +               if (gpios->gpio[i] && !mctrl_gpios_desc[i].dir_out)
> +                       gpios->irq[i] = gpiod_to_irq(gpios->gpio[i]);
>         }
>
>         return gpios;
>  }
> -EXPORT_SYMBOL_GPL(mctrl_gpio_init);
> +EXPORT_SYMBOL_GPL(mctrl_gpio_init_dt);
>
>  void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>  {
> @@ -147,3 +161,94 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>         devm_kfree(dev, gpios);
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_free);
> +
> +/*
> + * Dealing with GPIO interrupt
> + */
> +#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOCM_CTS)
> +static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
> +{
> +       struct mctrl_gpios *gpios = context;
> +       struct uart_port *port = gpios->port;
> +       u32 mctrl = gpios->mctrl_prev;
> +       u32 mctrl_diff;
> +
> +       mctrl_gpio_get(gpios, &mctrl);
> +
> +       mctrl_diff = mctrl ^ gpios->mctrl_prev;
> +       gpios->mctrl_prev = mctrl;
> +       if (mctrl_diff & MCTRL_ANY_DELTA && port->state != NULL) {
> +               if (mctrl_diff & TIOCM_RI)
> +                       port->icount.rng++;
> +               if (mctrl_diff & TIOCM_DSR)
> +                       port->icount.dsr++;
> +               if (mctrl_diff & TIOCM_CD)
> +                       uart_handle_dcd_change(port, mctrl & TIOCM_CD);
> +               if (mctrl_diff & TIOCM_CTS)
> +                       uart_handle_cts_change(port, mctrl & TIOCM_CTS);
> +
> +               wake_up_interruptible(&port->state->port.delta_msr_wait);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
> +{
> +       struct uart_port *port = gpios->port;
> +       int *irq = gpios->irq;
> +       enum mctrl_gpio_idx i;
> +       int err = 0;
> +
> +       for (i = 0; i < UART_GPIO_MAX; i++) {
> +               if (irq[i] <= 0)
> +                       continue;
> +
> +               irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
> +               err = request_irq(irq[i], mctrl_gpio_irq_handle,
> +                                 IRQ_TYPE_EDGE_BOTH,
> +                                 dev_name(port->dev), gpios);
> +               if (err) {
> +                       dev_err(port->dev, "%s: Can't get %d irq\n",
> +                               __func__, irq[i]);
> +                       mctrl_gpio_free_irqs(gpios);
> +                       break;
> +               }
> +       }
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_request_irqs);
> +
> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
> +{
> +       enum mctrl_gpio_idx i;
> +
> +       for (i = 0; i < UART_GPIO_MAX; i++)
> +               if (gpios->irq[i] > 0)
> +                       free_irq(gpios->irq[i], gpios);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_free_irqs);
> +
> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
> +{
> +       enum mctrl_gpio_idx i;
> +
> +       /* get initial status of modem lines GPIOs */
> +       mctrl_gpio_get(gpios, &gpios->mctrl_prev);
> +
> +       for (i = 0; i < UART_GPIO_MAX; i++)
> +               if (gpios->irq[i] > 0)
> +                       enable_irq(gpios->irq[i]);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
> +
> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
> +{
> +       enum mctrl_gpio_idx i;
> +
> +       for (i = 0; i < UART_GPIO_MAX; i++)
> +               if (gpios->irq[i] > 0)
> +                       disable_irq(gpios->irq[i]);
> +}
> +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
> index 400ba04..13ba3f4 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.h
> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/serial_core.h>
>
>  enum mctrl_gpio_idx {
>         UART_GPIO_CTS,
> @@ -40,6 +41,13 @@ enum mctrl_gpio_idx {
>   */
>  struct mctrl_gpios;
>
> +/*
> + * Return true if gidx is GPIO line, otherwise false.
> + * It assumes that gpios is allocated and not NULL.
> + */
> +inline
> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_idx gidx);
> +
This leads to a compile error :
  CC      drivers/tty/serial/atmel_serial.o
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/atmel_serial.c: In function 'atmel_disable_ms.part.22':
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:536:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:539:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:542:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:545:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/atmel_serial.c: In function 'atmel_enable_ms':
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:503:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:506:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:509:25: error: called from here
In file included from drivers/tty/serial/atmel_serial.c:64:0:
drivers/tty/serial/serial_mctrl_gpio.h:49:6: error: inlining failed in
call to always_inline 'mctrl_gpio_is_gpio': function body not
available
drivers/tty/serial/atmel_serial.c:512:25: error: called from here
make[3]: *** [drivers/tty/serial/atmel_serial.o] Error 1
make[2]: *** [drivers/tty/serial] Error 2
make[1]: *** [drivers/tty] Error 2
make: *** [drivers] Error 2



>  #ifdef CONFIG_GPIOLIB
>
>  /*
> @@ -60,12 +68,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx);
>
>  /*
> - * Request and set direction of modem control lines GPIOs.
> + * Request and set direction of modem control lines GPIOs. DT is used.
> + * Initialize irq table for GPIOs.
>   * devm_* functions are used, so there's no need to call mctrl_gpio_free().
>   * Returns a pointer to the allocated mctrl structure if ok, -ENOMEM on
>   * allocation error.
>   */
> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx);
> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigned int idx);
>
>  /*
>   * Free the mctrl_gpios structure.
> @@ -74,6 +83,28 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx);
>   */
>  void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
>
> +/*
> + * Request irqs for input lines GPIOs. The irqs are set disabled
> + * and triggered on both edges.
> + * Returns zero if OK, otherwise an error code.
> + */
> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios);
> +
> +/*
> + * Free irqs for input lines GPIOs.
> + */
> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios);
> +
> +/*
> + * Disable modem status interrupts assigned to GPIOs
> + */
> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
> +
> +/*
> + * Enable modem status interrupts assigned to GPIOs
> + */
> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
> +
>  #else /* GPIOLIB */
>
>  static inline
> @@ -95,7 +126,7 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>  }
>
>  static inline
> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int idx)
> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigned int idx)
>  {
>         return ERR_PTR(-ENOSYS);
>  }
> @@ -105,6 +136,28 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
>  {
>  }
>
> +static inline
> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
> +{
> +       /*return -ENOTSUP;*/
> +       return 0;
> +}
> +
> +static inline
> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
> +{
> +}
> +
> +static inline
> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
> +{
> +}
> +
> +static inline
> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
> +{
> +}
> +
>  #endif /* GPIOLIB */
>
>  #endif
> --
> 1.7.11.3
>

I think you should also update the documentation on mctrl_ helpers :
Documentation/serial/driver

I'm going to do some tests on atmel_serial.c

regards,
Richard.
