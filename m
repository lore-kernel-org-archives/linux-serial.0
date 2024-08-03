Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B81876;
	Sat,  3 Aug 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722689788; cv=none; b=WFAVyL5hYOGmYoezwgulLjdacCg4vmV/aNCuaigR45c0ZrlgRxKz8t5ZSlYhm2Ov2oj5C+FuBKwlY2In7zze8cU7xpWXJ9SuAFmb/YHuEuKSy9X3hOhzUChm6Q1f8Kp9Vb4gR8IhWIMIMy215lgsWKwsYmiFCPsn49+IDJRXL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722689788; c=relaxed/simple;
	bh=XUdycKTMsv2E+8uiwBLcx3vvlfuC0EfEfFUu8fsc0qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMBSv2/Y8O5gMaAYJklvRfcGi7g2blaTvmpKek5XQwJtb+JR8bjjTfeS19lnQ63FHgw0BvaC1Fsf4J6CnDvN2PeMrkwhpD0j2LwR2j4Nd6O+aCbJDqCHtoHTf0/L6CfwF0cVWMgjOATxosYaJQ9T4qc/hGbmkFOBonhwpYanAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BVlIp2J8; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BVlIp2J8"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 64E6440FB8;
	Sat,  3 Aug 2024 14:56:16 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LHZTQguMCRpp; Sat,  3 Aug 2024 14:56:15 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722689775; bh=XUdycKTMsv2E+8uiwBLcx3vvlfuC0EfEfFUu8fsc0qc=;
	h=From:To:Cc:Subject:Date;
	b=BVlIp2J8Sotye/3zXBAv47A5xoMBCOYr43urZqm4jiM918NSw325d0y/9f5ZJiVyA
	 gqCpo1LsM0M0DMID1EtJZt6wcdpzi6w0jP7JJe2fpwdnlL3Euc7EcTyolCwPB+lRf3
	 IJz3p2oVKav7c8DcbKtzuWOJgZISFAxUoNOrSHH2iv4PgElJbcCC6/UwM4ZghOj2Ir
	 vIS4YPvjdHu8RQwm2AA4e9IyG0IKw69XMWwH9avBjHk19fdGUGrFZYE4Wllg/Z4kNn
	 1W86Kk76SS8ed4zsoI0SZ4aw4piIxu/qa5KfKPNl2kyaAOp+36nCT4iQSZNPzlONyW
	 +Fzdf2O0pznDQ==
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
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/4] Add initial support for Rockchip RK3528 SoC
Date: Sat,  3 Aug 2024 12:55:07 +0000
Message-ID: <20240803125510.4699-2-ziyao@disroot.org>
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


base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
-- 
2.45.2

