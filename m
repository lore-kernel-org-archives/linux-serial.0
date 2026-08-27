Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820D44E671
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854597; cv=none; b=R/Q6HhcMo5RaGzq18AXVT3cjh5VctQZkhOe0ISC9EnNP60cQGNYs7aHYXL2JwFDI36NKduxOlSqNPX3cR6J5/N+pS+pii76W0WeXb8vmzU1rmQUXK8yC26bTaHiDQOgyGIJZ8TZhw1B/HNZBkGBmdjmGMzOInGjoJVsH+5M/S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854597; c=relaxed/simple;
	bh=uX5C60reDvRpK36SAxecoaPL1YQjSkOsLOLg47bHsHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4LVE4bBwcV8fgr8U7raKYSlSPRJWx40b/EyryDGUIGBUL/qhov33YbhBx9v1C2RFoaXDRjM1m4SYDyohvxWlnseZczMA/7QV9awNFcjdXHYMw+SH6Jm4cDdTgl170IKQY4snf1faiw+NfyR/3dcrzD0PphrWH8W4qscbx94H5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgTS8znV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgTS8znV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891381F00A3D;
	Thu, 27 Aug 2026 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787854594;
	bh=IZM/+OheTcw+O1O8tHPsRKPiNl89z1PtnrtBP4rRViY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EgTS8znVVyI4Vr41OOA0BDNtaSikn2OpJSv62OPQBRknt9Ku35l9BqgKx+CwEMCrU
	 stofIsPS5TDYLL5lc0x+lnjoCoYSC+XMQ0AfQkB4Ab/jiD3jsMBp4b8V3wHKl0jhHa
	 RSkXRVvoArjpgBeYS1L+Ua7WlmBUHHE19NGaE/B1ODcvOOcygPrDis06Aef8VkR8kM
	 OoE7Ua+OjUlpZgoSjWITvtPNiB9hKoPQuu2KYDuTNGMLY1oBH/rA2Hu+XiMvULzcFz
	 ih+6pjzwP2Us55+M1LH4aBCiGECWVVqCRw+d4z/SmWjaTgPvo3HvJW0uRjSYsdPD5y
	 xAjm063Ycc7LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:16:34 +0000
Message-Id: <20260827181634.891381F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Returning success for performance state 0 without notifying the =
SCMI hardware causes a power leak and genpd state desynchronization.
--

commit 2b6c1834f31c5a0d438704d927e8d116c0dd29ad
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0

The commit modifies scmi_pd_set_perf_state() to return 0 (success) instead
of -EINVAL when the requested performance state is 0. This change aims to
accommodate the OPP framework which uses state 0 when a device is runtime
suspended.

> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9c..e390f902a4442 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>  		return 0;
> =20
>  	if (!state)
> -		return -EINVAL;
> +		return 0;

[Severity: Medium]
Will this return 0 without notifying the SCMI hardware of the state change?

Since SCMI performance domains are marked with GENPD_FLAG_ALWAYS_ON, they a=
re
never actually powered off. When all devices in the domain suspend and genpd
aggregates the state to 0, it invokes scmi_pd_set_perf_state() with state 0.

If we immediately return 0 here without calling pd->perf_ops->level_set(),
no request is sent to the firmware.

Does this cause the hardware to get stuck at its last requested
high-performance level instead of scaling down, leading to a silent power
leak and a desynchronization between genpd software state and the hardware?

> =20
>  	ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com?par=
t=3D1
