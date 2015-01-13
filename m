From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [RFC PATCH v2 1/4] tty: serial_mctrl_gpio: Add irqs helpers for
 input lines
Date: Tue, 13 Jan 2015 10:20:37 +0100
Message-ID: <54B4E365.4020001@elproma.com.pl>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl> <20150113080356.GF22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150113080356.GF22880@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Uwe.

W dniu 2015-01-13 o 09:03, Uwe Kleine-K=C3=B6nig pisze:
> On Sat, Jan 10, 2015 at 03:32:43PM +0100, Janusz Uzycki wrote:
>> A driver using mctrl_gpio called gpiod_get_direction() to check if
>> gpio is input line. However .get_direction callback is not available
>> for all platforms. The patch allows to avoid the function.
>> The patch introduces the following helpers:
>> - mctrl_gpio_request_irqs
>> - mctrl_gpio_free_irqs
>> - mctrl_gpio_enable_ms
>> - mctrl_gpio_disable_ms
>> They allow to:
>> - simplify drivers which use mctrl_gpio
>> - hide irq table in mctrl_gpio
>> - use default irq handler for gpios
>> - better separate code for gpio modem lines from uart's code
>> In addition mctrl_gpio_init() has been renamed to mctrl_gpio_init_dt=
()
> Note that this breaks the drivers that are already using
> mctrl_gpio_init. This is fixed up in the follow up patches, but still
> you break bisection.

Could you give me more details about "break bisection" problem and how=20
to correct it?
I've decided to change the name in the same patch as parameter has been=
=20
also changed.


>> to focus DT usage. Also mctrl_gpio_init_dt() initializes irq table f=
or
>> gpios now and passes struct uart_port into struct mctrl_gpios.
>> This resulted in changed mctrl_gpio_init_dt() parameter.
>> It also requires port->dev is set before the function is called.
>>
>> There were also fixed:
>> - irq =3D 0 means invalid/unused (-EINVAL no more used)
>> - mctrl_gpio_request_irqs() doesn't use negative enum value
>>    if request_irq() failed. It just calls mctrl_gpio_free_irqs().
>>
>> The mctrl_gpio_is_gpio() inline function is under discussion
>> and likely it can replace exported mctrl_gpio_to_gpiod() function.

What do you think about? mctrl_gpio_to_gpiod() could be removed.

>>
>> IRQ_NOAUTOEN setting and request_irq() order was not commented
>> but it looks right according to other drivers.
> I suggest to add a comment for that. Something like:
>
> 	/*
> 	 * XXX: This is not undone in the error path. To be fixed
> 	 * properly this needs to be set atomically together with
> 	 * request_irq.
> 	 */

OK. What does XXX mean?
Since v1 I've seen more drivers set the flag but I didn't find any=20
comment about.

>  =20
>> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> There is no binding documentation for mctrl. This should be fixed, to=
o.

The bindings are added to atmel_serial and mxs-auart drivers because=20
they use mctrl.
Is it possible to improve bindings and how?

>
>> ---
>>
>> The patch requires to update the drivers which use mctrl_gpio:
>> - atmel_serial
>> - mxs-auart
>> - clps711x
>>
>> Changes since RFC v1:
>>   - patch renamed from:
>>     ("serial: mctrl-gpio: Add irqs helpers for input lines")
>>     to:
>>     ("tty: serial_mctrl_gpio: Add irqs helpers for input lines")
>>   - mctrl_gpio_request_irqs: changed mctrl_gpio_free_irqs() and
>>     dev_err() order to make debug easier
>>   - added patches for atmel_serial and clps711x serial drivers
>>
>> The patch applies to next (3.19.0-rc2) and was tested with mxs-auart
>> using kernel 3.14 and 3.18. It wasn't tested on the next (only compi=
led).
>>
>> The patchset delivers patches for mxs-auart, atmel_serial and clps71=
1x.
>> atmel_serial and clps711x were not tested - only compile tests were =
done.
>>
>> ---
>>   drivers/tty/serial/serial_mctrl_gpio.c | 109 +++++++++++++++++++++=
+++++++++++-
>>   drivers/tty/serial/serial_mctrl_gpio.h |  59 +++++++++++++++++-
>>   2 files changed, 163 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/se=
rial/serial_mctrl_gpio.c
>> index a38596c..215b15c 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -19,11 +19,15 @@
>>   #include <linux/device.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/termios.h>
>> +#include <linux/irq.h>
>>  =20
>>   #include "serial_mctrl_gpio.h"
>>  =20
>>   struct mctrl_gpios {
>> +	struct uart_port *port;
>>   	struct gpio_desc *gpio[UART_GPIO_MAX];
>> +	int irq[UART_GPIO_MAX];
>> +	unsigned int mctrl_prev;
>>   };
>>  =20
>>   static const struct {
>> @@ -72,6 +76,12 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctr=
l_gpios *gpios,
>>   }
>>   EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>>  =20
>> +inline
>> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_=
idx gidx)
>> +{
>> +	return !IS_ERR_OR_NULL(gpios->gpio[gidx]);
>> +}
>> +
>>   unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned in=
t *mctrl)
>>   {
>>   	enum mctrl_gpio_idx i;
>> @@ -96,8 +106,9 @@ unsigned int mctrl_gpio_get(struct mctrl_gpios *g=
pios, unsigned int *mctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(mctrl_gpio_get);
>>  =20
>> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned in=
t idx)
>> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsi=
gned int idx)
>>   {
>> +	struct device *dev =3D port->dev;
>>   	struct mctrl_gpios *gpios;
>>   	enum mctrl_gpio_idx i;
>>   	int err;
>> @@ -106,6 +117,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct devic=
e *dev, unsigned int idx)
>>   	if (!gpios)
>>   		return ERR_PTR(-ENOMEM);
>>  =20
>> +	gpios->port =3D port;
>>   	for (i =3D 0; i < UART_GPIO_MAX; i++) {
>>   		gpios->gpio[i] =3D devm_gpiod_get_index(dev,
>>   						      mctrl_gpios_desc[i].name,
>> @@ -128,11 +140,13 @@ struct mctrl_gpios *mctrl_gpio_init(struct dev=
ice *dev, unsigned int idx)
>>   			devm_gpiod_put(dev, gpios->gpio[i]);
>>   			gpios->gpio[i] =3D NULL;
>>   		}
>> +		if (gpios->gpio[i] && !mctrl_gpios_desc[i].dir_out)
>> +			gpios->irq[i] =3D gpiod_to_irq(gpios->gpio[i]);
>>   	}
>>  =20
>>   	return gpios;
>>   }
>> -EXPORT_SYMBOL_GPL(mctrl_gpio_init);
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_init_dt);
>>  =20
>>   void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios=
)
>>   {
>> @@ -147,3 +161,94 @@ void mctrl_gpio_free(struct device *dev, struct=
 mctrl_gpios *gpios)
>>   	devm_kfree(dev, gpios);
>>   }
>>   EXPORT_SYMBOL_GPL(mctrl_gpio_free);
>> +
>> +/*
>> + * Dealing with GPIO interrupt
>> + */
>> +#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | T=
IOCM_CTS)
>> +static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
>> +{
>> +	struct mctrl_gpios *gpios =3D context;
>> +	struct uart_port *port =3D gpios->port;
>> +	u32 mctrl =3D gpios->mctrl_prev;
>> +	u32 mctrl_diff;
>> +
>> +	mctrl_gpio_get(gpios, &mctrl);
>> +
>> +	mctrl_diff =3D mctrl ^ gpios->mctrl_prev;
>> +	gpios->mctrl_prev =3D mctrl;
>> +	if (mctrl_diff & MCTRL_ANY_DELTA && port->state !=3D NULL) {
>> +		if (mctrl_diff & TIOCM_RI)
>> +			port->icount.rng++;
>> +		if (mctrl_diff & TIOCM_DSR)
>> +			port->icount.dsr++;
>> +		if (mctrl_diff & TIOCM_CD)
>> +			uart_handle_dcd_change(port, mctrl & TIOCM_CD);
>> +		if (mctrl_diff & TIOCM_CTS)
>> +			uart_handle_cts_change(port, mctrl & TIOCM_CTS);
>> +
>> +		wake_up_interruptible(&port->state->port.delta_msr_wait);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
>> +{
>> +	struct uart_port *port =3D gpios->port;
>> +	int *irq =3D gpios->irq;
>> +	enum mctrl_gpio_idx i;
>> +	int err =3D 0;
>> +
>> +	for (i =3D 0; i < UART_GPIO_MAX; i++) {
>> +		if (irq[i] <=3D 0)
>> +			continue;
>> +
>> +		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
>> +		err =3D request_irq(irq[i], mctrl_gpio_irq_handle,
>> +				  IRQ_TYPE_EDGE_BOTH,
>> +				  dev_name(port->dev), gpios);
>> +		if (err) {
>> +			dev_err(port->dev, "%s: Can't get %d irq\n",
>> +				__func__, irq[i]);
>> +			mctrl_gpio_free_irqs(gpios);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_request_irqs);
>> +
>> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
>> +{
>> +	enum mctrl_gpio_idx i;
>> +
>> +	for (i =3D 0; i < UART_GPIO_MAX; i++)
>> +		if (gpios->irq[i] > 0)
>> +			free_irq(gpios->irq[i], gpios);
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_free_irqs);
>> +
>> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
>> +{
>> +	enum mctrl_gpio_idx i;
>> +
>> +	/* get initial status of modem lines GPIOs */
>> +	mctrl_gpio_get(gpios, &gpios->mctrl_prev);
>> +
>> +	for (i =3D 0; i < UART_GPIO_MAX; i++)
>> +		if (gpios->irq[i] > 0)
>> +			enable_irq(gpios->irq[i]);
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
>> +
>> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
>> +{
>> +	enum mctrl_gpio_idx i;
>> +
>> +	for (i =3D 0; i < UART_GPIO_MAX; i++)
>> +		if (gpios->irq[i] > 0)
>> +			disable_irq(gpios->irq[i]);
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);

It looks the functions should check if gpios is not NULL or drivers=20
should fail probe on it.
Which is the right way?

>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/se=
rial/serial_mctrl_gpio.h
>> index 400ba04..13ba3f4 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.h
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.h
>> @@ -21,6 +21,7 @@
>>   #include <linux/err.h>
>>   #include <linux/device.h>
>>   #include <linux/gpio/consumer.h>
>> +#include <linux/serial_core.h>
>>  =20
>>   enum mctrl_gpio_idx {
>>   	UART_GPIO_CTS,
>> @@ -40,6 +41,13 @@ enum mctrl_gpio_idx {
>>    */
>>   struct mctrl_gpios;
>>  =20
>> +/*
>> + * Return true if gidx is GPIO line, otherwise false.
>> + * It assumes that gpios is allocated and not NULL.
>> + */
>> +inline
>> +bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_=
idx gidx);
>> +
>>   #ifdef CONFIG_GPIOLIB
>>  =20
>>   /*
>> @@ -60,12 +68,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mct=
rl_gpios *gpios,
>>   				      enum mctrl_gpio_idx gidx);
>>  =20
>>   /*
>> - * Request and set direction of modem control lines GPIOs.
>> + * Request and set direction of modem control lines GPIOs. DT is us=
ed.
>> + * Initialize irq table for GPIOs.
>>    * devm_* functions are used, so there's no need to call mctrl_gpi=
o_free().
>>    * Returns a pointer to the allocated mctrl structure if ok, -ENOM=
EM on
>>    * allocation error.
>>    */
>> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned in=
t idx);
>> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsi=
gned int idx);
>>  =20
>>   /*
>>    * Free the mctrl_gpios structure.
>> @@ -74,6 +83,28 @@ struct mctrl_gpios *mctrl_gpio_init(struct device=
 *dev, unsigned int idx);
>>    */
>>   void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios=
);
>>  =20
>> +/*
>> + * Request irqs for input lines GPIOs. The irqs are set disabled
>> + * and triggered on both edges.
>> + * Returns zero if OK, otherwise an error code.
>> + */
>> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios);
>> +
>> +/*
>> + * Free irqs for input lines GPIOs.
>> + */
>> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios);
>> +
>> +/*
>> + * Disable modem status interrupts assigned to GPIOs
>> + */
>> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
>> +
>> +/*
>> + * Enable modem status interrupts assigned to GPIOs
>> + */
>> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
>> +
>>   #else /* GPIOLIB */
>>  =20
>>   static inline
>> @@ -95,7 +126,7 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctr=
l_gpios *gpios,
>>   }
>>  =20
>>   static inline
>> -struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned in=
t idx)
>> +struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsi=
gned int idx)
>>   {
>>   	return ERR_PTR(-ENOSYS);
>>   }
>> @@ -105,6 +136,28 @@ void mctrl_gpio_free(struct device *dev, struct=
 mctrl_gpios *gpios)
>>   {
>>   }
>>  =20
>> +static inline
>> +int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
>> +{
>> +	/*return -ENOTSUP;*/
>> +	return 0;
>> +}
>> +
>> +static inline
>> +void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
>> +{
>> +}
>> +
>> +static inline
>> +void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
>> +{
>> +}
>> +
>> +static inline
>> +void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
>> +{
>> +}
>> +
>>   #endif /* GPIOLIB */
>>  =20
>>   #endif
>> --=20
>> 1.7.11.3
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
