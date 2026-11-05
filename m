Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889522;
	b=XUPQREe7cYfN4FqiOwMPbt8taZkXqAetvtCh1KLWYk9R7vJZofLgDtkqm6LGVNH0KoXh
	 DGWMA/s+D7KuJzsHIXCm9Qq++pOyjMLAuTtk1NpPFCVRINkRQFYhschETfoK70YGR3/WO
	 h0/o/egkZhyUa3DORXnJMKV4zBsON1rjbY43mEUup+aon2qwbDd/biarzjlhMskiTlKp2
	 aFqnyJY8GLaU+9PY8ZrzdW/SidiKyi245hmPKA2jUYS4WeEmNkN+1f7qdCRSkdTqZ8Aga
	 8N5YjsdlKIKJ+yz4318LOXg+S7REoEUtHsvX94FM6apIhr1hPnjUdcf551GlCfBswEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889522;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L80SksQGChg4YQhhJ8Sy2tnwSAR/qlCY+GCnmyv3fG8=;
	b=geo0Dgppak1B3TpBNo/WEHhTLdcnHgEl+4fE0XxpVLqKmjUJV63Ri41Wr1euk0EB9La7
	 IJBqrow8gjIe88V24vgn6/oleQiTRqc8WtyiKRxb8Uw//MqaR36MCjy66ro07PltDrWWr
	 dEo1con1LE/4d3nIZc08NRvF09SbqBdTccuycZdVwRBGgns8DkIHZ/MbXNDoro8II7Zr5
	 boMJ2J9NZlN8kL1z7nF3pbuwh3trjRI9yZj/DclzwxQJUCiXthnRvBwVYGs+RXMXdspwL
	 l83mVzXSvl48VtJCN1gRFjBipt+7d6klmj4K8G9dk4dnWNoggAmHz7LqAX0k9PFib0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hl3DJjlk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06487606A31B;
	Thu,  5 Nov 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hl3DJjlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A911F000C1;
	Thu,  5 Nov 2026 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889521;
	bh=L80SksQGChg4YQhhJ8Sy2tnwSAR/qlCY+GCnmyv3fG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hl3DJjlkwLaQLAcKnQ5qD+cmPMDJt63km5YLGbvM+Ub6cUPJ41pjVbBoXjhGRUCqn
	 ZdOjwpWOOhMORpgAivucDTlAD3dMxAKBmV0px68jP1yL55IkGfG8qrpvYSu2u4isb9
	 d6dAYthMtjiQPPAHuUqDQy70h654dY+91VCWAmN2urKANaC9fWdkr86eis2gsH3yi8
	 UlZXkgAk+JiQ6z47kchee01pulqw4SOnyrtojgvDAQpEtrjUVfvEaeIVXezFdJl1SX
	 G9rVyV3BMSoJMnKXVwJ/AiWgG2aa5PmDrh/maXQCRsB9S+r3jlhstfxjomjqwrV5h3
	 r9kyWhNMDWcoA==
Message-ID: <sashiko-outbox-199255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: mediatek: Add Amazon Echo Dot (2016)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-6-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
 <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-6-e68d7d428f99@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:38:41 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm64: dts: mediatek: unmatched mediatek,mt8163-wdt compatible i=
n mt8163.dtsi
--

commit 1dcf4259a2a7c0a8d0a32ef9d20a66f3c078542e
Author: Ben Grisdale <bengris32@protonmail.ch>

arm64: dts: mediatek: Add Amazon Echo Dot (2016)

This commit adds a device tree for the Amazon Echo Dot (2nd generation, 201=
6),
codenamed "biscuit", based on the MediaTek MT8163 SoC, and enables building
mt8163-amazon-biscuit.dtb.

> diff --git a/arch/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts b/arc=
h/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts
> new file mode 100644
> index 0000000000000..5fb5d59e4ed25
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (c) 2026 Ben Grisdale <bengris32@protonmail.ch>
> + */
> +
> +/dts-v1/;
> +#include "mt8163.dtsi"

[Severity: Medium]
Building mt8163-amazon-biscuit.dtb includes arch/arm64/boot/dts/mediatek/mt=
8163.dtsi,
which defines watchdog@10007000 without a fallback compatible:

arch/arm64/boot/dts/mediatek/mt8163.dtsi:
		watchdog: watchdog@10007000 {
			compatible =3D "mediatek,mt8163-wdt";
			reg =3D <0 0x10007000 0 0x1000>;
			interrupts =3D <GIC_SPI 128 IRQ_TYPE_EDGE_FALLING>;
			#reset-cells =3D <1>;
		};

However, mediatek,mt8163-wdt is not documented in
Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml, nor is it
present in mtk_wdt_dt_ids[] in drivers/watchdog/mtk_wdt.c:

drivers/watchdog/mtk_wdt.c:
static const struct of_device_id mtk_wdt_dt_ids[] =3D {
	{ .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
	{ .compatible =3D "mediatek,mt6589-wdt", .data =3D &mt6589_data },
	...

Will this cause dtbs_check to fail on mt8163-amazon-biscuit.dtb and prevent
the MediaTek watchdog and TOPRGU reset controller driver from binding to
watchdog@10007000 at runtime? Should watchdog@10007000 in mt8163.dtsi inclu=
de
a fallback compatible such as "mediatek,mt6589-wdt" (along with the binding
update), or should mediatek,mt8163-wdt be added to the binding and driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-arm64-init=
ial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch?part=3D6
