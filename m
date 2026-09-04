Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A32AD37;
	Fri,  4 Sep 2026 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504829; cv=none; b=gH8d7V7kCYfw/nQFQbCz5MSqJHHl4gLIqrmH0V+hs4oa/SN+0bElYt+LgVd3uRyN0+8RfreqRVa93y5zsCQJgmY5VBt+JBt+9JKb/SbnhKWdwHeJhAL+QlA529z44IXkEPA9c7HWgjRFKJMKAyTD99l4rOuiM2ZE4Ogjf8BmKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504829; c=relaxed/simple;
	bh=8cq0ooiTHJt7hD/hDEeVhlYQ2ibIyJSmC9xxYIXB+RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5NqHTpXKDaGgiP4KICToB+80lZB0m0otnKjv0QOmWOzjUBjgZJXJm62WLfjDuiRx6uLLoKSs97+4558CFUMPq58IfqPAwqzXjO31jGYaejq99ae5tZC8goBgQl1FOWviwhfH29eIub2l5t3OzhwrCdOaTIb4N3uGgvaJuHmwEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXweSKem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXweSKem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3D71F00A3D;
	Fri,  4 Sep 2026 06:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504827;
	bh=2Hepebi5e8drCyFV2H5f329x72RUqL9PfcI5LAhgKGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXweSKemxDEbOrqRd27rWfjjVbh5ptd1FYMdY5vEO+LVvvs6hhCkihjFXRBxsmNOx
	 HfNIm3hIgC/6m+IVfFg4n50aQVV2UwkKjnoBMQip6JbBxMQaMJdBNn2V+1dyK4BX3u
	 EoR4kr9hqJSrw3aDf30Vfq0SVRAas9Ik1kxvFZFKONN8BwF7LFJoukSUTmmf6yy0ih
	 rbbaKTMnd3MinOraxNO+SzA+bXtZDf7AOiSwv427lGoG5pEhs7yWM5Ay5j0d8q9eiy
	 EhR6m4/ScQd7i0Esgb0u/UMWv/zQJiM+azOTWQMhIjsf65zw96SKl4uVvajWbk0nNK
	 GNJj/20F3UO6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] clk: ambarella: add CV75 CCU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Zhao" <longzhao@ambarella.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, lee@kernel.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260904-cv75-v5-v6-7-e918514cb3b1@ambarella.com>
References: <20260904-cv75-v5-v6-0-e918514cb3b1@ambarella.com>
 <20260904-cv75-v5-v6-7-e918514cb3b1@ambarella.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:53:46 +0000
Message-Id: <20260904065347.4B3D71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Hardcoded `ctrl_val =3D 0` breaks parameter configuration for PLL =
v2.
- [High] `amb_pll_determine_rate` bypasses rate validation and clamping for=
 fractional PLLs.
- [High] Out-of-bounds write in `ccu->data->hws` array due to improper boun=
ds allocation.
- [High] `amb_pll_set_rate` calculates the VCO range using stale hardware r=
egister state.
- [High] PLL `pre_scaler` and `post_scaler` are ignored during parameter ca=
lculation.
- [Medium] Clock gating/power down is improperly implemented via `set_rate(=
0)`.
- [Low] Bypassing clock framework abstractions using `__clk_get_hw()`.
--

commit 54fae2ddb7651a9b5e3a861a2b9b96fa672eb7cb
Author: Long Zhao <longzhao@ambarella.com>

clk: ambarella: add CV75 CCU driver

Add the Ambarella CV75 clock driver covering the core PLL and the
UART0 / AHB / APB clocks needed for early console bring-up.

> diff --git a/drivers/clk/ambarella/ccu-cv75.c b/drivers/clk/ambarella/ccu=
-cv75.c
> new file mode 100644
> index 0000000000000..c4828be598be2
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu-cv75.c
[ ... ]
> +static int amb_cv75_rct_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	osc_clk =3D devm_clk_get(&pdev->dev, "osc");
> +	if (IS_ERR(osc_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(osc_clk),
> +				     "missing osc clock\n");
> +	osc =3D __clk_get_hw(osc_clk);

[Severity: Low]
Is unwrapping the consumer clock pointer directly via __clk_get_hw()
bypassing the CCF abstractions? Could this be avoided by referencing
the parent natively via struct clk_parent_data (e.g., using=20
.fw_name =3D "osc"), as the driver already does for composite clocks?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(cv75_clks); i++) {
> +		hw =3D amb_cv75_register_clk(&pdev->dev, ccu, &cv75_clks[i],
> +					   osc, dummy);
> +		if (IS_ERR(hw))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
> +					     "failed to register %s\n",
> +					     cv75_clks[i].name);
> +
> +		if (cv75_clks[i].id =3D=3D AMB_CV75_CLK_REF_DUMMY)
> +			dummy =3D hw;
> +		else
> +			ccu->data->hws[cv75_clks[i].id] =3D hw;

[Severity: High]
Does this code risk an out-of-bounds write?

The ccu->data array is allocated based on the number of elements:

drivers/clk/ambarella/ccu_common.c:amb_ccu_init() {
    ...
    ccu->data =3D devm_kzalloc(&pdev->dev,
                             struct_size(ccu->data, hws, num_clks),
                             GFP_KERNEL);
    ...
}

However, the array is indexed here using the id from the DT bindings
(cv75_clks[i].id). If the binding IDs are sparse or start from 1, the max
ID could exceed the array size (ARRAY_SIZE(cv75_clks)), corrupting memory.

> +	}
> +
> +	return amb_ccu_register(ccu);
> +}
[ ... ]
> diff --git a/drivers/clk/ambarella/ccu_mux_div.c b/drivers/clk/ambarella/=
ccu_mux_div.c
> new file mode 100644
> index 0000000000000..d5259bc347e43
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_mux_div.c
[ ... ]
> +static int amb_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct amb_div *div =3D to_amb_div(hw);
> +	int val, mask;
> +
> +	if (div->fix_divider)
> +		rate *=3D div->fix_divider;
> +
> +	if (!rate) {
> +		/* Assert the reset/disable bit above the divider field. */
> +		val =3D BIT(div->width);
> +		mask =3D clk_div_mask(div->width + 1);
> +	} else {

[Severity: Medium]
Is clock gating properly handled here? By placing the power-down logic=20
inside .set_rate(0) without providing standard .enable and .disable=20
callbacks in clk_ops, standard drivers calling clk_disable_unprepare()=20
will leave the hardware powered on.

> +		val =3D divider_get_val(rate, parent_rate, NULL,
> +				      div->width, div->flags);
[ ... ]
> diff --git a/drivers/clk/ambarella/ccu_pll.c b/drivers/clk/ambarella/ccu_=
pll.c
> new file mode 100644
> index 0000000000000..76452003bb0d0
> --- /dev/null
> +++ b/drivers/clk/ambarella/ccu_pll.c
[ ... ]
> +static int amb_pll_calc_params(struct amb_pll *pll, unsigned long rate,
> +			       unsigned long parent_rate, u32 ctrl2_val,
> +			       u32 *intp, u32 *sdiv, u32 *sout,
> +			       u32 *vcodiv, u32 *fsdiv, u32 *fsout)
> +{
> +	const struct amb_pll_soc_data *soc_data =3D pll->soc_data;
> +	unsigned long max_numerator, max_denominator;
> +	unsigned long intp_ul, sout_ul, rate_tmp, parent_scaled;
> +	u32 ctrl_val;
> +
> +	if (!parent_rate)
> +		return -EINVAL;
> +
> +	*sdiv =3D 1;
> +
> +	if (soc_data->pll_version >=3D 2) {
> +		ctrl_val =3D 0;
> +		*vcodiv =3D (ctrl_val & soc_data->vcodiv_mask) =3D=3D
> +			  soc_data->vcodiv_val ? 2 : 1;

[Severity: High]
Because ctrl_val is hardcoded to 0 here, the bitwise AND operations=20
statically evaluate to 1 for vcodiv, fsdiv, and fsout on v2 PLLs.=20
Does this incorrectly restrict v2 PLLs to use dividers of 1 and ignore=20
existing hardware configurations?

> +		*fsdiv =3D (ctrl_val & soc_data->fsdiv_mask) =3D=3D
> +			 soc_data->fsdiv_val ? 2 : 1;
> +		*fsout =3D (ctrl_val & soc_data->fsout_mask) =3D=3D
> +			 soc_data->fsout_val ? 2 : 1;
> +	} else {
[ ... ]
> +	if (rate < parent_rate)
> +		return -EINVAL;
> +
> +	max_numerator =3D soc_data->vco_max_mhz;
> +	max_numerator =3D div_u64(max_numerator * 1000000ULL, parent_rate);

[Severity: High]
Does this calculation operate directly on the unscaled parent_rate?=20
It appears that reg[PRES_OFFSET] and reg[POST_OFFSET] are completely=20
ignored here. Will this result in incorrect PLL parameters if a PLL=20
instance is configured with non-zero prescalers or postscalers?

> +	max_numerator =3D div_u64(max_numerator, *vcodiv * *fsdiv);
> +	max_numerator =3D min(128UL, max_numerator);
[ ... ]
> +static int amb_pll_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	struct amb_pll *pll =3D to_amb_pll(hw);
> +	const struct amb_pll_soc_data *soc_data =3D pll->soc_data;
> +	u32 ctrl2_val =3D 0;
> +	u32 intp, sdiv, sout, vcodiv, fsdiv, fsout;
> +	unsigned long rate;
> +	u64 rounded;
> +	int ret;
> +
> +	if (!req->best_parent_rate)
> +		return -EINVAL;
> +
> +	if (!req->rate || pll->frac_mode)
> +		return 0;

[Severity: High]
Does returning 0 immediately for fractional PLLs bypass mandatory rate=20
clamping and boundary validation? It looks like the framework could pass=20
unbounded or unachievable rates down to the hardware, which would later=20
fail the VCO limits in amb_pll_calc_params().

> +
> +	if (req->rate > ULONG_MAX / pll->fix_divider)
> +		return -ERANGE;
[ ... ]
> +static int amb_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct amb_pll *pll =3D to_amb_pll(hw);
> +	const struct amb_pll_soc_data *soc_data =3D pll->soc_data;
> +	u32 *reg =3D pll->reg_offset;
> +	u32 ctrl_val, ctrl2_val =3D 0, ctrl3_val, frac_val =3D 0;
> +	u32 intp, sdiv, sout, vcodiv, fsdiv, fsout;
> +	unsigned long old_rate, new_rate, rate_tmp;
> +	int ret;
> +
> +	if (!rate) {
> +		regmap_read(pll->map, reg[CTRL_OFFSET], &ctrl_val);
> +		ctrl_val |=3D CTRL_POWER_DOWN | CTRL_HALT_VCO;
> +		amb_pll_write_enable(pll->map, reg[CTRL_OFFSET], ctrl_val);
> +		return 0;
> +	}

[Severity: Medium]
Similarly to the divider above, is clock gating properly handled here?=20
Calling .set_rate(0) instead of implementing .disable and .enable=20
callbacks leaves the clock powered on if a standard CCF driver calls=20
clk_disable_unprepare().

> +
> +	if (!parent_rate)
> +		return -EINVAL;
[ ... ]
> +	ctrl_val =3D ((intp - 1) & 0x7f) << 24;
> +	ctrl_val |=3D ((sdiv - 1) & 0xf) << 12;
> +	ctrl_val |=3D ((sout - 1) & 0xf) << 16;
> +	if (soc_data->pll_version >=3D 2) {
> +		ctrl_val |=3D vcodiv =3D=3D 2 ? soc_data->vcodiv_val : 0;

[Severity: High]
Because the vcodiv parameter (along with fsdiv and fsout) was computed=20
with a hardcoded 0 in amb_pll_calc_params(), will this write those=20
incorrectly calculated bits back to the hardware and destroy the=20
existing divider configuration?

> +		ctrl_val |=3D fsdiv =3D=3D 2 ? soc_data->fsdiv_val : 0;
> +		ctrl_val |=3D fsout =3D=3D 2 ? soc_data->fsout_val : 0;
> +	}
> +
> +	regmap_write(pll->map, reg[CTRL_OFFSET], ctrl_val);
> +	regmap_write(pll->map, reg[FRAC_OFFSET], 0);
> +
> +	old_rate =3D amb_pll_recalc_rate(hw, parent_rate) * pll->fix_divider;
> +	rate_tmp =3D old_rate > rate ? 0 : rate - old_rate;
> +	if (rate_tmp && pll->frac_mode) {
> +		u64 dividend, divider;
> +
> +		dividend =3D (u64)rate_tmp * sout * fsout;
> +		dividend <<=3D 32;
> +		divider =3D (u64)sdiv * fsdiv * parent_rate;
> +		frac_val =3D DIV64_U64_ROUND_CLOSEST(dividend, divider);
> +		regmap_write(pll->map, reg[FRAC_OFFSET], frac_val);
> +		ctrl_val |=3D CTRL_FRAC_MODE;
> +	}
> +
> +	if (soc_data->pll_version >=3D 2) {
> +		ctrl3_val =3D soc_data->ctrl3_val;
[ ... ]
> +	} else {
> +		u32 fvco_mhz, range;
> +
> +		fvco_mhz =3D amb_pll_calc_vco(pll, parent_rate) / 1000000UL;

[Severity: High]
Does amb_pll_calc_vco() use stale register state here? The ctrl_val was=20
updated with CTRL_FRAC_MODE locally, but it hasn't been written to the=20
hardware yet. Because amb_pll_calc_vco() performs a direct regmap_read=20
of CTRL_OFFSET, it will miss the fractional component, leading to an=20
incorrect VCO range assignment for the CTRL3 register below.

> +		for (range =3D 0; range < ARRAY_SIZE(soc_data->vco_range);
> +		     range++) {
> +			if (fvco_mhz > soc_data->vco_range[range])
> +				break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-cv75-v5-v6=
-0-e918514cb3b1@ambarella.com?part=3D7
