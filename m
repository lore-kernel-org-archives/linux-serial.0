From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH -next] serial: etraxfs-uart: Fix crash
Date: Mon, 2 Nov 2015 22:29:33 +0100
Message-ID: <20151102212933.GB4931@pengutronix.de>
References: <1446431576-4385-1-git-send-email-linux@roeck-us.net>
 <20151102073755.GN4931@pengutronix.de>
 <5637D1F5.2090608@flawful.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5637D1F5.2090608@flawful.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <nks@flawful.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Helo Niklas,

On Mon, Nov 02, 2015 at 10:13:25PM +0100, Niklas Cassel wrote:
> On 11/02/2015 08:37 AM, Uwe Kleine-K=F6nig wrote:
> >> The function call in the etraxfs-uart driver was not renamed,
> >> possibly due to interference with commit 7b9c5162c182 ("serial:
> >> etraxfs-uart: use mctrl_gpio helpers for handling modem signals").
> > Yes. BTW, 7b9c5162c182 looks broken, too, because the interrupt han=
dling
> > is missing.
>=20
> The only drivers including serial_mctrl_gpio.h is atmel_serial.c,
> clps711x.c, mxs-auart.c and etraxfs-uart.c
>=20
> etraxfs commit
> 7b9c5162c182 ("serial: etraxfs-uart: use mctrl_gpio helpers for handl=
ing modem signals")
> is heavily influenced by
> 62b0a1b3e759 ("serial: clps711x: Use mctrl_gpio helpers for handling =
modem signals")
>=20
> a driver which also appears to lack mctrl irq setup/handling.
>=20
>=20
> Uwe, are you going to convert all serial drivers that includes serial=
_mctrl_gpio.h to
> use the new mctrl_gpio_init? (which also sets up irqs)
That is the plan. For drivers like mxs-auart (that do irq handling) thi=
s
is just simplification. When the irq handling is missing converting to
the new mctrl_gpio_init might introduce regressions because it does
request_irq which might fail.

> Since mctrl gpios are optional in the device tree, I guess mctrl_gpio=
_init handles if
> they are missing. So even if etraxfs-uart.c currently lacks mctrl irq=
 setup/handling,
> if we migrate it to use the new mctrl_gpio_init, we will get this aut=
omatically?
Right, if there are no gpios specified (new and old) mctrl_gpio is a
nop.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
