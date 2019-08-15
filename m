From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/14] ARM: move lpc32xx and dove to multiplatform
Date: Thu, 15 Aug 2019 15:11:25 +0200
Message-ID: <CAK8P3a0=GrjM_HOBgqy5V3pOsA6w1EDOtEQO9dZG2Cw+-2niaw@mail.gmail.com>
References: <20190731195713.3150463-1-arnd@arndb.de> <20190731225303.GC1330@shell.armlinux.org.uk>
 <CAK8P3a1Lgbz9RwVaOgNq=--gwvEG70tUi67XwsswjgnXAX6EhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1Lgbz9RwVaOgNq=--gwvEG70tUi67XwsswjgnXAX6EhA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: SoC Team <soc@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Guenter Roeck <linux@roeck-us.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 1, 2019 at 9:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 1, 2019 at 12:53 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 31, 2019 at 09:56:42PM +0200, Arnd Bergmann wrote:
> > > For dove, the patches are basically what I had proposed back in
> > > 2015 when all other ARMv6/ARMv7 machines became part of a single
> > > kernel build. I don't know what the state is mach-dove support is,
> > > compared to the DT based support in mach-mvebu for the same
> > > hardware. If they are functionally the same, we could also just
> > > remove mach-dove rather than applying my patches.
> >
> > Well, the good news is that I'm down to a small board support file
> > for the Dove Cubox now - but the bad news is, that there's still a
> > board support file necessary to support everything the Dove SoC has
> > to offer.
> >
> > Even for a DT based Dove Cubox, I'm still using mach-dove, but it
> > may be possible to drop most of mach-dove now.  Without spending a
> > lot of time digging through it, it's impossible to really know.
>
> Ok, so we won't remove it then, but I'd like to merge my patches to
> at least get away from the special case of requiring a separate kernel
> image for it.
>
> Can you try if applying patches 12 and 14 from my series causes
> problems for you? (it may be easier to apply the entire set
> or pull from [1] to avoid rebase conflicts).

I applied patches 12 and 13 into the soc tree now. There are some
other pending multiplatform conversions (iop32x, ep93xx, lpc32xx,
omap1), but it looks like none of those will be complete for 5.4.

I now expect that we can get most of the preparation into 5.4,
and maybe move them all over together in 5.5 after some more
testing. If someone finds a problem with the one of the
preparation steps, that we can revert the individual patches
more easily.

      Arnd
