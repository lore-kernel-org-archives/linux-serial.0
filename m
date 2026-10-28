Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209690;
	b=ipKSYgpT9sFXzJqM6nnzNjZwJjH0+0R/bsa4X1tPr2KyDmrO6euCrZn+p8SHTqEnLNnU
	 6w7HggmQ5V4Mwn33ACyHEq5mYRTLhJOjVQ7pKiVlmzf4z0QJ6dZVV3dQKbSqlmUhLfb5H
	 gYd5clZniEIeDYsfzJ2GMOamkmXSZdS86wVBcse76rm+Fxl3wB5ZfoaFT7AwDG95oiBzC
	 wPZfZLzVUz+QzWpnoutFQNu0pDiu5mZf15WDMPE5NFSyBeURpTvgiFGUX23u75UvHvE6U
	 vffb/ewwLpuRwkh4+iluxXv2giqqnLVUV9EQdspNtBzGfi5oOi+1h3JyKC/fjQJJjzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/Wv2oduyHCB3bINkvbXDumOCP+2XIPoe6lycT40yGmU=;
	b=lF1VmTJqzC4AWQCxfU4gdoaeIPn1nMudFvzBt+bCLvJfq+uj480GOOmE0OE9sm8tEr8H
	 PvXTyXHy+Qyf5pu4PMPqB73XYEA6vsd/bztnzO0StIs/wGPL2+MaLhFoQzed6Jv/kPEC9
	 r7gkGf1fKLHrn5zRG6Q+U0nZEGH1E8JzhAkYhu8V5T09nW1375Hm5BtwnBtTUenY6D+Us
	 sXGQVG3/cti6Xw8hezgBS8O+KYYM3ORNIkzcL90g2+5ls978GcPd7ldQubBakQlL0VRdk
	 5qpWiyRXhaYTtjnlzHUqo52Zvwk/ISUrsqcFZs5ShJ5YHBNQPN+D2HeFaIgbn/E2Yng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ded5COZ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4455606A31E;
	Wed, 28 Oct 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ded5COZ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8996F1F01828;
	Wed, 28 Oct 2026 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793209689;
	bh=/Wv2oduyHCB3bINkvbXDumOCP+2XIPoe6lycT40yGmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ded5COZ7NK1LzkY5zjgze165QjBxccKnZt8HKG45T+ir/wGv+XVL4qTFMgnqrqSOl
	 L1HGKA+Fq5Yfn383MT9I0SC7m7tmCLqA6V3sO7toYVKVSu51xZ/A/DzG6kI6oHsfe3
	 JSqLPvahttWSBHqyRmT13u6BB42i4DocncHMis9Aa3PotPzDx5DTCf7PB1VPOJXgF0
	 s91q6oskyk4rpFa2vweOrbaaoTN+XNUVJYbsparmFsIjHZ+mkutEwZCATAltmh2HEb
	 QNc8bTZoZCK4qOdqlfHsFZwsBsk4ZcPmjD5NlR4xudHffk1l9IY+jvfi3g7NaDRZbS
	 XRsCIz6O09PUw==
Date: Wed, 28 Oct 2026 17:48:00 +0000
From: Conor Dooley <conor@kernel.org>
To: gaohan@iscas.ac.cn
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Samuel Holland <samuel.holland@sifive.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH RFC 00/18] riscv: add initial Zhihe A210 support using
 SCMI clocks and resets
Message-ID: <20261028-shrivel-wrath-b50d6b12c259@spud>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RV8O/JhgCogw9BKb"
Content-Disposition: inline
In-Reply-To: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>

--RV8O/JhgCogw9BKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:36:51PM +0800, Han Gao via B4 Relay wrote:
> This adds initial support for the Zhihe A210 SoC and the Melon Pi V1
> and V2 boards. It replaces the earlier series [1]. The way clocks and
> resets are handled changed completely, so I am posting it as a new RFC
> rather than as v2.
>=20
> The A210 has eight RISC-V cores in two clusters, four C908 and four
> C920, plus an E902 management core. In [1] Linux drove the clock and
> reset registers directly. Review pointed out that those blocks were not
> modelled properly, and they are also used by the E902 firmware, which
> owns the power, PMIC and CPU DVFS sequencing. This series leaves those
> registers to the firmware and uses the standard SCMI clock and reset
> protocols instead.
>=20
> I also looked at RPMI before settling on SCMI. The firmware has to
> provide reset domains for the UARTs and pad controllers and sensors for
> thermal management, and RPMI has no ratified protocol for either yet.
> SCMI covers everything the firmware exposes today: clock, reset, power
> domain, performance, voltage, sensor and system power. Linux, U-Boot
> and EDK2 already have SCMI clients, so on the Linux side only the
> mailbox transport is new. RPMI support in U-Boot is also still being
> debated [8].

FWIW, this is perfectly fine by me - makes no difference to me if people
want to support SCMI or RPMI on their platform.
But I want to know what the story is going to be in terms of a) vendor
provided firmware and b) upstream opensbi support for this.

Will opensbi actually add SCMI support into the project, or will this
method force people to use random downstream firmware indefinitely for
this platform? That's especially true if the vendors are not behind this
effort and will not be providing SCMI capable firmware with the board,
or in their BSP for people that integrate the A210 SoC, forcing people
to re-image their boards to run mainline.

Cheers,
Conor.

>=20
> The SCMI related changes compared to [1]:
>=20
> - The native clock and reset drivers and their bindings are gone.
> - A new mailbox driver for the AP to E902 doorbell. One channel carries
>   SCMI requests, the other carries notifications from the firmware. The
>   shared memory lives in the AON SRAM.
> - arm_scmi transports can be built on RISC-V.
> - New dt-bindings headers for the SCMI clock and reset IDs exported by
>   the firmware. Only the IDs used here are defined for now. More will
>   be appended later without renumbering the existing ones.
> - Each UART has separate APB and serial resets, so the UARTs get a
>   "zhihe,a210-uart" compatible with two resets, as Philipp suggested.
> - The pin controllers take their pad resets from SCMI.
>=20
> Other changes since [1]: the pinctrl binding explains the SDIO pad names
> and the shared SDIO mux bit, pin nodes are ordered as pins, function,
> then configuration, and the defconfig commit explains why ten 8250
> ports are needed.
>=20
> The series covers the mailbox, the pin controller, the UARTs and the
> bindings and device trees around them. It is based on v7.3 and boots on
> a Melon Pi V2 to a shell on the UART console with all eight CPUs online.
> I would mostly like feedback on the SCMI approach and the ID headers
> before sending the rest of the platform.
>=20
> The E902 firmware is a Zephyr based SCMI server [2]. The rest of the
> boot chain is coreboot [3], OpenSBI [4] and EDK2 [5][6]. The complete
> Linux tree with the remaining peripherals is at [7].
>=20
> [1] https://lore.kernel.org/r/20261022-a210-init-v1-0-5e438f972d24@iscas.=
ac.cn
> [2] https://github.com/RevySR/zephyr/tree/xuantie/scmi
> [3] https://github.com/revyos/coreboot/tree/a210/scmi
> [4] https://github.com/revyos/opensbi/tree/a210/scmi
> [5] https://github.com/revyos/edk2/tree/a210/scmi
> [6] https://github.com/revyos/ruyiedk2/tree/a210/scmi
> [7] https://github.com/RevySR/linux/tree/a210/scmi-bootchain-v7.3
> [8] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/635007=
=2Ehtml
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
> Han Gao (10):
>       firmware: arm_scmi: Allow SCMI transports on RISC-V
>       dt-bindings: mailbox: add the A210 AP to E902 doorbell
>       mailbox: add A210 AP to E902 doorbell support
>       dt-bindings: timer: add Zhihe A210 CLINT
>       dt-bindings: firmware: add A210 SCMI clock and reset IDs
>       dt-bindings: serial: snps-dw-apb-uart: add Zhihe A210 UART
>       riscv: dts: zhihe: add A210 module memory
>       riscv: dts: zhihe: add Melon Pi V1 and V2
>       riscv: defconfig: enable A210 support
>       MAINTAINERS: add Zhihe A210
>=20
> Zhiguo Zhu (8):
>       dt-bindings: vendor-prefixes: add Zhihe
>       riscv: add Zhihe A210 support
>       dt-bindings: pinctrl: add Zhihe A210 pin controller
>       pinctrl: zhihe: add A210 support
>       dt-bindings: interrupt-controller: add Zhihe A210 PLIC
>       dt-bindings: riscv: add Melon Pi V1 and V2
>       riscv: dts: zhihe: add A210 core support
>       riscv: dts: zhihe: add A210 UARTs
>=20
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    |    1 +
>  .../bindings/mailbox/zhihe,a210-ap-mailbox.yaml    |   76 ++
>  .../bindings/pinctrl/zhihe,a210-pinctrl.yaml       |  211 ++++
>  Documentation/devicetree/bindings/riscv/zhihe.yaml |   27 +
>  .../bindings/serial/snps-dw-apb-uart.yaml          |    5 +-
>  .../devicetree/bindings/timer/sifive,clint.yaml    |    1 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
>  MAINTAINERS                                        |   14 +
>  arch/riscv/Kconfig.socs                            |   10 +
>  arch/riscv/boot/dts/Makefile                       |    1 +
>  arch/riscv/boot/dts/zhihe/Makefile                 |    2 +
>  arch/riscv/boot/dts/zhihe/a210-melonpi-common.dtsi |   55 +
>  arch/riscv/boot/dts/zhihe/a210-melonpi-v1.dts      |    9 +
>  arch/riscv/boot/dts/zhihe/a210-melonpi-v2.dts      |    9 +
>  arch/riscv/boot/dts/zhihe/a210-som.dtsi            |   11 +
>  arch/riscv/boot/dts/zhihe/a210.dtsi                |  619 ++++++++++
>  arch/riscv/configs/defconfig                       |   10 +
>  drivers/firmware/arm_scmi/Kconfig                  |    2 +-
>  drivers/mailbox/Kconfig                            |    9 +
>  drivers/mailbox/Makefile                           |    2 +
>  drivers/mailbox/mailbox-a210.c                     |  205 ++++
>  drivers/pinctrl/Kconfig                            |   14 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/pinctrl-a210.c                     | 1212 ++++++++++++++=
++++++
>  include/dt-bindings/clock/zhihe,a210-scmi.h        |   15 +
>  include/dt-bindings/reset/zhihe,a210-scmi.h        |   13 +
>  26 files changed, 2534 insertions(+), 2 deletions(-)
> ---
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> change-id: 20261027-a210-scmi-ec32fdc246a6
>=20
> Best regards,
> -- =20
> Han Gao <gaohan@iscas.ac.cn>
>=20
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--RV8O/JhgCogw9BKb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauI1TQAKCRB4tDGHoIJi
0kURAQCUCYGbEMJ2NtTgInuo3iF5HLvfVD/KWlN1F3WR+DiNPwD+M0vPtUSR3sBM
RMtElB8aaZ7S8AQB/fwplFhnSj58zg0=
=p4sC
-----END PGP SIGNATURE-----

--RV8O/JhgCogw9BKb--
