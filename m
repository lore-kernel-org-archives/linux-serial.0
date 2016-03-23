From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4] tty: serial: meson: Implement earlycon support
Date: Wed, 23 Mar 2016 11:39:36 +0100
Message-ID: <56F27268.4060902@suse.de>
References: <1457263284-8819-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457263284-8819-1-git-send-email-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial <linux-serial@vger.kernel.org>
Cc: linux-meson@googlegroups.com, Nicolas Saenz Julienne <nicolassaenzj@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-doc <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Am 06.03.2016 um 12:21 schrieb Andreas F=C3=A4rber:
> Split off the bulk of the existing meson_serial_console_write()
> implementation into meson_serial_port_write() for implementing
> meson_serial_early_console_write().
>=20
> Use "meson" as the earlycon driver name, courtesy of Nicolas.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nicolassaenzj@gmail.com>
> Acked-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Select SERIAL_EARLYCON (Arnd)

Ping?

Andreas

> =20
>  v2 -> v3:
>  * Rename from "meson_serial" to just "meson" (Nicolas)
> =20
>  v1 -> v2:
>  * Implement meson_serial_early_console_write() instead of reusing
>    meson_serial_console_write() (Peter)
> =20
>  Documentation/kernel-parameters.txt |  6 ++++++
>  drivers/tty/serial/Kconfig          |  1 +
>  drivers/tty/serial/meson_uart.c     | 42 +++++++++++++++++++++++++++=
+++-------
>  3 files changed, 42 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index e0a21e4556a6..a7c1377fd80f 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1039,6 +1039,12 @@ bytes respectively. Such letter suffixes can a=
lso be entirely omitted.
>  			the driver will use only 32-bit accessors to read/write
>  			the device registers.
> =20
> +		meson,<addr>
> +			Start an early, polled-mode console on a meson serial
> +			port at the specified address. The serial port must
> +			already be setup and configured. Options are not yet
> +			supported.
> +
>  		msm_serial,<addr>
>  			Start an early, polled-mode console on an msm serial
>  			port at the specified address. The serial port
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index bdbe1c533c6a..ad7538e8a4e8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -213,6 +213,7 @@ config SERIAL_MESON_CONSOLE
>  	bool "Support for console on meson"
>  	depends on SERIAL_MESON=3Dy
>  	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
>  	help
>  	  Say Y here if you wish to use a Amlogic MesonX UART as the
>  	  system console (the system console is the device which
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/mes=
on_uart.c
> index 024445aa0521..6aea0f4a9165 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -481,18 +481,13 @@ static void meson_console_putchar(struct uart_p=
ort *port, int ch)
>  	writel(ch, port->membase + AML_UART_WFIFO);
>  }
> =20
> -static void meson_serial_console_write(struct console *co, const cha=
r *s,
> -				       u_int count)
> +static void meson_serial_port_write(struct uart_port *port, const ch=
ar *s,
> +				    u_int count)
>  {
> -	struct uart_port *port;
>  	unsigned long flags;
>  	int locked;
>  	u32 val, tmp;
> =20
> -	port =3D meson_ports[co->index];
> -	if (!port)
> -		return;
> -
>  	local_irq_save(flags);
>  	if (port->sysrq) {
>  		locked =3D 0;
> @@ -516,6 +511,18 @@ static void meson_serial_console_write(struct co=
nsole *co, const char *s,
>  	local_irq_restore(flags);
>  }
> =20
> +static void meson_serial_console_write(struct console *co, const cha=
r *s,
> +				       u_int count)
> +{
> +	struct uart_port *port;
> +
> +	port =3D meson_ports[co->index];
> +	if (!port)
> +		return;
> +
> +	meson_serial_port_write(port, s, count);
> +}
> +
>  static int meson_serial_console_setup(struct console *co, char *opti=
ons)
>  {
>  	struct uart_port *port;
> @@ -554,6 +561,27 @@ static int __init meson_serial_console_init(void=
)
>  }
>  console_initcall(meson_serial_console_init);
> =20
> +static void meson_serial_early_console_write(struct console *co,
> +					     const char *s,
> +					     u_int count)
> +{
> +	struct earlycon_device *dev =3D co->data;
> +
> +	meson_serial_port_write(&dev->port, s, count);
> +}
> +
> +static int __init
> +meson_serial_early_console_setup(struct earlycon_device *device, con=
st char *opt)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write =3D meson_serial_early_console_write;
> +	return 0;
> +}
> +OF_EARLYCON_DECLARE(meson, "amlogic,meson-uart",
> +		    meson_serial_early_console_setup);
> +
>  #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>  #else
>  #define MESON_SERIAL_CONSOLE	NULL
>=20


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton; HRB 21284 (AG=
 N=C3=BCrnberg)
