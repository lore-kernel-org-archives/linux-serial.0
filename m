Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58892DA746;
	Tue, 21 Oct 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039915; cv=pass; b=HU26laC6Dlsj3CVH/5cGEU55bb6KpQpQRGeM803muCu01GWqPEY6Hhvh5qSHXaKeIiG25EdBDnTaZMpvqoDeByytE/3m4ZM1HDtdWC/a+twT53IBiWCkzdmnX/82lz1e1vjLn5rBQfGVWIthPNksoSXc/QElHG3C26nEx1TZvgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039915; c=relaxed/simple;
	bh=HhYm2wgmjnUxkDSARQK8RR3OyXC2WBjXA6RAFCc0u4E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jkP3c4PEKQQVp8Vx5xni9uaQM6IvRUU4WT7pkZXkfMwhLkIjviG7F0CsVajfkYLFUgcTAwcZWZdQZAJxqo7th8jS9gzRiItrkDeNauJgFZu5Z3/KTb1WFbKTg9S4y54w65c7t2EudQ13gZupgPQx2nae/kRDT9ZRs7Met06lUIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=HEh5qm4o; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="HEh5qm4o"
ARC-Seal: i=1; a=rsa-sha256; t=1761039860; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NnzBGQLYNBCXKQJzYf3bBsAtiXzhu7UoLkvTu7ddrt1jrxpTt6/OsT3D14KW/4tJ/XRT4f4baqOBwAAFs++G+GcA+5udPQ/iX/e6ON4S98gCWOmJQviL8oWpKMcfsAAWGQLoXDpEc6YtVFKqNZaLEAMM8gB9j+i/AaaEzMtdU2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039860; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=15xJqilDviN6GeZoWciapgWlMTam4VZt04d8Xq7VHbc=; 
	b=aXQDbhjFWPFyzf3KCq+Hss3ySTNm91V1m1Y9jn/MCd/93MgC1cXuoSc4VrWvndnzXu8wWJnTZbGaEAQH94zJIR8I3DJBEfjf/2jwvL7oKOIfTbkOftNbvlYhorzFfayLWeUH9YHSxkz6S+6roGe5wbWVpQkeWm/cAnaJtK0c348=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039860;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=15xJqilDviN6GeZoWciapgWlMTam4VZt04d8Xq7VHbc=;
	b=HEh5qm4oRyBn8D/ZMACqQ41On4stzIqQj1U1jyEP97OK7NvxnC+YF4+1m6ExNibN
	exImK/5tuEaPxu6z8Nejg61U+IUK6bL1OsdsRaJ4nh4SCWBBWvkB8ta7Z+xRsSkK4hQ
	o7Clah0iQ+MD4QHeKKVxe3WWCpzxVk9BI2YfVxuc=
Received: by mx.zohomail.com with SMTPS id 1761039855417529.1083617434861;
	Tue, 21 Oct 2025 02:44:15 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3 00/13] riscv: Add initial support for Anlogic DR1V90
Date: Tue, 21 Oct 2025 17:41:35 +0800
Message-Id: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE9V92gC/2XNQQ6CMBCF4auQrq2ZDlSoK+9hXJR2hElUSEsaD
 eHuFmLiguX/kvlmFpECUxTnYhaBEkceXjnKQyFcb18dSfa5BQJqqBVIH1QyIFsb2Uk/yVIjGUv
 aurYR+WoMdOf3Jl5vuXuO0xA+24Ok1vVnodpZSUmQuq7AaWWMq+rLyN1zCPZxnMj1YvUS/g2Du
 DcwG6fKY6MBXFvujGVZvhaM0Iz2AAAA
X-Change-ID: 20250710-dr1v90-basic-dt-352e9ae5acb8
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@outlook.com>, 
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=3529;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=HhYm2wgmjnUxkDSARQK8RR3OyXC2WBjXA6RAFCc0u4E=;
 b=WuAubXbtDtHedNzHkVtHXi+tn5DscdWLgHql03MT3do1bmP0JG6WX8sNrVZLsfnLXG8bWZH/8
 YrmOvuywyfvDiHNYy9JWYrrJUA9KBEwp9gQi6atXP2kPggDv3joqGOY
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

This introduces initial support for the Anlogic DR1V90 SoC [1] and the
Milianke MLKPAI-FS01 [2] board.

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

Link: https://www.anlogic.com/product/fpga/saldragon/dr1 [1]
Link: https://www.milianke.com/product-item-104.html [2]
Link: https://nucleisys.com/product/900.php [3]
Link: https://github.com/pigmoral/opensbi/tree/dr1v90 [4]
---
Changes in v3:
- Update DT binding to use ACLINT instead of CLINT
- Drop MAINTAINERS patch
- Rebase on v6.18-rc1
- Link to v2: https://lore.kernel.org/r/20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech

Changes in v2:
- Add MAINTAINERS entry for the DR1V90 platform
- Remove the riscv,isa property of cpu and reorder propertyies
- Fix clint base address in the dtsi
- Change the memory node to cover the full 512MB RAM in board dts
- Link to v1: https://lore.kernel.org/r/20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech

---
Junhui Liu (13):
      dt-bindings: vendor-prefixes: Add Anlogic, Milianke and Nuclei
      dt-bindings: riscv: Add Nuclei UX900 compatibles
      dt-bindings: riscv: Add Anlogic DR1V90
      dt-bindings: interrupt-controller: Add Anlogic DR1V90 PLIC
      dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT MSWI
      dt-bindings: interrupt-controller: Add Anlogic DR1V90 ACLINT SSWI
      dt-bindings: timer: Add Anlogic DR1V90 ACLINT MTIMER
      dt-bindings: serial: snps-dw-apb-uart: Add Anlogic DR1V90 uart
      irqchip/aclint-sswi: Add Nuclei UX900 support
      riscv: Add Anlogic SoC famly Kconfig support
      riscv: dts: Add initial Anlogic DR1V90 SoC device tree
      riscv: dts: anlogic: Add Milianke MLKPAI FS01 board
      riscv: defconfig: Enable Anlogic SoC

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 +
 .../thead,c900-aclint-mswi.yaml                    |  17 ++--
 .../thead,c900-aclint-sswi.yaml                    |   4 +
 .../devicetree/bindings/riscv/anlogic.yaml         |  27 ++++++
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   1 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 .../bindings/timer/thead,c900-aclint-mtimer.yaml   |  17 ++--
 .../devicetree/bindings/vendor-prefixes.yaml       |   6 ++
 arch/riscv/Kconfig.socs                            |   5 ++
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/anlogic/Makefile               |   2 +
 arch/riscv/boot/dts/anlogic/dr1v90-mlkpai-fs01.dts |  28 ++++++
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi            | 100 +++++++++++++++++++++
 arch/riscv/configs/defconfig                       |   1 +
 drivers/irqchip/irq-aclint-sswi.c                  |   3 +-
 15 files changed, 201 insertions(+), 13 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250710-dr1v90-basic-dt-352e9ae5acb8

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>

