Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7443F5BDC
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533028; cv=none; b=KTjoBCjrzg0HN84RcLChh/2LD/lKeIe/mI8uEQ0XHmWzfnTgOOBXdiXuVRblcldGGw2bNxHY2RyWlOBht38sSgzlPx1rJk0tZx9LLbBW/tovud2MOOGITs1ZyCSeJyPvQkwG8w2Kj774Adt+2wKoeaQQVUhl7JkMLzw3s8MR04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533028; c=relaxed/simple;
	bh=7ravXgTmMO+fNz84uqrTJ5yh8qkHxeBte3jycrujzy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gje0Kw4fPUerk/gFZgteJF2t6VKXvGRq+H1s7w6qPVewpwebym1AHyncIjQjAhHnfscMOpuJ/tf6nBTgyQ0z/zWLN7TwVxXnijF2LL+KqIZ5WY1cmOZlVg9xQDux9X+xX8pxlvjFag2gkpxjRxpjWykDUwpB1tg5KYpaMH20XUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pl92d3GC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIfnzb7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pl92d3GC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIfnzb7L"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZUnt009053
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vd27UIermRndpbWE6uam5b
	8AYLKUJl9f4BWkWI0HBa4=; b=Pl92d3GCYk8Is3db513cjR1Hzz794L3jhQDp9i
	X5qrXqbd80W01fSw/sPCmDJmtYxRZ+fJH1qQRy5ssGmHHb8zVBxnF4ZzvRC/NOaH
	HFefxHXBGg/DZM1ykv8J+g6fQ16uPsvBVgeVa/o+8AO/7EljE2xh18fRu0cpQ3r1
	pggbVQcc6YijrCtaA9JTuPX0+5Wf2fYYJ4vf9svD2EgbKC0a8Htu7R6kpC69T/NZ
	NYJg7b8WI77K6gJFLB35FAzYFpnvXaKPwPMTG0IOBtxG6XEW7Vjktwa1Wn28A+YY
	CvSlwRsJetrH3eBhgM6NDociV/nuARd9KDYwBYf5kb3nD0ow==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteyd92vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 14:17:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso6200152a91.2
        for <linux-serial@vger.kernel.org>; Mon, 15 Jun 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781533026; x=1782137826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd27UIermRndpbWE6uam5b8AYLKUJl9f4BWkWI0HBa4=;
        b=eIfnzb7LkprSFjFOfYZsA+xyRMr1gCrPOXg1PA4k9FKxg8Bwi63ykCEQl9c2D/ocZS
         NokVcPxhRaNoIfFgCIlp/jyplZnjl8eup3LSmCaGx86tTI3e6NilMxCTEXaq8vofMbi4
         eyyK8r0FkATK4N3sJo2X/7MldRc0dDP7op2xCBFG0n+o8ReIZI7R4UB0P4LoWJrpsRAP
         Jln9nFWhbzJaiRgnh6eBV7Im2w3g01kUENrwLVsrk6enu4/QmSfPxogwUl7I7WRg2Bs7
         lgvPI6k/mpVj30bive2dWx+jcOxAIuzl4/Wxzn3HD6FR6tfmeliJed7YD6MkjoDaHUZL
         5AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533026; x=1782137826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd27UIermRndpbWE6uam5b8AYLKUJl9f4BWkWI0HBa4=;
        b=mcYJSq5SdJuaFFt5NX2vK63pDORo7Iie08pdSj0i/XmYQI+SF1TkB6+xrVzkE555Gs
         Agr8NLXcEedBIbgrvZjqDCccFc51TLpHmCr71Vi/XCdtMfyfoQBmfOMOhOGsLfvjPrQ5
         rc2Nxlkb2jdnq5KCvd0KfIa1sz8l8aIyyeOXzN89So+GaK5whkfcz2WSuOUNVn4H7QVG
         m8B+4SnqjC1NGg2k6/kFGlzrmsmw436cVnB5aeVAKqJG9DXBsIBD+gve0EVq6mIr1Bph
         vKi/YLk/rkoF2OTl6cRv3lPPRoGh9WcWxtYqY7ZF1yMW7FLigwVOtP/RpJAugNKOOT3x
         OewQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MzZY8JEVr+PaoFohslvYRvaD0NwurLsoEbxQj7BNUnd6RGRN8MNrK84roZ0Sh3cE4s8O6sGS8zLSfpOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTL/NcjUOlUpsreymQmtr7Yuzc3s39MaFifWQsVSyXsqd9bF7
	qHLcw19thbKK0ev2VB0W9jcIFeJ/DkKQsjvzWNC1rSr34d3J+6cOHb+EyS1EnUzFFDLs9CY9/+k
	tXtjpDR0ez9crLt4V/3t41VWd5PPfs2LW6zMCtUNRaimX5KKN98ZfFjzpTh9lBDLWuE1cwQDIlP
	Y=
X-Gm-Gg: Acq92OGpLuKYfegN0/qIsoBa4PIWWk3Ujc2KUeV9jCxnIoziF/RUc213WUDv0bhye+r
	xpeaD1XBI9t5X5dwr1noWjYirVTaIkNNte4VSgie35G19iz0Oa8KIJfB1+PbjC53QcOejAB8OQP
	w2vsGX5iE8IeGIPkjXWBz9bRp2kUYXZQLR7Y+qTO6m5ayuN6sMGPi6otsVR8Lc2krulnV+CNiPW
	4xuJnsL1TANUmVRrmA0IthqqUvRpKUkjm6cQGkiXmow1OqeAxpLsHlsQRbP64RxYI/7nVU+aYzN
	ifVoTfJzNDth/aJNiEtKbGeoxXrhdFjGlds6RV8ASfLfe5thKC7t9mntQdc5DJrLsrpMAErqFLE
	t+HFBK9BA0VGLhDvR/2jtA/58uZ3pDqfeavb9LRHJzqqyUyzytHL+bCs=
X-Received: by 2002:a17:90b:380f:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37c2bc6ed5amr11682491a91.3.1781533025723;
        Mon, 15 Jun 2026 07:17:05 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37c2bc6ed5amr11682419a91.3.1781533024975;
        Mon, 15 Jun 2026 07:17:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7172476a91.2.2026.06.15.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Mon, 15 Jun 2026 19:46:51 +0530
Message-Id: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMJMGoC/42NQQ6CMBBFr0K6dkg7FoquvIdx0UKBJtBCi0RDu
 LsFNy5csJnkTX7eW0jQ3uhArslCvJ5NMM5GyE4JKVtpGw2mikyQYk45CpBVBZOXpR6csVOA2nk
 YS9dDo62BzSY7uPBCCIGsUEKRqBq8rs1rz9wfkVsTJuffe3Vm2/cbyGh+LDAzoJBxrhBzhpoWN
 xdCOj5lF5d9Gg/ZOjP+uBkedGN0y0xgzpGps6z/uNd1/QAqN33DOwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781533020; l=3953;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=7ravXgTmMO+fNz84uqrTJ5yh8qkHxeBte3jycrujzy0=;
 b=qUpAxjwRvgrjKaoC+UG+nOXyp6Agx4jXC1KvUxF4qgf5EYa6wq+WBDmeM+tBjSAgrPq7ZgND7
 NLAIzdLvCXJB9QeNqoRn2PoEpBIcjhk2Fslfe4j3zJ92Z+ausjrijYu
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: KLMwhy6cLUz_Ln2jBCTLxn_mHmIrl-ro
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX/VWMjqvOF6zc
 vNEM2lvWA/hVEBeTf9FpdNxQEsY5GQhSQ3BxWqOYlWuiV/0dPHnMiDEfG6CQxfIKsAuDRUPB7J6
 wpkJil8hj7huRvXflRPSa4qnxRmlhvA=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a300962 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=ag1SF4gXAAAA:8 a=kp9qP9swKWubhZvKkLUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: KLMwhy6cLUz_Ln2jBCTLxn_mHmIrl-ro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX8A8zJK9KJLxX
 LnNfuPzVsNKGxTOnA5dmcjJp1r1a2YreYoY3wuoPAAopdmuLHpq7mEyo3aUPys2mHUANPFI2VpD
 DNDGfI8tuiN9G/lgD7z7zeEIEQQhpgKNcDVTZdfB/EOToVQJequpHYWAJpkRbJOOgW5WoHMV0/T
 rHgFJ03o6Y4w+P2Lqy06djgtNfgrQ9wCItyyJH4PfrAheN6+qvD/i71xfIoTrWhXgdMlRFInxjM
 V8xuzdGyDIqbheg4f7yZHrTNtmv9v0iibn4zCXVQvUEQezj8+DrYVgHKO0AdemdUQxtiUkVkHFV
 uhEB6yhlnrUx8Db4HULzBhN+ZL3qmvIcnqDqyLNUss3dIbWwyzYN0n+bNu6tdTYe4Iu/IbI+ixG
 H2JM0MXUoIQCpc0ICIFt4qkuM7zzL2nxHd4inYwUna8ZbSnknwGecrBvWRRrHUUWv6PqC7c+wsF
 af+x8LxbMdUDcPN8SKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150150

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
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

