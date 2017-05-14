From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH 2/8] gpio: exar: Fix passing in of parent PCI device
Date: Sun, 14 May 2017 10:11:13 +0200
Message-ID: <4a38292e-3340-dfb4-8a61-114fccf42958@web.de>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
 <20f1d241d134f9f4932a26e4bd873ffc250affce.1494660546.git.jan.kiszka@siemens.com>
 <CAHp75VfCd4feKeHOe4QMM88nMQ5wnP4yk7iDJMXN7LcygXVObw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gSeuwje7c53Xq1wE51RGMWX7vvfCnEdFV"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfCd4feKeHOe4QMM88nMQ5wnP4yk7iDJMXN7LcygXVObw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gSeuwje7c53Xq1wE51RGMWX7vvfCnEdFV
Content-Type: multipart/mixed; boundary="SXB1sGjAtKpwFloFfmeGcV875JNBWKWtj";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>
Message-ID: <4a38292e-3340-dfb4-8a61-114fccf42958@web.de>
Subject: Re: [PATCH 2/8] gpio: exar: Fix passing in of parent PCI device
References: <cover.1494660546.git.jan.kiszka@siemens.com>
 <20f1d241d134f9f4932a26e4bd873ffc250affce.1494660546.git.jan.kiszka@siemens.com>
 <CAHp75VfCd4feKeHOe4QMM88nMQ5wnP4yk7iDJMXN7LcygXVObw@mail.gmail.com>
In-Reply-To: <CAHp75VfCd4feKeHOe4QMM88nMQ5wnP4yk7iDJMXN7LcygXVObw@mail.gmail.com>

--SXB1sGjAtKpwFloFfmeGcV875JNBWKWtj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-05-13 15:25, Andy Shevchenko wrote:
> On Sat, May 13, 2017 at 10:29 AM, Jan Kiszka <jan.kiszka@siemens.com> w=
rote:
>> This fixes reloading of the driver for the same device: First of all,
>> the driver sets drvdata to its own value during probing and does not
>> restore the original value on exit. But this won't help anyway as the
>> core clears drvdata after the driver left.
>>
>> Use stable platform_data instead.
>=20
>>From the above I didn't clearly get what device you are talking about.
> GPIO?

"This fixes reloading of the GPIO driver for the same platform device
instance as created by the exar UART driver: [...]"

Clearer?

>=20
> Can you provide step by step what you did and what bug you got?

Obviously a NULL pointer: Just rmmod gpio-exar and reload it while there
is the same platform device present.

>=20
> Regarding below it looks to me a bit hackish.

The alternative is a classic platform data structure, then also carrying
the properties of patch 7 - which are, BTW, not DT-related, thus shall
not form an external interface. Probably another reason to switch
everything to some struct exar_gpio_platform_data.

Jan

>=20
>>  static int gpio_exar_probe(struct platform_device *pdev)
>>  {
>> -       struct pci_dev *pcidev =3D platform_get_drvdata(pdev);
>> +       struct pci_dev *pcidev =3D *(struct pci_dev **)pdev->dev.platf=
orm_data;
>>         struct exar_gpio_chip *exar_gpio;
>>         void __iomem *p;
>>         int index, ret;
>> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/=
8250/8250_exar.c
>> index b4fa585156c7..2d056d1eeca3 100644
>> --- a/drivers/tty/serial/8250/8250_exar.c
>> +++ b/drivers/tty/serial/8250/8250_exar.c
>> @@ -196,8 +196,12 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
>>         if (!pdev)
>>                 return NULL;
>>
>> -       platform_set_drvdata(pdev, pcidev);
>> -       if (platform_device_add(pdev) < 0) {
>> +       /*
>> +        * platform_device_add_data kmemdups the data, therefore we ca=
n safely
>> +        * pass a stack reference.
>> +        */
>> +       if (platform_device_add_data(pdev, &pcidev, sizeof(pcidev)) < =
0 ||
>> +           platform_device_add(pdev) < 0) {
>>                 platform_device_put(pdev);
>>                 return NULL;
>=20



--SXB1sGjAtKpwFloFfmeGcV875JNBWKWtj--

--gSeuwje7c53Xq1wE51RGMWX7vvfCnEdFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkYEScACgkQitSsb3rl5xTsxQCfWbk+didwvuQC+6zRp8P2bGM6
DrgAoOXvJrYFN/UoCcK61vFtEIq9RQBV
=pCkE
-----END PGP SIGNATURE-----

--gSeuwje7c53Xq1wE51RGMWX7vvfCnEdFV--
