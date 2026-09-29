Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E57D3B1017;
	Tue, 29 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664783; cv=none; b=gYIK1KG/lVbT4fCkz+pNy8M5wQZPsae/Jf1UluOQ+RCtDamfR5aaF3HCh21US5cUfvSmdIQkXkIwCoHXilscwvjuS6NR/NHQ4GDYAsVNNYM5hicGIlb2icaUvgS2re30KMygKE2JY1I1GJBn6UoS16czZk8Vf2cEXUmAKV7BB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664783; c=relaxed/simple;
	bh=DcQSZuK+Q9w4PMMA+//9Z2KDO/QZaxGII/MfdG+WfnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4czjpaMt5JRhyvxygSuYPMgoQVbjqD9DczY0DxwVaJbi7sUHgn+dIdBgr3V1/cIUcDIVlr/P2fybc+WQSm4/5rlYGuzIEQmtyg7uDaEpTSU3qvufrlmxdQtLBT+w+XC9w1KEO5XINzYfKNgnc2rRRw/2C1ayXnfW9po9w9nIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGaptqid; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGaptqid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F631F000FF;
	Tue, 29 Sep 2026 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664782;
	bh=lG2jnZBnGSFfWMpCDUixNxmfZOCJMvHcpR6vqHjdS64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGaptqidZZrFJd042xCpuahBh65XGEosVFBqXLgmwrWYjnZ0pwGB6Tvl2OfyGgSAC
	 Gu1jc6I4uaovnk5SVCTaA+b5LXinl2oHHneeUXdDCsceqUVKiouxT2TN4aNUUR5oc3
	 Y/WZswhjnU2MH3C6U4Tn/A3cP5ehdyxm+kz3R/I8Jp3aqZ9LkRWNofEZ1+73ZP0TW7
	 NMU+AEjgYhIfZp3K3Fz9CAbTMU2MiLDkxZyhvb398Gg0qh5EXR6JB/RXo0WgfkXlnO
	 vNI2MM3GiFuHgFnIXj0Jwl2w/rygVazyG/GejFexeIaKxgYDHPWDVxkmMra8R5yek8
	 JpYQuTUjrhP3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/20] dt-bindings: arm: berlin: Add Synaptics SL261X
 SoC and RDK board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: Frank.Li@kernel.org, linux-clk@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260929061417.20733-20-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-20-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:53:01 +0000
Message-Id: <20260929065301.99F631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pinctrl: register corruption due to wrong offset for GPIO54 and SM=
_GPIO20
- [Medium] reset: soc reset driver fails to probe due to compatible string =
mismatch
- [Medium] clk: missing clock provider registration in sl261x_aio_clk_setup=
()
--

commit efe9a4b32a9836b222023aba07e846238a729d6a
Author: Jisheng Zhang <jszhang@kernel.org>

dt-bindings: arm: berlin: Add Synaptics SL261X SoC and RDK board
   =20
Add devicetree binding for the Synaptics SL261X SoCs and corresponding
RDK boards.

> diff --git a/drivers/clk/berlin/sl261x-clks.c b/drivers/clk/berlin/sl261x=
-clks.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/clk/berlin/sl261x-clks.c
[ ... ]
> +static int sl261x_aio_clk_setup(struct platform_device *pdev)
> +{
[ ... ]
> +	/* aplls */
> +	ret =3D sl261x_pll_register(dev, base + APLL0_OFFSET,
> +				  clk_names[APLL0_OUT], clk_names[APLL0_OUTF]);
> +	if (ret)
> +		return ret;
> +	ret =3D sl261x_pll_register(dev, base + APLL1_OFFSET,
> +				  clk_names[APLL1_OUT], clk_names[APLL1_OUTF]);
> +	if (ret)
> +		return ret;
> +
> +	/* TODO aio clks */
> +
> +	return 0;
> +}

[Severity: Medium]
Since the device tree node for this clock defines #clock-cells =3D <1>, doe=
sn't
the clock framework expect a provider to be registered here?

It appears sl261x_aio_clk_setup() returns 0 without calling
devm_of_clk_add_hw_provider(), which could cause any consumer requesting a
clock from the syna,sl261x-aio-clk provider to fail with a probe deferral
error.

> diff --git a/drivers/pinctrl/berlin/pinctrl-sl261x.c b/drivers/pinctrl/be=
rlin/pinctrl-sl261x.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/pinctrl/berlin/pinctrl-sl261x.c
[ ... ]
> +static const struct berlin_desc_group sl261x_soc_pinctrl_groups[] =3D {
[ ... ]
> +	BERLIN_PINCTRLCONF_GROUP("GPIO54", 0x800c, 0x3, 0x03,
> +			0x87c, 10,

[Severity: High]
Is the configuration offset for GPIO54 correct in sl261x_soc_pinctrl_groups?

Surrounding pins like GPIO53 use 0x8878 and GPIO55 uses 0x8880. If this was
meant to be 0x887c, wouldn't writing to 0x87c during pin configuration corr=
upt
unrelated system registers instead?

[ ... ]
> +static const struct berlin_desc_group sl261x_sysmgr_pinctrl_groups[] =3D=
 {
[ ... ]
> +	BERLIN_PINCTRLCONF_GROUP("SM_GPIO20", 0x8, 0x3, 0x0f,
> +			0xc6c, 10,

[Severity: High]
Could the multiplexing offset for SM_GPIO20 in sl261x_sysmgr_pinctrl_groups
be a typo?

All surrounding pins use a multiplexing offset of 0xb08. Executing pinmux
requests with an offset of 0x8 might lead to system register corruption.

> diff --git a/drivers/reset/reset-sl261x.c b/drivers/reset/reset-sl261x.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/reset/reset-sl261x.c
[ ... ]
> +static const struct of_device_id sl261x_reset_dt_match[] =3D {
> +	{ .compatible =3D "syna,sl261x-reset", .data =3D &sl261x_reset_data },
> +	{ .compatible =3D "syna,sl261x-system-reset", .data =3D &sl261x_system_=
reset_data },
> +	{ },
> +};

[Severity: Medium]
Will this driver successfully bind to the SoC reset node during boot?

The sl261x_reset_dt_match table matches against syna,sl261x-reset, but the
devicetree bindings and device tree sources define the compatible string as
syna,sl261x-soc-reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D19
