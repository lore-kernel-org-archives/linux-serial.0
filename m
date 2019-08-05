From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 04/14] serial: lpc32xx_hs: allow compile-testing
Date: Mon, 5 Aug 2019 08:43:44 -0400
Message-ID: <CA+rxa6oU65QeEDaROdz1v=5R6m4YKTd7rRNEBx41d5uixyoz=g@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-5-arnd@arndb.de>
 <20190801055840.GC24607@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190801055840.GC24607@kroah.com>
Sender: netdev-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>Linu
List-Id: linux-serial@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Thu, Aug 1, 2019 at 1:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 31, 2019 at 09:56:46PM +0200, Arnd Bergmann wrote:
> > The only thing that prevents building this driver on other
> > platforms is the mach/hardware.h include, which is not actually
> > used here at all, so remove the line and allow CONFIG_COMPILE_TEST.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/tty/serial/Kconfig      | 3 ++-
> >  drivers/tty/serial/lpc32xx_hs.c | 2 --
> >  2 files changed, 2 insertions(+), 3 deletions(-)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
