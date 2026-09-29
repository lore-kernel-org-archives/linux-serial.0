Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138EA3B0ADE;
	Tue, 29 Sep 2026 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715002; cv=none; b=AQADgU7CIHDMJQXJSfjKElECTmcdGOEXFnR5OutCvPaVALEtZE6uHspWb4uulRgKhgztikLb/pBzlyaop10BYjOXeWCjc7fzZRPqgWj4HhxWOW15U5bwTXAftCb29pYlBRiewmiY5DrJJWxZNUuwCJuNdMrMCV25bHFSt5mbxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715002; c=relaxed/simple;
	bh=GljF+1NC/RXZTx9+3E8FrOBm82vK9TK0wXfADWR0Esk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LJJM3lhttGaz/zDqzow/eU9oB0Sb47ANSJ+cVbFDv1dw4Eqso9s8SRamjLe2UAUSB+g5ov2Xvv1tHsIqIN6qaKKNBpIg84HjFrG+nJHSuFNQiRMa/ULnaOjhcpx4AriSFplPtA9kmFcnbAXDgDOTYLvmm99jzblnm1O8uqevJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn2AyFYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn2AyFYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F5A1F000FF;
	Tue, 29 Sep 2026 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790715001;
	bh=AOv7kS0HNWPjs/Q/hGDfbLcUNYkegrwvUSvy0nguU/E=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=Mn2AyFYQgQxhfZ7RD4Ya642yiIK8/2l2E3CQFZ0TSOL/LEpwRbPotUFT5i7aW44VN
	 z+C12JVtubChjHGmVCPT95OXkm2OsPQqHnn3/piKqm+k+KAideiHehCs4RqHDL0tNj
	 1ST0P0VyRbmWap0koRQ/yI21kOGxDr6EA1y1ycBRpRCIpy7a2jMzn/9C04WSYthCIF
	 J1yDtyTqVawdYjRvbbN8mKVIjLN2gSY3fcSV5NW2x4EVDgZMxyXXKmlnrPt2EJAAd6
	 ZGl/qpz2qkf67KftPj9Ngw1fsUuApS+EMC1UytzAT25Ye+emUoT/YXSh9C8r35hEQV
	 G3jHYpOInq3pg==
Date: Tue, 29 Sep 2026 15:49:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 linux-gpio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lee Jones <lee@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 devicetree@vger.kernel.org, mfd@lists.linux.dev, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-spi@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jiri Slaby <jirislaby@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, linux-i3c@lists.infradead.org, 
 linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260929061417.20733-16-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-16-jszhang@kernel.org>
Message-Id: <179071488985.2683003.6376725914058156145.robh@kernel.org>
Subject: Re: [PATCH 15/20] dt-bindings: clock: add Synaptics SL261X clock


On Tue, 29 Sep 2026 14:14:12 +0800, Jisheng Zhang wrote:
> Add support for clocks, plls in Synaptics SL261X SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/clock/syna,sl261x-clk.yaml       |  92 ++++++++++++
>  include/dt-bindings/clock/syna,sl261x.h       | 131 ++++++++++++++++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
>  create mode 100644 include/dt-bindings/clock/syna,sl261x.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/syna,sl261x-clk.example.dtb: syscon@f7e10000 (syscon): compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml
Documentation/devicetree/bindings/clock/syna,sl261x-clk.example.dtb: cpu-wrap@f7e30000 (syscon): compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260929061417.20733-16-jszhang@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

