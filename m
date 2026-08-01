Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221942980A
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785563318; cv=none; b=LYIxmL0CnRekOSebyOVuHM82Az+NH3VSMynaVyPhnjVm1RWdaXwxSX8XhmNfg7bUh8YzWFJK2V1TVgdF1YbJnFkOpOuHEeQJovczBSW470GoLHXwoXUX4SVLv8D0fCZQPWMfNNBSo8lRg4O3I128i60tsQnvhMeWzIelTWAAc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785563318; c=relaxed/simple;
	bh=tWIJSkw9Kzo/avDWru6gjan4r26W1mpQOWzAfoc3/Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wpa88Mw2ImBtKVlinbJH/ex6gzsGQkpUfRpsBeBKTu6Avpw+Nd6Ma/1Lfi3RfOuKyoJJld8BtGPICYmB6lG0vo6YHqRNLxxDbSwT6ZRf0WmKdwpMzQMTppUNuUZSgfWZO3jHdkJbQbgk/ctiD+J00HtcHNWhoPtMlNTLY4w0lJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIZxUwmQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jH+kxlrk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YIZxUwmQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jH+kxlrk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713FjPm1759110
	for <linux-serial@vger.kernel.org>; Sat, 1 Aug 2026 05:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W/x2tCxPihtobiDZezuB+G3GBMdzVmyWSC8+1i1POXc=; b=YIZxUwmQS/i9BPHc
	WJyRPIbCGaHkWB6vqq/L9urNgoX7fEbiMm8vX8mQRcVE43WEzv1Kv6IcMojjFhmu
	26Jdzlq5nyZheCRC9NqCtjcEUsHfA/pTl9vnKfz016tzFz2ELtoSEhFMad9+22Qm
	YTWyRFQ9a2ZGygJpw9IcwGZfReX5QF3gLAQOi9n7tJGUP8FrugSKcBfrRwQ6YBxw
	qvviWQL6w4/v6pfUsHQ9acpGoy9/jA1NPVHaf5Fq6gm8jsYQHubp3J4jy0S240QA
	8vG+4MMge2kZiNpeTBjhi0eCHuKLu+wWLEFzmT6Ro0IwGrxN/ChSQNPD115zGd/z
	tKsozA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6g9tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 01 Aug 2026 05:48:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cd01a14e81so21287695ad.1
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785563315; x=1786168115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/x2tCxPihtobiDZezuB+G3GBMdzVmyWSC8+1i1POXc=;
        b=jH+kxlrkW3mLq4USOWd0JHj9wrRpVWqc7W/N74PsLoQXb9713IuRaNaExQw7JIe92F
         YrfkV3mbFkgPoJ1hhaQTXOvCoz2JeXWnyuo0UoIzol5TAr3WkgxmonSacRAcx5+r9Kut
         ASHc3f0srXQVrBZNTMM3VJcYJWyNLgYB/au8c8ELveWwN0xJxdNEt7wMIB7+D+wMRsPN
         rvohwKP7YmNvASsKqRsFVkg4w20+EbwwYr3hA+sk2mIHngxeEUGK0CWI1UGGHvuYG2R0
         0F6O9mPpCFQZ8out3Ana2jU8NY/adfhRmtfnZfD2zk+TbEHyU9pc39CAifnfJg9kscW8
         gNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785563315; x=1786168115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/x2tCxPihtobiDZezuB+G3GBMdzVmyWSC8+1i1POXc=;
        b=RLX8P9tlSobILt6ZkkLVh/rFjnLKDV+OICQfA5Yiw+sLQKkoT8BXkyGEZVQJ4wUUUD
         YU0S05ksTt51vUqM2G3s9MdcND7EhIvmPeGlZZ4636Iv+dAEVYjOC9KQNDGntQH38exD
         BEDBI1XNZsD6Wi81PsRa4D9Qz+9dpIo7otTAsjc5QFumGoLWlKuPB+UmUSBzZl64wxTP
         eR3FxZ5Gk/AJ30J5k0xx3DC8yO4Qwo97TaLPEvvo3leirIt8PH8xaBqZKopp2HgVgqrx
         9BwOYUL2TLcQsBMrrSmPHAAHtUwjbWcLIw9Imk9QMP5Y+GRUuo/nxI1iwiS8iVJ6cfQ0
         b3RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqh3/fjJ/4GupZ0sAEfysKQtqSVwSfcMbz41ZirXo2F9kXv8tr0puXKbobjst/cCzAf2lmBQhxwfWVkcLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7xZm3PDEJVm/nU3lFUnkPAZUT1KE0w8GqHtigh6oRM9m8nGL
	3YeayLDG2XqrRkpIUa9TdlDgYngeCjAKSXE6Uon7ZuUEdqJtbfodFiK+kb3VWU/hEpQY+7idzC5
	ANxdR66Z8sA62g5tEVpFRlxwWYBmQU7THTOBAaryWdfbZllx2arYkSQhtqgFx4z9mdxfUSl7qy6
	U=
X-Gm-Gg: AR+sD12EWDb3WMmtARRZJgYShL58jecX1+1fjz9cbEdc/5tqaVQteJKw20IMyUGSu8L
	M46q4mT9f60hEpzqoXEixpOJoWZag23GnQshwjenp6xk769fAVxQO+eyBG8YDBQE4iKkDLOxSJV
	tSQNf2fCoYJjsUeYRjPUuJQ7kqg6pKH3C4+P0lfS78r8CA0DUNiK3tRJV2WDU1fLcbB9xrXrHSE
	XDGj7TanvT9liOConmT7xGHZts3yCB+6ScwEj2lgiC9EKAPWIDDsHMIupbvjF5FyGJOhbpBg4Th
	mzPzfqN3YSPS559s7Fe++Ar5K4J++IO0ienF0HlYo6xa8K92KDSmWYYQBg2gXQBysmmQyukBZ3j
	Kss9C1w8jLmW2HdlZTlzwXlB91ApOqZWg/A==
X-Received: by 2002:a17:903:46c6:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d0521ed97emr22909785ad.13.1785563314769;
        Fri, 31 Jul 2026 22:48:34 -0700 (PDT)
X-Received: by 2002:a17:903:46c6:b0:2c9:a5e9:c26e with SMTP id d9443c01a7336-2d0521ed97emr22909625ad.13.1785563314217;
        Fri, 31 Jul 2026 22:48:34 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm18305211eec.4.2026.07.31.22.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:48:33 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 11:18:16 +0530
Subject: [PATCH v2 2/3] serial: qcom-geni: Use resources helper APIs in
 runtime PM functions
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-reuse_common_geni_framework_helpers-v2-2-13753256ef71@oss.qualcomm.com>
References: <20260801-reuse_common_geni_framework_helpers-v2-0-13753256ef71@oss.qualcomm.com>
In-Reply-To: <20260801-reuse_common_geni_framework_helpers-v2-0-13753256ef71@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785563302; l=4431;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=tWIJSkw9Kzo/avDWru6gjan4r26W1mpQOWzAfoc3/Nc=;
 b=eQGu4QihbRU7spnvlrKQMHHMm0XXvVECq4oCQrchgbrIuPBWwkjsOT+DcLkxgh5kmG/eJDZyL
 fKbi6wC+JMlCdz1rsjnGsBU0bGhtnVBmVakOnTongz2kLsgIMVVJurQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfX3XvNP9YCvrnI
 EdEb7Jcbn1bKNDd0CQi9geHM6vQvgt/rgtF2LxA6SwBl/Xm4Nd9RLbY9cZBlClf7iZvTxTu4dyw
 rPSCJ6o7AdnhUA+90R9FgBiEm1Rayqo=
X-Proofpoint-GUID: wX9cCLa9zQEWthPg--7LDHxmBv1xytTz
X-Proofpoint-ORIG-GUID: wX9cCLa9zQEWthPg--7LDHxmBv1xytTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfXyEzALtWg6qnA
 Ew3IwIXRaoXu2YJ2El3do7fCeFh7LNq5ig1PvAPA3rfxXXurOxIzpgXgGa+bdS+1f8gs2HYenr5
 fsPtrEisdQyyTfguRV8Blef7VM4FXlrmwgGK68zNBve9mRbURx+hbv0ZC9d3GnUzQTXxCQctAwB
 Q5WFyRLvc31E/ubr/U+wP6ZrnmfIqj3Ey7te8dhcsJCZwL0h9bQT2qqEeEs/qM5xwYcjkCfQN9n
 c/i5bNDvTGW+0dXfaiYMN4hGA4hQuQrPrTNNhdj3KR6uwc6Jgkks/a/29jpzBgYw0/GKnlAzfno
 KOauYW0SofiFuxoTJ2vwLK9IERW/t52HIzUwNxoqv2rfS+E2KAB9/qkHtbGDwkx5QM4Bq7X/ON4
 TyqYAZogxr7qny0Kns8+RWc3t/k9KN2W/s8CxXS8E0wsmJko2GrBbjSK0HK3pJ9712Y3q4ZE5Wr
 VhZZDLpf2tBnGEGDd7Q==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6d88b3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sJIhbiIXeOZG86cfmoMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010037

To manage GENI serial engine resources during runtime power
management, drivers currently need to call functions for ICC, clock,
and SE resource operations in both suspend and resume paths, resulting
in code duplication across drivers.

The new geni_se_resources_activate() and geni_se_resources_deactivate()
helper APIs addresses this issue by providing a streamlined method to
enable or disable all resources based, thereby eliminating redundancy
across drivers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 72 +++++++++--------------------------
 1 file changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index c8c4f01d3143..83ba0f5433ef 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -117,7 +117,8 @@ struct qcom_geni_device_data {
 	enum geni_se_xfer_mode mode;
 	int (*resources_init)(struct geni_se *se);
 	int (*set_rate)(struct uart_port *uport, unsigned int baud);
-	int (*power_state)(struct uart_port *uport, bool state);
+	int (*power_on)(struct geni_se *se);
+	int (*power_off)(struct geni_se *se);
 };
 
 struct qcom_geni_private_data {
@@ -1817,47 +1818,6 @@ static struct uart_driver qcom_geni_uart_driver = {
 	.nr = CONFIG_SERIAL_QCOM_GENI_UART_PORTS,
 };
 
-static int geni_serial_resources_on(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	int ret;
-
-	ret = geni_icc_enable(&port->se);
-	if (ret)
-		return ret;
-
-	ret = geni_se_resources_on(&port->se);
-	if (ret) {
-		geni_icc_disable(&port->se);
-		return ret;
-	}
-
-	if (port->clk_rate)
-		dev_pm_opp_set_rate(uport->dev, port->clk_rate);
-
-	return 0;
-}
-
-static int geni_serial_resources_off(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	int ret;
-
-	dev_pm_opp_set_rate(uport->dev, 0);
-	ret = geni_se_resources_off(&port->se);
-	if (ret)
-		return ret;
-
-	geni_icc_disable(&port->se);
-
-	return 0;
-}
-
-static int geni_serial_resource_state(struct uart_port *uport, bool power_on)
-{
-	return power_on ? geni_serial_resources_on(uport) : geni_serial_resources_off(uport);
-}
-
 /**
  * qcom_geni_rs485_config - Configure RS485 settings for the UART port
  * @uport: Pointer to the UART port structure
@@ -2115,25 +2075,27 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
-	int ret = 0;
 
-	if (port->dev_data->power_state)
-		ret = port->dev_data->power_state(uport, false);
-
-	return ret;
+	return port->dev_data->power_off ?
+	       port->dev_data->power_off(&port->se) : 0;
 }
 
 static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
-	int ret = 0;
+	int ret;
+
+	if (port->dev_data->power_on) {
+		ret = port->dev_data->power_on(&port->se);
+		if (ret)
+			return ret;
+	}
 
-	if (port->dev_data->power_state)
-		ret = port->dev_data->power_state(uport, true);
+	if (port->se.has_opp && port->clk_rate)
+		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
 
-	return ret;
+	return 0;
 }
 
 static int qcom_geni_serial_suspend(struct device *dev)
@@ -2191,7 +2153,8 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
-	.power_state = geni_serial_resource_state,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
@@ -2207,7 +2170,8 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
-	.power_state = geni_serial_resource_state,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {

-- 
2.34.1

