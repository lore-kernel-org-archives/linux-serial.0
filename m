From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO GPIOLIB support
Date: Thu, 28 Jan 2016 14:03:04 +0200
Message-ID: <1453982584.2521.285.camel@linux.intel.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1453972838-30268-3-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453972838-30268-3-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-01-28 at 17:20 +0800, Peter Hung wrote:
> This driver is GPIOLIB driver for F81504/508/512, it'll handle the
> GPIOLIB operation of this device. This module will depend on
> MFD_FINTEK_F81504_CORE.
>=20



> +	/*
> +	=C2=A0* The GPIO default driven mode for this device is open-
> drain. The
> +	=C2=A0* GPIOLIB had no change GPIO mode API currently. So we
> leave the
> +	=C2=A0* Push-Pull code below.
> +	=C2=A0*
> +	=C2=A0* pci_read_config_byte(dev, GPIO_START_ADDR + idx *
> GPIO_SET_OFFSET +
> +	=C2=A0*			GPIO_DRIVE_EN_OFFSET, &tmp);
> +	=C2=A0* pci_write_config_byte(dev, GPIO_START_ADDR + idx *
> GPIO_SET_OFFSET +
> +	=C2=A0*			GPIO_DRIVE_EN_OFFSET, tmp |
> BIT(gpio_num));
> +	=C2=A0*/
> +
> +	/* set output data */
> +	tmp =3D inb(priv->gpio_ioaddr + gc->idx);

ioread8 is a bit better since it automatically works with IO space and
MMIO. But if you are certain you will always have the address in IO
space, you can disregard this comment.

> +static int f81504_gpio_probe(struct platform_device *pdev)
> +{
> +	int status;
> +	struct f81504_gpio_chip *gc;
> +	void *data =3D dev_get_platdata(&pdev->dev);
> +	u8 gpio_idx =3D *(u8 *)data;
> +	char *name;
> +
> +	if (gpio_idx >=3D ARRAY_SIZE(fintek_gpio_mapping)) {
> +		dev_err(&pdev->dev, "%s: gpio_idx:%d out of
> range.\n",
> +				__func__, gpio_idx);
> +		return -ENODEV;
> +	}
> +
> +	gc =3D devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
> +	if (!gc)
> +		return -ENOMEM;
> +
>=20

> +	kfree(data);

What the heck?


> +	mutex_init(&gc->locker);
> +	platform_set_drvdata(pdev, gc);
> +
> +	name =3D devm_kzalloc(&pdev->dev, FINTEK_GPIO_NAME_LEN,
> GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	/* This will display like as GPIO-1x */
> +	sprintf(name, "%s-%dx", FINTEK_GPIO_DISPLAY, gpio_idx);
> +
> +	gc->chip.owner =3D THIS_MODULE;
> +	gc->chip.label =3D name;
> +	gc->chip.ngpio =3D 8;
> +	gc->chip.dev =3D &pdev->dev;
> +	gc->chip.get =3D f81504_gpio_get;
> +	gc->chip.set =3D f81504_gpio_set;
> +	gc->chip.direction_input =3D f81504_gpio_direction_in;
> +	gc->chip.direction_output =3D f81504_gpio_direction_out;
> +	gc->chip.get_direction =3D f81504_gpio_get_direction;
> +	gc->chip.can_sleep =3D 1;
> +	gc->chip.base =3D -1;
> +	gc->idx =3D gpio_idx;
> +
>=20

> +	status =3D gpiochip_add(&gc->chip);
> +	if (status) {
> +		dev_err(&pdev->dev, "%s: gpiochip_add failed: %d\n",
> __func__,
> +				status);
> +		return -ENOMEM;

You ignored the status.

> +	}
> +
> +	return 0;

Perhaps just
return gpiochip_add(); ?

> +}
> +
> +static int f81504_gpio_remove(struct platform_device *pdev)
> +{
> +	struct f81504_gpio_chip *gc =3D platform_get_drvdata(pdev);
> +
> +	gpiochip_remove(&gc->chip);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(f81504_gpio_pm_ops, f81504_gpio_suspend,
> +		f81504_gpio_resume);
> +
> +static struct platform_driver f81504_gpio_driver =3D {
> +	.driver =3D {
> +		.name	=3D F81504_GPIO_NAME,
> +		.owner	=3D THIS_MODULE,
> +		.pm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D &f81504_gpio_pm_ops,
> +	},
> +	.probe		=3D f81504_gpio_probe,
> +	.remove		=3D f81504_gpio_remove,
> +};
> +
> +module_platform_driver(f81504_gpio_driver);
> +
> +MODULE_AUTHOR("Peter Hong <Peter_Hong@fintek.com.tw>");
> +MODULE_DESCRIPTION("Fintek F81504/508/512 PCIE GPIOLIB driver");
> +MODULE_LICENSE("GPL");

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
