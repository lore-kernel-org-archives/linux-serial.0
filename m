Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C51BC4F;
	Mon, 17 Jun 2024 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718602148; cv=none; b=JXb+ztK9YeRcFCgB2JNn1n7FSOkrLJBmTHE1u9RCdJIsdLfLmq1TajY9AuwgpfeDPrgWoVwklBr4meDUG3w74//Zor4opH3fOQ2bqMRGr6cQQQhgiYfwL3MujjUJTGgvfDPNIjZwONSrw4q8Xk8+1L8/S7Gk+NT2BocRiyl6WAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718602148; c=relaxed/simple;
	bh=JfuXF7LccmOQXgvjaPciJFC2/V4JeOfYjOyWcZn6Fow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPJDIHmdE/aAtCGGdanLnXDIjOjnKKs8fNWgW6qSLmRaPLJRv/GGvvBfIFRQMEP0bqV8LSO84GihwlM0G+b4PeCEcW6kRUWMkTa+F2HirLcDXMMY+wa7yQNjJfYR1PWDpmcTvin5EWOjR4KtiKI4MCsGPYzm+N3OjpgOs/iP5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FKy5gVf/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FKy5gVf/"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45H5N4Pt017027;
	Mon, 17 Jun 2024 00:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718601784;
	bh=qu9x8V63xIXF7+SOlwPPEqr91xJ3aMsUjkBmekG1Wns=;
	h=From:To:CC:Subject:Date;
	b=FKy5gVf/eIOsc3HMyb0XpthUevaYMDNzmPy1yT1FeX41hAuwqUZb/l3JvKs5IZCIP
	 KrujFIKEahKu7xTl+cEnLEM31wesM53SMQ1x2pecdN10/1kGvrad0tOP3cRQfpKZeS
	 TiJHjgCPC6Ht9c9nIbfegnuoNKmPfybzZelNVGPs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45H5N4eP006639
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 00:23:04 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 00:23:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 00:23:03 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45H5MxRS035065;
	Mon, 17 Jun 2024 00:23:00 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <ronald.wahl@raritan.com>,
        <thomas.richard@bootlin.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2] serial: 8250_omap: Implementation of Errata i2310
Date: Mon, 17 Jun 2024 10:52:53 +0530
Message-ID: <20240617052253.2188140-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As per Errata i2310[0], Erroneous timeout can be triggered,
if this Erroneous interrupt is not cleared then it may leads
to storm of interrupts, therefore apply Errata i2310 solution.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Fixes: b67e830d38fa ("serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Test logs
https://gist.github.com/uditkumarti/7a7ab6994581bbb09cf1a4271c592d8e

Change logs
Changes in v2:
- Added Fixes Tag and typo correction in commit message
- Corrected bit position to UART_OMAP_EFR2_TIMEOUT_BEHAVE
Link to v1
https://lore.kernel.org/all/20240614061314.290840-1-u-kumar1@ti.com/

 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 170639d12b2a..ddac0a13cf84 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -115,6 +115,10 @@
 /* RX FIFO occupancy indicator */
 #define UART_OMAP_RX_LVL		0x19
 
+/* Timeout low and High */
+#define UART_OMAP_TO_L                 0x26
+#define UART_OMAP_TO_H                 0x27
+
 /*
  * Copy of the genpd flags for the console.
  * Only used if console suspend is disabled
@@ -663,13 +667,24 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 
 	/*
 	 * On K3 SoCs, it is observed that RX TIMEOUT is signalled after
-	 * FIFO has been drained, in which case a dummy read of RX FIFO
-	 * is required to clear RX TIMEOUT condition.
+	 * FIFO has been drained or erroneously.
+	 * So apply solution of Errata i2310 as mentioned in
+	 * https://www.ti.com/lit/pdf/sprz536
 	 */
 	if (priv->habit & UART_RX_TIMEOUT_QUIRK &&
-	    (iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT &&
-	    serial_port_in(port, UART_OMAP_RX_LVL) == 0) {
-		serial_port_in(port, UART_RX);
+		(iir & UART_IIR_RX_TIMEOUT) == UART_IIR_RX_TIMEOUT) {
+		unsigned char efr2, timeout_h, timeout_l;
+
+		efr2 = serial_in(up, UART_OMAP_EFR2);
+		timeout_h = serial_in(up, UART_OMAP_TO_H);
+		timeout_l = serial_in(up, UART_OMAP_TO_L);
+		serial_out(up, UART_OMAP_TO_H, 0xFF);
+		serial_out(up, UART_OMAP_TO_L, 0xFF);
+		serial_out(up, UART_OMAP_EFR2, UART_OMAP_EFR2_TIMEOUT_BEHAVE);
+		serial_in(up, UART_IIR);
+		serial_out(up, UART_OMAP_EFR2, efr2);
+		serial_out(up, UART_OMAP_TO_H, timeout_h);
+		serial_out(up, UART_OMAP_TO_L, timeout_l);
 	}
 
 	/* Stop processing interrupts on input overrun */
-- 
2.34.1

