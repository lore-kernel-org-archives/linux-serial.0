From: ram kiran <indrakanti_ram@hotmail.com>
Subject: RE: [PATCH v2] sc16is7xx: spi interface is added
Date: Wed, 13 May 2015 17:09:59 +0530
Message-ID: <SNT151-W59A9C5ADDA1491FE7C422EE7D90@phx.gbl>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: =?iso-8859-2?B?SmFrdWIgS2ljafFza2k=?= <moorray3@wp.pl>, "indrakanti.ram@gmail.com" <indrakanti.ram@gmail.com>
List-Id: linux-serial@vger.kernel.org

not sure why is not available on mailing list...

----------------------------------------
> From: indrakanti_ram@hotmail.com
> To: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; jslaby@suse.cz; gregkh@linuxfoundation.org
> CC: moorray3@wp.pl; indrakanti.ram@gmail.com; indrakanti_ram@hotmail.com
> Subject: [PATCH v2] sc16is7xx: spi interface is added
> Date: Wed, 13 May 2015 16:27:58 +0530
>
> spi interface for sc16is7xx is added along with Kconfig flag
> to enable spi or i2c, thus in a instance we can have either
> spi or i2c or both, in sync to the hw.
>
> Signed-off-by: ram.i hcltech <indrakanti_ram@hotmail.com>
> ---
>
> Changes in v2:
> -Added seprate flags for i2c and spi
> -Added space in the comments lines
> -Added MODULE_ALIAS for spi interface
> ---
> drivers/tty/serial/Kconfig | 27 +++++++++++++++--
> drivers/tty/serial/sc16is7xx.c | 69 +++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 92 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index f8120c1..8c505b2 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1181,13 +1181,34 @@ config SERIAL_SCCNXP_CONSOLE
>
> config SERIAL_SC16IS7XX
> tristate "SC16IS7xx serial support"
> - depends on I2C
> select SERIAL_CORE
> - select REGMAP_I2C if I2C
> help
> This selects support for SC16IS7xx serial ports.
> Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
> - SC16IS760 and SC16IS762.
> + SC16IS760 and SC16IS762, over i2c or spi.
> + select at least one of the i2c or spi interface.
> +
> +config SERIAL_SC16IS7XX_I2C
> + bool "SC16IS7xx for I2C interface"
> + depends on SERIAL_SC16IS7XX=y
> + depends on I2C
> + select REGMAP_I2C if I2C
> + help
> + to enable i2c interface for SC16IS7XX, say Y,
> + Otherwise, for i2c say N.
> + this would make the driver to interface over SPI and I2C would
> + be diabled.
> +
> +config SERIAL_SC16IS7XX_SPI
> + bool "SC16IS7xx for spi interface"
> + depends on SERIAL_SC16IS7XX
> + depends on SPI_MASTER
> + select REGMAP_SPI if SPI_MASTER
> + help
> + to enable spi interface for SC16IS7XX, say Y,
> + Otherwise, for i2c say N.
> + this would make the driver to interface over SPI and I2C would
> + be diabled.
>
> config SERIAL_BFIN_SPORT
> tristate "Blackfin SPORT emulate UART"
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 468354e..ca6a838 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -25,6 +25,7 @@
> #include <linux/serial.h>
> #include <linux/tty.h>
> #include <linux/tty_flip.h>
> +#include <linux/spi/spi.h>
> #include <linux/uaccess.h>
>
> #define SC16IS7XX_NAME "sc16is7xx"
> @@ -1203,7 +1204,73 @@ static struct regmap_config regcfg = {
> .volatile_reg = sc16is7xx_regmap_volatile,
> .precious_reg = sc16is7xx_regmap_precious,
> };
> +#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
> +static int sc16is7xx_spi_probe(struct spi_device *spi)
> +{
> + struct sc16is7xx_devtype *devtype;
> + unsigned long flags = 0;
> + struct regmap *regmap;
> + int ret;
> +
> + /* Setup SPI bus */
> + spi->bits_per_word = 8;
> + /* only supports mode 0 on SC16IS762 */
> + spi->mode = spi->mode ? : SPI_MODE_0;
> + spi->max_speed_hz = spi->max_speed_hz ? : 15000000;
> + ret = spi_setup(spi);
> + if (ret)
> + return ret;
> +
> + if (spi->dev.of_node) {
> + const struct of_device_id *of_id =
> + of_match_device(sc16is7xx_dt_ids, &spi->dev);
> +
> + devtype = (struct sc16is7xx_devtype *)of_id->data;
> + } else {
> + const struct spi_device_id *id_entry = spi_get_device_id(spi);
> +
> + devtype = (struct sc16is7xx_devtype *)id_entry->driver_data;
> + flags = IRQF_TRIGGER_FALLING;
> + }
> +
> + regcfg.max_register = (0xf << SC16IS7XX_REG_SHIFT) |
> + (devtype->nr_uart - 1);
> + regmap = devm_regmap_init_spi(spi, &regcfg);
> +
> + return sc16is7xx_probe(&spi->dev, devtype, regmap, spi->irq, flags);
> +}
> +
> +static int sc16is7xx_spi_remove(struct spi_device *spi)
> +{
> + return sc16is7xx_remove(&spi->dev);
> +}
>
> +static const struct spi_device_id sc16is7xx_spi_id_table[] = {
> + { "sc16is74x", (kernel_ulong_t)&sc16is74x_devtype, },
> + { "sc16is750", (kernel_ulong_t)&sc16is750_devtype, },
> + { "sc16is752", (kernel_ulong_t)&sc16is752_devtype, },
> + { "sc16is760", (kernel_ulong_t)&sc16is760_devtype, },
> + { "sc16is762", (kernel_ulong_t)&sc16is762_devtype, },
> + { }
> +};
> +
> +MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
> +
> +static struct spi_driver sc16is7xx_spi_uart_driver = {
> + .driver = {
> + .name = SC16IS7XX_NAME,
> + .owner = THIS_MODULE,
> + .of_match_table = of_match_ptr(sc16is7xx_dt_ids),
> + },
> + .probe = sc16is7xx_spi_probe,
> + .remove = sc16is7xx_spi_remove,
> + .id_table = sc16is7xx_spi_id_table,
> +};
> +module_spi_driver(sc16is7xx_spi_uart_driver);
> +MODULE_ALIAS("spi:sc16is7xx");
> +#endif
> +
> +#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
> static int sc16is7xx_i2c_probe(struct i2c_client *i2c,
> const struct i2c_device_id *id)
> {
> @@ -1255,7 +1322,7 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
> };
> module_i2c_driver(sc16is7xx_i2c_uart_driver);
> MODULE_ALIAS("i2c:sc16is7xx");
> -
> +#endif
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("Jon Ringle <jringle@gridpoint.com>");
> MODULE_DESCRIPTION("SC16IS7XX serial driver");
> --
> 1.9.1
>
 		 	   		  