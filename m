Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852501DFDE;
	Sun,  4 Aug 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722786696; cv=none; b=ZBIfavS5ks7X3w82as4fYP4L4oq4t04O1WeGZr51eMQAW5DILYCKH/FxcIkrCnZXt6bRNqEOOZ2k5YbQ5OuO4W5gA6DdO6GnqLY8oH3P+6fIHaj/8615nPU5Z8XLb1Lxud8lN8T7tffmGPssIaLRhvfBHYHUP4rvSO1+sIAtIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722786696; c=relaxed/simple;
	bh=GeN6veiciCRyl3DnFAeFZf+br87ledEqCi7HomNZhbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5BmImDZAx/MB9JveNh5JEXtszpvDIeXcJc0auip4m7JvCLa44MXsyPV/IH73s9Eiz57Pv+UGocraxY21L/4BaFkhPVwOV7IHBV9f39q6zRhwcZ2gjitHBP25i43UD1pcfS/GKB8/rxVGBth0k88v4XrbHXdzD+H/w3r0Hharvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sadVp-0001Lx-IS; Sun, 04 Aug 2024 17:51:13 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Yao Zi <ziyao@disroot.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>,
 Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Ondrej Jirman <megi@xff.cz>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Sun, 04 Aug 2024 17:51:12 +0200
Message-ID: <10256980.nnTZe4vzsl@diego>
In-Reply-To: <81147f0205c2a9555c9c64e4f7a69b6b@manjaro.org>
References:
 <20240803125510.4699-2-ziyao@disroot.org> <2408413.9XhxPE3A7Q@diego>
 <81147f0205c2a9555c9c64e4f7a69b6b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Sonntag, 4. August 2024, 15:59:19 CEST schrieb Dragan Simic:
> On 2024-08-04 15:44, Heiko St=FCbner wrote:
> > Am Sonntag, 4. August 2024, 15:25:47 CEST schrieb Dragan Simic:
> >> On 2024-08-04 15:20, Yao Zi wrote:
> >> > On Sun, Aug 04, 2024 at 12:05:11PM +0200, Krzysztof Kozlowski wrote:
> >> >> On 03/08/2024 14:55, Yao Zi wrote:
> >> >> > This initial device tree describes CPU, interrupts and UART on th=
e chip
> >> >> > and is able to boot into basic kernel with only UART. Cache infor=
mation
> >> >> > is omitted for now as there is no precise documentation. Support =
for
> >> >> > other features will be added later.
> >> >> >
> >> >> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> >> >> > ---
> >> >> >  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++=
++++++
> >> >> >  1 file changed, 182 insertions(+)
> >> >> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi
> >> >> >
> >> >> > diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3528.dtsi
> >> >> > new file mode 100644
> >> >> > index 000000000000..77687d9e7e80
> >> >> > --- /dev/null
> >> >> > +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> >> >> > @@ -0,0 +1,182 @@
> >> >> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> >> > +/*
> >> >> > + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
> >> >> > + * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
> >> >> > + */
> >> >> > +
> >> >> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> >> > +#include <dt-bindings/interrupt-controller/irq.h>
> >> >> > +
> >> >> > +/ {
> >> >> > +	compatible =3D "rockchip,rk3528";
> >> >> > +
> >> >> > +	interrupt-parent =3D <&gic>;
> >> >> > +	#address-cells =3D <2>;
> >> >> > +	#size-cells =3D <2>;
> >> >> > +
> >> >> > +	aliases {
> >> >> > +		serial0 =3D &uart0;
> >> >> > +		serial1 =3D &uart1;
> >> >> > +		serial2 =3D &uart2;
> >> >> > +		serial3 =3D &uart3;
> >> >> > +		serial4 =3D &uart4;
> >> >> > +		serial5 =3D &uart5;
> >> >> > +		serial6 =3D &uart6;
> >> >> > +		serial7 =3D &uart7;
> >> >> > +	};
> >> >> > +
> >> >> > +	cpus {
> >> >> > +		#address-cells =3D <1>;
> >> >> > +		#size-cells =3D <0>;
> >> >> > +
> >> >> > +		cpu-map {
> >> >> > +			cluster0 {
> >> >> > +				core0 {
> >> >> > +					cpu =3D <&cpu0>;
> >> >> > +				};
> >> >> > +				core1 {
> >> >> > +					cpu =3D <&cpu1>;
> >> >> > +				};
> >> >> > +				core2 {
> >> >> > +					cpu =3D <&cpu2>;
> >> >> > +				};
> >> >> > +				core3 {
> >> >> > +					cpu =3D <&cpu3>;
> >> >> > +				};
> >> >> > +			};
> >> >> > +		};
> >> >> > +
> >> >> > +		cpu0: cpu@0 {
> >> >> > +			device_type =3D "cpu";
> >> >> > +			compatible =3D "arm,cortex-a53";
> >> >> > +			reg =3D <0x0>;
> >> >> > +			enable-method =3D "psci";
> >> >> > +		};
> >> >> > +
> >> >> > +		cpu1: cpu@1 {
> >> >> > +			device_type =3D "cpu";
> >> >> > +			compatible =3D "arm,cortex-a53";
> >> >> > +			reg =3D <0x1>;
> >> >> > +			enable-method =3D "psci";
> >> >> > +		};
> >> >> > +
> >> >> > +		cpu2: cpu@2 {
> >> >> > +			device_type =3D "cpu";
> >> >> > +			compatible =3D "arm,cortex-a53";
> >> >> > +			reg =3D <0x2>;
> >> >> > +			enable-method =3D "psci";
> >> >> > +		};
> >> >> > +
> >> >> > +		cpu3: cpu@3 {
> >> >> > +			device_type =3D "cpu";
> >> >> > +			compatible =3D "arm,cortex-a53";
> >> >> > +			reg =3D <0x3>;
> >> >> > +			enable-method =3D "psci";
> >> >> > +		};
> >> >> > +	};
> >> >> > +
> >> >> > +	psci {
> >> >> > +		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
> >> >> > +		method =3D "smc";
> >> >> > +	};
> >> >> > +
> >> >> > +	timer {
> >> >> > +		compatible =3D "arm,armv8-timer";
> >> >> > +		interrupts =3D <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_=
LEVEL_LOW)>,
> >> >> > +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW=
)>,
> >> >> > +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW=
)>,
> >> >> > +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW=
)>;
> >> >> > +	};
> >> >> > +
> >> >> > +	xin24m: xin24m {
> >> >>
> >> >> Please use name for all fixed clocks which matches current format
> >> >> recommendation: 'clock-([0-9]+|[a-z0-9-]+)+'
> >> >
> >> > Will be fixed in next revision.
> >>=20
> >> Hmm, why should we apply that rule to the xin24m clock, which is
> >> named exactly like that everywhere else in Rockchip SoC dtsi files?
> >> It's much better to remain consistent.
> >=20
> > bindings or how we write devicetrees evolve over time ... similarly the
> > xin24m name comes from more than 10 years ago.
> >=20
> > We also name all those regulator nodes regulator-foo now, which in turn
> > automatically does enforce a nice sorting rule to keep all the=20
> > regulators
> > around the same area ;-)
> >=20
> > So I don't see a problem of going with xin24m: clock-xin24m {}
>=20
> I agree that using "clock-xin24m" makes more sense in general, but the
> trouble is that we can't rename the already existing instances of=20
> "xin24m",
> because that has become part of the ABI.  Thus, I'm not sure that=20
> breaking
> away from the legacy brings benefits in this particular case.

In the regulator case, we have _new_ boards using the new _node_-names
but I don't see any renaming of old boards and also don't think we should.

But that still does not keep us from using the nicer naming convention in
new boards ;-) .


Same with xin24m. We're talking only about the node-name here. The
phandle stays the same and also the actual clock name stays the same and
really only the actual node name you need to look for in /proc/device-tree
changes ;-) .

So I don't see the need to go about changing all the old socs, but new
additions should use improved naming conventions.

xin24m: clock-xin24m {
	compatible =3D "fixed-clock";
	#clock-cells =3D <0>;
	clock-frequency =3D <24000000>;
	clock-output-names =3D "xin24m";
};


Heiko



> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=3Dv6.11-rc1
> >> >>
> >> >> > +		compatible =3D "fixed-clock";
> >> >> > +		#clock-cells =3D <0>;
> >> >> > +		clock-frequency =3D <24000000>;
> >> >> > +		clock-output-names =3D "xin24m";
> >> >> > +	};
> >> >> > +
> >> >> > +	gic: interrupt-controller@fed01000 {
> >> >>
> >> >> Why this all is outside of SoC?
> >> >
> >> > Just as Heiko says, device tree for all other Rockchip SoCs don't ha=
ve
> >> > a "soc" node. I didn't know why before but just follow the style.
> >> >
> >> > If you prefer add a soc node, I am willing to.
> >>=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>=20




