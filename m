Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B704403147
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817073; cv=none; b=q9l2le0x3vnAcR/zw9yPjNWOMRn09VAj8HPeAv5/nyIbUYuYUg2wDOsN4wHnCbxAtnkFdUvuTK+Q+kIBwWyRkJPBdaAy4cYo4YJzFm+ILapD/AN2uISyWsZiMh+Cd7qZ1EpFinuLBwjfzuOE4nMFYuFEgdcwEjvUrfHnxoSCT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817073; c=relaxed/simple;
	bh=kO3PS+8vM+Y1cVJMEsnWbnLSJAXWqhiPW0FIU1IObx4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lJCpD3O/Pps10ZilGRcKv2EfrndbGbLndJ978Z1/MR0IJu/h7MOQPfejlgzLNXle/xv7zRKHa9YgvrW4xCB5n7o5pp/8iSwKCW9b+sryJX5IzrnuqjbOfJN3llQ1efgZtNaHg+UV1+1j/VzdlK4LNJDEd06Xh11wEw/HJP5V6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MszJtreq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SyuQmJMY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MszJtreq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SyuQmJMY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH1ccP3147049
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+8y1ULO/S42l3Qk21MCc9B
	/F3Sk3QdLI8zKZezL1FvI=; b=MszJtreq0sZpv3cEJSb9Br9HjNN7vc4pjSv16y
	gl2thm4Q8JVMlyFsP9PnJceuaWmKMvzy4KskwdxO2b32f1ml7IyxACRaRrwN56B9
	YcFOXxgJe3y4vgLR5rPRmVDXxk2ZxaO+7d58FIHzV3qXifLxhCtjdamHyw/4ZyV4
	5/LGdCFQWJFkS7pDsGBKA5stF4dZW0WAqjqMeiC/xuldNR2iE5ObmyF+kUp9ZPQu
	Lghp3lfhbcnUzDNEZ2RyLwqOHExqPsHKqL0KWqOASAyjFUyfbJO4OidACd03ixzb
	ntU30JimXluGHF13tgx0yxOQ2xahfPKL+RVOEDufVqbaqz7A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5v3u842-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 17:37:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c82751074c8so15645264a12.0
        for <linux-serial@vger.kernel.org>; Tue, 26 May 2026 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779817069; x=1780421869; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8y1ULO/S42l3Qk21MCc9B/F3Sk3QdLI8zKZezL1FvI=;
        b=SyuQmJMYE5+EY0tOjYbvWrpgyRTdKCnPMIsW5ceWko9+Wyp9rpZ/a6gDkj8g5/7KBD
         EyFYmLwT2RagrZIwjOaT4zRS/ajkrMCryumim/UY9uK6ZIGBGAPbY+4XD2ZJRrujJZNa
         xnrxhhuRHyd4EnVSqqQKGjVpdWzR0IjIe9xtWL9EL26kDM+BaoDXRrixjeuNmKMNdPH1
         nDtn0n7x7r6EOXZ2gkFt3s4DUFLV8ogARTVZvYvA3JtKAJSokgMYg5MQtc6ndHq1kn91
         t4Me19j3Lgty/MYsCV52l08ajdy7SazaTryAeXWPQwMZvuqUlX/tOE9ZYDLlTTwkA5BK
         Jm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779817069; x=1780421869;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8y1ULO/S42l3Qk21MCc9B/F3Sk3QdLI8zKZezL1FvI=;
        b=oM9SKY+X8cDmYBa1vQcG96mS9m85WNVSdy88KsaQPMp7Ru2bj6zOqNaTn1AMgA2xzy
         QnwRlDjLdLjUK2PRfTzWgow3NhHbJ8/k2biA+qVL3NwXgnSGgmdsMlZtqLUoN5z0LXTt
         dOCGMAYRZ552ByIgjw1JGfM5Ki3tPjgEJgaRmNZmawy6d3B4r0g04T48stmpJLLDHOTS
         EI2Amerl/mluY84nUBeqfH6E5ARZ259uov8PWqDr2N0QTeLSZbFU6DwPtIkRXe5zcoLR
         5Iyd1rEPmn6dBsPGNInv9mhQtstEOvZSRN9TmRZXgFk6qS0esnmZDjum8qNOmmMStg63
         ZO6g==
X-Forwarded-Encrypted: i=1; AFNElJ9TnOCvsJ3m4N8NpOXwTaej0fxngnSKFzVGg0izOvNkt+v20T9mNDEsUg7JMaGLK86lD4yONMXjjojuWqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXSIJ+7a8eXM59YTbQLKW8gZdeUS0I7fejO5EZ3jePZY5pPxT
	+fjRLysqVI9C5kj6V6z56FlhsLlC1tFssVaYYNXDGOWYnXCEa3NeHQ8lHUJbgE55AmT9kGlT73h
	vF1ro/E/LlmfuXFnglWslZ69U49NGq2TdS1WOW3HeBog64ry1mHFAQbZL2RoB75gBBM+MzkhaRV
	M=
X-Gm-Gg: Acq92OHKZ5XoBUStKoLMgl964X3A2ef+YG5o06Ka+29p2FVpEk2eVNRi5sCt8lPpM5h
	n01pbPsha9AecwX5RovSgXiu5IQ1FyP+WWEFqSkBqYZu/ZUXWx/rtXAQ10gxVJqRRLIHR8OTk/5
	HiIdNCRADHg2TAJRSSeyHQr4FQIKGqSIleNpeAL/mKXOJDib6I+v2rbjS6DMSY1d88B4LfCbZ7y
	5GlP66CgwHki9CljstmhVsmP6T3KteDZwx2WVBsyapZKzLwbJaF9LaXIoNLWfYJY12ZK66M0mqw
	t4vhOqyeO/nftdsyqvevUIfodUAsRCVTmHRW2YoDFp/HRsvnoOTri4ywS/hJLtVVRGW00+BB/Rx
	pU7czdQ21gihlo/vm9zjOsQKtrVehxdnTFGgvRKmwiW+d8/oJgb0VM2Kk2Sw+l1Z1tg==
X-Received: by 2002:a05:6a20:a121:b0:3b2:86e8:a819 with SMTP id adf61e73a8af0-3b328ecdb1amr19699633637.25.1779817069427;
        Tue, 26 May 2026 10:37:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:a121:b0:3b2:86e8:a819 with SMTP id adf61e73a8af0-3b328ecdb1amr19699583637.25.1779817068770;
        Tue, 26 May 2026 10:37:48 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841c32b511dsm3260461b3a.48.2026.05.26.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:37:48 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Tue, 26 May 2026 23:07:38 +0530
Message-Id: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLaFWoC/42NQQ6CMBBFr0K6dkg7lhZdeQ/jokCBJkChxUZDu
 LsFNy5csJnkTX7eW4jXzmhPrslCnA7GGztE4KeElK0aGg2mikyQoqAcJaiqgtmpUo/WDLOH2jq
 YSttDowcDm011cOG5lBJZXsiCRNXodG1ee+b+iNwaP1v33quBbd9vIKPiWCAwoJBxXiAKhprmN
 +t9Oj1VF5d9Gg/ZOgF/3AwPujG6VSZRcGTFWdV/3Ou6fgCa1nx3OwEAAA==
X-Change-ID: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779817064; l=3687;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=kO3PS+8vM+Y1cVJMEsnWbnLSJAXWqhiPW0FIU1IObx4=;
 b=faXztxcLxDwYimpPKNMRU6Z1BWVnGfTxoTnn/P4uPACUYxAHbQgBuBVpF+uILLFyNMFbg5eY+
 6udtByJn8c6CNVHZc7K0AI+9UxG/5Alw1tBtdeycE1ow+A/Wz0O//gV
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1MyBTYWx0ZWRfX0ynigYEqFOYf
 Sp5m0DTYiQ99XJs/O7U18lpPCklzyKBdi51buhT406i24qfIj1PATgAjgXovbMXR0IdtPkzrdGZ
 iixPDN41scjOCdRUX/8Qwg5ISzdWU+fVPa93rx50gZhTK55UF0oPxLPiH9WBWOGEO2x9xVDAs+t
 GQHCcSViEi7q+GcgIpDa8tbbxxVQR4Tpjf1lDreStkxyNB1H+o6qx1xT1r1eixxKxO42fpVR0Fs
 OTOolJpgYpV20wG8aUnMmUqpjrs3zz2w0d9PIs1By/mkCz5wTv/YXWEpjMRg+MglBzNScdvxEBk
 rzB0FTMVGNPTI+XmMFEOen9CuwebckiS0cjGTaz3cVIp7wi7M2d48or2GJiDmeT86Ngn1UBY1Yq
 ZVnX15zbwcTpF2cV66+6xYg2bGVtdpy8eX+/51kPneE4UQW5rQB4dUivIB1ontrIyT2gxCOG4kp
 EF2sVPRs7lrxexcnY1Q==
X-Authority-Analysis: v=2.4 cv=Zc4t8MVA c=1 sm=1 tr=0 ts=6a15da6e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=ag1SF4gXAAAA:8 a=xnuwXrIFmXssz-iuO0kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: lQd7oIyw5PcproddSaeCmVblDx8UUwdZ
X-Proofpoint-GUID: lQd7oIyw5PcproddSaeCmVblDx8UUwdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260153

Add tracepoints to the Qualcomm GENI (Generic Interface) serial driver.
These trace events enable runtime debugging and performance analysis of
UART operations.

The trace events cover UART termios configuration, clock setup, manual
control state, interrupt status, and actual transmitted/received data in
hexadecimal format.

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
Changes in v4:
- Rebased patch(02/02) on latest linux-next.
- Link to v3: https://lore.kernel.org/all/20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com

Changes in v3:
- Removed \n from geni_serial_tx_data and geni_serial_rx_data events.
- Resolved aligment issues in geni_serial_data, geni_serial_tx_data and
  geni_serial_rx_data events.
- Link to v2: https://lore.kernel.org/r/20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com

Changes in v2:
- removed multiple trace events for TX/RX events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: konrad.dybcio@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com
Cc: aniket.randive@oss.qualcomm.com
Cc: chandana.chiluveru@oss.qualcomm.com

---
Praveen Talari (2):
      serial: qcom-geni: trace: Add tracepoint support for Qualcomm GENI serial
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   |  27 +++++-
 include/trace/events/qcom_geni_serial.h | 164 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+), 4 deletions(-)
---
base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

