Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197955;
	b=ZjpeZ5tXqisbZx21uJmenAuzkKwZLiykor1rPE9oP16Qq4FsJAnr9EPtY/mwa3l/kV/k
	 uDK5v1HbPDnUbDWkoypKmRpRZb+N+UzUPXLhEBgiAXxyKuBH7sGdrk8ZGBtyXYZrCouWm
	 pRcc5zhz1OCT3LSnAf3tOaQfp0Kdn/4Hh6VhJWQqxbFbFsXZDurZZLpVUwWkgU7+1yxQX
	 lZLqVJfbu/W90A9slq1nQOe4BayUdJPtZjNc9d9UnbcMNsCShdqx9972EM4wtEbSt8VBM
	 SKU/QegZyrvlWbewBEIDaDlOmOxrHU5whztQL78oFjXjVB7zMSyhsvu08hqm1/8a/9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197955;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=+vj3JXaH73DAc9DdU35ASSRyg7WAvYyKv+vce4COULM=;
	b=eyG0iwm7SRum4THNJgd84uE0z83UGfAuOjDMBmplSSeedQhqHrCzDVKUhiv97q0Uk27X
	 didF5XgqS1VUjei+GUwDmFT8MAqXu/IOor2e/W0vDWYLrvTEHPJyre/vNsambW/Clc8E1
	 oH7vgja3e98Fcvbx5gTpEzNpurUreO5u7rmy2AfaSzvscubk6LdZvLLfD5BPeJVya4mrc
	 T0UVB3Yl9ekBGAnfs8hktGzslktDBXc8ALj5+7LZX5z9WnCmp2+sMlN2iDL8Q6B8bMqr4
	 M14/Zue5x0KeNJNZwqG75O0TWfWg43fXXnHUX6bJ6yePPqZXsZaWU4XEQp9LSr/XrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PrNxJIoI;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77438606A31D;
	Wed, 28 Oct 2026 14:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77438606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PrNxJIoI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8FF284E41366;
	Wed, 28 Oct 2026 14:32:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F5B860769;
	Wed, 28 Oct 2026 14:32:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3E6B103290D1;
	Wed, 28 Oct 2026 15:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793197945; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+vj3JXaH73DAc9DdU35ASSRyg7WAvYyKv+vce4COULM=;
	b=PrNxJIoIaUyhY8Zqt4SrJf4ec9/mtkg2tiyqW/XNHd1snpJ3Ho9quFY5u9M6HNrg3pe4DJ
	rEoBT0F3Mq7YaJMxOzPhZiJ4KGmGoe9sjxvUOuV2n6qPLG2XzN05gBCubNZ1sHNqWnQBXl
	LRmFcPNn37UP3qhOdV3tjyLwibLn8KorGjx5y5VWBzsoxMT0/oVLBKudz/EmG0A7o/PPWW
	NCdUf//rOnMSiE3qewS9q2nksK0+jikBkQsq+OemhIk3kyGwTEiL22QBuFxNfXE8gQEKmN
	rA5dGwbBYGMHOdRe/O2j379Co6IiS+ImdN4CA5Dgx96FKJwh3EawJv7Nihzgsw==
Message-ID: <880e67e2-3f29-4dfd-84ee-09006dc86574@bootlin.com>
Date: Wed, 28 Oct 2026 15:32:18 +0100
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] pinctrl: berlin: add optional pinconf support
To: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Andi Shyti
 <andi.shyti@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-13-jszhang@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260929061417.20733-13-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 29/09/2026 à 08:14, Jisheng Zhang a écrit :
> Add pinconf support for newer Synaptics SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/pinctrl/berlin/berlin.c | 232 +++++++++++++++++++++++++++++++-
>   1 file changed, 228 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index 0c2179b98629..06c67f00c527 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -13,6 +13,8 @@
>   #include <linux/of.h>
>   #include <linux/of_address.h>
>   #include <linux/of_device.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinconf.h>
>   #include <linux/pinctrl/pinctrl.h>
>   #include <linux/pinctrl/pinmux.h>
>   #include <linux/platform_device.h>
> @@ -20,9 +22,24 @@
>   #include <linux/slab.h>
>   
>   #include "../core.h"
> +#include "../pinconf.h"
>   #include "../pinctrl-utils.h"
>   #include "berlin.h"
>   
> +#define PINCFG_DS_10BIT		GENMASK(3, 0)
> +#define PINCFG_IE_10BIT		BIT(4)
> +#define PINCFG_PE_10BIT		BIT(5)
> +#define PINCFG_PS_10BIT		BIT(6)
> +#define PINCFG_SL_10BIT		BIT(7)
> +#define PINCFG_SPU_10BIT	BIT(8)
> +#define PINCFG_ST_10BIT		BIT(9)
> +#define PINCFG_DS_8BIT		GENMASK(2, 0)
> +#define PINCFG_IE_8BIT		BIT(3)
> +#define PINCFG_PD_8BIT		BIT(4)
> +#define PINCFG_PU_8BIT		BIT(5)
> +#define PINCFG_SL_8BIT		BIT(6)
> +#define PINCFG_ST_8BIT		BIT(7)
> +
>   struct berlin_pinctrl {
>   	struct regmap *regmap;
>   	struct device *dev;
> @@ -56,6 +73,8 @@ static int berlin_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
>   	struct property *prop;
>   	const char *function_name, *group_name;
>   	unsigned reserved_maps = 0;
> +	unsigned long *configs = NULL;
> +	unsigned int num_configs = 0;
>   	int ret, ngroups;
>   
>   	*map = NULL;
> @@ -75,11 +94,19 @@ static int berlin_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
>   		return -EINVAL;
>   	}
>   
> +	ret = pinconf_generic_parse_dt_config(node, pctrl_dev, &configs,
> +					      &num_configs);
> +	if (ret < 0) {
> +		dev_err(pctrl->dev, "%s: could not parse node property\n",
> +			node->name);
> +		return ret;
> +	}
> +
>   	ret = pinctrl_utils_reserve_map(pctrl_dev, map, &reserved_maps,
> -					num_maps, ngroups);
> +					num_maps, ngroups * (num_configs + 1));
>   	if (ret) {
>   		dev_err(pctrl->dev, "can't reserve map: %d\n", ret);
> -		return ret;
> +		goto exit;
>   	}
>   
>   	of_property_for_each_string(node, "groups", prop, group_name) {
> @@ -88,11 +115,22 @@ static int berlin_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
>   						function_name);
>   		if (ret) {
>   			dev_err(pctrl->dev, "can't add map: %d\n", ret);
> -			return ret;
> +			goto exit;
> +		}
> +
> +		if (num_configs) {
> +			ret = pinctrl_utils_add_map_configs(pctrl_dev, map,
> +					&reserved_maps, num_maps, group_name,
> +					configs, num_configs,
> +					PIN_MAP_TYPE_CONFIGS_GROUP);
> +			if (ret < 0)
> +				goto exit;
>   		}
>   	}
>   
> -	return 0;
> +exit:
> +	kfree(configs);
> +	return ret;
>   }
>   
>   static const struct pinctrl_ops berlin_pinctrl_ops = {
> @@ -177,6 +215,191 @@ static const struct pinmux_ops berlin_pinmux_ops = {
>   	.set_mux		= &berlin_pinmux_set,
>   };
>   
> +static int berlin_pinconf_group_get(struct pinctrl_dev *pctrl_dev,
> +				    unsigned int group, unsigned long *configs)
> +{
> +	enum pin_config_param param = pinconf_to_config_param(*configs);
> +	struct berlin_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrl_dev);
> +	const struct berlin_desc_group *group_desc = pctrl->desc->groups + group;
> +	bool enabled;
> +	u32 val;
> +	int ret;
> +	u8 conf_bits = group_desc->conf_bits;
> +
> +	if (!conf_bits)
> +		return -EOPNOTSUPP;
> +
> +	ret = regmap_read(pctrl->regmap, group_desc->conf_offset, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		if (conf_bits == 10)
> +			enabled = !(val & PINCFG_PE_10BIT);
> +		else
> +			enabled = !(val & (PINCFG_PD_8BIT | PINCFG_PU_8BIT));
> +		val = 0;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		if (conf_bits == 10)
> +			enabled = (val & (PINCFG_PE_10BIT | PINCFG_PS_10BIT)) == PINCFG_PE_10BIT;
> +		else
> +			enabled = val & PINCFG_PD_8BIT;
> +		val = enabled ? 1 : 0;
> +		break;
> +	case PIN_CONFIG_BIAS_PULL_UP:
> +		if (conf_bits == 10) {
> +			if ((val & (PINCFG_PE_10BIT | PINCFG_PS_10BIT)) == (PINCFG_PE_10BIT | PINCFG_PS_10BIT)) {
> +				enabled = true;
> +				if (val & PINCFG_SPU_10BIT)
> +					val = 2;
> +				else
> +					val = 1;
> +			} else {
> +				enabled = false;
> +				val = 0;
> +			}
> +		} else {
> +			enabled = val & PINCFG_PU_8BIT;
> +			val = enabled ? 1 : 0;
> +		}
> +		break;
> +	case PIN_CONFIG_DRIVE_STRENGTH:
> +		enabled = true;
> +		if (conf_bits == 10)
> +			val = FIELD_GET(PINCFG_DS_10BIT, val);
> +		else
> +			val = FIELD_GET(PINCFG_DS_8BIT, val);
> +		break;
> +	case PIN_CONFIG_INPUT_ENABLE:
> +		if (conf_bits == 10)
> +			enabled = val & PINCFG_IE_10BIT;
> +		else
> +			enabled = val & PINCFG_IE_8BIT;
> +		val = enabled ? 1 : 0;
> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		if (conf_bits == 10)
> +			enabled = val & PINCFG_ST_10BIT;
> +		else
> +			enabled = val & PINCFG_ST_8BIT;
> +		val = enabled ? 1 : 0;
> +		break;
> +	case PIN_CONFIG_SLEW_RATE:
> +		if (conf_bits == 10)
> +			enabled = val & PINCFG_SL_10BIT;
> +		else
> +			enabled = val & PINCFG_SL_8BIT;
> +		val = enabled ? 1 : 0;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	*configs = pinconf_to_config_packed(param, val);
> +	return enabled ? 0 : -EINVAL;
> +}
> +
> +static int berlin_pinconf_group_set(struct pinctrl_dev *pctrl_dev,
> +				    unsigned int group, unsigned long *configs,
> +				    unsigned int nconfigs)
> +{
> +	struct berlin_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrl_dev);
> +	const struct berlin_desc_group *group_desc = pctrl->desc->groups + group;
> +	u8 conf_bits = group_desc->conf_bits;
> +	u32 mask = 0, val = 0;
> +	int i;
> +
> +	if (!conf_bits)
> +		return -EOPNOTSUPP;
> +
> +	for (i = 0; i < nconfigs; i++) {
> +		enum pin_config_param param =
> +					pinconf_to_config_param(configs[i]);
> +		u32 arg = pinconf_to_config_argument(configs[i]);
> +
> +		switch (param) {
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			if (conf_bits == 10)
> +				mask |= (PINCFG_PE_10BIT | PINCFG_PS_10BIT | PINCFG_SPU_10BIT);
> +			else
> +				mask |= (PINCFG_PU_8BIT | PINCFG_PD_8BIT);
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +			if (conf_bits == 10) {
> +				mask |= (PINCFG_PE_10BIT | PINCFG_PS_10BIT | PINCFG_SPU_10BIT);
> +				val |= PINCFG_PE_10BIT;
> +			} else {
> +				mask |= (PINCFG_PU_8BIT | PINCFG_PD_8BIT);
> +				val |= PINCFG_PD_8BIT;
> +			}
> +			break;
> +		case PIN_CONFIG_BIAS_PULL_UP:
> +			if (conf_bits == 10) {
> +				mask |= (PINCFG_PE_10BIT | PINCFG_PS_10BIT | PINCFG_SPU_10BIT);
> +				val |= (PINCFG_PE_10BIT | PINCFG_PS_10BIT);
> +				if (arg == 2)
> +					val |= PINCFG_SPU_10BIT;
The value 2 Ohms is hijacked to be used as strong pull up.
The more I look at that, the more it feels hacky.

> +			} else {
> +				mask |= (PINCFG_PU_8BIT | PINCFG_PD_8BIT);
> +				val |= PINCFG_PU_8BIT;
> +			}
> +			break;
> +		case PIN_CONFIG_DRIVE_STRENGTH:
> +			if (conf_bits == 10)
> +				mask |= PINCFG_DS_10BIT;
> +			else
> +				mask |= PINCFG_DS_8BIT;
> +			val |= arg;
The drive strength is assumed to be lsb (which is the case), but maybe 
something like:
	if (arg > FIELD_MAX(mask))
		return -EINVAL;
	val |= FIELD_PREP(mask, arg);
would be more generic.

> +			break;
> +		case PIN_CONFIG_INPUT_ENABLE:
> +			if (conf_bits == 10) {
> +				mask |= PINCFG_IE_10BIT;
> +				if (arg)
> +					val |= PINCFG_IE_10BIT;
> +			} else {
> +				mask |= PINCFG_IE_8BIT;
> +				if (arg)
> +					val |= PINCFG_IE_8BIT;
> +			}
> +			break;
> +		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +			if (conf_bits == 10) {
> +				mask |= PINCFG_ST_10BIT;
> +				if (arg)
> +					val |= PINCFG_ST_10BIT;
> +			} else {
> +				mask |= PINCFG_ST_8BIT;
> +				if (arg)
> +					val |= PINCFG_ST_8BIT;
> +			}
> +			break;
> +		case PIN_CONFIG_SLEW_RATE:
> +			if (conf_bits == 10) {
> +				mask |= PINCFG_SL_10BIT;
> +				if (arg)
> +					val |= PINCFG_SL_10BIT;
> +			} else {
> +				mask |= PINCFG_SL_8BIT;
> +				if (arg)
> +					val |= PINCFG_SL_8BIT;
> +			}
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return regmap_update_bits(pctrl->regmap, group_desc->conf_offset, mask, val);
> +}
> +
> +static const struct pinconf_ops berlin_confops = {
> +	.is_generic = true,
> +	.pin_config_group_get = berlin_pinconf_group_get,
> +	.pin_config_group_set = berlin_pinconf_group_set,
> +};
> +
>   static int berlin_pinctrl_add_function(struct berlin_pinctrl *pctrl,
>   				       const char *name)
>   {
> @@ -287,6 +510,7 @@ static const struct pinctrl_desc berlin_pctrl_desc = {
>   	.name		= "berlin-pinctrl",
>   	.pctlops	= &berlin_pinctrl_ops,
>   	.pmxops		= &berlin_pinmux_ops,
> +	.confops	= &berlin_confops,
>   	.owner		= THIS_MODULE,
>   };
>   
Regards,
Richard
