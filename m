From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 1/4] mfd: f81504-core: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO core support
Date: Fri, 29 Jan 2016 10:22:20 +0800
Message-ID: <56AACCDC.8020306@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-2-git-send-email-hpeter+linux_kernel@gmail.com>
 <20160128100447.00cffae7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128100447.00cffae7@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Alan,

One Thousand Gnomes =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 06:04 =E5=AF=
=AB=E9=81=93:
>> +          Please bulit-in kernel if you need early console support.
> This driver needs to be built into the kernel to use early console
> support.
>

ok

>> +	switch (dev->device) {
>> +	case FINTEK_F81504: /* 4 ports */
>> +		/* F81504 max 2 sets of GPIO, others are max 6 sets*/
>> +		gpio_en &=3D 0x03;
>> +	case FINTEK_F81508: /* 8 ports */
>> +		max_port =3D dev->device & 0xff;
>
> If that is meant to fall through from F81504 into F81508 it's worth
> commenting, otherwise someone reviewing the code can't always be sure=
 it
> was intentional.

ok, I'll add comments to describe this.

>> +	/* Get the UART IO address dispatch from the BIOS */
>> +	pci_read_config_dword(dev, 0x24, &bar_data[0]);
>> +	pci_read_config_dword(dev, 0x20, &bar_data[1]);
>> +	pci_read_config_dword(dev, 0x1c, &bar_data[2]);
>
> Take these from the pci device itself. On some non PC platforms the
> values in the pci bar may be remapped by bridges and not give you the
> true answer.
>
> 	pci_resource_start(dev, barnumber)
>

Thanks for point this out, I'll rewrite here with pci_resource_start().
--=20
With Best Regards,
Peter Hung
