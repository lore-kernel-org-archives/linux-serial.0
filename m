Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685589;
	b=rkTHZffW7LoZvL0XcVxKwasDE6rCYgwUR2YF5jKWtxQVpDMT9IKgIHCWzAJ2ID65+LSi
	 6uD0q196tYioppLfB5FWZG7S2VMPijcA4KfAlDPaC5Kn95MA1pxAiD8MnjGoUtutDiKfQ
	 GVsLad8Oh+l0pNiBXqvdFKHm9dfUNYHfibDdl29cYWEdcOEoGdbvO8HOUsbHjui0XwIXx
	 C8eNNCOK1gasaLGUHBAxAbWlgkMwQidgxq2xyJKfB1FUdN64dkjWfCHXfQc7PX+MitIKe
	 j4DmrNXTKgWiMB/ETQoxsobcOvcPntmQ4iAjrraM9/I+p03IzW2Fp8+zkvi2tdDmMMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pYWBDbbU+QTRHK0HCB0YoFvBhJv+J3W0aUK6zLm7FaY=;
	b=BmqoRRu69cZcYx+1LYsrUpsSpQpj8TnC2WelbCRqRLezcykkiFbxLicKUJ+hK1vh0TMW
	 vRw07m5E/JEwV1EUFjT3LzZTygXYiG1xoT0e7c1Z0fgYCLKx/ywlaE2YUgeWiHOmhhKKE
	 nQQrZ5m28s0TNFKb0fatKJ8fYtCWy5nWMXreJ0VWOkzfe0700VyTSRhUd4rXXUVAQaOFw
	 PII4t5Qboa6p8vb7eVnMcsVj+FTvtYcnRI2sLVGGrPY53j+yu23XDmyW1V8DrmCeMqsQZ
	 2OV7Gdvqsgx31O0A9r6IL1wCtB+5nsAms75pISfrbiI0uPAS/c71GSaqrkDHao2aoQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzST28Ha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23884606A31A;
	Thu, 22 Oct 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzST28Ha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75691F031E0;
	Thu, 22 Oct 2026 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685588;
	bh=pYWBDbbU+QTRHK0HCB0YoFvBhJv+J3W0aUK6zLm7FaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AzST28HaqnRsJFlYfeiXrDT44IoRuEChlzBrNP/8e4wzuNRhmxCpULAD4lqIQbJpM
	 ekv1EWV9GjJ5XcUXYZPUeYRSnEyWv3X9CjFeB6FQ+Askh2lrYHsL2ef4tvZq6XfHOB
	 Y2P+oGziq/4w1Op4OZU7zHD9Wnh42cESMuG8tNlZ9pIk5OJFsxUF7XwR2LRwvPAr+L
	 fqiTZVlFCGdRm/8syszrNDl93WO6S4Wmd0OG2kqZVUkadOD8eeu4ZTzC9/fWBKTuT8
	 +wErSK/oS7HwIm1i1HG2VGhvQVxMF6fbWhiwL/nHhT+FrZ1Y6M9zPsQjj4vqlfU5/+
	 PQQqScVYdMOCQ==
Message-ID: <sashiko-outbox-181774@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/27] pmdomain: rockchip: Add RK3572 boot peripheral
 domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, lee@kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-10-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-10-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:13:07 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pmdomain: rockchip: incomplete power-on retry tracking in rockchip=
_pd_power()
--

commit c324244eacf06dcfc61ec2e5830623efbacb5d15
Author: Cunhao Lu <1579567540@qq.com>

pmdomain: rockchip: Add RK3572 boot peripheral domains

This commit adds the rk3572 boot peripheral power domains (nvm0, nvm1, php,
and vop), waits for the grf firewall before restoring consumers, and tracks
pending power-on transitions to retry failures without power-cycling the
domain.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e193f978d5f35..86a6ffd43254b 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -644,14 +657,29 @@ static int rockchip_do_pmu_set_power_domain(struct =
rockchip_pm_domain *pd,
>  	return 0;
>  }
> =20
> +static int rockchip_pmu_wait_firewall(struct rockchip_pm_domain *pd)
> +{
> +	struct rockchip_pmu *pmu =3D pd->pmu;
> +	u32 mask =3D pd->info->firewall_mask;
> +	u32 val;
> +
> +	if (!mask)
> +		return 0;
> +
> +	return regmap_read_poll_timeout(pmu->grf, pmu->info->firewall_status_of=
fset,
> +				       val, (val & mask) =3D=3D mask, 0, 10000);
> +}
> +
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_o=
n)
>  {
>  	struct rockchip_pmu *pmu =3D pd->pmu;
> +	bool is_on;
>  	int ret;
> =20
>  	guard(mutex)(&pmu->mutex);
> =20
> -	if (rockchip_pmu_domain_is_on(pd) =3D=3D power_on)
> +	is_on =3D rockchip_pmu_domain_is_on(pd);
> +	if (is_on =3D=3D power_on && !pd->power_on_pending)
>  		return 0;
> =20
>  	ret =3D clk_bulk_enable(pd->num_clks, pd->clks);
> @@ -663,7 +691,8 @@ static int rockchip_pd_power(struct rockchip_pm_domai=
n *pd, bool power_on)
>  	rockchip_pmu_ungate_clk(pd, true);
> =20
>  	if (!power_on) {
> -		rockchip_pmu_save_qos(pd);
> +		if (!pd->power_on_pending)
> +			rockchip_pmu_save_qos(pd);
> =20
>  		/* if powering down, idle request to NIU first */
>  		ret =3D rockchip_pmu_set_idle_request(pd, true);
> @@ -671,18 +700,29 @@ static int rockchip_pd_power(struct rockchip_pm_dom=
ain *pd, bool power_on)
>  			goto out;
>  	}
> =20
> -	ret =3D rockchip_do_pmu_set_power_domain(pd, power_on);
> -	if (ret < 0)
> -		goto out;
> +	/* A failed firewall wait must not restart powered memory on retry. */
> +	if (is_on !=3D power_on) {
> +		ret =3D rockchip_do_pmu_set_power_domain(pd, power_on);
> +		if (ret < 0)
> +			goto out;
> +	}
> =20
>  	if (power_on) {
> +		if (pd->info->firewall_mask)
> +			pd->power_on_pending =3D true;
> +
>  		/* if powering up, leave idle mode */
>  		ret =3D rockchip_pmu_set_idle_request(pd, false);
>  		if (ret < 0)
>  			goto out;

[Severity: High]
In drivers/pmdomain/rockchip/pm-domains.c, does setting pd->power_on_pending
only when pd->info->firewall_mask is non-zero and only after
rockchip_do_pmu_set_power_domain() succeeds leave partial power-on states
untracked in rockchip_pd_power()?

When genpd_power_on() -> rockchip_pd_power_on() -> rockchip_pd_power(pd, tr=
ue)
is called for a domain that is initially off (is_on =3D=3D false),
rockchip_do_pmu_set_power_domain(pd, true) enables the hardware power switch
in pmu->info->pwr_offset + pd_pwr_offset, making rockchip_pmu_domain_is_on(=
pd)
return true.

If rockchip_pmu_set_idle_request(pd, false) subsequently fails on a domain
where pd->info->firewall_mask is 0 (such as the "nvm0" and "nvm1" domains on
rk3572, or domains on other SoCs), or if rockchip_do_pmu_set_power_domain()
fails in rockchip_pmu_domain_mem_reset() after enabling the power switch,
pd->power_on_pending remains false when jumping to out.

If a later power-on retry calls rockchip_pd_power(pd, true),
rockchip_pmu_domain_is_on(pd) will return true while pd->power_on_pending is
false:

	is_on =3D rockchip_pmu_domain_is_on(pd);
	if (is_on =3D=3D power_on && !pd->power_on_pending)
		return 0;

Wouldn't rockchip_pd_power(pd, true) then return 0 immediately without
deasserting the bus idle request, resetting memory, waiting for the firewal=
l,
or restoring QoS registers via rockchip_pmu_restore_qos()? Furthermore, if
rockchip_pd_power(pd, false) is called in that state, wouldn't the
!pd->power_on_pending check allow rockchip_pmu_save_qos(pd) to overwrite
pd->qos_save_regs with unrestored values while the domain is still idle?

Should pd->power_on_pending be set unconditionally before
rockchip_do_pmu_set_power_domain(pd, true) when powering on a domain?

> =20
> +		ret =3D rockchip_pmu_wait_firewall(pd);
> +		if (ret)
> +			goto out;
> +
>  		rockchip_pmu_restore_qos(pd);
>  	}
> +	pd->power_on_pending =3D false;
> =20
>  out:
>  	rockchip_pmu_ungate_clk(pd, false);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add-board-=
ok3572-c-v1-0-0b0fd85a31ee@qq.com?part=3D10
