Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4093911CA;
	Tue, 29 Sep 2026 06:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664362; cv=none; b=IX24ioQWlsSbIM2jkVAa+D5/IPzXrIyAO+HoWkORgoX4m2AHV80m94Jk8zxV504Suf+Qmyt9wBYRoMuiiaF4cp2KoqBi8+mcLAHjZbu/qfnFBrpaiAaz3ucHE4QsqYTVB+xZ0dVqv7DKhXi2dUJAd2u7WO526ZAGKhexssycNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664362; c=relaxed/simple;
	bh=XvkPvrzFUwP+Kn6NYItKhw9IN/waxz3AaD/ratCZqQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLMWsVLWo56rF8oDLkH6qc34HJYmQ8LXbFQnVXZr5LujbyYpolZJ3R52nD79ozKWGGcJQMWz5i0pnoSSUIfyXVZM+r48ck1m4wiwoQ8Sm4wkmRWgy49ZfjT8sMjqL/xhAQBagpfp/f19FaLPMWlzx7Ow36Kj5B5lhX0TO9Iu1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLq/61g/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLq/61g/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF01F00893;
	Tue, 29 Sep 2026 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664360;
	bh=6JffcfM7MQZ0bdz1H389pc9jbp37MxjjQGCjxfkCeZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLq/61g/qCFNpN3EjDAFMPgq8R7j0tdSPUCRW3xaoEmzrjJ4DWAsYQWnh8E+/xlxk
	 Drl/q+WZShnORj0r8IO5VcsBIRxP4IGZ0Hkxe+BuYp+xhgVMZkOq02GnYGKWk7Tqwj
	 XC6xeqJO/dpMzvU72Iz5RdS1XKcdP4OYW5L0DTgjeeqRO7FlKLKZT1gKugIeX4iVLV
	 I8Wq2IYfV2Dcr2UOXSEg2QLeERxQSP7TitlbYeFlZKnf1JzOYeUYwDGaiQ+mRRmEL7
	 UfxITU0F7IYBmn7TMP8pG95lUy7uSvLH5KYC/uXZzQPzSSn8LZlqFNV1GXfxpffh51
	 u5hxkqenfLAKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/20] pinctrl: berlin: add optional pinconf support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: lee@kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, linux-i3c@lists.infradead.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org, linux-clk@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260929061417.20733-13-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-13-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:45:59 +0000
Message-Id: <20260929064600.6CAF01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pinctrl: Unmasked DRIVE_STRENGTH argument corrupts adjacent regist=
er bits
- [Medium] pinctrl: memory over-allocation due to incorrect map reservation=
 logic
--

commit 9565e1451acca64670b365c5e1dcc3edb4643737
Author: Jisheng Zhang <jszhang@kernel.org>

pinctrl: berlin: add optional pinconf support

Add pinconf support for newer Synaptics SoCs.

> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/ber=
lin.c
> index 0c2179b986295..06c67f00c5276 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
[ ... ]
> @@ -75,11 +94,19 @@ static int berlin_pinctrl_dt_node_to_map(struct pinct=
rl_dev *pctrl_dev,
>  		return -EINVAL;
>  	}
> =20
> +	ret =3D pinconf_generic_parse_dt_config(node, pctrl_dev, &configs,
> +					      &num_configs);
> +	if (ret < 0) {
> +		dev_err(pctrl->dev, "%s: could not parse node property\n",
> +			node->name);
> +		return ret;
> +	}
> +
>  	ret =3D pinctrl_utils_reserve_map(pctrl_dev, map, &reserved_maps,
> -					num_maps, ngroups);
> +					num_maps, ngroups * (num_configs + 1));

[Severity: Medium]
Does this map reservation logic permanently over-allocate kernel memory for=
 the
lifetime of the parsed pin configuration?

The driver reserves map entries using ngroups * (num_configs + 1). However,
pinctrl_utils_add_map_configs() aggregates the entire array of configuratio=
ns
into a single map entry. Thus, the driver adds at most 2 entries per group
(one for the mux and one for the configs), regardless of num_configs.

When parsing pin configurations from the device tree where num_configs > 1,
this results in (num_configs - 1) * ngroups unused array elements being
allocated.

>  	if (ret) {
>  		dev_err(pctrl->dev, "can't reserve map: %d\n", ret);
> -		return ret;
> +		goto exit;
>  	}
[ ... ]
> +static int berlin_pinconf_group_set(struct pinctrl_dev *pctrl_dev,
> +				    unsigned int group, unsigned long *configs,
> +				    unsigned int nconfigs)
> +{
[ ... ]
> +		switch (param) {
[ ... ]
> +		case PIN_CONFIG_DRIVE_STRENGTH:
> +			if (conf_bits =3D=3D 10)
> +				mask |=3D PINCFG_DS_10BIT;
> +			else
> +				mask |=3D PINCFG_DS_8BIT;
> +			val |=3D arg;
> +			break;

[Severity: High]
Can this regression cause the unbounded user-provided arg to overflow and
corrupt adjacent register bits?

When the device tree specifies a drive-strength value that exceeds the unma=
sked
bit width (e.g., > 15), the parsed arg is added directly to val via val |=
=3D arg
without applying a bitmask.

Because val and mask are accumulated across all config parameters in a loop,
the overflowing bits from DRIVE_STRENGTH will be written to the register if
they overlap with the composite mask bits requested by other parameters
(e.g., overriding the PINCFG_IE_10BIT state). This could lead to incorrect
hardware pin states and functional failures on key interfaces during device
probe.

> +		case PIN_CONFIG_INPUT_ENABLE:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D12
