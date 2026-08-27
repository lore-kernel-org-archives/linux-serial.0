Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED5472547
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854622; cv=none; b=IMbpp3R2Vtd57Udb2+uF3dOqJnECq3YxesUY7WTPpDLsQFMAi9970H+fjzSnb57W12uKyrAZyMhFG1Gibt6+2kvFjIhw1n9kEix1EvNhV0/9blrtStdynOagtme/+JjyFOHGUudNh0UZXLetGOcMsRFRNuNNjGlSON7UewfW6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854622; c=relaxed/simple;
	bh=FvQN3QQrJRzJCRGzhDeCDbwvBrGPYAB7wo1ChKVwKEY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3l4CudBSofZ1YFv+ScAVn6QtHFLreYZ19Y99hTL1mQXrFmVsEuVJ8aqKlmMIVeoTNs4lQv+dEl62o0WVa75Eob88RnuaP98vR+20/cIHWLut6irdMXzkEDezVyJfYFb+B3q68zy9xXPhpPQHYtIIkVYlqnwzruzqxaRyM8l8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE8pmIHT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE8pmIHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B941F000E9;
	Thu, 27 Aug 2026 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854620;
	bh=vVBnLepYhRpMpuH4DxlR018ZAk75+SWhvvEzKArF8+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jE8pmIHTV+KG10/0BbQWaaP9KWKdFnqEZNFdMbWir6dYQXvRed3yy8v1C0xE7EgYX
	 BbrSih4+kY+mk56WyjnP8ST8gTJ2ibhfbN5mq94EPp1pFKbWaKm9AC38zjYOs1Z3om
	 BgIwWVFzLBfl0N4rq33yhRE7oaV1xKo/VGMisXpHBv0eHKIFzpIeH8ogFjXDGa7Bza
	 0yC8tHL/mlEYK03otimhV/GjTRX9/DQuP/XsmpwpSCmLzfpXX8mdyzOlLH11GLD2xB
	 3VuKzNUUTJGaNn400YToTFb03QihBV+7X6QepwIGxmN5swWZctp4Zj/Dgf7FjkyEtz
	 6cfHA502oWGPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/9] soc: qcom: geni-se: Populate clk_perf_tbl with
 SE source clock frequencies from perf OPP table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:16:59 +0000
Message-Id: <20260827181700.53B941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Populating `clk_perf_tbl` with OPP performance levels instead =
of frequencies breaks clock divider math, introduces division-by-zero risks=
, and fails `dev_pm_opp_set_rate()`.
- [High] Fragile OPP iteration loop will fail the probe if the OPP table co=
ntains duplicate levels.
--

commit f430a1f0dd5802c00d71aa7a1d541115aa32fe57
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies =
from perf OPP table

This commit populates clk_perf_tbl with SE source clock frequencies
from the perf OPP table. It treats the OPP table as the actual SE hardware
supported source clock frequencies, allowing protocol drivers to compute
the correct source clock and divider.

> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 873bfbd6b2b7b..447b9cc6babf6 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
[ ... ]
> @@ -1175,6 +1181,31 @@ int geni_se_domain_attach(struct geni_se *se)
>  	else if (ret < 0)
>  		return ret;
> =20
> +	perf_dev =3D se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	num_opps =3D dev_pm_opp_get_opp_count(perf_dev);
> +	if (num_opps < 0)
> +		return num_opps;
> +	if (num_opps =3D=3D 0)
> +		return -ENODEV;
> +
> +	se->clk_perf_tbl =3D devm_kcalloc(se->dev, num_opps,
> +					sizeof(*se->clk_perf_tbl),
> +					GFP_KERNEL);
> +	if (!se->clk_perf_tbl)
> +		return -ENOMEM;
> +
> +	for (i =3D 0, level =3D 0; i < num_opps; i++, level++) {
> +		opp =3D dev_pm_opp_find_level_ceil(perf_dev, &level);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);

[Severity: High]
Does this iteration loop safely handle duplicate or missing OPP levels?

If the OPP table contains duplicate levels (e.g., same performance state but
different voltages), or if opp-level is unpopulated for some entries,
dev_pm_opp_find_level_ceil() will skip the duplicates.

This means the loop will run out of unique levels before 'i' reaches
'num_opps', returning -ERANGE or -ENODEV and failing the entire GENI SE pro=
be.

[Severity: Critical]
Does fetching the OPP performance level here instead of the clock frequency
break the clock divider math later on?

When this loop uses dev_pm_opp_find_level_ceil() instead of
dev_pm_opp_find_freq_ceil(), it retrieves abstract performance levels
(which can be 0 for OFF/minimum states) rather than actual Hz frequencies.

> +
> +		se->clk_perf_tbl[i] =3D level;

These performance levels are then stored in se->clk_perf_tbl, which is meant
for Hz frequencies.

When protocol drivers call geni_se_clk_freq_match() to configure their sour=
ce
clock, the following math is used:

	divider =3D DIV_ROUND_UP(tbl[i], req_freq);
	new_delta =3D req_freq - tbl[i] / divider;

If a performance level in tbl[i] is 0, 'divider' evaluates to 0, which leads
to a divide-by-zero kernel panic.

Even if the level is non-zero, it is treated as a tiny frequency, causing
dev_pm_opp_set_rate() to either fail with -ERANGE or force the clock to its
minimum state, breaking serial communication.

Should this use dev_pm_opp_find_freq_ceil() to populate the table with
opp-hz instead?

> +		dev_pm_opp_put(opp);
> +	}
> +	se->num_clk_levels =3D num_opps;
> +	se->has_opp =3D true;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D2
