Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFA25D20D;
	Fri, 25 Apr 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593165; cv=none; b=ayd93AuTpvPKdODiHzE+IBrTrmdiA36UPa+zCf5/jEtaxhYmt23hnbzOUgwRYFsjFP+6q4NT30Tx3w+mX6ofPOUef+EkUQCp6TrmCygt0oIk+BQJlVj2ZuFYw6iIAYuxPGVvh+CJbw4ALK/xVmOI4UFmTRXduQkpVNnWXtjkh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593165; c=relaxed/simple;
	bh=NcZTpW+W3/3j6URDi6LYMEmphirN8bIOsroNzlTdynU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdmkLkWCoeGNcvvdX1uhFBKw90igTmZMe3Ves3xMqS7ogvYkZ9p7qex1QtJ/Sr7htzsFvTfYCLGWxAUbcAmis3v6TtdGOWMuuQ3hFz+uWi5Hr4jMwAuu4pq8bSnv4NbRfGdoLKEf1uEYQViQbPeRlPvMbjFLRfLoTsvWLd6EJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CItDUdyO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CItDUdyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745593164; x=1777129164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NcZTpW+W3/3j6URDi6LYMEmphirN8bIOsroNzlTdynU=;
  b=CItDUdyO6yjcuSwi7oB/V68kGV28Hv7hieEzeWo528Vi/aei61jyf7hw
   OHu8ZNfNCmXl+c/2gnt0/31vsEb/69Kn10KjGmV3eCeenQs6tHV7Gx/tc
   Dh1x6KuZorXx4flBVkancMAlOLQ6xHHJyD2RujCe2qLMci30qzc0BitxG
   SNeTzeTaNILzLswWjbuM4Dgr58aOrekp5TWXVggGtJU/he1VlZcbuprsq
   aHTjKfxVmkmM7mmB3iJcIfSFgJZKdLFBG0QR0N5piPHqGRNP++xS2LNG8
   cxH9F+Gt3wSKgTAh21U3oD2g62BBnOMtsL+pwJyQAXJGjdKEAJbgYbI64
   g==;
X-CSE-ConnectionGUID: zK3E3vQOTby3Mg5yTvWlfw==
X-CSE-MsgGUID: F4j2S3AZQB2F3hBC3s68EQ==
X-IronPort-AV: E=Sophos;i="6.15,238,1739862000"; 
   d="scan'208";a="208402648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2025 07:58:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 25 Apr 2025 07:58:08 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 25 Apr 2025 07:58:06 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <unglinuxdriver@microchip.com>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v3 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices
Date: Fri, 25 Apr 2025 20:25:00 +0530
Message-ID: <20250425145500.29036-1-rengarajan.s@microchip.com>
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
v3
Resolved the indentation issues.
v2
Retained the original writel and simplified the hot reset condition.
v1
Initial Commit.

 drivers/tty/serial/8250/8250_pci1xxxx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index e9c51d4e447d..4c149db84692 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -115,6 +115,7 @@
 
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
+#define UART_RESET_HOT_RESET_DISABLE		BIT(17)
 
 #define UART_BURST_STATUS_REG			0x9C
 #define UART_TX_BURST_FIFO			0xA0
@@ -620,6 +621,10 @@ static int pci1xxxx_suspend(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		data |= UART_RESET_HOT_RESET_DISABLE;
+
 	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
 
 	if (wakeup)
@@ -647,7 +652,12 @@ static int pci1xxxx_resume(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		data &= ~UART_RESET_HOT_RESET_DISABLE;
+
 	writel(data & ~UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
 	iounmap(p);
 
 	for (i = 0; i < priv->nr; i++) {
-- 
2.25.1

