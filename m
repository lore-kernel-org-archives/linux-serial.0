Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB74052D9;
	Thu, 24 Sep 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240096; cv=none; b=hxqlJxSHLjEWOAEKN9zlxz0SdSuFXKDCJKKJEex7fNuQ3kt2Lscx9320lZWGd1czP3netQv/vNknSgW2B6BybgMi2185rELQ5LbxTfm2BCtW2cB8Onn+pFmZ0RmGEUza1jOGbGJmoskthC4hwj0Q5m4syPwRSv3vcgxYifrVyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240096; c=relaxed/simple;
	bh=wTakLQ//2ozlHA6m7gZJ0de66/8qfvwcBvnGwcVC3uk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGfrxyC/qSq2icOjbSzR7YKSpFj0awaXSEdgNL4cQfobdNC0z1od7ua/BJQB4AAUBrXR+BW+l1M9xIKfZDytbOSqAd9w0n/bMRP9htj9QUYDGmMRn+7uaqE0is21KQWYrqtH5+IW0wIO0tsq+aLCYzaz1xH5t/uSudPZMRq5JAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4jmXyQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4jmXyQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3135B1F000FF;
	Thu, 24 Sep 2026 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240095;
	bh=70H8SheMSlcbawkRcJQdsqUV1W6CBrJ/umkobmFKXYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4jmXyQTeI5fsEk5Jq2LEttK1IBv2Bb0vPr25bOacKJS2UVbNFu/CNtlpHScNIpAR
	 j2TifoEnwf9BfPhYh4khos7TOzcKRHK1He/oa5HAJaXFAmwJB0KS0Gla2R9Y+WwTeB
	 hlJnmn1rRrPPxKtjlJ4DK9CP1gDn8wjzTOV7Xy6EtNGbxVOgiPYiTrsgFROLJU/aTT
	 DUUu+ivK3FAAyhITkQIMrOXoDL0C4O5CAbScKCf64CRl+dQn3F8TWO1mwiscjEnRfb
	 sVnA504huvkjuLbOaclPjb9m1M0MckEEztH9hCcyl0R7zJzVR9I+Aomb+STTTj392k
	 M5/ba/0HsgyPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: mediatek: add Genio 720-EVK board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis-Alexis Eyraud" <louisalexis.eyraud@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
 <20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:54:54 +0000
Message-Id: <20260924085455.3135B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dts: incorrect mmc1 cd-gpios active polarity
- [Low] build: missing dt-binding header files
--

commit 333fee68bbe7dfc450967c253534e7bdd3fb61f2
Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
arm64: dts: mediatek: add Genio 720-EVK board

This commit adds support for the MediaTek MT8189 SoC and its variants.
It also introduces the devicetree for the Genio 720-EVK board based on
the MT8391 SoC variant.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8189.dtsi
> new file mode 100644
> index 0000000000000..b64882a931519
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
> @@ -0,0 +1,1009 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mediatek,mt8189-clk.h>

[Severity: Low]
Does this include reference a missing dt-binding header file? This is
currently absent from the tree, which will cause a preprocessor error during
device tree compilation.

[ ... ]

> diff --git a/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi b/arch=
/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
> new file mode 100644
> index 0000000000000..00c9f3c078f5e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
> @@ -0,0 +1,798 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +
> +#include "mt6365.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include "mt8189-pinfunc.h"

[Severity: Low]
Does this reference a missing pin configuration header file? Similar to the
clock header above, this file appears to be missing and will cause the
compilation step to fail.

[ ... ]

> +&mmc1 {
> +	bus-width =3D <4>;
> +	cap-sd-highspeed;
> +	cd-gpios =3D <&pio 2 GPIO_ACTIVE_HIGH>;

[Severity: Medium]
Is GPIO_ACTIVE_HIGH the intended polarity for this card detect pin?

Further down in this file, the mmc1_default_pins block configures this
physical pin with a pull-up resistor:

	mmc1_default_pins: mmc1-default-pins {
		...
		pins-insert {
			pinmux =3D <PINMUX_GPIO2__FUNC_GPIO2>;
			bias-pull-up;
		};
	};

This pull-up implies the empty slot state is HIGH, and card insertion shorts
it to LOW. If the active state is declared as GPIO_ACTIVE_HIGH, will the mmc
core incorrectly interpret an empty slot as having a card inserted, and an
inserted card as being removed? Should this be GPIO_ACTIVE_LOW instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-add-mediat=
ek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com?part=3D3
