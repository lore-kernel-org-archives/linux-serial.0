Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6A3515DF
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380762; cv=none; b=AV5wWeB+HLRt7lgKUpzT2rIeUht63JNvCLgHPCzci0gbrTiIsHt90HJYyMLM780HCcC8jpw7vV41qb0oJfUvqe/ypWv4bO/uCUl+VEIP1V0Cki6g/u2h2g2bxPLtItmy0sFNMhARwPvjxcl6eOPaFDbU4tsICNVQfDRS9bM3Bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380762; c=relaxed/simple;
	bh=vtCPb9zV6L5uTrn3PIAIHPOGWAn1ooRRD+kV9nQCxTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P9uD0/z54a6MoZsoOJ34t5YXyY473vw3CkjFPpXHzGQe13ozcILXKvU4MGg7SAjAVOJBytSpBZirRQnxiVG8cidEq+O9KXL3I3i33XWwTT6TLVslQsqOY4dCeUDjby1DFJwtVCdEBMI+adsuUkWFLNERkLG7d8tt5Wi/ROIrSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4OX2zBk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Imb7yjou; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4OX2zBk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Imb7yjou"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1FRPx1308133
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 03:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=n+xQAV+h4O3H+drN3Sggr/
	lxYZZZqiuYT8sgXuwudPk=; b=f4OX2zBkOHZC4vp1PrBUX98rySIaK6GX0MnQV/
	VQQDmlT26sdRrdyFOUPQThJIzuwrVIzuS2L/Glymax1lax4KR5oVzt5874YxYi9h
	ec5OWe+xfrG1GLr9D4YapDufJl/2c037nL7CbYU1+0a4nAsvp7l44r9BOi1AuRoB
	NFbd/fqbf6o79EMoap7mprBuIEBU0cl/ohYigfPWlloxDw72B2ZvDo1ElgrhtOoz
	Zh06lA1iHu9eeY6IkN7Hma3DG3coLRZuaq67J1+iZZEUZKH3SnzcHUo57y6YhICG
	XsjK5Zm/mNzShFicwd9Rhuz2O5LQ6yD4lLVp4sg7hfqwiF1w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc183cp20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 03:32:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so3478019eec.0
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 20:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792380758; x=1792985558; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n+xQAV+h4O3H+drN3Sggr/lxYZZZqiuYT8sgXuwudPk=;
        b=Imb7yjouRPTbHsLDyn2+Ud0Cc7E/vijJmnaDlDYgSw5Qc75EFt0swhTpAXTUYfOkhp
         va55SEY4IDRvEmztkxEk8AI8x1tmRw1nMFK2v3NzeRFNfE6bDWOIh/OVJSbciy6ARHUH
         QCnhq19Qc7UcCncJRZsvBr8dgX+HaSlAu28HDdQqtPt6bq8Trugq1islWNGjQNgNFEMo
         gS/x8Z9P/sUdNqEnNJSZW9+Sw8bW0BBgOxMHnmiprnUEgbm+ue4RNB1rh0EtJBaAjck4
         GbyZNIluzxW1F951VVYITzfEZzdUJu5ngc+jYGCVL659GPsd4cFZAfFW+LkaIyYSDlSJ
         aylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380758; x=1792985558;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n+xQAV+h4O3H+drN3Sggr/lxYZZZqiuYT8sgXuwudPk=;
        b=DqlKKlVk8Psyj31vISY5XZp9nd1+iOp5ea9nmu1mXplIdkFf4nz5Q4eH4uT3Kmffrq
         b6dSWQNM0T5arlJwhsPSaFfj47mC7LYlEfouzpsV5dUScg9+wc1mbx2wSV0bAC17q2V7
         VhLqQDl4lks3R4MqJHusstlMWJ+iJy4P2n42pKKRxgp7V4n7WnZUxhK7UNxQC9c33skD
         Oz04objL4t5MOdA++QR7JFi1VU1W45kTvj80iImI1UnTuK7cvK/gGoYn0FXBylIkic5v
         6lipqx9er9qyUhXs68JCFir0n7HK8KU+icKqFMj2sDMqG/XXQJWQ2yL9r9j2iWxvAPKK
         3NpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFiP/uJj4sMsb669f3rOeTrhS2yFWb9sJhNDdONfGxiT6zd/k+pNo2vetBSz/yeCxovBo/QmYQtPEF0H4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIx9XvGWEkEHHhBCAiq0jzl+3lT34qKkDFhNSwTCP8xkBpDyZZa
	ps8g+GfpQ5YfeyyXY5v5xtA6ivcgdPDupnnG1NDONEl6kVtDXLT+h4+JkuGP5Zi92pjbYWrNiqQ
	T7yi23YhaHh1RyeHHzPJy93qyOJxq1j4C5ruqLbO0FW97U9+BafuZU+HCrPqBYbNu8N2S0h3+H+
	o=
X-Gm-Gg: AYBFou2/MAejoaddAQOjoFxcZNsXcsz3vI/62fMWG4dG3S6xikj7kxNYzdwE5EA0QsQ
	r9P1i0bR+SvdObDCzI+6xa2c/TeiwxWzvdfdPcWdKyZM12sMgYAbOX8ysrqzb/uZ1oPxrNEAZ0Q
	SpA1ISJITo61DojFmWQbTbi/q7rbE5gkMWvqU1Xypmog+d4iNemqnFuvucfFDo++LSgQApcHfhN
	UVoFADHdrT3ZaJDqp3RqgPXMBqU0ltFlHDSt+0PUyp3ISQdeQsL0s3ulflcrfOEibBP1YVC7bVG
	+PAel9F36SqscLPzDguMev6sV6pfNvtyE3TacTcJetmNFsW9lLV9wzFznoZ1QXrqaTdkSLPbwcL
	dPmmjkQGwm6GGCPX20MIVzi7TL7bIn7yK
X-Received: by 2002:a05:7301:2727:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-361a1865981mr9545972eec.9.1792380758371;
        Sun, 18 Oct 2026 20:32:38 -0700 (PDT)
X-Received: by 2002:a05:7301:2727:b0:343:fb75:a5f2 with SMTP id 5a478bee46e88-361a1865981mr9545946eec.9.1792380757689;
        Sun, 18 Oct 2026 20:32:37 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm34893765eec.20.2026.10.18.20.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:32:37 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 09:02:24 +0530
Subject: [PATCH] serial: qcom-geni: Add tracepoints for SE reg dump
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-add-tracepoints-for-se-reg-dump-uart-v1-1-1fb47b1605b9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEeP1WoC/yXNQQ7CIBBA0as0s3YShKYNXsW4QJjWMRHIAI1J0
 7uLunyb/3coJEwFLsMOQhsXTrHjfBrAP1xcCTl0g1Z6UlbP6ELAKs5TThxrwSUJFkKhFUN7ZWx
 OKhoVrJmMHcfZQU9loYXfv8319ndp9yf5+m3DcXwAuL+qqIgAAAA=
X-Change-ID: 20260927-add-tracepoints-for-se-reg-dump-uart-30d93639447a
To: konrad.dybcio@oss.qualcomm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792380754; l=5010;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=vtCPb9zV6L5uTrn3PIAIHPOGWAn1ooRRD+kV9nQCxTM=;
 b=KWzX3cPm/D5hzwnetUbKi2UB/XqWCv+3NJiKclDx1Sh9RSdlWmUGPlPZt/oe3ruDAR9KNIyfc
 tj4nG5mJ5CJB2cJsh5DN2juAiHFzu61nyQ2SSWnjDrsD3rbZfNeJ7nL
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAxMyBTYWx0ZWRfXyWPFfM4fTade
 Nwgs6dvbkrEofkQvW1GnEIGSOF381LGfmzDMz2v15m+3U7cP3PKWOJ/Wd7Rn3cVMBTc+Y0Tp7t7
 CmYzkt3nvSsQ1PBfCtYNZuOxQE9jbzA=
X-Proofpoint-GUID: Ok6K_47rnFGssGuL90j7U-iblrKSyuSU
X-Authority-Analysis: v=2.4 cv=Bu8IUoX5 c=1 sm=1 tr=0 ts=6ad58f57 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-I6NzRS75OSQgGjscJcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAxMyBTYWx0ZWRfXzY57vQiYh1DS
 r85VLQ2MmskU+JjAc+4OlJFm3MA/mtpVetV45Jt96LLofiV0eO76yPXq10HKpnumsgX8ja0dmxt
 2rC/uhQiEey2q8Bykm6YA9ot99vZdKLIcjGOUzk4t7kikmLsjhGHBt/il6H2a3bnWmbUmmuEmtb
 RL/43C1CMNLZG6T+hcbf3IQsWR1aiBnjCufWYNwLy4fakxGou6S5AX9lk0Ojc0p314T0l02YPwx
 3lBiw0/3i7vJxxT/89GE5pHYE9Vn+Mp0NaeEi2OhG1h9LPPLlyASn/2Q2Vh8GCasfAtI0j8o4qZ
 noIk6B65rvGcgYMdDHQDp3BAPK+dDplKdk5PbnTQLQsYbc3iYIN3mtf0jk15mPoBxgmmrw4VbcU
 pU0va+hTs1HXmXtHqhpTJy9BIiaiOSteTNG0IvGxjO7IOsTaoyOGLGK9r1L4IUgMDqf2RRc70OO
 HSonyUeIHoRcsKYMb6Q==
X-Proofpoint-ORIG-GUID: Ok6K_47rnFGssGuL90j7U-iblrKSyuSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190013

The GENI serial driver reports various transfer failures such as
M_CMD abort/cancel timeouts, DMA TX/RX FSM reset timeouts, RX FIFO
write errors, illegal command interrupts, and DMA parity errors.
However, diagnosing the root cause of these failures is difficult as
the hardware state is not captured when the error occurs.

Add trace_geni_se_regs() calls at critical serial error handling paths
to automatically capture GENI serial engine debug registers when
failures are detected. This includes:

- M_CMD abort/cancel timeout
- DMA TX/RX FSM reset timeout
- Unexpected zero-byte RX DMA completion
- RX FIFO write error and illegal command interrupt status
- RX DMA parity error

Dumping the SE debug registers at the time of failure provides
additional hardware context and significantly improves post-mortem
analysis of serial transfer issues without affecting normal
operation.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index bfdc155c128d..34ab80e8cdbb 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -7,6 +7,8 @@
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
 
+#include <trace/events/qcom_geni_se.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/qcom_geni_serial.h>
 
@@ -811,8 +813,10 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
 	if (port->tx_dma_addr) {
 		writel(1, uport->membase + SE_DMA_TX_FSM_RST);
 		if (!qcom_geni_serial_poll_bit(uport, SE_DMA_TX_IRQ_STAT,
-					       TX_RESET_DONE, true))
+					       TX_RESET_DONE, true)) {
 			dev_err_ratelimited(uport->dev, "TX DMA reset failed");
+			trace_geni_se_regs(&port->se);
+		}
 		writel(TX_RESET_DONE | TX_DMA_DONE,
 		       uport->membase + SE_DMA_TX_IRQ_CLR);
 
@@ -923,8 +927,11 @@ static void __qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 	if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
 						M_CMD_CANCEL_EN, true)) {
 		geni_se_abort_m_cmd(&port->se);
-		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-						M_CMD_ABORT_EN, true);
+		if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
+					       M_CMD_ABORT_EN, true)) {
+			dev_err_ratelimited(uport->dev, "M_CMD_ABORT_EN not set");
+			trace_geni_se_regs(&port->se);
+		}
 		writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	}
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
@@ -1006,8 +1013,11 @@ static void qcom_geni_serial_stop_rx_dma(struct uart_port *uport)
 		qcom_geni_serial_abort_rx(uport);
 
 		writel(1, uport->membase + SE_DMA_RX_FSM_RST);
-		qcom_geni_serial_poll_bit(uport, SE_DMA_RX_IRQ_STAT,
-				RX_RESET_DONE, true);
+		if (!qcom_geni_serial_poll_bit(uport, SE_DMA_RX_IRQ_STAT,
+					       RX_RESET_DONE, true)) {
+			dev_err_ratelimited(uport->dev, "RX DMA reset failed");
+			trace_geni_se_regs(&port->se);
+		}
 		writel(RX_RESET_DONE | RX_DMA_DONE,
 				uport->membase + SE_DMA_RX_IRQ_CLR);
 	}
@@ -1048,9 +1058,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 				DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in)
+	if (!rx_in) {
 		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
-	else if (!drop) {
+		trace_geni_se_regs(&port->se);
+	} else if (!drop) {
 		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
 	}
@@ -1223,6 +1234,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	if (s_irq_status & S_RX_FIFO_WR_ERR_EN) {
 		uport->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
+		trace_geni_se_regs(&port->se);
 	}
 
 	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
@@ -1246,8 +1258,11 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
 
-	if (WARN_ON(m_irq_status & M_ILLEGAL_CMD_EN))
+	if (m_irq_status & M_ILLEGAL_CMD_EN) {
+		trace_geni_se_regs(&port->se);
+		WARN_ON(1);
 		goto handle_rx;
+	}
 
 	if (dma) {
 		if (dma_tx_status & TX_DMA_DONE) {
@@ -1270,6 +1285,7 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 			if (dma_rx_status & RX_DMA_PARITY_ERR) {
 				uport->icount.parity++;
 				drop_rx = true;
+				trace_geni_se_regs(&port->se);
 			}
 
 			if (dma_rx_status & RX_DMA_BREAK)

---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20260927-add-tracepoints-for-se-reg-dump-uart-30d93639447a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

