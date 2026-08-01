Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A9429CEF
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785563314; cv=none; b=Eut1H8A5CQdeUyitjDFC0kas4GqIvwgFNPfaGpu+kNNUxe6nMzYdqV6pCb2RDtzZNSb38f1n/RgYsOQ0W8iU/gtY4x6BNknLPvOJdwUl48Mj0VCRpK6ymN2099+s/b8hIlHOv6AKKKpwBO1pqzhZ+E2qUvV258Sb/2OqbK5V+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785563314; c=relaxed/simple;
	bh=MgKtl/MZBgsFKwakhQrsDRziDrdSWAQ759cFA3oxkBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAW7LuSTRu4BJ1l7dde6Wmslj/P+L2BZh/Y9UBAkzCVHRYHGmZ11HHbIz37KllZdyTSAmZtAdB2GJAzM+BWfZwE74CNZ9BdGI0TkhuLkZD7KJBqvTuK8fObKJvn9MasUSoDnClXNWkakLA4cusqU1Oec95a7I/jZqbtLu8IkZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pmxp6feg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ddMzD/S2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pmxp6feg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ddMzD/S2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713E6wR2066837
	for <linux-serial@vger.kernel.org>; Sat, 1 Aug 2026 05:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+kmzGi8WLW3q9cUIfuI3hkdmHctpvMeJjHJVyiabAW4=; b=Pmxp6fegGKUiwUYX
	yZ0So+b3UDQh+kWQidotB+YfYxmSPQxm+NOdHiSuT2VWDsyrU2/5jUfUls/GB2BQ
	xDcxfassdJNryqMAKLzbe4kUF31du/PYwGKNIp7hBDLAtuwAa5djvFh/BtsqbDEH
	4Wq4h1wmRWxjLso4f+oZhS9bRuWjBIneXF+iDbL5r4LahzlRiovyLzIIamWYxg+f
	PRMlRzT9757VE4/QJ4oR+tFs8wcQxolXzvia4kzoM1w50lxX9COJnEJQY3MLAQrD
	5+7V3jtKkUT25FQiQLKW7hF9b2HPnKCNZ1ABtDQcUNFVs+fc36lcsJYFfDPdGjvk
	mrSaSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8q509gf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Sat, 01 Aug 2026 05:48:31 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf6acd760cso18804095ad.3
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 22:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785563310; x=1786168110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kmzGi8WLW3q9cUIfuI3hkdmHctpvMeJjHJVyiabAW4=;
        b=ddMzD/S2PsFlIoBpQBA4/TKh6GufikevBnTn7+AU9ulNwVmIv24Ib9LsqVPW3KVlaC
         VF+7rN/3LrAaOpKcbJF9fkeEfhJASlnkhucsTvwMgDJP/dPY1g27LBbGu70Qwee6dAxH
         jO45oQfDP9wI9m8mXT1O973tvTgQLH/kCRUsClSySrHbb4at9ohLlNyyDzh9Fm2pYeTl
         AAdbzgBtK7s+viHZoYccxNWjMAKN//+WoDULfqP4HTJIgiXSHDxMKxj+Lsqe7PZ5NKqe
         dL31USF1HMHSO1zVej7tt01GkOHL/lljYQ4usjKh4dxYQNEEbCewkspAnViAOlbXqLyV
         VkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785563310; x=1786168110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+kmzGi8WLW3q9cUIfuI3hkdmHctpvMeJjHJVyiabAW4=;
        b=JR6bfToRaQvllFU3ZzqgPY1YNTM26BXCK5tqSzfZbsvWGiH0axtDGT0lwHse5PvTvQ
         vW8u5lWCxHEtNDFv8VzktcLvjkC4SLhNtzja1A2Fr7XYnWyLMmY00OIE93nTaKaU3F9d
         Begm3mVmtbr6qcc/g6l4JyfjM4n0IHhaczzErFYw/Qhj70KaIs4ulMAON4ndMpVtcrBP
         G+wtixGcc15xffU/Llg2r6FDHCHGXsIbnNzlgRmuiS6OoWFmCm/72RMyAhtry+kbLl7b
         AbQJZMht5Uk6r6K34zdV/4SLbX0Fq9PUxVn7ir0SWHD2b0l80CrSAFxDJaZ2bQTrfWUV
         pKww==
X-Forwarded-Encrypted: i=1; AHgh+RraH6kVkbQ/QkO6PvAs6vL6U8AUBFR4kzc97+VZZTFXWbp5axnXG3xAZ4DUDv9xL6iLr2tw5u7ouoK7NFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywft6a2K2AkYXRCoj6iTDnIbJPSiVc8ag/8U0DNUi5JFJtp5F9h
	iuoRSX8n0rDHpfw+4ApzM3G2y9reiIB+e1Kq/IXpdjw+GlZrxQrpcmx9Kwdg2A7QcnOm+E8xh9Z
	Sj1+QvMuKSKM6U3qf6eOLP/mxA0FM8BTNNiT9a6bpnw0hsUHOwqDOfuy9j0TbcgELBQE=
X-Gm-Gg: AR+sD10lzeSQUD3b+KvyNUu0PBuwW1b3lmCNxkWFXgW7iary/RPDC/5C543BoSPxeYE
	xf0blmlo5OM+BcueBt1ZCxTxu4QCshkg+J4mv/HKcxqStaumYN7hoMHEEEWZ7xTW9LjzGe+IM6P
	+zBvhF1IJkpgBMGjOAqkMW/ID17qeu0ENcSrLNgfLgPm7QMsysnegPpcovK4pSiP6mbMIXnFzyG
	FUsVqm/i67naxgPsuDMJzy0+k81t4IQApBFlDW4uXZgY6Qs88jie1Es3h95j74NO4c04ydtTSTA
	F3u9GSwSS7+AmhwkrnCdPstvMN5xAFRQWUxVXsB94Bd0EvzSlK8T4Q1Kb1yC41FEunA5dC3Vtzq
	4R2EsDrdo1DSlYO5TKMNZ4J2X83sJrNUglQ==
X-Received: by 2002:a17:902:f78e:b0:2ca:c68:c554 with SMTP id d9443c01a7336-2d05241f274mr23182145ad.38.1785563310480;
        Fri, 31 Jul 2026 22:48:30 -0700 (PDT)
X-Received: by 2002:a17:902:f78e:b0:2ca:c68:c554 with SMTP id d9443c01a7336-2d05241f274mr23181905ad.38.1785563309957;
        Fri, 31 Jul 2026 22:48:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm18305211eec.4.2026.07.31.22.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 22:48:29 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 11:18:15 +0530
Subject: [PATCH v2 1/3] serial: qcom-geni: Use common GENI resource
 initialisation helpers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-reuse_common_geni_framework_helpers-v2-1-13753256ef71@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785563302; l=6186;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=MgKtl/MZBgsFKwakhQrsDRziDrdSWAQ759cFA3oxkBI=;
 b=YB81WKLpf2lneMGAuZ33Vaec8Tnf/AEQkHovKF2pKFp6dHnpiSvvTeq2eK91fVg/71UwK7MfC
 feTUrzVXgIuCkd0EHU74XbjahIvnNKcwZB5eFOK/Wg7f1ytX4hQQh2s
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfX3kNRQFy+kvPd
 KnXQm5nmy4otGh8/HO8TLh8LoOxPNt0xr23dU27LI669+yCpP236dgaDQ9cK/ohypgdzszoECpH
 rku0ubijQibIGjIHFuAAT9HUwpt4e7U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAzNyBTYWx0ZWRfX0QcQjtlmKBiZ
 bPZn5u03SSVo0pKtz9Z2t8367qV0EsmFf7fBGNm7WFxYJ/zZp86T5jbN0T3sU8jxkns0MqN1eNA
 3sBu1QxRWG7zwWQU79Ehrw3RFi1qBMkHpr3u7YC1azVxXwgSZJYTtAlaVCfppr3fTetBVExKskw
 g9Ns2wD5KUHX311v7Ok9Oi65w/SofvvwzViZj3tx2u56An43H8gpymhIee2bPjaIRHaq/jqf5X2
 BeZ1C6fotkBLMAb3AsKeGtA6TydBHltMcCKOXdVrsgIVTLgKY0IEziTZ1n9boqnYrnJsxVDnxv+
 QRqkBQJ7WN4I3AmH1RIzJ6c6opc5DoDh80614KkIl9nT129vLiAe0r1bEqsz8LXYGgD1JV2R9Ka
 1QFWG8ZfFh46dk+pQ1GCDpZXGHdUWPSqBumnIErUIOx75KBLDN8CjjvVKG93kPzDXsGMAX93CuW
 LLb9bXelbIbVq40Vq0g==
X-Proofpoint-GUID: WC3-Vk4G8U3xcJYSHsah2tELgFZfW0vc
X-Authority-Analysis: v=2.4 cv=IYC3n2qa c=1 sm=1 tr=0 ts=6a6d88af cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=R6AoGHhCE4Cl6DLjkzUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: WC3-Vk4G8U3xcJYSHsah2tELgFZfW0vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010037

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
index fa4adb543562..c8c4f01d3143 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -115,8 +115,7 @@ static DEFINE_IDA(port_ida);
 struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
-	struct dev_pm_domain_attach_data pd_data;
-	int (*resources_init)(struct uart_port *uport);
+	int (*resources_init)(struct geni_se *se);
 	int (*set_rate)(struct uart_port *uport, unsigned int baud);
 	int (*power_state)(struct uart_port *uport, bool state);
 };
@@ -159,7 +158,6 @@ struct qcom_geni_serial_port {
 	struct irq_work tx_kick;
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
-	struct dev_pm_domain_list *pd_list;
 	struct notifier_block panic_nb;
 };
 
@@ -1500,7 +1498,7 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 static int geni_serial_set_level(struct uart_port *uport, unsigned int baud)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	struct device *perf_dev = port->pd_list->pd_devs[DOMAIN_IDX_PERF];
+	struct device *perf_dev = port->se.pd_list->pd_devs[DOMAIN_IDX_PERF];
 
 	/*
 	 * The performance protocol sets UART communication
@@ -1860,57 +1858,6 @@ static int geni_serial_resource_state(struct uart_port *uport, bool power_on)
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
 /**
  * qcom_geni_rs485_config - Configure RS485 settings for the UART port
  * @uport: Pointer to the UART port structure
@@ -2024,7 +1971,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 
-	ret = port->dev_data->resources_init(uport);
+	ret = port->dev_data->resources_init(&port->se);
 	if (ret)
 		return ret;
 
@@ -2137,7 +2084,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 				 DMA_RX_BUF_SIZE, DMA_FROM_DEVICE);
 		port->rx_dma_addr = 0;
 	}
-	dev_pm_domain_detach_list(port->pd_list);
+	dev_pm_domain_detach_list(port->se.pd_list);
 	return ret;
 }
 
@@ -2162,7 +2109,7 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 		port->rx_dma_addr = 0;
 	}
 
-	dev_pm_domain_detach_list(port->pd_list);
+	dev_pm_domain_detach_list(port->se.pd_list);
 }
 
 static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
@@ -2242,7 +2189,7 @@ static int qcom_geni_serial_resume(struct device *dev)
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
-	.resources_init = geni_serial_resource_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
 	.power_state = geni_serial_resource_state,
 };
@@ -2250,12 +2197,7 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
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
@@ -2263,7 +2205,7 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
-	.resources_init = geni_serial_resource_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = geni_serial_set_rate,
 	.power_state = geni_serial_resource_state,
 };
@@ -2271,12 +2213,7 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
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

