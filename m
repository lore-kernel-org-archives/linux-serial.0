Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98C361DDE
	for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2026 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885491; cv=none; b=V4GU2V8BwqLU/yFbCpe2tKjM3qnuUTRA44X8YNYkUSnjtqZEbZy/AqS4F3W1zcGBCNORlTk0gX95S5xuIuFBCFF01ne7Nci+HOcokWUI5YfB7tyLfh4UfUzPPAOHogLRFCHxCLex8M1Cvf9yp69CVFYnvwB7K4G/xroeB0mUhkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885491; c=relaxed/simple;
	bh=fzgLrdFqaGE/mRZaqKqjgHoSCum31HKjObovYE0bB6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FE5tuetCZf284LJuhgah/tbC23tmMS6p1hqACsjwyOFAYc6Ol2xz0BhcHq2OdfaRNsebb+YuXV0xiGeQeMT01BjWUdhYSXGrF+uGRiQOF4KCqOtTr+mAgsUlCXpmwbX8dhRLUuO2P0EQ33VUtaH5pHluo31aZ3G5KeNmat1HOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6dm5sSM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FFHGU8CW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6dm5sSM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFHGU8CW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lZip058560
	for <linux-serial@vger.kernel.org>; Wed, 1 Jul 2026 05:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=55kJi2SnGb1ozpyhdpZLPG
	5yCmn6dbu9QqA2uo11k8M=; b=K6dm5sSM6BOieA5aK/kIdWS5VfTolEk780PiRT
	9QWbhbLIVirDCNLmcPHXX5PUlkmbjVmh0LY7Qd2wFN77+H7eJKcNpUNL7a8XsBNm
	OQeDHDMScGxnR32Ozsll/Yrdl6UDA1lS7QhE+xmxKAG+onaRFzF+WwukcBdhiQIG
	Pole1MHU9NJTCi56MseOwCiKdfl5Pb9jM3PcuEkWqMWf3by+wZf/Si+xCvwChtdi
	ZZvFOn2BvcdAmOCpWmruJRPqoX27j7yEETp0LfigIB2ctAYp3mXQICV/Psxq015S
	ScbwoL/tuUuqAUySuzgJsskLLVvcgCB3oP42f3D2iOcbUm9A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfyau9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2026 05:58:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37e24235ce1so518278a91.0
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2026 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782885487; x=1783490287; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55kJi2SnGb1ozpyhdpZLPG5yCmn6dbu9QqA2uo11k8M=;
        b=FFHGU8CWcopuKyTmnSuWEgfBVs+PUbnXGLGrITX3aTL6ITojeZeNYanbSXEGZiqkif
         Ut5rJnFsrzTtutxhJVud9lg0LJlNJORciINEe4zgkxgZirZHyvF5QBHuxgvLzqLi1Y44
         yjkE4M3pT2FmV8CGODqLUm3sSybd+IZavjc/JXVIbzryg4wiG3TGXUNXWq/TpXK45Me/
         +6ZbRNawTgHC8CpceaCeifVwUSvS1XXUj+kJVlNewwHFp24Bwdhk/KWOTjwiROcjDWDo
         WNkkiLOP8P7bVU9ZcovbZ7gU/9ndkH3mjLHBSxLXnEInqkdpU3N3Q4MgC1iUNd1MEkGm
         mqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885487; x=1783490287;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55kJi2SnGb1ozpyhdpZLPG5yCmn6dbu9QqA2uo11k8M=;
        b=bLYKjzSwmMrN+na9keKlfaNP+r327roTlqeY0K/W8BK3mGzVaBSWWMs8//zU716xq0
         B9JP4TTRyEkiO3kSf5mHsi9p2TzrvO4OBJRGsM/YIqb5MR8yza+LoxUKgfcH8CG9/X54
         zpcmA7Tdq7660vTeb09v+Dk2DcFV/YC27q+texuW6Ntli7tafrUqv8BK9z5qeDXkEl0S
         /lhmma896EtOT8mOIxEPPC8Ro0RCx6UerRs0dLawkZIh3tyhiZq0fYNPVXj9sZEnq6Eh
         XKRU6A9upcVndkv5xHwtbQBG/EJPMMa5E6fbdt+PsBUIlavkGtc8iDua7Vnq8fWZNKg+
         qPgw==
X-Forwarded-Encrypted: i=1; AHgh+RoLmT8nynvXMvbej6tFssPuQfAwmqvVimL7sz09BMLHRexLMaRTBlitULyIgK55G67mAzOkNpjiwoTlW/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZt6p70qtUgYm86SFe/dmfYN6Ow0NBOWRsizS3jNjkZJ7lGx2
	zI80UxBnsl3n13IZl9PLJoQT1yMqF1MSQXvjD7cq+qdD7pvL7Cpl1aoC6ycDE5i9ttlr6Vn4sHF
	qm/SIZ63xy8wp7XIWywjwHaMgXSK1tQE7xx/fFb6aoNumGGq7Ptj6M/y41v5+K+dOYmw=
X-Gm-Gg: AfdE7ck709sy2WZ/wFBBeKqmWcuWodBHlClAdQsKZ0ToQj9apz/cNQnH5kiGnjlISLJ
	v8+q9E9IpIDHrCGvY9kq8Wum0bEh/xaH+QArEA54xT9BdeIpDZ32k225lBL2uanUmrOKJt8cbOg
	VMJhyd4LLJOY2kUOSXdRRC0WCHrmZQ36fvqpzIpy8zPqhfw4SYU0MJCmcbxytktUriTRmA7CTQ/
	yOADMldp+luV5YBowDkoV+1Bjk0oJYwerM+mH6YE4XRKFtNaNqPFB+YNn/u9Pn4zTNSuMTEOkfw
	mgbpNO0zz/OI7u+C29YdZDqWDR0yFCn1UqYfHzNlvy77NSMCVQgYLKsU0Y1/PLfLO5WXRYO8gUQ
	DZmicoV4hZEjCy7NHDJan+Ceoiyic12o/JDtF9GAAai4G
X-Received: by 2002:a17:90b:2e45:b0:37e:9e9:6ff0 with SMTP id 98e67ed59e1d1-380aa0bd330mr327886a91.13.1782885487371;
        Tue, 30 Jun 2026 22:58:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2e45:b0:37e:9e9:6ff0 with SMTP id 98e67ed59e1d1-380aa0bd330mr327863a91.13.1782885486866;
        Tue, 30 Jun 2026 22:58:06 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d76381sm1146375a91.6.2026.06.30.22.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:58:06 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 11:27:55 +0530
Subject: [PATCH] serial: qcom-geni: add force suspend/resume to system
 sleep callbacks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGKsRGoC/yXNWw6CMBBG4a2QeZakoJboVgyZlPavVrk0HTAaw
 t6t+vi9nLOSIAUInYuVEp5BwjRmVLuC7M2MV5TBZVOtaq101ZTGOfZTsmBZJGJ0nCDLAJ4nlrf
 MGFh6ILI1fd8Z+5DS+9qcDs1R75WmHI4JPrx+00v7tyzdHXb+nmjbPtLGCsuWAAAA
X-Change-ID: 20260617-add_force_suspend_resume_to_system_sleep_callbacks-ff2a94756306
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782885483; l=3242;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fzgLrdFqaGE/mRZaqKqjgHoSCum31HKjObovYE0bB6k=;
 b=X/3Xg2ml/r+mDoC7g+ThTtawJlEnLJwotN2atbbOrLAHe1lsqs6VkAND+/LoxoBjy2iHwwUR7
 dKPXSn+MiZKAPsI4htvdgt0qtHzaSNM4xoeuKpGl1dmgcm0Ro6Z3ZmN
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a44ac70 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rFQNHX_iIj8PGKCmY4cA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: QIcZloJVerQNnjJD_HwK0G5efRX78AkO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1OCBTYWx0ZWRfXyQMPSWqLgi8G
 KKXZOdTtH6unc/Pp5ipdAItUZ+KWtl3xnca+8TVPS7pgNdFuUSyUTckxvzwUFEEN6ybGvr3QrQT
 vswDfHPm/oVvAmSUS4CG5STI09qpbvc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1OCBTYWx0ZWRfX6BEs80XdBSFt
 YDYpnjn8ZrgQeQYmmTG3axo6ycBLRHSY3BC0gMGnM5Cg1lPwk3Unwg24G+QAh90vK4QZe9ySfUa
 doSrf9LO6ocyaoiO4oxDPocZXEVLJOcti1QiFv2Rb0E3A717n75bfMKOspktKWmc5J6eNQuXtHQ
 F8EmMXXepYl/LjTDAhwG/h5ThHll/5/DzxxdzKmZkmpANe2GS1/pk3X8GXBt1Z3ZCVZ27MD5t0B
 jw+xIz2NFUHw/+k4VPKYUFe6HteHT4V9SurNJQ/OhR+VHZMgvtDqzEKtkVX3s3hIc/tmEJoBhId
 Tj4gZE4zTTSJImYbR+eKx2U8H7emlxbB3jtKbrX1QSxaktR1HcPGjLTJMvqXK8qYuRQeoFv3CtK
 eVyM5YR4WeQ2/8LJlj6I7NT8/zDol3riAV/7hBPVkvIEq4VasJmOMpGDculb0Yc0607Me2IV07J
 t3rkaRjC9eBqq2H1Gvw==
X-Proofpoint-GUID: QIcZloJVerQNnjJD_HwK0G5efRX78AkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010058

During system sleep the hardware resources (clocks, interconnect) are
not gated because the runtime-suspend callback is never invoked from
the system sleep path.  This prevents the platform from reaching its
lowest idle state.

The system sleep callbacks qcom_geni_serial_suspend() and
qcom_geni_serial_resume() rely solely on uart_suspend_port() /
uart_resume_port() to manage power.  uart_suspend_port() drives the
UART PM state machine to UART_PM_STATE_OFF, which in turn calls
pm_runtime_put_sync() and eventually the runtime-suspend callback.
However, if the runtime-PM usage count is still elevated at the time
of system sleep (e.g. the port is held active by an open file
descriptor), the runtime-suspend callback is never invoked and the
hardware resources (clocks, interconnect) remain enabled across
suspend, preventing the platform from reaching its lowest idle state.

Fix this by calling pm_runtime_force_suspend() at the end of
qcom_geni_serial_suspend() so that the runtime-suspend callback is
always executed regardless of the usage count, and by calling
pm_runtime_force_resume() at the start of qcom_geni_serial_resume()
to restore those resources before uart_resume_port() re-opens the
port.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..ea8a1f0a9e3d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1954,6 +1954,7 @@ static int qcom_geni_serial_suspend(struct device *dev)
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
+	int ret;
 
 	/*
 	 * This is done so we can hit the lowest possible state in suspend
@@ -1963,7 +1964,19 @@ static int qcom_geni_serial_suspend(struct device *dev)
 		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ACTIVE_ONLY);
 		geni_icc_set_bw(&port->se);
 	}
-	return uart_suspend_port(private_data->drv, uport);
+
+	ret = uart_suspend_port(private_data->drv, uport);
+	if (ret)
+		return ret;
+
+	/*
+	 * When no_console_suspend is set the console must remain active
+	 * across system sleep, so skip the force suspend path.
+	 */
+	if (uart_console(uport) && !uport->suspended)
+		return 0;
+
+	return pm_runtime_force_suspend(dev);
 }
 
 static int qcom_geni_serial_resume(struct device *dev)
@@ -1973,6 +1986,10 @@ static int qcom_geni_serial_resume(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
 	ret = uart_resume_port(private_data->drv, uport);
 	if (uart_console(uport)) {
 		geni_icc_set_tag(&port->se, QCOM_ICC_TAG_ALWAYS);

---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260617-add_force_suspend_resume_to_system_sleep_callbacks-ff2a94756306

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

