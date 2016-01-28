From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Thu, 28 Jan 2016 13:55:06 +0200
Message-ID: <1453982106.2521.279.camel@linux.intel.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-01-28 at 17:20 +0800, Peter Hung wrote:
> The Fintek F81504/508/512 had implemented the basic serial port
> function in
> 8250_pci.c. We try to implement high baudrate & GPIOLIB with a spilt
> file
> 8250_f81504.c, but it seems too complex to add GPIOLIB.
>=20
> Alan & Andy recommend us to rewrite and spilt our driver with MFD
> architecture.
> https://lkml.org/lkml/2016/1/19/288


My comments below.


> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -310,6 +310,17 @@ config HTC_I2CPLD
> =C2=A0	=C2=A0=C2=A0This device provides input and output GPIOs throug=
h an I2C
> =C2=A0	=C2=A0=C2=A0interface to one or more sub-chips.
> =C2=A0
> +config MFD_FINTEK_F81504_CORE
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Fintek F81=
504/508/512 PCIE-to-UART/GPIO MFD
> support"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on PCI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select MFD_CORE
>=20

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y

I'm not sure we have to have this always y. Perhaps=C2=A0
default SERIAL_8250_PCI

> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -21,6 +21,8 @@ obj-$(CONFIG_HTC_EGPIO)		+=3D htc-
> egpio.o
> =C2=A0obj-$(CONFIG_HTC_PASIC3)	+=3D htc-pasic3.o
> =C2=A0obj-$(CONFIG_HTC_I2CPLD)	+=3D htc-i2cpld.o
> =C2=A0
> +obj-$(CONFIG_MFD_FINTEK_F81504_CORE)	+=3D f81504-core.o

I think '_' is better than '-'. What I saw and usually do is '_' for
regular source modules and '-' for the resulting objects when they have
more than one file.

> --- /dev/null
> +++ b/drivers/mfd/f81504-core.c
> @@ -0,0 +1,331 @@
> +/*
> + * Core operations for Fintek F81504/508/512 PCIE-to-UART/GPIO
> device
> + */
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/f81504.h>
> +
> +#define F81504_DRIVER_NAME	"f81504_core"

Yeah, exactly.

> +#define F81504_DEV_DESC		"Fintek F81504/508/512 PCIE-
> to-UART core"

Do you need this definition? Is it used more than once?

> +#define F81504_IO_REGION	8
> +
> +const u8 fintek_gpio_mapping[F81504_MAX_GPIO_CNT] =3D { 2, 3, 8, 9,
> 10, 11 };
> +EXPORT_SYMBOL(fintek_gpio_mapping);
> +
> +static int f81504_port_init(struct pci_dev *dev)
> +{
> +	size_t i, j;
> +	u32 max_port, iobase, gpio_addr;
> +	u32 bar_data[3];
> +	u16 tmp;
> +	u8 config_base, gpio_en, f0h_data, f3h_data;
> +	bool is_gpio;
> +	struct f81504_pci_private *priv =3D pci_get_drvdata(dev);

I would suggest to rearrange definition block here (and in the rest of
the functions in entire series) to somehow follow the following pattern

1) assignments go first, especially container_of() based ones;
2) group variables by meaning and put longer lines upper;
3) return value variable, if exists, goes last.

Besides that choose types carefully. If there is known limit for
counters, no need to define wider type than needed. Use proper types
for corresponding values.

> +
> +	/* Init GPIO IO Address */
> +	pci_read_config_dword(dev, 0x18, &gpio_addr);
> +	gpio_addr &=3D 0xffffffe0;


> +	pci_write_config_byte(dev, F81504_GPIO_IO_LSB_REG, gpio_addr
> & 0xff);
> +	pci_write_config_byte(dev, F81504_GPIO_IO_MSB_REG,
> (gpio_addr >> 8) &
> +			0xff);

Could it be written at once as a word?

> +	if (priv) {
> +		/* Reinit from resume(), read the previous value
> from priv */
>=20

> +		gpio_en =3D priv->gpio_en;

I would suggest to move this line down to follow same pattern in else
branch.

> +
> +		/* re-save GPIO IO addr for called by resume() */

re-save -> Re-save
addr -> address

> +		priv->gpio_ioaddr =3D gpio_addr;
> +	} else {
> +		/* Driver first init */
> +		pci_read_config_byte(dev, F81504_GPIO_ENABLE_REG,
> &f0h_data);
> +		pci_read_config_byte(dev, F81504_GPIO_MODE_REG,
> &f3h_data);
> +
> +		/* find the max set of GPIOs */

Use one pattern for all comments, like "Capital letter first, and full
words avoiding abbreviations".

> +		gpio_en =3D f0h_data | ~f3h_data;
> +	}
> +
> +	switch (dev->device) {
> +	case FINTEK_F81504: /* 4 ports */
> +		/* F81504 max 2 sets of GPIO, others are max 6
> sets*/

Space before * is needed.

> +		gpio_en &=3D 0x03;
> +	case FINTEK_F81508: /* 8 ports */
> +		max_port =3D dev->device & 0xff;
> +		break;
> +	case FINTEK_F81512: /* 12 ports */
> +		max_port =3D 12;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* rewrite GPIO Mode setting */
> +	pci_write_config_byte(dev, F81504_GPIO_ENABLE_REG, gpio_en &
> 0x3f);
> +	pci_write_config_byte(dev, F81504_GPIO_MODE_REG, ~gpio_en &
> 0x3f);
> +
> +	/* Get the UART IO address dispatch from the BIOS */
> +	pci_read_config_dword(dev, 0x24, &bar_data[0]);
> +	pci_read_config_dword(dev, 0x20, &bar_data[1]);
> +	pci_read_config_dword(dev, 0x1c, &bar_data[2]);
> +
> +	/* Compatible bit for newer step IC */
> +	pci_read_config_word(dev, F81504_IRQSEL_REG, &tmp);
> +	tmp |=3D BIT(8);
> +	pci_write_config_word(dev, F81504_IRQSEL_REG, tmp);
> +
> +	for (i =3D 0; i < max_port; ++i) {

i++, since it's more usual pattern.

> +		/* UART0 configuration offset start from 0x40 */
> +		config_base =3D F81504_UART_START_ADDR +
> F81504_UART_OFFSET * i;
> +		is_gpio =3D false;
> +
>=20


> +		/* find every port to check is multi-function port?
> */
> +		for (j =3D 0; j < ARRAY_SIZE(fintek_gpio_mapping);
> ++j) {
> +			if (fintek_gpio_mapping[j] !=3D i || !(gpio_en
> & BIT(j)))
> +				continue;
> +
> +			/*
> +			=C2=A0* This port is multi-function and enabled
> as gpio
> +			=C2=A0* mode. So we'll not configure it as serial
> port.
> +			=C2=A0*/
> +			is_gpio =3D true;
> +			break;
> +		}

Looks like a separate function.

func()
{
=C2=A0for () {
=C2=A0 =C2=A0if ()
=C2=A0 =C2=A0 return X;
=C2=A0}
=C2=A0return Y;
}


> +
> +		/*
> +		=C2=A0* If the serial port is setting to gpio mode, don't
> init it.
> +		=C2=A0* Disable the serial port for user-space
> application to
> +		=C2=A0* control.
> +		=C2=A0*/
> +		if (is_gpio) {
> +			/* Disable current serial port */
> +			pci_write_config_byte(dev, config_base +
> 0x00, 0x00);
> +			continue;
> +		}
> +
> +		/* Calculate Real IO Port */
> +		iobase =3D (bar_data[i / 4] & 0xffffffe0) + (i % 4) *
> 8;


> +
> +		/* Enable UART I/O port */
> +		pci_write_config_byte(dev, config_base + 0x00,
> 0x01);
> +
> +		/* Select 128-byte FIFO and 8x FIFO threshold */
> +		pci_write_config_byte(dev, config_base + 0x01,
> 0x33);
> +
> +		/* LSB UART */
> +		pci_write_config_byte(dev, config_base + 0x04,
> +				(u8)(iobase & 0xff));

Redundant explicit casting.=C2=A0

> +
> +		/* MSB UART */
> +		pci_write_config_byte(dev, config_base + 0x05,
> +				(u8)((iobase & 0xff00) >> 8));

Ditto.

And similar question, can it be written as a word?

> +
> +		pci_write_config_byte(dev, config_base + 0x06, dev-
> >irq);
> +
> +		/*
> +		=C2=A0* Force init to RS232 / Share Mode, recovery
> previous mode
> +		=C2=A0* will done in F81504 8250 platform driver resume()

Period at the end of sentences in multi-line comments.

> +		=C2=A0*/
> +		pci_write_config_byte(dev, config_base + 0x07,
> 0x01);
> +	}
> +
> +	return 0;
> +}
> +
> +static int f81504_prepage_serial_port(struct pci_dev *dev, int
> max_port)
> +{
> +	size_t i;
> +	int status;
> +	u8 tmp;
> +	u16 iobase;
> +	struct resource	resources =3D DEFINE_RES_IO(0, 0);


> +	struct mfd_cell f81504_serial_cell =3D {
> +		.name =3D F81504_SERIAL_NAME,
> +		.num_resources	=3D 1,
> +	};

> +
> +	for (i =3D 0; i < max_port; ++i) {
> +		/* Check UART is enabled */
>=20

> +		pci_read_config_byte(dev, F81504_UART_START_ADDR + i
> *
> +				F81504_UART_OFFSET, &tmp);
> +		if (!tmp)
> +			continue;

So, this is the same as below, right?

> +
> +		/* Get UART IO Address */
> +		pci_read_config_word(dev, F81504_UART_START_ADDR + i
> *
> +				F81504_UART_OFFSET + 4, &iobase);

=E2=80=A6why not to check here?

> +
> +		resources.start =3D iobase;
> +		resources.end =3D iobase + F81504_IO_REGION - 1;
> +
> +		f81504_serial_cell.resources =3D &resources;

> +		f81504_serial_cell.pdata_size =3D sizeof(i);

This is static, can be part of definition.

> +		f81504_serial_cell.platform_data =3D &i;
> +
> +		status =3D mfd_add_devices(&dev->dev,
> PLATFORM_DEVID_AUTO,
> +					&f81504_serial_cell, 1,
> NULL, dev->irq,
> +					NULL);
> +		if (status) {
> +			dev_warn(&dev->dev, "%s: add device failed:
> %d\n",
> +					__func__, status);

Indent _ under &.

> +			return status;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int f81504_prepage_gpiolib(struct pci_dev *dev)
> +{
> +	size_t i;
> +	int status;
> +	struct f81504_pci_private *priv =3D pci_get_drvdata(dev);
> +	struct mfd_cell f81504_gpio_cell =3D {
> +		.name =3D F81504_GPIO_NAME,
> +	};
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fintek_gpio_mapping); ++i) {
> +		if (!(priv->gpio_en & BIT(i)))
> +			continue;
> +
>=20

> +		f81504_gpio_cell.pdata_size =3D sizeof(i);

Static. The problem here is badly chosen type of i. Like I mentioned at
the top of review=E2=80=A6

> +		f81504_gpio_cell.platform_data =3D &i;
> +
> +		status =3D mfd_add_devices(&dev->dev,
> PLATFORM_DEVID_AUTO,
> +					&f81504_gpio_cell, 1, NULL,
> dev->irq,
> +					NULL);
> +		if (status) {
> +			dev_warn(&dev->dev, "%s: add device failed:
> %d\n",
> +					__func__, status);
> +			return status;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int f81504_probe(struct pci_dev *dev, const struct
> pci_device_id
> +			*dev_id)

Usually drivers are using pdev, id pair in parameters. Shorter; known
pattern.

> +{
> +	int status;
> +	u8 tmp;
> +	struct f81504_pci_private *priv;
> +
> +	status =3D pci_enable_device(dev);

Please, pcim_, see comment below.

> +	if (status)
> +		return status;
> +
> +	/* Init PCI Configuration Space */
> +	status =3D f81504_port_init(dev);
> +	if (status)

Device left enabled if not managed.

> +		return status;
> +
> +	priv =3D devm_kzalloc(&dev->dev, sizeof(struct
> f81504_pci_private),
> +				GFP_KERNEL);
> +	if (!priv)

Ditto.

> +		return -ENOMEM;
> +
> +	/* Save the GPIO_ENABLE_REG after f81504_port_init() for
> future use */
> +	pci_read_config_byte(dev, F81504_GPIO_ENABLE_REG, &priv-
> >gpio_en);
> +
> +	/* Save GPIO IO Addr to private data */
>=20

> +	pci_read_config_byte(dev, F81504_GPIO_IO_MSB_REG, &tmp);
> +	priv->gpio_ioaddr =3D tmp << 8;
> +	pci_read_config_byte(dev, F81504_GPIO_IO_LSB_REG, &tmp);
> +	priv->gpio_ioaddr |=3D tmp;

One read as word?

> +
> +	pci_set_drvdata(dev, priv);
> +
> +	/* Generate UART Ports */
> +	status =3D f81504_prepage_serial_port(dev, dev_id-
> >driver_data);
> +	if (status)
> +		goto failed;
> +
> +	/* Generate GPIO Sets */
> +	status =3D f81504_prepage_gpiolib(dev);
> +	if (status)
> +		goto failed;
> +
> +	return 0;
> +
> +failed:
>=20

> +	mfd_remove_devices(&dev->dev);

mfd_add_devices takes care.

> +	pci_disable_device(dev);

pcim_ takes case.

> +	return status;
> +}
> +
> +static void f81504_remove(struct pci_dev *dev)
> +{

> +	mfd_remove_devices(&dev->dev);
> +	pci_disable_device(dev);

Ditto.

> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int f81504_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int f81504_resume(struct device *dev)
> +{
> +	int status;
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +
>=20

> +	status =3D pci_enable_device(pdev);
> +	if (status)
> +		return status;

It's done by PCI core I believe.

> +
> +	/* Re-init PCI Configuration Space */
> +	status =3D f81504_port_init(pdev);
> +	if (status)
> +		return status;
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct pci_device_id f81504_dev_table[] =3D {
> +	/* Fintek PCI serial cards */
> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81504), .driver_data =3D 4},
> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81508), .driver_data =3D 8},
> +	{PCI_DEVICE(FINTEK_VID, FINTEK_F81512), .driver_data =3D 12},
> +	{}

So, if you have default y for this and 8250_pci, which one will be
loaded?

> +};
> +
> +static SIMPLE_DEV_PM_OPS(f81504_pm_ops, f81504_suspend,
> f81504_resume);
> +
> +static struct pci_driver f81504_driver =3D {
> +	.name =3D F81504_DRIVER_NAME,
> +	.probe =3D f81504_probe,
> +	.remove =3D f81504_remove,
> +	.driver		=3D {
> +		.pm	=3D &f81504_pm_ops,


> +		.owner	=3D THIS_MODULE,

kbuild =C2=A0already complained about.

> +	},
> +	.id_table =3D f81504_dev_table,
> +};
> +
> +module_pci_driver(f81504_driver);
> +
> +MODULE_DEVICE_TABLE(pci, f81504_dev_table);
> +MODULE_DESCRIPTION(F81504_DEV_DESC);
> +MODULE_AUTHOR("Peter Hong <Peter_Hong@fintek.com.tw>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/f81504.h b/include/linux/mfd/f81504.h
> new file mode 100644
> index 0000000..13bd0ae
> --- /dev/null
> +++ b/include/linux/mfd/f81504.h
> @@ -0,0 +1,52 @@
> +#ifndef __F81504_H__

__MFD_F=E2=80=A6

> +#define __F81504_H__
> +
> +#define FINTEK_VID			0x1c29
> +#define FINTEK_F81504			0x1104
> +#define FINTEK_F81508			0x1108
> +#define FINTEK_F81512			0x1112
> +
> +#define FINTEK_MAX_PORT			12
> +#define FINTEK_GPIO_NAME_LEN		32
> +#define FINTEK_GPIO_DISPLAY		"GPIO"
> +
> +#define F81504_UART_START_ADDR		0x40
> +#define F81504_UART_MODE_OFFSET		0x07
> +#define F81504_UART_OFFSET		0x08
> +
> +/* RTS will control by MCR if this bit is 0 */
> +#define F81504_RTS_CONTROL_BY_HW	BIT(4)
> +/* only worked with FINTEK_RTS_CONTROL_BY_HW on */
> +#define F81504_RTS_INVERT		BIT(5)
> +
> +#define F81504_CLOCK_RATE_MASK		0xc0
> +#define F81504_CLKSEL_1DOT846_MHZ	0x00
> +#define F81504_CLKSEL_18DOT46_MHZ	0x40
> +#define F81504_CLKSEL_24_MHZ		0x80
> +#define F81504_CLKSEL_14DOT77_MHZ	0xc0
> +
> +#define F81504_IRQSEL_REG		0xb8
> +
> +#define F81504_GPIO_ENABLE_REG		0xf0
> +#define F81504_GPIO_IO_LSB_REG		0xf1
> +#define F81504_GPIO_IO_MSB_REG		0xf2
> +#define F81504_GPIO_MODE_REG		0xf3
> +
> +#define F81504_GPIO_START_ADDR		0xf8
> +#define F81504_GPIO_OUT_EN_OFFSET	0x00
> +#define F81504_GPIO_DRIVE_EN_OFFSET	0x01
> +#define F81504_GPIO_SET_OFFSET		0x08
> +
> +#define F81504_GPIO_NAME		"f81504_gpio"
> +#define F81504_SERIAL_NAME		"f81504_serial"
> +#define F81504_MAX_GPIO_CNT		6
> +
> +extern const u8 fintek_gpio_mapping[F81504_MAX_GPIO_CNT];
> +
> +struct f81504_pci_private {
> +	int line[FINTEK_MAX_PORT];
> +	u8 gpio_en;
> +	u16 gpio_ioaddr;
> +	u32 uart_count, gpio_count;
> +};
> +#endif

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
