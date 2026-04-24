Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD07D3446C4;
	Fri, 24 Apr 2026 05:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009229; cv=none; b=KtDSYUGBLIauEfGDnYh90a3y+mX5QaTCn2NvP7guR2+eG5+ZZmaAAF1zkrax5tv0ns9bYmjpGViRfNv/meBWdxLm7hw2r/yCqwJiTH00pAvhijPvtjvhNtzwkusfjjjFTWnn9+AgeUeBRuFSP3ZuT5Pv3+QJ6OvBgDFuiWB5Qws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009229; c=relaxed/simple;
	bh=k55XBV/nmFEVR3wNAXd6Yzldm76QwPMOMHGutyTPK34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tbY+gFq2ph7VLXtwodYB88+MvcYnKV7xOpELCOJVefpdF8uOwR27qzBwj5SnppFxDanEdO4ViJdd7JW6ZKxSpdtOcz9mNh4QEKWQf5eA36BkTn4jsWaa3AiFCDQDvJwdPaiknnQLWXqfWhxoRB3omLYRA8pU9rikj2occoGwV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=GTYJ8U/F; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="GTYJ8U/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=En
	tjKiXGiVc7g9ljDSOTLPPgkKKwLhEPaqid4wCky4Q=; b=GTYJ8U/FXpj2dAoA/9
	9Q6vlXq/sTbGO86OIEn+q/fm/JP8f4hvz00a2P1eKSXGJ73MHQCuKOPZb7+94xNR
	K6GSkEOyV6DTmstskOc0BXnku47zcL3ko+KocOoYabmVfAjh+3tmUC+p4GVwD6+1
	eAhcPC61wrJqrE2vz1RE3Er+4=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUJlAutpm8gCAA--.1607S2;
	Fri, 24 Apr 2026 13:40:53 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH v4 0/4] serial: 8250_dw: Add support for UltraRISC DP1000
 UART
Date: Fri, 24 Apr 2026 13:39:27 +0800
Message-Id: <20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8C62kC/4XN0QrCIBgF4FcJrzPU31zrqveILpz7bUZtodsox
 t49XVFQgy4PnPOdgQT0DgPZLgbisXfBNXUMcrkgptL1EakrYyaCCcWA5bQ7t157FwxNS32mSlq
 rIMPSCkXi7OrRuttE7g/PHLrihKZNTmpULrSNv0+fPU+9F8/VL99zyqiR8QUwB9Dr3buyMs2Fp
 Ite/ENERJQuADOrNzk3cwh8ECn4DAIRgTKzLDdCCobfyDiOD4RaV+xQAQAA
X-Change-ID: 20260309-ultrarisc-serial-64ff637edf26
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777009209; l=2625;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=k55XBV/nmFEVR3wNAXd6Yzldm76QwPMOMHGutyTPK34=;
 b=m23lxKeGrSvvMwMxC73BQt4E78pRW+AQ7iu8g4y1JQfYxO9PI4ZTzunANxT1JBHzTSzpkMpQH
 ntlP33boulFAWNe9XpxLyoirrnpZjx4EtX0GJFkroVlq+LW290Lz55j
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUJlAutpm8gCAA--.1607S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfCr4Uuw45CF45tr13Arb_yoW5Gry7pF
	43KrZIyr98tFySkan7tw1IvF1fWF48JryUXFnrKw1Yq3W5ZF18trWrKw45AF98Zr95Wr1j
	9F45u34rGa4UuwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWnq6L8ACAAAsL

This patch series adds support for the UltraRISC DP1000 UART controller.

The series includes four patches. The first two are preparatory cleanups;
the last two add the DP1000 compatible and fixed CPR handling.

The patches have been tested on an UltraRISC DP1000 development board with
Linux v7.0-rc7, verifying basic UART functionality.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v4:
- Added two preparatory patches before the original series, shifting patch
  numbers (former 1/2 -> now 3/4).
- Patch 1:
  * Move all DesignWare UART register/field definitions into 8250_dwlib.h
    for shared use with 8250_dw.
- Patch 2:
  * Converted the Renesas RZ/N1 CPR magic value to use DW_UART_CPR_* macros
    and FIELD_PREP_CONST().
- Patch 4:
  * Converted the UltraRISC DP1000 CPR magic value to use
    DW_UART_CPR_* macros and FIELD_PREP_CONST() (value unchanged).
- Link to v3: https://patch.msgid.link/20260421-ultrarisc-serial-v3-0-3d7f09c2420e@ultrarisc.com

Changes in v3:
- Rebased on Linux v7.0-rc7.
- Patch 1:
   * Removed separate `items` entry for DP1000, merging it into the
     existing `enum` to comply with the schema.
   * Updated commit message to describe DP1000 UART hardware differences.
- Patch 2:
   * Drop the custom quirk for missing CPR register.
   * Switch to using DW_UART_QUIRK_CPR_VALUE to provide a fixed CPR value.
- Link to v2: https://patch.msgid.link/20260316-ultrarisc-serial-v2-0-6ab3e7fa891c@ultrarisc.com

Changes in v2:
- Rebased on Linux v7.0-rc4 (previously on v7.0-rc2).
- Reordered patch series: DT binding patch comes before driver changes.
- Updated commit message for DT binding patch.
- Link to v1: https://patch.msgid.link/20260316-ultrarisc-serial-v1-0-c464f3e933a5@ultrarisc.com

---
Jia Wang (4):
      serial: 8250_dwlib: move DesignWare register definitions to header
      serial: 8250_dw: build Renesas RZN1 CPR value from DW_UART_CPR_* definitions
      dt-bindings: serial: snps-dw-apb-uart: Add UltraRISC DP1000 UART
      serial: 8250_dw: Use a fixed CPR value for UltraRISC DP1000 UART

 .../bindings/serial/snps-dw-apb-uart.yaml          |  1 +
 drivers/tty/serial/8250/8250_dw.c                  | 31 ++++++-----
 drivers/tty/serial/8250/8250_dwlib.c               | 49 -----------------
 drivers/tty/serial/8250/8250_dwlib.h               | 63 ++++++++++++++++++++++
 4 files changed, 83 insertions(+), 61 deletions(-)
---
base-commit: e774d5f1bc27a85f858bce7688509e866f8e8a4e
change-id: 20260309-ultrarisc-serial-64ff637edf26

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>

