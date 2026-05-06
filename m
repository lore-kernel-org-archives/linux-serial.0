Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B624A2E3A
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088304; cv=none; b=KZaUdD63wppaCzg/AYltzlDDTOzooUwklZcsb1656eTp4V+m+XoaCRLGOT409d1VgFMo6QvQzlC/3xgOwTO7SG9WKQj5q44qfyazysqkI0PL4/kPWrzyq2PJGx+8hqlme4puad2JOSGs0oFaJAKa0Im+Vr70Etq5hbT7levyTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088304; c=relaxed/simple;
	bh=+AZ7HP8vxs7weUtdsrjpH50Vk0P8ZMYChRlMTdxE1CE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jzz4cTvMrUWRzp+jhVu042N8QunpDwuS611ijQ2ZATMGeFjGYPM/Ewn9MoYBBmGfQSF6L5MkyPSe9asG62ho9LSXnm3cBzvCulKJeAjM5B6qOLN8dEcwRHrtZrcRczoWEfupwUSWsKYPLjgzBtKxIMAJ3bPMvAm+TSGEjLIJbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZMrbSaI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jSya5nHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZMrbSaI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSya5nHd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646EFlHS2427624
	for <linux-serial@vger.kernel.org>; Wed, 6 May 2026 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O7Ga15NSFXzMxuZpJT7ZHF
	6f1emO6pmsZRbxPGcXR5w=; b=dZMrbSaIUEhMGECURKe5lEl+n82UJYfJMhRRmk
	WikP3LerVq/yRCRUVYYSzHZoyhvYKGcF4qsqdTpoVnpOnBQjqTyxsKevDwl5SvuL
	pXgXSxJ0yVo1ACZx7tIT/IH22inGWQ1OU/sfINVTOSbGmxjg5HpToFd4mOyEI0Tg
	CfKkVk8s+pTv1kB3IJOzwqyjzF4MArmr7KIafxeRNcmy2MbduBUuMnESwuDiysDW
	x7TmZeudTJEi/vYz45TkIbuPIl7K6xTzYbgwWWWY8psSXnDeqqBpHAaGcyVYzWBC
	R5cvUypX95rOcGmyab+fd5vgi5Nnn7wW8vGzZBbU2YNVOBng==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph27d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 17:24:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-365290bc5adso2100088a91.1
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088297; x=1778693097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7Ga15NSFXzMxuZpJT7ZHF6f1emO6pmsZRbxPGcXR5w=;
        b=jSya5nHd4sncEBdJWdyASW2+JObHaTZPHLF16CoZuMkdgM58bdIOX5fwVZyCu3dqyf
         w4C6BbvH49CSbkrHemJ5zq+lsEhZgzDjWADjXf41R7a1fBRL7ElxWvUPTs9xIUqmVS+B
         0/qNRZEG1RP/UMiyNlI5FuO8emhsEz5QS+nj4waX3WdS5OOlGnYPAY3Tus28Zbh3OedL
         HuNH++G1e/yYRg8mwsKYvZUwwARnVsmHUtkUdpJ1k9FybdHxdvn2px9/KQ4QFQ8P493J
         KIOiss1sw+k/iNUpHTLOvR2Chh/7EF5S1xf3JcB+tmqwVubTrzBzd5JLxOBj84m0D9LR
         iUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088297; x=1778693097;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7Ga15NSFXzMxuZpJT7ZHF6f1emO6pmsZRbxPGcXR5w=;
        b=QD9AJ3L85Quiz/0m75yZeJFy9pmiXMDQu+Il1o414jmfvqnsG2LhgHLW+FvbP/EFRt
         JCwzeDKAY7QhAiAN4gXZOb7uibpkq/7ywv/HAd2HnhL81VuYKImESLZy+aKPJ/jtbXpU
         9IggjJJ05GGJARwDahuoLNir1XX/+Lztq5UFCvpJ+EMs6zrxGML1eA6akDu35HHwivI3
         Ljebi/xRLj8g/qhJ7e5hkAGobEa1RS3gF8BqISjQJkwBPiNXpbl00VmyDGKIR/kHHwq3
         p54bE85PWS7zmk9//ZKiTYEzbxzGX6kRgyd3Go7QWATyK768kRSGg2hCpzUOWOg4qlPd
         DsnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mN2NDzBdYpupsLffl8h73bk5M94Kv3UEWhR6TqJ80tPu2CVIt3TxIAi/uWnGjHBF8tkAiqthxEoAEMMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdj6qKCu7rObHKvqS/XJreiAvvZZ9fe25ZU7xfB7P3dQaeESz
	bIYfg7ZhO6ffb2gLlL01GlqaF6OKXlxgjUwOBJ5DVJm7k6Tz9gQHjyl+Uj8+3iRdlGxLIBr2pKY
	izfggXd3H7FzpjRuLIsisBCPUoTIdvLdvT9+NjYvU1WaOifwuckMXToKocjxdyXiKCGY=
X-Gm-Gg: AeBDievKa9ynWAxTWJ1RbgewWaw768n4jGDkIDnb7uf89J6F60WCdESeS0Kjgh5iFla
	Ig1hiExfFr00GnxljLIrRowpRHNFHDYIPMsdOlSIVMo1yWTF6CPglWW028M382iWG6cW4uvbSaq
	8pbcWKyVS5Rj17jGykNW+V26QJNZrNxiESTVYMMQZcFM9fqj2FYAEHyDRzm00rXbGinoWCfLTCm
	THXRS7zrodlN9e7RhxO74NBEPTaDj4QhSsDzh0kWe51MXnZJOlDd8WvBCHZ+V//pHpuCMbgwUq3
	83YHjt7If39n0qJHKDhFUkB6V+8zsXyqgjVM31xBvBMmO8gQ7tRXq/5TccYgwYm9uAaSfLDK7sW
	WkCPta/FFpiD8TAVsPb47KtTrBvIx/ERSLFrE02gGJC9+ttTDIvRuKKMbpupw8PMrfA==
X-Received: by 2002:a17:90b:3911:b0:364:aa5d:7d64 with SMTP id 98e67ed59e1d1-365ac270394mr4325142a91.14.1778088296279;
        Wed, 06 May 2026 10:24:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3911:b0:364:aa5d:7d64 with SMTP id 98e67ed59e1d1-365ac270394mr4325089a91.14.1778088295496;
        Wed, 06 May 2026 10:24:55 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c9ad13sm3051948a91.15.2026.05.06.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:24:55 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Wed, 06 May 2026 22:54:43 +0530
Message-Id: <20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFt5+2kC/x3NQQqDMBBA0avIrDtggjjWq0gXMRntQE10IlIQ7
 97Y5d+8f0JmFc7QVycoH5IlxRLmUYF/uzgzSigNtrZt3VhCFwLu6jyvSeKecUqKm08LzhwFb81
 98Nl0RGRNN9IIhVqVJ/n+NwMcBl7X9QONXh1kegAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088290; l=2401;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=+AZ7HP8vxs7weUtdsrjpH50Vk0P8ZMYChRlMTdxE1CE=;
 b=vFHs2/S/IHwSMm2C0TzZmarhzpoiTlQdxnVh8yDl5yb/fW4SITagb7J8JD2fJZZFAgzjnw4j/
 MMI56+HksXZD3pwQ/sYVWZkoGLBn6d6+B8Aj9GhK3YYE98ZBg5++GYO
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OSBTYWx0ZWRfXxp25opOavTkB
 581+h4CROAyEO2J08j2oKnwYp+17TItmzVYT/XUCjUn08bttV6oSpTX2t11nj+Z4Zuidye1dprW
 QOOVXnArBbtYU5dgf/KYVK+i4STEKR2bZMKI30HLbfeLl6vtUoC/27Xj2mMhU5CtNnAZ6O4stLh
 KuIpBf+UyISfsrXxH9VqVkomSptJV8fC0Dz9tgF5SO2yW6Y6E7hWTz/ad2Gw9oacYkg+Pkh83f4
 U7ZzGtnZM9XC+KZHuumpybDZyIs4hghvUXtfk9Vi8fH9EpBUjvWFuzVIUgJ1gkJkKQf31bV5KDX
 k6Z33x0g8wqdfIfampq1d5uKW+FvRUlcAQjKKRTsoD6CPPgKfoRPz/9alkI02E+s84RwCzq4Ccg
 5fetXowtVsSaJcqeZ5zLTs97vp9nOY1bjsTLkArSR1US8wQCfNvwc0rbIlfQiRN+d8FWeG56hP6
 8NSX1Uann45SouI1QVQ==
X-Proofpoint-GUID: nGMm7VIKm_XkRnW2UyRk1gmaddQFljkl
X-Proofpoint-ORIG-GUID: nGMm7VIKm_XkRnW2UyRk1gmaddQFljkl
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb796a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=RLcLI9r_3EWR4hCO9JsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060169

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
Praveen Talari (2):
      serial: qcom-geni: trace: Add tracepoint support for Qualcomm GENI serial
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   |  27 ++++-
 include/trace/events/qcom_geni_serial.h | 173 ++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+), 4 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

