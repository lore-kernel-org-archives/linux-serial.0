Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303A2857EA
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070317; cv=none; b=BVB3WcIWGS10lpBPf2WAsuxdqXBaZEMJPT09ubcWIdr8Do+CjOswJ+c0rOaoPZTlcpQNLYqyjecufi3tNRn4xDEaRyyfCMdJVIfNWIsd/D2N8Zzksx7S578KAe1PxqPAfh/juR95psto4PIH+M3l02MPnHGzWA+AYMOo6H1Wu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070317; c=relaxed/simple;
	bh=EiNI1fcXFOf1aibBAIk1kwwhQtoMeOZzO/I6UXLHg/k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ptYLMTLxH8Kw/gJB60ZrfLuWo3S/hT4vrFSv7mS9thhZBenHD5e0b77/UXbwSvfs/2+sULzjDp/ClL5MmFzvJpJtslouyQVqM9X41FDMMn+8/UU2ojNc/hFzdhi4nyXUUWjr+qs+BDLokBgkCuKO8ry6OI1TYXW9pmbyEG083a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgOpVYiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgOpVYiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D61F000C4;
	Thu, 15 Oct 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070315;
	bh=AHKWeCD9skxkLzZyducL4Xh8uRKiDdRlKeB+aAc0Z2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VgOpVYiyr84xJXXW77QL0xauBujnMf7GO1FG5WZnbcwU4oP2WzCXgeHfQNWNafvPZ
	 CzLwjBRwQRTGmTmR6nGJkgE66fJ/inWMyAsz5xFztu5eDsg3VyqUsB+AOM+zdr8fGH
	 Mn8THu1upbW0xQGyIqgdRz2cIiRiSALfgPKxlatS8kRciOHmIBcTjT9xfOVhVaFO/2
	 mI/6KxGZzNzoHi6V34ssAFXrFc0FGJBf+LkRSeqMxxxVtbMbAbehUfIUY1Ft/mOIZL
	 8DcCUQpbOzr+lnixkH34H5MkdzOC6v+8pOOfC/ZcTbDN4QzoUBHhLFvwunczwBx2/i
	 U0RRhVTtFQBsA==
Message-ID: <sashiko-outbox-172909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] i2c: qcom-geni: Vote for SE clock rate using OPP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Praveen Talari" <praveen.talari@oss.qualcomm.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-6-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 13:18:35 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] i2c: qcom-geni: missing power_off rollback on opp_set_rate failure=
 in resume
- [High] i2c: qcom-geni: PM state desync on opp_set_rate failure in suspend
- [High] i2c: PM desync in suspend causes unclocked access crash
--

commit e5bbe927d2b6dbf7ee2cdbdeb6104c05147c9959
Author: Praveen Talari <praveen.talari@oss.qualcomm.com>

i2c: qcom-geni: Vote for SE clock rate using OPP
   =20
The GENI I2C driver selects a source clock based on the requested bus
frequency and programs the corresponding clock selector. However, it
does not request the selected source clock rate when OPP-based clock
scaling is used.
   =20
Store the matched source clock frequency and vote for it through
dev_pm_opp_set_rate() before programming the clock selector. Also remove
and restore the vote during runtime suspend and resume.

> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 5f3d260a3913b..a6fe89d0934f6 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[ ... ]

> @@ -255,6 +257,11 @@ static int qcom_geni_i2c_conf(struct geni_se *se, un=
signed long freq)
>  	struct geni_i2c_dev *gi2c =3D dev_get_drvdata(se->dev);
>  	const struct geni_i2c_clk_fld *itr =3D gi2c->clk_fld;
>  	u32 val;
> +	int ret;
> +
> +	ret =3D dev_pm_opp_set_rate(se->dev, gi2c->src_freq);
> +	if (ret)
> +		return ret;
> =20
>  	writel_relaxed(gi2c->clk_idx, gi2c->se.base + SE_GENI_CLK_SEL);

[Severity: High]
If dev_pm_opp_set_rate(dev, 0) fails during geni_i2c_runtime_suspend(), the
PM core will leave the device state as RPM_ACTIVE even though the physical
clocks were disabled.

On the next transfer, pm_runtime_resume_and_get() would see RPM_ACTIVE and
skip calling geni_i2c_runtime_resume(). This leads to qcom_geni_i2c_conf()
where dev_pm_opp_set_rate(dev, gi2c->src_freq) succeeds, but writel_relaxed=
()
is executed while the physical hardware is still unclocked.

Could this sequence trigger a fatal bus error?

[ ... ]

> @@ -1286,7 +1293,7 @@ static int geni_i2c_runtime_suspend(struct device *=
dev)
>  		}
>  	}
> =20
> -	return 0;
> +	return dev_pm_opp_set_rate(dev, 0);

[Severity: High]
If dev_pm_opp_set_rate(dev, 0) fails here, the error is returned to the
runtime PM core. Does this leave the PM core thinking the device is RPM_ACT=
IVE
while the hardware clocks were already physically turned off by the precedi=
ng
gi2c->dev_data->power_off() call?

>  }
> =20
>  static int geni_i2c_runtime_resume(struct device *dev)
> @@ -1300,6 +1307,12 @@ static int geni_i2c_runtime_resume(struct device *=
dev)
>  			return ret;
>  	}
> =20
> +	if (gi2c->src_freq) {
> +		ret =3D dev_pm_opp_set_rate(dev, gi2c->src_freq);
> +		if (ret)
> +			return ret;

[Severity: High]
If dev_pm_opp_set_rate() fails, this returns immediately. Does this skip the
gi2c->dev_data->power_off() rollback and enable_irq() calls, leaving the
hardware resources enabled indefinitely while the PM core marks the device =
as
RPM_SUSPENDED?

> +	}
> +
>  	enable_irq(gi2c->irq);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-derive_clk=
_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com?par=
t=3D6
