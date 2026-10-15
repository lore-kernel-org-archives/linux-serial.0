Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32A22CBE6
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070412; cv=none; b=u1cWibCn5UWF0Re78gOyeRfy8LW/u26DppdY9u6RSIn1NY0VT1LQYWn7hg7vfi+8LEOPrv46+WK1CfDWW+jHZYqIPduJ2d8RJL/erPkOfEZ+r6aYVC2+o0IQjX6yIvnyukyK0D42N/h7TC9kOzZmwWCyB7paWLNJG5RnIPnBe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070412; c=relaxed/simple;
	bh=XeRGTr94OgRbHhY0FQOi6wN7cDI4DYiIFG58IyK4cgo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qjkcL7df4H6sEiZNqbM0IpwM374PdAaEfDFxdaV8dtVDJEYNRLZjKt0uJP/zhMqQwtrY3ZC3Xmm3PMph9Uzl3MvJFnhEBKfnz4LG7YzS+N2fd4QEXPtCkRJbuprM8cp9v4jhFTHJO0aFO8pRug04x3yB/+S72f4jwtD+ugOx7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKWudimw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKWudimw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF0C1F000C5;
	Thu, 15 Oct 2026 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070411;
	bh=1StyblGGDq7zgG/eIP0+vRN2aMeyLvYUL7MM+yzoCRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GKWudimwTls/jqQ0mcReAtq6cUr1CGiSps8LWpYwIr7o06ySLN8GG3SYnSzhnz+Qu
	 BfnEfcFwKZloZKu6ydt+VZiy1jI03RN7/tdsfOOcOgXYigaymiSao3EsQO+9M8W9pi
	 aFKxvqcAa9VkyjZ+SszcledrIbfuRdn2N00FXZA3jEkX2l2IU0pgO4oLoeoyATkLgi
	 ndFzcQ2p0dP7CtE4o0C1d0O1ZEjib5En3ADpVs1p6pNWlqdpOnYCCM8mdJ0naZ0kvU
	 R1Bs1bMbgXRBrF+QRqV80p0or9R/hKbXbqUWnafO/45gUVGLpUUKGt0PFYaVhU6oaS
	 RWOPHrE5433rQ==
Message-ID: <sashiko-outbox-172924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] i2c: qcom-geni: Use common GENI resource
 initialization helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-7-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-7-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:20:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] i2c: qcom-geni: uninitialized src_freq bypasses OPP vote before hw=
 access
- [High] i2c: qcom-geni: severe lock contention by calling icc_set_bw per-t=
ransfer
- [Medium] i2c: qcom-geni: leak of GPI DMA channels on clk map error path
--

commit 78a289de1b8e5415a287115753c631aba3c4355a
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

i2c: qcom-geni: Use common GENI resource initialization helper

This commit replaces a custom resource initialization callback with
geni_se_resources_init(). It moves clock frequency validation and ICC
bandwidth vote programming to probe and qcom_geni_i2c_conf() respectively.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index a6fe89d0934f6..dbe344719b86c 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -275,7 +275,9 @@ static int qcom_geni_i2c_conf(struct geni_se *se, uns=
igned long freq)
>  	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
>  				 itr->clk_div, itr->t_high_cnt,
>  				 itr->t_low_cnt, itr->t_cycle_cnt);
> -	return 0;
> +
> +	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> +				  Bps_to_icc(gi2c->clk_freq_out));
>  }

[Severity: High]
Could this introduce severe lock contention?

The geni_i2c_xfer() handler invokes this configuration function on every ba=
tch
of messages. Moving geni_icc_set_bw_ab() into qcom_geni_i2c_conf() means
icc_set_bw() is now called on every I2C transfer.

Because icc_set_bw() unconditionally acquires the global icc_bw_lock mutex
and iterates through interconnect nodes, will this rapidly acquire and
release a global interconnect lock during normal I2C operations, throttling
the rest of the system?

[ ... ]

> @@ -1251,6 +1237,11 @@ static int geni_i2c_probe(struct platform_device *=
pdev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D geni_i2c_clk_map_idx(gi2c);

[Severity: High]
Does moving geni_i2c_clk_map_idx() after geni_i2c_init() leave gi2c->src_fr=
eq
uninitialized when hardware is first accessed?

When geni_i2c_init() calls pm_runtime_resume_and_get(), it triggers
geni_i2c_runtime_resume() which checks gi2c->src_freq:

	if (gi2c->src_freq) {
		ret =3D dev_pm_opp_set_rate(dev, gi2c->src_freq);
		if (ret)
			return ret;
	}

Because gi2c->src_freq is 0 at this point, the OPP performance state vote is
silently bypassed. geni_i2c_init() then immediately accesses hardware regis=
ters.
On Qualcomm platforms, could this un-voted access result in a NoC timeout or
system crash?

> +	if (ret)
> +		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n=
",
> +				     gi2c->clk_freq_out);

[Severity: Medium]
Does this path leak the GPI DMA channels?

geni_i2c_init() allocates RX and TX channels via setup_gpi_dma() when the
device is in GPI mode. When geni_i2c_clk_map_idx() fails here, we return
the error directly without calling release_gpi_dma() to clean up the
allocated channels, unlike the i2c_add_adapter() error path directly below =
it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D7
