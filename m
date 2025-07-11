Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674B537F8;
	Fri, 11 Jul 2025 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.142.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264296; cv=none; b=Sqr7V1WHkI3AeJ0Qezulfxu0uyZ/wX055HvB49uT7VZkqe0no+fBf9sYcGXO06ZxCv12OJ8iehRW9ub1XLWLQorVbnwvxs07LpnEsngAm4TxjqqoNPTOKV5Rz83uO83kvtJd2OomEB+Kq406YW0KwUj+XSAQ8arqto1J1iQioIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264296; c=relaxed/simple;
	bh=ygWDw5VfhdyzawkgXcsAl4xikRoEEP3lHKS9QtH5I2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kac2F2S01+wo0aX6WsQ1vPAQsFzbDY3Q95PS9YkJTqIuH5bHZpVrhEeT20azt/S/bdUu/CE+b8ib0dDQxyoMuoZb6hF71SpqdsQU6ASZm9YP0V/5zENZVzvtZ6qBEuRTw1eRE4h57QxxEzLQIdokJ8lOE3E7xZXTXVAtw8iFp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=Dae6X3PL; arc=none smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="Dae6X3PL"
Received: from pps.filterd (m0484885.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJF1o7028365;
	Fri, 11 Jul 2025 20:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=+byR
	F3hrf2mokB/wMSDku8KYvNqFIAgteSdf0kKobQQ=; b=Dae6X3PLAK4dlvbRsvK3
	EHKccrsvFaJcts7w7EfJG18O+bIGjjrW8ZOk0y8IQUeJ1cVqTKAmaZmmjhyIDbdr
	Mx6YI/81IvHcf4ey50GY+xQQrG2fibEvZPaK0VEA8BXY8qZGdSiUCPfv8W3xxTRS
	usvE1mFoWTeIhWL1gy1vGIuzMGR52G0hrDuPSqlX7Uxa9KVqVj19QOp9awuHy8bS
	N4W2pME4pFEpN5j3uqIFGZ8g9RlLLFdX4ufufm1Iw1oGQDPHq/wqEYeAjs4ycZ5m
	B4P7v07cC2+recLqXNDU5so3F6hHmIVfyjUUeTdYJOf16gD4jN8sXAzts5eA7CbU
	7w==
Received: from us-aus-excas-p2.ni.corp.natinst.com ([130.164.94.74])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 47u1dp2prh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 20:04:42 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 11 Jul 2025 15:04:41 -0500
Received: from cvadrevu-p620.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 11 Jul 2025 15:04:41
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
Subject: [PATCH v2 1/2] serial: 8250_ni: Fix build warning
Date: Fri, 11 Jul 2025 15:04:17 -0500
Message-ID: <20250711200418.1858682-2-chaitanya.vadrevu@emerson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711200418.1858682-1-chaitanya.vadrevu@emerson.com>
References: <20250711200418.1858682-1-chaitanya.vadrevu@emerson.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B_GmmVwVNPOJFh_5X8ZAVMJ0sGCbRfxJ
X-Authority-Analysis: v=2.4 cv=UaBRSLSN c=1 sm=1 tr=0 ts=68716e5a cx=c_pps a=VUOoxcgKHUMpfFMIT0tLvw==:117 a=VUOoxcgKHUMpfFMIT0tLvw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=geDs06hvAAAA:8 a=eTsoE9kVQGiD-jAPuUoA:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MCBTYWx0ZWRfXwHui5FCyX0Ca k0SfmetQRg1/dCRilAYfxJH8rpB0+Abvn9/DPiBpbVkBiY5tZszSb5L2RAuHYO32Tt8Is9B0Yyy YQB3I2aRiOEjRoqX24s24vCYIvpGM/9oGS5NhYqAt4pNfLwdbTKNf9AFfTVqaunSxZgDJ8bkoHx
 18rV0E+Bon/eXwiyBLDNdZ4tpGbtb2wFoQDQYVAoK6uDOkL+GgnwTar3n6oyWNJHkwLhrwrDeN6 8/vLIcKE3Du2+1FS28UH0sexQCIJdTfNBn5Fy9QnwGJ54hA3UEaK3JOZ3xcVE3ebMuBYMRlJ/0K 0p9GzIDbV6tcXUwWbOKjNvLyWnyXXQ7mS3d6C8m56MlchvfOJeGfICCBsHHeRpmCJhGPI002eWo
 6s6/SzheqPzuvNhYGxzd6TZVBtXd+JNOPeUDGXPyOlwLdRtjyZOz1WqLRCd7qt4yWxABbLRE
X-Proofpoint-ORIG-GUID: B_GmmVwVNPOJFh_5X8ZAVMJ0sGCbRfxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110150

Allocate memory on heap instead of stack to fix following warning that
clang version 20.1.2 produces on W=1 build.

drivers/tty/serial/8250/8250_ni.c:277:12: warning: stack frame size (1072) exceeds limit (1024) in 'ni16550_probe' [-Wframe-larger-than]
  277 | static int ni16550_probe(struct platform_device *pdev)
      |            ^
  1 warning generated.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507030557.vIewJJQO-lkp@intel.com/
Cc: Jason Smith <jason.smith@emerson.com>
Cc: Gratian Crisan <gratian.crisan@emerson.com>
Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_ni.c | 54 +++++++++++++++++--------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
index b0e44fb00b3a4..81f2255012153 100644
--- a/drivers/tty/serial/8250/8250_ni.c
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -277,7 +277,7 @@ static int ni16550_probe(struct platform_device *pdev)
 {
 	const struct ni16550_device_info *info;
 	struct device *dev = &pdev->dev;
-	struct uart_8250_port uart = {};
+	struct uart_8250_port *uart __free(kfree) = NULL;
 	unsigned int txfifosz, rxfifosz;
 	unsigned int prescaler;
 	struct ni16550_data *data;
@@ -285,66 +285,70 @@ static int ni16550_probe(struct platform_device *pdev)
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

