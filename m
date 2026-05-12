Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058613D9681
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606066; cv=none; b=ZmJWxFBZ5kQaCdbJj61NuKC3X79Xa/WAbzgTySG0gU92sWzurfYv+j6M6yfFQ+Awx99vPVzRWb6ws/Rr7HL6116ZSy5/Vkocqdy9ICBaCBb8HTs7DROlNiCM5E0GtaW6/1LLuBzhEWaeScg8YZDZHk4fNSJj5ZCB7j/bje5DIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606066; c=relaxed/simple;
	bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhRJpSsvHhz23t+aORPMyRd5Womv9Pn49z+4R9+5FnJkp3/IULFA2Ubg1GoOAx9nEleSYJe5v8wjP/LyIQY72LtCEHNG26+mZCLDmVTfD21q7r3e8okMrYrRoIhj2Bnt86M50FOEcICTaeDUDsT2l2UDN8wBgedQ2qCREJNUkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SoxZUgwW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XExmD+Vk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SoxZUgwW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XExmD+Vk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CChAqO1410273
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=; b=SoxZUgwWU5PZ3/XJ
	dhdbg8AdK7tiX7oCDXkC6Q+CPCkh0+JlCjXzymUNd4n8enaDDHKRV3Izjd97nLHT
	6nNnhWr9otJg83vLoZxI/fpaU0YEY1VvwQ5xl6UGbcMpo1bx+4E4SmB9JW/kI6zg
	4WontDoO6MsFooza7RVVaZiwpvuZnN8pN8EHnYVoMrlUfdFtYOZAC/y76XTgrebn
	tWX46tAHsSwJp+zcfOgL8X1vqpqNUzonrwvySlsyl9pRsVEwWlwvjennP5G5UZU+
	muSp0N/4IxScFeOJca4JqUtFCq1f6d21UjpugpvlwJ+p7tZFy1VRKK8+49KMAPaE
	RsM75A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f312hq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4678c6171so60508525ad.1
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778606063; x=1779210863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=XExmD+VkiPxm/1Yxie5gmHDfLqyzRxrI3z+pb/Bz1JMuEgaFPxK8PoBcfhpbgZ5vXq
         Un9omG32VEtNLbpnaqxEmfVTb1pO5gFvBX8MZceXFNMbMr1p1xt+1huQKJ38hwlJZk5u
         pBEdH5UJNRq5nhu93NNM3eB+fNYrLDXmtW3dJK2/OpGMbeVG7dInHvvLCTn/uOhfzBXZ
         1MqzQ5UrteIo0pciC3IdKsHOq5uru71nkeYF83psV7HrWe4Qge8UcS4v8ojK/Zq9vHDy
         kFBtJc0DDBBCS+is3DCAO7JlNvBGpwC1yJJcOGOU19fLjRzJt0V3SRCVg6n/4BCtGWWC
         bjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606063; x=1779210863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=X+RlJuVv0Itz168c/74qss41h1SeZKv6QNadd2BHbI0pXftqoIu4S2O5Meleo7ovml
         MGX66Z+WTqrpTk5NCLueLm7FRRnzWrhU7QqWwJHp+49+BRGcawCVNlLU3g6Dg80XrS4e
         KBYK6kSAk9d+7Z6I+9joCRoaKaiVEbjQUIESwJY2FYpTJ9f8wnANzR6plUNBOICrScmC
         D49Qdb5p6iYt6jYwX2hwAi5nwYr0+tWkpMzbd6QvxlPo3+QwTMGfi6mJ5MPyWgCbsaRu
         f+AIPcRMjdZgJyPSHF/TujJhECrY4QZpp8CVcIRzrtGEeDvx0sphgP72tjL+K1kZYYbJ
         5/eg==
X-Forwarded-Encrypted: i=1; AFNElJ9jZBfOXjPj7Kq7HYhEonpwmB3tolaFSVqDyS7hpO59tNHXDIWZ8TUVaIOVbHBnTSv3WF2CbKidQic9KrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaJfC53bkNP8Z4EXd7JTHa8GA1oH09RFEQ7nmr+LT7jUcQe8a
	OlPcJlqVhxyFDM2U1ZBjE2Vibu1D86/C80x4DdwId93s4TlzjKtIYONw3LrOpxsoX4oXCJHG8LL
	OwvgAmeHFfTySJLKi13TaMJ2T1dFHaap+NO567b2eQD6itVzyN7Ve9MjVJEj+fVtx0SQ=
X-Gm-Gg: Acq92OGSvW2Y7sSD7u5uknA0dWC1PFLY3k1tGTOFeVh3o4SigZwXBu9OmZgkDmhuSIJ
	chm3nwdTKxJgHZq5TcLe53P7mrxGNlkTktyuuJQ6S+LVGa8QK72iIGdooCDQ3nVQuoEdSDm/dP3
	R0/4QArTBJL8U3o5yjudWbVm32qKMAnh0KCDUzsSpcR23792i4pSDrD4DAuL0HoX9h0tJ5/5Msu
	sGzWSKBCU8zlGxU7hDOsU4HlMW8rvTWGxWRf2ETsyulx4UBQBpcydQugtFq3P7g33uYdOca5y08
	maIIRik+HkN9C2sr3Evgx1Vh7gP0WiK1ODREktLPbQYdeDXub99uVzNe13PkKD95+qeIQTOvWDY
	B3iPbKPeXcOh7vSsINJ4HlmTSE3m5/TNPxkbNcp6xA0pywBCZHGYi8iI=
X-Received: by 2002:a17:903:3bc7:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2bc7ac7305emr157039125ad.36.1778606063388;
        Tue, 12 May 2026 10:14:23 -0700 (PDT)
X-Received: by 2002:a17:903:3bc7:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2bc7ac7305emr157038725ad.36.1778606062723;
        Tue, 12 May 2026 10:14:22 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40427sm149996685ad.24.2026.05.12.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:14:22 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 22:44:04 +0530
Subject: [PATCH v2 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-serial-v2-2-a5726421b3af@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778606047; l=5509;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
 b=edNqEIQASRPfmCjJJ76xPFTodkyNIPwMyvZj8qPhFLmYKe3Df+d09/fEWq5af5duIUgvcmKmj
 DTwBZbqVdLTB36fsAa5Bz122lyRjz3k8e06oqcO/sMRYsj0vcLrG4iC
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: nTpSFddU-O6BWZcJFQ7UCjBP2wryt0q5
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a035ff0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9bDMwBodl1-tA_8t4OkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OSBTYWx0ZWRfXx154bJICSzoO
 OZ0r18P+KiDTj7NScpJPQO68u9cx0eR8fSf+KQEkUw6fnm/+dSBupC7gchI6GMIaBu9eeHkgNks
 Ue8XrbXmsJVFRF3qMRVYPreTxvUicvDHqsiJWmkEFQl0BmbNI/EIdgsBPwS1UKEsacyddcG6Tub
 37R7zqtdm+0RequZpc4FO1/XauE4CvHbS6IkCd2ce/ZgavCIDGUxo5AyC3gssn+4JlGLolnSl9T
 zlniKPBDhPwOLmux5iuk8dV/jK6/teBDW9glwfAToNv7TKlizYETULx7+oI/pkckRjAZUdwr/D6
 CD42DVQbDZjt6tPu1Kv9GPpJEN4tUq/cLplxcNTsgIDXi2TZ1cAZyhwLUiFFp6z5ryQ2o9c5fx/
 T1rALh03nt1iYflFINS+CjCLls069/LqvRMiAPmv2EURr4xy4uA24ddyz6E4wNkvvp1M+1eFRJG
 4g9dGlEDiFWVg5zzSbg==
X-Proofpoint-GUID: nTpSFddU-O6BWZcJFQ7UCjBP2wryt0q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120179

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

