Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CC401A01;
	Thu, 24 Sep 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240006; cv=none; b=rnbEmapECQ/abt6zaeF+a5/vL2vuaxNUil2oomhr3+7W4HKGb70GVoMH3wT/hu9dcjtvVrv6kSZvdsaQG6sByNmrzUyTZnS497XTtYvWJsrXmef/IhfxO11YzPp6J7ShXryIftvah98BjDD6OmHm85lark526DIscxNghY5In6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240006; c=relaxed/simple;
	bh=XN8hK45TVTO6k9vuWg5Zie+oqvvx3jasXgY6Ls8cYoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQbrblAR+hV1dUm+HwiD7Mj3vwmTcYsLVLChQbKDKOt7jPwV7UHzME22gp6nZTPUrA4tuXMvETonCGXCLVx9yjFfN+z/gCP68/AElkKSZnae8ymfQfl9/NodXLmFbQ6sig11VUx6w/Z/4Oc81wO8s9EbM02ArmCESUM3Ud7vqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjx1VV4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjx1VV4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D001F00893;
	Thu, 24 Sep 2026 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240001;
	bh=XN8hK45TVTO6k9vuWg5Zie+oqvvx3jasXgY6Ls8cYoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qjx1VV4Iw+SZbcRA5aAO07rlOVeVfUd9m3rn0y14GyhcwGORt4N0o+49ZXxrDl9WL
	 WM/Y09i7hh8FmdlqeRYPAVwc9AoEieqX8w6jWTDZ0lN0PXonGwRyjFqpeU29myya+b
	 alb7vx//YcbQ5bAOBoUvpBMLsTmu9DuIGKVs+xCQYOxOmAKjwPwp+2v5EE0+VRCQXQ
	 ri+AyVBa5gIu7BKF/t1SvwVnpg4lGfI3E+K9JNE46K1WZ312aa+3G4tLKc4sJJ79/a
	 Z2Bd0WaOcnpek+G2jT4x3+PAzEmIzOU5+K8W8bsmy3pTKPriwnBAsBHq9ufc+CbEjv
	 ZKqCisaFXOfAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: mediatek: add Genio 520-EVK board
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis-Alexis Eyraud" <louisalexis.eyraud@collabora.com>
Cc: linux-serial@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-4-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
 <20260924-add-mediatek-genio-520-720-evk-v3-4-2ec5c80677d4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:53:21 +0000
Message-Id: <20260924085321.99D001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing mt8189 dt-binding headers causes build failure
--

commit 89127654e38899b1e36f59aefa3964e9801b30af
Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

arm64: dts: mediatek: add Genio 520-EVK board

This commit adds the device tree for the Genio 520-EVK board based on the
MT8371 SoC. It provides basic hardware enablement and registers the new
board in the mediatek device tree Makefile.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts b/arch=
/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts
> new file mode 100644
> index 0000000000000..b4fd343bc08a6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2025 Collabora Ltd.
> + * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8189.dtsi"
> +#include "mt8391-genio-common.dtsi"

[Severity: Low]
Does this commit rely on dt-binding headers that haven't been included in t=
he
tree yet?

When compiling the device tree, the preprocessor fails because mt8189.dtsi
attempts to include <dt-bindings/clock/mediatek,mt8189-clk.h>, and
mt8391-genio-common.dtsi attempts to include "mt8189-pinfunc.h". Both of
these headers appear to be missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-add-mediat=
ek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com?part=3D4
