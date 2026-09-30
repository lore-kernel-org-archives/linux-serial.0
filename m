Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B644DE725;
	Wed, 30 Sep 2026 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779146; cv=none; b=Vk7ehMfigsxWvUKXXHh8QJMmc+tD4LaRXjc1Qn2hDt35gCNmDvzDgpb0F5QbpehXthuXx2MSoLx5dG/V7FFmypGuPGZuRfDCBAlU7ydEtgDLiAgsSsWwDWhsOMqbktT3t32zG1sDLeGRje1mNZ5wN+nONWL3h0S/kjOAluICb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779146; c=relaxed/simple;
	bh=FuPPtGSHFU0HSyuu2mNWhA12dsfnCAWFjA6NZfdDpsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZuVhYue/G9T2YV46FGptKd/nkur72XzbNFfwT7pG/JuFV1YzrfZyJY4zCjge2Vdi32R1vBbDpDQA8x+6/W71GFvp9AGov9lGErwXIoiq98/vEGGVzDE4FZ+g50ahNwXoEG86tn3vUwWzjj6jpyaSyfEnmsvHf1SiKTSryy8EsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFAEBntT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFAEBntT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BAF1F00893;
	Wed, 30 Sep 2026 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779135;
	bh=TLwqX0Jc4SEY+5d3H8Hlwyk9JbAaEYoiaByM1n6xaJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFAEBntTWqsr9f+bZRPYoG8BMt2qUA16+CcPbet1ElNVDfz3duvMY1eTbRrBlpjaN
	 cIon7vOp8BIBORn0wJUIWhj/PltI4gtxG8eVMwGsGdnFsiM1OZ9yBSyUxYUCrwRsTR
	 L83NVeDeG/UuRlwckROIJvRhDJpenFVA2LR4r4OZ6e++EdeFVrohpm7StyCGVNDzLz
	 czTL6ARYUk2MMhcoCzNQaPEsRgTGnwE4aTTjFOXXBs4rAv+XwTwnmbwd62P2bA3Vrs
	 CpcI/r7ObWshXlQWe/q5qyYVT4HbL9j2Lo35umLnU0a1yzP3NPB7mv79ZGQYm/fKXL
	 /HYh7QMDms0pw==
Date: Wed, 30 Sep 2026 22:18:53 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-gpio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>, devicetree@vger.kernel.org,
	mfd@lists.linux.dev, Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-spi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	linux-i3c@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 15/20] dt-bindings: clock: add Synaptics SL261X clock
Message-ID: <ar0aTV1GTWjMN4v_@xhacker>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-16-jszhang@kernel.org>
 <179071488985.2683003.6376725914058156145.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179071488985.2683003.6376725914058156145.robh@kernel.org>

On Tue, Sep 29, 2026 at 03:49:57PM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 29 Sep 2026 14:14:12 +0800, Jisheng Zhang wrote:
> > Add support for clocks, plls in Synaptics SL261X SoCs.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/clock/syna,sl261x-clk.yaml       |  92 ++++++++++++
> >  include/dt-bindings/clock/syna,sl261x.h       | 131 ++++++++++++++++++
> >  2 files changed, 223 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
> >  create mode 100644 include/dt-bindings/clock/syna,sl261x.h
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/clock/syna,sl261x-clk.example.dtb: syscon@f7e10000 (syscon): compatible: ['syscon', 'simple-mfd'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml
> Documentation/devicetree/bindings/clock/syna,sl261x-clk.example.dtb: cpu-wrap@f7e30000 (syscon): compatible: ['syscon', 'simple-mfd'] is too short
> 	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml
> 
> doc reference errors (make refcheckdocs):

oops, I missed this dt example dt_binding_check, or in details -- I forget
to update the example after fixing the soc dtsi syscon nodes. In newer
version, I will move synaptics chip global block binding patch earlier
and update the example

> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260929061417.20733-16-jszhang@kernel.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
