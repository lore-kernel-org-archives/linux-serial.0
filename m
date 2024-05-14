Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127D181333;
	Tue, 14 May 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713667; cv=none; b=HmYRnUVnXAyPzYu1SoJY+CQTszydKBzxyL4gnbdGHfAkmDm+YslswuWOltAIVOvbIZpx7XUUYbATtTcob5a3bfTOq0ZdXlOYcwqAkC7fhpm9PnCC3FkICnJfYPRbo4srgmx+JGtYDhopYnHMAooJFnIVibXJv2r80E3chTIoqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713667; c=relaxed/simple;
	bh=NRErZBf0OenO3XQkRFFP5ig29EPfvJk/CcKRDORAwKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSJwk8hPPUgritESsHl1z6wC0BxFkxgl3+wjmtWcgmuDUrNCNbNstKq4U9br8zurUzgTgk+wLZkb12yVU9GCsPJOKdn/GLd2/mpBrk/UqX1bKq10sB5UFdFyKeetOE/v3PHUQ7VHEUbpPwDAJ1dkgBqPpAEKE/4SuBnfdTTlLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIgZeg8E; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIgZeg8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715713665; x=1747249665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NRErZBf0OenO3XQkRFFP5ig29EPfvJk/CcKRDORAwKw=;
  b=EIgZeg8EaGraYlEXh+oTm+O/ONzlimoohRbmzvqBmWxtsm6DGbxm43j/
   aRVlivvlhADTf2T5C/PT0ER4fr5ZOlMu/s7LTWqVfdqoWKWt1u5EkF/pb
   oH2jpSBalgKH9hHxVjyGEQK5ZqMhihqB2Zdn7kjBG/55JjlZgkIyQ5Jaf
   UlOIZubbj9aOW+m/nbE7UV4aO0Jxf0VaL0aisR5aLjhoSvWIOt0Ov71HK
   uJKc3UrGW6aVKkTt5r98suc6XawY3/wV5m5/WxgHwq5ce2pmeN5AnkKJB
   2amNdDClxFDaxXTuPGLCWUYfxvmD3j7pmP6/lu4xWzI08hERaY9r9JlQ9
   g==;
X-CSE-ConnectionGUID: ZmnDPjUSRqqyAg7JpT7laA==
X-CSE-MsgGUID: /HjnR3cLT3ORWoax63cVww==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="37096476"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="37096476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 12:07:38 -0700
X-CSE-ConnectionGUID: VCcviGleQgqYAFTB4JImUg==
X-CSE-MsgGUID: VpNTSQ4uSGGhRC9wQ9iGvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="68243745"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2024 12:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4B1AC78; Tue, 14 May 2024 22:07:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 1/2] serial: 8250_dw: Don't use struct dw8250_data outside of 8250_dw
Date: Tue, 14 May 2024 22:05:53 +0300
Message-ID: <20240514190730.2787071-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240514190730.2787071-1-andriy.shevchenko@linux.intel.com>
References: <20240514190730.2787071-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The container of the struct dw8250_port_data is private to the actual
driver. In particular, 8250_lpss and 8250_dw use different data types
that are assigned to the UART port private_data. Hence, it must not
be used outside the specific driver.

Currently the only cpr_val is required by the common code, make it
be available via struct dw8250_port_data.

This fixes the UART breakage on Intel Galileo boards.

Fixes: 593dea000bc1 ("serial: 8250: dw: Allow to use a fallback CPR value if not synthesized")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 9 +++++++--
 drivers/tty/serial/8250/8250_dwlib.c | 3 +--
 drivers/tty/serial/8250/8250_dwlib.h | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1300c92b8702..94d680e4b535 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -55,6 +55,7 @@
 #define DW_UART_QUIRK_SKIP_SET_RATE	BIT(2)
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
+#define DW_UART_QUIRK_CPR_VALUE		BIT(5)
 
 static inline struct dw8250_data *clk_to_dw8250_data(struct notifier_block *nb)
 {
@@ -445,6 +446,10 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	unsigned int quirks = data->pdata ? data->pdata->quirks : 0;
+	u32 cpr_value = data->pdata ? data->pdata->cpr_value : 0;
+
+	if (quirks & DW_UART_QUIRK_CPR_VALUE)
+		data->data.cpr_value = cpr_value;
 
 #ifdef CONFIG_64BIT
 	if (quirks & DW_UART_QUIRK_OCTEON) {
@@ -727,8 +732,8 @@ static const struct dw8250_platform_data dw8250_armada_38x_data = {
 
 static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
 	.usr_reg = DW_UART_USR,
-	.cpr_val = 0x00012f32,
-	.quirks = DW_UART_QUIRK_IS_DMA_FC,
+	.cpr_value = 0x00012f32,
+	.quirks = DW_UART_QUIRK_CPR_VALUE | DW_UART_QUIRK_IS_DMA_FC,
 };
 
 static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 3e33ddf7bc80..5a2520943dfd 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -242,7 +242,6 @@ static const struct serial_rs485 dw8250_rs485_supported = {
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct dw8250_port_data *pd = p->private_data;
-	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
 	u32 reg, old_dlf;
 
@@ -278,7 +277,7 @@ void dw8250_setup_port(struct uart_port *p)
 
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg) {
-		reg = data->pdata->cpr_val;
+		reg = pd->cpr_value;
 		dev_dbg(p->dev, "CPR is not available, using 0x%08x instead\n", reg);
 	}
 	if (!reg)
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index f13e91f2cace..794a9014cdac 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -19,6 +19,7 @@ struct dw8250_port_data {
 	struct uart_8250_dma	dma;
 
 	/* Hardware configuration */
+	u32			cpr_value;
 	u8			dlf_size;
 
 	/* RS485 variables */
@@ -27,7 +28,7 @@ struct dw8250_port_data {
 
 struct dw8250_platform_data {
 	u8 usr_reg;
-	u32 cpr_val;
+	u32 cpr_value;
 	unsigned int quirks;
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

