Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792554587;
	b=hvlIaU8SpKiBUeXYo1sZOUj0OGikiQjfRV+0aTZ+G+hDN8CEj13a1uUpykaVVedQ8d0m
	 GO0Og8anuIiaarUg5PsgJDpFdzkxUuT3NSTKVySu9Qfd5jqP5b/RE3ne+Zk0K/M03F9lg
	 iVG5n4MP2006xegLFYu3m9ppINjgD91L0h9VhY4eXuV/+1mM65n76S6UWBIUyoSiXMP6W
	 K1zqKqdM652vTqWdRf1c81Kw0GTrGCQIj/XFt8+KVLmuv5mW536yCkkmSNAuQ8rWKkVhG
	 BIzByfZiC4LbZI6GxDlogAdgRPm/FffFCz3kSETJUE448pbo22xFL2M1nEez2xyRvgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554587;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pLrh8nz8hNj9hqeWyzFJsjUUiYRx6U77nlmEL0j61zc=;
	b=E+swJYw1nIK67JEe6yTtjCfNbon2Az+2uSAfHlwv2FCKu2zBpZjUjQDfuQ3vQ2vN0/tR
	 lqj6+uSTX0l2B5RLjCoThR58Ual8n563uZ/l0hEIHNvMSdY+x3wSULh6MZY9eqCJs6cUv
	 mQ6aHnxuL1dKTZlfM7BrEO2leZTHWQMBf92XxvQE1F4DRuds6kruk9ruMgV4o758QpdyI
	 TLmnhb43MESkb0W1lJijjN0a8sphxiBolm0Pq+VL8cJ+4SzY8oPTF8NdbQXFKjXQ4oZpV
	 qd1yM6970Hal+J99LpLdE9GkBEE15IWKBrly7Ox0k7MYQVr0SfsOdTygY9MQhr8OQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kECgPfTN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EzEHMB3T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29553606A319
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 03:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29553606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kECgPfTN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EzEHMB3T
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L3Ddpb4113859
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 03:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pLrh8nz8hNj9hqeWyzFJsj
	UUiYRx6U77nlmEL0j61zc=; b=kECgPfTNzmCWj3CWfza28xyyr29a5/M+Qahfcp
	4VeFr2LLlPKFfUGyx3AFRQ+Wy4r3KyBIpi1DdDhW4DT6mmyXQml+CYSWxEcqEhAE
	Uwh574acraqShr0BX1hIQjjK/G2QGdY1OCiUxWm9EPr0oCk5j7IuPz6qFSeBJNTQ
	u7tQv5V/zEYrY2wQQScXv3LXuOOpLSNfh3TYJl1E2d+WazpQYQTKF5KWXrYdi86M
	rds3c9VNDcpwTBuvfWdj9Xvdm+kUOEN0ZyBrrjXZoTFVgaXnqlttX2pOGcpzt9jM
	jiYv8bA0X6onchkpEOlj3ddbxkXg4TtPqkW4ihHkmISNAE0w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajhusu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 03:49:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so497012eec.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792554585; x=1793159385; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pLrh8nz8hNj9hqeWyzFJsjUUiYRx6U77nlmEL0j61zc=;
        b=EzEHMB3TzUNaBooAE2fO7URaLAMlHnkuZUOPyGUaoti1U+RSLnl+PRtj4BVModmYxz
         JEPfez3/hDdnMSVmGsR8sbz5yWJWDL584lvWvxXbwm8GafuCm8ujTjeSEfdTvQZNGxHh
         lX+M4rYnBe0LVe7FsRIi6HG6ZKBB8pM43tIENKyjUAtp2xw/oxvXxhQ8J1xVsVT1IXkn
         Al74IwbsKEspuH0Sa7AbJUYG2Z4jrAYrn8GNtYwuLXsUnRuKdpU0Nt5sGpVH/awdKQ8w
         VP6jAQV/AQ9R/HEpkQInIaV9I8WrrX8CdXRuYVD2kaarqV+yxXs98hGC5x8VY23wZF/N
         Ox5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792554585; x=1793159385;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pLrh8nz8hNj9hqeWyzFJsjUUiYRx6U77nlmEL0j61zc=;
        b=hsR0PhBPoZbGyhAGz5JAkRhYeqr1RBp7pP4IEYMLQ7d0RinxOju+xBKr4I15HaZSA6
         MGo4sUx0F04lTPV4cH/9xkzFDorGFZUKv9X50hZoMp36zKmHLFDshpPTn98ooWVSNsZz
         6MNV9RLojQnG2ViiQwbbAvNxtgl+U90omQcWeZGVkk9iFFSHN4eV3UAv2k26psyNQqnZ
         cZ9cqBotRbplygsYMzeGdMTraxNQgt53UZh9h1oQbQACJ6TiqgPO4Crbe7JmW/Z9wgCj
         hdxzMWQI7Wpd2zbHHaadtTOtuD8rLWKBxqVKRg2XT//KO84ViLnlAOM9rHc0dtDSNovh
         ijDQ==
X-Forwarded-Encrypted: i=1; AKwUvBydFZqGQFSmbED4NqPZhSeyeCdol0GyXRatVFxYjZqgTi4WL5RomNQhwYJtkI0okzbd4iuxJAGR6ZQfhjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjxCyB61ALyeOw3ksTJjGu8+1hxQQPGZPYFz/3LYtbhVzZ1Jzd
	4nNGFtE/P/gpUBx3cmVWslF8FjKL7Qt/0/bam2j4NKRF50QmFoJGr1EPEJUQopQZs5C0a8VRb5I
	EZ0x/qWFNZU9B82BxDHIIIb+ctHWzcTQ9MSr98s2ARXa6Ycm4UefTvbRkJxEIH0ftfqg=
X-Gm-Gg: AYBFou26vKJtANLbtVHF94+qcAkM2jYNRsGBnjfz0r+WEw296Ta+nuzyxUmISXL0WKq
	80XILYjMTB6mI7cd5VHgkWhizykIDD1dVRpNRNDygtFGUBdMVxsytFYlJXN2oPZ08dFahHgBQOQ
	v4RZ8s2cpZnKUO4bSItaHhH6IghxPP/F2Uhqhlbn4qzpX5Ui+gVplZTTBb+zLv3f/rULjoFEsva
	Hw4cysUTibouWVLM0pax4yMgF/PcKkKg16VFsc37yOzakxhiQPJOdEDDzgUjepCV5cpLgs0CwKB
	tjQEM1YL9oRPOspxwEVNmFo0nGzGK3yeWGVOMLpKuJUIZnfJ9VvSiRRgOFBl2n3E887RQyY6tA1
	wI8gYU9jRsMFkcxsKcFnF0n5bTvtvZ8wj7g==
X-Received: by 2002:a05:701b:4344:b0:187:c940:21b7 with SMTP id a92af1059eb24-190a44718a7mr1082931c88.9.1792554584568;
        Tue, 20 Oct 2026 20:49:44 -0700 (PDT)
X-Received: by 2002:a05:701b:4344:b0:187:c940:21b7 with SMTP id a92af1059eb24-190a44718a7mr1082899c88.9.1792554583940;
        Tue, 20 Oct 2026 20:49:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a74624csm2660983c88.7.2026.10.20.20.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 20:49:43 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:19:37 +0530
Subject: [PATCH] serial: qcom-geni: Clear pending IRQs while suspended
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-ack-interrupts-on-suspended-port-v1-1-2747a58ca7cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFA22GoC/yXNTQoCMQxA4asMWRtoB/+vIi46bdQopCVpRRjm7
 lN1+W3em8FImQzOwwxKbzbO0uE3A8RHkDshp24Y3bj3zp8wxBeyVFJtpRpmQWtWSBIlLFkruuh
 TcLtw3LoD9ExRuvHnt7hc/7Y2PSnWbxeWZQVffRIZhAAAAA==
X-Change-ID: 20261019-ack-interrupts-on-suspended-port-0c1da05a8407
To: konrad.dybcio@oss.qualcomm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792554580; l=2968;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ieX+YQtASDWC13bK513dosiz5ZJU2cC0PQouYsKDNkg=;
 b=yy6LTPvTOiJPvyNosk4BoFkFNjWSjUTf/2rib16JnpJgqHn+FkWmZ9n7iGY5pfvR5pOfPP8fn
 seC5+cEndI1Czqo0TNu4k4gxoV+HElWxtg3Bt06NG2caPyHYUxqEDkr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfX0OZ7IoUM7406
 /0QP9gChBy5ZNyfHfC45/Qt2iRd1kjU2bSvoNABwNugu2V7RlxOQ5rzX8n7/VYI2lpoBxVrK/7i
 ZEc5uOboZXC+AvBLQvLbuazSYTOlM92ELBDGYiFxN1GcqRPd3i6omcuuHlkwM+ByiGVm+HOwReB
 sXV1z9J8iS4FpANMg7XfqjKPRIvUsJNTPgvBubbuieacaXfUbz8VxlSmfXwOqc431ZnmMW7u6U9
 mKDlJPRw5sZR3DBkHRiut9SOTOtxbE29+w/JxPjcohNHmAhD3Fagm76dEUsiXr2bE2BIhaPnZ4S
 twULOODsTkhmJmBVpqXLSSg71FcbdzqLJsm7w7HbK0VBsK83QzFq8Bqk/OBfnAkagwcbQqcMXRr
 hpPzz2Mv8epXhSEOUGvjIbC/Rc/PpxX/EdtYG/K/JaLNLBJJ/xOQKk4vAV1wT218EPNqG1BVbpB
 RO8sldygCeYszdIA+yQ==
X-Proofpoint-GUID: E9rvrLvoCoNDzOYWX6VVmkBhrysuMizg
X-Proofpoint-ORIG-GUID: E9rvrLvoCoNDzOYWX6VVmkBhrysuMizg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfXzgM2ikHmhKeK
 TmDt1VuQ3jRGQJENPPmZyVeIobvS/4awDuoqwE7pOOhV6K2P6CK6g2CBRyaA/Ngj7X1RfbBP2Q6
 ty0Lj8M93WVkKPqPFYwdZHXHGqQepnQ=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad83659 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vhs-WGORcTz9ne4HZroA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210014

When uart_suspend_port() marks a port suspended, an interrupt may still
be pending before TX and RX are stopped. Returning IRQ_NONE before taking
the port lock leaves those interrupt status bits uncleared and can cause
the interrupt to be retriggered.

Take the UART port lock and clear the relevant interrupt status first,
then skip interrupt processing while the port is suspended.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index bfdc155c128d..d8323d6b5286 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1210,16 +1210,26 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	struct tty_port *tport = &uport->state->port;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
-	if (uport->suspended)
-		return IRQ_NONE;
-
 	uart_port_lock(uport);
 
+	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
 	s_irq_status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
+	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
 	dma_rx_status = readl(uport->membase + SE_DMA_RX_IRQ_STAT);
+	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
+	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
+	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
 	writel(dma_rx_status, uport->membase + SE_DMA_RX_IRQ_CLR);
 
+	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
+			      dma_tx_status, dma_rx_status);
+
+	if (uport->suspended)
+		goto out_unlock;
+
 	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
 		uport->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
@@ -1234,18 +1244,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		port->brk = true;
 	}
 
-	m_irq_status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
-	dma_tx_status = readl(uport->membase + SE_DMA_TX_IRQ_STAT);
-	geni_status = readl(uport->membase + SE_GENI_STATUS);
-	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
-	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
-
-	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
-			      dma_tx_status, dma_rx_status);
-
-	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
-	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
-
 	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
 		goto handle_rx;
 

---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261019-ack-interrupts-on-suspended-port-0c1da05a8407

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

