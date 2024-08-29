Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FB1547C8;
	Thu, 29 Aug 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924144; cv=none; b=NNj76QkHJE6RjGQ+I6/tqNJWKTLnOzk+H0LM/BQgpQg0NF2CwL//WbzJ6or5w20fm2MxeTFIy6yGl48AZzf7MmAuTc/mYzVgGKysLwWfZjVh6PTDWJw9cxObfI+63nQS3STMvqQUNXgWgjcNPNUtOj83/chM2g0eQSYVAlREa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924144; c=relaxed/simple;
	bh=H9lfUPv3T1mST3tzbqShCdPOuFcAKP3xRCkh/nwpKwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbscrmygXeqz3bU389JY6S8m2QegVnsfrBaPZCjKGMrDFZu3CYmOoruH09lFOz5HRL62WOu/msdawZuqd5oW2xadjARn0NYKvAmwJpoKb9uXTgOhcjQ72kAHYznOWqB7jovNGdX8zTLGwuRDirweO0Qyy1VZS4nwZvElTPFHa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Jq2XZ2Wv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Jq2XZ2Wv"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6A1724157B;
	Thu, 29 Aug 2024 11:27:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BgBux_5UOXgm; Thu, 29 Aug 2024 11:27:54 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1724923674; bh=H9lfUPv3T1mST3tzbqShCdPOuFcAKP3xRCkh/nwpKwM=;
	h=From:To:Cc:Subject:Date;
	b=Jq2XZ2WvwoOnB6Q/RKRhl9eBW6tXwK6poVcZiFavSh9HX2vyeZhJCqp0V12JOgMEp
	 Y9XDP4ECZvXkBPjktrReKakwSa30mOpNX6TVBYsPbMPqFwSdl0tJf8PVjE/cMGFun1
	 VfsEQATb/r/EDTUyFZiYfyZiH8Uf60RgzW+P4AlJP//1gbhh6OW0hlW7+0uON+nyLt
	 9HmOsGKWzpFWa4bHHQZ23F92rpFG8HoI8Zh4kDJgBHxPw+kBjbZnzBLz2/7C3jZrhG
	 IiUsd4HImvLCEYXDWtr+8AtB4rIZ2OSjAZXqWICiyIfnXvoS8kop/FZHsIrWs5zzbf
	 UeMHGrvhitAUQ==
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
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 0/4] Add initial support for Rockchip RK3528 SoC
Date: Thu, 29 Aug 2024 09:27:01 +0000
Message-ID: <20240829092705.6241-1-ziyao@disroot.org>
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

Changed from v3:
- move mmio devices into soc node
https://lore.kernel.org/all/20240814155014.18097-1-ziyao@disroot.org/

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
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   |  22 ++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 189 ++++++++++++++++++
 5 files changed, 218 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi

-- 
2.46.0

