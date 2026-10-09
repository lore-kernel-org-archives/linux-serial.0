Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722C3D567F;
	Fri,  9 Oct 2026 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534653; cv=none; b=pyabgeEGpeNfk2pR5boyOfcF8PiI7SsKT1nbGSLxxRS509wRpPxAp5Qb80KyaYRdPtw+6I4/T2r1l2X/XqF4trg+B3a+6w3OLiPIwVi9UGdhjvzdBa8e1ogdZksjEwnDRwV+koUHZFfICfZxwAQuQS5zELUlTPyHXLr1jlF6zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534653; c=relaxed/simple;
	bh=r3ohT9wHYAsfvCdJYDvxtn8lfj+IE/RUNqd3ruBVUO8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=inpA7QV5I40oVxWuLej1w94imPi84kBKWKKUALAscZWTw/ByFonfIen+TNv43yrZHgpqv2ScrDVklw8Q8XzbjURMkkgK28fAsl08q1juhwPluuaUbY4aA8GnIV01mqgediWPYU9DIq9pyAwCCBBlJ6HQ8p7ku116P22KNCDGlrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mglpgA3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mglpgA3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886011F000FF;
	Fri,  9 Oct 2026 08:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791534651;
	bh=Hq5b8Cru+MoWF0/UduBplYFu12iGqoWfxWeeHwXim30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mglpgA3TB2C8Z6/EgQhNGcZ8uco3kO+DIlxi9MkD2vZl2OqPk5GGy6FaloZcJ9rof
	 /6P1yLNcmD5UYdcj2nMitpCxw/Q+SQmB2QQGzMx5bCqGS76E/tLRy2x05jL9BwvPSj
	 nhLD997JVREv2/47M8jJnKYn6DWUpAJis2dFBhu5InFIxALP1PtBFm5XlvEKjPdQDp
	 XloOfk0Tuhl1KR8VWKtrLTLFrOYKupdL5DUTsE31f4TiQQHeD6ftWY7+GwNQBMhPvJ
	 ykvfp3H/QdcNEHNJKGqxaFtmwQf+R+0RIgBF5Wd30R/CJ8oRLo/9ptu+mf5KmXVhON
	 xuvhO2OHrMMvA==
Message-ID: <sashiko-outbox-165091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: serial: Document WK2xxx SPI UART
Reply-To: sashiko-reviews@lists.linux.dev
To: zjzhao@edatec.cn
Cc: linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261009082530.248219-1-zjzhao@edatec.cn>
References: <cover.20261009.wk2xxx.v5@edatec.cn>
 <20261009082530.248219-1-zjzhao@edatec.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 08:30:51 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing constraints for wk2124/wk2132 flow-control =
and rs485
--

commit f014f512db212c81969cf531fd505916a62774fa
Author: Zi Jie Zhao <zjzhao@edatec.cn>

dt-bindings: serial: Document WK2xxx SPI UART

Add a DT binding for the WK2xxx SPI-to-UART bridge ICs (WK2124, WK2132,
WK2168, WK2212 and WK2204) from Chengdu Weikai Microelectronics (WKmic).

> diff --git a/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml b=
/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
> new file mode 100644
> index 0000000000000..47a0cbdb5ca14
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/wkmic,wk2124.yaml
> @@ -0,0 +1,119 @@
> [ ... ]
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - wkmic,wk2132
> +              - wkmic,wk2212
> +    then:
> +      patternProperties:
> +        "^serial@[23]$": false

[Severity: Medium]
The commit message explicitly states: "Differentiate compatible strings by
channel count and register availability. WK2124 and WK2132 lack hardware
flow-control and RS-485 registers."

However, this conditional block only differentiates the models by channel
count. Since serial.yaml and rs485.yaml are referenced unconditionally for
all serial@[0-3] nodes, device trees that configure RS-485 or hardware flow
control on WK2124 and WK2132 will silently pass schema validation despite
the hardware lacking these registers.

Should there be an additional conditional block to reject RS-485 and hardwa=
re
flow-control properties for the WK2124 and WK2132 models?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009082530.2482=
19-1-zjzhao@edatec.cn?part=3D1
