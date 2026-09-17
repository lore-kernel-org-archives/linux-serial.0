Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACD56E05D;
	Thu, 17 Sep 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654486; cv=none; b=n4H4vw16JPVge0iXa6j+I5Ul7v1DZvVCJtBdapON1HhyLxoWZ1rOPIT2YLxFerS2iyOYWO5JIhzm8Jo9Cwx+Ay5wlOq8LXgpWrVTmTBLKmXexTOSzZ2YOp8WMGcdVx8O6RFW670Z8vS7F5oznMg/FEk67fdYSjEctVizbb2X5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654486; c=relaxed/simple;
	bh=4shylKAbJsnFyU7KvvNuYqOiQx2DKvhDYyX9zGdrlDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NiACRTVmmaSz8GjDYBIMwa4lpsPkqpnYEiPk48Ye766F6jVGr0YZ19ShvAg7WRlSF2rTsuZvIYGxT+eEV4cX4tpueZxBcl2T9h7GzYwu5gwbrzMoemNdkircDEA3CL326kc7I47Jg2bgW0smFjzYnm97VFcUfuLjoiK/eXER7ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv1Nz3OV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv1Nz3OV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68B91F000FF;
	Thu, 17 Sep 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654484;
	bh=pRG7pz6vO1luRi64oHWeg6SEcTUKVKg73Jlx2MVzRj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rv1Nz3OVmOtdPqUxWAaa8F+dpw2GmoUqCbWAqU30NW4FJQAh8Y8IpnPRPZAxkz+xq
	 4JACkihhJ+d4vY+Z5uQ+WPl2nN7UT3fEM5IGKVHelPvAwY+pBgLOUFV74sE0A4oFjZ
	 dMgfwuNIsOxfmxJ9nLUDgK1mGRbtzEAwK+IlAU5zgIbEauDgy28DOB69cFW7r/197G
	 w9uXiOWhOn5dOGoKAAhWGRmd1DAtRRD0RskxRIVMVNV2puGIRkON8d1jazNmIn/93c
	 ocMpf1VHOfk2SzhoxhI2+aS4mFlAceCLxkS62yW7w6vs4PpIuFgrbhLblkPhOCf3SE
	 P5Y753HJEMhNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Increase number of
 DMA channels to 6
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>
References: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:14:43 +0000
Message-Id: <20260917141443.B68B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: schema allows 6 DMAs for older SCIF hardware
--

commit ca96f7e40234020713acb3baf706d0b07d5dcc48
Author: Geert Uytterhoeven <geert@linux-m68k.org>

dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6

This commit updates the renesas,scif device tree binding to allow up to 6
DMA channels. This supports the R-Car X5H hardware where SCIF serial
interfaces are connected to three DMACs.

> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b=
/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> index 82f54446835e6..b465c93c8357f 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
[ ... ]
> @@ -145,14 +145,14 @@ properties:
> =20
>    dmas:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Low]
Does modifying the global properties.dmas limit relax the schema too much
for older hardware variants? By changing the top-level maxItems to 6, older
SCIF generations (like Gen1-Gen4) will now pass dt_binding_check even if a
device tree incorrectly specifies more than 4 DMA channels. Should this
expanded limit be constrained to the R-Car X5H compatible string using an
if-then conditional block instead?

>      description:
>        Must contain a list of pairs of references to DMA specifiers, one =
for
>        transmission, and one for reception.
> =20
>    dma-names:
>      minItems: 2
> -    maxItems: 4
> +    maxItems: 6

[Severity: Low]
Similarly, does changing the global properties.dma-names maxItems to 6
allow invalid configurations for older SoCs to pass validation? If previous
hardware only supports up to 4 DMA names, applying this limit globally
bypasses the stricter constraints of older generations.

>      items:
>        enum:
>          - tx

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4d6e5ac045af387dde8=
ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org?part=3D1
