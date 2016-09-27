From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCHv3 1/3] serial: mctrl_gpio: implement mctrl_gpio_use_rtscts
Date: Tue, 27 Sep 2016 17:15:34 +0200
Message-ID: <CACQ1gAg769tYE2GQ6VgU8Hsvi5sCGbWDyzpqSP166Aku=4kbtg@mail.gmail.com>
References: <20160927141313.27668-1-richard.genoud@gmail.com>
 <20160927141313.27668-2-richard.genoud@gmail.com> <20160927151207.owivtd7ruvgmexu7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160927151207.owivtd7ruvgmexu7@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

2016-09-27 17:12 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello,
>
> On Tue, Sep 27, 2016 at 04:13:11PM +0200, Richard Genoud wrote:
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial=
/serial_mctrl_gpio.c
>> index d2da6aa7f27d..0e5525a64c2a 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/err.h>
>>  #include <linux/device.h>
>>  #include <linux/irq.h>
>> +#include <linux/err.h>
>
> this isn't needed any more, right?
indeed !

>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/termios.h>
>>  #include <linux/serial_core.h>
>> @@ -72,6 +73,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gp=
ios *gpios,
>>  }
>>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
>>
>> +bool mctrl_gpio_use_rtscts(struct mctrl_gpios *gpios)
>> +{
>> +     return mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS) &&
>> +             mctrl_gpio_to_gpiod(gpios, UART_GPIO_RTS);
>> +}
>> +EXPORT_SYMBOL_GPL(mctrl_gpio_use_rtscts);
>> +
>>  unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned int *mc=
trl)
>>  {
>>       enum mctrl_gpio_idx i;
>
> Best regards
> Uwe
Thanks !

Richard.
