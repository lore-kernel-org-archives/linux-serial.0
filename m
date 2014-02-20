From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v3 1/7] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Thu, 20 Feb 2014 12:20:19 +0100
Message-ID: <5305E4F3.4090700@gmail.com>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com> <1392656247-3351-2-git-send-email-richard.genoud@gmail.com> <1392662231.122430857@f359.i.mail.ru> <53032F1C.2040607@gmail.com> <20140218192620.12ad4b94cb63135e8665cf45@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:59964 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbaBTLUm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Feb 2014 06:20:42 -0500
Received: by mail-wg0-f41.google.com with SMTP id l18so467052wgh.2
        for <linux-serial@vger.kernel.org>; Thu, 20 Feb 2014 03:20:41 -0800 (PST)
In-Reply-To: <20140218192620.12ad4b94cb63135e8665cf45@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?VXdlIEtsZWk=?= =?UTF-8?B?bmUtS8O2bmln?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 18/02/2014 16:26, Alexander Shiyan wrote:
> On Tue, 18 Feb 2014 10:59:56 +0100
> Richard Genoud <richard.genoud@gmail.com> wrote:
>=20
>> On 17/02/2014 19:37, Alexander Shiyan wrote:
>>> Hello.
>> Hi !
>>>
>>> A few comments below..
>>>
>>> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA,=
 17 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2014, 17:57 +01:00 =D0=BE=
=D1=82 Richard Genoud <richard.genoud@gmail.com>:
>>>> This patch add some helpers to control modem lines (CTS/RTS/DSR...=
) via
>>>> GPIO.
>>>> This will be useful for many boards which have a serial controller=
 that
>>>> only handle CTS/RTS pins (or even just RX/TX).
>>>>
>>>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>>>> ---
>>> ...
>>>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/=
serial/serial_mctrl_gpio.c
>>> ...
>>>> +static const struct {
>>>> +	const char *name;
>>>> +	unsigned int mctrl;
>>>> +	bool dir_out;
>>>> +} mctrl_gpios_desc[] =3D {
>>>> +	{ "cts", TIOCM_CTS, false, },
>>>> +	{ "dsr", TIOCM_DSR, false, },
>>>> +	{ "dcd", TIOCM_CD, false, },
>>>> +	{ "ri", TIOCM_RI, false, },
>>>> +	{ "rts", TIOCM_RTS, true, },
>>>> +	{ "dtr", TIOCM_DTR, true, },
>>>> +	{ "out1", TIOCM_OUT1, true, },
>>>> +	{ "out2", TIOCM_OUT2, true, },
>>>> +};
>>>> +
>>>> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl=
)
>>>> +{
>>>> +	enum mctrl_gpio_idx i;
>>>> +
>>>> +	for (i =3D 0; i < UART_GPIO_MAX; i++)
>>>
>>> Use ARRAY_SIZE(mctrl_gpios_desc) here and elsewhere below.
>> Could you explain why ARRAY_SIZE(mctrl_gpios_desc) seems better than
>> UART_GPIO_MAX ?
>=20
> Because you iterate through the array.
> I do not see the use of UART_GPIO_MAX in this module. You use UART_GP=
IO_MAX
> in the at91 serial driver only, here we must be sure that we are with=
in the
> boundaries of the array.
Well, the loop iterates through the gpios->gpio[] array which size is
UART_GPIO_MAX, and uses also the mctrl_gpios_desc[] which size is impli=
cit.
Anyway, if you absolutely want this change, I'll do it.

(Or I could also force the length of mctrl_gpios_desc[] like that:
static const struct {
	const char *name;
	unsigned int mctrl;
	bool dir_out;
} mctrl_gpios_desc[UART_GPIO_MAX] =3D {
	{ "cts", TIOCM_CTS, false, },
	{ "dsr", TIOCM_DSR, false, },
	{ "dcd", TIOCM_CD, false, },
	{ "ri", TIOCM_RI, false, },
	{ "rts", TIOCM_RTS, true, },
	{ "dtr", TIOCM_DTR, true, },
	{ "out1", TIOCM_OUT1, true, },
	{ "out2", TIOCM_OUT2, true, },
};
This way, all loops will be correct. )

> ...
>>>> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned i=
nt *mctrl)
>>>> +{
>>>
>>> Why you want to put mctrl as parameter here?
>>> Let's return mctrl from GPIOs, then handle this value as you want i=
nt the driver.
>> It's because I like when it's simple :).
>> Use case:
>> Your USART controller handles CTS/RTS, and you add DTR/DSR as gpios.
>> In get_mctrl() callback, with current implementation, you'll have
>> something like this: (cf atmel_get_mctrl() for a real life example)
>> {
>> unsigned int mctrl;
>> mctrl =3D usart_controller_get_mctrl(); /* driver specific */
>> return mctrl_gpio_get(gpios, &mctrl);
>> }
>> If I use as you suggest mctrl_gpio_get(struct mctrl_gpios *gpios), w=
e'll
>> have:
>> {
>> unsigned int usart_mctrl;
>> unsigned int gpio_mctrl;
>> int i;
>>
>> usart_mctrl =3D usart_controller_get_mctrl();
>> gpio_mctrl =3D mctrl_gpio_get(gpios);
>> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS]) {
>> 	if (gpio_mctrl & TIOCM_CTS)
>> 		usart_mctrl |=3D TIOCM_CTS;
>> 	else
>> 		usart_mctrl &=3D ~TIOCM_CTS;
>> }
>> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR]) {
>> 	if (gpio_mctrl & TIOCM_DSR)
>> 		usart_mctrl |=3D TIOCM_DSR;
>> 	else
>> 		usart_mctrl &=3D ~TIOCM_DSR;
>> }
>=20
> No, just like this:
> {
>   unsigned int mctrl =3D usart_controller_get_mctrl(); /* driver spec=
ific */
>   mctrl |=3D mctrl_gpio_get(gpios, mctrl) & ~(TIOCM_CTS | TIOCM_DSR);
>   return mctrl;
> }
Hum, I think you made a mistake here.
The "mctrl_gpio_get(gpios, mctrl) & ~(TIOCM_CTS | TIOCM_DSR)" doesn't m=
ake
any sense. Or I don't understand what you want to do...

>=20
> or in reverse order:
> {
>   unsigned int mctrl =3D mctrl_gpio_get(gpios, mctrl);
>   return mctrl | usart_controller_get_mctrl(); /* driver specific */
> }
Ok, I didn't explain everything on that:
In atmel_serial (at least), the function usart_controller_get_mctrl()
is in fact a read on a register (Channel Status Register)  + conversion
from the register flags to TIOCM_* flags.
That's pretty classical.

BUT when, for example CTS, is muxed as a GPIO and not as the peripheral
function, the value read for the register is undefined (I've seen it
changed randomly). (and it's not very surprising)

So, the value(s) of declared GPIO have to supersede the value(s)
retrieved from the controller.

Thus, a simple OR won't do the trick.

If you really think that mctrl_gpio_get() as it is, is over-complicated=
,
I could do something like:
static inline unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios) {
  int mctrl =3D 0;
  return mctrl_gpio_update(gpios, &mctrl);
}

unsigned int mctrl_gpio_update(struct mctrl_gpios *gpios, unsigned int =
*mctrl)
{
/* like the old mctrl_gpio_get() */
}

But is it really worth it ?

>=20
> ...
>>>> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios=
)
>>>> +{
>>>
>>> I suggest to allocate "gpios" here and return pointer to this struc=
ture
>>> or ERR_PTR(). Additionally, as I mentioned before, add "index" vari=
able
>>> to specify port number.
>>
>> I don't understand the benefit of dynamically allocating something t=
hat
>> has a fixed size...
>> Or maybe in the case no GPIO are used, the array is not allocated, a=
nd
>> I'll have to add "if (!gpios)" test in other functions. That could s=
ave
>> some bytes.
>=20
> Yes, but basically this able to use just a pointer in your driver dat=
a,
> this will not depend on GPIOLIB, since without GPIOLIB we do not know=
 storage
> size of struct gpio_desc.
Ok, convinced.

>=20
>> Could you explain a little more your idea of ""index" variable to
>> specify port number" ?
>> I'm not sure to get it.
>=20
> Index can be used for drivers which allocate more than one port for o=
ne device.
> In your implementation you should just replace devm_gpiod_get() to
> devm_gpiod_get_index() and add an additional parameter to mctrl_gpio_=
init().
> For at91 serial this parameter should be 0.
Understood.

>>
>>>> +	enum mctrl_gpio_idx i;
>>>> +	int err =3D 0;
>>>> +	int ret =3D 0;
>>>> +
>>>> +	for (i =3D 0; i < UART_GPIO_MAX; i++) {
>>>> +		gpios->gpio[i] =3D devm_gpiod_get(dev, mctrl_gpios_desc[i].name=
);
> ...
>=20


Thanks !

Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
