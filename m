Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297E3F9F50
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533038; cv=none; b=iXUaqo6SFaSJ6FkE4JNi02fnPcpLo54jjYXYVjSupC4D3NG3RXJ8OrrknccwKt+ZkT1OZ1T1WSPNR0mACxog33o2dxnWona0W9QD5xkFHRsTLso8v/zPhVMR1b7eBd/sYZJgWxT3L63BymbIumky0areXPMIZyqW5J20Vg4/A7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533038; c=relaxed/simple;
	bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF/gkj22WeGAZztIaaf6vnMGcMF9+D6DLuBO0qVvVaySkaFV+6NUqWb5UagyxwM/xdf1FaqWAddwF++JoN5PpcncOa2dN7BI2f9FYWNW3gTD1N9rUr2L3s3NEJq+ka+3QRu1O2CVzsGOxGynxSTfN4njpSC213Zu2bZkB0GdhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJmt6HOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4vAyvgW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJmt6HOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4vAyvgW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZa3s4116605
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=; b=UJmt6HOi/rwRra3t
	l8sp3S4SBw4CBG7/oogEe0jOCglWUD9Wyay1ePvVTVrC4m4S9C+3QPQEiYk2C1Bh
	7acHVV2/bed6PEr7p4DsTv6sRHj1olZCdd585/6Rzui7TLXj6wkNp7iA7LMCZUMK
	QXbstIGi+U+8thXf68JzSaxUlBl50rYxap72vUxwabEsFnXzbZCjAYXrTNxBl1U5
	+jxFsBVC31EE/fEdEjxjw/jASWeEBv6a77EnNE+P5qLJmnC4bbcXeeSYCCpuM4ov
	0858wR1WVJs+iQbelDa8WSvl/6Xwshud2VfoOvDL8uRMev+REPj/Ac2kE+S1Mowe
	DYPHvQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjs4eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf08c2a24bso34189215ad.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781533035; x=1782137835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=A4vAyvgW8d4tSA1qG9WHBJKH2rDZtVdyRVCJV0ZTbCM725BxdSaCpuGPqsbhbLJM9c
         gyO7/oBgc0mSKyGNlUmspys6DPw2dA0b/h0L/yLuzwczaeNtYBAwgcWmipDeoTjHH6t6
         eSZ6z8TDJ6E/0jEOWOMx3omQEGVVQlc3p7Rv4qNfGvsm1vJZWV691EdyvuC5nBgNVOf9
         coV28PYhqNko0J4ujE0G+EiOiAiD6yPpzoHyvcM9FXeZGqvqOr/A2HzQDVAioI1vaX/P
         AS+YUGziPWSkAUJoqMxGDDw+Sk1c9x6Xti4OtW+NKksDj4HMYt1fHdkPIsa4PPT34rjI
         VAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533035; x=1782137835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=n3qbYeiuRcV34jgIJMz0zh8bPajuBm4gxkFxCoJq+DEDNICyUw/rzu6tPyfcGV5Vha
         BxOHgpqbRHW8KienAMFrLXW68dyRw4CWO+MLKQGB2ezJ7gJ93ar3x2G1Eg1mHEtO5i/L
         R8dt/p/YIQXzVEdWXE/kQLujo6oFvqtW/2Jj942MbLd2BNLICHl3va41KDMAf1/z3BDZ
         6N4N08rOlQpePTw9D5M4mF7Zckm6BfuZInUhG3onV/jETnMH2rRZdvWR7vhl5sab9OzH
         7PPfEeDRrpBusfpBeMCmYFjLm+twNaOmku8/9MoqSUTVJasyTQwJcPy1eUy4fYgSGeP1
         15Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8uDmrQkHTVwvUOFFxMo023q8Hgn3MZ00BzOMzE6qjgzo1gJ6a/Z9fq6zjI8CzvXv4yY4Isd5a6tSFqYXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLO6WKDYBMoCcRCGxolZRsWutWa2B3jz8t8XLyrqnJa1j/wm90
	apWlpOITaG9G1sdvsGlHZ4iWxBxjSP8Xv5kMWTb95T9UkEm7QlpuqJsgdM+rRsJ/jqDsHvpp0k9
	mFy7nS95xpoUZekgFB6DKVYsrkzYQS8kXNY6NrcZq5ZAiir73JWCxI3Gcqec7ZUD3sUc=
X-Gm-Gg: Acq92OEdZ3dSi5nmaGedR2fZ9KxzdcDVYvtOnKIzfaLd2Hh/Pyl5rvXCwlRYCSPmKD0
	JOsuimTXvo12q2rPwNb5dp87dMagzK6QAnr3csf+4WYiS9BNhmQN2MbuRd82Hcc0oi7GgfM3Lz4
	QG1CRD2o7O7uEgOO8TYZmPeU2btBIlihehJrPLu02giXcNi1v7UphZ2nYeCkcbqNnUu5lgQ3Rhq
	mJW4ipexKTWBncTfssNF25wxwYKqLvr6EREnXHLD5iLc07SweKpsl/we6SMCHoob/wSuYUqj159
	M4A083Uf6qgRBBMlTqk9CpnvC18pr0e3GU4iXQLQoVS991m49qlFKTSrJvBBwM3cHXl65IIQ2qq
	0GSi9nsRvb62xauwfbBVOO8rxu7jiMecz4xSb9lkK5FrYrykctHSDSTs=
X-Received: by 2002:a17:90b:514f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-37a0184a3bemr15713046a91.4.1781533035414;
        Mon, 15 Jun 2026 07:17:15 -0700 (PDT)
X-Received: by 2002:a17:90b:514f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-37a0184a3bemr15712968a91.4.1781533034731;
        Mon, 15 Jun 2026 07:17:14 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7172476a91.2.2026.06.15.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:14 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 19:46:53 +0530
Subject: [PATCH v5 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-add-tracepoints-for-qcom-geni-serial-v5-2-2efa4c97e0e2@oss.qualcomm.com>
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781533020; l=4256;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
 b=qTbvMsUOC65Bt7ZLTkLfW54/qFSjUxfHmp6BMI0qwDqiP42Ml3uTZGq2DsyEV+gNq55q3IPdH
 e6PCr/CrgyGCOLA+sYrx/D/Rywd9phNURw0u2ZI1ocRUpjEirRPcvKo
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX4TdTHaeFgWPT
 SewsrS+vbwuQxET0DVagoZ+1Hpt9YeufVH9RMVyh2ZqOf5r+eYTO6sW9dK3ZYRcqCuVhC7ZTeOZ
 khegml9Y88JJCE7pRp5yrdriEVJBlSAAmT+iNcMeWVLrf8zMG/7phAagsR61i2S9VFvTsbPNfg6
 FtgetTgIlewk3V7GtdvS4KinPq5O9h1kiF9q5OFLviETedRO7SwUSQU87lgyEWPwMHBc8o0xdbm
 gStfl04oq5bnKlulW16DKY83J99uFWZx3eS5rPqFWoW9OxygR7SCspYzkOu/Gnq/+U5ByssfELG
 hv/JMOHZcCmOxKrlWi7sPcbVpEBAONsfORpbfo84GagG3gGINM99yqN0oFAdYVCSUOwBxOlbipg
 lI/Oey9o0MKcpfeoUv4V/76fjWAaX84wX2JxNjjuLWmsQIc4G2eqx+3dm2hNoVHW+CCfDNaYY0r
 J+GWsyrdzc6zARnMlwA==
X-Proofpoint-ORIG-GUID: jAaj27krGXkKh13soTZIop3FSBLSXw6M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXx1HAK3aJQUgQ
 eaHk06BF/GUro2OhCRsIoEZwyUEJFNjoMEhaoZAfDiP1V2kNhTRFSQHhOkgz0kDbntP7lLfyhGI
 WHxWk2NXjOkFFvrLshuTsSBC+kfHVPI=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a30096c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KXSloCXmEunfo-Xy6rIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: jAaj27krGXkKh13soTZIop3FSBLSXw6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150150

Add tracing to the Qualcomm GENI serial driver to improve runtime
observability.

Trace hooks are added at key points including termios and clock
configuration, manual control get/set, interrupt handling, and data
TX/RX paths.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Updated commit text(removed example as it was available on cover
  letter).
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..4b62e58d4918 100644
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
@@ -226,7 +229,7 @@ static void qcom_geni_serial_config_port(struct uart_port *uport, int cfg_flags)
 static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 {
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
-	u32 geni_ios;
+	u32 geni_ios = 0;
 
 	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
@@ -236,6 +239,8 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 			mctrl |= TIOCM_CTS;
 	}
 
+	trace_geni_serial_get_mctrl(uport->dev, mctrl, geni_ios);
+
 	return mctrl;
 }
 
@@ -254,6 +259,8 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 	if (port->manual_flow && !(mctrl & TIOCM_RTS) && !uport->suspended)
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+
+	trace_geni_serial_set_mctrl(uport->dev, mctrl, uart_manual_rfr);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -684,6 +691,8 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
 			UART_XMIT_SIZE);
 
+	trace_geni_serial_tx_data(uport->dev, tail, xmit_size);
+
 	qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_ON_SEND);
 
 	qcom_geni_serial_setup_tx(uport, xmit_size);
@@ -910,8 +919,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 		return;
 	}
 
-	if (!drop)
+	if (!drop) {
+		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,
@@ -1082,6 +1093,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
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
@@ -1294,8 +1309,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u, clk_idx = %u\n",
-		baud * sampling_rate, clk_rate, clk_div, clk_idx);
+	trace_geni_serial_clk_cfg(uport->dev, baud * sampling_rate, clk_rate,
+				  clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1455,6 +1470,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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

