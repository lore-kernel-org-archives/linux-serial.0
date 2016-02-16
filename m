From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V3 3/4] 8250: 8250_f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO UART support
Date: Tue, 16 Feb 2016 11:11:39 +0200
Message-ID: <1455613899.31169.149.camel@linux.intel.com>
References: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1455605710-3724-4-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455605710-3724-4-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-02-16 at 14:55 +0800, Peter Hung wrote:
> This driver is 8250 driver for F81504/508/512, it'll handle the
> serial
> port operation of this device. This module will depend on
> MFD_FINTEK_F81504_CORE.
>=20
> The serial ports support from 50bps to 1.5Mbps with Linux baudrate
> define excluding 1.0Mbps due to not support 16MHz clock source.
>=20
> PCI Configuration Space Registers, set:0~11(Max):
> =C2=A0=C2=A0=C2=A0=C2=A040h + 8 * set:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit7~6: Clock source selec=
tor
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000=
: 1.8432MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A001=
: 18.432MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010=
: 24MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A011=
: 14.769MHz
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit0: UART enable
> =C2=A0=C2=A0=C2=A0=C2=A041h + 8 * set:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit5~4: RX trigger multipl=
e
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A000=
: 1x * trigger level
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A001=
: 2x * trigger level
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A010=
: 4x * trigger level
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A011=
: 8x * trigger level
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit1~0: FIFO Size
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A011=
: 128Bytes
> =C2=A0=C2=A0=C2=A0=C2=A044h + 8 * set: UART IO address (LSB)
> =C2=A0=C2=A0=C2=A0=C2=A045h + 8 * set: UART IO address (MSB)
> =C2=A0=C2=A0=C2=A0=C2=A047h + 8 * set:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit5: RTS invert (bit4 mus=
t enable)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bit4: RTS auto direction e=
nable
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00: RTS control by MCR
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A01: RTS driven high when TX, otherwise low
>=20

=46ew my comments below.

> +++ b/drivers/tty/serial/8250/8250_f81504.c
> @@ -0,0 +1,254 @@
> +#include <linux/pci.h>
> +#include <linux/serial_8250.h>
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/mfd/f81504.h>
> +
> +#include "8250.h"
> +
> +static u32 baudrate_table[] =3D { 1500000, 1152000, 921600 };
> +static u8 clock_table[] =3D { F81504_CLKSEL_24_MHZ,
> F81504_CLKSEL_18DOT46_MHZ,
> +				F81504_CLKSEL_14DOT77_MHZ };

I suggest to replace DOT by _.

> +
> +/* We should do proper H/W transceiver setting before change to
> RS485 mode */
> +static int f81504_rs485_config(struct uart_port *port,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct serial_rs485 *rs=
485)
> +{
> +	u8 setting;
> +	u8 *index =3D (u8 *) port->private_data;

private_data is a type of void *, therefore no need to have an explicit
casting.

> +static int f81504_check_baudrate(u32 baud, size_t *idx)
> +{
> +	size_t index;
> +	u32 quot, rem;
> +
> +	for (index =3D 0; index < ARRAY_SIZE(baudrate_table); ++index)

Post-increment is also okay.

> {
> +		/* Clock source must largeer than desire baudrate */
> +		if (baud > baudrate_table[index])
> +			continue;
> +
> +		quot =3D DIV_ROUND_CLOSEST(baudrate_table[index],
> baud);

So, how quot is used and is it possible to set, for example, baud rate
as 1000000 or 576000?

> +		/* find divisible clock source */
> +		rem =3D baudrate_table[index] % baud;
> +
> +		if (quot && !rem) {
> +			if (idx)
> +				*idx =3D index;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void f81504_set_termios(struct uart_port *port,
> +		struct ktermios *termios, struct ktermios *old)
> +{
> +	struct platform_device *pdev =3D container_of(port->dev,
> +					struct platform_device,
> dev);
> +	struct pci_dev *dev =3D to_pci_dev(pdev->dev.parent);
> +	unsigned int baud =3D tty_termios_baud_rate(termios);
> +	u8 tmp, *offset =3D (u8 *) port->private_data;

Same for provate_data as above.

> +		/* read current clock source (masked with
> CLOCK_RATE_MASK) */

=2E..

> +			/*
> +			=C2=A0* direct use 1.8432MHz when baudrate
> smaller then or
> +			=C2=A0* equal 115200bps

Check your style of comments in a _whole_ your series.

/*=C2=A0
=C2=A0* Start sentence with Capital letter and end with a period.
=C2=A0*/

> +			=C2=A0*/
>=20

> +		if (!f81504_check_baudrate(baud, &i)) {
> +			/* had optimize value */

/* For one line comment */


> +			/*
> +			=C2=A0* If it can't found suitable clock source
> but had old
> +			=C2=A0* accpetable baudrate, we'll use it

Typo: acceptable.
Baudrate -> =C2=A0baud rate.

> +			=C2=A0*/
> +			baud =3D tty_termios_baud_rate(old);
> +		} else {
> +			/*
> +			=C2=A0* If it can't found suitable clock source
> and not old
> +			=C2=A0* config, we'll direct set 115200bps for
> future use
> +			=C2=A0*/


> +static int f81504_register_port(struct platform_device *dev,
> +		unsigned long address, int idx)
> +{
> +	struct pci_dev *pci_dev =3D to_pci_dev(dev->dev.parent);
> +	struct uart_8250_port port;
> +	u8 *data;
> +
> +	memset(&port, 0, sizeof(port));
> +	data =3D devm_kzalloc(&dev->dev, sizeof(u8), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	*data =3D idx;
> +	port.port.iotype =3D UPIO_PORT;
> +	port.port.irq =3D pci_dev->irq;
> +	port.port.flags =3D UPF_SKIP_TEST | UPF_FIXED_TYPE |
> UPF_BOOT_AUTOCONF |
> +			UPF_SHARE_IRQ;
> +	port.port.uartclk =3D 1843200;
> +	port.port.dev =3D &dev->dev;
> +	port.port.iobase =3D address;
> +	port.port.type =3D PORT_16550A;
> +	port.port.fifosize =3D 128;
> +	port.port.rs485_config =3D f81504_rs485_config;
> +	port.port.set_termios =3D f81504_set_termios;
> +	port.tx_loadsz =3D 32;


> +	port.port.private_data =3D data;	/* save current idx */

Not sure you need to allocate memory for that at all, or maybe use a
struct with one member (for now).


> +static SIMPLE_DEV_PM_OPS(f81504_serial_pm_ops,
> f81504_serial_suspend,
> +		f81504_serial_resume);
> +
> +static struct platform_driver f81504_serial_driver =3D {
> +	.driver =3D {
> +		.name	=3D F81504_SERIAL_NAME,
> +		.owner	=3D THIS_MODULE,

You perhaps don't need this. Check the rest of the modules.

> +		.pm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D &f81504_serial_pm_ops,
> +	},
>=20

> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -116,6 +116,17 @@ config SERIAL_8250_PCI
> =C2=A0	=C2=A0=C2=A0Note that serial ports on NetMos 9835 Multi-I/O ca=
rds are
> handled
> =C2=A0	=C2=A0=C2=A0by the parport_serial driver, enabled with
> CONFIG_PARPORT_SERIAL.
> =C2=A0
> +config SERIAL_8250_F81504
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Fintek F81=
504/508/512 16550 PCIE device support"
> if EXPERT
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SERIAL_82=
50 && MFD_FINTEK_F81504_CORE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default SERIAL_8250
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select RATIONAL

It seems RATIONAL API is not used here.


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
