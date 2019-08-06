From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 07/14] net: lpc-enet: move phy setup into platform code
Date: Tue, 6 Aug 2019 16:12:54 -0400
Message-ID: <CA+rxa6pZ7RLAOR1AQqdcNWxvk8dyoMR586n0d2e_b8SHU-jyWA@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-8-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-8-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux
List-Id: linux-serial@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Wed, Jul 31, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Setting the phy mode requires touching a platform specific
> register, which prevents us from building the driver without
> its header files.
>
> Move it into a separate function in arch/arm/mach/lpc32xx
> to hide the core registers from the network driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-lpc32xx/common.c       | 12 ++++++++++++
>  drivers/net/ethernet/nxp/lpc_eth.c   | 12 +-----------
>  include/linux/soc/nxp/lpc32xx-misc.h |  5 +++++
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
> index f648324d5fb4..a475339333c1 100644
> --- a/arch/arm/mach-lpc32xx/common.c
> +++ b/arch/arm/mach-lpc32xx/common.c
> @@ -63,6 +63,18 @@ u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
>  }
>  EXPORT_SYMBOL_GPL(lpc32xx_return_iram);
>
> +void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
> +{
> +       u32 tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
> +       tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
> +       if (mode == PHY_INTERFACE_MODE_MII)
> +               tmp |= LPC32XX_CLKPWR_MACCTRL_USE_MII_PINS;
> +       else
> +               tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
> +       __raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
> +}
> +EXPORT_SYMBOL_GPL(lpc32xx_set_phy_interface_mode);
> +
>  static struct map_desc lpc32xx_io_desc[] __initdata = {
>         {
>                 .virtual        = (unsigned long)IO_ADDRESS(LPC32XX_AHB0_START),
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> index bcdd0adcfb0c..0893b77c385d 100644
> --- a/drivers/net/ethernet/nxp/lpc_eth.c
> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> @@ -20,9 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/soc/nxp/lpc32xx-misc.h>
>
> -#include <mach/hardware.h>
> -#include <mach/platform.h>
> -
>  #define MODNAME "lpc-eth"
>  #define DRV_VERSION "1.00"
>
> @@ -1237,16 +1234,9 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
>         dma_addr_t dma_handle;
>         struct resource *res;
>         int irq, ret;
> -       u32 tmp;
>
>         /* Setup network interface for RMII or MII mode */
> -       tmp = __raw_readl(LPC32XX_CLKPWR_MACCLK_CTRL);
> -       tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
> -       if (lpc_phy_interface_mode(dev) == PHY_INTERFACE_MODE_MII)
> -               tmp |= LPC32XX_CLKPWR_MACCTRL_USE_MII_PINS;
> -       else
> -               tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
> -       __raw_writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL);
> +       lpc32xx_set_phy_interface_mode(lpc_phy_interface_mode(dev));
>
>         /* Get platform resources */
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> diff --git a/include/linux/soc/nxp/lpc32xx-misc.h b/include/linux/soc/nxp/lpc32xx-misc.h
> index f232e1a1bcdc..af4f82f6cf3b 100644
> --- a/include/linux/soc/nxp/lpc32xx-misc.h
> +++ b/include/linux/soc/nxp/lpc32xx-misc.h
> @@ -9,9 +9,11 @@
>  #define __SOC_LPC32XX_MISC_H
>
>  #include <linux/types.h>
> +#include <linux/phy.h>
>
>  #ifdef CONFIG_ARCH_LPC32XX
>  extern u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr);
> +extern void lpc32xx_set_phy_interface_mode(phy_interface_t mode);
>  #else
>  static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaaddr)
>  {
> @@ -19,6 +21,9 @@ static inline u32 lpc32xx_return_iram(void __iomem **mapbase, dma_addr_t *dmaadd
>         *dmaaddr = 0;
>         return 0;
>  }
> +static inline void lpc32xx_set_phy_interface_mode(phy_interface_t mode)
> +{
> +}
>  #endif
>
>  #endif  /* __SOC_LPC32XX_MISC_H */
> --
> 2.20.0
>
