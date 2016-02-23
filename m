From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V4 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Tue, 23 Feb 2016 13:05:17 +0200
Message-ID: <1456225517.13244.41.camel@linux.intel.com>
References: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
	 <1456209003-22396-2-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456209003-22396-2-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-02-23 at 14:30 +0800, Peter Hung wrote:
> The Fintek F81504/508/512 had implemented the basic serial port
> function in
> 8250_pci.c. We try to implement high baudrate & GPIOLIB with a spilt
> file
> 8250_f81504.c, but it seems too complex to add GPIOLIB.

[...]

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -345,6 +345,18 @@ config HTC_I2CPLD
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
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default SERIAL_8250

SERIAL_8250_PCI ?

> +static bool f81504_is_gpio(unsigned int idx, u8 gpio_en)
> +{
> +	unsigned int i;
> +
> +	/* Find every port to check is multi-function port */
> +	for (i =3D 0; i < ARRAY_SIZE(fintek_gpio_mapping); i++) {


> +		if (fintek_gpio_mapping[i] !=3D idx || !(gpio_en &
> BIT(i)))
> +			continue;
> +
> +		/*
> +		=C2=A0* This port is multi-function and enabled as gpio
> mode.
> +		=C2=A0* So we'll not configure it as serial port.
> +		=C2=A0*/
> +		return true;

Perhaps

if (fintek_gpio_mapping[i] =3D=3D idx && (gpio_en & BIT(i)))
=C2=A0return true;

?

> +	}
> +
> +	return false;
> +}

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
