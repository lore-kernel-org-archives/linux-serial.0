From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/14] ARM: move lpc32xx and dove to multiplatform
Date: Thu, 15 Aug 2019 21:38:46 +0200
Message-ID: <CAK8P3a3ry0S-yhE75hZx1SawYuVzY=NgnNBei101F6+HxBfE3g@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731225303.GC1330@shell.armlinux.org.uk>
 <CAK8P3a1Lgbz9RwVaOgNq=--gwvEG70tUi67XwsswjgnXAX6EhA@mail.gmail.com>
 <CAK8P3a0=GrjM_HOBgqy5V3pOsA6w1EDOtEQO9dZG2Cw+-2niaw@mail.gmail.com> <b43c3d60-b675-442c-c549-25530cfbffe3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b43c3d60-b675-442c-c549-25530cfbffe3@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, SoC Team <soc@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 15, 2019 at 8:32 PM Sylvain Lemieux <slemieux.tyco@gmail.com> wrote:
> On 8/15/19 9:11 AM, Arnd Bergmann wrote:
> > On Thu, Aug 1, 2019 at 9:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I applied patches 12 and 13 into the soc tree now. There are some
> > other pending multiplatform conversions (iop32x, ep93xx, lpc32xx,
> > omap1), but it looks like none of those will be complete for 5.4.
>
> I think the patchset (v2) for the LPC32xx is ready for 5.4
> ([PATCH v2 00/13] v2: ARM: move lpc32xx to multiplatform)

Good point. I've merged these into the arm/soc branch now.

     Arnd
