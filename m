Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616843909A2;
	Tue, 29 Sep 2026 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664428; cv=none; b=jQ0WvHmbvGnbVoaSEp5qOhKkH9pc14DZsK5+uALcQOg9tNBHvJRea54nlE7L3qzwHtpMcODrdoduXSTolobs5zTJHRYlTSBHBqUT64SiglYmXB1cIUU7KayC5iEG5BaTBzj6+ZJcxtZ3iYya0Y6JCFx/PjKTMESfQm2Md6Y+KJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664428; c=relaxed/simple;
	bh=8fQhdPYPuEHqf4Ru43ELndvM6YUy8t7Hz6ODo7dDhmI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oTI/s2MJ/xhakGDJNeGC3ybZri/mA+lZlc0U7tBnAOoP6BF2XZ1ygPYYdPEOa2hhJNdkMnb4dgLbsGWWgut07VWgP9F/tAqim/59Z9IjAG3fu4NzjlsmpC+NRg8AJjRUI7rcE7HlZ9sWI+ZE4yzlidzqXzw7y5whiWFmaUWmlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyXJGral; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyXJGral"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750881F000FF;
	Tue, 29 Sep 2026 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664427;
	bh=jHmXMhmblbm6tAvv+tcTE/uj35n6b+3UDALg5+OHpGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NyXJGralibTSZisac7PfeSAECMeCC7dYDCKJQj+zqqi1SRWX47jghjbnwD/9zAN40
	 sBKsaehRXcGGqE5+TBMCZlGndrx+hPo3UrC+/nmJ6K6vFpWlSQsO7sTZvFLNgy2ptf
	 odvikBBmteW62flSfN4I3+OqqeBK2xhuM71xUrlu5QkzvF3Qr4R3FUsar7mO7OJZZX
	 Onq/LGzMtqPCgNR+yX/cEfbQ+fUqhj9qZWVmf2vQAe2bKHeXu9z6zskVKyWjUBA/Cd
	 lWo7yxgssA/5udzdtsj5AdJyzRlmkfsmj2Tf+z7gt7Q+rJ4so3qeqNc8/aH/CHBOFT
	 WVaWUcdjU6ePA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/20] reset: add Synaptics SL261x reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: robh@kernel.org, lee@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, Frank.Li@kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260929061417.20733-10-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-10-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:47:06 +0000
Message-Id: <20260929064706.750881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] reset: sl261x: potential NULL pointer dereference in probe
- [Medium] reset: sl261x: unsafe read-modify-write on non-sticky pulse trig=
gers
- [Low] reset: sl261x: typo 'sl261x2' in driver name and probe function
--

commit 78616d8a7b66b0ac665b311775dd566f2469412a
Author: Jisheng Zhang <jszhang@kernel.org>

reset: add Synaptics SL261x reset support

This commit adds support for the reset controller in Synaptics SL261X SoCs.

> diff --git a/drivers/reset/reset-sl261x.c b/drivers/reset/reset-sl261x.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/reset/reset-sl261x.c

[ ... ]

> +static int sl261x_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct sl261x_reset_priv *priv =3D to_sl261x_reset_priv(rcdev);
> +	const struct sl261x_reset_cfg *cfg =3D &priv->cfgs[id];
> +
> +	if (cfg->sticky) {
> +		regmap_clear_bits(priv->regmap, cfg->reg, cfg->bit);
> +		usleep_range(10, 15);
> +		return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);
> +	}
> +
> +	return regmap_set_bits(priv->regmap, cfg->reg, cfg->bit);

[Severity: Medium]
Could this read-modify-write operation disrupt concurrent resets?=20

If the non-sticky hardware registers are active-high self-clearing pulse
triggers that read as 1 while active, the regmap_set_bits() operation
might read 1s for concurrently active resets and write them back,
unintentionally extending or re-triggering them.

[ ... ]

> +static const struct reset_control_ops sl261x_reset_ops =3D {
> +	.reset	=3D sl261x_reset_reset,
> +	.assert =3D sl261x_reset_assert,
> +	.deassert =3D sl261x_reset_deassert,
> +};
> +
> +static int sl261x2_reset_probe(struct platform_device *pdev)

[Severity: Low]
Is the "sl261x2" in the probe function name intentional? It looks like a
typo.

> +{
> +	struct device_node *parent_np;
> +	struct sl261x_reset_priv *priv;
> +	const struct sl261x_reset_data *data =3D device_get_match_data(&pdev->d=
ev);
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	parent_np =3D of_get_parent(pdev->dev.of_node);
> +	priv->regmap =3D syscon_node_to_regmap(parent_np);
> +	of_node_put(parent_np);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->rcdev.owner =3D THIS_MODULE;
> +	priv->rcdev.ops =3D &sl261x_reset_ops;
> +	priv->rcdev.of_node =3D pdev->dev.of_node;
> +	priv->rcdev.of_reset_n_cells =3D 1;
> +	priv->rcdev.nr_resets =3D data->num;

[Severity: Medium]
Can data be NULL here?=20

If the driver is bound via sysfs to a device that has a valid syscon parent
but does not match the OF compatible strings, device_get_match_data() will
return NULL. Unconditionally dereferencing data->num in this case would
cause a NULL pointer dereference.

> +	priv->cfgs =3D data->cfgs;
> +
> +	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
> +}
> +
> +static const struct of_device_id sl261x_reset_dt_match[] =3D {
> +	{ .compatible =3D "syna,sl261x-reset", .data =3D &sl261x_reset_data },
> +	{ .compatible =3D "syna,sl261x-system-reset", .data =3D &sl261x_system_=
reset_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sl261x_reset_dt_match);
> +
> +static struct platform_driver sl261x_reset_driver =3D {
> +	.probe	=3D sl261x2_reset_probe,
> +	.driver	=3D {
> +		.name =3D "sl261x2-reset",

[Severity: Low]
Does this driver name intentionally use "sl261x2-reset"? Exposing a confusi=
ng
name to the platform bus and sysfs might break userspace scripts expecting a
consistent "sl261x-reset" name.

> +		.of_match_table =3D sl261x_reset_dt_match,
> +	},
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D9
