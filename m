Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636C3DB992
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675359; cv=none; b=eporRHl1FacRpXWWF9yJd4y12LS0e862xdCBQQBZdm71oN37lxoF4V2MYTKklQ6SNM4I4PxDtZEsj4A7mk9YSDR7sp2JZSpHn2VRVWW/fAqJy62sN7WdwiJWAPagzFQP21+laHxMONLrHJsAib85CAKV93GDSGTHcGqKWsXEe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675359; c=relaxed/simple;
	bh=RqyHW0IaMsqAhVvqhdhpa4R22HDdXI9mCD/eBUCRSlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=moBsLAZNZy2ONzQJqGLNeJv+CNFcbZLrJ34tg2jrigX6tvtox4g+5sDh60UZvfaZQ0XVgN+d+hXoTa0O7XktzH3mCWWFKm3aFUMZt7124b2Fd55B/YvC8IZxqoNioozxXYDHuAUojWgmFVQZ5NCJXWiDXzTX7AvNgGSBlMgsKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I81HjiLY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hDBqFcZe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I81HjiLY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hDBqFcZe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dSuK172472
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 09:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W7oU3IZfHQjETmHidlQ2tZ
	qPHO5HhZmNxF1CxZNhCYs=; b=I81HjiLY7FSVjvZu5xuyeEh1phAF0mptjY+t86
	YXBZEBTmwpi7XxYRiS9BR7fKadQLD0SDcI1CMJxMY/1EqQQoJ6EooYZILt/2t4XL
	LQbcQFNwniNRZKkf51jQO4/uChIl5rMViQhs0yuj/3XMDx6Fiy2mAB4oj2V2mEwC
	rbjBQgnXxkpEqFxGRH8VX4puMbTzJqj0nt2Ll2zBVei8PY85xIdKbDv0fw4n06XJ
	n75LLKahRoKbpxtjVA8EqLkuzIf/2NVv8yk+KZs8uR8x+mwQ2iGbi4d63zM1iHq7
	e8PExjYMJFp5Hu9ZlSp0uTAreWe27s6lxRYxV+J81S6eOkcw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe9srg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 09:22:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848693daa20so1889265b3a.3
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2026 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783675356; x=1784280156; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W7oU3IZfHQjETmHidlQ2tZqPHO5HhZmNxF1CxZNhCYs=;
        b=hDBqFcZeV+vfO0klhYDgygcf8nozgf3Os/VmPSCKGPqe9G14wSPUpbjhmHcoBd9hqn
         tCoAC3+5rICv6kZqCANHxhNhLGuep1kIauXS1Od+Go/YM6zKREX1Ils1kRLrdHcO4Ira
         x8UeDq8WAt7u8HOYsW4bohsmtNyvC0wBg0dnGOxjAVS/ny9vL09pXv49oq+OmP70/WGA
         yuS1k/w1xx02FTxaGE7WuoSnmYbopbiHFUoc/+IOyydKq3qsTImqfvwwL//VEQtdiMwQ
         Iho6B+evoNpl0mU/v0XAqTQE25Vs3YbusnUgVbFlO+/C90n6TjgWejKpiMHaDDAt5sd4
         bmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675356; x=1784280156;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W7oU3IZfHQjETmHidlQ2tZqPHO5HhZmNxF1CxZNhCYs=;
        b=d+VECVaLvVymKAr+w0q7RVhn41l5d+y6uy/pMCpy4t5rBAL1rgINdKiOZNwM2rUagr
         jE6xQqvIqHiKlWMl0VgSeTwFMUrXqsEJNUBFylsUDIWAb0qs8MFHcyi/PeA5VgPh4RS6
         cY6ruL6EPBbyJPEDtCs+vSHEiaPqqn6cl/h/E6TMn6vc71o28n0KcynMpj40BbESPL2M
         J7IRqD2AnTJ8myfZRUymRYuLHKLbEfrgNX8jnaECz6SH/52aAVEnucPs/MN/Hm2MOJUR
         7aB9f1Gg/MxxWNwRgyQmCwGJXhQ3rD9NNI+KRM5tCKHCXvUe1/eWf0OgPJ4h1WqK1Nqr
         hulg==
X-Forwarded-Encrypted: i=1; AHgh+RqDh8jc+fHkQTW/QIKNqcwlx4o1BKm8bE4QurTFvx1LwiEhKC1NFsTXnJehE8sMg8YAlgiNAhcGwQxcp1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPf9KKf8A0/2Myc0j+IaRAPVhRriF+fvZ2OZcr1L6hbhNaIVe
	GpxfwuKyW5m7XdYJDGSPKXt3avCXBzGUd7beMjhecVrNIkIJ0pJqXPEhyfypliY5iSktt4dRUDA
	XDahxLI8TaIKpDMmQT+TvCbXTVcl9SG+lG5AA8p1D/6lHsqDs0Lgvg85dkHKUyHNBH+U=
X-Gm-Gg: AfdE7cli0kdvxw/hiF0sPSlZb1L8vBYCcJlW86o3twUa0ZAlNsrj0Rr2hBb4YaMxAPE
	nDiipJQrotlHpqDUxqsoKlV75ANIyarfbr7oLz4+ncjTyLSbN1if0/hOw9yUARxlY/eZsFsDXSP
	GnEhosirMq1BSC6qFP12eZbq/SwkFAHyrAAumC48C/3zq2566r+gRWJzXbDNB0RN5BtlFkLGRsW
	aK3CKZ6Ud+TIUl9P7I9UauG9OvUhQf9zPX7Tb4Ua+Rmi0S+WI7JDal1Rsh825XOwjB6gmyfsxwi
	ZqJkzlgkaIclBdpOm6uPJ0h231YsNVfKa2h1SFrY3A1UuHpnJzBmTcIFy+eRM+wEF2f1KH1VWad
	ClOyxnDca84t8N77xKjrLq9N7tCah5OSrbMC1pJKDb0Zv
X-Received: by 2002:a05:6a00:1884:b0:845:c5d5:3745 with SMTP id d2e1a72fcca58-848432dae99mr10916254b3a.34.1783675356358;
        Fri, 10 Jul 2026 02:22:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1884:b0:845:c5d5:3745 with SMTP id d2e1a72fcca58-848432dae99mr10916230b3a.34.1783675355795;
        Fri, 10 Jul 2026 02:22:35 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4edb4sm9959355b3a.33.2026.07.10.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:22:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:51:32 +0530
Subject: [PATCH] serial: qcom-geni: remove .pm callback, use runtime PM in
 startup/shutdown
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-remove_uart_change_state-v1-1-8e8468da22a1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJu5UGoC/yXM0QqCQBCF4VeRuXZhNWirVwlZRjvWBGnMrEsgv
 ntbXn5wzr+SQQVGl2olRRaTeSpo6oqGB093OLkVU+vbow/+7BSvOSMurCnui2iJExw3Y0A4HRi
 9p3J/K0b5/NPXbrct/RND+vVo275s0YPufAAAAA==
X-Change-ID: 20260709-remove_uart_change_state-a1f7e783aeb0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783675351; l=4513;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=RqyHW0IaMsqAhVvqhdhpa4R22HDdXI9mCD/eBUCRSlo=;
 b=J8sMP5fCjVG7SkRW95a1Fs6z48yLiPE93pufCw/TBXoDZZGZrEuUYNJH8TGVXxd3Jlyl3fplh
 KdwWnT45ADeAjxm2EF3J87Y608RZ0aGjBlKaJxdHYT4u6sZJFEFU4U0
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50b9dd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Lm143-4zXO_JaeHAvGEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MCBTYWx0ZWRfX0T4vVK/AE8I8
 K/9rQ9+RyQb8+OfiN6h2IBb+LfLp2fPdSOyXantrCKTc5MJWwbmYwtz3pUhQIGeG0lyY76FNiw3
 iaLuZ/nzmemByxu6bcafQhd7EZkiYHq3/zNSPyP/ij597Zobr+rPrr77LrEjlZ2aEKweCxI9Aly
 qMBMXSvQYosknGfJZqQs5iaNno3ZDW3DBSi3EDof3MOKPple5GPWwWOiNrwTR21Vnjje84UAxEh
 d6h2BBVfU43Ax2j5VxR3o7MBdbCR+XMruw2o6v07b5vXIKBzB4yJLimfbJsYPQY9+Fq3M4hn1J0
 XcBVHTvldCXGOxNSbHkhxbr/vizHwh/Pxy9BrF/KlZovQM0AOyCYcgmQFlk18zFy0xivFklrcE4
 aCexzwV/YzHWrWcFTaik91LMmfTj2BCsCCtqtoMWuV3ayEZjtNLWx5vhWNmoZ8AKTwGckcCsOHZ
 scTVzvD2DNibDBgUWjA==
X-Proofpoint-ORIG-GUID: UFblNytA_Pzofc8SYUkkX4faFMww6t03
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MCBTYWx0ZWRfXxsuIRCgRP91l
 Bkmk4yZP8HOiuDDa8WqnB4mZ7JHxxp4WVq7CCqtPq3eOMCCTDaQ42qnFU4o5wjEcH757Qg0p1re
 BWraYp0dZ+NMYiPgPYF4CuyBI+qEcEg=
X-Proofpoint-GUID: UFblNytA_Pzofc8SYUkkX4faFMww6t03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100090

The driver currently relies on qcom_geni_serial_pm() through the
uart_ops.pm callback to manage runtime PM references. However, the
callback has a void return type, so failures from
pm_runtime_resume_and_get() cannot be propagated to the caller.

As a result, startup() may continue and access hardware even when the
runtime PM resume operation failed, leading to register accesses while
the device is not powered.

Move runtime PM acquisition to qcom_geni_serial_startup() and release it
to qcom_geni_serial_shutdown(). Since startup() can return an error, PM
resume failures are now detected and propagated before any hardware
initialization is performed. The startup/shutdown pair also provides a
natural place to balance runtime PM references for normal port usage.

During probe, uart_add_one_port() may configure the port before any user
opens the TTY, meaning startup() has not yet been called. To keep the
hardware powered during port registration, wrap uart_add_one_port() with
PM_RUNTIME_ACQUIRE_IF_ENABLED() and PM_RUNTIME_ACQUIRE_ERR(). This
ensures the device is resumed for the duration of registration and that
the runtime PM reference is automatically released afterwards.

By moving runtime PM handling out of uart_ops.pm, resume failures are no
longer silently ignored and all hardware accesses are guaranteed to
occur while the device is powered.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 37 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..e16a31b5dc32 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1178,6 +1178,8 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 	qcom_geni_serial_cancel_tx_cmd(uport);
 	uart_port_unlock_irq(uport);
+
+	pm_runtime_put_sync(uport->dev);
 }
 
 static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
@@ -1246,10 +1248,18 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	int ret;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
+	ret = pm_runtime_resume_and_get(uport->dev);
+	if (ret < 0) {
+		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+		return ret;
+	}
+
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
-		if (ret)
+		if (ret) {
+			pm_runtime_put_sync(uport->dev);
 			return ret;
+		}
 	}
 
 	uart_port_lock_irq(uport);
@@ -1724,22 +1734,6 @@ static int geni_serial_resource_init(struct uart_port *uport)
 	return 0;
 }
 
-static void qcom_geni_serial_pm(struct uart_port *uport,
-		unsigned int new_state, unsigned int old_state)
-{
-
-	/* If we've never been called, treat it as off */
-	if (old_state == UART_PM_STATE_UNDEFINED)
-		old_state = UART_PM_STATE_OFF;
-
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		pm_runtime_resume_and_get(uport->dev);
-	else if (new_state == UART_PM_STATE_OFF &&
-		 old_state == UART_PM_STATE_ON)
-		pm_runtime_put_sync(uport->dev);
-
-}
-
 /**
  * qcom_geni_rs485_config - Configure RS485 settings for the UART port
  * @uport: Pointer to the UART port structure
@@ -1778,7 +1772,6 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.poll_put_char	= qcom_geni_serial_poll_put_char,
 	.poll_init = qcom_geni_serial_poll_init,
 #endif
-	.pm = qcom_geni_serial_pm,
 };
 
 static const struct uart_ops qcom_geni_uart_pops = {
@@ -1795,7 +1788,6 @@ static const struct uart_ops qcom_geni_uart_pops = {
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,
-	.pm = qcom_geni_serial_pm,
 };
 
 static int qcom_geni_serial_probe(struct platform_device *pdev)
@@ -1921,6 +1913,13 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	devm_pm_runtime_enable(port->se.dev);
 
+	PM_RUNTIME_ACQUIRE_IF_ENABLED(uport->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret < 0) {
+		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+		goto error;
+	}
+
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
 		goto error;

---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260709-remove_uart_change_state-a1f7e783aeb0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

