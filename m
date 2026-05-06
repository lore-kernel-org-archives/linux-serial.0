Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CD4ADD9F
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088309; cv=none; b=fhTHmB9CcAWVZkXoKt6v3/XkW4EXX0e6T6oFHZAKYPHqTZcjejgQ+W/Yt4sA6K2yYXgg1YJayvzE829But+7JYnBQMokngRB2XtK9/LjxssQFXeSM7iIO5vtvAimPowfYe1yJBKiwyOgHTrGVrbsDt01PPgXcCXU9bMiIyBHWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088309; c=relaxed/simple;
	bh=NBIu/qIHN2l90jn7SpQJDeyvXBRVzWh9a/1UlM4vu8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGe70WDCgcae8J4BeS7ptuxuJQtrVohbvncq2n5g2sRwNZkJ/cxDcoAa2OyglkC/qeh8Q18bcS73MC1LHomVDjxNmIVb7W/B01Tq69ln4VlpQv8H/+9I/kIEEXOixM+mOP5WhlbMHM9bZnaJbRrsWYtO7LIENzyfBwMzVpNgKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4ZtbRE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVM7eGSh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4ZtbRE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVM7eGSh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646EB3X31436257
	for <linux-serial@vger.kernel.org>; Wed, 6 May 2026 17:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JbNpuUYPRXk/T6JMrBd7+YckcYOUOw2b84FbhT7cP10=; b=A4ZtbRE6nfWV1ERy
	pOJdoQBf8izDY204JGX5MNtIYAMkHJlzMj3VT8j7lo0sMuVfVdRqAFKMpYwSjdDF
	jT7fvv2ZXesNfXZ4/TowcAbZazhwcrsBV5XBHnMoicbfiSRUT8UutdZ8GiECFBU4
	jJsJNsq7+sRLVjxhiv1fFklNBPBVRDaie+cEnYoxjnUenzS8XOMWVpu93093+kGK
	8QgmTIjr9yaznLysHReaO/MLXLvarpYOokJTHtAl3MnInlQHxIocCD3zZthEoii7
	K+gJDhrRgD1H9z7iZAWQXBPjm2etH4UHhPHfRTXq8E+BNPONcul8GLMLdY9GU++8
	qj8dFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyuqdugfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 17:25:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36512f223d8so8925117a91.3
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088301; x=1778693101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbNpuUYPRXk/T6JMrBd7+YckcYOUOw2b84FbhT7cP10=;
        b=bVM7eGSh6HVJwRyOqlRU3Dor8hja8Jx4aHZWjlbgfTz1mIOaQyELE912I5f/QQ5Nm6
         8ppZzfpGEdUqcebX35G3vizf48z8FEpC2NjTtYDUnHko/0aZiIqEDuSLVFNp4xgrUYO0
         xcaNosEaEG35JiDryc1iOMEccKnD/kG9ok74eWZ8GF0Kjx789clUcvrv11Sw4eCeuqgF
         yrjJxHirw2wvsMaWjO5vEM7RT50/BwShqncnvUDT8I5eC/BcRVCkUwA8IyocX50JD66d
         tqO6enqOdDdcrlpt0TNet+OTfSN4DDGyRYBKGbPMmbLHY8GBIAXhbEY8hzbMUPjo/8ko
         LQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088301; x=1778693101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JbNpuUYPRXk/T6JMrBd7+YckcYOUOw2b84FbhT7cP10=;
        b=TjRm/enW1yIGiAj6sR3tO8JdRGQuSv6YOBINl5Tlp1IXiyFKPklxLop8bLN0lSjo7P
         NIb5W6iAxwgQ2zWSuHgBIEOaQffeUVfDuKubFKARUFzjfswd/FihkF4KFe0geOEGLfOM
         SNZyrXM7oWDooj6EP4o/pL8zxvIYZcyxtgF+v66TDDDPhq7gP3Yk/aIUa9Dof1ZJT6eM
         nduszxpQIzYTRw9CKCu31QYY0OGddOE3cI9MetGj51Q+hrvFIcRWrrc2i3zEPCNi5GDh
         g6wl9G0IJK0mH7U+vCtPZWoanENfCFunPqchcDolqdGQc+F9daTUE2V9OqpAzmteoOvY
         PUAg==
X-Forwarded-Encrypted: i=1; AFNElJ8qUCPxb5lJzvZ9uWL8+up9s13atmECZBJngyMvui4WQLSsp8nkFl1MUT1R5inFJU/Az0Twwz3dfE9Dn/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxidUkYZq7xWGoUskzAIVJ1VNWQDwsuTQ/cvJ6U8Qs6jbkmdtNu
	D5PLMLdfzrdy7bWkMk5mUPHGDPaGYnKVc7BU0pVHJHDuJVzYfzqnoSrk6zoaK1AD4mrtgOumII1
	eBdG8f85wxrSBxVRlFke7dRTCjmXxTo+YSAkXjkrK4depqPKAVQr6wOcZvWlkqx8LsuY=
X-Gm-Gg: AeBDiesCZt2Z8Ub87si15+tvI3uwIRokoa4Uy5jrm/keiswCEYeYgRb74xjpin+pP68
	4np+34mPVOmIJg+6DAsWRzRi7a0gVSIyIj9eYR398fO+cDqcrs3FpcB/gvtC1pKQKtiKlJkbDko
	GVF/GPkVb0nxCQXz7Slkh+PN7UXqIl4xxf8/oPQ1uU94Ks5osL7GJUHknVoJWJGQyP2I9ffVvXs
	bdv4RH0cKwGeVGdHPdWYNkkoTbIKp36usC9PEdeT6/KWzIFdJ1M8/AhQqWtV8tGZ5jSXPY1o5kA
	evZR5KB4ZnNqH+MO2t7IfD/cbBhq8dLThG8HsYUbdZ4TYm8JhoWDBoQrM7mfbzrp+vCv9GI7HLQ
	dNQknEFku92MkbuXeSjh7p2VstIDGOx0hc8SQhu7St4PKI5fBCfgshjqunNPa0c5bVQ==
X-Received: by 2002:a17:90b:2f4e:b0:35f:bb33:d728 with SMTP id 98e67ed59e1d1-365abae617fmr4696990a91.11.1778088301279;
        Wed, 06 May 2026 10:25:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4e:b0:35f:bb33:d728 with SMTP id 98e67ed59e1d1-365abae617fmr4696907a91.11.1778088300585;
        Wed, 06 May 2026 10:25:00 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c9ad13sm3051948a91.15.2026.05.06.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:25:00 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 06 May 2026 22:54:44 +0530
Subject: [PATCH v1 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add-tracepoints-for-qcom-geni-serial-v1-1-544b22612e08@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088290; l=6511;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NBIu/qIHN2l90jn7SpQJDeyvXBRVzWh9a/1UlM4vu8U=;
 b=5+97K3ZzYFMAFbWnT3AdzPbNHUdm4yJU7pM8oyVNXdLu7N2cp40b+iatWwm7fqmNVX9PtjEJ5
 iuLMHuWEIt5DNwR5TtpDgXJ94b2alMZVzyD5os76ls2o33OmZYw4z3l
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=W4sIkxWk c=1 sm=1 tr=0 ts=69fb796e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ESrFBFgxKAYm4imzEJIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OSBTYWx0ZWRfX/JB7T5OL73hG
 nFjk9Qr3uePOCcKiLgMZ5+tqy7D44wkX4ylwZqf2sY8hDNXQv/xHOC9Z3T9TeJlXh+mrhm7HtvS
 1GCEPaBvPkuAkX3CoYFiEmmeSLn0pKVPrs3sXhw//LzXTNKYtsx5aAOew8fx3/rC8PoAkrwQIn6
 XaM18niGGjnwF+FlRsJzqVcRyuCZs+Uy04tepQSql3Wgt0cJ+lzqsBzkwQ1F55xlcG9m8XWIHj5
 7Zk3akXUDdNW8fCWSZ/x87EIWfFTsX8oNA+r2T4e3egTf72ntkX8VNhXn5dI1tLN3P2uMUY//CK
 Wd48OvV+pbxtj65JQm6sNRvq5fh+baAYNIkxQGjZQ+RLGgPvWJOJFv3zHs4hF0o3Yl1MB4ZOBod
 FLwmU/f6frd+++HsQe+KpXiBFkwcufXfzB1Eo5B9s4HpzBI372DSK9GUDB4apB+q8zNIT0ucsZZ
 Xng/pCJgq6+LjYbLIMw==
X-Proofpoint-ORIG-GUID: VYNKb-KNYGVQG3u77LkOr-rvi635s_pZ
X-Proofpoint-GUID: VYNKb-KNYGVQG3u77LkOr-rvi635s_pZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060169

Add tracepoint support to the Qualcomm GENI serial driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover UART termios configuration, clock setup, modem
control state, interrupt status, and TX/RX data, making it easier to
diagnose communication issues in the field.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_geni_serial.h | 173 ++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
new file mode 100644
index 000000000000..f386d163907a
--- /dev/null
+++ b/include/trace/events/qcom_geni_serial.h
@@ -0,0 +1,173 @@
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
+TRACE_EVENT(geni_serial_tx_data,
+	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+	    TP_ARGS(dev, buf, len),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __dynamic_array(u8, data, len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   memcpy(__get_dynamic_array(data), buf, len);
+	    ),
+
+	    TP_printk("%s: tx_len=%u data=%s",
+		      __get_str(name), __entry->len,
+		      __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+TRACE_EVENT(geni_serial_rx_data,
+	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+	    TP_ARGS(dev, buf, len),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __dynamic_array(u8, data, len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   memcpy(__get_dynamic_array(data), buf, len);
+	    ),
+
+	    TP_printk("%s: rx_len=%u data=%s",
+		      __get_str(name), __entry->len,
+		      __print_hex(__get_dynamic_array(data), __entry->len))
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

