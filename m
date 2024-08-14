Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD128DC3;
	Wed, 14 Aug 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650777; cv=none; b=Nf3HQdiLlRAZOsZI6D39IY+wODmzbKOSZJFXFgRwxOV1k5KiVXIUjY/2dkz+a/07g6ERgs+7ktp38bU3kOzHrWWgAv2rnxKwvSX9ZkzJdYDejVr9PYypdlWcXlHOOzTfPtAhQgygrGGJ+duuvYFrJ3hp33n6aPckZm4K6QBfUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650777; c=relaxed/simple;
	bh=1qewHqlWASIAhVOdfGLDw/liKY4yxKBTes4LCOBtdAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+mUbTnYMfCDXvyC2FB3HHG/ayU3kO0BrKQZKiWDqb3l7RT9Zfeg4LW0hYbhYtBrWbOtbWUaG3mQu7aI/UaEVYNA7hxPP8ebJf1NxU0tP6fL3umlU5/iUpcobxjNEFOxqTC5Egs6rbuyDbHOCJywUnNe0kwtIgc4NffPecjD6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OJAMElNX; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OJAMElNX"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8FD7A41ABE;
	Wed, 14 Aug 2024 17:52:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLbjJhDSXSZ9; Wed, 14 Aug 2024 17:52:45 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723650765; bh=1qewHqlWASIAhVOdfGLDw/liKY4yxKBTes4LCOBtdAw=;
	h=From:To:Cc:Subject:Date;
	b=OJAMElNXqVlglRAYXLuq0LVQdY6/GlLJY/w3rMG9FTqNoHZCcuJkXuQEAwRMn2913
	 cmci5SF/O25pSe6TByle42/sYeLD7lQidNBvp6Oum0JgOnyvNxC2Z+5nXw/BnK0aqR
	 imn5JouvITG8x6EqrVcmAtFVyKCbvnhp86z+7qpxCOrLklSVXZbap9TNSzkKhucVMR
	 lN/9zZPCUbdDenw47wodAG13Y8MXeVzzHnSjvs5Pq1AaQeIBfvEX/GPvad2X0gTekm
	 2CXozr8QPDPH/hOiEjqPNasQyttAT+HBVSMZtl8C4gMb6N0/k2Wp49tyu+WmGh+guL
	 no/uUklLRfXnw==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 0/4] Add initial support for Rockchip RK3528 SoC
Date: Wed, 14 Aug 2024 15:50:10 +0000
Message-ID: <20240814155014.18097-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 is a quad-core ARM Cortex-A53 SoC designed for
multimedia application. This series add a basic device tree with CPU,
interrupts and UART nodes for it and is able to boot into a kernel with
only UART console.

Has been tested on Radxa E20C board[1] with vendor U-boot, successfully
booted into initramfs with this log[2].

[1]: https://docs.radxa.com/en/e/e20c
[2]: https://gist.github.com/ziyao233/b74523a1e3e8bf36286a572e008ca319

Changed from v2:
- fix fixed-clock nodename
https://lore.kernel.org/all/20240811140725.64866-1-ziyao@disroot.org/

Changed from v1:
- fix stdout-path
- style improvements
https://lore.kernel.org/all/20240803125510.4699-2-ziyao@disroot.org/

Yao Zi (4):
  dt-bindings: serial: snps-dw-apb-uart: Document Rockchip RK3528
  dt-bindings: arm: rockchip: Add Radxa E20C board
  arm64: dts: rockchip: Add base DT for rk3528 SoC
  arm64: dts: rockchip: Add Radxa e20c board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/serial/snps-dw-apb-uart.yaml     |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 +++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 182 ++++++++++++++++++
 5 files changed, 211 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi

-- 
2.46.0

