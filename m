Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6C18131F;
	Tue, 14 May 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713664; cv=none; b=mJp4qktOYM162uGYeTFCNwA1guaGBqQ1LPBvJiftGPMxB5nSj3wCDlWHfg6oe8qlzWTuazAMkLNxm6CcAXnFDLQ89KQERfWg4p0jQ7665PXjNN2L9IEZmczS/eXkt222RY9ReyHtjvTolQFC1htJQmqPX0F/cfrdbP+y7KIyjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713664; c=relaxed/simple;
	bh=JP2NL+OQgH8JB2VUuZFDhCeUgviMydioNwQSSoDCcxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYQpvwj17xA/QYzvA149PaI02hm61blvXpLT+YAVPTM9WWSQ7iXQkJ7PPhjS2EJP+rNtUzHQyZzIXcG6K9piq14Y1JFPEtUwYA5dSH2x+1o32U2SYOxZLW4A1PPSNOGbCReaiUndf5sldG/+uPNW7xGLj0YHAYgluWxZlUZMeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Smi8YikN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Smi8YikN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715713659; x=1747249659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JP2NL+OQgH8JB2VUuZFDhCeUgviMydioNwQSSoDCcxA=;
  b=Smi8YikNJq0AMgQsiNQsyfnoNzXwCGxZHbf5PdusIazwTA1XoIr/kYJh
   zom5nVoHA+i80Nv622ggreBtq2FVoecKbIs1+LHbNaP6wyKuJPhwwijtz
   MwfflpWRZ8cTweMvuQvA6kdAQ0U+6x2BT3MJTbvh9vtpnjW8t+PA89s69
   2lZ8M1MJeGCFx4FVAazVl+h+tDy3ijDzhzLC/Q1QNrG5YWZdQhjs/DEbD
   RUtx6LTO84Yl+Ir+bw/jNacvGTSkpCO8VpxkEXZWS8I+Md9TUMAhFBr0K
   uAR6N5F44Z2yn1z8nKg04N8fKOWBe7gOml+OMXzpc5bgBnEiLXXatw+nB
   w==;
X-CSE-ConnectionGUID: IPLipkrYTryzBMOO6o6RlQ==
X-CSE-MsgGUID: /80yWVAiSMuQqjroMt68Yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="37096483"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="37096483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 12:07:38 -0700
X-CSE-ConnectionGUID: v/HURVohSb6rsi44mWmO6g==
X-CSE-MsgGUID: Is4Z9s7xQS2dKhgVzSWqbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="68243746"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 May 2024 12:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5876065C; Tue, 14 May 2024 22:07:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 2/2] serial: 8250_dw: Revert "Move definitions to the shared header"
Date: Tue, 14 May 2024 22:05:54 +0300
Message-ID: <20240514190730.2787071-3-andriy.shevchenko@linux.intel.com>
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

This reverts commit d9666dfb314e1ffd6eb9c3c4243fe3e094c047a7.

The container of the struct dw8250_port_data is private to the actual
driver. In particular, 8250_lpss and 8250_dw use different data types
that are assigned to the UART port private_data. Hence, it must not
be used outside the specific driver.

Fix the mistake made in the past by moving the respective definitions
to the specific driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 27 +++++++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h | 32 ----------------------------
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94d680e4b535..a58890fd53e2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -57,6 +57,33 @@
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
 
+struct dw8250_platform_data {
+	u8 usr_reg;
+	u32 cpr_value;
+	unsigned int quirks;
+};
+
+struct dw8250_data {
+	struct dw8250_port_data	data;
+	const struct dw8250_platform_data *pdata;
+
+	int			msr_mask_on;
+	int			msr_mask_off;
+	struct clk		*clk;
+	struct clk		*pclk;
+	struct notifier_block	clk_notifier;
+	struct work_struct	clk_work;
+	struct reset_control	*rst;
+
+	unsigned int		skip_autocfg:1;
+	unsigned int		uart_16550_compatible:1;
+};
+
+static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
+{
+	return container_of(data, struct dw8250_data, data);
+}
+
 static inline struct dw8250_data *clk_to_dw8250_data(struct notifier_block *nb)
 {
 	return container_of(nb, struct dw8250_data, clk_notifier);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 794a9014cdac..7dd2a8e7b780 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -2,15 +2,10 @@
 /* Synopsys DesignWare 8250 library header file. */
 
 #include <linux/io.h>
-#include <linux/notifier.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 
 #include "8250.h"
 
-struct clk;
-struct reset_control;
-
 struct dw8250_port_data {
 	/* Port properties */
 	int			line;
@@ -26,36 +21,9 @@ struct dw8250_port_data {
 	bool			hw_rs485_support;
 };
 
-struct dw8250_platform_data {
-	u8 usr_reg;
-	u32 cpr_value;
-	unsigned int quirks;
-};
-
-struct dw8250_data {
-	struct dw8250_port_data	data;
-	const struct dw8250_platform_data *pdata;
-
-	int			msr_mask_on;
-	int			msr_mask_off;
-	struct clk		*clk;
-	struct clk		*pclk;
-	struct notifier_block	clk_notifier;
-	struct work_struct	clk_work;
-	struct reset_control	*rst;
-
-	unsigned int		skip_autocfg:1;
-	unsigned int		uart_16550_compatible:1;
-};
-
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, const struct ktermios *old);
 void dw8250_setup_port(struct uart_port *p);
 
-static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
-{
-	return container_of(data, struct dw8250_data, data);
-}
-
 static inline u32 dw8250_readl_ext(struct uart_port *p, int offset)
 {
 	if (p->iotype == UPIO_MEM32BE)
-- 
2.43.0.rc1.1336.g36b5255a03ac

