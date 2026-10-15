Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5C2F9984
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069851; cv=none; b=D8oR5OqKHfTu88FGX9ZUcyZeeJYCNMnundP9ZBDHOXrgcx+6Xk5sXbHb9+inx0tslkcRME514Dy/BeZpJk+sW61LNnvodaL2A2tPBXPb/54vpeCLCj9Hc/coZEhh8vWbR6yeZRf13aeUyH35H1b0kJhjke5rbFMDN2cndO4lJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069851; c=relaxed/simple;
	bh=DNigvX3T+h5Y4xU43wmiNRL+PNX2Tx7CTpxHkCeF/OM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qL/4yD5V/xznVkiINch4h4m53vYt6XV/LhMaPyhg6Jv0a+Cxn7VOtcdXK3mxcQ+cbkOhDlwzwP11tVgyOxhfE5YMwsDxkV5eF4fQh8IcHdrHUyesxuFr9zGXsBcRh4WYdoO7HktABN2OFLooa/AMPolwRzaBlnGVooXyT2iPLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWDXuE1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWDXuE1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594B51F000C4;
	Thu, 15 Oct 2026 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069850;
	bh=/niNXQzyZBt2VwM2dvCCmWur/5nlSswhZ/D2BF01pk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWDXuE1S08QvS/kIaC6EJdYu9T9hlKiT/Xd0hizuPoR2JSpHDe7HDlXdIq4sgRlOt
	 HZRiknKGR8nNFS5LeetiDhVfuH+ewnYg4qOAS0wd2/IHQ5AdyFirGCM+iaxZtnO60J
	 3uGNgOt8sd/xdycVemnljsdI8eTcz5tXm4ABpLlLhzQS4rRMWN48erogB7SRn7os/C
	 dwfydgGMk4ABhYMbKrNjeml07+FkcpD+u17AKtdnkAgBBnh11Zy+stbLADU8iaq5D+
	 lwOJeBraUmlBVwrq5w/FmaJVzVirmD6PgMkYE4jexNyMOTkWPb9JzEk2gCS7Zikbyv
	 pzg7WNdAoxgXA==
Message-ID: <sashiko-outbox-172901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with
 SE source clock frequencies from perf OPP table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:10:49 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] soc: qcom: geni-se: clk_perf_tbl populated with OPP levels instead=
 of frequencies
--

commit 2006551310c45129142551fa77079692b29b39f8
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies =
from perf OPP table

This commit aims to populate clk_perf_tbl using the OPP table exposed on
the perf domain device. This is intended to allow protocol drivers on the
firmware managed path to calculate required dividers and pick supported
source clock frequencies similarly to the Linux clock managed path.

> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni=
-se.c
> index 074087c592cc3..95eeb9438a292 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
[ ... ]
> @@ -1170,7 +1171,12 @@ int geni_se_domain_attach(struct geni_se *se)
[ ... ]
> +	level =3D 0;
> +	for (i =3D 0; i < num_opps; i++) {
> +		opp =3D dev_pm_opp_find_level_ceil(perf_dev, &level);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +
> +		se->clk_perf_tbl[i] =3D level;

[Severity: High]
Does this populate clk_perf_tbl with abstract performance levels instead of
actual clock frequencies?

The commit message states clk_perf_tbl should be populated with actual sour=
ce
clock frequencies so protocol drivers can calculate dividers and set the ra=
te
via dev_pm_opp_set_rate(). However, by using dev_pm_opp_find_level_ceil()
in geni_se_domain_attach(), it appears this loop stores the performance
level (an abstract index like 16 or 64) rather than the frequency in Hz.

For SCMI performance domains, this abstract level will break the divider ma=
th
in geni_se_clk_freq_match(), leading to massive deltas or invalid dividers.
It will also cause dev_pm_opp_set_rate() to receive tiny abstract levels
instead of Hz. Because dev_pm_opp_set_rate() searches the OPP table for a
matching frequency, passing the abstract level will incorrectly match the
lowest available frequency and likely break protocol communication.

Should this use dev_pm_opp_find_freq_ceil() and track a frequency variable
to store the actual rates in clk_perf_tbl?

> +		dev_pm_opp_put(opp);
> +		level++;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D1
