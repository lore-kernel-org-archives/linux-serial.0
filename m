From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [PATCH 03/14] watchdog: pnx4008_wdt: allow compile-testing
Date: Mon, 5 Aug 2019 08:42:58 -0400
Message-ID: <CA+rxa6oOxHH20Oiw1BKqa+9QF+J+M2cnQgMRKkLuxjcm9Ux2uQ@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731195713.3150463-4-arnd@arndb.de>
 <20190731202343.GA14817@roeck-us.net> <CAK8P3a2=gqeCMtdzdqg4d1n6v1-cdaHObeUoVXeB+=Okwd1rqA@mail.gmail.com>
 <20190731203646.GB14817@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190731203646.GB14817@roeck-us.net>
Sender: netdev-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Wed, Jul 31, 2019 at 4:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Jul 31, 2019 at 10:26:35PM +0200, Arnd Bergmann wrote:
> > On Wed, Jul 31, 2019 at 10:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Wed, Jul 31, 2019 at 09:56:45PM +0200, Arnd Bergmann wrote:
> > > > The only thing that prevents building this driver on other
> > > > platforms is the mach/hardware.h include, which is not actually
> > > > used here at all, so remove the line and allow CONFIG_COMPILE_TEST.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > What is the plan for this patch ? Push through watchdog
> > > or through your branch ?
> >
> > I would prefer my branch so I can apply the final patch without waiting
> > for another release. Not in a hurry though, so if some other maintainer
>
> Ok with me.
>
> Guenter
