Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024BD43636B;
	Tue, 29 Sep 2026 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664277; cv=none; b=cVOUFDdx71pSY3dpfp41x5fcijbdERZ6Iz1gQgPrPxsy74FLDiF/SOKVkKWv2iB1+t5t7WInbCbKcbxftHLh1PJLaq4amOu/Tv0rLVj8FRBsPCNp53oqgtd4Gw3bG74+0nyULeYHIrXtZI48aN8+j2JRwMi/BTARL0rzWGYJgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664277; c=relaxed/simple;
	bh=4xBchgruCtuMtfraixVfYAK8/9yIK2xiCGEuAZUVm8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msXDn0zDW0SB0rb9X5dVSDEd0N3dsmm1e1Kns+rvUJ6OiEEUFp/L6AyrI8KaYD4/blNz9nRsUlkbBOF5TYBbMwoPiwayJr4ANk/zVfR95GAVCy3mLHBopmxk3ThOgJ1GhGVmFXLWuP934QjDcc/vL4XL8Q/XjOwBUMormlorAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axtpkRUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axtpkRUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DAE1F000FF;
	Tue, 29 Sep 2026 06:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664275;
	bh=bJ+oJ7wH7njA5atKm2+mCrcTSv2vUPMgXS9P3JY+aHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axtpkRUeU2ceMjIqZRo/che0zuUvdIc+UKf27yA4lNTAvIJb4UGtSvFaTfZgB0PQx
	 9QC0rG7uv8lCPI3PqO1sfhINTGNkwexx0hD23aXNGcVQZNab5O/P9UZEsvhRCrh/mh
	 jJGie8KuGZ1wxsxxA4WcozQ6GHW+a5H6wNBQ/H5dr3vx5TnG7oFtk3xkrS2prx2Oc1
	 pBHIxife/gxTY5e/AGLW4aVIYOrexKGC7eg7GLlO/WgaPzPbkCwnFv3lsy/YfOqd+D
	 6RA/P4PzQ7mS0RLNIgMK6vcbyE3XoRoRMnrLxmkvO0mNGj8JQhtZ1LMHQhTRwcfcbW
	 QkpJpM7LTox0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/20] dt-bindings: clock: add Synaptics SL261X clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-i3c@lists.infradead.org, conor+dt@kernel.org
In-Reply-To: <20260929061417.20733-16-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-16-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:44:34 +0000
Message-Id: <20260929064435.10DAE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] dt-bindings: clock: schema erroneously matches generic syscon gl=
obally
- [Medium] dt-bindings: clock: missing clock-cells in required properties
- [Medium] dt-bindings: clock: missing clock IDs for AIO clock controller
- [Low] dt-bindings: clock: missing include guard in header file
--

commit e7f8a3b9148879b63e354fd7d1d51ae0ec2df9d0
Author: Jisheng Zhang <jszhang@kernel.org>

dt-bindings: clock: add Synaptics SL261X clock

Add support for clocks, plls in Synaptics SL261X SoCs.

> diff --git a/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml=
 b/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
> new file mode 100755
> index 0000000000000..3fd380c1dd39d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/syna,sl261x-clk.yaml
> @@ -0,0 +1,92 @@

[ ... ]

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - syna,sl261x-soc-clk
> +          - syna,sl261x-cpu-clk
> +          - syna,sl261x-aio-clk
> +          - syna,sl261x-system-clk
> +      - items:
> +          - const: simple-mfd
> +          - const: syscon

[Severity: Medium]
Will defining these generic strings as valid matches cause the schema
toolchain to improperly select and apply this highly restrictive clock
schema to all syscon nodes system-wide?

> +
> +  reg:
> +    maxItems: 1

[ ... ]

> +  '#clock-cells':
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Reference clock used as the input to the PLLs.
> +
> +required:
> +  - compatible

[Severity: Medium]
Should '#clock-cells' be explicitly included in this required list to
enforce that these nodes act as valid clock providers?

> +
> +allOf:

[ ... ]

> +    else:
> +      properties:
> +        syna,gbl-syscon: false
> +
> +additionalProperties: false

[Severity: Medium]
When applied to a generic simple-mfd or syscon node system-wide, will this
strict constraint incorrectly reject valid properties and child nodes?

[ ... ]

> diff --git a/include/dt-bindings/clock/syna,sl261x.h b/include/dt-binding=
s/clock/syna,sl261x.h
> new file mode 100644
> index 0000000000000..4649b233f08a5
> --- /dev/null
> +++ b/include/dt-bindings/clock/syna,sl261x.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Synaptics SL261X clock tree IDs
> + *
> + * Copyright (C) 2025 Synaptics Incorporated
> + *
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */

[Severity: Low]
Does this file need a standard include guard (e.g.,
#ifndef _DT_BINDINGS_CLOCK_SYNA_SL261X_H) to prevent macro redefinition
warnings and compilation errors if included multiple times?

> +
> +/* SoC domain */
> +
> +/* GBL common clks */
> +#define CLK_CPUFASTREF		0

[Severity: Medium]
The header explicitly maps domains like SoC, CPU, and sysmgr, but lacks a
macro section defining IDs for the AIO clock controller.

Since the schema declares the AIO clock controller (compatible =3D
"syna,sl261x-aio-clk") and requires '#clock-cells =3D <1>', device tree
authors need valid IDs to consume its clocks.

Are there missing clock IDs for the AIO clock controller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929061417.2073=
3-1-jszhang@kernel.org?part=3D15
