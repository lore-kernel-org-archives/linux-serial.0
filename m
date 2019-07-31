From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 00/14] ARM: move lpc32xx and dove to multiplatform
Date: Wed, 31 Jul 2019 23:53:04 +0100
Message-ID: <20190731225303.GC1330@shell.armlinux.org.uk>
References: <20190731195713.3150463-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190731195713.3150463-1-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 31, 2019 at 09:56:42PM +0200, Arnd Bergmann wrote:
> For dove, the patches are basically what I had proposed back in
> 2015 when all other ARMv6/ARMv7 machines became part of a single
> kernel build. I don't know what the state is mach-dove support is,
> compared to the DT based support in mach-mvebu for the same
> hardware. If they are functionally the same, we could also just
> remove mach-dove rather than applying my patches.

Well, the good news is that I'm down to a small board support file
for the Dove Cubox now - but the bad news is, that there's still a
board support file necessary to support everything the Dove SoC has
to offer.

Even for a DT based Dove Cubox, I'm still using mach-dove, but it
may be possible to drop most of mach-dove now.  Without spending a
lot of time digging through it, it's impossible to really know.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
