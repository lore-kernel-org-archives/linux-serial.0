Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87866392819;
	Tue, 29 Sep 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710740; cv=none; b=Oikk17iYol1YoNfEssEeO9jAj+40WPCCMWhFbCILWOXQ4f6fb+Z4yAOrThjkYbl1T6zPUAqoqzIob9aB4h3wAqo/VTZ5RFb1zL1NoCaIXVz6t8COfQkzl82NVoEyKsvnY6N3CajcxeWf3O9imcgZWTAgrPV/e56WqsqU4mUk/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710740; c=relaxed/simple;
	bh=0PEVIn2BfHN7sUqiyH9zoZrr3wqEIptJ04d6UD6OcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSOVC7mmFo6Y10kfLflg0xwHp7UrbA0x0q1EOjkx9i+QJ9TeXaLBj8xGlTo3FfTsJy2/mxkG2ajtWpqKZM5VncxuScpcq4NdXNR48D+hYZy6kJ3EZLk76ahFGNR0nJtHo1jD++keVet0bHo49Qnk74ciFXriKoKWk7vXqKjjnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj11jVh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj11jVh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D59D1F000FF;
	Tue, 29 Sep 2026 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710739;
	bh=VsGpWLQ4V1vn9Tkitk4/L46O9pJ0sPXyLWBFVS/Nrs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fj11jVh99BJrwxKYIiKxEfLqjBw8IgTj2t8u8K+Qbhjj6i2r3O4J19cjqCKMcc0x7
	 3pjU1jPb3MmY6lReift+WlXzce/KSulEsw4QGtLAmO8bgUM3PCeJe1IN1Wc0F1PLLY
	 EtE6R0y7ofJDC+Fwp1gsUG7an3u3q+xpOmOfblyT1rsIjQaNi+kqjpVsrHT1dp7EmW
	 t1mQ2zNdRwqPQ0A7TqLalEVPESJhh+fuiO0+GX8uJigtS8EJATk/I8xeiEl9vpMut3
	 hzokpXB+U0h0zadU0cfhGF7mxc7QTCqbBE8ux3N8t0I45sSEVwPZ3fJzuqyOk3/Omz
	 dJ1ya0c+b8LwQ==
Date: Tue, 29 Sep 2026 20:38:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/20] arm64: add Synaptics SL261X SoCs and RDK boards
Message-ID: <20260929-smoked-laurel-087d5a3523a3@spud>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftlp7D0f7O7319jz"
Content-Disposition: inline
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>

--ftlp7D0f7O7319jz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:13:57PM +0800, Jisheng Zhang wrote:
> Add initial support for the Synaptics SL261X SoCs and corresponding
> RDK boards.
>=20
> The SL261X SoCs include five pin-to-pin compatible SoCs: SL2611, SL2613,
> SL2615, SL2617, and SL2619.
>=20
> Only reset, pinctrl, clk/pll, uart, gpio, i2c, spi, i3c are included in
> this series. The support for Ethernet, USB, SDHCI, CAN, DMAC, XSPI will
> be submitted after this series is merged.

This series is filled with wildcard compatibles, which we don't permit
typically. The only case for SoCs that I've seen them accepted is when
the devices covered are actually just different binnings of the same
device. I took a look at the docs for this device, but it wasn't clear
to me if these are actually binnings or if there are different
integrations here. If they're binnings, I'd rather you used 0 as the
final digit, rather than x, since that matches the synaptics
documentation for the family. If they're not binnings, there's no
guarantee that they share the same errata etc, and must have different
compatibles.

Cheers,
Conor.

>=20
>=20
> Jisheng Zhang (20):
>   dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl261x uart
>   dt-bindings: i2c: dw: Add Synaptics sl261x i2c
>   spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl261x spi
>   dt-bindings: i3c: dw: support up to two reset lines
>   i3c: dw: switch to array-based exclusive reset control
>   dt-bindings: i3c: Add Synaptics sl261x i3c
>   arm64: kconfig: let ARCH_BERLIN cover Synaptics arm64 SoCs
>   dt-bindings: reset: add Synaptics SL261X SoCs
>   reset: add Synaptics SL261x reset support
>   pinctrl: berlin: use u16 instead of u8 for the offset
>   pinctrl: berlin: enable module build support
>   pinctrl: berlin: add optional pinconf support
>   dt-bindings: pinctrl: berlin: Support Synaptics SL261X SoCs
>   pinctrl: berlin: support Synaptics SL261X SoCs
>   dt-bindings: clock: add Synaptics SL261X clock
>   clk: berlin: add Synaptics SL261X SoC clocks and plls
>   dt-bindings: mfd: Add Synaptics SL261x global block binding
>   regulator: dt-bindings: sy8827n: support standard properties
>   dt-bindings: arm: berlin: Add Synaptics SL261X SoC and RDK board
>   arm64: dts: synaptics: Add Synaptics SL261X SoC and RDK board
>=20
>  .../bindings/arm/marvell,berlin.yaml          |  20 +
>  .../bindings/clock/syna,sl261x-clk.yaml       |  92 +++
>  .../bindings/i2c/snps,designware-i2c.yaml     |   1 +
>  .../bindings/i3c/snps,dw-i3c-master.yaml      |   6 +-
>  .../bindings/mfd/syna,sl261x-gbl.yaml         | 208 +++++
>  .../pinctrl/marvell,berlin2-soc-pinctrl.yaml  |  10 +-
>  .../bindings/regulator/silergy,sy8827n.yaml   |   5 +-
>  .../bindings/reset/syna,sl261x-reset.yaml     |  40 +
>  .../bindings/serial/snps-dw-apb-uart.yaml     |  12 +-
>  .../bindings/spi/snps,dw-apb-ssi.yaml         |   1 +
>  arch/arm64/Kconfig.platforms                  |   4 +-
>  arch/arm64/boot/dts/synaptics/Makefile        |   5 +
>  arch/arm64/boot/dts/synaptics/sl2611-rdk.dts  |  16 +
>  arch/arm64/boot/dts/synaptics/sl2611.dtsi     | 490 ++++++++++++
>  arch/arm64/boot/dts/synaptics/sl2613-rdk.dts  |  16 +
>  arch/arm64/boot/dts/synaptics/sl2613.dtsi     |  12 +
>  arch/arm64/boot/dts/synaptics/sl2615-rdk.dts  |  16 +
>  arch/arm64/boot/dts/synaptics/sl2615.dtsi     |  46 ++
>  arch/arm64/boot/dts/synaptics/sl2617-rdk.dts  |  16 +
>  arch/arm64/boot/dts/synaptics/sl2617.dtsi     |  46 ++
>  arch/arm64/boot/dts/synaptics/sl2619-rdk.dts  |  16 +
>  arch/arm64/boot/dts/synaptics/sl2619.dtsi     |  44 ++
>  .../boot/dts/synaptics/sl261x-rdk-common.dtsi | 135 ++++
>  drivers/clk/Kconfig                           |   1 +
>  drivers/clk/berlin/Kconfig                    |  25 +
>  drivers/clk/berlin/Makefile                   |   4 +
>  drivers/clk/berlin/sl-clk.c                   | 279 +++++++
>  drivers/clk/berlin/sl-clk.h                   |  31 +
>  drivers/clk/berlin/sl-sysmgr-clk.c            | 250 ++++++
>  drivers/clk/berlin/sl-sysmgr-clk.h            |  44 ++
>  drivers/clk/berlin/sl261x-clks.c              | 385 +++++++++
>  drivers/clk/berlin/sl261x-pll.c               | 145 ++++
>  drivers/clk/berlin/sl261x-pll.h               |  14 +
>  drivers/i3c/master/dw-i3c-master.c            |  24 +-
>  drivers/i3c/master/dw-i3c-master.h            |   2 +-
>  drivers/pinctrl/berlin/Kconfig                |   7 +
>  drivers/pinctrl/berlin/Makefile               |   1 +
>  drivers/pinctrl/berlin/berlin.c               | 259 +++++-
>  drivers/pinctrl/berlin/berlin.h               |  17 +-
>  drivers/pinctrl/berlin/pinctrl-sl261x.c       | 745 ++++++++++++++++++
>  drivers/reset/Kconfig                         |   6 +
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-sl261x.c                  | 224 ++++++
>  include/dt-bindings/clock/syna,sl261x.h       | 131 +++
>  include/dt-bindings/reset/syna,sl261x-reset.h |  80 ++
>  45 files changed, 3899 insertions(+), 33 deletions(-)
>  create mode 100755 Documentation/devicetree/bindings/clock/syna,sl261x-c=
lk.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/syna,sl261x-gbl=
=2Eyaml
>  create mode 100644 Documentation/devicetree/bindings/reset/syna,sl261x-r=
eset.yaml
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2611-rdk.dts
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2611.dtsi
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2613-rdk.dts
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2613.dtsi
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2615-rdk.dts
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2615.dtsi
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2617-rdk.dts
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2617.dtsi
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2619-rdk.dts
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl2619.dtsi
>  create mode 100644 arch/arm64/boot/dts/synaptics/sl261x-rdk-common.dtsi
>  create mode 100644 drivers/clk/berlin/Kconfig
>  create mode 100644 drivers/clk/berlin/sl-clk.c
>  create mode 100644 drivers/clk/berlin/sl-clk.h
>  create mode 100644 drivers/clk/berlin/sl-sysmgr-clk.c
>  create mode 100644 drivers/clk/berlin/sl-sysmgr-clk.h
>  create mode 100644 drivers/clk/berlin/sl261x-clks.c
>  create mode 100644 drivers/clk/berlin/sl261x-pll.c
>  create mode 100644 drivers/clk/berlin/sl261x-pll.h
>  create mode 100644 drivers/pinctrl/berlin/pinctrl-sl261x.c
>  create mode 100644 drivers/reset/reset-sl261x.c
>  create mode 100644 include/dt-bindings/clock/syna,sl261x.h
>  create mode 100644 include/dt-bindings/reset/syna,sl261x-reset.h
>=20
> --=20
> 2.53.0
>=20

--ftlp7D0f7O7319jz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwTywAKCRB4tDGHoIJi
0iSUAQDQBP7yTMTRQHM/PgAAhHzzJvYdwsiryiFIj8dSXwY0TAD9F2PqX3b5V+ld
h0q5oG8eDLbjjVQcWB1DWaQc14lxeQw=
=yJKk
-----END PGP SIGNATURE-----

--ftlp7D0f7O7319jz--
