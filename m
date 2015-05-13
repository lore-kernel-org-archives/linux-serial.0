From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v2] sc16is7xx: spi interface is added
Date: Wed, 13 May 2015 14:21:12 +0200
Message-ID: <20150513142112.32fb6781@north>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: "ram.i hcltech" <indrakanti_ram@hotmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org, indrakanti.ram@gmail.com
List-Id: linux-serial@vger.kernel.org

On Wed, 13 May 2015 16:27:58 +0530, ram.i hcltech wrote:
> spi interface for sc16is7xx is added along with Kconfig flag
> to enable spi or i2c, thus in a instance we can have either
> spi or i2c or both, in sync to the hw.
> 
> Signed-off-by: ram.i hcltech <indrakanti_ram@hotmail.com>
> ---
> 
> Changes in v2:
>  -Added seprate flags for i2c and spi
>  -Added space in the comments lines
>  -Added MODULE_ALIAS for spi interface
> ---
>  drivers/tty/serial/Kconfig     | 27 +++++++++++++++--
>  drivers/tty/serial/sc16is7xx.c | 69 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f8120c1..8c505b2 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1181,13 +1181,34 @@ config SERIAL_SCCNXP_CONSOLE
>  
>  config SERIAL_SC16IS7XX
>  	tristate "SC16IS7xx serial support"
> -	depends on I2C

Please keep the dependency like this:
depends on I2C || SPI_MASTER

(or SPI, I don't know what's the difference. SPI seems fine.)

>  	select SERIAL_CORE
> -	select REGMAP_I2C if I2C
>  	help
>  	  This selects support for SC16IS7xx serial ports.
>  	  Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
> -	  SC16IS760 and SC16IS762.
> +	  SC16IS760 and SC16IS762, over i2c or spi.
> +	  select at least one of the i2c or spi interface.

I would phrase the help message like this:

This selects support for SC16IS7xx serial ports.
Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
SC16IS760 and SC16IS762. Select supported buses using options below.

> +config SERIAL_SC16IS7XX_I2C
> +	bool "SC16IS7xx for I2C interface"

Please add "default y" to minimize oldconfig pain for those already
using the driver.

> +	depends on SERIAL_SC16IS7XX=y

Why =y?

> +	depends on I2C
> +	select REGMAP_I2C if I2C
> +	help
> +	  to enable i2c interface for SC16IS7XX, say Y,
> +	  Otherwise, for i2c say N.
> +	  this would make the driver to interface over SPI and I2C would
> +	  be diabled.

I would phrase it simply like this:

Enable SC16IS7xx driver on I2C bus.

> +config SERIAL_SC16IS7XX_SPI
> +	bool "SC16IS7xx for spi interface"
> +	depends on SERIAL_SC16IS7XX
> +	depends on SPI_MASTER

Right now it is possible to select the driver without any bus-specific
option being set.  I don't see an easy way to avoid this but please
make sure that there are no build failures/warnings in this scenario.

You should also extend the binding information to include the new SPI
interface (Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt)


Thanks!
