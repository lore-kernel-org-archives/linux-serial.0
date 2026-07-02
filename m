Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FE46AF3B
	for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992538; cv=none; b=YwqUoVy5sqEWXAMmzIzwsgrpA+zQu4jR8aMelYgjtYt5CFe5p9F5KLcQ6P9qVEJcHzTySbbgw7rHVfE7KA7pWK+2GG+HjNJJDxkfrwhniF9hQzvyeEolLD7RodlCer7XgMtGh7hGjWbe9YXSpgrjGSWMdYT77mowM6fPUV4Swn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992538; c=relaxed/simple;
	bh=HhI7UpvSknhnFNbcEbOCngyE4YZQ9GavkB23UFY2kEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IJ1PH1GsKw3Md3m5ZjvJUx+S42IemYmmrF+S5H1rDkfhWl6Dz8qDgFqKihnKsbBry/h7NB1gQf7LBrLRRT18QO+ldRcDhI0kenhq6i1TcMee8uYbnc13MK3+qpahQJ1nzK3LYJhFnUCt9bK6T/I6tW2QK5PIo9BwMdCbPhQ6TYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e2Z52gn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AcjpJDF5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e2Z52gn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AcjpJDF5"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AVWjJ3591605
	for <linux-serial@vger.kernel.org>; Thu, 2 Jul 2026 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nzxpecyep97AV+PFFM2s8J
	7aEQ5A9VbWiiK0LxrKfB0=; b=e2Z52gn86L4F4ZMZns31DEk+vE++kUUKogqZtc
	432bhBqVlrpjdNOYsru73wTFEurhecPBV2LyghMfGTI8kJUY/k36UwLIq5QcwsHp
	+mShEnB6Dp8LsXnT6U3c1/k3cKFSFNUhJewvjq9Rwu4TJHp/BdtiI0ou1JHMylQv
	HhmTmfFYvDlPMcaINbY2Sfm0adjodlPuUs4ioPlqxwaUFbx+4EMHW7OAqJcz93lx
	ByCicG1eDM0ZIX0HuOrU4nFGYYJru9Ioapkf75/v5beODoeyFfH2o5mw7zQnKDx7
	do3kKcI3g5A52SeCQcoJtEygeIgcIk658ukQL1Ba/hHz4akw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9gsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 11:42:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo3675665b3a.0
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2026 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782992530; x=1783597330; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzxpecyep97AV+PFFM2s8J7aEQ5A9VbWiiK0LxrKfB0=;
        b=AcjpJDF5tSsr9RkZ40dZ7TAKdSXI8KGLTcUStHuigaT3yRGWhLrHWkQdKbfjmouEtx
         zNRwqQNfe/4U3upxczd0q7PzcnIPV+cKyF5l1hF4B5dC/JROniDipk0dz9csx+pKa7fu
         R/CSOXVoAiWjTiz5KNM60MLm6x9qaDWjsecyNL42DaVZFcSOQOFZ1ytIWsQgt4G0s57s
         p09Ua4TCLDJ3ilnQnUNLC/eUwGjZtCyh9Pc/kUV7tkbgcL2RPKkx3aR73N+BHU5Dp0DC
         evt9/b0nzDHNNeTPeKhDR7Y5YTaIjbdJuU2ztZ5ZHwNBNmHlDDqDMd+nxkqdkdHKFghV
         dIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992530; x=1783597330;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzxpecyep97AV+PFFM2s8J7aEQ5A9VbWiiK0LxrKfB0=;
        b=RV0YX2YUhRLwcrIA02BuOg7KG4wK8pck2CiGmEgRDTJmv24dtMRfedBWJ6o1mVxE0Q
         Zk4p4Pb0ZQz3Nt6IHvaQ6+KJtaeUtlUFZz1VFv2IzjgQ+kYkxPKHmChjlMKxuPIyB3N0
         TEPQCynsujT5zCm4c39G+tu1+Le9cROh/loZxxadJb+EPG/hVxtciQAs3qbGeR8ec6k1
         J8GxKz7dFdDd1ND5HB3Q6xFcq7BcYr04aVyi39kKAtKIx7s1cnmg5qsS0MdSHjEmHYYL
         z3v/Txela3+WpSnd1/402NQvTaieEGoHEWlOPmmIFmv4dImJH47EC3mm3JcyIVbyZOqm
         2wdA==
X-Forwarded-Encrypted: i=1; AHgh+RqHKSdyD3PmZxmgedi16tZqxBsmUdnRjQ5y7B3MpsM+wAK2RXuVRcR36M2a2wc6JKlW96UYP+a+TYodJrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSLRrQBI4iBEDVcRorkVI2bvmbxCKVmxolFe4qFeZW7OO2V2D
	He00rbt7YVIV8s2LeWZIsVSiLn5xFqz3q2ZjDCIEtSMgOlkzoedZosrvsDuwJtSZXijN20WgKN5
	M/XGX+O+yVhM+tK0cfTVLKuyhRiODAdYmJsIKIZEDZlooegWvvTCw1vueiAHCYRNNySAwbEGNZ4
	A=
X-Gm-Gg: AfdE7ckN2rLORQq5PhZ2dn5t+fbimNpf3AcFL6FA71GOrLqo+Sydw09PohU/DpyTszz
	feUCZEx1oYEqG69WEBlNu4xoE45ZG2RpteH03+G3ud5ekSKcUD2u3oM0jwww6YVMwOqUFyDlKHM
	lmfIJUAea+ZxiC1frWN1ly206vuqSptkLgh6CU0SULOIZS48BMtoIR7rFdM0/CmKxwtgjf3supV
	Kahng+VbJ9u3ytr3I6HiogxsJpo8eqlo47p88aBkgt1aFMwlYdjMqmBFdr/qgz5m8E02jileHhT
	yxZKRx3b0cm51+CJc4Ec/VMKnvpXhM4jpMLPNzw1ChIB0OEkaG+A+OfvngADCJEz+0pulvTip6E
	LfpTPsdO60KQnoQgyL2ADqkkysw+Od2F8L0IdTfMk9U8L
X-Received: by 2002:a05:6a00:2e08:b0:845:44c7:5e28 with SMTP id d2e1a72fcca58-847c5105992mr5024520b3a.31.1782992530237;
        Thu, 02 Jul 2026 04:42:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e08:b0:845:44c7:5e28 with SMTP id d2e1a72fcca58-847c5105992mr5024485b3a.31.1782992529663;
        Thu, 02 Jul 2026 04:42:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9db855sm1231089b3a.55.2026.07.02.04.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:42:09 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 17:11:50 +0530
Subject: [PATCH v2] serial: qcom-geni: add force suspend/resume to system
 sleep callbacks
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-add_force_suspend_resume_to_system_sleep_callbacks-v2-1-b79e254a7015@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAH1ORmoC/52OWw6CMBREt2L6bUlbsIhf7sOQprQXqQLFXiASw
 t7lsQN/JjnJZObMBCE4QHI7zSTA6ND5dgVxPhFT6fYJ1NmViWBCMslTqq1VpQ8GFA7YQWtVABw
 aUL1XOGEPjcIaoFNG13WhzRtpWQqdJelFxkySdbgLULrvfvrID8aheIHpt6etUTnsfZh2q5Fvv
 UMgZfwfgZFTTuOryXQquE6kuHvE6DPo2vimidYg+bIsP9NhbNwNAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782992525; l=3586;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=HhI7UpvSknhnFNbcEbOCngyE4YZQ9GavkB23UFY2kEg=;
 b=LvUsIrTmtABzRNBUXaRIRfbnulkMCiI3DcqB6m8s9ZtDYXqcfNHjMeLXGbbI19kXC4nML9vjr
 Jrlr6rpzxJSCZZsHtRKH50Qqk+bZ8mRWdd4NCtKor9mmEBKUXDSfMnp
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMSBTYWx0ZWRfX31si6uPbPqmT
 1toedu6JFhb8AdDWbXmeOOCY7QRL7RaNYOKjWVn5FDXHH5fmhU856wDfiqyjPJZNw/jIx46lf2W
 erxk7ietFBZBZ3rQw3uJ76JQJG4vokSbA+Utbm2j6tZrvLzMGC5kdThm1Xzsp5Auxjy4QWV02Mq
 douMnkaYvR2vm0hWTL72aiyaTnizdh6HJmG/kj/Ez3LHDcWELI4PwuyhpBEryiEAcMnvqKpcHY8
 1mH1ZkCwv9Lf1js6aOD2UKdgzVOZsk4tzv124zzULvpM5uT2bZeX1PTk/lDph9Q6K069F0762Y2
 I09DnvBBs2q++QP5P+iiqj/z4Nt4jkFBCSqjyo3UlcmnAEAZi58OCOkfm2FeMQkeV5H7yq/veJy
 kxnqO/KXbj4thKFrt5V669xNNurVUADReLX/GsyjPZZzZ+e4LF6V3gkqtzpCTwHFr07MWwp4cmm
 uBZxMciHjEXVUgtLtTg==
X-Proofpoint-ORIG-GUID: t11QiVG-S1gPmDWJMN9a95q972rPHNDZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMSBTYWx0ZWRfXzQEXrgTLBwGY
 wvZvCZZVGztrCpvAjHvpFFN2bbyeq3P6kONZ89me7KgWB3Zlb1RK8d4r9qFJ8ZOsa3Wu3Qp7ezv
 0mTebltFEroLOuSBJ+HWMPcuM9RvQrE=
X-Proofpoint-GUID: t11QiVG-S1gPmDWJMN9a95q972rPHNDZ
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a464e92 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=rFQNHX_iIj8PGKCmY4cA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020121

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
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20260701-add_force_suspend_resume_to_system_sleep_callbacks-v1-1-38c9a721a462@oss.qualcomm.com
---
v1->v2
- Used console_suspend_enabled instead of uport->suspend.
---
 drivers/tty/serial/qcom_geni_serial.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..55c9d716bd89 100644
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
+	if (!console_suspend_enabled && uart_console(uport))
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

