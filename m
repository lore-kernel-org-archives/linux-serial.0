From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V2 4/4] serial: 8250_pci: Remove Fintek F81504/508/512
 UART driver
Date: Mon, 1 Feb 2016 11:33:38 +0800
Message-ID: <56AED212.5010903@gmail.com>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453972838-30268-5-git-send-email-hpeter+linux_kernel@gmail.com>
 <1453982657.2521.287.camel@linux.intel.com> <56AB20B1.9030609@gmail.com>
 <1454071220.2521.311.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454071220.2521.311.camel@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

Andy Shevchenko =E6=96=BC 2016/1/29 =E4=B8=8B=E5=8D=88 08:40 =E5=AF=AB=E9=
=81=93:
> On Fri, 2016-01-29 at 16:20 +0800, Peter Hung wrote:
>> Hi Andy,
>>
>> Andy Shevchenko =E6=96=BC 2016/1/28 =E4=B8=8B=E5=8D=88 08:04 =E5=AF=AB=
=E9=81=93:
>>> On Thu, 2016-01-28 at 17:20 +0800, Peter Hung wrote:
>>>> -	/* Fintek PCI serial cards */
>>>> -	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data =3D
>>>> pbn_fintek_4 },
>>>> -	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data =3D
>>>> pbn_fintek_8 },
>>>> -	{ PCI_DEVICE(0x1c29, 0x1112), .driver_data =3D
>>>> pbn_fintek_12
>>>> },
>>>
>>> Shouldn't you blacklist them in 8250_pci?
>>>
>>
>> You are referring to add blacklist instead of remove F81504/508/512
>> code?
>
> No.
>
>>   or add blacklist and remove code?
>
> This one.

ok

> Check what lspci tells you about your device. I'm pretty sure that it
> has Serial Class, which would trigger enumeration in 8250_pci.c if it
> comes first.
>

I had add log with 8250_pci.c. It really trigger once by 8250_pci.c,
but will failed with serial_pci_guess_board(). So It can be handled by
f81504-core.c. I should add pid/vid to blacklist and comments it'll
be handled by f81504-core.c

Thanks
--=20
With Best Regards,
Peter Hung
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
