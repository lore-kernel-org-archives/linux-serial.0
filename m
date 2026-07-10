Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A243B492
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703552; cv=none; b=e2DfZ3ar6jM6JCguHb1DiDofSaJTtaJ2sElrWCYtFd86wpzvDE59G4ukK128iGZJjzN71dFJwiNkiJCDKAu4KHdZ9C3J0BtcFSwqNnmPybSF/ofN+qio53OwyuAmY9bxGfLHHl/ifCDR0CdhHNE1BF9AK83YWYHcBSmukcrz2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703552; c=relaxed/simple;
	bh=w/htGaYN4MRQBkBxw9Vyzouak6ZhBaXPMXN6dHtpIC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NoKDNPC0OFOzBfIjuH5d74hiAKLw37TvScZd3Kk74JcF/1xds58iBJNb8lnjgslCL+lQ26WpanJ+pg79MTvCVenK0rDvtSC7JdlXZtEytw6Sd0m9M5xpc80vegPqugWvagnFfS10aq7E3UmV1SsDvpsB9IQZJA9/eTqCGROWryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UcPylpbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqRVxWNP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcPylpbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqRVxWNP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3sgH1325602
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 17:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=suX5GFzgtIvy+WnRpGcGhY
	1Adyg80YvOjSiOP0vhCIg=; b=UcPylpbmkwEjGg6VLB2secRcZuH651W3IBaogT
	RR8kWWYMrs40dUiEw/bDMToCyd6kIFiJJICCGjdo4rPN/qYtwqNiEMjIzZgGqPLb
	BiYnJbhD547EfXSNHsaixDbckFZj2MYNFQMSfWBHToMrP25kTXpMslZdWmwf/TKi
	3Zgj8Dewr9n9Nf6OePwXSdqtztN/dNDf7JTOz8vXHVSScGjwNo2o7A6AGR18Z9eg
	GZELNx522uiF3kBz/p/ZWomjcV1ckZGohn4qEpJTu4+p4T3Zn6zktVP2rGLKv9F9
	uB+7vZ/taBaQFxb1msEkJQtjq/2C4rXCbMQFIsLavHxT5l0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339rf2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 17:12:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso16700a12.0
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783703550; x=1784308350; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=suX5GFzgtIvy+WnRpGcGhY1Adyg80YvOjSiOP0vhCIg=;
        b=GqRVxWNPNQbHYYM/JYwT70yc3AZImzGlDKhyoWgwZDpQc0eDrjZ+6ZyQqjbkis7dQT
         +TtXeGkdefMRmmSseHbjiF8B4DUwSrB1gwpGp/Q2AdY4Wzine3+1/6z487nkB7p27yxB
         pu2m9TV99lXRBDGE92OhhQto7xsAm+X7LwuGBBELJm/+N+XNvJ6bAtKgm2rtDvqCqXi8
         HPuwoCl23nsY4aF6SPoWpS3U5Qu6fxkx8bSzEi7tfqZ0Z1snqnxQ/TmoEIcCEfkFHEti
         sGc23/WFmTx69uqvpQj47+eYFg3EUPuOAzNjEo+4AzOlfCoD2hGu34Z/nfMNPFv/bTVw
         JNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703550; x=1784308350;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=suX5GFzgtIvy+WnRpGcGhY1Adyg80YvOjSiOP0vhCIg=;
        b=bEmzSAWrEtZ7kgt0hf3FwuXp62TMn21l5Dds5Wd3Y4Sw7dI97deBGVk4q2mEK8xb/s
         FyMRlC/FnbMBVoR/hOgCquAOrqpSBuMQxjfja6ijMnze0DwNI0hs1yb0QL8NzdKaWjNZ
         oxUivla5n7j4FGaOXkVnLYO5Ry+DSw0F/+KZ27ALSNMvWzOHYhBA82XiTg5sCm5ouDrN
         ZR6QGMBHdbNYY3/WZ//+aB59sBRWSnXjsxyB7Dk0TbItgD5hvSA4oLUzfVGabXEWipkX
         Ql+OSnRsac7nz/vkN52mRqq8QlyPKjd6pyno1O731h+Te7NJrFQ9JQQYopwsSXcX+jjV
         ntgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHYikO4HSPUrHM0E+tMHr7RX8lMuG5YVPjnNVTEzSC2IbaTGygJppH9O/iFDXvtK6EbDfDqoLf+0x02ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslrTdF2kkQoMLbgdc0kq7UXznxZMqnhDDePjH9HV6XjXk/d9o
	bg45uJoKGAwg+H6rmQqCXcAeb1uEoyJkn8GtwcgZ8I3ON3u2ATRIGBT/ekvS3leOgMxMCtkzHGl
	XMcaryOMQyeYjgrFioT040JFW8AkYR/Z0GawtRPEuUICFzJJkXqPF7CNmF7I3vm6xAyI=
X-Gm-Gg: AfdE7ckVQpMKuRwdvKrdm1TKhJxYmEnoIstFlv9vSgpbgs8getqubTB39YYJ0w/4wN9
	J77gCHXqzaa/j2TszxgMf+6g/Msn9FRjjG4ckzRI5i4xBCqLl7QIHjJzrcEzef7xFvgx6QhpECV
	c1wSB/XqS1+jBlVVkV4N3ilH0yrdLvW1EFM+UEDfUIya1vTTXw1xTl8Hwf7m+ziMN0NOUoYSxcu
	bUeq6CfuBi0jVXmTew/OnqH0N8sKE5klCCHhHX83J2HqFCkm0z8gGmZZdmcD+hLrbquNLTGMLh3
	cI/q1A4dx2tgVnquY5gfUiY+n9qnC5Cl1wZzRSf/OV6znwBkfTaHwO8BQfuoFQtKLTI1UjdoS+R
	8WwvnnrbcQHNNL9/WKciEuwWQoKTpnN6l6xauVsb5tfli
X-Received: by 2002:a05:6a20:a107:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c0bc9161c4mr14798874637.17.1783703549949;
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:a107:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c0bc9161c4mr14798831637.17.1783703549397;
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm46636277c88.12.2026.07.10.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v6 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Fri, 10 Jul 2026 22:42:11 +0530
Message-Id: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsnUWoC/42NQQ6CMBBFr0K6dkg7lhZdeQ/jokCBJkChxUZDu
 LsFNy5csJnkTX7eW4jXzmhPrslCnA7GGztEEKeElK0aGg2mikyQoqAcJaiqgtmpUo/WDLOH2jq
 YSttDowcDm011cOG5lBJZXsiCRNXodG1ee+b+iNwaP1v33quBbd9vIKPiWCAwoJBxXiAKhprmN
 +t9Oj1VF5d9Gg/ZOgF/3AwPujG6VSZRcGTFWdV/3Ou6fgC7Ew7EOwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783703544; l=4142;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=w/htGaYN4MRQBkBxw9Vyzouak6ZhBaXPMXN6dHtpIC8=;
 b=K1GsQgIBTSZVK/rXxQ5gOYoYKuMaGiWWRUKkWfnth6N0YGb2DtUiR9fcobzRF1XnNYcFR24qt
 WgtmEaz8BfoB8DOkRJ+bE0dH6Msbrgh1SErGtsJanbbvcV2sZaBu4Zx
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX4Y9M5ixOwtEE
 Aau9cR8qw35VtT+G+ycon9msNC8Y0yF1MutMYzFoyZfo37qGaNIwZ6ZUFytb3GuSl6a9/7WPS3m
 vDvWeiUZItKgfCtSVBWzaBp/6DRz+Kc=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5127fe cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=ag1SF4gXAAAA:8 a=1hfpssHSpbbJHZzjzoIA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: M7T_1AfY1EldHrulsknGu8IKext0gK_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX766sHzK5lKR2
 Kb2wYX/qcjvdmtPab1+xvPc7ejx6r/s3Y0iA9AhpRxYTu8baHpTavfLROrQX5TuhYPR53dBp2nq
 S65AVDFroV3Fcxrwh2Q0dTxVuL9PVUHf2nAMKiuE6LrqLy28LDSjsd5Ph2ZZX/smPmeXjVHOiaP
 OXo8ZjTv/RvDB3eeGD8HM7+Ih7Oaxuy0WY0SDh+dBk2H8PjB85ScPmdtI8mauCMTmQaSfsn5M9V
 24aNISBbCKI7wgLz485vJgqcPN/XW2CFXkA2jSASIEPsCroLY/2MvV0Ff6y2AKW9Ely91IqjulR
 6DyoRP9qBxr6CGtgMQRZxEwq77jxNaajE45jGu7fCPzb7/j3K2kvUZUGGtISuB5PKekc8XC9rK1
 XupmGizeTNaxJN2Km9wSI4QepvFijQd5Kzqd2n13NtkYWMZMyC2KSpG+3MWctSLDAf8k/Xdy+eN
 V5O+oFCJMEnQcpMr88w==
X-Proofpoint-GUID: M7T_1AfY1EldHrulsknGu8IKext0gK_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100171

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
Changes in v6:
- Rebased patch(02/02) on latest linux-next.
- Link to v5: https://lore.kernel.org/all/20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com/

Changes in v5:
- Remove serial trace header patch since it was accepted and merged.
- Added a new patch to fix for remove unwanted variable len.
- Link to v4: https://lore.kernel.org/all/20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com

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
      serial: qcom-geni: trace: Drop redundant len field from geni_serial_data
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   | 27 +++++++++++++++++++++++----
 include/trace/events/qcom_geni_serial.h |  7 +++----
 2 files changed, 26 insertions(+), 8 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

