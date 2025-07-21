Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E62D5C9B;
	Mon, 21 Jul 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113061; cv=pass; b=u4Ki5nb+OghTpEa9xkSsAH6b+5f2RquAreaRZ9uxQZotWjm9zV2xJ3XVt2WG70i5yAGu8mwHQ27pAvlDqnlpiZKibc96jNn/CUtG9TysI8Ya08un2dftywbKOtu1g8SZOfnYZlESft+qcTgJ9iiMcrWQw0IeAq++IMCCNvQXopw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113061; c=relaxed/simple;
	bh=r3dWtS0DfR1Rn/ACuj4nW8IHgBNJ1oWA5UeVc8umEeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=odumRqzm+M23TovrM4Pg4i5WMvmv9R/hLyB1O2/KMcVspbCU6wlQM4tdElHnLRdovTdvRvarZz6+e7IKLv4q/+cK/yMAY30sgCYXHsHhCWKW66IfGEPzSKE2a7q4nLGvFhtvxPzSwPnvMN8CmYUcg0LJodcUq+lanTwYfXDsIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=HXoLZVTA; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="HXoLZVTA"
ARC-Seal: i=1; a=rsa-sha256; t=1753113014; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KqKKAmYf2zvkxQUXdERjNM5NdmxSKj95ZivuIYjAQSr9NcnUbjeqH05Ig811ifwullI+anb8sSV9MzaD4ZzYbtUlY7h0A+5LSBs1y3UH+iUTGZJGCKcwlCFM7nrNq/P0tX+2z+69DCiPklNMMiNBST/CIVayapHKDCiGs8Fiffs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113014; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=87b0yZUM9BV8txVqBiMLUvYqikzqvjOolhiCh3LlqBM=; 
	b=Q2H3/9gfOTJOJcdaxLmqepir5VYQnWH47L0hqzKP3O1TJkIBbSeneNHAlRpDxCcSQRLXrGRuEdoe8VnbsMEzFszq9d+cfhzRhp1vWIMKAf6YEgiIfri5ugTRsqdI4St0Jf1QdlVNl49WMPPxK5daPg5Bk10NRdX5NNnLAccKFE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113014;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=87b0yZUM9BV8txVqBiMLUvYqikzqvjOolhiCh3LlqBM=;
	b=HXoLZVTA9EydJ2ytaU4mDZd8N9ii1xhoRs5KNTQjSmjytAxdI1ETtiEXGLy34/Te
	/FXA2xSkH/LxMDbqrMp3hKyGhRvpmeyHeGqEvh0Je//HFuesGoYN5xo5TC+JXrUszIt
	QXOEY78Nwl/Jw8yN5rFK1HiEbPD8Rzxw9BeJnLNY=
Received: by mx.zohomail.com with SMTPS id 1753113011689418.4639332270798;
	Mon, 21 Jul 2025 08:50:11 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH RFC 00/10] riscv: Add initial support for Anlogic DR1V90
Date: Mon, 21 Jul 2025 23:46:06 +0800
Message-Id: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL5gfmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MD3ZQiwzJLA92kxOLMZN2UEl1jU6NUy8RU08TkJAsloK6CotS0zAq
 widFKQW7OSrG1tQD4JAXsZgAAAA==
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
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=3155;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=r3dWtS0DfR1Rn/ACuj4nW8IHgBNJ1oWA5UeVc8umEeA=;
 b=ZdozYEXri0BuBkNJKSKCxzXLS6f3dOB74CXec9evRvaicTz9MbnHLk/ezbFEqrk406Ll2ISPJ
 oAAp5VoBPn8DYB4v1eAYsr83a2u9Y0GmkwWFbCUeg4y4+BfiRA10/T0
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

This patch series introduces initial support for the Anlogic DR1V90 SoC
[1] and the Milianke MLKPAI-FS01 [2] board.

The DR1V90 is a RISC-V based FPSoC from Anlogic, featuring a Nuclei
UX900 [3] core as its processing system (PS) and 94,464 LUTs in the
programmable logic (PL) part. The Milianke MLKPAI-FS01 board is one of
the first platforms based on this SoC, with UART1 routed to a Type-C
interface for console access.

Tested upon Milianke MLKPAI-FS01 board based on vendor's OpenSBI and
U-Boot with log [4]. The log indicates that OpenSBI is running at
0x3fe00000. Since the region 0x20000000-0x3fffffff is a mirror of
0x00000000-0x1fffffff, the actual physical base address for OpenSBI is
0x1fe00000.

Notice: A "no4lvl" bootarg is currently required for successful boot on
the DR1V90 platform, since the SoC hangs if the kernel attempts to use
unsupported 4-level or 5-level paging modes. I plan to submit a
follow-up patch to allow the kernel to query the supported MMU mode
directly from the "mmu-type" property in the device tree, to avoid
probing unsupported SATP modes.

This patch series is marked as RFC because basic drivers such as clock,
reset and pinctrl are not yet supported. These essential drivers will be
submitted in later patch series.

Link: https://www.anlogic.com/product/fpga/saldragon/dr1 [1]
Link: https://www.milianke.com/product-item-104.html [2]
Link: https://nucleisys.com/product/900.php [3]
Link: https://gist.github.com/pigmoral/7a61297593386dadbf357837d93adc95 [4]
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Junhui Liu (10):
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

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/anlogic.yaml         | 27 +++++++
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  1 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  6 ++
 arch/riscv/Kconfig.socs                            |  5 ++
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/anlogic/Makefile               |  2 +
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts | 28 +++++++
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi            | 86 ++++++++++++++++++++++
 arch/riscv/configs/defconfig                       |  1 +
 12 files changed, 160 insertions(+)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250710-dr1v90-basic-dt-352e9ae5acb8

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

