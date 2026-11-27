Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785047;
	b=xLpXCANszE7I+D3bGbom+CHcoEk+DKbVzY52dyuRRgzH4WJrKDwMowU7lXXDwyHn8sep
	 law9tUhhDUviJTWqWzNhoTjuF/kWQWI3My8Y12FBQDopN24JwvQIWSgLxkgNsHye3A3GC
	 F83X3cS7beaOwETkvEKjlNzFEtICdNVAX6NMyDHpiXM5VC2hyEKGdupzkgvJU+XzM+li6
	 ddCIt7S3dRC7trX6+Td/XCDH9Q41jNeV7MrBsWdRDvGQdZSMk/hxGkzS/BSv/uFLN8VUa
	 K5S8SJvWve0pvxSm2VUVO6v/CbIUinVBqdoanovaITHzw+AOLFGpDbOq2ZjRzL/gJRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785047;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZFxfAAA6GwTz51RC5rJw8wfbBqlOQRlWMUcxU0I/V0E=;
	b=v/Yw3ZX3vujTHkAJNpsAAbrDE/blU9RZMYRo712MHLHMEF5AyppsItIAaXvDHb7Gcggb
	 B/wbuNZ1Ys1Upu2Czz6bO/erjb4V2NQOOxcEcLJVHjVShWG2pgXXKt0Nf5LL8bSeVPIbX
	 dqcGK8UX0PReTT09jpFA96EYZsMQRwdPLRWVDjpLQmF6d3fznWUde8NCaXP0uQQnUMptR
	 Ud4AwJ+fI7gYbH1lcfaYj7bFv6FSIxTuhYcy3Kg/qdhtDPfD36NY1ubiKaxG4PWTAEl9B
	 Sk/1fRiSOn1uy1sthA3o0eOjJ0e68ui55fbf/ETvqGjnFoycbIboTMLu8Kuh60R/lbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.ch;
	spf=pass smtp.mailfrom=protonmail.ch;
	dkim=pass header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b=grn3HwCD;
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CA606A321
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.a=rsa-sha256 header.s=protonmail3 header.b=grn3HwCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
	s=protonmail3; t=1795785043; x=1796044243;
	bh=ZFxfAAA6GwTz51RC5rJw8wfbBqlOQRlWMUcxU0I/V0E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=grn3HwCDTOorQ5DALp09B0V9rgT7HOcv09Ofyb9FXml+uMHqwhYYArjSOQMVzhiKS
	 nSD6DHlU4jffGsj6H48yMf8lRqAxTsfI9khmN69QNMoGU+uBuMdkSAKOTWzCCSLvyE
	 96BNClbPVfSAqHyYxohYacXF9qYwgKWc6PHCJYHktHHIIVePz72+RhM+EXQbIg15oo
	 M20FCW1jcvEDPKzKFmtdO+Se3BaooawElpyxhKuBTk2RSj0oMTjc5SALYS+O3I3/UJ
	 8sEBjNFW6yUY+KUpgxUA9tfBwuFfGCQpta0G6CTUL+EuBW47NtP1Ye3ykXnwACiaY+
	 UWiZNY6WQ05TQ==
Date: Fri, 27 Nov 2026 13:10:35 +0000
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
From: Ben Grisdale <bengris32@protonmail.ch>
Cc: rva333@protonmail.com, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: mediatek: initial support for mt6768
Message-ID: <20261127131027.6af2d515@ben-desktop>
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
Feedback-ID: 27291966:user:proton
X-Pm-Message-ID: edd5e5751e2e69693495bd2942b0edb1496e65e7
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 14:39:53 +0200
"Roman Vivchar via B4 Relay" <devnull+rva333.protonmail.com@kernel.org> wro=
te:

> This series adds basic support for the MediaTek mt6768 SoC and Xiaomi
> Redmi Note 9 smartphone (codenamed "merlin").
>=20
> The mt6768 is a 64-bit SoC featuring six Cortex-A55 and two Cortex-A75
> cores, typically paired with LPDDR4X memory and found in low to mid range
> phones.
>=20
> This series requires custom TF-A and U-Boot forks, because the device
> shipped with broken PSCI implementation and bootloader that pollutes dtb.
> TF-A: https://github.com/mt6768-mainline/arm-trusted-firmware
> U-Boot: https://github.com/mt6768-mainline/u-boot
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Whole series,

Reviewed-by: Ben Grisdale <bengris32@protonmail.ch>

Best regards,
Ben Grisdale

