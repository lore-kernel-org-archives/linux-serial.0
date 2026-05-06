Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39438317170
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088314; cv=none; b=JQmGGHRdstIP7wRztA++SvRvR0KATP+5a7+SPaWwEqINIL9pwEOJ10aN2sTzPn8iCAH9wbNe2GITI16FW3ZnCGF7giezKnJUtksn/1kbYwmbUzgH+t/8PrGbcOJsDVeEkGxi1l07aRXbtKB/jwwcq7MMOBexB4i7boZtYQTq0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088314; c=relaxed/simple;
	bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYDHEG44P7oj3D4HtFJd00YkJYhFTRcKv8SE4dj+WH5pcxrdDgtXYdGHNsFZKsMm39p/Mi/Hg2Q5a/V9FihnLqehjP+YfcgqG7ICNydNkIB2GrgTpk3rcKuWsX86f/drhX5DOy/BIov+itijNSNBi3RjDQb96C3y8+MqD4m00Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TN1d5uU3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cET7oj2b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TN1d5uU3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cET7oj2b"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BECfF2581411
	for <linux-serial@vger.kernel.org>; Wed, 6 May 2026 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=; b=TN1d5uU3sCBiDNNJ
	1XzVn2ywIKnm/OGFsmeBbC0O5pUDrNHinTm7auznIXkFNfEnG5bz9yO19bJPvg/b
	wX1R1H5bUR0H58vvgVF/9g3TdfxpXSQKimmR2Co04TY3YlaqNbYJzYRhu314wKDs
	935I+6k/iE7Vt1gf5azv6+HPKooPcPM0vjkw6StA3NOaJqy5/YYwcw+Pt95l/f6T
	S3Yi3fABVeiQQDf2BFs9V6ZrbVdxcvs0qa8pyMdwvbCbtGwz1ZKCBe+2/03bSyTO
	DFI8Dt3d++N95rwTYESia8N+TnJNpCHCibTkL8bUUgX9RZWKq5ShDUBtT261Bx7V
	jf+Xzg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw2pna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 17:25:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36521936155so3672621a91.3
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088306; x=1778693106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=cET7oj2b6RiH4ZKyO/xMeAUH9QQt3Cs0A0DgQCtJOrdN792N/kMFR5bpt1dCzXgm5e
         9EAwThLBTjdbQ/5YnsFDxQ3PaoKrzvFSfr10E3LoMLN0VyDwxYlFlNnzjGi6/+Ue9XrR
         T78bXfLVVZdEDuHi57QhMiqmbvqYU6YqO4IXA5C925OKmrVchnPHyy1af7bgR/gq8G3v
         G5pjrvpdcy68Ubxj2pazknwBOcX15aIjJ8svKVqNZpj3y4bGHPNRgS4hbDQbkjMOIZTq
         wcTr6RQR8RsC1wf6ulSXPXptUBWlyLzlKUVBM4571qFBrKxJKPCEjth6TcEygKSm9UvD
         trAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088306; x=1778693106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=RN9xUW9O+UbA74hLnmVVwCUNZaGmDOe/6sVo6kIK7UjLSlZyuQoxQDPYyoH5l8q6HE
         YVxpUXhpCEudTwv5A4gz2WmlE4PfeOT1v+tSjyLlyk3Tnju4QK1ItkOzg6l/0lXOqYno
         Gk8AWQP6rH8gL4cTuv15e504vGXniPCjmgefP+leRXQ5MwMBqwxKR3XN2cN0qBHzh37r
         5bBFqrsBmPJYxkIarzrINmzK9sFc7erVSPHzhZQNcFHjubH79cwtUM4pXWXEmWAygFAV
         U9pAkvbegwZXaXnEejD7d1X/Xe0Dtz3rH32715yPQisnE5cFOtraGj18qXyb4Bd9KfJe
         NuLg==
X-Forwarded-Encrypted: i=1; AFNElJ+uGZ5KrreVDp90u2RtNg3f99z19W/8YA50JeuECAy3pGLpo09P5re/9rLx/ZzAsoErhPddl15ySRjP5IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjJJilH+HDgFkfYrvBAGvJVAcgPNeBUYPG7K1J4nBVjdr/pkA
	w4K5CvNSsnmhA8l4Ihh/TkxLPYkvU3jC60XYUWyniSXv1kP/2Y5Sxt90wJhyHPw5quwDUfxvuVf
	0EWP8CQCZIL92f7XDJnliPap4TU81xesh5E3mEYi/4hCaEa0w1ejamv2ixm9LNFTI/78=
X-Gm-Gg: AeBDietG3kRQaOqoV6y3lBVIdIwPMQmP4AfIIXS3gU5cmOHp1T4gHLEgD+ZZV4kt/op
	ybeHoVGKOAbiXUg9Scfyw7cJHACOvG1flmbjjLlontb35n6NQZFFLLGTykoBK8KWi/TXbzo654X
	1BUZsiaoEnvkhfl23eeuY6Yw+U8Opil6FYwcVlvn3xrntaO1Y2RPwVT7V+KSwaJa/i2DseuMQMM
	6A0NKgGc1+CUxEcKSiB5OhuLss0he3kYNemFggeiGLwpYjSB0hBmECU5SuPY//4r9vkvJxne5pH
	0KqOGW7QSwOZDkgtI2zSPOz47wcIz4sF78Nbrnpnd2Gp3KtsbfDq2SXOGzBHBm9WF6vDRfI6nJ4
	EP+ANUvNNcYnh1c4zuJalrizlbZW9YkOxR7u1GLIzGBL0IUzpXbQX4NvRA0U4HH7OmQ==
X-Received: by 2002:a17:90b:3c8f:b0:35f:be11:b3e0 with SMTP id 98e67ed59e1d1-365ab9b8135mr4565375a91.2.1778088306207;
        Wed, 06 May 2026 10:25:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8f:b0:35f:be11:b3e0 with SMTP id 98e67ed59e1d1-365ab9b8135mr4565330a91.2.1778088305575;
        Wed, 06 May 2026 10:25:05 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c9ad13sm3051948a91.15.2026.05.06.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:25:05 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 06 May 2026 22:54:45 +0530
Subject: [PATCH v1 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add-tracepoints-for-qcom-geni-serial-v1-2-544b22612e08@oss.qualcomm.com>
References: <20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com>
In-Reply-To: <20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088290; l=5509;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
 b=KfFd0y+71+XaxkJepYBKHqRiRmFWd2/gTlbNof9M4vUEV487vyTWZtoqd0oB0Bfb7QZrlzIQR
 UmcPo5RhJzyBSx1NazrRDNsYU7eAJ/+qzndXxIzhfZPQ2z1dR8jFegu
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb7972 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9bDMwBodl1-tA_8t4OkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OSBTYWx0ZWRfX33n/sRkThENv
 aC/T3DSfZxgNxLSA3myURwJsbWkxKGfAt/Yu96l9LyLd0iIM++0ZT+gq6iZubuGcH7zw0ZGDrKD
 h6PB5LnPzlK216+4quGtvy3ndsvN8r/KtVNPIP7M2NGVMml7ORuHDFBaloT5GzFNmJZoiYnychK
 jP5gBeAPpkvDCh28dKpLeHlwBSeiH6m86Gf8JLL84c6ZyWVg8qvDT13KfnTgucTcCQxWLt0oQI6
 c2f8vw1NmhKr3mQZWX+TZzrsChaHNya3UGD5iTGukExHmRjkvc3wy2xVGcQBtz8nlJLtMVpPQPr
 Xe1Hsk9DdKT1HC/EhrLgjNQUzsG+IB0y2LNfqlg7JgYLFTNo8yA/ABGwCl5ewf97WDq2QLxowR2
 5+zQvJ7qcCGPQ4tLb4B+9/HKfd1f2MRxiKbBWpkZMYv4o8HRtwsPvmxg5dD89iclm/cBK8QcFK5
 ukxHbMAMV3D1KajOA6g==
X-Proofpoint-ORIG-GUID: sTXIpvokdK6SEh3qTYa-hn1UterjdJC9
X-Proofpoint-GUID: sTXIpvokdK6SEh3qTYa-hn1UterjdJC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060169

Add tracing to the Qualcomm GENI serial driver to improve runtime
observability.

Trace hooks are added at key points including termios and clock
configuration, manual control get/set, interrupt handling, and data
TX/RX paths.

Usage examples:

Enable all serial traces:
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_serial/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

2517.938432: geni_serial_clk_cfg: a94000.serial: desired_rate=1843200
     clk_rate=7372800 clk_div=4 clk_idx=0
2517.938753: geni_serial_irq: a94000.serial: m_irq=0x88800000
     s_irq=0x08000111 dma_tx=0x00000000 dma_rx=0x00000000
2517.938803: geni_serial_set_termios: a94000.serial: baud=115200 bpc=8
     tx_trans=0x00000002 tx_par=0x00000000 rx_trans=0x00000000
rx_par=0x00000000 stop=0
2517.938807: geni_serial_set_mctrl: a94000.serial: mctrl=0x8006
     uart_manual_rfr=0x00000000
2517.938818: geni_serial_get_mctrl: a94000.serial: mctrl=0x0160
     geni_ios=0x00000001
2517.939165: geni_serial_irq: a94000.serial: m_irq=0x00400000
     s_irq=0x00000000 dma_tx=0x00000000 dma_rx=0x00000000
2517.939592: geni_serial_tx_data: a94000.serial: tx_len=8 data=61 62 63
     64 65 66 67 68
2517.940610: geni_serial_irq: a94000.serial: m_irq=0x00000001
     s_irq=0x00000000 dma_tx=0x00000003 dma_rx=0x00000000
2517.942174: geni_serial_irq: a94000.serial: m_irq=0x08000000
     s_irq=0x08000100 dma_tx=0x00000000 dma_rx=0x00000003
2517.942323: geni_serial_rx_data: a94000.serial: rx_len=8 data=61 62 63
     64 65 66 67 68
2517.942680: geni_serial_set_mctrl: a94000.serial: mctrl=0x8000
     uart_manual_rfr=0x80000002

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..9e2de074d799 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -7,6 +7,9 @@
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_serial.h>
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
@@ -225,7 +228,7 @@ static void qcom_geni_serial_config_port(struct uart_port *uport, int cfg_flags)
 static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 {
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
-	u32 geni_ios;
+	u32 geni_ios = 0;
 
 	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
@@ -235,6 +238,8 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 			mctrl |= TIOCM_CTS;
 	}
 
+	trace_geni_serial_get_mctrl(uport->dev, mctrl, geni_ios);
+
 	return mctrl;
 }
 
@@ -253,6 +258,8 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 	if (!(mctrl & TIOCM_RTS) && !uport->suspended)
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+
+	trace_geni_serial_set_mctrl(uport->dev, mctrl, uart_manual_rfr);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -683,6 +690,8 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
 			UART_XMIT_SIZE);
 
+	trace_geni_serial_tx_data(uport->dev, tail, xmit_size);
+
 	qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_ON_SEND);
 
 	qcom_geni_serial_setup_tx(uport, xmit_size);
@@ -909,8 +918,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 		return;
 	}
 
-	if (!drop)
+	if (!drop) {
+		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,
@@ -1069,6 +1080,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
 	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
 	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+
+	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
+			      dma_tx_status, dma_rx_status);
+
 	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
@@ -1281,8 +1296,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n, clk_idx = %u\n",
-		baud * sampling_rate, clk_rate, clk_div, clk_idx);
+	trace_geni_serial_clk_cfg(uport->dev, baud * sampling_rate, clk_rate,
+				  clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1432,6 +1447,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
 	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+
+	trace_geni_serial_set_termios(uport->dev, baud, bits_per_char,
+				      tx_trans_cfg, tx_parity_cfg, rx_trans_cfg,
+				      rx_parity_cfg, stop_bit_len);
 }
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE

-- 
2.34.1

