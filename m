Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549621D5AF;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=fjWd62tei0IPlwBbTUE5sAkiFBKaLrSh1U4sqWKKhwbg44gUR6EbYZ+czW4OWrAg0Ng+PfCzBCVG6DF6azaHClHHfzAl+z73XaFUnoO2bjV5NjS8F7NA/uaDFwmCdK3ZxprMkfHmV20EVAfQmdsgN5y+K53o/2Kpk+r/zoqU2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=thj8fkgUx0n2g+Qn+PTrOCu0LTjxGyRDrb52j8S8ekc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ibim9G63UDwd637Jqeu72Nll29eZGs0Hf5zt5604LALhBlCiiyjhWe+Zg1706XiyEcyljOf0j4/LoXZ1EDN5oA99bZ433Opy38HbN41kdVVgOgs5fna/y2NX7HO5oG0hdYpiQvjMw762SzlvkVWzbcm/7RsIyRfPw3oad263XNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F72mnuI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F72mnuI4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CF06C2BCFC;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=thj8fkgUx0n2g+Qn+PTrOCu0LTjxGyRDrb52j8S8ekc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=F72mnuI4oHnt4nKAU+QkStDp7WvhbgzvQO0ShJ6HRc54JUkxevJikJ0CeHe72Y+Ew
	 1Qk/1MTRKrciGPL5KtgeXI12f01fzvz+s5amBJGPYYDYdPZIYXQxYnApdCLV4I0pBc
	 LkhoIYG1ATZD/lxwcN1vYu7AdxEMxsHjlZJwUQA1WX/hPN916Om7hq4/oeK6qHyfcr
	 evgv7qKJyG5lPW/rCZ6g4bmJTcRnWN6m9O7DWEE3t7vf4L14n/pUfdXW5Y9ZjnMOvS
	 BjmflVr8Y7fhRE5HWo7+9zZyMdqCXRBmEmvo8dwdUNWZy/DMJnvF2aDlOzrvyImDFS
	 afspQ5FGOU1sA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC53ECCA490;
	Mon, 19 Oct 2026 00:40:42 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Subject: [PATCH 0/8] arm64: Initial support for MediaTek MT8163 SoC
Date: Mon, 19 Oct 2026 01:39:56 +0100
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ7CIBBA0as0s3aSUislXsV0MYWpjkohQI1J0
 7uLunyb/zfInIQznJsNEr8kS1gq1KEBe6PlyiiuGrq206pVBil53aMsUoSemNcYQyo4h4SenVD
 hB/pilD5iDhaZTsb1g50GIqjNmHiW9+93Gf/O63RnW74T2PcPeljb5ZEAAAA=
X-Change-ID: 20261018-arm64-initial-support-for-mediatek-mt8163-soc-ea58d47cb7aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=2459;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=thj8fkgUx0n2g+Qn+PTrOCu0LTjxGyRDrb52j8S8ekc=;
 b=i7OwJUkugOJE/D+2y+P+4fegBQ7NuLsKS335d+2Vi2ni8uBe4FdVhG0EnIbq72qaanzaK0SBo
 lNocYm3/9rMAQ7ClQ2xo2w5Yc2Rmgxz43NVeTj0SfrgeBg//XTWCMu1
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

This series adds basic support for the MediaTek MT8163 SoC.

The MT8163 is a 64-bit SoC featuring four ARM Cortex-A53 cores,
typically found in entry-level tablets and smart displays, such as
the Amazon Echo and Fire HD devices.

The bindings, SoC dtsi and watchdog support added here are enough to
boot the 2016 Amazon Echo Dot (biscuit) to a shell over UART0.

This series requires custom TF-A, U-Boot and OP-TEE ports for MT8163.
The stock vendor firmware does not provide a usable PSCI implementation
(the vendor kernel brings up secondary CPUs with a custom "mt-boot"
enable-method instead), and these ports also define the reserved memory
layout used by the board dts:
 - TF-A: https://github.com/iara-linux/arm-trusted-firmware
 - U-Boot: https://github.com/iara-linux/u-boot
 - OP-TEE: https://github.com/iara-linux/optee_os

This is the first of several series. Support for the remaining
peripherals will follow, starting with the clock controllers, pinctrl
and power domains.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
Ben Grisdale (8):
      dt-bindings: arm: mediatek: Add MT8163 Amazon Echo Dot (2016)
      dt-bindings: interrupt-controller: mediatek,mt6577-sysirq: Add MT8163
      dt-bindings: timer: mediatek,timer: Add MT8163
      dt-bindings: serial: mediatek,uart: Add MT8163
      dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
      watchdog: mediatek: Add support for MT8163 TOPRGU/WDT
      arm64: dts: mediatek: Add basic support for MT8163 SoC
      arm64: dts: mediatek: Add Amazon Echo Dot (2016)

 .../devicetree/bindings/arm/mediatek.yaml          |   4 +
 .../mediatek,mt6577-sysirq.yaml                    |   1 +
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/timer/mediatek,timer.yaml  |   1 +
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../boot/dts/mediatek/mt8163-amazon-biscuit.dts    |  68 ++++++
 arch/arm64/boot/dts/mediatek/mt8163.dtsi           | 243 +++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c                         |   6 +
 include/dt-bindings/reset/mediatek,mt8163-wdt.h    |  23 ++
 10 files changed, 349 insertions(+)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261018-arm64-initial-support-for-mediatek-mt8163-soc-ea58d47cb7aa

Best regards,
--  
Ben Grisdale <bengris32@protonmail.ch>


