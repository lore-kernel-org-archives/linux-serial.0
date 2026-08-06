Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DDB43786F;
	Thu,  6 Aug 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013793; cv=none; b=i4yFhgcVEXZCp5E2iq5CXwYW/sFlvRuMgik+tD6GpnkoJuGuJsA56tGJrXKlPfSWkeYhLgGYIueV4V3NHAI9TUztCgj4UG4CZhl+xsFP070BeecpN5DiM3DQfyfG+cy+5qV7TmRsoQXEZYLP5T0sSC5na2nY5gmLha2ryaChy5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013793; c=relaxed/simple;
	bh=sNEUopoyTJUHwBT+rKD2gMVOginLuCDXNd+/Fwk/yS4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ciEn1iVA1x9X0A5loZyfBhMxvyGAI7ILJknPDJlVVe+h6PeVttTTFyp93/tHZput549gBw8CnxW82hMIYF4Zwpci1jCWh8N43++fVUGUr+yXHs2EQ3gRE6lDgil2OS/Y6chrL5QyToDQWt5TcciZl+xAu7z6D5YmTFa7Bu5+rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7dcb2/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7dcb2/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A82B1F000E9;
	Thu,  6 Aug 2026 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013792;
	bh=Q2SvrgBAvQzWpCgMCUgmcZUm9KIImY+r3a3l7Zd8wi8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=F7dcb2/yd2Yy3f2kyTTPO1spfJw3CONmketrIR7kFW/uv8tdayy5Kp0RAIdhzjCcS
	 UO8eEl+c+Sz/raZTKj1eUdW1imC3ygy9gxvGs9GOe1iFGkrtxDcR1Iw2RnJ48iD8Wr
	 bHXhudad88iuhGqybIQTzHALl1BB4hPIuDGji2MH2n1++fvnnzg/73hgwNRovBBWUp
	 NrkEdqLIdd0XlyV01PrbaVD3b6L2yf1gfsxMFC4prwo1NikYv3TchGr2jb/wBDSJLf
	 PiPwTNsk0iCZscT6j8Yl3hpEKFh3oDenDpRmJGPUhgNBgtqmpErEnrZSbBQi+rMe5k
	 5mtHxrBoi04eQ==
Date: Thu, 06 Aug 2026 05:56:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-gpio@vger.kernel.org, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-serial@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 linux-kernel@vger.kernel.org, soc@lists.linux.dev, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-clk@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Will Deacon <will@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com>
Message-Id: <178601379135.876323.14270090902806254891.robh@kernel.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: clock: add Ambarella CV75 RCT
 clock controller


On Thu, 06 Aug 2026 17:34:11 +0800, Long Zhao wrote:
> Add the CV75 RCT clock controller binding and clock ID header.
> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  .../bindings/clock/ambarella,cv75-rct.yaml         | 66 ++++++++++++++++++++++
>  include/dt-bindings/clock/ambarella,cv75-clock.h   | 17 ++++++
>  2 files changed, 83 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-tdshp.example.dtb: tdshp@321e0000 (mediatek,mt8196-disp-tdshp): 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-tdshp.yaml
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260806-longzhao-upstream-cv75-v2-v2-3-6b09707c5fe9@ambarella.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

