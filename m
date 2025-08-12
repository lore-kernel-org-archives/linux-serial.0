Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419C2E3AFC;
	Tue, 12 Aug 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977728; cv=none; b=Nu/aWdI3HyLRlOw5ilesI+885GPSgY1nbiMGQr9NtbBcROgsjuT8nc5QUcWRJRkhXs/PuwyMMuXQTU++aQ8lKhDIFvKBz2haK1hi0H/yXmeYgvet9/XWfEWX3IwfgHQ3gHGq8KfZQXCyke4oDRj5N/VaAWqx+fK4teu02U/oHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977728; c=relaxed/simple;
	bh=0Z/McpoyVuCR+KN0hmegWKtulm0ruOwLVSqHqC33EOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feqhW7pVkH7xjqMZPNkgK+yLrdFIRpvdIyABSj2psyr0XrWS5si4KOk6l++B4admT9CL2SSokHuNH+iDyntdZEItZ+z/eqMNUzNB/oIY2OfTir2oi1VwVrD2NVdf4WQKiAVoxceOYBnYTVgBSSk2BULol5+ivoevC/IocojJZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D78TPvg+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D78TPvg+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5Hjto022381;
	Tue, 12 Aug 2025 05:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4pyva962VqNRh4GTZvbrxxWfN16XMSFV7hHsPDGmRGI=; b=D78TPvg+6QWWIBAf
	B/r/K/xQD5T89TDClXMJqh1y8eKzHg8MdJY9GdKp48HG6pE8OJKtRtfQ4PLYi8+9
	Y7ccvq3dz6kXEJBmOqNxgMnExNkpQxVA8WwNgQp1zGJAMvKMuBRq4ETMQvoyRQ9x
	o3qoxcrctfxkh7MHDC3T3FiB5JWDETHwvwcamzP611lGpCZojfxUs4f62PXB1Xss
	WnvlQFx3NWExPdsSDaeCsylo7ldzfRNVGJ37ZRl0+a2jv61YC/QQpin68wNEE8my
	xD2Ze/SJ/rYeYXaYdGSlFNsyZzpbwObQg3dLKmjjumCePc+akJIrrux3CweAL6Zx
	qGg/JQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj46y3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57C5miTR008615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:44 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 22:48:42 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_msavaliy@quicinc.com>, <quic_vdadhani@quicinc.com>,
        Zong Jiang
	<quic_zongjian@quicinc.com>
Subject: [PATCH 1/2] serial: qcom-geni: Dynamically allocate UART ports
Date: Tue, 12 Aug 2025 13:48:18 +0800
Message-ID: <20250812054819.3748649-2-quic_zongjian@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX7fJbHalw+lF9
 Ol2e5tqQ/5RiWIGPXwOoABWQ6LHV3z2/Zb8B3mzhvtJA+uuEJ0TyR4F6c5uxk55xK2womxv+M2k
 dKaNdT7I8MnvZZkUw6Qh4SXXc85lmO7fHCE3PflGWGSI+kYQjLAWhBkWhmMjqKBOqIScwLD/Wzv
 g5CEsQ81k/gAQkZr6kaVOY7QQqBLFnUYYa001Q6oc4PzwWIyZDoHeoBGNFhAeetXpHcsLrFX1gj
 a1aqY8jCYZIG6WSbGd4v20+8TeutqiqJD+ehUsZ31shs14EPykS7cmA4nonzuHF501DVbMm1ebZ
 1CRaLz+meJ7AcsC4dhM23G5z5G6CeV8EsnSs+Pzv/XiNImVxbaZy7vKaDAs++GrOMFZFnsiAhg2
 W0i6Xdx4
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=689ad5bd cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=PvzVzoMQvDNWUbuwUUAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ItWgfjdyCBz4YWwxiSo-h8GphCTed5Bl
X-Proofpoint-GUID: ItWgfjdyCBz4YWwxiSo-h8GphCTed5Bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

Replace the static allocation of UART ports with dynamic allocation
using devm_kzalloc. This change removes the fixed-size array and instead
allocates each UART port structure on demand during probe, improving
memory efficiency and scalability.

Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 44 ++++++++-------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 32ec632fd080..080c18ddbdde 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -164,33 +164,6 @@ static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
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
-
 static struct qcom_geni_serial_port qcom_geni_console_port = {
 	.uport = {
 		.iotype = UPIO_MEM,
@@ -285,7 +258,7 @@ static const char *qcom_geni_serial_get_type(struct uart_port *uport)
 	return "MSM";
 }
 
-static struct qcom_geni_serial_port *get_port_from_line(int line, bool console)
+static struct qcom_geni_serial_port *get_port_from_line(int line, bool console, struct device *dev)
 {
 	struct qcom_geni_serial_port *port;
 	int nr_ports = console ? GENI_UART_CONS_PORTS : GENI_UART_PORTS;
@@ -306,7 +279,14 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console)
 		if (line < 0)
 			return ERR_PTR(-ENXIO);
 
-		port = &qcom_geni_uart_ports[line];
+		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+		if (!port)
+			return ERR_PTR(-ENOMEM);
+
+		port->uport.iotype = UPIO_MEM;
+		port->uport.ops = &qcom_geni_uart_pops;
+		port->uport.flags = UPF_BOOT_AUTOCONF;
+		port->uport.line = line;
 	}
 	return port;
 }
@@ -554,7 +534,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
-	port = get_port_from_line(co->index, true);
+	port = get_port_from_line(co->index, true, NULL);
 	if (IS_ERR(port))
 		return;
 
@@ -1511,7 +1491,7 @@ static int qcom_geni_console_setup(struct console *co, char *options)
 	if (co->index >= GENI_UART_CONS_PORTS  || co->index < 0)
 		return -ENXIO;
 
-	port = get_port_from_line(co->index, true);
+	port = get_port_from_line(co->index, true, NULL);
 	if (IS_ERR(port)) {
 		pr_err("Invalid line %d\n", co->index);
 		return PTR_ERR(port);
@@ -1866,7 +1846,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
-	port = get_port_from_line(line, data->console);
+	port = get_port_from_line(line, data->console, &pdev->dev);
 	if (IS_ERR(port)) {
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
-- 
2.34.1

