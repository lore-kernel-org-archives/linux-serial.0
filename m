From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 12/15] tty: serial: 8250: Correct conversion
 specifiers
Date: Thu, 14 Jan 2016 11:31:24 +0200
Message-ID: <1452763884.2521.23.camel@linux.intel.com>
References: <1452720561-28443-1-git-send-email-anton.wuerfel@fau.de>
	 <1452720561-28443-13-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1452720561-28443-13-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hung <hpeter@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel <linux-kernel@i4.cs.fau.de>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-01-13 at 22:29 +0100, Anton Wuerfel wrote:
> This patch fixes compiler warnings about wrong conversion specifiers=C2=
=A0

This patch obviously doesn't _fix_warnings_, rather changes specifiers
to get it consistent with argument.

> used
> in a debug output in 8250_pnp.c. The precise warning is:

Usually there is no need to cite all lines=E2=80=A6

>=20
> drivers/tty/serial/8250/8250_pnp.c: In function =E2=80=98serial_pnp_p=
robe=E2=80=99:
> include/linux/dynamic_debug.h:64:16: warning: format =E2=80=98%x=E2=80=
=99 expects
> argument
> of [...]

OK.

>=20
> include/linux/dynamic_debug.h:84:2: note: in expansion of macro
> =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=80=99
>=20
> include/linux/device.h:1179:2: note: in expansion of macro
> =E2=80=98dynamic_dev_dbg=E2=80=99

Redundant.

>=20
> drivers/tty/serial/8250/8250_pnp.c:467:2: note: in expansion of macro
> =E2=80=98dev_dbg=E2=80=99
> =C2=A0 dev_dbg(&dev->dev,
> =C2=A0 ^
> include/linux/dynamic_debug.h:64:16: warning: format =E2=80=98%lx=E2=80=
=99 expects
> argument
> of [...]

OK.

>=20
> include/linux/dynamic_debug.h:84:2: note: in expansion of macro
> =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=80=99
>=20
> include/linux/device.h:1179:2: note: in expansion of macro
> =E2=80=98dynamic_dev_dbg=E2=80=99

Redundant.

>=20
> drivers/tty/serial/8250/8250_pnp.c:467:2: note: in expansion of macro
> =E2=80=98dev_dbg=E2=80=99
> =C2=A0 dev_dbg(&dev->dev,
> =C2=A0 ^
>=20
> Those warnings never got triggered, because the command was nested
> in an #ifdef, which is removed by a patch of this series.
>=20
> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> Cc: linux-kernel@i4.cs.fau.de
> ---
> =C2=A0drivers/tty/serial/8250/8250_pnp.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pnp.c
> b/drivers/tty/serial/8250/8250_pnp.c
> index 0c32c59..92f4412 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -465,8 +465,8 @@ serial_pnp_probe(struct pnp_dev *dev, const
> struct pnp_device_id *dev_id)
> =C2=A0		return -ENODEV;
> =C2=A0
> =C2=A0	dev_dbg(&dev->dev,
> -		=C2=A0"Setup PNP port: port %x, mem 0x%lx, irq %d, type
> %d\n",
> -		=C2=A0uart.port.iobase, uart.port.mapbase,
> +		=C2=A0"Setup PNP port: port %lx, mem 0x%lx, irq %d, type
> %d\n",
> +		=C2=A0uart.port.iobase, (unsigned long)uart.port.mapbase,

This approach is not fully correct. In Linux kernel we have %p
extensions to cover some custom types such as resource_size_t, of which
mapbase is.

Thus,

"Setup PNP port: port %lx, mem %pa, irq %d, type %d\n",
uart.port.iobase, &uart.port.mapbase,

looks better.

> =C2=A0		=C2=A0uart.port.irq, uart.port.iotype);
> =C2=A0
> =C2=A0	if (flags & CIR_PORT) {

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
