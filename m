Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E7385D9A
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606056; cv=none; b=smJPF/H+FTKzpnvRJB6+LCshcG1r58mSO9ZoIcNLEvp+hihLiSDegFQ+NLEHNoWcRFytgZvzuOfNQK+lgJVmedfhQ8arfcn58NVOsPqB2TnW/TnRLk/vhQRGt9LNqkeG3JbYFt7RCMJOdTt/SVryUvZwW41UHKe+H70pxyOouYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606056; c=relaxed/simple;
	bh=vtuaOx2zVVLYtnylYkt36kWIEs/b1ctEamglNtENjmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bZ/iEWcdAFKCGEgfwapZE4ZDQgMH7a2KMDvTcfGn//cgRKzip0zPfCWtztK7lVylYIwqStxQaCBqWTUIyFfz6bIORvMbX+sNNwQqzApF8mbyysoqWl+RI3d5lmHKanKfPmvd73LKr9kB6pOa9eHawVBHqe8C6gEGk1IBoTmil5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IRUctPmX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NcEdFuR0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IRUctPmX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NcEdFuR0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCA7lf144593
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xaxy4PVMEJ71BCLmllBAGr
	+bhPijTMsLDG3ItrJ6hbc=; b=IRUctPmXMvYAGWwncwm8CXMpSsm5YGQm1H/2i8
	MyhHi9sUO1wSrdA9CG/EcZlVc09PF8zTr9RKV8AMn4ikVG2AQ7UkUdz8SKfBQ2o0
	aH8JfCWFsfZiiCd5OxW6BLOXRNuYwhdiuT4YuP3CcdhhSMKexsuu6Xft/B2lt448
	JYzB0Ty3NUO5vFTsWV3Tkf9pYYopc0JhjC1gnac1drTRh88+/C37cztTO84/nj9N
	8mONT+mcCe/UcGF90fr3A2yq+9+N/XJPuCleq/DlhvWqrhSE/qbC64uFZwz/2N5O
	nSQ4MwlRyMGiMs5+x6RgXGUcBmP5aIBIHjAZ6oHXDU+Nu8sw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp99ep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 17:14:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba15e384c7so34688295ad.3
        for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778606053; x=1779210853; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xaxy4PVMEJ71BCLmllBAGr+bhPijTMsLDG3ItrJ6hbc=;
        b=NcEdFuR0o1qRECSXwKb/knSlnjoZPpuG5zR6d4gArnQjXgK3q2AqtfN4iw09JusR7p
         DhAmm9O2F2M0TP+Dx2dnQAl5ks/Y16t1b+9OSnGJS5/IyCoPHQQDlsFBTHdnG6esGLns
         NJxMJSb9GF7tjJCBQHG9hokt8YxKYt/ouUkz7wGlmT+tkLhbtL3HBdI/rh7BIjQt/oLT
         toaC5/lLwPjDZrvWe7maJHRYj9RYXKxRAB981KZ5avWY5y4J2pvtjGWDGr0MXu1Ts0h3
         VACKXhxGBs1WrjFdfh7dsB9XKMIsGaKIx/5lv1xum6RUxphCuK+gu3c0tkxGQERWJuxH
         xVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606053; x=1779210853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xaxy4PVMEJ71BCLmllBAGr+bhPijTMsLDG3ItrJ6hbc=;
        b=iY1frIa6x+wrIz/fFiCuGKIgASodWiU53bhrHGPuYtZNrDWupRFH2pL85VcNoa2de6
         mbQqU/9ienCRtBuoeVsjknDn5j7JjYBqTnsC9F7+mnEXuDKvGJA8w68akIZXFchgKCGm
         py8gCGoV2w7j+t3pkMIIQL7uzja5otxYXFg8HHUlByXlxM7nB5FbUgA91cZwKxwgOaD8
         KSxHnbHbzv81yGb3ss343ZgjUAOkHT3KpZsRQ59FdOO3AEMbX4k4korcehTuJxDzGSPJ
         p3h0VHzMki/S91QCG/Zv6MAswA8NH1LufwVU+2alfDBCxxOJAlxmgDfAwTa/hQ9toAok
         21pg==
X-Forwarded-Encrypted: i=1; AFNElJ+zxWSyDtK2F4KUG0W4gmJ6sRfPaDvO25ZGwRZU7u15/C5vnhcG0YW9hiMeh8ziys0PRDFlZI334ClBgmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAA5xxsWm8QINxL/WcrQshw+oB11FHu0ebI2E/OXp2c2jwdcR
	mK0dIG1TalQ+60+7vEc3DNvEBsSTcyvPvxVrFbER15tlaEsALtXIERhwtRLpttSzfTsGjYSSJ+f
	jg5Nb+Fw++U5tORUz5dMLxcE8rdYxlqXaoacyzkdJcT+LNVXBVyHQWzkfhQJJOi68gck=
X-Gm-Gg: Acq92OHuXkxQuIHTLx2G+0I7p/r4GofBozjwZaVwtJ6hBqE/bfRVG3kcs7Iu42auNCq
	rWPBp/L+i33KDuj8S36MLuYJLasVex1a4cKtPWwu3w/2dWzjwCCLMLiJMtZGStFFXrzYZNznNRO
	+murXtlsrNPcGoAnB3giOA7tcoaBUvccUtgia+fe5Z2MldleH6nu1S7Mezqqc6oybVNEHsVfzjE
	B09dqFHMPvX1zKnW6DUszHQULJJa1RendvuSE2nqEBNc1NKyl1hbaDV6lOmPV8hg7Vje/QsPsnI
	6hw9LY6SwtSSt4kbdWcU+SNRLin+bkt7etWYCgaSu3aUY4Gr7SSOaVnbIFsC6Th8xJMA1P283zt
	CtUVQHFr0rLm1aRN/A7jATvWcfkSBZnNO02iLnKyFdn5QRgVF1Xh5OYU=
X-Received: by 2002:a17:902:d2c2:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2bd012adf2amr46522135ad.35.1778606053084;
        Tue, 12 May 2026 10:14:13 -0700 (PDT)
X-Received: by 2002:a17:902:d2c2:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2bd012adf2amr46521645ad.35.1778606052497;
        Tue, 12 May 2026 10:14:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40427sm149996685ad.24.2026.05.12.10.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:14:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Tue, 12 May 2026 22:44:02 +0530
Message-Id: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpfA2oC/42NQQqDMBBFr1Ky7kgcorFd9R7FRdRRBzTRxEqLe
 PdGe4FuPrzP579NBPJMQdwvm/C0cmBnI+D1Iure2I6Am8gCJeZSoQbTNLB4U9Pk2C4BWudhrt0
 IHVmG480McFOF1hrTotKViFeTp5bfp+ZZRu45LM5/TuuaHu1PkMn8P8GagoRMqQoxT5Fk8XAhJ
 PPLDHE5JjFEue/7F9afCmzfAAAA
X-Change-ID: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778606047; l=2651;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=vtuaOx2zVVLYtnylYkt36kWIEs/b1ctEamglNtENjmc=;
 b=1vgcoHwOODA6t57siZRa6W/GL4U/w4xLGXDDYeX0PtZJfDJFsWC1a0LPJQ7/fHLdwFMWcT+6y
 6lat1NRRwu8DeXyiTXMjhzw7M+mqg91Z+W32BLhF0dsZCjAmrw4SiBZ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: Fo5nRxU9y8UNvHovE3No21c11Lsjo-i8
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a035fe6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RLcLI9r_3EWR4hCO9JsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OSBTYWx0ZWRfX9FWeS0Gg+hZA
 BHRXPCiX0pb5H/xK5lKHUr54AGPsIFfkIlQWAWRjWJD5y7hjaDytn/Gvz4EDAVWUc21ZcqdIngF
 K1kXgVQQaObyURY/6UFRgipa2RPXRqkujWL2tI68mgfVrDLmZO+KCisSsCIke4YYX8xk7XdRu5f
 cV/ykhZn8rGCOzb7mSjbQO5MNU2EHv6JSLxHTmHcThYu8UtDp0Q3kvbr0BnHI9ryxPBeGmwz37e
 NaKmIqJXedGvqoWaYXvCzMAQBibsY393bPk94kOuIzCBUk+RN4U5wVShfggmuEqsfyJ66RpSGjT
 2rhTOloqkB8U5+8+IhNKEVNqTerjGPHWMLsVsgfNz6sm5Jt1jZrzUK6WGG0KKg3gKn/QFi4wuaG
 gD0mu8ztCKlMT/sovmKfqKAPqrqBKwqFu3O6u1hOaZcskGDa+juvaceERezVJt27G0N28cGQO1H
 ZYEYu6L6OR6GO+BarkA==
X-Proofpoint-GUID: Fo5nRxU9y8UNvHovE3No21c11Lsjo-i8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120179

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
Changes in v2:
- removed multiple trace events for TX/RX events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com

---
Praveen Talari (2):
      serial: qcom-geni: trace: Add tracepoint support for Qualcomm GENI serial
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   |  27 ++++-
 include/trace/events/qcom_geni_serial.h | 172 ++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 4 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

