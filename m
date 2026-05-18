Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FF38735A
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127031; cv=none; b=npdIm41f7EPH9Ez/J0JBJQanEcztO5drTnrgA841gOW9M/uYd9xq5+wJkqKCMHX0oFDYmjHEuiO8zjun2vrcusOSAcn9gZ8ekHsu4YY/CXr3TdUVDjL4z6A+mSv8EATeh9o2r82j7KQPSNNAwDRHFlLN4+JHh70ZTzk94rOudNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127031; c=relaxed/simple;
	bh=BDcxULYUwHPnQDZMNyXWoS4pkdO+USCnxIgpys6Vf58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PUovPHCY0Dbi/vNA2WM/V6cpcokmx97zZGpD8Z3D7JIg6eGV1DthIoLXmAKVqrxkVLiVXVI8hz+0T3YTfnKZgigul4W0WSnRbEkGxOoQwSEY4WxziG9T12COsGyESzF7XTsON6u2K9g6c0RvyzHpKTtkdOGzpLZZTpu/l2ORhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a/HaNgZJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XxG0ftF9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/HaNgZJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XxG0ftF9"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IH1bxA2685242
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=z5K7wTFmH8yAQCvybBcXJZ
	FczmG5iawgjYdYVhxTH38=; b=a/HaNgZJtxBJDj22qCneFRwD9NbzgBiE2qAbWl
	t1Ywo4L6eJ1r+qVy+HY5XZk80D3N+fspOTjr7SZ5gJSxZ/iehw3sECDBkcEar0lj
	ufXM055DXDdsMD/+F79VW+rztfJ4Y3/J1SIpj2qS1pV9kVXLWoWUUwuDwMPAEdvZ
	A/xWGzA/9s6HmFdwWkIj1WqZcJjnHPMucP9Qzl2FippuBDQA+GrVlBv05P1qWORS
	PZm/UjtgAFI8cu6EtycmmtoA4Zf/ARfsfPBPVHdKScPYtO9xN7pt29oddYkCE0ie
	NlP3oDffFJNJwbJmdnVEkTUGGfPIZLr6knjgwMnSxCk2D0zg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbu233-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 17:57:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9b8137828so28865055ad.0
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2026 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779127029; x=1779731829; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5K7wTFmH8yAQCvybBcXJZFczmG5iawgjYdYVhxTH38=;
        b=XxG0ftF94d5WRqw4/eYMEdw4QYEprCBa/v80pS9dw6BnGqxG7Fj0mRhro4KyFF+7fD
         +J/J+1qFvyiMQnSRB4Jj5ADNYCq7OaN2kipni/iBi001YKTybxlBFeRgntS4YVsnp4FD
         2o9+1mKN0fyA10D0O5aZ/nX1uyoybwx3ZT1F21bfMcmyhSCjfmPlobNqslc0U9nuzfP1
         kAqvZ4rEaBjDoznAnCF4MdLhNsb1472mwzd26NfImPO/qXcbKXj7nXRaKRPsD1teBLtq
         KAznr+BoIpI9Oq0KLQ+SISIOHtYCjNdsY3M7fud3SzJ6n4HsarCWPKcYj8lhRKtYVaqi
         DWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127029; x=1779731829;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5K7wTFmH8yAQCvybBcXJZFczmG5iawgjYdYVhxTH38=;
        b=jiw2uGc5FnAl3yO+UfjBgzSEPor4uGjfGgt22Qp1LYvdbgrdSe2f+yaudhergf9BSH
         565xPso7o3e8fh4g6Nrxetsnn803ofFvWvwUqtdlaq45xINZjj8QJIjOTX5ueIdL8p6T
         VwPI+EGBiLGvtUpxCN9Smb82xcSeyZmfu+2gI6bpASViGHQVsJRSziVjh7MjMlbFfmwy
         mvJLoANGBNGvU3RTbfaEW2YEt1AUBeuWtUDmbR/rSIC+PDnSIBbzioa8mNrhWsZ1SxmF
         70vo+0MgD5/T98+ZnGgU8ahkr4m/P0PbmvCUXZgFufQ/otMvfOcGU9p8cZesVDpMU0tl
         4V4w==
X-Forwarded-Encrypted: i=1; AFNElJ8y7PI5ZaZKaucyH3Q4EIZQQD7uGefVPO8+1E63QPElBtGY6Mk0IuOFPvClxbfREzB+O82YE82WQnMWiJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycpMYJXXb+JmhWNKupPq7dWyP2zKGunIQ/Lmmrovy6gAAwj6Aw
	nuQFB/a2gHV0EWtjvsA42f70OO3em79T0Ul+HfqxI9ooQ2Dk7U9C4FpITI+HRqqYICNxlFjpV3p
	XjN5/1KPN+7stD3+4p2Nnf0HYYztQcefcHG0ndZNMLSCHkByUw8Oa3Om4bXbf9WwWthc=
X-Gm-Gg: Acq92OFFegy/8ADL17L74YjcOqltTWL0feEPtp42l82k1s3TWfWf8R8YyLYtFRU5Pl1
	fM0NYxURNGCo+RnxbBBVu7/YV1DdmjGt3B8+ulDT2ukyS9P2aULpwN6cObAzIYa2bKfF305ilaN
	286fGy7kR8G9L0qP0LQZdjWxTzz9NhokqyA6Bu3zX5fDwP4Y1w1giWJ5/KDbfKmBxclh40kvz89
	GNrMCOwrXNTFMr5KtpmD49vR1IvlhCwsZC2/STtGgZb9UfN56zvoP2fbgrQq0h//H2Do1ghlsFQ
	/OW/LxImAQ2C7nhY+qtf1uCheU1xx/n8Ke4KTCQBPdoZYFrYCCbG5qcMpYMKB5SrDQNIghOK720
	mXf1C9+yoLkvswgevOXGF47Q4NNJWZkG8xWJByz1RrclCNBENoESYvT/ydXXUMON4VA==
X-Received: by 2002:a17:902:76c8:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2bd7e990fa7mr134128825ad.30.1779127028686;
        Mon, 18 May 2026 10:57:08 -0700 (PDT)
X-Received: by 2002:a17:902:76c8:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2bd7e990fa7mr134128485ad.30.1779127028075;
        Mon, 18 May 2026 10:57:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe4973sm158348015ad.41.2026.05.18.10.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:57:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Mon, 18 May 2026 23:26:54 +0530
Message-Id: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOZSC2oC/42NQQ6CMBBFr2K6dkg7lBZdeQ/jokCBJtBCi0RDu
 LsFNy5csJnkTX7eW0jQ3uhArqeFeD2bYJyNkJ5PpGyVbTSYKjJBioJylKCqCiavSj04Y6cAtfM
 wlq6HRlsDm011cOG5lBJZXsiCRNXgdW1ee+b+iNyaMDn/3qsz277fQEbFscDMgELGeYEoGGqa3
 1wIyfhUXVz2STxk68z442Z40I3RrTKJgiMrUlX/ca/r+gEIfpvNOwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779127023; l=2967;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=BDcxULYUwHPnQDZMNyXWoS4pkdO+USCnxIgpys6Vf58=;
 b=QazdiBa0Pe50+9QnwELQN9Hj99JAAk7jFbNDXuPyFFCnPn0/2S+EEKWLPVUmG/r9XdTtqqYcX
 kx8/dvAvbbTA6ZN7Z20KZ0rylFe7a34pqOkKCOBHfRhNa4qFcSlEooL
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: aeYqb5CGOU9xVdVc6VUr-tP2RU3UeEA8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE3NyBTYWx0ZWRfX6vcCAJ0PI5Z9
 QFG81jEO52Hy4olV1x9CdxPzZWYMQEjD9TT62n5ITdh+j+Fyua7mOu/h7FKQbKu2WVL3G3aPxCV
 3xc6Xf6KBRjpVmvl2yjNNLIhl9di4ru2uhl0wU54PcdZIr66VLBESx5hAX6gjuBB/4GhNeP5i7D
 Qg6VaZYLHdJ27E9knJEmRA/quEdZtbo066EYsSdXdzqlhTShEWReRGIHSkC8WSkwPh43g0jEkYr
 mrkCKAoliZ/9/MwGZ5M9yUyn0fVeANuy2rKoqpU8yhfGSay4znpkQwKt2Oy5WkVb6Wal6DwChQU
 y5bvw6Yowr1tP0wPUYLIPJvQWmvoBLjhStJIKvlqVRI2lZbL+ihJjUBTHuZBKKzyGPOONktCQsf
 z8q88/xzT30pP+tTjNIh1jZJP5b+h8utRYuX9yI6H9mCq6Cnw9PxIZ2DNB5Fn+wpo8ImMN2/R56
 udte9mIAZ56f1g+5g/w==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0b52f5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RLcLI9r_3EWR4hCO9JsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: aeYqb5CGOU9xVdVc6VUr-tP2RU3UeEA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180177

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
Changes in v3:
- Removed \n from geni_serial_tx_data and geni_serial_rx_data events.
- Resolved aligment issues in geni_serial_data, geni_serial_tx_data and
  geni_serial_rx_data events.
- Link to v2: https://lore.kernel.org/r/20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com

Changes in v2:
- removed multiple trace events for TX/RX events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com

---
Praveen Talari (2):
      serial: qcom-geni: trace: Add tracepoint support for Qualcomm GENI serial
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   |  27 +++++-
 include/trace/events/qcom_geni_serial.h | 164 ++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+), 4 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

