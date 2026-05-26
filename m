Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7141B36A
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817081; cv=none; b=dzQuc9caO4+kmyovId1zCug9uqhV/2sVKktxGyIFKgHlzs44S9nwDjROMUFkgHUy0jF4XnU2oFC7t8r4/Vv6DeTusBiGA3McQdUFvTe93MpeNUYfitC2G1cHf9tCagWftc/vhdCzneZFokmvfzF1bUFNJC8OO2ve/emlctMqDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817081; c=relaxed/simple;
	bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brUtTX5CBKBoazUAGoi+U2sLwpdCBfPumUQ93ZqGjhK+szpDTFxhR0RIpSWKdjNZ4byu5H+Tzekhx1GPQJ91haIwiuYryOceLIncz/Mv8pAJusnMSnX24x2BeHy38Qz2D1EhtqyQPpPKq8Nc3u6SVxkZZu+f5WF5jRWvWdfckSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH/ftc1G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jL/grDhG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH/ftc1G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jL/grDhG"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH0qXw195353
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=; b=UH/ftc1Go6WNiRG7
	P8ZitGD+wHJFBCNIrhG93ShLh4eYvKATklbEHd7i6ogf2pp7kjDcPIHvJmnNwhcA
	pSal/sXJMId2vvSFN0e3OOwuH0qTFJTnQPiYPpmI+9zioiyRUGJ7l689J0wjFpOC
	Z5H6DvjPqwMI/Rz/ke8OS7mZ34Q9ZLBDgLfAtr9VeM5aZzuEerp7g4/Ob51ObSP3
	uvmI8I9bWWrVG1b6bW6eMpk9F7/X+7KRps+nBHCRCWN+w96juaRbp0DjbndxYtUC
	GqdZt0BLlDkmEvr05Arf0CTBqMoXzPkGz9GoTfSNmpZbnSWspYKjQ13Blh3xvKKq
	mwKgfw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddd7rwgp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8525f0807aso5269531a12.3
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779817078; x=1780421878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=jL/grDhGC4us7AvtnILb5rGlguwotK2gBLYTZzOHALLhgc2raWouRzlOTU7Selki7E
         9/Vv2XsYatZTwW1nIiGk/ScRQzJwqeufqw7YWTLjhTrmFrDl7jhnN1mw9QE4xNYp8AxO
         WMkAjureVpPLwEjkYDJHdR8xB1+ONKvE/hgG9Mm6RTPaB+tmIWsMzSGENsiBjVmfQvOe
         6Emv7/+LkExzCRYE90Ere7/diA65k7jmu3R7RNXeQ2xnbtOIap2uaVUio28TCANYNhoo
         3YRRCCxtpuwBNnMC0UUNdzpSWxE7voAUoafCrFcrZaKaGdLmL3Gx2DV0ubjHm0i6iKmH
         q8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779817078; x=1780421878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=Xv+Gv5qGzZS6yC12zAlG8ahmglf940uXWJw74VBx9hdsWVO1qtg7/GZXUh1wypeA3K
         hZbpxXVqnu8tU2a3GHdrbMyHREMLmuUXYZayxz98W5hhHca9buKSVu5Sp4H9QukDjOcM
         QIFHR/TXw5KiN72k7Tu8GVWZRIlZXJ3U0kOuft3bHzBNyLJ3gj/qqPrGPdBJwgrtvw5W
         SbX+vLOPaWr/S3jw6uEbPTAv/GBacMnHmV1sIKeChAKsbjmYg0cOBTFg7chmofLXLFAs
         biBcaOxl6qbK4HMSc3QwKb/Yi7NKSeVfTKJ3SX0J0xCQr24Hjrhie92NhlKHSxRJQO9L
         wMCA==
X-Forwarded-Encrypted: i=1; AFNElJ9stYxiBiX43eGJqYfhWPTwHIu7v6UCML15kY6OGSUfFG7sm9xwp47tHiauHzBmrY5+vDONmnswMiyCGPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSygKaguAsceLz6z6UpnVGp5FDUpKXUYlA1bdRyTxBPoC99ISf
	Uj6JEj4VwAS3dKSNszZZfsR1obyRqOD2wf5GL6ucSDCZUHI7Q5vLC+I+xTxZa9h4KQWsZrGFvXA
	Pl4Y1mI7gri37LwJD1lQ/TPMnBq4jOHkMqJjCjepZDSD+dXACAy4kk0g1WdAuYhd2Lz8=
X-Gm-Gg: Acq92OFseqdiXyW2fx8S234uDS2Ss3tR1Ivw2t5Bl1xZrvvrotyhSOkx1+dffZIj/HJ
	WXj+GpAWupNZi9h39e06vu7rYZOCaDyweJBGOV+McMPBjW+mw2y5sb/hGLeacoBPoxXMxiFm2Sr
	fojBsZ0oj/yo/eG826kI2P2rZbCo3VxX2BjmGEU0ydIjFBlmZraXDgpd8Pypi00R+GRfN1RUd4g
	H0Ncipib3+P0lH9px751dLzJV9zd8YoxxbJto23m5+ma7ohgTI37xCrDeOkuXIOfiDGbHRNggKQ
	1B1rn5gXiCpEQHzZOKPLwllcNH5dkdvUyVS8i/V+FSJNpu6Rs3Eq4ok21eqippVFi/mM2r8qj0S
	Iu1Q7JfAE8S+IQdF36dCKi7KlcRcr/hOfIvDtD1V4BkVjcBMPewkhRCA=
X-Received: by 2002:a05:6a00:887:b0:83a:7516:5be0 with SMTP id d2e1a72fcca58-8415f3f197amr18011090b3a.50.1779817078477;
        Tue, 26 May 2026 10:37:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:887:b0:83a:7516:5be0 with SMTP id d2e1a72fcca58-8415f3f197amr18011061b3a.50.1779817077812;
        Tue, 26 May 2026 10:37:57 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841c32b511dsm3260461b3a.48.2026.05.26.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:37:57 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 26 May 2026 23:07:40 +0530
Subject: [PATCH v4 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-add-tracepoints-for-qcom-geni-serial-v4-2-e94fbaec0232@oss.qualcomm.com>
References: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
In-Reply-To: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779817064; l=4256;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
 b=B+01FdhrNr8H2zS6hZLDVdozovxGugFAYbEnpRfGUk2mrlnH3CoqferFlm3DfPXRabC8h9zWA
 319EjkjFMRxCu6AuiQJkRJ+vXYD3MveQrlKjWrs1Vq2HBfl2ZCkbV7H
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1MyBTYWx0ZWRfX7NzoiklBH1dO
 hKHYui3viM+Pug7H8dgFrKFbzLtrqI6NJRnD4PyeVADCiF6I/5AjcJfyea8YopECmAECo9rzzOw
 hDbZtNbaiKeLaMObEO+NmO6kW06I5nkL9o1E+jLSIVpXXLdqKFRv913tPkyfxTje5m8fN0STrMq
 yLMvgv6IXcgL9Ax6qDyXS0LFJLTKPLJyFbOcI97AnI/UDHZtWLW7oJYJmOKgipDwRVGmZWJbs05
 n6XlSkyd5ZSTUK6cVd+KSkeAEUzHLWiwTdbyqy9OoJArwMoS0kiuaoGZ3dlfQ5zs1+hCWGes4b7
 J/xF2zir4a+PiBhyTGDrYruPmPwCxLEgM5JYknagjnkDivIxyrl0YJhnE6Govuk6OPktggByzVn
 Z51sf4jH0+MCfe6QroIiJIJYHxTDya6+4zibhv6ek9EH8yRy2hoDBNWiATBc3yzupAcZZg6XEQj
 9hkY/HlI58QKy2ccUUg==
X-Proofpoint-GUID: 9W7F-gryPt4nR9RU2NcwO8Kl_LONohZu
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=6a15da77 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KXSloCXmEunfo-Xy6rIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 9W7F-gryPt4nR9RU2NcwO8Kl_LONohZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260153

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

