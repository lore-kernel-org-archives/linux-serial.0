From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v2] sc16is7xx: spi interface is added
Date: Thu, 14 May 2015 10:03:16 +0200
Message-ID: <20150514100316.75e23c2f@north>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
	<20150513142112.32fb6781@north>
	<SNT151-W2631587836D659058C19A7E7D80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SNT151-W2631587836D659058C19A7E7D80@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: ram kiran <indrakanti_ram@hotmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "indrakanti.ram@gmail.com" <indrakanti.ram@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 14 May 2015 13:16:20 +0530, ram kiran wrote:
> > On Wed, 13 May 2015 16:27:58 +0530, ram.i hcltech wrote:
> >> spi interface for sc16is7xx is added along with Kconfig flag
> >> to enable spi or i2c, thus in a instance we can have either
> >> spi or i2c or both, in sync to the hw.
> >>
> >> Signed-off-by: ram.i hcltech <indrakanti_ram@hotmail.com>
> >> ---
> >>
> >> Changes in v2:
> >> -Added seprate flags for i2c and spi
> >> -Added space in the comments lines
> >> -Added MODULE_ALIAS for spi interface
> >> ---
> >> drivers/tty/serial/Kconfig | 27 +++++++++++++++--
> >> drivers/tty/serial/sc16is7xx.c | 69 ++++++++++++++++++++++++++++++=
+++++++++++-
> >> 2 files changed, 92 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconf=
ig
> >> index f8120c1..8c505b2 100644
> >> --- a/drivers/tty/serial/Kconfig
> >> +++ b/drivers/tty/serial/Kconfig
> >> @@ -1181,13 +1181,34 @@ config SERIAL_SCCNXP_CONSOLE
> >>
> To avoid error or warning on build, i think this would be the probabl=
e solution.
> I thinking to go with this, any comments on this please.
>=20
> config SERIAL_SC16IS7XX
> =C2=A0=C2=A0=C2=A0 bool
>=20
> config SERIAL_SC16IS7XX_SELECT
> =C2=A0=C2=A0=C2=A0 tristate "SC16IS7xx serial support"
> =C2=A0=C2=A0=C2=A0 select SERIAL_CORE
> =C2=A0=C2=A0=C2=A0 depends on I2C || SPI_MASTER
> =C2=A0=C2=A0=C2=A0 select REGMAP_I2C if I2C
> =C2=A0=C2=A0=C2=A0 select REGMAP_SPI if SPI_MASTER
> =C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0 =C2=A0 This selects support for SC16IS7xx serial p=
orts.
> =C2=A0=C2=A0=C2=A0 =C2=A0 Supported ICs are SC16IS740, SC16IS741, SC1=
6IS750, SC16IS752,
> =C2=A0=C2=A0=C2=A0 =C2=A0 SC16IS760 and SC16IS762. Select supported b=
uses using options below.
>=20
> config SERIAL_SC16IS7XX_I2C
> =C2=A0=C2=A0=C2=A0 bool "SC16IS7xx for I2C interface"
> =C2=A0=C2=A0=C2=A0 depends on SERIAL_SC16IS7XX_SELECT
> =C2=A0=C2=A0=C2=A0 select SERIAL_SC16IS7XX
> =C2=A0=C2=A0=C2=A0 default y
> =C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0 =C2=A0 Enable SC16IS7xx driver on I2C bus.
>=20
> config SERIAL_SC16IS7XX_SPI
> =C2=A0=C2=A0=C2=A0 bool "SC16IS7xx for spi interface"
> =C2=A0=C2=A0=C2=A0 depends on SERIAL_SC16IS7XX_SELECT
> =C2=A0=C2=A0=C2=A0 select SERIAL_SC16IS7XX
> =C2=A0=C2=A0=C2=A0 help
> =C2=A0=C2=A0=C2=A0 =C2=A0 Enable SC16IS7xx driver on SPI bus.
>=20

This looks quite elegant!  Should we aslo make SERIAL_SC16IS7XX depend
on SERIAL_SC16IS7XX_I2C || SERIAL_SC16IS7XX_SPI?  Would that work?

I know little about kbuild but I'm worried that someone doing oldconfig
can still get SERIAL_SC16IS7XX selected while saying no to all the
others.

Other option would be to swap the names between SERIAL_SC16IS7XX and
SERIAL_SC16IS7XX_SELECT, oldconfig would run smoother.

Thanks!
