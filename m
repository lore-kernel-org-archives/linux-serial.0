From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/14] serial: lpc32xx: allow compile testing
Date: Thu, 1 Aug 2019 07:59:06 +0200
Message-ID: <20190801055906.GD24607@kroah.com>
References: <20190731195713.3150463-1-arnd@arndb.de>
 <20190731195713.3150463-10-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190731195713.3150463-10-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 31, 2019 at 09:56:51PM +0200, Arnd Bergmann wrote:
> The lpc32xx_loopback_set() function in hte lpc32xx_hs driver is the
> one thing that relies on platform header files. Move that into the
> core platform code so we only need a variable declaration for it,
> and enable COMPILE_TEST building.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-lpc32xx/serial.c       | 30 ++++++++++++++++++++++++
>  drivers/tty/serial/lpc32xx_hs.c      | 35 ++++------------------------
>  include/linux/soc/nxp/lpc32xx-misc.h |  4 ++++
>  3 files changed, 38 insertions(+), 31 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
