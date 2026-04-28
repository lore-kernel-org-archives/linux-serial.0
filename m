Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4134252B;
	Tue, 28 Apr 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354018; cv=none; b=KV+ZO0ZeMix01Qz9FBlRkdvitAmSd799kdp9SOCM5fGsbMisTKcaeBUUhUgp5YvhYfis7C5fA+2TPSVEaMEAk8wYuOBcKpZWECIX+U99YxRFDZOC6K3swhhUcOcnJm6YI2brq7X7SPfX7FwD/fHHI3vsIqomp4AMq5u1xdPBjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354018; c=relaxed/simple;
	bh=jO0zlNA1eKxRESAZ5hHV3AD2XwV5WDA/D8hVXLHOwgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hBTGj7VZUFSb1/CsCEaD97tgeeM6vtZdQy3c4lifnd+hq1vozA7sKH4RYjkYdgtm1PEL6yCEkBLp7WVMys9MkC6inyEvLOHil2RtpmGRcIiyorPW1g7RnHDsHGXyG7Sh2TtXzS3gcd7fw/NLy2AtQ+0jdAfh9w0iL4iOoefPDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=BYhLsZJK; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="BYhLsZJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tk
	+Su0SD8Q9/52Qv4/eBjgpzRRMB+Aab/0Tn5htEYYs=; b=BYhLsZJK/a+Gi/xhNK
	WI8B2pRhuqlFjB7EBTIo+FswAGSDuR/mewYPoXDlNRHlsdaeTwlCHgml46pno5nE
	uiJEgTBJf3VJqDmdAMES2ghPheUj6um2U4xi/WygJtuCANte4FNM4aAL9KuE9/km
	nSxCkkG47VJ+6LyL4Ic0GQ75c=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUIxRfBpJRMDAA--.1785S2;
	Tue, 28 Apr 2026 13:27:13 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH v5 0/4] serial: 8250_dw: Add support for UltraRISC DP1000
 UART
Date: Tue, 28 Apr 2026 13:26:25 +0800
Message-Id: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFF8GkC/4XNwU6EMBQF0F8hXVvT9j2KzMr/MC5KeR1qECYtE
 A3h323ROJORxOVN7j13ZZGCp8hOxcoCLT76cUihfCiY7cxwJu7blJkSSgsQNZ/7KZjgo+V5aXq
 u0TkNFbVOaZZml0DOf+zky+t3jnPzRnbKTm50Pk5j+Nw/F5l7P7zUf/lFcsEtphegGsCUz7+VR
 zu+s3yxqP8QlRBtGqDKmada2iMErggqeYBAQqCtnKitQiXoCMFbBA8QTIisdGlEgxaNuEe2bfs
 CG3W1MpUBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777353989; l=2987;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=jO0zlNA1eKxRESAZ5hHV3AD2XwV5WDA/D8hVXLHOwgY=;
 b=mZB5PyptJVQTQp7P790pUMUE+WLiBvm2WEW+kA5FWYSWDhGjVMiknAZFQQ//eZh+aglDFUiB0
 fBJh4X5WS5aDx9wuh4u8gA+rAmXyk4Url1jwqMOecct1fAgsq05C38U
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cUIxRfBpJRMDAA--.1785S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDGr17CryDtrW8tr1xAFb_yoW5Ar4fpF
	4YgFsIy3s8tFyfKan7tw1rZF1SgF4rJrWYqFsrKw1Yv3W5ZF1IqrWrKw45ZF9xZ3s5Xr1j
	9F13uw1rGa42vwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAes-

This patch series adds support for the UltraRISC DP1000 UART controller.

The series includes four patches. The first two are preparatory cleanups;
the last two add the DP1000 compatible and fixed CPR handling.

The patches have been tested on an UltraRISC DP1000 development board with
Linux v7.1-rc1, verifying basic UART functionality.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v5:
- Rebased onto Linux v7.1-rc1.
- Patch 1:
  * Reorder and document the moved DesignWare register/bit definitions.
- Patch 2:
  * Add a FIFO size -> CPR FIFO_MODE helper and use it for RZ/N1.
- Patch 4:
  * Use the FIFO_MODE helper for DP1000.
- Link to v4: https://patch.msgid.link/20260424-ultrarisc-serial-v4-0-1765a0b4c4a0@ultrarisc.com

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
 drivers/tty/serial/8250/8250_dw.c                  | 33 ++++++----
 drivers/tty/serial/8250/8250_dwlib.c               | 49 --------------
 drivers/tty/serial/8250/8250_dwlib.h               | 74 ++++++++++++++++++++++
 4 files changed, 96 insertions(+), 61 deletions(-)
---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260309-ultrarisc-serial-64ff637edf26

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>

