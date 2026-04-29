Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB93A9015;
	Wed, 29 Apr 2026 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453540; cv=none; b=IDyFl+HieUN6lFHyD74va7qJuVlKmJc3cou9m6ApEhk5xh/KGDsZPfuYaoshrzHAfeut1ZPT9aUs66rvrGp51iS1gYoqS6SW08CmDuk8bo3kBGKNV0fdvAkh07F1sOu0cE8EeIBSVWpJb0vQQEWLV1+UoTZxMrqYjRmLQj69GLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453540; c=relaxed/simple;
	bh=Yk54Cwui4NyzISBwTNrGewLTMBC258yufC94tSuMGz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjXJLhHI8IMWaOReBy12nTbE4B/NcaBEYuKPqWReFdpJJI02ZW1bve66rwlgjdox+8SswYVr43/cd/YogykSWMccFQLhKsRgqHvyEKdMHNBivwfl28tMsxym+2HGxgAwGAM3mijw3dUZ8ygI8F0lnSV0brgUn3bMo7cdMi1ZGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=jsRxyQlQ; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="jsRxyQlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=MhdY4otkQDeu9JhXT6dgKmzO640veuR
	iZlGBWDtVC3I=; b=jsRxyQlQlTXso1huCEJ0g3R7HhZOc3LKL0jOXeoebyL0SyG
	K2E7MJzRDWVHn43DSr3oQeGejV19idB/1mQEr/9U/mb5NBGG1Y16BmzSNmLP4h3V
	Jf46pjwA8k0IA4WbngnJOo8bVH/Yp6qzUJ+bDaMMdEH6vKk1BASVJI6ImkVg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUL1yfFp_SQDAA--.1731S4;
	Wed, 29 Apr 2026 17:06:00 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 29 Apr 2026 17:05:14 +0800
Subject: [PATCH v6 2/4] serial: 8250_dw: build Renesas RZN1 CPR value from
 DW_UART_CPR_* definitions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ultrarisc-serial-v6-2-b2c852e0c4c3@ultrarisc.com>
References: <20260429-ultrarisc-serial-v6-0-b2c852e0c4c3@ultrarisc.com>
In-Reply-To: <20260429-ultrarisc-serial-v6-0-b2c852e0c4c3@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777453513; l=2418;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=Yk54Cwui4NyzISBwTNrGewLTMBC258yufC94tSuMGz0=;
 b=uaZ5tyDAcAZj91ZBbydsuquaNhHfRuyyMUeRd4tr1euJSXEmmCix+dofGFMVqwh4MYXIeVXLN
 7mAa64R5sVNCeWgvgVc3JILaJ6mpYyyNLw+u/XX1QQBbwOjgrzzs5Kq
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUL1yfFp_SQDAA--.1731S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur43ArWxXrW8tFy3twb_yoW5Jr4xpr
	s0kr4qvr1Y93Z3W34IkrWjvF4Sga15Ga4IkF9rG3sxtFnIyr1ktws0vFy3trZrJFWFvrW5
	GF17Zw15ua4jkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwBBsg

Replace the magic CPR value for Renesas RZ/N1 with a composition using
DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().

Introduce a helper macro to convert a FIFO size (bytes) into the CPR
FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
bounds. Use it to replace the literal FIFO_MODE values in the RZN1.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 10 +++++++++-
 drivers/tty/serial/8250/8250_dwlib.h |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 467755bf0092..480f82d89856 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -937,7 +937,15 @@ static const struct dw8250_platform_data dw8250_armada_38x_data = {
 
 static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.usr_reg = DW_UART_USR,
-	.cpr_value = 0x00012f32,
+	.cpr_value = FIELD_PREP_CONST(DW_UART_CPR_ABP_DATA_WIDTH, 2) |
+		     DW_UART_CPR_AFCE_MODE |
+		     DW_UART_CPR_THRE_MODE |
+		     DW_UART_CPR_ADDITIONAL_FEATURES |
+		     DW_UART_CPR_FIFO_ACCESS |
+		     DW_UART_CPR_FIFO_STAT |
+		     DW_UART_CPR_SHADOW |
+		     DW_UART_CPR_DMA_EXTRA |
+		     DW_UART_CPR_FIFO_MODE_FROM_SIZE(16),
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 2f26f9ecacbe..1fe52332e774 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/build_bug.h>
 #include <linux/io.h>
 #include <linux/types.h>
 
@@ -68,8 +69,13 @@
 #define DW_UART_CPR_DMA_EXTRA		BIT(13)
 #define DW_UART_CPR_FIFO_MODE		GENMASK(23, 16)
 
-/* Helper for FIFO size calculation */
+/* Helpers for FIFO size calculation */
 #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
+#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)			\
+	(FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE,		\
+			  BUILD_BUG_ON_ZERO((size) > 2048) +	\
+			  BUILD_BUG_ON_ZERO((size) % 16) +	\
+			  ((size) / 16)))
 
 struct dw8250_port_data {
 	/* Port properties */

-- 
2.34.1

