Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372C2E3AFC;
	Tue, 12 Aug 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977734; cv=none; b=tUw36sfIIANeTuD4Kx10jDHx6etgbE9djH8iVBaFiqRu429U0D5GCNdAYl8/UO1+zic0SbhtA/9tuK7Mesmt6NgJApA1HVJD+IK3uJCL/Q0xhLZ6QoCbJPvuDaYeyp41kq+h/hzJaxMvmthUTqUUIP8M80lG+7uZzn3WLgLJmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977734; c=relaxed/simple;
	bh=Ly6eLhqFS7+gf123dMHEvhq74lr/N5lDJgipyL0QR8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nh5gLL1qhGX8AN4f+DwDFbsJf0++WhH0dISy3Wjh1pBAL/k1gzXFQokjSpG9xmFZQ1GBUTBGlmDNZVlWHrnsz6d1w87WTvXBub8H2RUF8/bvlEeFX0jDGNhTX1YcBRCWPkF5I34OcRmB6H79qPZW4Dc0/75UvLT+P6CW8n7oMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XMWggOat; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XMWggOat"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5ULU1005283;
	Tue, 12 Aug 2025 05:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BadKjfoBxfBUHH0TDrRBXlfbh1hbllAzsvWvxvxazbo=; b=XMWggOatQ2oKTtIn
	WYx0mB0e4R6nM0kajvUbwWoodhQkH3VNR0VIf67mC6HYrRLU5HE73YZvazKWKb4T
	Ks85E6T5AZq8abypqmYHY/OBDcA9DkITncsGgsLIJRojGDJkUmw9aCuHM0r/DZ9f
	/Yzme8UXXkBADWMQ+vpHmj5cjBRcjCZvr42YA+YmLc0+Sri7VTS2fl9v+BsOJRss
	p1v6GfhIBPXBpXTdr6AFBODVl2PcFWzNMmMfMKmoP1NqLLCYB7OhqCeZ9l1IP2Pm
	m6N87pi/PYgAgMK6hyaqaukBpiJxwRwQ74g/q3/O9auYyAFbGh4XtS8WzhXiDUZ4
	wb/N/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx55hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57C5moMI028701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:50 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 22:48:47 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_msavaliy@quicinc.com>, <quic_vdadhani@quicinc.com>,
        Zong Jiang
	<quic_zongjian@quicinc.com>
Subject: [PATCH 2/2] serial: qcom-geni: Make UART port count configurable via Kconfig
Date: Tue, 12 Aug 2025 13:48:19 +0800
Message-ID: <20250812054819.3748649-3-quic_zongjian@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812054819.3748649-1-quic_zongjian@quicinc.com>
References: <20250812054819.3748649-1-quic_zongjian@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX4URKSGvCeEIt
 Z7Jtu1NS4sV5P7L75bjmWsXWKeCGw/UATGkIfYtnuHTfFJrOtuDaGL3gdk1zTUUBU/t/7gPp6fo
 ridOrwLaBcWF39vtcE3UF2aAS0RPu/HspbC+y0VW7wpFe3W6HyxK0XM0ld9mYuOyLGd9Z+QqzJk
 aNdygoh4GcVC15jvWiDJ+nsITp6a0d8ffoZyE8aXFwcIpqQhT8aL1kWi7EX8lHVQC0I6FnWUdPR
 OdaHIxlJZV92Ja2ALs2GpACVfurj3hzMUazAp7hfZHGfP3WrHREcoqm+s7dTrgthmVzIQJl7hMU
 7ppXcZt11fV0frd3jrK+Xjs9xQf3KkeMz/ZSBOUGVk+cB49w9exvw8j0usJYPl2Mul5UfZGphAE
 QnERT6KK
X-Proofpoint-GUID: EktRJq2w4V8t5TlhKcD7Ws2U-SwDCxjG
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689ad5c3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=WPGC7FYvddHUjIg9JlYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EktRJq2w4V8t5TlhKcD7Ws2U-SwDCxjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

Replace the hardcoded GENI_UART_PORTS macro with a new Kconfig option
SERIAL_QCOM_GENI_UART_PORTS to allow platforms to configure the maximum
number of UART ports supported by the driver at build time.

This improves flexibility for platforms that require more than the
previously fixed number of UART ports, and avoids unnecessary allocation
for unused ports.

Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
---
 drivers/tty/serial/Kconfig            | 8 ++++++++
 drivers/tty/serial/qcom_geni_serial.c | 5 ++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d..e661f5951f55 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -928,6 +928,14 @@ config SERIAL_QCOM_GENI_CONSOLE
 	  Serial console driver for Qualcomm Technologies Inc's GENI based
 	  QUP hardware.
 
+config SERIAL_QCOM_GENI_UART_PORTS
+	int "Maximum number of GENI UART ports"
+	depends on SERIAL_QCOM_GENI
+	default "8"
+	help
+	  Set this to the maximum number of serial ports you want the driver
+	  to support.
+
 config SERIAL_VT8500
 	bool "VIA VT8500 on-chip serial port support"
 	depends on ARCH_VT8500 || COMPILE_TEST
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 080c18ddbdde..9c7b1cea7cfe 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -77,7 +77,6 @@
 #define STALE_TIMEOUT			16
 #define DEFAULT_BITS_PER_CHAR		10
 #define GENI_UART_CONS_PORTS		1
-#define GENI_UART_PORTS			3
 #define DEF_FIFO_DEPTH_WORDS		16
 #define DEF_TX_WM			2
 #define DEF_FIFO_WIDTH_BITS		32
@@ -261,7 +260,7 @@ static const char *qcom_geni_serial_get_type(struct uart_port *uport)
 static struct qcom_geni_serial_port *get_port_from_line(int line, bool console, struct device *dev)
 {
 	struct qcom_geni_serial_port *port;
-	int nr_ports = console ? GENI_UART_CONS_PORTS : GENI_UART_PORTS;
+	int nr_ports = console ? GENI_UART_CONS_PORTS : CONFIG_SERIAL_QCOM_GENI_UART_PORTS;
 
 	if (console) {
 		if (line < 0 || line >= nr_ports)
@@ -1652,7 +1651,7 @@ static struct uart_driver qcom_geni_uart_driver = {
 	.owner = THIS_MODULE,
 	.driver_name = "qcom_geni_uart",
 	.dev_name = "ttyHS",
-	.nr =  GENI_UART_PORTS,
+	.nr = CONFIG_SERIAL_QCOM_GENI_UART_PORTS,
 };
 
 static int geni_serial_resources_on(struct uart_port *uport)
-- 
2.34.1

