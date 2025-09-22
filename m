Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1C30101F;
	Mon, 22 Sep 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545318; cv=pass; b=OlwcQlS/kVxkHacxI/qTwsZHvOd0TyvauR5ah/DiQcy6LN+8pcZikzoSRYJGvfYLv/TY9iW9rHGD/KzITgkoakEnp4oLoq5++ALlvCd+RoGT3uz5TF03aj4tKNaXNGZ/7/hzdrVOX4IOi94JanKi7EmZEsL+VfeGGUDaq+Bs5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545318; c=relaxed/simple;
	bh=ajgpqeWH1J9OjvBk976S+Q5QHwI27D09dVg+WbxvooQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n0a2ItUIG31cWMneOgw64CsBLWNY63U4h4DqDjo3RIBBZaiGPBd0/Xkp2ipaK4isOrSOcdzH9G6HNIEo3Ns9ROoEjfVlgwCqNVleDH6Q0CuI63Jp2BSDZWhsOSkPxQlRs4N/RbhlLvRGDdXmsoT8wwT6XYycwi+hJOGBxpJ/yG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=bxLN3kHH; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="bxLN3kHH"
ARC-Seal: i=1; a=rsa-sha256; t=1758545252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FLON75iNI9JeHakiKtstQpQY0Ir6xijkmvDbc+pQKZMfTyA9jb5ryUx4wbF9gOxkhEW4ik81Bda4wp+jNwFQ+NhuomroOGnvfuadLWJDjLYIViTCw4MJaqO6+1PvNEsIiH4eXFcbGgLl+mMCnJ3qkCLxdBlRa6JxckaldS4HPL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QQHfWPLq9h9/26EFDezuhABuHqn17sUNy+23WQyGpPU=; 
	b=H+RUeXyAvuzi51F/NpdpfmgLuct9VvfsjU8iwVR5n9dfR/yQJ3onNE3GNyI3+qV+8Qoxhe1mwGmUxwBrqlQnUcIOTDR2L5hdYn1cBe8w3xhPED4ogT4lPtdkulbQd49LQj2peIalt4yLo8KbHmOCDws7Ui9r5nsi+YWGXBr6QaY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545252;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=QQHfWPLq9h9/26EFDezuhABuHqn17sUNy+23WQyGpPU=;
	b=bxLN3kHHHM0PpnR/N/YnowWACvzX+3ZFxQwHdkbgTlvSh/D5DLMcGjmh/gA59zib
	xF0PLnUAW7kzpyZf+Du4z1D/VuuI/X6OETsEeQSU7xvi4TD3XG0ZSfSdFLb/yjKIPbf
	3KmDtov5L9MENQ3v6HXWcX2T7WStGiHvj7v5nz84=
Received: by mx.zohomail.com with SMTPS id 1758545250603407.16427504257217;
	Mon, 22 Sep 2025 05:47:30 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 00/11] riscv: Add initial support for Anlogic DR1V90
Date: Mon, 22 Sep 2025 20:46:30 +0800
Message-Id: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACZF0WgC/2WNQQrCMBBFr1Jm7UgSG2JceQ/pIk3HdkDbkoSgl
 NzdWNy5fA/++xtECkwRLs0GgTJHXuYK6tCAn9w8EvJQGZRQWhgpcAgyW4G9i+xxSHjSiqwj7Xx
 /hrpaA935tRdvXeWJY1rCez/I8mt/LSX/WlmiQG1a4bW01rfmuvL4XIJ7HBP5CbpSygdnsNQ6s
 gAAAA==
X-Change-ID: 20250710-dr1v90-basic-dt-352e9ae5acb8
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=3345;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=ajgpqeWH1J9OjvBk976S+Q5QHwI27D09dVg+WbxvooQ=;
 b=BM1IXkvoJJUJQu9/EIL9IfPkPgdDl/LrRNrn7XaLuR4FQWU3nNPC6jFTkXc8wd1csYCvwteOC
 WQ7F3pEnccFDX2VF6rfBWZeZtllg70wToOUT18ZIDm6M/IcCmRpR03z
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

This patch series introduces initial support for the Anlogic DR1V90 SoC
[1] and the Milianke MLKPAI-FS01 [2] board.

The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
the first platforms based on this SoC, with UART1 routed to a Type-C
interface for console access.

Tested on the Milianke MLKPAI-FS01 board with both the vendor's OpenSBI
and the not-yet-upstreamed mainline OpenSBI [4], as well as the vendor’s
U-Boot. Because the vendor’s OpenSBI is loaded at 0x1f300000, we have
to additionally reserve the DRAM region 0x1fe00000–0x1fffffff to prevent
overlap if using vendor's OpenSBI.

Notice: A "no4lvl" bootarg or dependency patch [5] is currently required
for successful boot on the DR1V90 platform, since the SoC hangs if the
kernel attempts to use unsupported 4-level or 5-level paging modes.

Link: https://www.anlogic.com/product/fpga/saldragon/dr1 [1]
Link: https://www.milianke.com/product-item-104.html [2]
Link: https://nucleisys.com/product/900.php [3]
Link: https://github.com/pigmoral/opensbi/tree/dr1v90 [4]
Link: https://lore.kernel.org/linux-riscv/20250722-satp-from-fdt-v1-0-5ba22218fa5f@pigmoral.tech [5]
---
Changes in v2:
- Add MAINTAINERS entry for the DR1V90 platform
- Remove the riscv,isa property of cpu and reorder propertyies
- Fix clint base address in the dtsi
- Change the memory node to cover the full 512MB RAM in board dts
- Link to v1: https://lore.kernel.org/r/20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech

---
Junhui Liu (11):
      dt-bindings: vendor-prefixes: Add Anlogic, Milianke and Nuclei
      dt-bindings: riscv: Add Nuclei UX900 compatibles
      dt-bindings: riscv: Add Anlogic DR1V90
      dt-bindings: timer: Add Anlogic DR1V90 CLINT
      dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC
      dt-bindings: serial: snps-dw-apb-uart: Add Anlogic DR1V90 uart
      riscv: Add Anlogic SoC famly Kconfig support
      riscv: dts: Add initial Anlogic DR1V90 SoC device tree
      riscv: dts: anlogic: Add Milianke MLKPAI FS01 board
      riscv: defconfig: Enable Anlogic SoC
      MAINTAINERS: Setup support for Anlogic DR1V90 SoC tree

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/anlogic.yaml         | 27 +++++++
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  1 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  6 ++
 MAINTAINERS                                        |  9 +++
 arch/riscv/Kconfig.socs                            |  5 ++
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/anlogic/Makefile               |  2 +
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 +++++++
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi            | 85 ++++++++++++++++++++++
 arch/riscv/configs/defconfig                       |  1 +
 13 files changed, 168 insertions(+)
---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20250710-dr1v90-basic-dt-352e9ae5acb8

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

