From: ram kiran <indrakanti_ram@hotmail.com>
Subject: RE: [PATCH v2] sc16is7xx: spi interface is added
Date: Thu, 14 May 2015 14:45:47 +0530
Message-ID: <SNT151-W14BC72C1F2CACF46C6BF1FE7D80@phx.gbl>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>,<20150513142112.32fb6781@north>,<SNT151-W2631587836D659058C19A7E7D80@phx.gbl>,<20150514100316.75e23c2f@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514100316.75e23c2f@north>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-2?B?SmFrdWIgS2ljafFza2k=?= <moorray3@wp.pl>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "indrakanti.ram@gmail.com" <indrakanti.ram@gmail.com>
List-Id: linux-serial@vger.kernel.org

> On Thu, 14 May 2015 13:16:20 +0530, ram kiran wrote:
>>> On Wed, 13 May 2015 16:27:58 +0530, ram.i hcltech wrote:
>>>> spi interface for sc16is7xx is added along with Kconfig flag
>>>> to enable spi or i2c, thus in a instance we can have either
>>>> spi or i2c or both, in sync to the hw.
>>>>
>>>> Signed-off-by: ram.i hcltech <indrakanti_ram@hotmail.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> -Added seprate flags for i2c and spi
>>>> -Added space in the comments lines
>>>> -Added MODULE_ALIAS for spi interface
>>>> ---
>>>> drivers/tty/serial/Kconfig | 27 +++++++++++++++--
>>>> drivers/tty/serial/sc16is7xx.c | 69 +++++++++++++++++++++++++++++++++++++++++-
>>>> 2 files changed, 92 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>>> index f8120c1..8c505b2 100644
>>>> --- a/drivers/tty/serial/Kconfig
>>>> +++ b/drivers/tty/serial/Kconfig
>>>> @@ -1181,13 +1181,34 @@ config SERIAL_SCCNXP_CONSOLE
>>>>
>> To avoid error or warning on build, i think this would be the probable solution.
>> I thinking to go with this, any comments on this please.
>>
>> config SERIAL_SC16IS7XX
>>     bool
>>
>> config SERIAL_SC16IS7XX_SELECT
>>     tristate "SC16IS7xx serial support"
>>     select SERIAL_CORE
>>     depends on I2C || SPI_MASTER
>>     select REGMAP_I2C if I2C
>>     select REGMAP_SPI if SPI_MASTER
>>     help
>>       This selects support for SC16IS7xx serial ports.
>>       Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
>>       SC16IS760 and SC16IS762. Select supported buses using options below.
>>
>> config SERIAL_SC16IS7XX_I2C
>>     bool "SC16IS7xx for I2C interface"
>>     depends on SERIAL_SC16IS7XX_SELECT
>>     select SERIAL_SC16IS7XX
>>     default y
>>     help
>>       Enable SC16IS7xx driver on I2C bus.
>>
>> config SERIAL_SC16IS7XX_SPI
>>     bool "SC16IS7xx for spi interface"
>>     depends on SERIAL_SC16IS7XX_SELECT
>>     select SERIAL_SC16IS7XX
>>     help
>>       Enable SC16IS7xx driver on SPI bus.
>>
>
> This looks quite elegant! Should we aslo make SERIAL_SC16IS7XX depend
> on SERIAL_SC16IS7XX_I2C || SERIAL_SC16IS7XX_SPI? Would that work?
>
This would be additional protection, need to check if that is too much to do or would be good to go.

> I know little about kbuild but I'm worried that someone doing oldconfig
> can still get SERIAL_SC16IS7XX selected while saying no to all the
> others.
>
> Other option would be to swap the names between SERIAL_SC16IS7XX and
> SERIAL_SC16IS7XX_SELECT, oldconfig would run smoother.
I think, with the above, there would need a configuration change for sure.
It should be okay, as I2C is default Y.

Swap names would need Makefile changes, i was just thinking to avoid this.
obj-$(CONFIG_SERIAL_SC16IS7XX) += sc16is7xx.o
would be 
obj-$(CONFIG_SERIAL_SC16IS7XX_SELECT) += sc16is7xx.o

I think its some that need not be there. Do suggest..

Thanks


>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  