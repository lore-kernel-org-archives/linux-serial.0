Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389442BE85;
	Thu, 30 Jul 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415369; cv=none; b=s1YPvAn/dJwT3Ay7/nAw7HIKYXAdAaX5MxNmUg0oIo4I3a3crvwq3MbANhnje3D4/sT9oc3NhUa1lX1hbhV3/7844/7ZF0swRps0R4qkSRI71yA8A4OEPX6VJKjnklUnMLhM9ydSHQUcAja7E5gYcIhQPuIePJrRykfpIUMlxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415369; c=relaxed/simple;
	bh=YLlX9gxN3/+bGJ4WAJ8+xMZo8u7iKiD8jmgpmvSTZrQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TtIDdXH6dZpptss7o9RRjZi4USV4dh46mqq4tDAtRkjBU/gYm8OQE4CTXXae79vzRTxqDSB4Aqx6D58+qbzLcx1LnQG2KDEDUWaDeBAbH/bVi2UfYYSFOtkgGcIyHmso6oALEh3WQjxp7r0townXfmmNJRh+R3NFI1ZtOtRIwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIsQy804; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIsQy804"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7021F00A3A;
	Thu, 30 Jul 2026 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415367;
	bh=CU+ENcPYcmdbwm2Mz6p4kmUYZCDdIKr4KPR9KNirpJA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=EIsQy804JqSOGgVoEGjOo1nFtYf95U4b5AMjQ22HeCiBSJ+5JM9FPTAyawlUbsmGC
	 AhTuyX8EousxHkoQk4/vbw3q04BgsavNZMwiIz3k22JNJ+NMzLcyRjsdmNF2/Rz0jm
	 Tcq0g2/qp262EgRSTRJtBrJCZLbmGUm+BkYX7rNTzRVvQqFjno7lxlgS2iHu9XPkn1
	 TL91K8OyVZ28W/2o821acBC7kHzQ0jkupq9HvS22s4GhCAKataATprvfvHGwDFsA5i
	 v0js8JOZPm/kI7KuVitQpCq1aBhLODbUbWNACdAvLYjO/ElbxO9YIInIv6dDYZkFAB
	 ZhWa4EsgRjNHQ==
Date: Thu, 30 Jul 2026 07:42:47 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: soc@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, Jiri Slaby <jirislaby@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Will Deacon <will@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
In-Reply-To: <20260730104330.81367-5-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
 <20260730104330.81367-5-longzhao@ambarella.com>
Message-Id: <178541536614.2602004.2083911306176491952.robh@kernel.org>
Subject: Re: [PATCH 04/10] dt-bindings: pinctrl: add Ambarella CV75 pinctrl


On Thu, 30 Jul 2026 18:43:24 +0800, Long Zhao wrote:
> Add the CV75 pin controller binding and pinmux ID header.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../pinctrl/ambarella,cv75-pinctrl.yaml       | 167 ++++++++++++++++++
>  .../dt-bindings/pinctrl/ambarella,pinctrl.h   |  11 ++
>  2 files changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ambarella,cv75-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/ambarella,pinctrl.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.example.dtb: tdshp@321e0000 (mediatek,mt8196-disp-tdshp): 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-tdshp.yaml
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml
Documentation/devicetree/bindings/clock/ambarella,cv75-rct.example.dtb: / (ambarella,cv75-evk): 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260730104330.81367-5-longzhao@ambarella.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

