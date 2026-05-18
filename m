Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48E2367D9
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127036; cv=none; b=q8UAnsMJFEFI/n+8M5O2qi9QmHwcvErtumiUB3ZBmu+9eCDv2YarwTYndQNx5MLgdWLonAeTn+FrsBV6nxSMxq+9zihIc//eEbVIreHxrxFHviLSrfYeJFYz3H/h+wegscClGrePcGukeBw2RBoPviRPEBbfZsMkocIfY6u37E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127036; c=relaxed/simple;
	bh=bE5uS5jA4gBHIOsnRhx9ylByIay9uNE8JeImQsB7G9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IA59nHjmj7TBeDfkKUnfSmjKyIXrOW0GlgMA+85p+p0OadwPPjZa6pJX7MtwQsEVwF1vKO1A8xpzE+XIg+wSPOj1XTf+cRrovS8szNQ+0rmmb6WLmGRO7/iroIpHWFpWZno03ZoVS4l56Mfs1XhmRAfJd1QkVmGXaV+xIb0uPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CpMlNfAn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CszbXVpq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CpMlNfAn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CszbXVpq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICovXm2437943
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=; b=CpMlNfAnlEQ1cQ6G
	B2IV/Wu4BzLt1CuDnmsccwQxkkbKI/8D6xef3C5mtqrOaMvAf8aYCwjSYlp7zN2s
	d14/VTgnhJ1WXVEakSRN3GFkCJ2FuJi9SJh23SFWu2djxoXOdfQGxU0MKL12YmAv
	JRqDvf/1zA0GjM3VISrVZvOI8y2bmgp7ffEFqUQgbXl7CW23cK0aos5ofyunNITg
	a0fyUdNKuj5RxUizkV2bEeLBopFT1f6FpHqXUtZjf1kP1fKjq5vOVinLp66/MNNP
	xC68G+TsfkyU3GfvwEHMvqUxtRbsCHjrToC80+WNot5oNw841qEqhlSPIQCX+3kx
	BpCpmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e834v17gq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2baedd2fd43so18831255ad.1
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779127034; x=1779731834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=;
        b=CszbXVpqux1ZyjC1QPJfIm83ru2H9/jfumBFHexa1HpJstJhtQtzAmFw5+TRPYSIFU
         6tRba1bLWWz8I1wQdrR7f+37pYU4NNGezFh5pSyZNmpzr5yrg/XUCkapG5Msksxh2h9d
         OCTS5fT7LZ/gk8upvBSYX08rBGeYQDPFhJZCHGRwcW9fvX8YxL3UpWOiQicwTANHEQYm
         nJOedMFDPnz50zTpNEKRLq5Popuv3+pG4DC1nxWDCc/FmhWUC+f8X8mpe8r4pEqEOhCd
         JbFynkwZD9oGlc2LlpnNkcn5XuaU5+AMKpDmN/J7XgG+CYCxb8zbZ4ReMKAfoBSzcVqY
         l9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127034; x=1779731834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=;
        b=Uwt66uU4CSBtztgt/3R5Mx13OlO/lIMel/AinAhkKq5SnUHKcndEknBwLHu1HwOOD7
         IoXTCsdXTsNkn+xs6R4j+7wrrXeDvgMq7PbAJip4jvh1OdGSn/jWztqT221Ug5RdIELE
         qMhw7vmj1MNjcemT9qmcPChRsADB5Q+r7Ku/cTvzV0UbjZmhVsSE+ZMB40CXnTwgOgHn
         vlZh47+CrOmZshkzKWOJNMK6E4ad0eT9w33W9iyo+3mqF8vPg+D0ZWnbjrhU7CL3sab3
         1VG8BPx97ZjpjV287M8bjyFZDii4Izjvf0g4/DA0/3CNieKDGfcinEbhs/8GtlACmMaE
         yL2A==
X-Forwarded-Encrypted: i=1; AFNElJ/iCFajoBX+XVwbarNeYVu8DrVB75Go+rsiMiKv/OSOkVUtSpR93rlSe7jlYE735ePOGGB9kyS4I2xMPE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WdFNiW4Q/JCiYZ1HzAlO2sHbRZAFc5vUg9BuB1kL3pfs+fRp
	e7ADY1lh2PwPHyWhfvo4VQ3/BM1Jy4wVLTtboLIssth906Wu2vWh1IyxB/NYejADwCQJD8Cki64
	EVHe/LxmXL+OGtJOnW7OBmpJTpau1YaGZLZgadkMHQ9gvD8NTzXq2LndWQsGAU5uPMtk=
X-Gm-Gg: Acq92OGxACbAsnotoIUQINbjvI8tdoTHV4xbiDegGo0eD6GYpm5exeVZpNzVnqybv41
	JF6IkJaA0hcaMxWWkSxeUwMLkkTaOUq+n9A/m/ff+I+JTn3DzjwkEbWjFn+t0Rh5So3jv4KLgQB
	5nBHHuUz24QNS0aminX3dQKDh8bd8D+5sN7GQWexYy6RRCGZ6KtbyAJxq2ZPNRpioIGC8nKKSxN
	L9PoOuYsBB836C05guHAMiktvTciU2fpIEA6Ug65HYsoM78GxjKr+2VohLOSPYUpk8BYqbleRJY
	ns1DHIYyVlF7eNgTE82V6HJx4i12J6eKyRl2diYMyoxTdt1xZA9UTqOKgEA0gQgIq6b12k9wGJD
	9amzuXy4rBXavpxnyHXxPKuhtc2HPl+O5gpnWULO/sOIkMaJmYfIvoYU=
X-Received: by 2002:a17:902:ea03:b0:2bd:9c0a:32c with SMTP id d9443c01a7336-2bd9c0a065cmr121058125ad.19.1779127033565;
        Mon, 18 May 2026 10:57:13 -0700 (PDT)
X-Received: by 2002:a17:902:ea03:b0:2bd:9c0a:32c with SMTP id d9443c01a7336-2bd9c0a065cmr121057935ad.19.1779127032904;
        Mon, 18 May 2026 10:57:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe4973sm158348015ad.41.2026.05.18.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:57:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 18 May 2026 23:26:55 +0530
Subject: [PATCH v3 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-add-tracepoints-for-qcom-geni-serial-v3-1-b4addb151376@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779127023; l=6634;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=bE5uS5jA4gBHIOsnRhx9ylByIay9uNE8JeImQsB7G9Y=;
 b=/ODY7GjAISGw7k6fX3K91Fp/f+BdNhjJSP2vsH/1XTsekZj3v/82964g5pw0rVcKupyvFk4jh
 Qh5fAt66M9GAeeCCU1/YIwmn6d0xSTsJ9T3dMMWJkI+6sGJJCVgVGl0
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a0b52fa cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ESrFBFgxKAYm4imzEJIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: vnSHS0KI0HRwROt70l4U07AzVu3feSuj
X-Proofpoint-GUID: vnSHS0KI0HRwROt70l4U07AzVu3feSuj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NyBTYWx0ZWRfX3xKxFN5Fg9bd
 N/D0aV55a2WU2OCnnXfKmoi9g6Cxebk9M96h5+BB47VphCba8pJXr94OZLIqpHbgCAwCX+D2G5t
 Ay7CWrXO1M0BAAJbhUhKr6C6r/s7pFTerktVL1Y7j3qWoXhwiK/GW9FFyQtle507jld2ZxHWCaJ
 Y2EVoobTO4WRy5CsCCRbDPoKSQO2mKMn7fKNghxNEn42sodpv9h1cz+XWPz9FPVDhtI9HfQGUlU
 7nGZP6C7u2IIaWSMyW36nGEtv6Qb4TT2swPWCmVYjk1UCHc3ogB5/IZmU2mGbl6LLVsi+dWRN/w
 o3XMbfhl1kuRhA5he4kbGnJTkWAWTPu/j8zFNMLc0vbDWGBMoMm2iMaWtk43XLSkL2UK4Hf50Yd
 R8KeugrYRsDDzRay1sXVd30S/eGwT/H7lIQNyf5TS7HttnbUyKAPt+2ycJgNP2SbXZDVEtr6twH
 KH3GQHNlYvLcDyLWykw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180177

Add tracepoint support to the Qualcomm GENI serial driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover UART termios configuration, clock setup, modem
control state, interrupt status, and TX/RX data, making it easier to
diagnose communication issues in the field.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Removed \n from geni_serial_tx_data and geni_serial_rx_data events.
- Resolved aligment issues in geni_serial_data, geni_serial_tx_data and
  geni_serial_rx_data events.

v1->v2:
- Removed multiple TX/RX trace events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
---
 include/trace/events/qcom_geni_serial.h | 164 ++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
new file mode 100644
index 000000000000..417ec01f9fc8
--- /dev/null
+++ b/include/trace/events/qcom_geni_serial.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_serial
+
+#if !defined(_TRACE_QCOM_GENI_SERIAL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_SERIAL_H
+
+#include <linux/device.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_serial_set_termios,
+	    TP_PROTO(struct device *dev, unsigned int baud,
+		     unsigned int bits_per_char, u32 tx_trans_cfg,
+		     u32 tx_parity_cfg, u32 rx_trans_cfg,
+		     u32 rx_parity_cfg, u32 stop_bit_len),
+	    TP_ARGS(dev, baud, bits_per_char, tx_trans_cfg, tx_parity_cfg,
+		    rx_trans_cfg, rx_parity_cfg, stop_bit_len),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, baud)
+			     __field(unsigned int, bits_per_char)
+			     __field(u32, tx_trans_cfg)
+			     __field(u32, tx_parity_cfg)
+			     __field(u32, rx_trans_cfg)
+			     __field(u32, rx_parity_cfg)
+			     __field(u32, stop_bit_len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->baud = baud;
+			   __entry->bits_per_char = bits_per_char;
+			   __entry->tx_trans_cfg = tx_trans_cfg;
+			   __entry->tx_parity_cfg = tx_parity_cfg;
+			   __entry->rx_trans_cfg = rx_trans_cfg;
+			   __entry->rx_parity_cfg = rx_parity_cfg;
+			   __entry->stop_bit_len = stop_bit_len;
+	    ),
+
+	    TP_printk("%s: baud=%u bpc=%u tx_trans=0x%08x tx_par=0x%08x rx_trans=0x%08x rx_par=0x%08x stop=%u",
+		      __get_str(name), __entry->baud, __entry->bits_per_char,
+		      __entry->tx_trans_cfg, __entry->tx_parity_cfg,
+		      __entry->rx_trans_cfg, __entry->rx_parity_cfg,
+		      __entry->stop_bit_len)
+);
+
+TRACE_EVENT(geni_serial_clk_cfg,
+	    TP_PROTO(struct device *dev, unsigned int desired_rate,
+		     unsigned long clk_rate, unsigned int clk_div,
+		     unsigned int clk_idx),
+	    TP_ARGS(dev, desired_rate, clk_rate, clk_div, clk_idx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, desired_rate)
+			     __field(unsigned long, clk_rate)
+			     __field(unsigned int, clk_div)
+			     __field(unsigned int, clk_idx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->desired_rate = desired_rate;
+			   __entry->clk_rate = clk_rate;
+			   __entry->clk_div = clk_div;
+			   __entry->clk_idx = clk_idx;
+	    ),
+
+	    TP_printk("%s: desired_rate=%u clk_rate=%lu clk_div=%u clk_idx=%u",
+		      __get_str(name), __entry->desired_rate, __entry->clk_rate,
+		      __entry->clk_div, __entry->clk_idx)
+);
+
+TRACE_EVENT(geni_serial_irq,
+	    TP_PROTO(struct device *dev, u32 m_irq, u32 s_irq,
+		     u32 dma_tx, u32 dma_rx),
+	    TP_ARGS(dev, m_irq, s_irq, dma_tx, dma_rx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_irq)
+			     __field(u32, s_irq)
+			     __field(u32, dma_tx)
+			     __field(u32, dma_rx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_irq = m_irq;
+			   __entry->s_irq = s_irq;
+			   __entry->dma_tx = dma_tx;
+			   __entry->dma_rx = dma_rx;
+	    ),
+
+	    TP_printk("%s: m_irq=0x%08x s_irq=0x%08x dma_tx=0x%08x dma_rx=0x%08x",
+		      __get_str(name), __entry->m_irq, __entry->s_irq,
+		      __entry->dma_tx, __entry->dma_rx)
+);
+
+DECLARE_EVENT_CLASS(geni_serial_data,
+		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+		    TP_ARGS(dev, buf, len),
+
+		    TP_STRUCT__entry(__string(name, dev_name(dev))
+				     __field(unsigned int, len)
+				     __dynamic_array(u8, data, len)
+		    ),
+
+		    TP_fast_assign(__assign_str(name);
+				   __entry->len = len;
+				   memcpy(__get_dynamic_array(data), buf, len);
+		    ),
+
+		    TP_printk("%s: len=%u data=%s",
+			      __get_str(name), __entry->len,
+			      __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+DEFINE_EVENT(geni_serial_data, geni_serial_tx_data,
+	     TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+	     TP_ARGS(dev, buf, len)
+);
+
+DEFINE_EVENT(geni_serial_data, geni_serial_rx_data,
+	     TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+	     TP_ARGS(dev, buf, len)
+);
+
+TRACE_EVENT(geni_serial_set_mctrl,
+	    TP_PROTO(struct device *dev, unsigned int mctrl,
+		     u32 uart_manual_rfr),
+	    TP_ARGS(dev, mctrl, uart_manual_rfr),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, mctrl)
+			     __field(u32, uart_manual_rfr)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->mctrl = mctrl;
+			   __entry->uart_manual_rfr = uart_manual_rfr;
+	    ),
+
+	    TP_printk("%s: mctrl=0x%04x uart_manual_rfr=0x%08x",
+		      __get_str(name), __entry->mctrl, __entry->uart_manual_rfr)
+);
+
+TRACE_EVENT(geni_serial_get_mctrl,
+	    TP_PROTO(struct device *dev, unsigned int mctrl, u32 geni_ios),
+	    TP_ARGS(dev, mctrl, geni_ios),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, mctrl)
+			     __field(u32, geni_ios)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->mctrl = mctrl;
+			   __entry->geni_ios = geni_ios;
+	    ),
+
+	    TP_printk("%s: mctrl=0x%04x geni_ios=0x%08x",
+		      __get_str(name), __entry->mctrl, __entry->geni_ios)
+);
+
+#endif /* _TRACE_QCOM_GENI_SERIAL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

