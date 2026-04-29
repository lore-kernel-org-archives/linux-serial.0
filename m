Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858E1DF25C;
	Wed, 29 Apr 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454019; cv=none; b=E1vdIgJkrn2/4CABS93P+P7ylqbdMP1iHiHlo2KYdfzQ25nyXqX4K3Sl4E0gwQmPeZ4xOKecFxiwmTs9cNTpo+D7s3PGbBEswmqBFfeVOrrNZ7COGkIPi9imyv1oHbhGVFJhY0dSDC+yNwRu5D7ORrYuaIyIsmNkoeYaI/kJ6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454019; c=relaxed/simple;
	bh=wAQP+sx727xXQnIObEdZzfFVpnb7D4WO3GVRhswul/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt0I/eCtfQ5BLhEzS5uFrrkGFGPULiaUha2f+/TmKS2//yBFztbhZ1apqvxTG1k1PsMPz9GgMR52aLPH8l7jTXhx0TBvSJKOYdkFIzG2/u+6BWnYQ5TxX2ZhR0JcdVO2chqFvFZMTUwxpWgd+U2Xe+MP5PiqUS3TIgaoj8ycpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Snuae87v; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Snuae87v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=FnpYgmI4IXJfeFt3b31k6g1C+jKERLb
	RnA9mX5P+fmo=; b=Snuae87v3mvEc/ceIhgfIpAUvuA1t9VDSdkefzPiVbQCl8/
	1H9Hjy21NEKQvGoGevbXPnz+h3f25MmvYK2mFNAU2YPbe42zvKkdIVXcNdJR88/W
	uH+ENyohq81wAmA7cWwO0jhHbTKpxBIKU7cp1TL57C+2704fUZojpxLkobR0=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULgy_FpFiUDAA--.1811S3;
	Wed, 29 Apr 2026 17:14:10 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 29 Apr 2026 17:13:25 +0800
Subject: [PATCH v7 1/4] serial: 8250_dwlib: move DesignWare register
 definitions to header
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ultrarisc-serial-v7-1-e475cce9e274@ultrarisc.com>
References: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com>
In-Reply-To: <20260429-ultrarisc-serial-v7-0-e475cce9e274@ultrarisc.com>
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
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777454005; l=7310;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=wAQP+sx727xXQnIObEdZzfFVpnb7D4WO3GVRhswul/M=;
 b=FrgtzoldECs0ckDqVejoxmeQKEvIjCzwY6LMiZz6h7bXLQACzfBdsPKQ0HW8qjFMHY/xiOuvA
 j0hV/dJESkPBPNunjM9M7a2Eyn+JjBAY9YJwre9d+D4BdZnhQYKRhHn
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cULgy_FpFiUDAA--.1811S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF48Gw1UCr1Dur45JF1UKFg_yoW3XF4kpF
	1FkFZ8tF1qya13W34xtFW3tr4xXFWxGw1I9ry3W3yDtF48A34ktFyYvFW3tr4DWryrArWU
	XF1UAw4Y9a4I9r7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwBPsu

Move the DW_UART_* register offsets and CPR bit/field definitions from
8250_dwlib.c into 8250_dwlib.h so they can be shared by 8250_dw and
8250_dwlib users.

Add an include guard for 8250_dwlib.h.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 11 ------
 drivers/tty/serial/8250/8250_dwlib.c | 49 --------------------------
 drivers/tty/serial/8250/8250_dwlib.h | 67 ++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 60 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb4024d..467755bf0092 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -34,22 +34,11 @@
 
 #include "8250_dwlib.h"
 
-/* Offsets for the DesignWare specific registers */
-#define DW_UART_USR	0x1f /* UART Status Register */
-#define DW_UART_DMASA	0xa8 /* DMA Software Ack */
-
 #define OCTEON_UART_USR	0x27 /* UART Status Register */
 
 #define RZN1_UART_TDMACR 0x10c /* DMA Control Register Transmit Mode */
 #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
 
-/* DesignWare specific register fields */
-#define DW_UART_IIR_IID			GENMASK(3, 0)
-
-#define DW_UART_MCR_SIRE		BIT(6)
-
-#define DW_UART_USR_BUSY		BIT(0)
-
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index b055d89cfb39..8859e66d2d71 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -13,55 +13,6 @@
 
 #include "8250_dwlib.h"
 
-/* Offsets for the DesignWare specific registers */
-#define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
-#define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
-#define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
-#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
-#define DW_UART_RAR	0xc4 /* Receive Address Register */
-#define DW_UART_TAR	0xc8 /* Transmit Address Register */
-#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
-#define DW_UART_CPR	0xf4 /* Component Parameter Register */
-#define DW_UART_UCV	0xf8 /* UART Component Version */
-
-/* Receive / Transmit Address Register bits */
-#define DW_UART_ADDR_MASK		GENMASK(7, 0)
-
-/* Line Status Register bits */
-#define DW_UART_LSR_ADDR_RCVD		BIT(8)
-
-/* Transceiver Control Register bits */
-#define DW_UART_TCR_RS485_EN		BIT(0)
-#define DW_UART_TCR_RE_POL		BIT(1)
-#define DW_UART_TCR_DE_POL		BIT(2)
-#define DW_UART_TCR_XFER_MODE		GENMASK(4, 3)
-#define DW_UART_TCR_XFER_MODE_DE_DURING_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 0)
-#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
-#define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
-
-/* Line Extended Control Register bits */
-#define DW_UART_LCR_EXT_DLS_E		BIT(0)
-#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
-#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
-#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
-
-/* Component Parameter Register bits */
-#define DW_UART_CPR_ABP_DATA_WIDTH	GENMASK(1, 0)
-#define DW_UART_CPR_AFCE_MODE		BIT(4)
-#define DW_UART_CPR_THRE_MODE		BIT(5)
-#define DW_UART_CPR_SIR_MODE		BIT(6)
-#define DW_UART_CPR_SIR_LP_MODE		BIT(7)
-#define DW_UART_CPR_ADDITIONAL_FEATURES	BIT(8)
-#define DW_UART_CPR_FIFO_ACCESS		BIT(9)
-#define DW_UART_CPR_FIFO_STAT		BIT(10)
-#define DW_UART_CPR_SHADOW		BIT(11)
-#define DW_UART_CPR_ENCODED_PARMS	BIT(12)
-#define DW_UART_CPR_DMA_EXTRA		BIT(13)
-#define DW_UART_CPR_FIFO_MODE		GENMASK(23, 16)
-
-/* Helper for FIFO size calculation */
-#define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
-
 /*
  * divisor = div(I) + div(F)
  * "I" means integer, "F" means fractional
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 7dd2a8e7b780..2f26f9ecacbe 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -1,11 +1,76 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /* Synopsys DesignWare 8250 library header file. */
 
+#ifndef _SERIAL_8250_DWLIB_H_
+#define _SERIAL_8250_DWLIB_H_
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/io.h>
 #include <linux/types.h>
 
 #include "8250.h"
 
+/* Offsets for the DesignWare specific registers */
+#define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DMASA	0xa8 /* DMA Software Ack */
+#define DW_UART_TCR	0xac /* Transceiver Control Register (RS485) */
+#define DW_UART_DE_EN	0xb0 /* Driver Output Enable Register */
+#define DW_UART_RE_EN	0xb4 /* Receiver Output Enable Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
+#define DW_UART_RAR	0xc4 /* Receive Address Register */
+#define DW_UART_TAR	0xc8 /* Transmit Address Register */
+#define DW_UART_LCR_EXT	0xcc /* Line Extended Control Register */
+#define DW_UART_CPR	0xf4 /* Component Parameter Register */
+#define DW_UART_UCV	0xf8 /* UART Component Version */
+
+/* Interrupt ID Register bits */
+#define DW_UART_IIR_IID			GENMASK(3, 0)
+
+/* Modem Control Register bits */
+#define DW_UART_MCR_SIRE		BIT(6)
+
+/* Line Status Register bits */
+#define DW_UART_LSR_ADDR_RCVD		BIT(8)
+
+/* UART Status Register bits */
+#define DW_UART_USR_BUSY		BIT(0)
+
+/* Transceiver Control Register bits */
+#define DW_UART_TCR_RS485_EN		BIT(0)
+#define DW_UART_TCR_RE_POL		BIT(1)
+#define DW_UART_TCR_DE_POL		BIT(2)
+#define DW_UART_TCR_XFER_MODE		GENMASK(4, 3)
+#define DW_UART_TCR_XFER_MODE_DE_DURING_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 0)
+#define DW_UART_TCR_XFER_MODE_SW_DE_OR_RE	FIELD_PREP(DW_UART_TCR_XFER_MODE, 1)
+#define DW_UART_TCR_XFER_MODE_DE_OR_RE		FIELD_PREP(DW_UART_TCR_XFER_MODE, 2)
+
+/* Receive / Transmit Address Register bits */
+#define DW_UART_ADDR_MASK		GENMASK(7, 0)
+
+/* Line Extended Control Register bits */
+#define DW_UART_LCR_EXT_DLS_E		BIT(0)
+#define DW_UART_LCR_EXT_ADDR_MATCH	BIT(1)
+#define DW_UART_LCR_EXT_SEND_ADDR	BIT(2)
+#define DW_UART_LCR_EXT_TRANSMIT_MODE	BIT(3)
+
+/* Component Parameter Register bits */
+#define DW_UART_CPR_ABP_DATA_WIDTH	GENMASK(1, 0)
+#define DW_UART_CPR_AFCE_MODE		BIT(4)
+#define DW_UART_CPR_THRE_MODE		BIT(5)
+#define DW_UART_CPR_SIR_MODE		BIT(6)
+#define DW_UART_CPR_SIR_LP_MODE		BIT(7)
+#define DW_UART_CPR_ADDITIONAL_FEATURES	BIT(8)
+#define DW_UART_CPR_FIFO_ACCESS		BIT(9)
+#define DW_UART_CPR_FIFO_STAT		BIT(10)
+#define DW_UART_CPR_SHADOW		BIT(11)
+#define DW_UART_CPR_ENCODED_PARMS	BIT(12)
+#define DW_UART_CPR_DMA_EXTRA		BIT(13)
+#define DW_UART_CPR_FIFO_MODE		GENMASK(23, 16)
+
+/* Helper for FIFO size calculation */
+#define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
+
 struct dw8250_port_data {
 	/* Port properties */
 	int			line;
@@ -38,3 +103,5 @@ static inline void dw8250_writel_ext(struct uart_port *p, int offset, u32 reg)
 	else
 		writel(reg, p->membase + offset);
 }
+
+#endif /* _SERIAL_8250_DWLIB_H_ */

-- 
2.34.1

