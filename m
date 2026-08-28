Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0935C69E
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927549; cv=none; b=k4/YUcw8EBXWMdFOo5uuqgc4WB6Cefq1dETIyCv2rds7flQcKn2+te94Cl8Ig+snkia+1iukBvh6kDk0VgGOVh16diW9jG4IM6z630rel/9ufEAxZZrD/fIXni1FDrnFr43GVdwW1BsZRgCXni2ubkmRo0Ob6GEkrDVROgj763s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927549; c=relaxed/simple;
	bh=zsmXCPRsDe+vrSMpkrR/SKA6swtHN9aDV14WU1G3cCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oOE+q0Nc162W6e967Vit7JB84A43CKnSZYiOYYeMbU74OowooDMuV7iO7WijJChY+w+7H1M30cuNP8OLommmCd5kMNqoSJMErW1Uju3MPfAwiOqJeOpvFs4Fq5PXd/cufziqEeGjxENbrfA5b8uDJN5DxBBUY99RHjJ0AYHljQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HArCm5zq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXdlXsdl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HArCm5zq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cXdlXsdl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDkcni3790198
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HXukI0MtwTD3BvyKqizU81
	C8XBF62MTXfa2zVlFQEVM=; b=HArCm5zqtVwN5UjxpqvHpaE+8OqhWIvHnQnHrE
	xqD5EXjgH+sZZGRINB8vn/F9dz5eUpCo2OULHCovKjfnye/chbVbW++mGM4C+O10
	vdK7Pk56NTymbIkC8sjkcfBgudxQYnV4ejBdAvvzyuXXECbkyyJJReNQ7kkeNJfN
	lkApZWSzeRDKHEry1qcYai75YclSABqow6ePgG8t2Kl8YvnnIEtV6joZbjyl3Tvt
	OHlj9o2hJNbrBSrZptA3K96r8SwrdYGvI6mMLoSgYu6aVNs6iwzTQTtzbwH8rYYu
	S7wqp6jnjZoU3xtY2sP9l4ZMpxBd3/kQZEWO3DgmCyjEmjXw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42pa0p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 14:32:26 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97c83bdfa6fso813049241.2
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2026 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787927545; x=1788532345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HXukI0MtwTD3BvyKqizU81C8XBF62MTXfa2zVlFQEVM=;
        b=cXdlXsdlCKsDW9e8mu6HvDaiv1Dwvmk3uNlOrV19TSLXqTL8sL4A45T/9yrBF4JRD1
         q5zGtJvsumL6BOkw12P53mUbPgQz/xx2pKN6eGkmQ/+zcgebN8VxB/Kgjj6ESd1XocKD
         ZSYeatbd99wtxz9j/yMVRtRhLeBg75R8IC/3LlMoViOnNmrA6yTab/TNHCruVZK0ZGcU
         yAwNAwqoiRcLGLH7w3uxfSTDiRU46v6oAfTBVsJFaO/7U3lyLHiVZjqK9KACe8cS+NNn
         32oj7alKlCCJg4bYQi+TXLWlAOCwndRqT0IbWvwE7ybSzfS+bOGoLHF4JfrgTd7gqknm
         gxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927545; x=1788532345;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HXukI0MtwTD3BvyKqizU81C8XBF62MTXfa2zVlFQEVM=;
        b=KzPqhk+QyseI/HHfLkAQHQrjleSwfdM27hgfoDjZNQWqet2jXoTrOXEdiEmoC0aSqz
         ZtNF3bN+BdthaWJDFMP0Ukmysiy8FOfi8T7BDJDcyR7DbgoOUNldlrvMrJt2nrp9iPUY
         biCAUXgipJmkOWaqmewZV6OIj1JSQKBeSy5fsyB30To0StvveC0jDC2/41pXzTRt1+ym
         WuZfTR4s6coZgJHsENAx+0EhQgi/KhT/h9hRzLfFIH/S1nHiz/O1kBHeOs5lFB0NShtG
         sPn/mVtmv06AfnQ1DNB/CyhCbg4esqthz6fAAK29EYEduCjjqlFIu3nDk/V53WxWFIwj
         Wozw==
X-Forwarded-Encrypted: i=1; AHgh+RokphRmYW2djZz+mkpKpUkxjjfV3ShA62cdGr63lahNDLwmHCmQAXe19W70H3kGREN/GSRoW/ND43N1x7w=@vger.kernel.org
X-Gm-Message-State: AFuF++mY9YsRgoFDWwGwFStg3cNUoEcR75huee0p5HNjIRjXDdLwaUiQ
	e2RHoGrtsTv3oJ5vJ1bVcX4+1ipQtrX6YKaEY6TFX/f7jTbw7C8CpjCXNlmLlCl0rTreo6Kv4Gf
	7GKGqS5jBHp/iqotyBjCA24RdtOLGB+Ju6NXQyKLCsDtBsPdv0af5UCrcgn7sg/U115I=
X-Gm-Gg: AR+sD10bnJ82G7vp253XbLrpzShxAM6lsV5g1IxthgsU5vq0QFFR3Jswj8hVsanuIRW
	bih5EjVCEM0v1aK5US0H8MGBRdtuDPqWnyB+8ZcyXHvmpzdtwvAVoHf3AYBJntIw7krTJte9fd9
	jJ0Qu0kaqF5vjbAGqCUfGFaUuPmCw3VA1qse3gmc+cBwEHwdvFFMZRQe1k+y8nD5wjihY4dQJdZ
	HOWn1JaXAabcIsziUwtJUK927RlEqgDYWjokxwPmw8G6YsPXfcE7SYBSqBv/YGkKXmIp/M9fNNt
	1VheVEE1Zgvuvv3e3uqqlWBEJ04aUh8Qj3v/wpgMm1xvBx7JstM9sB3WcG0x9JikeCpF3ZG2RMD
	QNDFsTg==
X-Received: by 2002:a05:6102:5109:b0:778:636c:71cb with SMTP id ada2fe7eead31-7859872c8cemr2486243137.10.1787927544838;
        Fri, 28 Aug 2026 07:32:24 -0700 (PDT)
X-Received: by 2002:a05:6102:5109:b0:778:636c:71cb with SMTP id ada2fe7eead31-7859872c8cemr2486187137.10.1787927544118;
        Fri, 28 Aug 2026 07:32:24 -0700 (PDT)
Received: from [127.0.1.1] ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm137344075e9.15.2026.08.28.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:32:23 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 17:32:17 +0300
Subject: [PATCH] serial: qcom-geni: Fix unbalanced runtime PM resume for
 no_console_suspend
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-v1-1-af3e5aef17a6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPCbkWoC/yWNQQrCMBQFr1L+2g9pKiF6FXGRps/6pUlrYkQov
 bupLgeGmZUykiDTuVkp4S1Z5lihPTTk7y6OYBkqk1baKKst776b+OnnwCOi8E0+XGLvJhc9Bk5
 L4IRcAti2R5hOddr0J6rBJaHKv9nl+udc+gf8az/Qtn0Bbm92eY4AAAA=
X-Change-ID: 20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-814e630326b9
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=zsmXCPRsDe+vrSMpkrR/SKA6swtHN9aDV14WU1G3cCc=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBqkZv1296DBkswXagCOkTK18MdrFasYbvtQ3MVC
 emVBCDQ9DmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCapGb9QAKCRAbX0TJAJUV
 VmfVD/9ApGTtQ7ROWFhmetAvxXA45LyZq2CHEdbWlDN2sO1IZecNWNF4JqogY3VK/3rCWnQ+Y+F
 9eX+M8UqD3UtHumE/McNEcLl+OQiO+1k2/8NfOqExFLqo0UAbKrtS9p1unnDmiXU9JDzADJSX2j
 kesbI1jtrCZTSR7GVMKv/SP8GY+gC8+Hcs/BHZG6mbWcjCkFDbanxpd+Wiyn8pc6TUCbGm6yQKz
 4JBAQNxWwEu1LkAQD9Hoz11QDqrn87ZgTV0Oyjwk3j4ryjSu9jNtoFo5I2exksVTJ+zL8mj6vg7
 6t+arXl6Lxt8TCjmHL+WFEnEEqa1SAhDn6eWCli3qcFaMNWhaSNpJZw5FR+IJbvGTUDx5jSILH7
 wLHOGSQs2a5lnMZAKvtu969/13GBSXSw1+oshAXjx0oq6hzGMCdgpALGsY7uy4wGboaU4CO3sB7
 vZYqIv4ey5RTEEhfq6fHTKBqxfEyXIm58FIV/Bpx7V0QZV8o3iDiutUaFfCTiZHApkJ8YlRE6J6
 0N4Qti4p15NjU3x9rd6CDrtsbdU6EYYd0TEi5XtSpTMh8qEXYMZvG9BpAK21rM4JVMcCcsxFEH6
 maIVSim6k/rvXL6cwJX0/fr/aBHc6xIrB2dG9pmGTXOzewo89cBJNmlesSM36f8Ma0Z3++YnhxT
 5NVKdvBWPuHRCrw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: Wj_wHDAfEvebVEypgtsgkkaVGEmWczzM
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a919bfa cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-2yc3nOPJIj7eM9l8gEA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: Wj_wHDAfEvebVEypgtsgkkaVGEmWczzM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyNiBTYWx0ZWRfXyE7JtuBeF/zZ
 5PqH9GYFcyYWYrj6HNOa0Tiqxu7IAMjm66nFQdscpSmOUdmBuXEJ+iRhkxIjUhRgpaED22+sbTG
 k3WSUWP/S2U+KWCNZlKSG1B/+F/OezE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyNiBTYWx0ZWRfX4tKKga7Jr7wV
 4O3i827eIds78QzqkY+4/WNOmmlF2lWuzkJHOlpOoy3iubi60EAbKd8gyTD52uH/czGQPg/jhk2
 59C517nIJWIYwcrS6+B3y4V9hv2CfiPWW5pbTqGdvD/Xe7vLWQKrGaS+woyo+2/ZaA6FsJLie9r
 9eQf+rTQxN0oVy6VPn8bTe1LUNizbTxcyGtFANcL1LwxUIJonCXeThnFnISVibyG/BcTae+A8J9
 pUL9jFaUtDGPLlko1f72ubR5uOCjv+xBaFJrTMxCI8EpRQcBK0NHyhuGZ54XPuMdVU745iOI3fH
 VYB2+0Pemz70qBPL2NLiGTEeamAiFdBGPx0dfxh+NpISidQruT3o7QHhZXih3gDt70EbeImqkOo
 hWDEso54tlehP+SiYS+41mv9GWPsfCsSMmpjv7eybIqKmHKNzkmn1CCmVgo2CTLA1wX2DENgDm8
 Tq3t/8rTTTLr2L+D8mQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280126

When no_console_suspend is set for the serial console, the system
suspend callback skips pm_runtime_force_suspend() to keep the console
active. The resume callback still unconditionally calls
pm_runtime_force_resume(), which triggers an "Unbalanced
pm_runtime_enable!" warning.

Only force resume when the suspend callback force suspended the device.

Fixes: d0cd9c8d0fd5 ("serial: qcom-geni: add force suspend/resume to system sleep callbacks")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..a180a00c9e23 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2099,9 +2099,11 @@ static int qcom_geni_serial_resume(struct device *dev)
 	struct uart_port *uport = &port->uport;
 	struct qcom_geni_private_data *private_data = uport->private_data;
 
-	ret = pm_runtime_force_resume(dev);
-	if (ret)
-		return ret;
+	if (console_suspend_enabled || !uart_console(uport)) {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = uart_resume_port(private_data->drv, uport);
 	if (uart_console(uport)) {

---
base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
change-id: 20260828-serial-qcom-geni-fix-unbalanced-rpm-resume-814e630326b9

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>

