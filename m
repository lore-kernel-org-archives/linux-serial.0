From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 08/14] net: lpc-enet: allow compile testing
Date: Tue, 6 Aug 2019 16:13:58 -0400
Message-ID: <CA+rxa6ovZ+ghiHyGQXepx0pEo465WHEP3TJq+dcnZyx2weE0uw@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-9-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731195713.3150463-9-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Linux
List-Id: linux-serial@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Wed, Jul 31, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The lpc-enet driver can now be built on all platforms, so
> allow compile testing as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/nxp/Kconfig   | 2 +-
>  drivers/net/ethernet/nxp/lpc_eth.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/nxp/Kconfig b/drivers/net/ethernet/nxp/Kconfig
> index 261f107e2be0..418afb84c84b 100644
> --- a/drivers/net/ethernet/nxp/Kconfig
> +++ b/drivers/net/ethernet/nxp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config LPC_ENET
>          tristate "NXP ethernet MAC on LPC devices"
> -        depends on ARCH_LPC32XX
> +        depends on ARCH_LPC32XX || COMPILE_TEST
>          select PHYLIB
>          help
>           Say Y or M here if you want to use the NXP ethernet MAC included on
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> index 0893b77c385d..34fdf2100772 100644
> --- a/drivers/net/ethernet/nxp/lpc_eth.c
> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> @@ -14,6 +14,7 @@
>  #include <linux/crc32.h>
>  #include <linux/etherdevice.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/phy.h>
>  #include <linux/platform_device.h>
> --
> 2.20.0
>
