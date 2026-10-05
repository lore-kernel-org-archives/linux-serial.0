Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B314CB8AA;
	Mon,  5 Oct 2026 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215351; cv=none; b=n23Xdh9VQzkhiQuwc7nJIeoVUEHHn3eSpKuNJ3Pt/GM1O6h8CQ+Tk5KE8qLwsapL2iqB2ZRygBJ6lsaXcMR1jQgBltJntHPFstlED3RQXllwR4kgFuJBXJmGyOE/gWMvAhuBw6+Pnr2DB1qnwu81AKMR7jSBtfe8oHR7zCfIeQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215351; c=relaxed/simple;
	bh=KgomGN3Yi/GUVWkTsc8I9LFLDnuZkLs1NBs5FVF9dEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tq4a65K0g8QQbAQip+GNYsW3ZsKnQcmoABkZCg/Gs9/1ejbVmp1dmxyz/XBOxpJqC9ab2Q+H8RYm8IR7c228Og58qs5gQcz00gqb9nvzQeZBBtM9VLRUus4XlzTWItXuScuSSQtz9XDrPwOsukdVIZlA8UgayWgOS59LJIkEpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP3UMOQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP3UMOQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAA21F000FF;
	Mon,  5 Oct 2026 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215350;
	bh=kUV7xRC9X+QrKJ70POIRsLRj18000rGQgk0i7PAYBAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cP3UMOQM1cGvl+F4BXx7OCjA1eEnB2ZiR9AS0Z0TjMNM++6i8w9i5mRxgEseK4xeG
	 V6w6PTnmAQcnYgCjvDMS7P5L98MwFZtEZbktTa5/FfEiyCA1i5PI5hG8XqVkmokRmJ
	 A/DxXJqFljXQyEbPXr5/H7re3Zd+nxioYSlTHh4Hh9QJ1jPzJVm5cA0fsxsrkqWBks
	 83aw9CnA6P7lu3DedAmD4t5XEjce8HzfYriXjs+jCzslOnoZXN1N/uYncTEm6V/E3r
	 FJx39dwgW4Cogg48zlQtoZkBQGbBmT2biEgNsCZHD15rgv9s6VXAKaGLLR/AGh7qhH
	 9G0+wi+WYFbWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics
 sl2610 uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261005151918.25259-1-jszhang@kernel.org>
References: <20261005151918.25259-1-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 15:49:09 +0000
Message-Id: <20261005154909.BCAA21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: missing minItems: 2 constraint for syna,sl2610-uart re=
sets
--

commit d2c2a625dcf17e541f9ec792d85888075ee11605
Author: Jisheng Zhang <jszhang@kernel.org>

dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl2610 uart

Add the compatible for the UARTs of the Synaptics SL2610, which are
compatible with the Synopsys DesignWare APB UART.

> diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> index 664305de4986f..a40f2737e71b5 100644
> --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> @@ -34,7 +34,16 @@ allOf:
>        properties:
>          resets:
>            minItems: 2
> -    else:
> +
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - starfive,jh7110-uart
> +                - syna,sl2610-uart

[Severity: Low]
Does this compatible string also need to be added to the if-then block
enforcing the minItems: 2 constraint?

This block explicitly exempts syna,sl2610-uart from the maxItems: 1=20
single-reset constraint, indicating it requires 2 resets. However, the=20
block immediately above this (which enforces minItems: 2 for=20
starfive,jh7110-uart) was not updated to include syna,sl2610-uart.

As a result, device trees for syna,sl2610-uart with only 1 reset will
silently pass schema validation.

> +    then:
>        properties:
>          resets:
>            maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005151918.2525=
9-1-jszhang@kernel.org?part=3D1
