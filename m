From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V4 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Wed, 2 Mar 2016 15:34:13 +0800
Message-ID: <56D69775.7080309@gmail.com>
References: <1456209003-22396-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1456209003-22396-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <1456225517.13244.41.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1456225517.13244.41.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/2/23 =E4=B8=8B=E5=8D=88 07:05 =E5=AF=AB=E9=
=81=93:
> On Tue, 2016-02-23 at 14:30 +0800, Peter Hung wrote:
>> +config MFD_FINTEK_F81504_CORE
>> +        tristate "Fintek F81504/508/512 PCIE-to-UART/GPIO MFD
>> support"
>> +        depends on PCI
>> +        select MFD_CORE
>> +        default SERIAL_8250
>
> SERIAL_8250_PCI ?

In my opinion, 8250_pci & f81504_core are independently drivers.
So I'll set the default to SERIAL_8250.

>> +static bool f81504_is_gpio(unsigned int idx, u8 gpio_en)
>> +{
>> +	unsigned int i;
>> +
>> +	/* Find every port to check is multi-function port */
>> +	for (i =3D 0; i < ARRAY_SIZE(fintek_gpio_mapping); i++) {
>
>
>> +		if (fintek_gpio_mapping[i] !=3D idx || !(gpio_en &
>> BIT(i)))
>> +			continue;
>> +
>> +		/*
>> +		 * This port is multi-function and enabled as gpio
>> mode.
>> +		 * So we'll not configure it as serial port.
>> +		 */
>> +		return true;
>
> Perhaps
>
> if (fintek_gpio_mapping[i] =3D=3D idx && (gpio_en & BIT(i)))
>   return true;

Your code is more simple and readable. I'll change it for V5

Thanks for your advices.
--=20
With Best Regards,
Peter Hung
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
