Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685606;
	b=L7MpSlBv6p1IhP9vVdge41VzOeG6X3hf99MFqxyzFu/sF7FZKnrRkcSH2W+Jbm+NOxbQ
	 1ugG0aEaRD17pxhG23Mbx34GCtlS42MTQ8f5nLUKchf4UpVXWuLql/tEdFJbBfXFTzJmi
	 EgpVHBnz0SnRNI6MdsEAwsyuzA6lGc1yt3Y8vEu1+yHrtb7dyEHlgIw/fkwidglJB+iHH
	 Z1S2/vo/nA7lYlXHuB2PARXsjfIT1DcBIeA0rxEQetrX9FL/nRamwQkKha+cf0KulHKyK
	 0FDshV5Me1PGIdjTmAviDyMV4XX16+wNu822k/joaz1FF77g0HYnQMp+HUnHBem42Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685606;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RMgulY08ZJVlFJJu8HfSK1T+bjv1y0Dztk0c5dEhw1Y=;
	b=SAd0Iz8K0iCdnW5MRy/e3M8jZISmGQuJetWWex/Ms9ZilrrxjjM4HuQmC2Ike7L/fPzm
	 s2Tax6LP6b3kTPkzM2lJbEtFh2tPIyZa4e+LcWBpFi8g0QmbT08MvRjQ6XbehEdHia5Oz
	 k+YLu+oDXOnFrKViZ0bjbyRfW2U2vB/DXs6+tnyIUC0GJoJ1AAS0k8D0EMMkKM2Ycfn31
	 9pHXYNLmiqM4TQiC8Wvn4vntcNBYHM8OZwwQ8tFia8BVpuJavQVnwHKNkFixuB+2nb2ta
	 ZMuC9WCuFLHsNlwy0/CHLiy1ln6fqNF37RlK1BWpLeGzpMiQIOGhlIo8vG3BT96RDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WornGomS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C9606A33B;
	Thu, 22 Oct 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WornGomS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A121F01825;
	Thu, 22 Oct 2026 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685606;
	bh=RMgulY08ZJVlFJJu8HfSK1T+bjv1y0Dztk0c5dEhw1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WornGomS8imMbDY1iUxrs+PmiX4urtORVq176unmyxkvCW8J+bPSaRXz6zzY/+DVV
	 tHgTz15zZUGZe8V3r6fjcVF+AGqgU2bBUKXrnrT2Pc+HSxCmHi+Jj5hbjkjeSvvK0F
	 y3T2/0Llw8xhWLHqMT/9yr0L93tqlpyTt18mDYUKemroXUHEfe/xmEBWWdx14fN6sX
	 g3RaUDGEEGiGohK38fwLhlYsxcpRBqMV6nh2oagWX4w4RQqcwRKA8npGZA15wK840s
	 ar6vukgom9iJycmgXGl/TWVOkGUnntHcLbi6YfzI/exmd9ru+1czLw0zCq5O535aca
	 kOLh3/CO4QX0g==
Message-ID: <sashiko-outbox-181790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/27] arm64: dts: rockchip: Add RK3572 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-26-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-26-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] arm64: dts: rockchip: duplicate pdmm1-clk*-idle node names in rk=
3572-pinctrl
- [Medium] arm64: dts: rockchip: missing pixel clock pin in rk3572 rgb3x8_p=
ins_m1
--

commit 187a63c766133c9d7856a97e9575a5f3703cf119
Author: Cunhao Lu <1579567540@qq.com>

arm64: dts: rockchip: Add RK3572 SoC

This commit adds the base device tree files for the Rockchip rk3572,
including the operating points, pinctrl definitions, and peripheral nodes.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3572-pinctrl.dtsi b/arch/arm6=
4/boot/dts/rockchip/rk3572-pinctrl.dtsi
> new file mode 100644
> index 0000000000000..8440feea419b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3572-pinctrl.dtsi
> @@ -0,0 +1,3935 @@

[ ... ]

> +	pdm {
> +		/omit-if-no-ref/
> +		pdmm0_clk0_idle: pdmm0-clk0-idle {
> +			rockchip,pins =3D
> +				<0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm0_clk1_idle: pdmm0-clk1-idle {
> +			rockchip,pins =3D
> +				<0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm1_clk0_idle: pdmm1-clk0-idle {
> +			rockchip,pins =3D
> +				<2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm1_clk1_idle: pdmm1-clk1-idle {
> +			rockchip,pins =3D
> +				<2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm2_clk0_idle: pdmm1-clk0-idle {
> +			rockchip,pins =3D
> +				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm2_clk1_idle: pdmm1-clk1-idle {
> +			rockchip,pins =3D
> +				<1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm3_clk0_idle: pdmm1-clk0-idle {
> +			rockchip,pins =3D
> +				<2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm3_clk1_idle: pdmm1-clk1-idle {
> +			rockchip,pins =3D
> +				<2 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm4_clk0_idle: pdmm1-clk0-idle {
> +			rockchip,pins =3D
> +				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		pdmm4_clk1_idle: pdmm1-clk1-idle {
> +			rockchip,pins =3D
> +				<3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};

[Severity: Medium]
Should the node names for pdmm2_clk0_idle, pdmm3_clk0_idle, and
pdmm4_clk0_idle under the pdm node in rk3572-pinctrl.dtsi be
pdmm2-clk0-idle, pdmm3-clk0-idle, and pdmm4-clk0-idle (and likewise for the
clk1-idle nodes), rather than repeating pdmm1-clk0-idle and pdmm1-clk1-idle?

Because these sibling nodes share the same node names under the pdm parent,
dtc merges them into a single pdmm1-clk0-idle node and a single
pdmm1-clk1-idle node, overwriting rockchip,pins with the values from
pdmm4_clk0_idle and pdmm4_clk1_idle when any of the pdmm1, pdmm2, or pdmm3
idle clock pinctrl phandles are referenced.

[ ... ]

> +	vo {

[ ... ]

> +		/omit-if-no-ref/
> +		rgb3x8_pins_m0: rgb3x8-pins-m0 {
> +			rockchip,pins =3D
> +				<3 RK_PD7 3 &pcfg_pull_none>,
> +				<3 RK_PD0 3 &pcfg_pull_none>,
> +				<3 RK_PC7 3 &pcfg_pull_none>,
> +				<3 RK_PC6 3 &pcfg_pull_none>,
> +				<3 RK_PC5 3 &pcfg_pull_none>,
> +				<3 RK_PC4 3 &pcfg_pull_none>,
> +				<3 RK_PC1 3 &pcfg_pull_none>,
> +				<3 RK_PC0 3 &pcfg_pull_none>,
> +				<3 RK_PB7 3 &pcfg_pull_none>,
> +				<3 RK_PD4 3 &pcfg_pull_none>,
> +				<3 RK_PD5 3 &pcfg_pull_none>,
> +				<3 RK_PD6 3 &pcfg_pull_none>;
> +		};
> +
> +		/omit-if-no-ref/
> +		rgb3x8_pins_m1: rgb3x8-pins-m1 {
> +			rockchip,pins =3D
> +				<3 RK_PB6 3 &pcfg_pull_none>,
> +				<3 RK_PB5 3 &pcfg_pull_none>,
> +				<3 RK_PB4 3 &pcfg_pull_none>,
> +				<3 RK_PB0 3 &pcfg_pull_none>,
> +				<3 RK_PA7 3 &pcfg_pull_none>,
> +				<3 RK_PA6 3 &pcfg_pull_none>,
> +				<3 RK_PA5 3 &pcfg_pull_none>,
> +				<3 RK_PA4 3 &pcfg_pull_none>,
> +				<3 RK_PD4 3 &pcfg_pull_none>,
> +				<3 RK_PD5 3 &pcfg_pull_none>,
> +				<3 RK_PD6 3 &pcfg_pull_none>;
> +		};

[Severity: Medium]
Is rgb3x8_pins_m1 under the vo node in rk3572-pinctrl.dtsi missing the
<3 RK_PD7 3 &pcfg_pull_none> pixel clock pin?

rgb3x8_pins_m0 and the other display pin groups (vo_lcdc_pins, bt1120_pins,
bt656_pins, rgb565_pins, rgb666_pins, and rgb888_pins) all include this pin
alongside their data and sync pins, whereas rgb3x8_pins_m1 only lists the 8
data pins and 3 sync pins.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D26
