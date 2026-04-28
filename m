Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0306342539;
	Tue, 28 Apr 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354019; cv=none; b=nfodRWauXYgR6eVZ+TqQ1mOGkkRyKzxrRmoPJtZ+0vneElLD8dd77tNVwY5M36fqiZTt/T/dHUJFtWfv/9wt0CVf8FoKqv2lVhvDycnc1E5nqpJfWaIOF4ltg1CB4hMA+18pJWw5Epm0YUMFHyNs7iVxGiBL37KcoWrvCBmrpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354019; c=relaxed/simple;
	bh=A5CCafM9ZkDWbA5vbjYEFX3HyNOl1jj7t9s3liEYB0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GldFEt2IRSPWC3usy8uBrW4m47Ru1NyqHykm0j6teRwHLFq/vrca+NDgyC6STSKSFEQDpJ/WBJrTzM5GnObW2fqALHlN5RWM6uXyihdPianXtNcWOvbWZYKydKKIMRxEPB1ZXufKZLvw5A75aj2Ooxr750GPgPlI+UEq3g5rlXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=q+rbEW1H; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="q+rbEW1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=eu6xcYQBkr+nwx6koqqcliFwhSiICCy
	FSC33b3cp3aA=; b=q+rbEW1HkPWpUNdrz4jW2Ok+HJG55Lo9rCXoT2X/FXJ9Jc4
	yiSQ6+E9hFP2YjriXdMVuOLKkEGVbAS1LtSsN0OHhwXtRa3pqN062IwvZ2m0qfer
	EWyWNbMr1wPTcMyLf8Xg66/SE8HzWw/7ovYW8max3z1Uh/s4Rn1qVogPIN0w=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUIxRfBpJRMDAA--.1785S4;
	Tue, 28 Apr 2026 13:27:24 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Tue, 28 Apr 2026 13:26:27 +0800
Subject: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value from
 DW_UART_CPR_* definitions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
In-Reply-To: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777353989; l=2326;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=A5CCafM9ZkDWbA5vbjYEFX3HyNOl1jj7t9s3liEYB0k=;
 b=N+HNp/hepAFG1ZmnqJ49LLp4klYmysYR4HEuq/My2/fwIWaPOs61Ksl68CRtTDGxeYaRzQO0X
 6BLgGDHoPvYAu8bEP0qp6L+fAGzCmrjaNWAHngE0mCQRmOg8wV0UqFE
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cUIxRfBpJRMDAA--.1785S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur43AF13KrW3AFyUtrb_yoW8KF1Upr
	s0kr4qvryY93Z3W34IkrWjvF4Sqa15Wa4I9F9rW3sxtF13Ar1ktrs0vF9xtrnrJFWFvrW5
	GF17Ary5uay0kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwAisD

Replace the magic CPR value for Renesas RZ/N1 with a composition using
DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().

Introduce a helper macro to convert a FIFO size (bytes) into the CPR
FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
bounds. Use it to replace the literal FIFO_MODE values in the RZN1.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 11 ++++++++++-
 drivers/tty/serial/8250/8250_dwlib.h |  7 +++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 467755bf0092..5cf3bb74b285 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -937,7 +937,16 @@ static const struct dw8250_platform_data dw8250_armada_38x_data = {
 
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
+		     FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE,
+				      DW_UART_CPR_FIFO_MODE_FROM_SIZE(16)),
 	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 2f26f9ecacbe..c1f87cd42ecc 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -6,6 +6,8 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/align.h>
 #include <linux/io.h>
 #include <linux/types.h>
 
@@ -70,6 +72,11 @@
 
 /* Helper for FIFO size calculation */
 #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
+#define DW_UART_CPR_FIFO_MODE_MAX	0x80
+#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
+	(BUILD_BUG_ON_ZERO(!IS_ALIGNED((size), 16)) +			\
+	 BUILD_BUG_ON_ZERO(((size) / 16) > DW_UART_CPR_FIFO_MODE_MAX) +	\
+	 ((size) / 16))
 
 struct dw8250_port_data {
 	/* Port properties */

-- 
2.34.1

