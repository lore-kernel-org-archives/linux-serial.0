Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBB393;
	Fri, 14 Jun 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345639; cv=none; b=BOK/hYqCMJYVIipK0QkUIinfGo82+hWn1XLEx043TYQQiWHAv3vb2pM7nAtn699Y0T2P9HwKTu8U2OFOs2XhLoFnNZi2jLbFzWqS1kPMLNTz9SEWzu1Csu0JsRdCCmkkR2y3fhNQRFsI/BZXSidBC0uDw0c/W9U3dpLiOVHXFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345639; c=relaxed/simple;
	bh=dINWXejZejeNvy4vTa+5QjhOC1IhShPhljwOH1oq2kE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unY9lpca9K3NTWBGlRo0M5KDyEFcCwV7P6MS9jKrdl19ngAdvfQ4ytXCfUh0KLyJIOfQK9h8zXERhG/yyEkBmhlWMtCSQExhJm6aHyQ5sW8Uw8TzSO6iNbbLf3+CaPd5nCJ2bUmAjzkZFb+1R6pmIVUiLtw8MRpBg9JDll2Na2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oPG9e+KI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPG9e+KI"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E6DWOZ027648;
	Fri, 14 Jun 2024 01:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718345612;
	bh=nwOhQ5GEl1mes6kpUbvK009JH5lDGyw8RkwUP7+kb+U=;
	h=From:To:CC:Subject:Date;
	b=oPG9e+KIT8W/VpjXOcin87RH8gqO4PLdcuiaa5xRrxRodtTxI7iaLvGl4LsRwWCac
	 nqIxdpeDwh/QexbOE0H8ywd64ILOGVK/SArXHeta09qQod1ldUpBH/85X7q9xH+Cq/
	 pX04AWd6BmV42w7+hlbjiMw1AHtWrO8mIwvgsvys=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E6DWhs021266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 01:13:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 01:13:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 01:13:32 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E6DSuq026165;
	Fri, 14 Jun 2024 01:13:29 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <tony@atomide.com>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <ronald.wahl@raritan.com>,
        <thomas.richard@bootlin.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH] serial: 8250_omap: Implementation of Errata i2310
Date: Fri, 14 Jun 2024 11:43:14 +0530
Message-ID: <20240614061314.290840-1-u-kumar1@ti.com>
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
to strom of interrupts, therefore apply Errata i2310 solution.

[0] https://www.ti.com/lit/pdf/sprz536 page 23

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 170639d12b2a..38eb639f78d3 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -115,6 +115,10 @@
 /* RX FIFO occupancy indicator */
 #define UART_OMAP_RX_LVL		0x19
 
+/* Timeout Low and High */
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
+		serial_out(up, UART_OMAP_EFR2, 0x1);
+		serial_in(up, UART_IIR);
+		serial_out(up, UART_OMAP_EFR2, efr2);
+		serial_out(up, UART_OMAP_TO_H, timeout_h);
+		serial_out(up, UART_OMAP_TO_L, timeout_l);
 	}
 
 	/* Stop processing interrupts on input overrun */
-- 
2.34.1

