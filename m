Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3F4438B;
	Thu, 24 Apr 2025 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745467367; cv=none; b=cz+bRwRGWSTzuW9egQj3pUJ5AUiCo431Xeu/enx5ytztXgD+UVp05AUGVhrd73aINnxWAIu3PIU1sVNLwZ7hTZ6czGcd1Uc7dI0AhdMD3+AXe41S/p4U4A9kY9g0r/AcAihVghDUr/1AVI2TuPT8GaW3nRPuXa4NGnTO/pap3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745467367; c=relaxed/simple;
	bh=hG3ZsGcYBkYxir6SWWhI/tKTbJNxVe6v0nAQD21YnqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvSFs31zOkH98t65z4Eu9NLOJ2WWQ8RPFAdnDc+LawSIF4HmpUtwfKuQRk7AimNpxKxrgNUnukE62EGhI/JFhkk0i+ijpnJrBNa7BEkXmp60ZjxGizL/NFL3FiS1UVOUorzKg8BsaIflBBRhfjjGenjbLdGrGxKFK/s4F0N02N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nnf3xABN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nnf3xABN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1745467366; x=1777003366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hG3ZsGcYBkYxir6SWWhI/tKTbJNxVe6v0nAQD21YnqE=;
  b=nnf3xABNJBITMCRw8Em5/wgCCm4QuEfg6OTZKKPUYvTnNf1JFe8YFe8C
   DQyNSZGOJw92a04JWuHFsUqT79l1xXpmAObevgPA06JHrg0RnxcZq+Nov
   g0+zQyPQpoxmYeHmwnurwpgK9ww90PoixNHPBnxvYxJ0rRpCHjVFhNA5S
   He78+TGPkd3Xr+ErNCmzCdNxldrNwx/53A9YqQf3uSbSFT/IwmAxMFv95
   hS7GzTskAQo6Oggw0JXLJFnNdqwyTWe7wgR8lEluyINJXhDiYmDGRs682
   Cf3YyG+c3M0Exc11Yy6/Imw3FLQTWpgTyOt9es3fEkYRPCJ237/cgbRJy
   Q==;
X-CSE-ConnectionGUID: 6WeuSPYfQkq6an5r4ywa9Q==
X-CSE-MsgGUID: gG5Bh38LSg2k1LzSra3BEw==
X-IronPort-AV: E=Sophos;i="6.15,233,1739862000"; 
   d="scan'208";a="41304460"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2025 21:02:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 23 Apr 2025 21:02:20 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 23 Apr 2025 21:02:17 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <unglinuxdriver@microchip.com>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH v2 tty-next] 8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices
Date: Thu, 24 Apr 2025 09:29:13 +0530
Message-ID: <20250424035913.7673-1-rengarajan.s@microchip.com>
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

v2
Retained the original writel and simplified the hot reset condition
v1
Initial Commit.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index e9c51d4e447d..61849312393b 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -115,6 +115,7 @@
 
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
+#define UART_RESET_HOT_RESET_DISABLE            BIT(17)
 
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

