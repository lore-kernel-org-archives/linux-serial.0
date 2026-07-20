Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E3433BDC
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560093; cv=none; b=TvbFD2RugEZezkc3UDx9H8Kr3URIFjb8ahqIQJE0X6UoRsExRv0Ikk/ngaZNVtFqku5GmI+L3zNBsU8SE19A8HMgcwpCB12UN40IlQImVZUiHvD8zDYLAtZH9WXOEx+rYu0y1m08uiegbm9uYP5DL8NM3IS+suB6YrwlXQchdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560093; c=relaxed/simple;
	bh=NcQxVQ619WGiRGzna8yxBU65SU+YJA8Jivukkll4UC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MfFP4gFwXWEJwk2TtDOA38F5H01TcZgY+t2pam8b83VxcZQqU3DdV0n21YD+LW5WE7oel1SgYKv5ZM1gFb4SDZEqVRbhX2iGmzmzOLYt06TE1dgGLhpUpU1RpzVpr9pZXZaCANEO4OlV+CnRnjx37XqEOGLPsJ2SywJPgqS5gQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y4qFzBSu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJL6SBTv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4qFzBSu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJL6SBTv"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDr55r2965749
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QK5PeiJNFZwQCJrkJtf/b3iSLfC/qQj+IwdiMSxf3G8=; b=Y4qFzBSuGOYY7J3q
	Nn2+P1IVowFeFebLR0VEHmGZ0cNsdqLAfEd9acCGebo6bdCPi6QeVFQRKJX9udsN
	X2txjBOii3cQ0+1Ik5T+XhMomM+Iz8Z7jILkZGIMmr6/QSA8+PxUDRHURzV/UhLK
	E9A3E5rujptzTbCPZKvD2bpyAbXmQBUGyhBsGNf9zydIK/HDYBl0lO5+AxzS2r1K
	OdC3R183gHf8N5lrXU/wLAHXTA2lG2kQb38VR0nz5O6+zqWdU2N07cyqV4qXG3ik
	4lxHWmneMmH557WpENNbNaLrC6QmKxGh0bBW8B5XoJpf7ag+kYD0HeHNhWOZeiI0
	eFydAA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdchyqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 15:08:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e6d253330so1551750a91.1
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784560090; x=1785164890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QK5PeiJNFZwQCJrkJtf/b3iSLfC/qQj+IwdiMSxf3G8=;
        b=RJL6SBTvC2d/B2lb72bISA0eMZtbuO1Lkt84CjUfJQr9Om86u03Gp/HT9EfXaPCFE7
         uqYvhFcvFx1oCGc5H0OBN7iG5A+UeY8NNRcY74PNjonQMFKjJazP9VeffDzf6rfWJ0Ss
         na1eDh2fw6K46+ow2PoaJ5QRGs+Ul79uVX0INA1qsd5ZFPUaXz9bR1Eg7CMLfZLRt2Ac
         kxmzVC3ax89owMkqCJW239q4vl7Odf7M31sxFf7Ng+Uhy+nkd2Z8yD8HSuRXR95PEvdZ
         wqoQtXhZXK7Cq3+NZvaolgpDddaqC9AVajSlf7FlhXtqKkpO16T1Y0g8Ze0cFy2MTKVa
         tQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560090; x=1785164890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK5PeiJNFZwQCJrkJtf/b3iSLfC/qQj+IwdiMSxf3G8=;
        b=HZg9qq/7Z/fYKGu+FI4b1rrWqHEEkwfbMN3/UwVBF+/dtLUV1U2htWG0ZI8NM8tzPx
         hZB5IafsxLQAxoxm4I5LlcdniUo5MqlWzWDB3EPyAul043X2Zqp18WX+/ubNKHoZXNt9
         gL9BQJWZtgAjKGexd7xxxb6MuKW7HQAqe4/FlqDYnIhhVbLiRidA3Xw4etSq8zBdViTV
         UciFargPNSaTJ+vXOwWsn81XwT6LpmUUgmdkMLhqpGX2EZ8dOjD5gnc9N+xMvUm/GYWP
         8K+/NBrSU5XPA5l3SAVvX42dAu9Qx5B77GiqTL380XAiJOHXmuzs2DvTEQznGuVZVI+R
         IcYA==
X-Forwarded-Encrypted: i=1; AHgh+RqkNw49SmP+2GQPO6bPtepUBR6y/ZWe/thicc+s+Wy5H4/uZYxXWKvvDvUCtKdghIDqVYgRy35TpR0Q89c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FnOZaSmqjrK2s9wyhWxfT+Q9d6jcoipJ3gsQaM8sdGjLZyQV
	GIop6MyHnR8o+gVsNkbZ0/4C1WYweJvVINs5LZlB1d+NsIlY9wy8cl9Al4nmlcP02whk/2GWPN+
	y8tBOgwoGP4+Y7PiY7H3qfOi/NsxnsC+wZgLMMTpPYAwl2B6My7F8tEI+iJRzzqnWCs8=
X-Gm-Gg: AR+sD12xq+TSNyihDkDrCSih6w6WGp1iMCMD4e9Z/IduWcqwpBESg3tyeVlQ1vlI4ZH
	xtx9Dxh883ABywaiGDuRhg0Lv+BGcVjsrhwSg5nxapNQLXgvzRoRvLsJ7TMUYI9cFio2sVehm0W
	k67//5JPjb9Lb/6BBmIR6ax9R4DsYErizASp1HAi3L5SRTlUVBEsUQ1uFQ1X96lqII5vJnCDC2a
	81h5i9ybUv8Kzd6xiEifx9XFL8I9xprCziLgAb3/ZKmq+wd5oo4Fhc1ofZonFxw+n8foJN9nv8c
	GJ3OOGz+VEZnx6JHBUjAqefS3SxDuJQfQZbJ7nOi3jAatg1Ot/XeHNBU6JKIVFAnU+TWQYZXzYi
	qtCLxBKl7dB58cw6X9DqUpL3+4hk/5oEa4w==
X-Received: by 2002:a17:90a:c2cd:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-38e4b4d3dadmr13088857a91.4.1784560090038;
        Mon, 20 Jul 2026 08:08:10 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cd:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-38e4b4d3dadmr13088779a91.4.1784560089146;
        Mon, 20 Jul 2026 08:08:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0531asm7856411a91.5.2026.07.20.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:08:08 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 20:37:49 +0530
Subject: [PATCH 1/3] serial: qcom-geni: Use common GENI resource
 initialisation helpers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-reuse_common_geni_framework_helpers-v1-1-c3330ab9b982@oss.qualcomm.com>
References: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>
In-Reply-To: <20260720-reuse_common_geni_framework_helpers-v1-0-c3330ab9b982@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784560081; l=6149;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NcQxVQ619WGiRGzna8yxBU65SU+YJA8Jivukkll4UC0=;
 b=0jYAbxDvUcSLEvRo40E9AgVRTxMMmweD8d3G+z1NpWKYGBGSFq3UfYHafSwLj2jVMW5G8RPWj
 69aed70CUf1DQvI7h0hEz9OYWy27ZqNYGR9MCOMRj3MUwPVHA4cGYja
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: 5iaWcSrqiTAtmQYU4AuhjoTiYC_x494g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfXxE7IE3di9IaT
 bKWw0c+wKE3H3VYfpn4ET6mBOhsmrn6UnhDeXBFUw9IIaQbaaol8VYV+p3hx6K4fpcepRP0W9rX
 bOWUfj0Ztg9SxCa2qO0+ipVzgSX6TOAdpF/ortgQzET4nMdGBko4+15hOeUt4gGDGJ0R8CMSrZc
 fO5iSNEBtU6XbeTRI7zwa7DqU/n/WKNU6Dnx52n8HU9rk3htRavK/WILwf+ygbAzWIxh1LKMOD9
 mcyzzw4czuZnvOI24sD82zwE5ZnZsr+O82ZnafrQTwSuQwmi54cp+AKptMNP7ldd0jkQjVTRb/r
 Q0rdJMLYOXk9StG7XyNKdXt0HZ70Zs0R3SQB/4uLKYxP0f19Xm0mGEKR0vSyaJzd3S5SUQQYIJX
 k5i+z56tmEMVbbtdYZ8kgIePxeQMVmOadr7v0HBDmj4C8g7MWCrky2iIpShX4Tu3sNRQz4YWAz2
 btPBeG3OAEwuKoA6PaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX3Fw9FrDDxsFN
 XNWSeyuXmy8jber74YrmW2fiKepHmrTl5NlAflc2xFYsDzLgAo3lX8AJ8DUNvPyEEkI4xEoZsOa
 Rj5pIwt+aUNAHA8BRz/qnTpYwmlA0sE=
X-Proofpoint-GUID: 5iaWcSrqiTAtmQYU4AuhjoTiYC_x494g
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5e39da cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=b2qtf1SUZPxI15QPQQsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200167

The UART driver maintains local helpers for resource and power-domain
initialisation that duplicate functionality already provided by the common
GENI framework.

Replace the driver-specific implementations with geni_se_resources_init()
and geni_se_domain_attach(), and use the power-domain list stored in
struct geni_se. This reduces code duplication and centralises GENI resource
management without functional changes.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 81 ++++-------------------------------
 1 file changed, 9 insertions(+), 72 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 67b14fda4ff9..4f34eef15598 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -113,8 +113,7 @@ static DEFINE_IDA(port_ida);
 struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
-	struct dev_pm_domain_attach_data pd_data;
-	int (*resources_init)(struct uart_port *uport);
+	int (*resources_init)(struct geni_se *se);
 	int (*set_rate)(struct uart_port *uport, unsigned int baud);
 	int (*power_state)(struct uart_port *uport, bool state);
 };
@@ -156,7 +155,6 @@ struct qcom_geni_serial_port {
 
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
-	struct dev_pm_domain_list *pd_list;
 	struct notifier_block panic_nb;
 };
 
@@ -1344,7 +1342,7 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 static int geni_serial_set_level(struct uart_port *uport, unsigned int baud)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	struct device *perf_dev = port->pd_list->pd_devs[DOMAIN_IDX_PERF];
+	struct device *perf_dev = port->se.pd_list->pd_devs[DOMAIN_IDX_PERF];
 
 	/*
 	 * The performance protocol sets UART communication
@@ -1701,57 +1699,6 @@ static int geni_serial_resource_state(struct uart_port *uport, bool power_on)
 	return power_on ? geni_serial_resources_on(uport) : geni_serial_resources_off(uport);
 }
 
-static int geni_serial_pwr_init(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	int ret;
-
-	ret = dev_pm_domain_attach_list(port->se.dev,
-					&port->dev_data->pd_data, &port->pd_list);
-	if (ret <= 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int geni_serial_resource_init(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	int ret;
-
-	port->se.clk = devm_clk_get(port->se.dev, "se");
-	if (IS_ERR(port->se.clk)) {
-		ret = PTR_ERR(port->se.clk);
-		dev_err(port->se.dev, "Err getting SE Core clk %d\n", ret);
-		return ret;
-	}
-
-	ret = geni_icc_get(&port->se, NULL);
-	if (ret)
-		return ret;
-
-	port->se.icc_paths[GENI_TO_CORE].avg_bw = GENI_DEFAULT_BW;
-	port->se.icc_paths[CPU_TO_GENI].avg_bw = GENI_DEFAULT_BW;
-
-	/* Set BW for register access */
-	ret = geni_icc_set_bw(&port->se);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_clkname(port->se.dev, "se");
-	if (ret)
-		return ret;
-
-	/* OPP table is optional */
-	ret = devm_pm_opp_of_add_table(port->se.dev);
-	if (ret && ret != -ENODEV) {
-		dev_err(port->se.dev, "invalid OPP table in device tree\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static void qcom_geni_serial_pm(struct uart_port *uport,
 		unsigned int new_state, unsigned int old_state)
 {
@@ -1883,7 +1830,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 
-	ret = port->dev_data->resources_init(uport);
+	ret = port->dev_data->resources_init(&port->se);
 	if (ret)
 		return ret;
 
@@ -1988,7 +1935,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
 		port->rx_dma_addr = 0;
 	}
-	dev_pm_domain_detach_list(port->pd_list);
+	dev_pm_domain_detach_list(port->se.pd_list);
 	return ret;
 }
 
@@ -2011,7 +1958,7 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 		port->rx_dma_addr = 0;
 	}
 
-	dev_pm_domain_detach_list(port->pd_list);
+	dev_pm_domain_detach_list(port->se.pd_list);
 }
 
 static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
@@ -2091,7 +2038,7 @@ static int qcom_geni_serial_resume(struct device *dev)
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
-	.resources_init = geni_serial_resource_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
 	.power_state = geni_serial_resource_state,
 };
@@ -2099,12 +2046,7 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
-	.pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-		.pd_names = (const char*[]) { "power", "perf" },
-		.num_pd_names = 2,
-	},
-	.resources_init = geni_serial_pwr_init,
+	.resources_init = geni_se_domain_attach,
 	.set_rate = geni_serial_set_level,
 };
 #endif
@@ -2112,7 +2054,7 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
-	.resources_init = geni_serial_resource_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
 	.power_state = geni_serial_resource_state,
 };
@@ -2120,12 +2062,7 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
-	.pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-		.pd_names = (const char*[]) { "power", "perf" },
-		.num_pd_names = 2,
-	},
-	.resources_init = geni_serial_pwr_init,
+	.resources_init = geni_se_domain_attach,
 	.set_rate = geni_serial_set_level,
 };
 

-- 
2.34.1

