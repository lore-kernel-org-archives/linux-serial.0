From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 04/11] tty: serial: 8250: Fix multiline comment style
Date: Wed, 16 Dec 2015 08:52:28 -0800
Message-ID: <567196CC.2090305@hurleysoftware.com>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
 <1450280177-4460-5-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-5-git-send-email-anton.wuerfel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffe>
List-Id: linux-serial@vger.kernel.org

On 12/16/2015 07:36 AM, Anton Wuerfel wrote:
> Checkpatch outputs some warnings about incorrect comment style,
> which is fixed by this patch.
>=20

Please fix the comments in a consistent fashion. For example ...

> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> CC: linux-kernel@i4.cs.fau.de
> ---
>  drivers/tty/serial/8250/8250_ingenic.c |  6 ++-
>  drivers/tty/serial/8250/8250_pnp.c     |  6 ++-
>  drivers/tty/serial/8250/8250_port.c    | 29 ++++++-----
>  drivers/tty/serial/8250/serial_cs.c    | 92 +++++++++++++++++++-----=
----------
>  4 files changed, 75 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/ser=
ial/8250/8250_ingenic.c
> index 49394b4..c53d2501 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -153,13 +153,15 @@ static void ingenic_uart_serial_out(struct uart=
_port *p, int offset, int value)
> =20
>  	case UART_IER:
>  		/* Enable receive timeout interrupt with the
> -		 * receive line status interrupt */
> +		 * receive line status interrupt
> +		 */

This isn't the same style as ...

>  		value |=3D (value & 0x4) << 2;
>  		break;
> =20
>  	case UART_MCR:
>  		/* If we have enabled modem status IRQs we should enable modem
> -		 * mode. */
> +		 * mode.
> +		 */
>  		ier =3D p->serial_in(p, UART_IER);
> =20
>  		if (ier & UART_IER_MSI)
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/=
8250/8250_pnp.c
> index 1f18065..2731031 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -367,8 +367,10 @@ static const struct pnp_device_id pnp_dev_table[=
] =3D {
>  	{	"PNPCXXX",		UNKNOWN_DEV	},
>  	/* More unknown PnP modems */
>  	{	"PNPDXXX",		UNKNOWN_DEV	},
> -	/* Winbond CIR port, should not be probed. We should keep track
> -	   of it to prevent the legacy serial driver from probing it */
> +	/*
> +	 * Winbond CIR port, should not be probed. We should keep track
> +	 * of it to prevent the legacy serial driver from probing it
> +	 */

this style.

>  	{	"WEC1022",		CIR_PORT	},
>  	/*
>  	 * SMSC IrCC SIR/FIR port, should not be probed by serial driver
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial=
/8250/8250_port.c
> index 57ad0f2..0ec823e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -250,9 +250,11 @@ static const struct serial8250_config uart_confi=
g[] =3D {
>  		.fcr		=3D UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
>  		.flags		=3D UART_CAP_FIFO | UART_CAP_AFE,
>  	},
> -/* tx_loadsz is set to 63-bytes instead of 64-bytes to implement
> -workaround of errata A-008006 which states that tx_loadsz should  be
> -configured less than Maximum supported fifo bytes */
> +	/*
> +	 * tx_loadsz is set to 63-bytes instead of 64-bytes to implement
> +	 * workaround of errata A-008006 which states that tx_loadsz should=
 be
> +	 * configured less than Maximum supported fifo bytes
> +	 */
>  	[PORT_16550A_FSL64] =3D {
>  		.name		=3D "16550A_FSL64",
>  		.fifo_size	=3D 64,
> @@ -1970,16 +1972,17 @@ int serial8250_do_startup(struct uart_port *p=
ort)
> =20
>  	serial8250_set_mctrl(port, port->mctrl);
> =20
> -	/* Serial over Lan (SoL) hack:
> -	   Intel 8257x Gigabit ethernet chips have a
> -	   16550 emulation, to be used for Serial Over Lan.
> -	   Those chips take a longer time than a normal
> -	   serial device to signalize that a transmission
> -	   data was queued. Due to that, the above test generally
> -	   fails. One solution would be to delay the reading of
> -	   iir. However, this is not reliable, since the timeout
> -	   is variable. So, let's just don't test if we receive
> -	   TX irq. This way, we'll never enable UART_BUG_TXEN.
> +	/*
> +	 * Serial over Lan (SoL) hack:
> +	 * Intel 8257x Gigabit ethernet chips have a
> +	 * 16550 emulation, to be used for Serial Over Lan.
> +	 * Those chips take a longer time than a normal
> +	 * serial device to signalize that a transmission
> +	 * data was queued. Due to that, the above test generally
> +	 * fails. One solution would be to delay the reading of
> +	 * iir. However, this is not reliable, since the timeout
> +	 * is variable. So, let's just don't test if we receive
> +	 * TX irq. This way, we'll never enable UART_BUG_TXEN.
>  	 */

Might as well unwrap this to max line length too.


>  	if (up->port.flags & UPF_NO_TXEN_TEST)
>  		goto dont_test_tx_en;
> diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial=
/8250/serial_cs.c
> index f5270ba..a4bdcf6 100644
> --- a/drivers/tty/serial/8250/serial_cs.c
> +++ b/drivers/tty/serial/8250/serial_cs.c
> @@ -1,35 +1,37 @@
> -/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -    A driver for PCMCIA serial devices
> -
> -    serial_cs.c 1.134 2002/05/04 05:48:53
> -
> -    The contents of this file are subject to the Mozilla Public
> -    License Version 1.1 (the "License"); you may not use this file
> -    except in compliance with the License. You may obtain a copy of
> -    the License at http://www.mozilla.org/MPL/
> -
> -    Software distributed under the License is distributed on an "AS
> -    IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
> -    implied. See the License for the specific language governing
> -    rights and limitations under the License.
> -
> -    The initial developer of the original code is David A. Hinds
> -    <dahinds@users.sourceforge.net>.  Portions created by David A. H=
inds
> -    are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
> -
> -    Alternatively, the contents of this file may be used under the
> -    terms of the GNU General Public License version 2 (the "GPL"), i=
n which
> -    case the provisions of the GPL are applicable instead of the
> -    above.  If you wish to allow the use of your version of this fil=
e
> -    only under the terms of the GPL and not to allow others to use
> -    your version of this file under the MPL, indicate your decision
> -    by deleting the provisions above and replace them with the notic=
e
> -    and other provisions required by the GPL.  If you do not delete
> -    the provisions above, a recipient may use your version of this
> -    file under either the MPL or the GPL.
> -   =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D*/
> +/*
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * A driver for PCMCIA serial devices
> + *
> + * serial_cs.c 1.134 2002/05/04 05:48:53
> + *
> + * The contents of this file are subject to the Mozilla Public
> + * License Version 1.1 (the "License"); you may not use this file
> + * except in compliance with the License. You may obtain a copy of
> + * the License at http://www.mozilla.org/MPL/
> + *
> + * Software distributed under the License is distributed on an "AS
> + * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
> + * implied. See the License for the specific language governing
> + * rights and limitations under the License.
> + *
> + * The initial developer of the original code is David A. Hinds
> + * <dahinds@users.sourceforge.net>.  Portions created by David A. Hi=
nds
> + * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
> + *
> + * Alternatively, the contents of this file may be used under the
> + * terms of the GNU General Public License version 2 (the "GPL"), in=
 which
> + * case the provisions of the GPL are applicable instead of the
> + * above.  If you wish to allow the use of your version of this file
> + * only under the terms of the GPL and not to allow others to use
> + * your version of this file under the MPL, indicate your decision
> + * by deleting the provisions above and replace them with the notice
> + * and other provisions required by the GPL.  If you do not delete
> + * the provisions above, a recipient may use your version of this
> + * file under either the MPL or the GPL.
> + *
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + */
> =20
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> @@ -441,16 +443,20 @@ static int simple_config(struct pcmcia_device *=
link)
>  	struct serial_info *info =3D link->priv;
>  	int i =3D -ENODEV, try;
> =20
> -	/* First pass: look for a config entry that looks normal.
> -	 * Two tries: without IO aliases, then with aliases */
> +	/*
> +	 * First pass: look for a config entry that looks normal.
> +	 * Two tries: without IO aliases, then with aliases
> +	 */
>  	link->config_flags |=3D CONF_AUTO_SET_VPP;
>  	for (try =3D 0; try < 4; try++)
>  		if (!pcmcia_loop_config(link, simple_config_check, &try))
>  			goto found_port;
> =20
> -	/* Second pass: try to find an entry that isn't picky about
> -	   its base address, then try to grab any standard serial port
> -	   address, and finally try to get any free port. */
> +	/*
> +	 * Second pass: try to find an entry that isn't picky about
> +	 * its base address, then try to grab any standard serial port
> +	 * address, and finally try to get any free port.
> +	 */
>  	if (!pcmcia_loop_config(link, simple_config_check_notpicky, NULL))
>  		goto found_port;
> =20
> @@ -480,8 +486,10 @@ static int multi_config_check(struct pcmcia_devi=
ce *p_dev, void *priv_data)
>  	if (p_dev->resource[1]->end)
>  		return -EINVAL;
> =20
> -	/* The quad port cards have bad CIS's, so just look for a
> -	   window larger than 8 ports and assume it will be right */
> +	/*
> +	 * The quad port cards have bad CIS's, so just look for a
> +	 * window larger than 8 ports and assume it will be right
> +	 */
>  	if (p_dev->resource[0]->end <=3D 8)
>  		return -EINVAL;
> =20
> @@ -623,8 +631,10 @@ static int serial_config(struct pcmcia_device *l=
ink)
>  			break;
>  		}
> =20
> -	/* Another check for dual-serial cards: look for either serial or
> -	   multifunction cards that ask for appropriate IO port ranges */
> +	/*
> +	 * Another check for dual-serial cards: look for either serial or
> +	 * multifunction cards that ask for appropriate IO port ranges
> +	 */
>  	if ((info->multi =3D=3D 0) &&
>  	    (link->has_func_id) &&
>  	    (link->socket->pcmcia_pfc =3D=3D 0) &&
>=20
