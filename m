Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5032F43AA1;
	Sun, 11 Aug 2024 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385308; cv=none; b=CbV2r1OYkyTOg5QCe3v753uYRSgPLcLF/tMhzp7la3jFeFf6m08ZJ7imjQMfQAMzK1NIadJp/KqbV0E1JpxnmbvFf4B8ebRnXOEYGhXHlkjZ+RqzkqykMA7yIVeTCK47SyUyrwXvAuwZ60D9WX3efIX+SveQbI1T1rAJqffvuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385308; c=relaxed/simple;
	bh=UNVNR/ZqPyzz34eJw5rBf+oEyAv4KDBkWcUQLDbLptw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHxkPeSP+6z7TVll7I96X8AnVcF2Yh+cwPmD9aRfAutEQDMIJjW5QeBrlxzQOLcEaepmC2l6wgthzH1qcs7wlBooHN7i8Z5k5IGd9Jch3zFo2K/mZY8mryS2tBqJBeQdGRDacLHSS+FGqK/XugRcI8n7lNPtry+bCZiBLxMl3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PC7Oi5lD; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PC7Oi5lD"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6724240CF8;
	Sun, 11 Aug 2024 16:08:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dfrF0iKQAmrr; Sun, 11 Aug 2024 16:08:16 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723385296; bh=UNVNR/ZqPyzz34eJw5rBf+oEyAv4KDBkWcUQLDbLptw=;
	h=From:To:Cc:Subject:Date;
	b=PC7Oi5lD0TwnijadOykhVgXBuwvR6s4D3KPnmLQs6bLFUW0yvZkyxkA6u2+WYvf9w
	 g7mj1Ugs1gSj0CJNLB9tlC5f1bw4Z1dCs7dYFNsIm7QQ6ExJ8c4KsBgN8Wl2/GFR4o
	 8C3D58lvT9q2H1PoGvb0BAj+WXtYjIjEubLugmK7gry9w1Z84j9HjnasBak2gROdnc
	 xAEggK4C/OJW2l6X+KbHjxJ+Abbg8G5Hxuerdf7gXAAw/FSeb4qVs99DrkIzjDrqOQ
	 ti17eJQAtbGhEr8T7iW955lj1wLcvZ/3GXSTdk9RFo81Ql6d9QE82P2ox/+Cw3FUez
	 Vxpdlgo+ytVNA==
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
Subject: [PATCH v2 0/4] Add initial support for Rockchip RK3528 SoC
Date: Sun, 11 Aug 2024 14:07:21 +0000
Message-ID: <20240811140725.64866-1-ziyao@disroot.org>
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
2.45.2

