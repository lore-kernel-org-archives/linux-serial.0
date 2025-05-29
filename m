Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7F1EB5FA;
	Thu, 29 May 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748509447; cv=none; b=Q5qmXSKciRuhdM9GRcqgxHQxcyloPdeEHSNiaoujyekw8s+i8pLSqPXvFaNPUmAqbAYm0bxxB95XiJdhRKZMOmifo6ggEUo0uLRPOTUu1mdT/z7t/gqlhu5DYGowrq3Y9IClE1L2JV8OEvKBV7Q4fNCRJmmKZzfiN2z7au/vGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748509447; c=relaxed/simple;
	bh=uik7CVAfylf4Zns01Xl/e4tYqWdzKhabVx4q5X0bwss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHJZq/L5jVAbKenrPlG/T5z4LWSnRulJtUSCZlezIdUSUji5cO3F3/hs5pQnPnIHsmUfAE4xW4kyyqPs7vX+ecETiqtdOj/sfJv3/jaoith7NlEgEicjxbAawOfSBt8ZUAe7Xc/XNWbLH7BzzhjF3sPkqmgrII+i6ZsMDoDS4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ix347Nd6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ix347Nd6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T8GuWK013744;
	Thu, 29 May 2025 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QYitLenvKdMMoSXMFdk5ar
	dpn4Q/7ywfa6pxQK9lrIQ=; b=ix347Nd6ze2cJCRJ2daKFNkDEcyo/tzCC7NeJt
	K/KAoEQgnYf3/gt2BweZZCQVUux7x1KD28Zpwd976k/8eoIuE0TAG6rTHeggWa6s
	LP91YyyeyEOblsuz/99DB14hwEWDFaGcwas13TUrbXtBnESJwu+N7tpWhK8s/0qb
	SosBY9K4cjCdQNjjF627SX9BSbVqPJ5P8y9zyfxBaHOIJ5RdH050bd8T/sKekk0i
	g1h/mJgIJTRzGakXKKgkO8azlUperwde7sovCH1WE9AG1P99yigaRrA+B00gNrm+
	TEOezc+9iivizexOfBjB2VnSCSaTwkXmxmQnbFflqGHZnGmw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691fnew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 09:03:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54T93wFm032025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 09:03:58 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 May 2025 02:03:56 -0700
From: zongjian <quic_zongjian@quicinc.com>
To: <quic_zongjian@quicinc.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, <quic_haixcui@quicinc.com>,
        <quic_anupkulk@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vdadhani@quicinc.com>
Subject: [PATCH v1] serial: qcom-geni: Add support to increase UART ports efficiently
Date: Thu, 29 May 2025 17:03:25 +0800
Message-ID: <20250529090325.1479702-1-quic_zongjian@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=683822ff cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=fp4JcETvSatQGfsmKXEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QUXfGPdFBAar2tK12GA043gYDYLz3ZLC
X-Proofpoint-ORIG-GUID: QUXfGPdFBAar2tK12GA043gYDYLz3ZLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA4NyBTYWx0ZWRfXx8YG/8vr467x
 jn8EFj1ad/WPZG3p7cpNgxgOyRTGyJYdmhlp2CnL+5Pz7zOzKsKF3/oFwSo50/mePGnqSYmgf6a
 8qMntEZytHDC/prRxOf9ZDed+NiDhWDwqlK6MG9Eb6URER7MhmghkooZwnWOpbD6llxn572IeU9
 XOeZlX6S5CMbs+xu5Usd4eHf5nCNInLWLfSCEE6on7YQkuyAggfGw0chKlBOm2+41+Jzt6VlUM0
 YRgPLAiO2Vxi78H8MkeysqYUlpBS0bDNdZxTS2YD1eHdN85JdZQOMyoF2dRDLRd3Gf5iDzuTk3D
 5Xn6VLnj6j1gI6wtok0QMPgERguhEWPgUpAFxrEJ3fxXM3rsR+c6tgdBJHdokX31zlhl8YU7EgE
 LPb9PTqHbL5CBtcy77Flr2LbUuo8ESu+XsGsmgEP6oQbhXCcs/ZOSAYEFQP7j0j6Mr40B9jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_04,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290087

Populate members of qcom_geni_uart_ports through a loop for
better maintainability. 

Increase the UART ports to 5, as a few use cases require more than 3 UART ports.

Signed-off-by: zongjian <quic_zongjian@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 40 +++++++++------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 140c3ae5ead2..d969c96b9690 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -77,7 +77,7 @@
 #define STALE_TIMEOUT			16
 #define DEFAULT_BITS_PER_CHAR		10
 #define GENI_UART_CONS_PORTS		1
-#define GENI_UART_PORTS			3
+#define GENI_UART_PORTS			5
 #define DEF_FIFO_DEPTH_WORDS		16
 #define DEF_TX_WM			2
 #define DEF_FIFO_WIDTH_BITS		32
@@ -153,6 +153,7 @@ static const struct uart_ops qcom_geni_console_pops;
 static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
+static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS];
 
 static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
 static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
@@ -163,32 +164,15 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 	return container_of(uport, struct qcom_geni_serial_port, uport);
 }
 
-static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
-	[0] = {
-		.uport = {
-			.iotype = UPIO_MEM,
-			.ops = &qcom_geni_uart_pops,
-			.flags = UPF_BOOT_AUTOCONF,
-			.line = 0,
-		},
-	},
-	[1] = {
-		.uport = {
-			.iotype = UPIO_MEM,
-			.ops = &qcom_geni_uart_pops,
-			.flags = UPF_BOOT_AUTOCONF,
-			.line = 1,
-		},
-	},
-	[2] = {
-		.uport = {
-			.iotype = UPIO_MEM,
-			.ops = &qcom_geni_uart_pops,
-			.flags = UPF_BOOT_AUTOCONF,
-			.line = 2,
-		},
-	},
-};
+static void qcom_geni_serial_port_init(void)
+{
+	for (int i = 0; i < GENI_UART_PORTS; i++) {
+		qcom_geni_uart_ports[i].uport.iotype = UPIO_MEM;
+		qcom_geni_uart_ports[i].uport.ops = &qcom_geni_uart_pops;
+		qcom_geni_uart_ports[i].uport.flags = UPF_BOOT_AUTOCONF;
+		qcom_geni_uart_ports[i].uport.line = i;
+	}
+}
 
 static struct qcom_geni_serial_port qcom_geni_console_port = {
 	.uport = {
@@ -2048,6 +2032,8 @@ static int __init qcom_geni_serial_init(void)
 {
 	int ret;
 
+	qcom_geni_serial_port_init();
+
 	ret = console_register(&qcom_geni_console_driver);
 	if (ret)
 		return ret;
-- 
2.34.1

