Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D23C5845;
	Tue, 29 Sep 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664732; cv=none; b=KkleTtzvltXE7sXzjLJhQFetnyjFyM05DMdb+CLXeD4AmMiPKp/PoyElvhpbhC91dW9h3/GNW+iZSX0t4yr8uIBcypUv1iAanZClXmTYcEAQNz8W9Ck6mXsmhBLyVi+5hKvbuX5V0folDg1l+JuZIfiJHFrdv9yFIhyYKKG3+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664732; c=relaxed/simple;
	bh=2DCyhnVyR0SrnlxZqXTrl5sWmjU/E/QncBSYSpCIQ+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIYM+QwVWvo6Vs53gQ64LV6SAmPDW3bUsvcntlhLsUA67pfz/Xxs4NgQZp2efwjLaKngnYcARKNUzlQSA8Fm1efdoCUgGE1PDmW18GLFtEquNnPZGBUnTjgZG11Bi5chKnVESkexn+ebGZFoY2nFj8UTxgwct48ApKs/f9enFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKlM/E/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKlM/E/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08E1F000FF;
	Tue, 29 Sep 2026 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664731;
	bh=cRt7cF6SpjDJnXL8CB9WsFFKyw37KPQ4L/LPlsP2FA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jKlM/E/39F/hLnt7FHWSD36xBy83PrBrc7ea27/8ohohNU/NHr2f7b9neBxrmQZhA
	 MDhVi+nvB4jRlf2obrhyksvG26vfU3ym33XCmcYo5/a5LHbTTEcMGUfq87YsHB9Rvp
	 u3m/yh1vmfrM7gMkAxaA7ErpEBK6wJgZa15rV/0C+HXfRJ8mjcd9D9j4DfR6mKNejd
	 OiVVmyHD0Gf35wQMIGLoidajA1M1lcefgxA8owAMzFB9mXVhZR7mHsCSB/Jde3uHaH
	 hozFWf1Iv745EIBZX6h+4DG6XjEP56lWaQrGJcbe0FJWw0YFGUY9LZ6g72DATVtV3u
	 51GseBZeEyhWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/20] arm64: dts: synaptics: Add Synaptics SL261X SoC
 and RDK board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: linux-i3c@lists.infradead.org, robh@kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-clk@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260929061417.20733-21-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-21-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:52:09 +0000
Message-Id: <20260929065210.5C08E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] dt: cpu0-supply is deprecated and breaks scaling on secondary co=
res
- [Low] dt: missing root compatible string in sl2619.dtsi
- [Low] dt: schema violation by nesting l2-cache inside cpu node
- [Low] dt: missing whitespace before opening brace in cpu-wrap node
--

commit 58d4f39b5f4d2e3ef035e2e85d0944a8e6331b18
Author: Jisheng Zhang <jszhang@kernel.org>

arm64: dts: synaptics: Add Synaptics SL261X SoC and RDK board

Add dts(i) files for the Synaptics SL261X SoCs and corresponding
RDK boards.

> diff --git a/arch/arm64/boot/dts/synaptics/sl2611.dtsi b/arch/arm64/boot/=
dts/synaptics/sl2611.dtsi
> new file mode 100644
> index 0000000000000..1d640ffe4c4b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/synaptics/sl2611.dtsi
[ ... ]
> @@ -0,0 +1,490 @@
[ ... ]
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			reg =3D <0x0>;
> +			enable-method =3D "psci";
> +			cpu-idle-states =3D <&CPU_SLEEP_0>;
> +			i-cache-size =3D <32768>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <128>;
> +			d-cache-size =3D <32768>;
> +			d-cache-line-size =3D <64>;
> +			d-cache-sets =3D <128>;
> +			next-level-cache =3D <&L2_0>;
> +
> +			L2_0: l2-cache {
> +				compatible =3D "cache";

[Severity: Low]
Could this violate the standard Device Tree schema for CPU topology? The
l2-cache nodes shouldn't be instantiated as children of the cpu nodes. Can
they be moved as siblings under the /cpus node to avoid dtbs_check validati=
on
errors?

[ ... ]
> +		chip: chip-control@f7e10000 {
> +			compatible =3D "syna,sl261x-chip-control", "syscon", "simple-mfd";
> +			reg =3D <0xf7e10000 0x10000>;
> +
> +			clk: clock {
> +				compatible =3D "syna,sl261x-soc-clk";
> +				#clock-cells =3D <1>;
> +				clocks =3D <&osc>;
> +			};
> +
> +			pinctrl: pin-controller {
> +				compatible =3D "syna,sl261x-soc-pinctrl";
> +			};
> +
> +			rst: reset {
> +				compatible =3D "syna,sl261x-soc-reset";
> +				#reset-cells =3D <1>;
> +			};
> +		};
> +
> +		cpu_wrap: cpu-wrap@f7e30000{

[Severity: Low]
Should there be a space before the opening brace for cpu-wrap@f7e30000? Whi=
le
the Device Tree Compiler parses this successfully, it goes against standard
formatting conventions.

> +			compatible =3D "syna,sl261x-cpu-wrp", "syscon", "simple-mfd";
> +			reg =3D <0xf7e30000 0x4000>;
[ ... ]
> diff --git a/arch/arm64/boot/dts/synaptics/sl2615.dtsi b/arch/arm64/boot/=
dts/synaptics/sl2615.dtsi
> new file mode 100644
> index 0000000000000..11b1fe316aa6d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/synaptics/sl2615.dtsi
[ ... ]
> @@ -0,0 +1,46 @@
[ ... ]
> +	cpus {
> +		cpu1: cpu@100 {
> +			compatible =3D "arm,cortex-a55";
> +			device_type =3D "cpu";
> +			reg =3D <0x100>;
> +			enable-method =3D "psci";
> +			cpu-idle-states =3D <&CPU_SLEEP_0>;
> +			i-cache-size =3D <32768>;
> +			i-cache-line-size =3D <64>;
> +			i-cache-sets =3D <128>;
> +			d-cache-size =3D <32768>;
> +			d-cache-line-size =3D <64>;
> +			d-cache-sets =3D <128>;
> +			next-level-cache =3D <&L2_1>;
> +
> +			L2_1: l2-cache {
> +				compatible =3D "cache";

[Severity: Low]
Similar to sl2611.dtsi, does this violate the standard Device Tree schema f=
or
CPU topology? The l2-cache node is instantiated as a child of the cpu node
here, and it should likely be moved to be a sibling under the /cpus node.

[ ... ]
> diff --git a/arch/arm64/boot/dts/synaptics/sl2619.dtsi b/arch/arm64/boot/=
dts/synaptics/sl2619.dtsi
> new file mode 100644
> index 0000000000000..96bd58bbed3e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/synaptics/sl2619.dtsi
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include "sl2613.dtsi"
> +
> +/ {

[Severity: Low]
Would it make sense to include the root compatible string here? sl2619.dtsi
includes sl2613.dtsi but doesn't override the root compatible string to
syna,sl2619 (unlike sl2615.dtsi and sl2617.dtsi). Even though sl2619-rdk.dts
overrides it, this omission seems logically inconsistent.

> +	cpus {
> +		cpu1: cpu@100 {
> +			compatible =3D "arm,cortex-a55";
[ ... ]
> diff --git a/arch/arm64/boot/dts/synaptics/sl261x-rdk-common.dtsi b/arch/=
arm64/boot/dts/synaptics/sl261x-rdk-common.dtsi
> new file mode 100644
> index 0000000000000..78a9b28fdf99e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/synaptics/sl261x-rdk-common.dtsi
[ ... ]
> @@ -0,0 +1,135 @@
[ ... ]
> +	cpus {
> +		cpu@0 {
> +			cpu0-supply =3D <&vcore>;

[Severity: Medium]
Will this break voltage scaling for secondary cores? cpu0-supply is depreca=
ted
in the cpus.yaml devicetree bindings in favor of cpu-supply.

Also, since this is hardcoded strictly under cpu@0 in the common board dtsi,
any secondary cores introduced by multi-core SoCs (like cpu1 in SL2615) will
inherit no regulator supply. Could this cause the cpufreq driver to fail to
configure voltage scaling for secondary cores?

> +		};
> +	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D20
