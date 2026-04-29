Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181E3BC69D;
	Wed, 29 Apr 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454019; cv=none; b=n7B//iKD8Ns8FVvEGb1Dk0DkIzEy+SseGGRmPAyXu1L2l0oQT5e3nnwngd8nRkDrxTtNyeBMTvtsb6tcCZGgmyRJza96Y/XWQMWLHQNXENyOqq9X0bbxisjJT6NpHa1nvMG1BMCAg/2jIbHhy+2rii+L4hpL4SYKdI+Pe1S0Aw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454019; c=relaxed/simple;
	bh=WjU2AbG/UNZElfP5fOb5TngitEhS+RvlYopZbCL9xXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqzaXHxOMfRsi+MdkcPFF0jBAcl1lkkQq7b7BrzfcDPg2zaeBL6u3x/dknJPehTjwKV8JWVUDtH/ShgyEnIbcvzhvuVQ/8VX5SxUlKoJZPNPxIu8lRNEnOYzA+38wD+D/dEYwBAls+pRBUHyHFru7Sf46YuocQVqeLX0dmvS8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=bXjp0fIw; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="bXjp0fIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=UdMs010C5F0YX3vHI4Kv9XgCU5Baql8
	ZWhWSA778QWE=; b=bXjp0fIwuhG/1riqlA+6vdwn5I1bAiwFgppVayFml2hFyEM
	cOqtpWuQKFgporundVXnsV43ntVNkkuMsj97g/TEPrkZm1VkR9Ag1c8opPBLV8zg
	jSejhsJa3S9eFiTdidaudvZszwTJttNXvAgVZQ6WbdjddACN60ukJU+PdrO8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cULgy_FpFiUDAA--.1811S4;
	Wed, 29 Apr 2026 17:14:11 +0800 (CST)
From: Jia Wang <wangjia@ultrarisc.com>
Date: Wed, 29 Apr 2026 17:13:26 +0800
Subject: [PATCH v7 2/4] serial: 8250_dw: build Renesas RZN1 CPR value from
 DW_UART_CPR_* definitions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ultrarisc-serial-v7-2-e475cce9e274@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777454005; l=2352;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=WjU2AbG/UNZElfP5fOb5TngitEhS+RvlYopZbCL9xXY=;
 b=pXZUyBhbEF+Kbgi8VaJ2MAn/3ZlhJpiSvRPGWpuC327nYc0DfeuXWKL2DIVbmlRj6zHE/gb5u
 NpsbXThPptqBjz10533RFGhcY4w8k7yYSf3dljImBm+JGaWbeG1+/mV
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwA3cULgy_FpFiUDAA--.1811S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur43AF13KFWxKr4DJwb_yoW8KF47pr
	s0kr4qvr1Y93WfW34IkrWjvFWSqa15Ga4IkF9rG3sxt3ZIyr1ktrs0vFy3trZrJFWFvr45
	GF17Zw15ua4jkr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWnti78ACwBRsw

Replace the magic CPR value for Renesas RZ/N1 with a composition using
DW_UART_CPR_* bit/field definitions and FIELD_PREP_CONST().

Introduce a helper macro to convert a FIFO size (bytes) into the CPR
FIFO_MODE field value, with BUILD_BUG_ON_ZERO() checks for alignment and
bounds. Use it to replace the literal FIFO_MODE values in the RZN1.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
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

