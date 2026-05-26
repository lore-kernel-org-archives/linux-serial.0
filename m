Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591B38B7DC
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817083; cv=none; b=rFfleLxkH04Ci75x2wioa4ZE+ToNLEMQq7gNHqzkVcH6PbFJAVK0kWgfIuvA4zwu/7QMEYdZ5jTeuwXFZAV00L60ziRu6EcmwGyJ9g4els8f3JN3EnBOSr9Oa4zoxTLYuc4PrACKvRGtY5Nj4cQ6SiekQMSavGN6J843pre80nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817083; c=relaxed/simple;
	bh=bE5uS5jA4gBHIOsnRhx9ylByIay9uNE8JeImQsB7G9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G25vy98L8CWYRfueF6nkW+JoLbsn+DbfWaY9IV00ddDlnMAkCwCnYCf1kNXKfkRNhZ8VYdBzciucoTs6XJit6g7gj1+ZWyTpfVNjvjVnymCRsXw6Etjp+hIiwBmcMdHUaBJF29DQNDCLjTHlQ3vShwKNzPK64rbk/0rdJQvF1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bq9PkBWB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kccISZ4j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bq9PkBWB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kccISZ4j"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH19xt2164257
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=; b=Bq9PkBWB886q9OuI
	P969TFKaH9c0pL8BEsl0RFlvMa8/F1Sn/rHXIzbbacNv6+rxu2/CB2kLgfbQDcif
	hOlB0wihcB5qrwJ86mVHhwV9QVQA7ldfSwrgqkMK9LUX9UX1Oirjk94nF24m3nS5
	ihhy7dZE742wDsWl3Mo0yNKBH7UaG3hra1UCvFGO75mYFwdGk/pLcQWJeUZEdjJB
	s0w4NP398yDhNt8stH1C9L8hF7xD9JdaFQAJ/cCKpWHkpGPd7MbEPw1XoKi2Une5
	HUxAVgi3uDEgMVsFa6Ro6XXvQsdReny6VCF/YfDMilZEU5u3tc7uOfdT4Vgv8YT3
	Se0efg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwwg8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa366fb79so13256701b3a.2
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779817074; x=1780421874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=;
        b=kccISZ4jlqZjvSbKOuRK3Q2GioouJG2wsXdsVvKc4bYwaiysY+yslLQLx72MCmCkIH
         fqeLxIMz75cuxl+bHQlav6RwJqBMwxdzYHHrjEu5WwHF0dSApEE+ghf1AsxHk12NJ8Dd
         YRVY8w2d6suGCzhF3ap0AIlz/rFi4y7pCs+1AXwvRA6rQ2UCgJzYPFkx62ZDjBVqEFMe
         RaVICbCVNgi8Lah3VbSoUVDbQTJsfw8d24nBEd8WedAptMBNV6LkqrNu9B+sc4QaT1Lw
         e2JhtYf0bKhGIITXITOvgbRwEATVeTG2DBky3ir5e13/tdeRBvHm8hiXnRy5784xmn2Z
         Y+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779817074; x=1780421874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfH/3JY9K6L3mKJHK5XJzCKs/zpVCvC7Z8FqVLUpQcg=;
        b=cvEiF0BfCEbHuljOqcEOiKkgx9oZdBqQbeNhvqXmxSVgas0tyMdfkvi++CJGGC6lT/
         T+F04sHVevpz82e85oz6920bHc6DAbjNmXsl4co3WamDl1R8KvYjycnpzq0HywyFelXW
         /SCDjhcxix5SYySConEk2MRq8gaIkwmxkjabKM5B6/qmRun+lyim0o1DpuTyPwnbof8g
         0rkIwAx8+3lPBj/LLJWOIUSCSTRJA70pX84SFP9L1gQHQlS5ef/5fT+SHy3ln/cwmZsr
         wnr2Os8gi55DHPv621zxJD0T/hx7haiLhC6Ydu8TSfTjduYNpsmMvmYmsjsvSSW9Ryqg
         emmw==
X-Forwarded-Encrypted: i=1; AFNElJ9gkmH6MaDcd1TNxEY3W40/6ej7y/+IZUUIQXA0P8O3PSriesTKsUnwnLTSyzqGzbyHx+kP4WPo2Vj/YwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbRWJm7jTMzdknpP9pZcfUx5vGdtQltpJvgQIX4Mhz+tMptMF
	FTBCeFzX+gmbQNbrgYz4kfKLdrFdKjPjKBwgzAX7WJOR8fImLJ5/yc4sDTJ2/yokKdk42mkbRyf
	hcGdmoqXa3/eWk6AUXRNhp33/8IEgxOrUbeLkug4ZbUZix2DQqSf9/152gtukzDFl2lg=
X-Gm-Gg: Acq92OEUwn5oDry6KYuyW/1uqbWyziwuFC7chedgr11nUMzPpZpuXxL7kr1Tv5tpvtF
	vld9P5aF4A9cPfBFGhw1IIUxn+OXUUKBa3xqK6R3rokYjx1aMggxl4DM0PcKRaHCYTdkOIueBqU
	ckWWRhoOJAlnA25jngOuNalgrD61ENauRgwOSP9V2NFQeWGyvhYH5jP85AdS1vubO1JCHDKYgVs
	izCRYcVwsxRfenHRh5S6D6QyL0oWdld98H5arJWkCH1Le/+tfqt+gs/qfN7+y+nEAdxohgES71s
	2uJuhHlsusrCleZyb4pqsPajZYARVOxghd/CdXbbG1VgeGtGsVlsn/Pd7BbuxYwv57Gfqjlx3OY
	V92TxAU7nZoNfcUrz3esPIvgrEnsMoDoV0hImzihj1qPS2AV1J45PE5Qjld451oRhUQ==
X-Received: by 2002:a05:6a00:39a6:b0:83f:a040:a3d3 with SMTP id d2e1a72fcca58-8415f39bb02mr19599043b3a.43.1779817073856;
        Tue, 26 May 2026 10:37:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:39a6:b0:83f:a040:a3d3 with SMTP id d2e1a72fcca58-8415f39bb02mr19599012b3a.43.1779817073272;
        Tue, 26 May 2026 10:37:53 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841c32b511dsm3260461b3a.48.2026.05.26.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:37:53 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 26 May 2026 23:07:39 +0530
Subject: [PATCH v4 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-add-tracepoints-for-qcom-geni-serial-v4-1-e94fbaec0232@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779817064; l=6634;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=bE5uS5jA4gBHIOsnRhx9ylByIay9uNE8JeImQsB7G9Y=;
 b=rTSTQGxsEroBnOXPvxhp84afXRCDlvR2b1ji0u/PHA09e7OOxq39uE05/Qf7ob/SZmEQ3Bqvs
 dnUlsV5HOJpCOsObRVp5COvIYaHr5n+/5Ogv8+KP16eZM03pAqa/WSx
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: 8fE56IDBMzdf6BSd2QQXbTl8FrUzLVUk
X-Proofpoint-GUID: 8fE56IDBMzdf6BSd2QQXbTl8FrUzLVUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1MyBTYWx0ZWRfX8EhHVNcEnSDb
 JmF+olz3CtnNjlIhyI8brMpFxwainqXqKR2ohLdNUmLaozfu9e84xBYczrgspadDUwzMelNYp10
 r58gxljWLJPSpKAkkHnN3lj4fmlKzRCbmqiP3VCqLKdX5t6GYJNk154gI4QTwFNxm+eqSZ8cFm0
 O6Bh5ntQpA9J4jRNXgJPIccba7FQe1tDJZ6sPR7F/Au80GTW51bUZ6TyszLAvtSfFfQkR+OOOjQ
 ZDQ4jaaJImY/HrXDYyLIZdsrJx9p+avvZm4bzbTaIKMLBKAD4KmERjTckbWCbtbUCqbGKfoC8Pd
 9owgAi+s8KCzy6FTrxLX2r1r8RcPY2XtvuquN/Wk9VqkkAEYSnNHhF2Ysmjl+8JCwN2sxlEGtBO
 5+QHarriUfph1xk29FsrUt2kzjr41kem7E/4vWvhPf8JT1yxgrXoS7gMY1YS5TjnFpKW48dH1hb
 c2p6RWQiHYxxjDf0Qaw==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a15da76 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ESrFBFgxKAYm4imzEJIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260153

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

