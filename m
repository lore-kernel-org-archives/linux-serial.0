Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696885;
	b=HkNneB4NMehqzhSONdtGPMtxDkdg7+n8gRMJSyM1cuCUCSt+4Hx8hWy8blVCIt8qpcWd
	 KRJEh5W3Taasnzo150iKBaMjE92AwRdmo3e+Zxq84Cl88f9a/Z/B1aNaYXdFGMoV8L8Lk
	 pEMNcdzGyVOpdmUbtHvz67iFHwomTPEKm6Vvc/ql0D4GZNbdey1B8TN4HxQoKTYREDmvy
	 YToBeIROl/AlFWdt44SZiEipQ2doToUvHel1APmGImtG4TEwy9uJfXfBJGzm+3D6SYOLP
	 ImlWgE+b680XlcvbMGX5okLhwIDkTzZIKTfCZpzUuVUfPWwT9/WskQDpxTDe6KT3kRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696885;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vQq2/q5vUElXwPSdG7ABYlW0YvIeOi1yQ+hYmdgmbOI=;
	b=UW0WexnZb4hb/zZizsjHQo66SvXkz1qvEVsGY6d+1ZgFTk3gSKJb90uFc5mRS0Pg5l0y
	 dthtpRhK7J3gJ8/jl1ZEnlCJifBbqmrZN9+ps4t8BkDIptIaqqz++04vb1mc423AhHPWX
	 Oik2J1ztLn1YipucTEF9xJRb14veM9/KiR5QxggqxgIpDMYF8NK0u2xszyexgyuEEjWzr
	 SRWjgbPNPbnUvkPTpbJZ7Xr0opbKWjd+QDa1naQWe9OIzyi/jbAQzCDfvrpLk43V9aGf4
	 YZx4wGUR78YDKwQ24J7OrgBZM/FtZf2kZNR2luH8jnEnuDYqoCAivhmMAwSmjznVipQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QldK1S2+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F04606A32D;
	Thu, 26 Nov 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QldK1S2+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696884;
	b=uGxDBoYcpWg/c9W7P9BvRSTtuwB26JS0BYmeWoyNrclFuB/2LSHbq9fmGy5qquRMZeUA
	 fXah24I/zrgL13QfoXy4bYMxpAjLBpCalCV8v1Ps7t+f8PTarF7BVosZHu9HjwoEc8CSe
	 QP/RTnG3SqI8sxs9SB3/Woheh0EStieD2Dquskz6Ng67Xifx5342ZvBiz7GgriiU8wh3A
	 TRKkh+LZ1r6qt0iRsLH915ehki08Q04+jRHlhxqA6HCIQNqd2pJhxc1/a3KcwISkZAWBf
	 rjz7R8Cw2/9a5TVF5Fw0+lZ3eTqclDVMrl04GtzF+SZ8C9E8iVyddhcTpaotkY19uUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696884;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vQq2/q5vUElXwPSdG7ABYlW0YvIeOi1yQ+hYmdgmbOI=;
	b=qbOHkWivi5u8oye1yAgobxOuhLaZmwxlO9lvS5bgo0qHSKdTuIXHxOGli12IXOPFt2Ib
	 MZI4zpmuPZuYzIXSLdx54ehMqAfauOn4JW+XzYekSLAqYVgKRGDqWAAJSHGnllSK0l6TI
	 STTroOykjuaii5xxzohsWQt1WbfaaJTbsw2eRTW1vc2syvejVT3XY8xQcMduYq3h1PLV0
	 azV/bwB5CPiT1/bqWdHc3g9C9u/IHZFlkDwCXM9X5pTSf6Pz4QxYkReIOgYYlM0TnHOTg
	 yK/oFjPw0vGeEUfdY/CncdNqZYq1guQkp0RmGzc7/sX1Ux7jX6uQtdaSwDpGRkO4emw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 51C371F000CA;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696884;
	bh=vQq2/q5vUElXwPSdG7ABYlW0YvIeOi1yQ+hYmdgmbOI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=QldK1S2+cm6Y5eKkNektDUpAw0U3ggdTUBsT4KM8W61fa0p5/FGChBTMGgPiohZhm
	 EGRRDt/l9jt9lvaKu5xTBGPYB5J0KeXhtSMCqr2qqi0efsDfD7/kD+5J8RFM/S1teL
	 C3wXTdTcy4l1dPqGe6WAEL6wb6unwnyujrnlskl+RdD5KiDoIe4l2z/yiAW1TjFe7O
	 O8ih/eI1Eq1RlvNeoHQ8nmfIJyLX7knhI/Wz29SZjzo04mEeYHKjYjmOLNVLapY64g
	 5YeQySZT1tA/EVzGRjfWqFKc5PYe33Bzbxjh0WD6d+26oRqCeW/49beM0Bewm2i2SU
	 /ggvus5K8Xyow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5185D4D4C8;
	Thu, 26 Nov 2026 12:41:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/8] arm64: mediatek: initial support for mt6768
Date: Thu, 26 Nov 2026 14:39:53 +0200
Message-Id: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDXRUSWuIhZag7EoaRGJuLti+
 ZKff0EgzxSgTi7wdHDgxUXINAE7dW4kwX00YIZaStRCl7oS7HgTqkCjeoN5meUQ+9XTwOf3atr
 fYTcz2e0dwH0/cHtiXm0AAAA=
X-Change-ID: 20261126-6768-init-452b4db23703
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=1911;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=OuksRoDHKFpT/R8LxjmQb4PYxWFGU2toCTWUqRQ83nI=;
 b=M8pLRwIso+8rS6ShJtdTTZ8LXr45utWV3TwSmwDKcanvlFd8lSNaDtyAwkSlI9x8SUU2U0dwx
 or4OP3XkIa0Ahz+lp+/izRarO7wnUi18pqJzDcMEGt5RNvk2QYQ1y0h
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds basic support for the MediaTek mt6768 SoC and Xiaomi
Redmi Note 9 smartphone (codenamed "merlin").

The mt6768 is a 64-bit SoC featuring six Cortex-A55 and two Cortex-A75
cores, typically paired with LPDDR4X memory and found in low to mid range
phones.

This series requires custom TF-A and U-Boot forks, because the device
shipped with broken PSCI implementation and bootloader that pollutes dtb.
TF-A: https://github.com/mt6768-mainline/arm-trusted-firmware
U-Boot: https://github.com/mt6768-mainline/u-boot

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
Roman Vivchar (8):
      dt-bindings: arm: mediatek: add mt6768
      dt-bindings: serial: mediatek,uart: add mt6768
      dt-bindings: watchdog: mediatek,mtk-wdt: add mt6768
      dt-bindings: timer: mediatek,timer: add mt6768
      dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: add mt6768
      watchdog: mediatek: add mt6768
      arm64: dts: mediatek: add initial mt6768 support
      arm64: dts: mediatek: mt6768: add Xiaomi Redmi Note 9 support

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../mediatek,mt6577-sysirq.yaml                    |   1 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/timer/mediatek,timer.yaml  |   1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../boot/dts/mediatek/mt6768-xiaomi-merlin.dts     |  42 +++
 arch/arm64/boot/dts/mediatek/mt6768.dtsi           | 418 +++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c                         |  22 ++
 include/dt-bindings/reset/mediatek,mt6768-wdt.h    |  19 +
 10 files changed, 510 insertions(+)
---
base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
change-id: 20261126-6768-init-452b4db23703

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


