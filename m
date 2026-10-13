Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924761A9FA8;
	Tue, 13 Oct 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895243; cv=none; b=XFrEqZBlD/hwnogLlcIp2Kki+NJdfi0pH3im3QfjpPm8LJcMYIfYpd9Z0OBjpgdo0Pv0dlLHS5ACHXfG2WAClM2Ljx3GEO0ZvVbS9mcQtxdJGqGFXZ2y0XobEfLbP8dYCJ/QytZ+bYw9DBV+BPjQEWrEtyTgbq2CESdWGwz6gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895243; c=relaxed/simple;
	bh=tdCnVLQjztegDcspwnfbrGCRR3nFA79dUIYY/Ho3dO8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=f6ndIr3PwzvJB1hNbga0jXJPZeg+c/pTmID62MCf0hmXzyQbp5qVNLF1L8vuGiQa+QMJ94wqtzKto8dueuFYJSMxpxOIv1gCyppKUT3Cyj4TVzwV5JfqHsI8cdUS264/6Q/SZvc2lAAdtJnoM1V+iaFTvOjg8UWaVg2EpSA4te4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqof8uaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqof8uaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E69B1F000FF;
	Tue, 13 Oct 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895242;
	bh=MN3wM5z02C2EbjykjJBw8CRBl7hi08MZ0mOQsv07SVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kqof8uajGfrCV8yRYNQsXgDdXj/HTaY823cpkZzjKjTN1N3qjvehJZTJy6XhypoiC
	 vKlmxXDk1D0TpPWbx0uzssDB1JKR5CXHFIBAwg0ssze5UEZ2YjHLBbgcWpKkMPL8Cy
	 GAM70NPIj+y9+b26COzXPSprWGQizplf8bRRn3jEUhmKIsEE+eEfey3Fd5hQltXDDA
	 B5/h5tLAO0A9zKGReaYIs8QkooprhA662IPhRKZpBdkO/sOtBvrBCSxeU0s+JYfsBh
	 8UsW4vrpsd2DiHPSMB9axuWNpJDsmu8eh9QR/5E4ZgLVoYQJfA8bJJQd7717W9XCgB
	 ZdFwIAvrTAyVA==
Message-ID: <sashiko-outbox-169730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: serial: create binding for mcf-uart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013120831.1046590-5-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
 <20261013120831.1046590-5-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:40:41 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: $id path mismatch breaks schema cross-referencing
- [Medium] dt-bindings: schema keyword typo allof prevents base serial sche=
ma evaluation
--

commit c5bd98e903d69d54479e4a7058d0ad59884cfb54
Author: Greg Ungerer <gerg@linux-m68k.org>

dt-bindings: serial: create binding for mcf-uart

This commit creates documentation for a new binding to support the Freescale
ColdFire UART hardware block. This hardware block is found on M68K derived
Freescale ColdFire family of SoC devices.

> diff --git a/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml b=
/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> new file mode 100644
> index 0000000000000..d1dba518f67af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/fsl-mcf-uart.yaml#

[Severity: Medium]
Will this schema mismatch cause a regression by breaking cross referencing?

In Documentation/devicetree/bindings/serial/fsl,mcf-uart.yaml, the file is
named with a comma, but the id is defined with a hyphen.

The device tree bindings subsystem guidelines require that the path in the =
id
field exactly match the file path relative to
Documentation/devicetree/bindings/. The dt_binding_check tooling will
encounter this mismatch and silently skip or fail validation because the
paths do not correspond.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale ColdFire UART
> +
> +maintainers:
> +  - Greg Ungerer <gerg@linux-m68k.org>
> +
> +allof:
> +  - $ref: serial.yaml#

[Severity: Medium]
Could this typo cause a regression where the base serial schema is not
evaluated?

JSON Schema keywords are case-sensitive. The binding uses allof instead of
allOf, meaning the reference directive is silently ignored.=20

When running dt_binding_check on device trees utilizing this compatible
string, it will not enforce necessary properties or allow standard UART
properties because it fails to inherit the base serial schema.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120831.1046=
590-1-gerg@linux-m68k.org?part=3D4
