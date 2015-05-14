From: ram kiran <indrakanti_ram@hotmail.com>
Subject: RE: [PATCH v2] sc16is7xx: spi interface is added
Date: Thu, 14 May 2015 13:16:20 +0530
Message-ID: <SNT151-W2631587836D659058C19A7E7D80@phx.gbl>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>,<20150513142112.32fb6781@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150513142112.32fb6781@north>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-2?B?SmFrdWIgS2ljafFza2k=?= <moorray3@wp.pl>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "indrakanti.ram@gmail.com" <indrakanti.ram@gmail.com>
List-Id: linux-serial@vger.kernel.org

> On Wed, 13 May 2015 16:27:58 +0530, ram.i hcltech wrote:
>> spi interface for sc16is7xx is added along with Kconfig flag
>> to enable spi or i2c, thus in a instance we can have either
>> spi or i2c or both, in sync to the hw.
>>
>> Signed-off-by: ram.i hcltech <indrakanti_ram@hotmail.com>
>> ---
>>
>> Changes in v2:
>> -Added seprate flags for i2c and spi
>> -Added space in the comments lines
>> -Added MODULE_ALIAS for spi interface
>> ---
>> drivers/tty/serial/Kconfig | 27 +++++++++++++++--
>> drivers/tty/serial/sc16is7xx.c | 69 ++++++++++++++++++++++++++++++++=
+++++++++-
>> 2 files changed, 92 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index f8120c1..8c505b2 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1181,13 +1181,34 @@ config SERIAL_SCCNXP_CONSOLE
>>
To avoid error or warning on build, i think this would be the probable =
solution.
I thinking to go with this, any comments on this please.

config SERIAL_SC16IS7XX
=A0=A0=A0 bool

config SERIAL_SC16IS7XX_SELECT
=A0=A0=A0 tristate "SC16IS7xx serial support"
=A0=A0=A0 select SERIAL_CORE
=A0=A0=A0 depends on I2C || SPI_MASTER
=A0=A0=A0 select REGMAP_I2C if I2C
=A0=A0=A0 select REGMAP_SPI if SPI_MASTER
=A0=A0=A0 help
=A0=A0=A0 =A0 This selects support for SC16IS7xx serial ports.
=A0=A0=A0 =A0 Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS=
752,
=A0=A0=A0 =A0 SC16IS760 and SC16IS762. Select supported buses using opt=
ions below.

config SERIAL_SC16IS7XX_I2C
=A0=A0=A0 bool "SC16IS7xx for I2C interface"
=A0=A0=A0 depends on SERIAL_SC16IS7XX_SELECT
=A0=A0=A0 select SERIAL_SC16IS7XX
=A0=A0=A0 default y
=A0=A0=A0 help
=A0=A0=A0 =A0 Enable SC16IS7xx driver on I2C bus.

config SERIAL_SC16IS7XX_SPI
=A0=A0=A0 bool "SC16IS7xx for spi interface"
=A0=A0=A0 depends on SERIAL_SC16IS7XX_SELECT
=A0=A0=A0 select SERIAL_SC16IS7XX
=A0=A0=A0 help
=A0=A0=A0 =A0 Enable SC16IS7xx driver on SPI bus.



>> config SERIAL_SC16IS7XX
>> tristate "SC16IS7xx serial support"
>> - depends on I2C
>
> Please keep the dependency like this:
> depends on I2C || SPI_MASTER
>
> (or SPI, I don't know what's the difference. SPI seems fine.)
>
>> select SERIAL_CORE
>> - select REGMAP_I2C if I2C
>> help
>> This selects support for SC16IS7xx serial ports.
>> Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
>> - SC16IS760 and SC16IS762.
>> + SC16IS760 and SC16IS762, over i2c or spi.
>> + select at least one of the i2c or spi interface.
>
> I would phrase the help message like this:
>
> This selects support for SC16IS7xx serial ports.
> Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
> SC16IS760 and SC16IS762. Select supported buses using options below.
>
>> +config SERIAL_SC16IS7XX_I2C
>> + bool "SC16IS7xx for I2C interface"
>
> Please add "default y" to minimize oldconfig pain for those already
> using the driver.
>
>> + depends on SERIAL_SC16IS7XX=3Dy
>
> Why =3Dy?
>
>> + depends on I2C
>> + select REGMAP_I2C if I2C
>> + help
>> + to enable i2c interface for SC16IS7XX, say Y,
>> + Otherwise, for i2c say N.
>> + this would make the driver to interface over SPI and I2C would
>> + be diabled.
>
> I would phrase it simply like this:
>
> Enable SC16IS7xx driver on I2C bus.
>
>> +config SERIAL_SC16IS7XX_SPI
>> + bool "SC16IS7xx for spi interface"
>> + depends on SERIAL_SC16IS7XX
>> + depends on SPI_MASTER
>
> Right now it is possible to select the driver without any bus-specifi=
c
> option being set. I don't see an easy way to avoid this but please
> make sure that there are no build failures/warnings in this scenario.
>
> You should also extend the binding information to include the new SPI
> interface (Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt=
)
>
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
