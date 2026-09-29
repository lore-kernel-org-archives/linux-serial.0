Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB00349CD8;
	Tue, 29 Sep 2026 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664354; cv=none; b=nObQo4kc9M3OKpGiHq8yQjgOniUtEEnZYM9Tr3Xku3rX8jnWNw8nNTQHmqifd9oRa176CDbfmsxnxIJPBCkP0Chu1jzL7zlXZFRE6oKcuBf/5cwdP7M63gfAgcI0W1uUA7KLwQ7E9+xTqeEf9+onjfK1RJYM41RpkOJsXLZ6DdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664354; c=relaxed/simple;
	bh=r2hDJdPR3jl1u4EjKYN77Stng4r+7yHbXSwMfQAScUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h1B5i3XRopaL/Hx7lTZyHaflW3IalH6tlLLNaeaF99EfpsPLzl+rP4UyMzPpzORBy56Q6Xid6BGdQbgYw2D+coGcRoayPosaCqUzdkp6zul97/PQP57qC+Carm5mpYw5Rnp75wk7w28iBVXJK62w+JQm4yYEKZE2QMzK5GEp1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oInz0bZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oInz0bZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D401F00893;
	Tue, 29 Sep 2026 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664353;
	bh=5J5RXXCLjh+TffupwBrVSwaI8V+2cqKZtM4RZs43XcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oInz0bZDPYkUh3oJ6CnsxiotsehDi7RcYQ/g8shcFjqNDkrwOBd/RWNswqsX5wTtT
	 21X7vagxTtv1EDf87Vx2tYVaXlFgR3haHus8sJxpQOJnEY0L69mWWfYTnJkW0bqCWO
	 DVIqH3G1u33eciPgNbOyfpoKQdJOq5abNQp1oSX8prUz30DGKGW3CUm9S8W5wzvFy2
	 QrMMYSKlE93K+8SnTrISePj9Bwx+s5xvXgyi4hmV6qt+jAWwCjaCK2amL71itd0bh1
	 hQITe+ujQ7y7SXhZpbAB3g6EXCUjFxwiN2SHE+DZTC6y6b13HLpGN4kbhazRYMThKk
	 /dsj4Ajdd8+fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/20] dt-bindings: pinctrl: berlin: Support Synaptics
 SL261X SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, linux-i3c@lists.infradead.org, linux-clk@vger.kernel.org, lee@kernel.org, linux-serial@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260929061417.20733-14-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-14-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:45:52 +0000
Message-Id: <20260929064553.18D401F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: pinctrl: undocumented schema relaxation for all SoCs
--

commit 85b4def57a8a9be19cfbb07ca389098832f3670a
Author: Jisheng Zhang <jszhang@kernel.org>
dt-bindings: pinctrl: berlin: Support Synaptics SL261X SoCs

This commit adds device tree binding support for the Synaptics SL261X SoCs
to the Marvell Berlin2 pinctrl schema. It also modifies the subnode schema
references to include generic pin configurations.

> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-so=
c-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-=
soc-pinctrl.yaml
> index 6ace3bf5433bd..fb60a310a24e6 100644
> --- a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinct=
rl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinct=
rl.yaml
[ ... ]
> @@ -44,8 +46,10 @@ properties:
>  additionalProperties:
>    description: Pin group configuration subnodes.
>    type: object
> -  $ref: /schemas/pinctrl/pinmux-node.yaml#
> -  additionalProperties: false
> +
> +  allOf:
> +    - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +    - $ref: /schemas/pinctrl/pincfg-node.yaml#

[Severity: Medium]
Does this change unintentionally relax the schema for all older SoCs?

By universally adding the reference to pincfg-node.yaml here, generic pinco=
nf
properties (like drive-strength or bias-pull-up) in pin configuration subno=
des
will now silently pass validation for all existing SoCs (such as
marvell,berlin2-soc-pinctrl). These were previously explicitly rejected by
the removed additionalProperties: false declaration.

Since the commit message strictly states it only aims to support Synaptics
SL261X SoCs, should this schema relaxation be restricted to just the newly
added variants?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D13
