Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D323A5E90
	for <linux-serial@vger.kernel.org>; Fri,  9 Oct 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529131; cv=none; b=Y97Ly4SafNUHL1gnQnr299pT9e9F457foH3vByw1cquo7vqk5EImXpuU9hSqVhz71hpwQqE8TlSHJglAu3i5EHsGsZQzQcjzDTITQjPiaI7vSWbcagkYcuCN+K/XJ7nswy/U5K9TG47ajL+/wZ5ZOROqthQLRJV1G9ewPjhnQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529131; c=relaxed/simple;
	bh=eKy7aW5cGjwegx4nzL/W7tmnNG2iMKFhFizCpsDBd1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QFfGEdc3M3oVXJzbqiwtbYIr4kMTrgT8HYluECqKa5/Q6oKGPe/izodAc0c9C+HpL3grdKCgoDnRauc7ZsSNYrYxYtczSpMuWuijsVoAqR9dnlaKQyHaFcTmvmRXP/KCPmpxqvmeS4/xFEr/ZY3uKgmK2X21YxiN7FbeCmJf874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y30A0ZqY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iliolux5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y30A0ZqY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iliolux5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HB3D1598074
	for <linux-serial@vger.kernel.org>; Fri, 9 Oct 2026 06:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4EYWCqhhTUL7OpT9NVgvbM
	UnffT1MdTryqJzCFDDtL8=; b=Y30A0ZqYdd/gkzx6Orn0/OWeJBI9y+DesxeSeq
	bsLFBcqYTUWPT3/XaUeKsCrxVnVefwJyYnEAYMDbt4g7KORXWfehhAI9S+a7epT5
	bFcDtNnQOs1IERAavPRKBxJj+vR2E5XBEdUPzqro/rZWcMeV3FLwwipP6qtKZUPt
	nMBgzgSABJINDa2W01ylJzuLrJEDADxXt6v+kNKnZd1553uyDmQUNCH2u7YSZwoG
	3j91sxK+LDC0xyiP3RbTb3+1kZO2dVQ2oaHNfjTkZGqO6ZoI/7gyM5nKEr/agXtI
	0s8KF6PeQ5b0hYfpviyS7VpqFqCbuHAYOlxs54SaPcOW/dhg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufs4t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 09 Oct 2026 06:58:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so6535046a12.0
        for <linux-serial@vger.kernel.org>; Thu, 08 Oct 2026 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791529129; x=1792133929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4EYWCqhhTUL7OpT9NVgvbMUnffT1MdTryqJzCFDDtL8=;
        b=iliolux5QcY8/cwrtEcZC5dcsQiY3efXw2fBUdZhEbQhcK/dJOTVMwLq2XEqAiE17B
         4XlS4Ph0EbUxWzA6N8GkoU8sO+yoJpLJHohu75Ap5Pk0wlQw+OE+l7YQFB43uuFOJsRA
         2QDQpIe0TIsl7PB+FHBDh9Ynfmzmj1xmxr4nx3F7Y3sI2uBmquF1YZZfwqttgL7fa9vC
         qB+XpxVVJ4uStdzzs5FUtWYR/EKjVsLQh2sdxm8HfoItSaw6cSTJ8cxOO+jJD5AWwQt3
         pfKDRTPBWPOumlUizEoTAL1ZLO/9Nj4V5/ZTG6qb9k7xz5BYZN7LIQ3ckFWvBstKkD4/
         dmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791529129; x=1792133929;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4EYWCqhhTUL7OpT9NVgvbMUnffT1MdTryqJzCFDDtL8=;
        b=WwoTsujZlC/ETydcx9IpycRHRCMwEeYmbXgyd2VectOaVQEiJzDBz2chc4TrxHMPgD
         YaSKw9A2J5Z0QdmgXHrGZPWvIp1PbyxEDSCpCbPhP8cLvSyObL0ksFMdnPjLtkFJFez7
         lKcMZ6JFVh6bEMi/MrevbwzkNrKvJp2ccW5gI4VPeaHsYbEXzt0S/ydtOmhk6jHJR0XK
         xvyFigbAkGB52DHzAYV1ZO/oAM/yuToyoZD0XVNdS8h/7qK085mCTDxQbHW7dRTLNMhK
         7lg9UQg9vK3CiBHceGCLHtw/+OEZlvJY3D0Evn4u08UFc3vV0ejat2Mp5EFCilgYemmf
         d83w==
X-Forwarded-Encrypted: i=1; AKwUvBzM422rG1C2Q2s/I1v5OCq4f2Zk9tDwln0xSOS0SxV+N2EluzrE7pA/iEvC8GrDvqLnNifsS7tvPTZbw80=@vger.kernel.org
X-Gm-Message-State: AFuF++m7W0W9OxnNo2ALYbNfvjhIqmBHfxphRsUE7nlpSlV1ZeFnksKC
	uk1Tp1Mp+jHMyH31nuR5Dp/x+br1mU431bl64yD/n8ZKvP+tQ8n8JJlUQ/UujzY3uclr6BuAs7I
	eFVz15oarQ0E2OM4Mljg7YNqi/3mxBoH80zl9of8n/HoVjF0E4Dbv5IQFM8GuDuWo2fo=
X-Gm-Gg: AYBFou1zfPfP8q80bS07iySx4hDlHYDOpVLnzxDtBajEAJFex6S3iajosmLbc86NXkH
	KH94Bp9YVxEu6cZ20hzLN2ckgkwfj+bHCxiUZR4gbSSMlUYL7ddU0NhxPCF/t7AAJTk/W6sw6Yi
	w13ctSI3MkKInlM2kId6rxIOUGWoCOgUsUKTAdAHXT8fJw1aK7YTfOu/L0/TIqjaslXvCa7wWhP
	v2whTRX4wkzMFwK4MvkxQ0yX458pmft7k0NCtmjp8caiWtH3eZ6QEFbbC3OBEST+6M2gzWwsxMk
	u2WYt2Ch+W6exo4PRHq+MdFdJhrWp7x4UEI2wQ8JYeb+I55/3bFtjKJX4PNPAjrVgEzQKZgmAh5
	Z5n3kWT7A9i5Q8iyFIl8e
X-Received: by 2002:a05:6300:2290:b0:3dd:a007:cb2d with SMTP id adf61e73a8af0-3e16be44435mr752858637.41.1791529129154;
        Thu, 08 Oct 2026 23:58:49 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3dd:a007:cb2d with SMTP id adf61e73a8af0-3e16be44435mr752839637.41.1791529128689;
        Thu, 08 Oct 2026 23:58:48 -0700 (PDT)
Received: from [10.213.103.163] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e088efsm499980a12.11.2026.10.08.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 23:58:48 -0700 (PDT)
From: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Subject: [PATCH 0/4] tty: serial: qcom_geni_serial: Add GPI DMA support
Date: Fri, 09 Oct 2026 12:27:52 +0530
Message-Id: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCQyGoC/yXMwQrCMAyA4VcZORvIOlaGryIe6pLOCK6lWUUYe
 3er3v7v8u9gUlQMzt0ORV5qmtaG/tTBfA/rIqjcDI6c74kmDMy4ZEV+BrSacyobxlSwhhbjEN1
 INPiJPbRFLhL1/dtfrn9bvT1k3r5POI4P6CsuDYAAAAA=
X-Change-ID: 20261008-add-gpi-dma-support-for-uart-53f2500368d6
To: konrad.dybcio@oss.qualcomm.com, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        praveen.talari@oss.qualcomm.com,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791529122; l=1956;
 i=naresh.maramaina@oss.qualcomm.com; s=20260316; h=from:subject:message-id;
 bh=eKy7aW5cGjwegx4nzL/W7tmnNG2iMKFhFizCpsDBd1w=;
 b=l5g/hTqngweTjeXJIqJaTcnNRfYdVfYBFtN7DqdkZc4UXHijLsdkAC3AjuumT3OhIdAiqJ6ZU
 Plx4SATFpBkD29JmeH6qNbeWpJrS/0Fvs3e5ThsUDEZhULKSLlwF3A1
X-Developer-Key: i=naresh.maramaina@oss.qualcomm.com; a=ed25519;
 pk=j7iST9yrLbsgWcWrqdlUNIOWl2WBl4wV1q35/n9SCkg=
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac890a9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CXWnIO0hCF0je_3tyHEA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX542VHYtISzoF
 pSy6C4X1qAWo+M/WqVBKnmkMe6N4SxgDOSeICrzzuc92Ilumv/ZofpTdpUiB7pKog3F5X4NpI80
 Wy/wHqwkF3zOJMb0WYMgLa/37jEgYQ4=
X-Proofpoint-GUID: msl9NuNhVu_zYPCwq1XgciIaEES3uEi0
X-Proofpoint-ORIG-GUID: msl9NuNhVu_zYPCwq1XgciIaEES3uEi0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNyBTYWx0ZWRfX1jZgo1Zk9z2v
 cn5IsoBSo4LyLNaoN+hv4TTT4GzZ3iMvGgfSrluqe99NqMObzBaR0225QQEecwMySTonNv3ZJ79
 4B/K1C4/8q4ZPfGycT9ScesmTo2FXzTxQY6Y1ErnTbBidIQFENViAezVCXO+3BSUiKYi0L/0Nc1
 T0COA/QdY6APBBcuu9UdeLOcXDTIFQJuKKBS5otcdlGLI5K498Sfdua9HTcJDbElETbRaV4NyJL
 qyNILltLOq7ocJe0YfdZEQX+IrIQbHVcM/9XQvdWyhB0YhQyKPvYuipA1fN0o5CCk28cgE/c0Zk
 pRMXiX7ARPQCKJyYq7yascdzWBksZ1eDAOgMG+/WfNevOewhqQ+LXYmLBK2Aq3eyVCnjWgP+rvP
 VMO0EeckggljCijNTt+SOuaoX9LnLnZzh4owY+7h3iGBOw48U4Y9I/C2mrIeqtiyhJZ71mDzbVy
 UR3F4Z03CrRvgsa3HQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090027

QUP serial engines support FIFO, SE DMA and GPI DMA transfer modes.
The qcom_geni_serial driver currently supports FIFO and SE DMA modes.

Add support for serial engines configured to operate in GPI DMA mode.

The Qualcomm GPI DMA driver is extended with UART transfer support,
UART-specific TRE accounting and handling for transfer-completion
events generated during channel cancellation.

The qcom_geni_serial driver is updated to detect GPI DMA operation,
manage UART transfers through DMAengine and program UART parameters
through GPI peripheral configuration.

This series currently supports 2-wire UART operation (TX/RX) and has
been validated across multiple baud rates and transfer sizes.
4-wire UART operation with CTS/RTS flow control is not included in
this series. GPI DMA support for CTS/RTS will be added separately
after implementation and validation.

The series is organized as follows:

1. Add UART transfer support to the GPI DMA driver
2. Calculate UART TRE count per direction
3. Ignore cancelled transfer-completion events
4. Add GPI DMA support to qcom_geni_serial

Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
---
Naresh Maramaina (4):
      dmaengine: qcom: gpi: Add UART transfer support
      dmaengine: qcom: gpi: Calculate UART TRE count per direction
      dmaengine: qcom: gpi: Ignore cancelled transfer-completion events
      tty: serial: qcom_geni_serial: Add GPI DMA support

 drivers/dma/qcom/gpi.c                | 153 ++++++++-
 drivers/soc/qcom/qcom-geni-se.c       |   4 -
 drivers/tty/serial/qcom_geni_serial.c | 576 ++++++++++++++++++++++++++++++++--
 include/linux/dma/qcom-gpi-dma.h      |  33 ++
 4 files changed, 732 insertions(+), 34 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261008-add-gpi-dma-support-for-uart-53f2500368d6

Best regards,
--  
Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>

