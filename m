Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1C29ACED;
	Thu, 10 Jul 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.146.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188071; cv=none; b=iAxnlPFaeXWORyMXFbELtWj0xTfnPVZXNDioZpOEtpzBMSAXMy9w3bk8vEcIIslhvSswur0IOsADj5qjTd5S0by4cYqnaIKdAsqROG+LFo87i0KLbjdZRFX809RtavrK0SvFu/9IwmkNCUQZN6oHg4OmQPo37lee2ImczcHA6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188071; c=relaxed/simple;
	bh=ivJCxUCgl243XjRN5WyGeQAZx+zEqsXgZwQIzGfWy1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=apRVh/YxVOrbfyXrsrBOBLC7eDp/hVHJ5IoPB0y+myUX+E5Lr5o8HL3AoslrY6KhzaoufNTZwHsO1/a+4duZ2BUBarSvg/EFeVZNU7rgL8/8BJ768o09PSQ/0kRrmv876PdXeGkRFh+95YM3bigoAZMoTPTeKTKSqszNFyZKG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=YfkVPAt8; arc=none smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="YfkVPAt8"
Received: from pps.filterd (m0484890.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFFF2B018228;
	Thu, 10 Jul 2025 22:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=fcapAq07CM1CDaQ3F+G3TLDDXj
	xDGQO7C/TUD9IvSSo=; b=YfkVPAt8XGkBNgdwy6S7AHYLNOixzYCUeMo2iO05IF
	9qxeyQ6l53gbBMUrtV34ci3Zq4BYVD3rz6oG+i9UaxABtTm8TM7caohnOxF7xAiP
	hPmguA5w+yYnIgnKnq863rzrRNY1LYFj18fm2lqxQhTdGpgj/+kUzIGxgcY33o+V
	72sOyFnXpA6bOYmN/fbZ9Y60wjaU2H4Yyl/Ay53QOdtDqpQbVDTxExnYrcx1eI1A
	8DxQEAdRwSPyfQMSM9NJocHf6IkoghNNnZB/mOMdbAUi2h83qxVaps364U0b56B4
	WlWJVD5XIFVKGThNhRmwWWruWRiRWBDTQ1IIYBiU0byw==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 47tam6wpnf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 22:39:03 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 10 Jul 2025 17:39:02 -0500
Received: from cvadrevu-p620.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Thu, 10 Jul 2025 17:39:02
 -0500
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Chaitanya
 Vadrevu" <chaitanya.vadrevu@emerson.com>,
        kernel test robot <lkp@intel.com>,
        Jason Smith <jason.smith@emerson.com>,
        Gratian Crisan
	<gratian.crisan@emerson.com>
Subject: [PATCH] serial: 8250_ni: Fix build warning
Date: Thu, 10 Jul 2025 17:38:37 -0500
Message-ID: <20250710223838.2657261-1-chaitanya.vadrevu@emerson.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=68704107 cx=c_pps a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=geDs06hvAAAA:8 a=eTsoE9kVQGiD-jAPuUoA:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE5MCBTYWx0ZWRfX07SJvoixVHqg fNSiPq3CJr0G3Ke6cnAdn6K+w+GBbsaou7M1fGXlYjCxRP6Z268Wt53lHppG3Cu1inQdHfGmvnZ +adaWcWgFMA519JTAWbH3BwkLA5cRYDfn6x+p+Ct8GiSiIYidjJRmDPOKpKp92KQOLFrx1+mHvZ
 dYqMrFP8B8M6wtGEo2uMRitaHjS3raFIdwL8arc39WpkLxv5TWYyLsaDNwOAWZ7oJQ42nxWR8oZ yOD2qSFETqnXUrBxgT0//C0ml/TY3l89OW8yFO2dwAVNGeKEACgMks3sX/1ZboSlIjeG7EflYP0 GXwwLJ0XlBovQV3ZXmVw291iukw+tN1u1o0S7ACe6qnpt/BYrpmL9xCMT5PRRTurRQrYPpokRiJ
 4P0Vk+85R9TqFTiLWqJzCk9EvhifJvSn4eLMeNdZWAF1mKGwmfXyhnPLV4cQRRlpWwQvV5A0
X-Proofpoint-ORIG-GUID: ROE9RDew2f4Edt4xn8gnpSXlZqzHBP-K
X-Proofpoint-GUID: ROE9RDew2f4Edt4xn8gnpSXlZqzHBP-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100190

Allocate memory on heap instead of stack to fix following warning that
clang version 20.1.2 produces on W=1 build.

drivers/tty/serial/8250/8250_ni.c:277:12: warning: stack frame size (1072) exceeds limit (1024) in 'ni16550_probe' [-Wframe-larger-than]
  277 | static int ni16550_probe(struct platform_device *pdev)
      |            ^
  1 warning generated.

Also, reorder variable declarations to follow reverse Christmas tree
style.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507030557.vIewJJQO-lkp@intel.com/
Cc: Jason Smith <jason.smith@emerson.com>
Cc: Gratian Crisan <gratian.crisan@emerson.com>
Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
---
 drivers/tty/serial/8250/8250_ni.c | 56 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index b0e44fb00b3a4..cb5b42b3609c9 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -275,76 +275,80 @@ static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static int ni16550_probe(struct platform_device *pdev)
 {
+	struct uart_8250_port *uart __free(kfree) = NULL;
 	const struct ni16550_device_info *info;
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = {};
 	unsigned int txfifosz, rxfifosz;
-	unsigned int prescaler;
 	struct ni16550_data *data;
+	unsigned int prescaler;
 	const char *portmode;
 	bool rs232_property;
 	int ret;
 
+	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
+	if (!uart)
+		return -ENOMEM;
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	spin_lock_init(&uart.port.lock);
+	spin_lock_init(&uart->port.lock);
 
-	ret = ni16550_get_regs(pdev, &uart.port);
+	ret = ni16550_get_regs(pdev, &uart->port);
 	if (ret < 0)
 		return ret;
 
 	/* early setup so that serial_in()/serial_out() work */
-	serial8250_set_defaults(&uart);
+	serial8250_set_defaults(uart);
 
 	info = device_get_match_data(dev);
 
-	uart.port.dev		= dev;
-	uart.port.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-	uart.port.startup	= ni16550_port_startup;
-	uart.port.shutdown	= ni16550_port_shutdown;
+	uart->port.dev		= dev;
+	uart->port.flags	= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart->port.startup	= ni16550_port_startup;
+	uart->port.shutdown	= ni16550_port_shutdown;
 
 	/*
 	 * Hardware instantiation of FIFO sizes are held in registers.
 	 */
-	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
-	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
+	txfifosz = ni16550_read_fifo_size(uart, NI16550_TFS_OFFSET);
+	rxfifosz = ni16550_read_fifo_size(uart, NI16550_RFS_OFFSET);
 
 	dev_dbg(dev, "NI 16550 has TX FIFO size %u, RX FIFO size %u\n",
 		txfifosz, rxfifosz);
 
-	uart.port.type		= PORT_16550A;
-	uart.port.fifosize	= txfifosz;
-	uart.tx_loadsz		= txfifosz;
-	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
-	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
+	uart->port.type		= PORT_16550A;
+	uart->port.fifosize	= txfifosz;
+	uart->tx_loadsz		= txfifosz;
+	uart->fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
+	uart->capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
 
 	/*
 	 * Declaration of the base clock frequency can come from one of:
 	 * - static declaration in this driver (for older ACPI IDs)
 	 * - a "clock-frequency" ACPI
 	 */
-	uart.port.uartclk = info->uartclk;
+	uart->port.uartclk = info->uartclk;
 
-	ret = uart_read_port_properties(&uart.port);
+	ret = uart_read_port_properties(&uart->port);
 	if (ret)
 		return ret;
 
-	if (!uart.port.uartclk) {
+	if (!uart->port.uartclk) {
 		data->clk = devm_clk_get_enabled(dev, NULL);
 		if (!IS_ERR(data->clk))
-			uart.port.uartclk = clk_get_rate(data->clk);
+			uart->port.uartclk = clk_get_rate(data->clk);
 	}
 
-	if (!uart.port.uartclk)
+	if (!uart->port.uartclk)
 		return dev_err_probe(dev, -ENODEV, "unable to determine clock frequency!\n");
 
 	prescaler = info->prescaler;
 	device_property_read_u32(dev, "clock-prescaler", &prescaler);
 	if (prescaler) {
-		uart.port.set_mctrl = ni16550_set_mctrl;
-		ni16550_config_prescaler(&uart, (u8)prescaler);
+		uart->port.set_mctrl = ni16550_set_mctrl;
+		ni16550_config_prescaler(uart, (u8)prescaler);
 	}
 
 	/*
@@ -362,7 +366,7 @@ static int ni16550_probe(struct platform_device *pdev)
 		dev_dbg(dev, "port is in %s mode (via device property)\n",
 			rs232_property ? "RS-232" : "RS-485");
 	} else if (info->flags & NI_HAS_PMR) {
-		rs232_property = is_pmr_rs232_mode(&uart);
+		rs232_property = is_pmr_rs232_mode(uart);
 
 		dev_dbg(dev, "port is in %s mode (via PMR)\n",
 			rs232_property ? "RS-232" : "RS-485");
@@ -377,10 +381,10 @@ static int ni16550_probe(struct platform_device *pdev)
 		 * Neither the 'transceiver' property nor the PMR indicate
 		 * that this is an RS-232 port, so it must be an RS-485 one.
 		 */
-		ni16550_rs485_setup(&uart.port);
+		ni16550_rs485_setup(&uart->port);
 	}
 
-	ret = serial8250_register_8250_port(&uart);
+	ret = serial8250_register_8250_port(uart);
 	if (ret < 0)
 		return ret;
 	data->line = ret;
-- 
2.43.0

