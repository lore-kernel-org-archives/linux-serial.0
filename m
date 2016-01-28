From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Thu, 28 Jan 2016 10:04:47 +0000
Message-ID: <20160128100447.00cffae7@lxorguk.ukuu.org.uk>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	<1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

> +config MFD_FINTEK_F81504_CORE
> +        tristate "Fintek F81504/508/512 PCIE-to-UART/GPIO MFD support"
> +        depends on PCI
> +        select MFD_CORE
> +        default y
> +        help
> +          This driver generate F81504/508/512 UART & GPIO platform
This driver provides the F81504/508/512 UART & GPIO platform
> +          device. It should enable CONFIG_GPIO_F81504 to get GPIOLIB
devices. You should enable CONFIG_GPIO_F81504 to get GPIOLIB
> +          support and CONFIG_8250_F81504 to get serial ports support.
port rather than ports

> +          Please bulit-in kernel if you need early console support.
This driver needs to be built into the kernel to use early console
support.



> +	switch (dev->device) {
> +	case FINTEK_F81504: /* 4 ports */
> +		/* F81504 max 2 sets of GPIO, others are max 6 sets*/
> +		gpio_en &= 0x03;
> +	case FINTEK_F81508: /* 8 ports */
> +		max_port = dev->device & 0xff;

If that is meant to fall through from F81504 into F81508 it's worth
commenting, otherwise someone reviewing the code can't always be sure it
was intentional.

> +		break;
> +	case FINTEK_F81512: /* 12 ports */
> +		max_port = 12;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* rewrite GPIO Mode setting */
> +	pci_write_config_byte(dev, F81504_GPIO_ENABLE_REG, gpio_en & 0x3f);
> +	pci_write_config_byte(dev, F81504_GPIO_MODE_REG, ~gpio_en & 0x3f);
> +
> +	/* Get the UART IO address dispatch from the BIOS */
> +	pci_read_config_dword(dev, 0x24, &bar_data[0]);
> +	pci_read_config_dword(dev, 0x20, &bar_data[1]);
> +	pci_read_config_dword(dev, 0x1c, &bar_data[2]);

Take these from the pci device itself. On some non PC platforms the
values in the pci bar may be remapped by bridges and not give you the
true answer.

	pci_resource_start(dev, barnumber)


Alan
