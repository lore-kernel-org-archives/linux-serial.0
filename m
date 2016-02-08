From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: meson: Implement earlycon support
Date: Sun, 7 Feb 2016 20:22:20 -0800
Message-ID: <56B817FC.4000604@hurleysoftware.com>
References: <1454878635-24396-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1454878635-24396-1-git-send-email-afaerber@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
Cc: Carlo Caione <carlo@caione.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Andreas,

On 02/07/2016 12:57 PM, Andreas F=C3=A4rber wrote:
> Reuse the existing console write implementation for implementing
> DT-based and command-line-based earlycon support.
>=20
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  Documentation/kernel-parameters.txt |  6 ++++++
>  drivers/tty/serial/meson_uart.c     | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 602065c..90801ac 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1030,6 +1030,12 @@ Such letter suffixes can also be entirely omit=
ted.
>  			the driver will use only 32-bit accessors to read/write
>  			the device registers.
> =20
> +		meson_serial,<addr>
> +			Start an early, polled-mode console on a meson serial
> +			port at the specified address. The serial port must
> +			already be setup and configured. Options are not yet
> +			supported.
> +
>  		msm_serial,<addr>
>  			Start an early, polled-mode console on an msm serial
>  			port at the specified address. The serial port
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/mes=
on_uart.c
> index b12a37b..6f89567 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -548,6 +548,19 @@ static int __init meson_serial_console_init(void=
)
>  }
>  console_initcall(meson_serial_console_init);
> =20
> +static int __init
> +meson_serial_early_console_setup(struct earlycon_device *device, con=
st char *opt)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	device->con->write =3D meson_serial_console_write;

meson_serial_console_write() is not appropriate for earlycon; it assume=
s the
earlycon port is the same as the driver port (it isn't).


> +	return 0;
> +}
> +EARLYCON_DECLARE(meson_serial, meson_serial_early_console_setup);
> +OF_EARLYCON_DECLARE(meson_serial, "amlogic,meson-uart",
> +		    meson_serial_early_console_setup);

With today's linux-next (or Greg's tty-next tree), it is no longer nece=
ssary to
declare separate earlycon's when you want both; OF_EARLYCON_DECLARE() d=
eclares
both a devicetree-enabled earlycon and automatically provides for a com=
mand line
earlycon of the same name.

Regards,
Peter Hurley

> +
>  #define MESON_SERIAL_CONSOLE	(&meson_serial_console)
>  #else
>  #define MESON_SERIAL_CONSOLE	NULL
>=20

