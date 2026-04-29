Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69D3BC69D;
	Wed, 29 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454026; cv=none; b=MLdyyLUuJXv5K+Wye9/SZxvg9WJScqJhOxntimqN77N7ysgpVyjzBtlVSCxbJWpxaa44XVHUvvmaqJqR7Vm7y27AdwPejNNV6mGy6jCjwUaHZqOPolTmfrmo/EcqOpy0l6hxWGlrkyuN0QPUWnzZGyFQMHZpC1G5CIFBA1J1cQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454026; c=relaxed/simple;
	bh=LzLjT3qvm+KtKQjCVc9lSvU3XgXjY5p2/MkW8lPuF6U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d+UsyLXQcdvwzLwMyxYJQi36nELXgV28pomCXyx7uAImfDPGCmLvNcK1aVKO4kTyLREe+iGtbEwAXbrw1WajZYVQQuZNkpO0i5iepxcPkY2ZOTEu/c5DTkV2nWbbGXW4G6TNiqxJde7F/+ge9br4D1jUwnJiyEJ4a+nfmNNMPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=NCD7b9Dn; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="NCD7b9Dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=u+
	rn9bMDmRyBvWaXm4whF8AkhEv3IBQJ1K4YRL41CmQ=; b=NCD7b9DnMlTqUt2rWl
	Dq0Rs9l/MxT6GJ4VjLDt+TJykK0dFEjHPQ3Dhbwun0On8eOLQVH2o9b8YJl+1cGB
	fqD0InQX1Vt0W/fw7GJKjSnfyNN4vkJS+YUhUmJnEZVU/r8mlzKrPeZh1oFVBqoM
	+a/zfk350A3mwZocWIDK+9VQQ=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULgy_FpFiUDAA--.1811S2;
	Wed, 29 Apr 2026 17:14:09 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Subject: [PATCH v7 0/4] serial: 8250_dw: Add support for UltraRISC DP1000
 UART
Date: Wed, 29 Apr 2026 17:13:24 +0800
Message-Id: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALTL8WkC/4XRwU7EIBAG4FfZcBYDDIXWk+9h9gDTwcWsWwNds
 mbTd5euRhsl8fgn/3z/Ya4sU4qU2cPuyhKVmON0qsHe7Rge3OmZeBxrZkooI0AM/Hyck0sxI18
 v3ZEbHYIBS2NQhtWzt0QhXm7k0/4z57N/IZxXZ20cYp6n9H7bLHLtffHS/OWL5IKjritAA4DrH
 r8r9zi9snWiqP8QVRHjPJANrh8kthD4QbSSDQQqAqMNYkCllaAWoreIbiC6ItKazgmvUTvRQro
 t0jeQriKDHcmAlwTkW4jZIo2/FVMRr7DvFAnUCL+RZVk+ANQmw08fAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777454005; l=3623;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=LzLjT3qvm+KtKQjCVc9lSvU3XgXjY5p2/MkW8lPuF6U=;
 b=St1Go1FKFTgZokHukCib7dJB344eSTx54ULih8dvaRyC/GUED1agwTBCPRJUNlTH7qUc0kGUf
 zDkJvstNBZBBWJLSPftFQJUeXYCLYIjfnb7dOmbTFigzHIgG42bUQSl
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cULgy_FpFiUDAA--.1811S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDGw15ZF1DZw45JFy5urg_yoW5KrW3pF
	4Ygrs0ya9rtryrKan7tw1fJF1SgF4rJrWYqFnrKw1Yv3W5Zr1IqrWrKw4Y9F9xZ3s5Xr1j
	kF13u34rCa4jvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwBNss

This patch series adds support for the UltraRISC DP1000 UART controller.

The series includes four patches. The first two are preparatory cleanups;
the last two add the DP1000 compatible and fixed CPR handling.

The patches have been tested on an UltraRISC DP1000 development board with
Linux v7.1-rc1, verifying basic UART functionality.

v7 removes a Reviewed-by tag on patch 2 that was included by mistake;
Andy explicitly asked for a fresh review on that patch. Apologies for
the oversight.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
Changes in v7:
- Patch 2:
  * Dropped Andy's Reviewed-by from patch X per his request (the tag
    was mistakenly kept in v6; no other changes).
- Link to v6: https://patch.msgid.link/20260429-ultrarisc-serial-v6-0-b2c852e0c4c3@ultrarisc.com

Changes in v6:
- Patch 2:
  * Simplify the FIFO size -> CPR FIFO_MODE helper.
- Patch 4:
  * Use the updated FIFO helper.
- Link to v5: https://patch.msgid.link/20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com

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
 drivers/tty/serial/8250/8250_dw.c                  | 31 +++++----
 drivers/tty/serial/8250/8250_dwlib.c               | 49 ---------------
 drivers/tty/serial/8250/8250_dwlib.h               | 73 ++++++++++++++++++++++
 4 files changed, 93 insertions(+), 61 deletions(-)
---
base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
change-id: 20260309-ultrarisc-serial-64ff637edf26

Best regards,
--  
Jia Wang <wangjia@ultrarisc.com>

