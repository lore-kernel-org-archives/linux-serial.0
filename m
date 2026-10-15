Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506B5208D9
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070685; cv=none; b=MHCm6sKJ9+I2tl4zSpCc7+7JqT2KgeNW21fBkGYKPgpCE/CzEMWygDgl3ST8ZKIdSLth6lFbkGO5AAbmMcD488dSoH7UrVPNZMmB+SVcDU26bJ/ZDJjqcRjN+t/lTZrQnntkRQtNkexoXsTK2dDNdE/gyrhAOQJz+RabT5o3cuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070685; c=relaxed/simple;
	bh=p/xSL6yln0TSJPyJiJ4Qq0xuTRWmhemzlvLCyti/nb8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GhjRwRukDc31t+F7ehNeBeaTJIFuyaHlvEztJzhKAqy4XroJc3D8a2S1BI9DK+6S5Fn2alrHRtJkiGrL3J77QzHY0GPTd+/xHrsd8UaSYrRhSybXl9q0ENN7AppV+WG44dtpc0lbsSBiA67mxqZVOmtZxWRukNLucbN/zN/nEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyy9A7dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyy9A7dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786231F000C5;
	Thu, 15 Oct 2026 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070684;
	bh=KEU0IUJWkNjgAzkqD9LGZE+pI9MEncbsh8dZhXbBAsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fyy9A7dlcllAnb206DsxHySWardVIasY/gvDS0zFVxkNxA06D9Q+Ytp4gn8iXdhJA
	 V8jEOxFY8Vx1AwKROIsQYEdOILG4ML9ljFwATP9NssCi0DC/Yx88T/P+1R1EiHhY9a
	 f4UYUZIS5bhURc0GwVvg0KwGFeu2gyqTo8QQJnjpuOh78TL1p5gXRlZmpSeT7/mH7e
	 WGwPJDg1FxGG9xsaHXyqqZYI9Kb4W+vnhnxC6fEuhE82ZqvG+pLAmSURoogLA9LL/A
	 T/PzKz07Xq8kBWKqyYG2pSVa/BtcCz3WGij1mwNHl81CKds73E/LFjK789F0bcQGN6
	 2X//NrRVy0Y2Q==
Message-ID: <sashiko-outbox-172926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] i2c: qcom-geni: Use geni_se_set_rate() for
 setting source clock frequency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-8-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-8-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:24:44 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] i2c: qcom-geni: severe overhead from per-transfer ICC/OPP voting
- [Medium] i2c: qcom-geni: DMA channel leak on clk_map error path
- [Low] i2c: dead code in struct geni_i2c_desc after removing set_rate usage
--

commit 180f114c4a84db9299622afd7b4abba3adcdb2b5
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: i2c: qcom-geni: Use geni_se_set_rate() for setting source clock fr=
equency

This patch switches the GENI I2C driver to use geni_se_set_rate() instead of
platform-specific callbacks for source clock programming. It performs the
source clock configuration from qcom_geni_i2c_conf(), abstracting the
underlying resource management and unifying the code path across platforms.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index dbe344719b86c..4879170a12576 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[ ... ]

> @@ -1042,7 +1041,7 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>  		return ret;
>  	}
> =20
> -	ret =3D gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
> +	ret =3D qcom_geni_i2c_conf(&gi2c->se);
>  	if (ret)
>  		goto out_pm;
> =20

[Severity: High]
Is there a significant performance regression from moving the interconnect
bandwidth vote and OPP setting into qcom_geni_i2c_conf()?

Because qcom_geni_i2c_conf() is now called unconditionally on every I2C
transaction via geni_i2c_xfer(), the interconnect and OPP frameworks are
invoked per transfer. This acquires global mutexes (like icc_bw_lock) and
recalculates hardware constraints, which could introduce massive overhead on
this hot path.

[ ... ]

> @@ -1345,7 +1344,6 @@ static const struct dev_pm_ops geni_i2c_pm_ops =3D {
> =20
>  static const struct geni_i2c_desc geni_i2c =3D {
>  	.resources_init =3D geni_se_resources_init,
> -	.set_rate =3D qcom_geni_i2c_conf,
>  	.power_on =3D geni_se_resources_activate,
>  	.power_off =3D geni_se_resources_deactivate,
>  };
> @@ -1354,14 +1352,12 @@ static const struct geni_i2c_desc i2c_master_hub =
=3D {
>  	.no_dma_support =3D true,
>  	.tx_fifo_depth =3D 16,
>  	.resources_init =3D geni_se_resources_init,
> -	.set_rate =3D qcom_geni_i2c_conf,
>  	.power_on =3D geni_se_resources_activate,
>  	.power_off =3D geni_se_resources_deactivate,
>  };
> =20
>  static const struct geni_i2c_desc sa8255p_geni_i2c =3D {
>  	.resources_init =3D geni_se_domain_attach,
> -	.set_rate =3D geni_se_set_perf_opp,
>  };

[Severity: Low]
Is the set_rate function pointer now dead code?

The patch completely removes the initialization of .set_rate from all
geni_i2c_desc instances, but it leaves the function pointer inside
struct geni_i2c_desc:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_desc {
    ...
    int (*resources_init)(struct geni_se *se);
    int (*set_rate)(struct geni_se *se, unsigned long freq);
    int (*power_on)(struct geni_se *se);
    ...
}


I also noticed a resource leak in geni_i2c_probe() that appears to have been
introduced earlier in this series when geni_i2c_clk_map_idx() was moved:

drivers/i2c/busses/i2c-qcom-geni.c:geni_i2c_probe() {
    ...
    ret =3D geni_i2c_init(gi2c);
    if (ret < 0)
        return ret;

    ret =3D geni_i2c_clk_map_idx(gi2c);
    if (ret)
        return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d H=
z\n",
                     gi2c->clk_freq_out);
    ...
}

[Severity: Medium]
Are the GPI DMA channels leaked on this error path?

This problem wasn't introduced by this patch, but a previous commit in this
series moved geni_i2c_clk_map_idx() into geni_i2c_probe() after
geni_i2c_init().=20

geni_i2c_init() allocates GPI DMA channels via setup_gpi_dma() if FIFO is
disabled. If geni_i2c_clk_map_idx() then fails, the probe function returns
immediately without calling release_gpi_dma(), causing a leak of the
allocated channels.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D8
