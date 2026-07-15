Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0673B1EF2
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089528; cv=none; b=hqQXitlCyLAPpm0gtFlMUdakN74PDfZ3YP0aDyJHvSWn9ViR8jaTVRLwnCKxE+p48UtThe/DwRtlNt9cx/2W5WOSqjJO+l98Zt84WvGFAC1BJAHd7QwaRfZ5G3NaIr+O0a1FzTYTVRAm10MhKEMVzO5b6/TZBda2LlGblJoZM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089528; c=relaxed/simple;
	bh=isgiWVv8eg/ry/KcN3nqJ0LarhMHhngG7XuTjJOZypE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXCLHo4keFCgeGpFLmIusHyWXPE32V8Fpbp3wV1IsX3DgoU5grdwtbC//JHIDBZx8j1t4O8A1ndfAoLRsv74VFa7mJT9KYEygBUGcxGDQAaY9/N3U1Nf04jIEdp0ugzQUgW6QPp6TjDmdjVBvESi2NSmO9hFDGtwM+rCbFNAbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mD2zyW2H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NkPnTSzk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mD2zyW2H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkPnTSzk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lJRj2405269
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o0bZJn+gd5gr14r1blwfsd9DGfSKmSKm7GbYkCSyCzQ=; b=mD2zyW2HgatxMajV
	NJmn+UpwTYMg27cdlJxG23lx5EX3tEUa59xgi9ijC2eDL+DmBJv9bem5sy8d2jnN
	Psvjwp/qCMLe98V5r7wRstJyPQEyzYcIsEPlM+9WW2vlMwOA+itJCTel6nq55kfo
	M+JNTB8Mb4fIFiaSoAMWoZddSgpqBGppOdt93T8g11aRRdWAF587IPiK8GRdWqse
	3aYK3OburKT8SlRbyREabOP5WUNQc8GhABI0ooeZ3Z6BTVpHWPz0lEpDsZ1hfQAn
	uSZNqRGaawS3m2/8EXuK4/lquAC4XpK71Qawol1Bg/IQsY5pDWM1pDAPo6AsoPcV
	WF+XFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnp0jyk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 04:25:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2caf4173b1cso31799545ad.3
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784089526; x=1784694326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0bZJn+gd5gr14r1blwfsd9DGfSKmSKm7GbYkCSyCzQ=;
        b=NkPnTSzk5eSrz721sp5PT6qHnBcA87+ZgDwIGPFvW8Ryfdo3UGIOYxJY+Mz3e1SLJK
         AVst36ubYHwCLxhYTQtJPxyxDvkaxkzG66iEcJCuq4gUcieftVlET0jG2gQkgagyHajs
         D6njs+l/Jx0eMyKaL0Nvgvr4FtCrg+ndlQnkfElVJCpTexphwTl/OqoiGva3ks/bT18t
         6cssAyBTotgEF3zMTOQecmpoOAScnIBZpDFqD4LTx+qYdTg/3w9weq8PROMzSV6FRT8s
         SlHbJvcCxdi/g8HiTIpKlE/c2IutG/XiEULLSjlDAB3WZs482VXnuH5MyPhMMfZ5a0nM
         KKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784089526; x=1784694326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0bZJn+gd5gr14r1blwfsd9DGfSKmSKm7GbYkCSyCzQ=;
        b=RVdNwubJHwwQPqn4rcTF8eRBE/9j34Kj152Y1AaNbbZg6Sv0w30scMQGUpgfCDceXB
         4R+1Kz6XXg5JgYZYJS1fbRCtFc7XyL0jU1Jsm6fcDDg1AWFDqpCpBghv8HcgWuCD/jjo
         yYFg/O0DNePcv0Q8UxWKT/wRaDMJK+HeRrsN8PQRfzuz+1XXC96VGPf+w+4bVJmQI2oU
         wkTAuhtwIUcJyDAIfzrzgteSgsqJJY76rxNWNDRqz6eWUImZu5oSqhM8/HIuvZ2qdBP4
         yUF0rcv4ss0fbhdBXMWHenap1CwLRDu84Psk7FpEsJ9FDNh0Zwt8ggKklGIxRuKWSlc8
         uUkA==
X-Forwarded-Encrypted: i=1; AHgh+RoW+Gp/B2t23DKMegCbTEj++Qz2DMiF6dxjFZSMOR+UogzzUSb0wyQdWoSr4ngddAB8HzTQEv+NsjoQ6N4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ThX+UVIKSNpq7aAD8jujItkHUj7JkjQ+s7iw7KaP4ljEM+pd
	fFXXE8/PtgI0/VkuX//kZLOBk26FkeCRBGDqrSIgeH0GuWwMQtzIF1UtGcMBUIp/aaZEwCx9q0k
	cOqBixeD1yD3UwcKka3lDgUqylZRrvG6GNsL7Qozp4wlp1e7dKi6lBHb731lv5wzixZU=
X-Gm-Gg: AfdE7cmcb8AFnvnmIbcoqP3Dg1VfKN/GbFFsa2uHbJPSuQCFrf7i+bcJ5pJPyWqg8r/
	uIhKpwIYJnsdmESxm51uLrIUWwCr5794ZFRBZGukSCpQP50UoSBaoI1p+yslMpBLGzy2WfGIICi
	UabGRtpG79t+Ii5WeAuc52uhnhikbUQzAmsJNkJY49rmV5+agiZ43Twolbp3AzD+Rr0y2BTW3I8
	sZw4MuU2QQpnif3RGBOXrVG2UG5/jVi7bRSQaMw82Pj53TiTNtj+Yi6mtIfLtKWIaqm42lKJlMk
	iqkcAKfx+pkj2iI/v+Ib6JUvVEJq5X5TraGMs0Kj5GY2wCAp32ISTv+ETIy5VG7xJNtuX0NGKW0
	Z50Z/04Ft3UiPsyTRSBA3evqboO66JzRmAcN3ZjLXGxao
X-Received: by 2002:a05:6a21:a346:b0:3bf:9e25:1a19 with SMTP id adf61e73a8af0-3c1108c014dmr17974644637.52.1784089525938;
        Tue, 14 Jul 2026 21:25:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:a346:b0:3bf:9e25:1a19 with SMTP id adf61e73a8af0-3c1108c014dmr17974621637.52.1784089525426;
        Tue, 14 Jul 2026 21:25:25 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm62395491eec.24.2026.07.14.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:25:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:55:14 +0530
Subject: [PATCH 1/2] serial: qcom_geni: Add shutdown callback to quiesce
 hardware on reboot
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-add_shutdown_and_panic_notifier_serial-v1-1-23e3787c7109@oss.qualcomm.com>
References: <20260715-add_shutdown_and_panic_notifier_serial-v1-0-23e3787c7109@oss.qualcomm.com>
In-Reply-To: <20260715-add_shutdown_and_panic_notifier_serial-v1-0-23e3787c7109@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784089517; l=2248;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=isgiWVv8eg/ry/KcN3nqJ0LarhMHhngG7XuTjJOZypE=;
 b=S5lzLJH9S+DrJtBka7ar3f2lcL0ZYQmESc1NUaGbusqnVF+KveRaDeZS4RfYpNeTqsyTrqkZ1
 ZEdjky2QGUXDvYxjvSxivAem6prHs0971X+eRg7VgQARgOmz8jLnLju
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzNiBTYWx0ZWRfX3nKfJ7ZVEcSt
 Y/Tafo18Qvv0pD8OcKEF/IkpO/WloMj/+XDqLNxUiqze7nDdzkGdKITE2XCH2IjhFX3wWSb6E2x
 VMFLTcqeeNcp1QdDpcfL/V93phiAhUk=
X-Proofpoint-GUID: b9yD_3TtR-cRS9sxRM3CLDc22I-L5cHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzNiBTYWx0ZWRfX7sw99qp/bxg2
 QA6EFOXAqK0u2t7ZMy3d7ic9EK6ZaFUZX6nhHGNJ7grQPANvDOO40IaujuFMxEP0GdUdPXYRDSp
 CiB4x+bHIdT7N525x80so8jBfV/nDlF7WZqCH3v4ZolkKCFOoURCnxz0IyIwSoovrfxWyTqJafj
 V7Oi496AAF4SHhQZc5/nL1xywhVECNYFfSN9QedAj5sLXb8m9vc1iUh8tZYc76jL5J+yETgFQtP
 0tIwvVUzDxI39GqDHZZ8FwtSTMUWqmakQVU67cD9Iu/Nr8By3pOhgnurJzkxgqvQF4G3K6OrhFh
 nzWKM5YBSXWML3NRT794+fx7QAxlekf2EZtLLNmp9iHh7JD+qgn5MHR8dFScmw7qF3ni8Xiayjs
 9aZNB5CPlDTVxQudrGXrcTpG60ai8IS2knRwSlvKZsfbME4nXEG+f0QrzhC1yKmmx+7VSY1Hxsm
 wzulwzpHidHe7tRMMUA==
X-Authority-Analysis: v=2.4 cv=FtM1OWrq c=1 sm=1 tr=0 ts=6a570bb6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=yFGuIqwZ_iH4-3sRbD8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: b9yD_3TtR-cRS9sxRM3CLDc22I-L5cHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150036

During system reboot, an active UART DMA transfer can leave the GENI
Serial Engine in an indeterminate state. On VM-based platforms, if a
DMA transfer is in progress when the VM is shut down, the SMMU can
raise context faults as the DMA engine continues to access IOVAs that
have already been invalidated during VM teardown.

Add a shutdown callback to stop TX and RX and bring the hardware to
idle before the system resets, preventing both hardware state corruption
on reboot and SMMU faults during VM shutdown. The port lock is not taken
here since shutdown runs from process context with the device already
quiesced from the UART core's perspective; instead, the runtime PM status
is checked so that TX/RX are only stopped while clocks and resources are
still active, avoiding any register access once the device is runtime
suspended.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..21ac2e3bad81 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2049,6 +2049,18 @@ static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
 };
 
+static void qcom_geni_serial_sys_shutdown(struct platform_device *pdev)
+{
+	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct uart_port *uport = &port->uport;
+
+	if (pm_runtime_status_suspended(uport->dev))
+		return;
+
+	qcom_geni_serial_stop_tx(uport);
+	qcom_geni_serial_stop_rx(uport);
+}
+
 static const struct of_device_id qcom_geni_serial_match_table[] = {
 #if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 	{
@@ -2075,6 +2087,7 @@ MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
 static struct platform_driver qcom_geni_serial_platform_driver = {
 	.remove = qcom_geni_serial_remove,
 	.probe = qcom_geni_serial_probe,
+	.shutdown = qcom_geni_serial_sys_shutdown,
 	.driver = {
 		.name = "qcom_geni_serial",
 		.of_match_table = qcom_geni_serial_match_table,

-- 
2.34.1

