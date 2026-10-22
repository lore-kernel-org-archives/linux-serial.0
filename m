Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685585;
	b=FxN3Tz4l193fltGDB+8hHWlM7VPvV2izWlqGe538GAncmYqMVB2ZeK1DAWQQO6hb4v5s
	 i4UNIlgB6ESeyYLsQfIQnggqxY1JjBQc+S7MyMv4w0NOEk/xSrjUI4VIPRHZ6hSZDFzUi
	 REyHqqKHTBet1MFprJEhbzKx6vC7qZbSxIN0+9H8AkQ/QR2pQy4FZEiYeUvN4QOlX1jZ2
	 xOoE0Wx0OdwxbbFiXvncS8Rxetfz4Mez2fx+VcfZJGov2M8YmqYOEnX5xdtGX5V7JMdYo
	 QGJ2RFTvzKYwe3NEZte1B/nF9iuwteE92jtoUKs6u/8D5CebdXfxIOoOsb+bY3GFl6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jF1NmDnjh7c7kkxRx9bcWKHyYF3gUqr7mA5JIQaVVhI=;
	b=tb1GNcqJNF98e8K0aEOSch1Q8Xsd+W+mL5KhAwQOcN0FPDQuQAfFLhdItGNldNNJudC7
	 Wx65AOSj3FABEWk/Z2am40C79xAnco++Rl4oXNVZYq8jSi8afsRNmlpP3WBHt/91Pab68
	 T2oYmGJTubtiL3uUbcr64HwYfR8VHgZY0H1YPxAkJhZwmr5XsRe5qhce0GEKIY3uAmJvD
	 6RpnxrI7n2MeX+MkqkHRoT+Wkx7fl5uY51P20N0QcWQwnfS0Tu8ySwemodA8qqWIYxJhG
	 tXElsdNbMWiB6a7P5BSWC9k9Qp5X6dX0SB5Hw39qfMXlysPeDfZMRgqBZSZQpAVr1Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbKU9Xij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C7606A31B;
	Thu, 22 Oct 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VbKU9Xij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D023C1F031E0;
	Thu, 22 Oct 2026 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685584;
	bh=jF1NmDnjh7c7kkxRx9bcWKHyYF3gUqr7mA5JIQaVVhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbKU9XijUrEX0e4+6Rn3tL6jndLa0XGqXD16igKfK2SXZJ2P6cdLWIj2iQt2CDgZE
	 8dHVpsg338sud3dCvLpyaruKJoGrMpLcAvOcxouQO0yRHvsM7YDGG/lb6SMyUlnK7P
	 EjFJeQA8nDr6caxF8yna5GwsBxTVyY4E4bOIZxrjDYUjWoBrGg/qXxHIoDutLMTapA
	 EDi8JjNSWQKwA3XABoJZGcGv9inNuF89WCXtegcQ/Fk2lcMx3pWNNt1+ip20SLhNqm
	 LI2XImZpCUj7xtN4KsFk63598DT+8lBpHDdGsESggY6fGE+OTV+uLnH0yFipfLsWP0
	 hQ9WqlLEd/RiA==
Message-ID: <sashiko-outbox-181771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:03 +0000
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
- [Medium] clk: rockchip: missing CLK_AUDIO_FRAC_0..2 in rk3572_clk_branches
- [Medium] clk: rockchip: internal FACTOR(0) branches overwrite PLL_PPLL in=
 rk3572_clk_init()
--

commit 9602441daaa896927eb56cc9b1d0e4d99173c907
Author: Cunhao Lu <1579567540@qq.com>

clk: rockchip: Add RK3572 clock and reset support

This commit adds clock and soft-reset controller driver support for the
Rockchip rk3572 SoC.

> diff --git a/drivers/clk/rockchip/clk-rk3572.c b/drivers/clk/rockchip/clk=
-rk3572.c
> new file mode 100644
> index 0000000000000..78fd35f5f27d1
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk3572.c

[ ... ]

> +PNAME(mux_24m_frac_int_mclk4_p) =3D {
> +	"xin24m", "clk_audio_frac_0", "clk_audio_frac_1", "clk_audio_frac_2",
> +	"clk_audio_frac_3", "clk_audio_int_0", "clk_audio_int_1", "clk_audio_in=
t_2",
> +	"sai0_mclk_in", "sai1_mclk_in", "sai2_mclk_in", "sai3_mclk_in",
> +};

[ ... ]

> +PNAME(mux_24m_frac_int_mclki_p) =3D {
> +	"xin24m", "clk_audio_int_0", "clk_audio_int_1", "clk_audio_int_2", "clk=
_audio_frac_0",
> +	"clk_audio_frac_1", "clk_audio_frac_2", "clk_audio_frac_3", "sai0_mclk_=
in",
> +	"sai1_mclk_in", "sai2_mclk_in", "sai3_mclk_in", "sai4_mclk_in",
> +};
> +
> +PNAME(mux_24m_frac_int_mclki_sclki_p) =3D {
> +	"xin24m", "clk_audio_int_0", "clk_audio_int_1", "clk_audio_int_2", "clk=
_audio_frac_0",
> +	"clk_audio_frac_1", "clk_audio_frac_2", "clk_audio_frac_3", "sai0_mclk_=
in",
> +	"sai1_mclk_in", "sai2_mclk_in", "sai3_mclk_in", "sai4_mclk_in", "sai0_s=
clk_in",
> +	"sai1_sclk_in", "sai2_sclk_in", "sai3_sclk_in", "sai4_sclk_in",
> +};

[ ... ]

> +static struct rockchip_pll_clock rk3572_pll_clks[] __initdata =3D {
> +	/* Keep BPLL and LPLL enabled for firmware consumers. */
> +	[bpll] =3D PLL(pll_rk3588_core, PLL_BPLL, "bpll", mux_pll_p,
> +		     CLK_IGNORE_UNUSED, RK3572_PLL_CON(0),
> +		     RK3572_MODE_CON1, 0, 15, 0, rk3572_pll_rates),
> +	[lpll] =3D PLL(pll_rk3588_core, PLL_LPLL, "lpll", mux_pll_p,
> +		     CLK_IGNORE_UNUSED, RK3572_LPLL_CON(16),
> +		     RK3572_LPLL_MODE_CON0, 0, 15, 0, rk3572_pll_rates),
> +	[vpll] =3D PLL(pll_rk3588, PLL_VPLL, "vpll", mux_pll_p,
> +		     0, RK3572_PLL_CON(88),
> +		     RK3572_MODE_CON0, 4, 15, 0, rk3572_pll_rates),
> +	[aupll] =3D PLL(pll_rk3588, PLL_AUPLL, "aupll", mux_aupll_p,
> +		     0, RK3572_PLL_CON(96),
> +		     RK3572_MODE_CON0, 6, 15, 0, rk3572_aupll_rates),
> +	[cpll] =3D PLL(pll_rk3588, PLL_CPLL, "cpll", mux_pll_p,
> +		     0, RK3572_PLL_CON(104),
> +		     RK3572_MODE_CON0, 8, 15, 0, rk3572_pll_rates),
> +	[gpll] =3D PLL(pll_rk3588, PLL_GPLL, "gpll", mux_pll_p,
> +		     CLK_IGNORE_UNUSED, RK3572_PLL_CON(112),
> +		     RK3572_MODE_CON0, 2, 15, 0, rk3572_pll_rates),
> +	[ppll] =3D PLL(pll_rk3588_ddr, PLL_PPLL, "ppll", mux_pll_p,
> +		     0, RK3572_PPLL_CON(128),
> +		     RK3572_PPLL_CON(134), 15, 15, 0, rk3572_ppll_rates),
> +};
> +
> +static struct rockchip_clk_branch rk3572_clk_branches[] __initdata =3D {
> +	/* fixed */
> +	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
> +
> +	COMPOSITE_FRACMUX(CLK_32K, "clk_32k", "xin24m", CLK_IS_CRITICAL,
> +			  RK3572_PMU_CLKSEL_CON(21), 0,
> +			RK3572_PMU_CLKGATE_CON(7), 14, GFLAGS, NULL),
> +
> +	FACTOR(0, "clk_spll_div12", "spll", 0, 1, 12),
> +	FACTOR(0, "clk_spll_div6", "spll", 0, 1, 6),
> +	FACTOR(0, "clk_spll_div4", "spll", 0, 1, 4),
> +	FACTOR(0, "clk_spll_div2", "spll", 0, 1, 2),

[Severity: Medium]
Will registering these fixed-factor branches with an id of 0 overwrite the
ppll entry in ctx->clk_data.clks[0]?

In include/dt-bindings/clock/rockchip,rk3572-cru.h, the binding id for ppll
is 0:

    #define PLL_PPLL				0

During rk3572_clk_init() in drivers/clk/rockchip/clk-rk3572.c,
rockchip_clk_register_plls() runs before rockchip_clk_register_branches():

    rockchip_clk_register_plls(ctx, rk3572_pll_clks,
                               ARRAY_SIZE(rk3572_pll_clks),
                               RK3572_GRF_SOC_STATUS0);
    ...
    rockchip_clk_register_branches(ctx, rk3572_clk_branches,
                                   ARRAY_SIZE(rk3572_clk_branches));

When rockchip_clk_register_branches() iterates over rk3572_clk_branches[],
it unconditionally calls rockchip_clk_set_lookup(ctx, clk, list->id) in
drivers/clk/rockchip/clk.h:

    static inline void rockchip_clk_set_lookup(struct rockchip_clk_provider=
 *ctx,
                                               struct clk *clk, unsigned in=
t id)
    {
            ctx->clk_data.clks[id] =3D clk;
    }

Because xin12m (which also has no consumers in this file) and
clk_spll_div12, clk_spll_div6, clk_spll_div4, and clk_spll_div2 all pass 0
as their id, rockchip_clk_register_branches() overwrites
ctx->clk_data.clks[0] with clk_spll_div2. Any device tree consumer
requesting ppll will receive clk_spll_div2 instead.

[ ... ]

> +	MUX(CLK_AUDIO_FRAC_0_SRC, "clk_audio_frac_0_src", gpll_cpll_aupll_24m_p=
, 0,
> +	    RK3572_CLKSEL_CON(13), 0, 2, MFLAGS),
> +	MUX(CLK_AUDIO_FRAC_1_SRC, "clk_audio_frac_1_src", gpll_cpll_aupll_24m_p=
, 0,
> +	    RK3572_CLKSEL_CON(15), 0, 2, MFLAGS),
> +	MUX(CLK_AUDIO_FRAC_2_SRC, "clk_audio_frac_2_src", gpll_cpll_aupll_24m_p=
, 0,
> +	    RK3572_CLKSEL_CON(17), 0, 2, MFLAGS),
> +	MUX(CLK_AUDIO_FRAC_3_SRC, "clk_audio_frac_3_src", gpll_cpll_aupll_24m_p=
, 0,
> +	    RK3572_CLKSEL_CON(19), 0, 2, MFLAGS),
> +	COMPOSITE_FRAC(CLK_AUDIO_FRAC_3, "clk_audio_frac_3", "clk_audio_frac_3_=
src", 0,
> +		       RK3572_CLKSEL_CON(18), 0,
> +			RK3572_CLKGATE_CON(1), 14, GFLAGS),

[Severity: Medium]
Are the fractional divider definitions for clk_audio_frac_0,
clk_audio_frac_1, and clk_audio_frac_2 missing from rk3572_clk_branches[]
here?

In include/dt-bindings/clock/rockchip,rk3572-cru.h, all four fractional
audio clocks and their parent muxes are defined:

    #define CLK_AUDIO_FRAC_0			25
    #define CLK_AUDIO_FRAC_1			26
    #define CLK_AUDIO_FRAC_2			27
    #define CLK_AUDIO_FRAC_3			28
    #define CLK_AUDIO_FRAC_0_SRC		29
    #define CLK_AUDIO_FRAC_1_SRC		30
    #define CLK_AUDIO_FRAC_2_SRC		31
    #define CLK_AUDIO_FRAC_3_SRC		32

However, rk3572_clk_branches[] in drivers/clk/rockchip/clk-rk3572.c only
registers the four source muxes (clk_audio_frac_0_src through
clk_audio_frac_3_src) and clk_audio_frac_3, omitting clk_audio_frac_0,
clk_audio_frac_1, and clk_audio_frac_2.

Because mux_24m_frac_int_mclk4_p, mux_24m_frac_int_mclki_p, and
mux_24m_frac_int_mclki_sclki_p list clk_audio_frac_0, clk_audio_frac_1, and
clk_audio_frac_2 as parents, 13 downstream audio clocks (clk_pdm0_src_top,
mclk_asrc0_src_0, mclk_asrc1_src_1, mclk_pdm0_src_top, mclk_sai0 through
mclk_sai5, and mclk_spdif_tx0 through mclk_spdif_tx2) will fail to resolve
those parents when rk3572_clk_init() -> rockchip_clk_register_branches()
runs, and device tree lookups for those three clock ids will fail to find a
registered clock.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D7
