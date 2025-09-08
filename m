Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B3301487
	for <linux-serial@vger.kernel.org>; Mon,  8 Sep 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349944; cv=none; b=ACpZL9X+3mtMEC2UpJen5lRw34BWcrXyhRnsJrxe8GCYmaUd+OMdAWbU5G9o7/+IzuoCCTOUST0fGaYadpG+/oc+bWPPcjbWRd6ONTytfwXIgngp8z0MWLSjbRWQcRYfkYacLGILHNP3T4s5VfuqKQz+shlCd/inr+HiTIAstwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349944; c=relaxed/simple;
	bh=6PqMLWKDJtKfVT+GHF4Y1k5/ea+AFwqdR62kduV2yF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1j7sriuc4a7QzSazY6WY0MsstKbgvDruss7bluMn2WsesyDFXaFkGcO2OSNbXSGRtfHgcWUzduqK9nOfx4EopqjlVjMa0udarNwDI2uqWNBj3M0hDvXUhEIuDyyvQdl6NQIwqu4bMPv/vM8gW1+ISyYfpS72HFHL42F9Vk6olI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cF9r0N20; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cF9r0N20"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588BIHCW012763
	for <linux-serial@vger.kernel.org>; Mon, 8 Sep 2025 16:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=34Aw1JEvLQX8Jf7s5ppgnDzivC2hh4Fc7ZC
	M6ufDdzA=; b=cF9r0N20D8+R7qV0LuaJPtmTWTyirlUMuLt4CWP0DDtbTECV4Ni
	6a8S4DqTNuh2niaw4gb7riMZlFcZdMy0HRj5iJakGDXT+fucFYKswdgyBgpRX6fC
	m+/WX/N4clA10mffWpvAoPdzN7fHCDILpp1U0jk9Uu0cApIc50B2tHkjGMfG8jAj
	HLNytukr8EM3VcjqDNkE+kYMIs1AVXJSnIKmaFxO021wnx0X5XYEYfCV5V59nNlV
	ByE/75TvK8Hj3mRR8qOmdhBIUco5AbiueOOsjmOp3rCpt2Epmf96i7z9LkTYNHwL
	ca+zz+VdADBY3tabIxfjIBHYPSH0cHShaEA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdt4fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2025 16:45:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24caf28cce0so113646885ad.0
        for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2025 09:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349941; x=1757954741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34Aw1JEvLQX8Jf7s5ppgnDzivC2hh4Fc7ZCM6ufDdzA=;
        b=xUCjJlX7oKQU1rOfVtB9rLe7cktF97Qk/KtYatnVq8VX/T4wTZeofsTJhWUAPqSPFz
         sicXNp9rdMpn1VapEV0ETgW6UsfyWvQBZJ8IMUHWvwsgKzouebPGJ+4+FTltTUcYVgSQ
         LHHT5+fs4Pquc8Q0OKz6AwpkFsWTWNO7/IK7I+22/flxdZPcEsZ0AgCk7BgS2hI8BE00
         zovpikbu/Q7cA7W4sO0yUPcU1eMKe1ss9NXsUFhasZ+DmlJFPTd2c7lvVdhDHrbVHVjQ
         jnOrwKZPvjK843vBxzLaZWFveqwbfBwQCR4hZ21FweTeXFX0kAiEyx/z4UptngV+bANp
         Earw==
X-Forwarded-Encrypted: i=1; AJvYcCW/AE1bZ8EW6XHXiZ/BZTDph1me5DEZPRsQrihFcujBGpwOBgzd4+/RuhmeIxW27kxpBdlcZSgOxkwCoHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDS7orstFwz3zRp05q67g4a3GzIo9GGL1HYb9CY3r1i0pHVU7
	LBAyvkt5S0Tft9kd7jzSyIcUk0BecgJrdegu1euKLnwxTZ2+nhdKX5+mrzN/QE5uVjpqJKVfB0h
	MeZ9T8MZPsDwA1MXs+MvYB9mJ8ld5jGIVRwja88vd9+Q7XvCtno7TS6aMxF1ugZQiqTg=
X-Gm-Gg: ASbGncvSNzC4Ec29yUNftqn4zolnvhaGgVILHhMuHp/+8LyTezBVNnw+GEPvtRLaQ7i
	S7s4WPZudgomEMyTW/101eBfqSP3rNFJLWpIZuONdgynrr7gLsxIm3fJToa1Y0UmFaa94f8qbg1
	sQ9gmfAAVfF7yK40jyiTOWUySrBcrEDCwwMSIkb07R0ED3pj6lkieUewJT5EdZEOaEcUEbJVyZj
	rxPzkp/jwBNb4/X6R21hQNRP5ofujlaH4tLMkR0mbh2m/VODWKth2VWw2BzXb4E3lFVofSfJJn3
	QCRYubJ9zlSFBBMdYzHXIhi1YvalobfhkFHQTKK7ue3DlHIyLXFg9vlGXRLXVW/4uZLFSyEUAw=
	=
X-Received: by 2002:a17:902:db03:b0:248:fbec:7ca0 with SMTP id d9443c01a7336-251753ddc6bmr114524865ad.52.1757349940877;
        Mon, 08 Sep 2025 09:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KvQs9Tv5MscTkp53nskEqyMUOykepAr5xV7PIPByLyoDaC48YY8vt2347cxTMkjP8lyWfQ==
X-Received: by 2002:a17:902:db03:b0:248:fbec:7ca0 with SMTP id d9443c01a7336-251753ddc6bmr114524405ad.52.1757349940303;
        Mon, 08 Sep 2025 09:45:40 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24df9e881casm91508045ad.62.2025.09.08.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:45:39 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, alexey.klimov@linaro.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime resume
Date: Mon,  8 Sep 2025 22:15:32 +0530
Message-Id: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6l2K6PbVUtEluoWc0lRDq175bGMNlx5c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX6sqSe2FxnOv4
 lMVakFrakW9Jf9DRCpy7E4WD11N5gOOfi/TcWgiTC3MtOTrei+MgTrkWNDmz9+8trkVvknuT8s2
 j2AwTLoi1ZvuaOFLvBCO8BvnRiWSr4FELhPo6s+8qesRtQwEGSbQHaNT2zQzGUlT+IJv45i0fbP
 YfQ+LOTp79qwdRPj0KC/tquONfX3pfypxKUYGvbouG8FgBtHd9rR7nyS1OiEc07jTiKuLSmOu+m
 DzW/AxHoYvX50LuzSbD58X5qWM6RcETuBgqgg3eaGNNwJ96da4877tFOa95SXb29sXunAC5kkbH
 MxikWw/8ihkj6zTYp61E4iSkcS+3T4hoirk3fOHzWOv+sL3uwbY/gWkDaNC5MYPNEZRP3zb8SzY
 Oe9sl5bN
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bf0835 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wCWT4eE_qC1rGXKMDvQA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 6l2K6PbVUtEluoWc0lRDq175bGMNlx5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

A deadlock is observed in the qcom_geni_serial driver during runtime
resume. This occurs when the pinctrl subsystem reconfigures device pins
via msm_pinmux_set_mux() while the serial device's interrupt is an
active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
__synchronize_irq(), conflicting with the active wakeup state and
causing the IRQ thread to enter an uninterruptible (D-state) sleep,
leading to system instability.

The critical call trace leading to the deadlock is:

    Call trace:
    __switch_to+0xe0/0x120
    __schedule+0x39c/0x978
    schedule+0x5c/0xf8
    __synchronize_irq+0x88/0xb4
    disable_irq+0x3c/0x4c
    msm_pinmux_set_mux+0x508/0x644
    pinmux_enable_setting+0x190/0x2dc
    pinctrl_commit_state+0x13c/0x208
    pinctrl_pm_select_default_state+0x4c/0xa4
    geni_se_resources_on+0xe8/0x154
    qcom_geni_serial_runtime_resume+0x4c/0x88
    pm_generic_runtime_resume+0x2c/0x44
    __genpd_runtime_resume+0x30/0x80
    genpd_runtime_resume+0x114/0x29c
    __rpm_callback+0x48/0x1d8
    rpm_callback+0x6c/0x78
    rpm_resume+0x530/0x750
    __pm_runtime_resume+0x50/0x94
    handle_threaded_wake_irq+0x30/0x94
    irq_thread_fn+0x2c/xa8
    irq_thread+0x160/x248
    kthread+0x110/x114
    ret_from_fork+0x10/x20

To resolve this, explicitly manage the wakeup IRQ state within the
runtime suspend/resume callbacks. In the runtime resume callback, call
disable_irq_wake() before enabling resources. This preemptively
removes the "wakeup" capability from the IRQ, allowing subsequent
interrupt management calls to proceed without conflict. An error path
re-enables the wakeup IRQ if resource enablement fails.

Conversely, in runtime suspend, call enable_irq_wake() after resources
are disabled. This ensures the interrupt is configured as a wakeup
source only once the device has fully entered its low-power state. An
error path handles disabling the wakeup IRQ if the suspend operation
fails.

Fixes: 1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..4f5ea28dfe8f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1926,8 +1926,17 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	int ret = 0;
 
-	if (port->dev_data->power_state)
+	if (port->dev_data->power_state) {
 		ret = port->dev_data->power_state(uport, false);
+		if (ret) {
+			if (device_can_wakeup(dev))
+				disable_irq_wake(port->wakeup_irq);
+			return ret;
+		}
+	}
+
+	if (device_can_wakeup(dev))
+		enable_irq_wake(port->wakeup_irq);
 
 	return ret;
 }
@@ -1938,8 +1947,17 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	int ret = 0;
 
-	if (port->dev_data->power_state)
+	if (device_can_wakeup(dev))
+		disable_irq_wake(port->wakeup_irq);
+
+	if (port->dev_data->power_state) {
 		ret = port->dev_data->power_state(uport, true);
+		if (ret) {
+			if (device_can_wakeup(dev))
+				enable_irq_wake(port->wakeup_irq);
+			return ret;
+		}
+	}
 
 	return ret;
 }

base-commit: 3e8e5822146bc396d2a7e5fbb7be13271665522a
-- 
2.34.1

