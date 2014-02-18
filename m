From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v3 1/7] tty/serial: Add GPIOLIB helpers for controlling
 modem lines
Date: Tue, 18 Feb 2014 19:26:20 +0400
Message-ID: <20140218192620.12ad4b94cb63135e8665cf45@mail.ru>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
	<1392656247-3351-2-git-send-email-richard.genoud@gmail.com>
	<1392662231.122430857@f359.i.mail.ru>
	<53032F1C.2040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:35863 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbaBRP0w (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 10:26:52 -0500
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.176.129])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 16D5CF9031A4
	for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2014 19:26:51 +0400 (MSK)
In-Reply-To: <53032F1C.2040607@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uwe =?KOI8-R?Q?Kleine?= =?UTF-8?Q?-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 18 Feb 2014 10:59:56 +0100
Richard Genoud <richard.genoud@gmail.com> wrote:

> On 17/02/2014 19:37, Alexander Shiyan wrote:
> > Hello.
> Hi !
> >=20
> > A few comments below..
> >=20
> > =F0=CF=CE=C5=C4=C5=CC=D8=CE=C9=CB, 17 =C6=C5=D7=D2=C1=CC=D1 2014, 1=
7:57 +01:00 =CF=D4 Richard Genoud <richard.genoud@gmail.com>:
> >> This patch add some helpers to control modem lines (CTS/RTS/DSR...=
) via
> >> GPIO.
> >> This will be useful for many boards which have a serial controller=
 that
> >> only handle CTS/RTS pins (or even just RX/TX).
> >>
> >> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> >> ---
> > ...
> >> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/=
serial/serial_mctrl_gpio.c
> > ...
> >> +static const struct {
> >> +	const char *name;
> >> +	unsigned int mctrl;
> >> +	bool dir_out;
> >> +} mctrl_gpios_desc[] =3D {
> >> +	{ "cts", TIOCM_CTS, false, },
> >> +	{ "dsr", TIOCM_DSR, false, },
> >> +	{ "dcd", TIOCM_CD, false, },
> >> +	{ "ri", TIOCM_RI, false, },
> >> +	{ "rts", TIOCM_RTS, true, },
> >> +	{ "dtr", TIOCM_DTR, true, },
> >> +	{ "out1", TIOCM_OUT1, true, },
> >> +	{ "out2", TIOCM_OUT2, true, },
> >> +};
> >> +
> >> +void mctrl_gpio_set(struct mctrl_gpios *gpios, unsigned int mctrl=
)
> >> +{
> >> +	enum mctrl_gpio_idx i;
> >> +
> >> +	for (i =3D 0; i < UART_GPIO_MAX; i++)
> >=20
> > Use ARRAY_SIZE(mctrl_gpios_desc) here and elsewhere below.
> Could you explain why ARRAY_SIZE(mctrl_gpios_desc) seems better than
> UART_GPIO_MAX ?

Because you iterate through the array.
I do not see the use of UART_GPIO_MAX in this module. You use UART_GPIO=
_MAX
in the at91 serial driver only, here we must be sure that we are within=
 the
boundaries of the array.

=2E..
> >> +unsigned int mctrl_gpio_get(struct mctrl_gpios *gpios, unsigned i=
nt *mctrl)
> >> +{
> >=20
> > Why you want to put mctrl as parameter here?
> > Let's return mctrl from GPIOs, then handle this value as you want i=
nt the driver.
> It's because I like when it's simple :).
> Use case:
> Your USART controller handles CTS/RTS, and you add DTR/DSR as gpios.
> In get_mctrl() callback, with current implementation, you'll have
> something like this: (cf atmel_get_mctrl() for a real life example)
> {
> unsigned int mctrl;
> mctrl =3D usart_controller_get_mctrl(); /* driver specific */
> return mctrl_gpio_get(gpios, &mctrl);
> }
> If I use as you suggest mctrl_gpio_get(struct mctrl_gpios *gpios), we=
'll
> have:
> {
> unsigned int usart_mctrl;
> unsigned int gpio_mctrl;
> int i;
>=20
> usart_mctrl =3D usart_controller_get_mctrl();
> gpio_mctrl =3D mctrl_gpio_get(gpios);
> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_CTS]) {
> 	if (gpio_mctrl & TIOCM_CTS)
> 		usart_mctrl |=3D TIOCM_CTS;
> 	else
> 		usart_mctrl &=3D ~TIOCM_CTS;
> }
> if (!IS_ERR_OR_NULL(gpios->gpio[UART_GPIO_DSR]) {
> 	if (gpio_mctrl & TIOCM_DSR)
> 		usart_mctrl |=3D TIOCM_DSR;
> 	else
> 		usart_mctrl &=3D ~TIOCM_DSR;
> }

No, just like this:
{
  unsigned int mctrl =3D usart_controller_get_mctrl(); /* driver specif=
ic */
  mctrl |=3D mctrl_gpio_get(gpios, mctrl) & ~(TIOCM_CTS | TIOCM_DSR);
  return mctrl;
}

or in reverse order:
{
  unsigned int mctrl =3D mctrl_gpio_get(gpios, mctrl);
  return mctrl | usart_controller_get_mctrl(); /* driver specific */
}

=2E..
> >> +int mctrl_gpio_init(struct device *dev, struct mctrl_gpios *gpios=
)
> >> +{
> >=20
> > I suggest to allocate "gpios" here and return pointer to this struc=
ture
> > or ERR_PTR(). Additionally, as I mentioned before, add "index" vari=
able
> > to specify port number.
>=20
> I don't understand the benefit of dynamically allocating something th=
at
> has a fixed size...
> Or maybe in the case no GPIO are used, the array is not allocated, an=
d
> I'll have to add "if (!gpios)" test in other functions. That could sa=
ve
> some bytes.

Yes, but basically this able to use just a pointer in your driver data,
this will not depend on GPIOLIB, since without GPIOLIB we do not know s=
torage
size of struct gpio_desc.

> Could you explain a little more your idea of ""index" variable to
> specify port number" ?
> I'm not sure to get it.

Index can be used for drivers which allocate more than one port for one=
 device.
In your implementation you should just replace devm_gpiod_get() to
devm_gpiod_get_index() and add an additional parameter to mctrl_gpio_in=
it().
=46or at91 serial this parameter should be 0.

>=20
> >> +	enum mctrl_gpio_idx i;
> >> +	int err =3D 0;
> >> +	int ret =3D 0;
> >> +
> >> +	for (i =3D 0; i < UART_GPIO_MAX; i++) {
> >> +		gpios->gpio[i] =3D devm_gpiod_get(dev, mctrl_gpios_desc[i].name=
);
=2E..

--=20
Alexander Shiyan <shc_work@mail.ru>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
