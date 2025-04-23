Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9423E35D;
	Wed, 23 Apr 2025 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745379806; cv=none; b=SS0u6mr7YAQSIQ2nlx8H23133qW72QuauMN04RWuwuhh8RrafM9oQAYzAc4QVEULll6W54xAT3TaU3qGDDW1YkknwYha9ruxSHI6FWMn2JwbhaZL7IvqUk4voVDA5XRHHQnKuM2gSthIXAyrAglhOL2FP1kWh/TgtugpMq2poWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745379806; c=relaxed/simple;
	bh=UppegL8eqOatI5rkNWA4+BqGjnxLl/vwLnSllPrK+H0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X478bkJlk5un18uSH8fKPhMXXqGWcCgtZyjlVJ1AM0+q8HhCRqJZK6KYnMouX6uZ9Lm3oeYEAQN9NeJrhwf8evnDIwKGNMmIKKKxijdL4sqf+GFznlPDS1JP7ZiSBxQjYIJUDWLJTQ1M9XDTwmVSdPYUMLijn2nAo07R+T62GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XCFpCiT0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XCFpCiT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745379805; x=1776915805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UppegL8eqOatI5rkNWA4+BqGjnxLl/vwLnSllPrK+H0=;
  b=XCFpCiT0648WW50GS99+PmhRunZYvPdkQewe2oOzXEKMmPn0EPqyRxmO
   Z8HRc7sE4iNQ68GPew4vUzqRVpWnIRzZNv7GAwJPbj4ymJhdhtPXe7iLb
   mmnnS/WZFWyHXkqDncgbMzDeoHnu/zCRD6HUa5Bqv4w/XfeoSW8VbLOrt
   GyrDiwaeqZiqi8iP6DsAcdz8CG4ljNHMvRQsWhtyYzN7UWHqZdz+5ePvN
   e7JP8n5KXQDlE+SLqxI5YKfPQPTCswdZ7YdbNV2p4iWH3sM7XQAuyIAYS
   kXbzB0dWELvtJphAccGrPPZ2xhTGd6BYdoWkJ0p1qWDJhm+OVMSFIGVOK
   A==;
X-CSE-ConnectionGUID: OIKPGXYnRTy8Tk+dna2eYw==
X-CSE-MsgGUID: 4VgQr5GbR6yfbKcfYvyGzg==
X-IronPort-AV: E=Sophos;i="6.15,232,1739862000"; 
   d="scan'208";a="40787373"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 20:42:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 22 Apr 2025 20:41:55 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 22 Apr 2025 20:41:52 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <unglinuxdriver@microchip.com>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v1 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices
Date: Wed, 23 Apr 2025 09:08:41 +0530
Message-ID: <20250423033841.33758-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Systems that issue PCIe hot reset requests during a suspend/resume
cycle cause PCI1XXXX device revisions prior to C0 to get its UART
configuration registers reset to hardware default values. This results
in device inaccessibility and data transfer failures. Starting with
Revision C0, support was added in the device hardware (via the Hot
Reset Disable Bit) to allow resetting only the PCIe interface and its
associated logic, but preserving the UART configuration during a hot
reset. This patch enables the hot reset disable feature during suspend/
resume for C0 and later revisions of the device.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index e9c51d4e447d..ec573327590f 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -115,6 +115,7 @@
 
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
+#define UART_RESET_HOT_RESET_DISABLE            BIT(17)
 
 #define UART_BURST_STATUS_REG			0x9C
 #define UART_TX_BURST_FIFO			0xA0
@@ -620,7 +621,13 @@ static int pci1xxxx_suspend(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
-	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		writel(data | (UART_RESET_D3_RESET_DISABLE |
+		       UART_RESET_HOT_RESET_DISABLE), p + UART_RESET_REG);
+	else
+		writel(data | UART_RESET_D3_RESET_DISABLE,
+		       p + UART_RESET_REG);
 
 	if (wakeup)
 		writeb(UART_PCI_CTRL_D3_CLK_ENABLE, p + UART_PCI_CTRL_REG);
@@ -647,7 +654,14 @@ static int pci1xxxx_resume(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
-	writel(data & ~UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		writel(data & ~(UART_RESET_D3_RESET_DISABLE |
+		       UART_RESET_HOT_RESET_DISABLE), p + UART_RESET_REG);
+	else
+		writel(data & ~UART_RESET_D3_RESET_DISABLE,
+		       p + UART_RESET_REG);
+
 	iounmap(p);
 
 	for (i = 0; i < priv->nr; i++) {
-- 
2.25.1

