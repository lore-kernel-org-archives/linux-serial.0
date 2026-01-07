Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF20FAAB
	for <linux-serial@vger.kernel.org>; Wed,  7 Jan 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768528; cv=none; b=b04d1oc8UVjGqZh9Zx0i9asrQYoUqVNM7NLhorlSFwbDSGSC8SXEFGvgv8TUZlea39TOzXLujfoaW5LOmltI1EUEx9UAsFcsymLFZ5AKodwwDS22NO8P9qJv4IRmxJTlOinqT/xqEVSQ6ZhA4VnLpqBIOPOPDC5gjW+42+FzgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768528; c=relaxed/simple;
	bh=pesAjfavjb5Yz48Nmc0KgZVkETybNrrExJnN9Nb9JeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o6VSJMzD+KdpRFWi9VWuP8zZyHNDjHMydlfEr/nrseSEnShPpuRV/6M3JqLhkEScYbTbz4v7MV1b7dKxY360BkzZesnv1S8x5Stlast+399xAQPtl2g8CieO8qpS/rXouG/5PbVdz8mY43elR7+W+jVzl31MGs862hB4p1i0wPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y1T6H7cY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=adwJKJcG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1T6H7cY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="adwJKJcG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6070r2c01981267
	for <linux-serial@vger.kernel.org>; Wed, 7 Jan 2026 06:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4bnEylxTkLuKxt75YayPjSupmukY0oY6rK7
	ctJ7Yfyk=; b=Y1T6H7cYBO0pVgZv6/iJW8hbNJSvkWxokIm7l7hy7g/dkftRnWh
	c7K370x0wj5e3lrLycPot/BYlPh4bRJHlx512XXyp+hjOA/n1ZEtPMOuTTCv6tZF
	AWbIYKld7dtfj7A+Kfc7Wyk+tctJt0AqnS5qoJRV6DBxnLstm0Y6aQh4E+/+J7bY
	RanTwt0tibRhaHx0qT9eE46PYf42aYO27c1zX5CTjhSsIbRu0Ib6sgeROrgB8ckv
	W8dVQCneCz5S0uhaonOg4hkFw5l5GmQ9ec6TmGwik3V1+y5gyC+pHXJM3RODR7m+
	rcaltfz/+xKvdLxWtF9/4qYW2ASU2NHClHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhdavgxs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 07 Jan 2026 06:48:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f2381ea85so38283885ad.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Jan 2026 22:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767768524; x=1768373324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bnEylxTkLuKxt75YayPjSupmukY0oY6rK7ctJ7Yfyk=;
        b=adwJKJcGV46uf3GQb4R86/Yoxmqzbaah9MH855KorpzohNXrn8A9rny+Etb+tVttMU
         fHDyjz8foMe7XZgabgSpvvSRJUD0Q/G6sazYxtljXoRtAxmfMt1Aq3nWq4P/oLQKdYXW
         dEBmm9mL5QAtRxn2l0Rlp1sSLO44ZvQku8SgwF7Y79XtEztWzv8JzIMLmqi24LLmqKTM
         zLOHMZ4CHiMp26dUsZh30hoV1d5/Q1l8gtBapNbjw7syYUgmtzwoVXI4TY1AD9GaJ2Tl
         VwX+QcuZjWEoM6X5bN/1mxladaJzHpLgOMDf0wamRqx8crvoG46zqRHJsOpVPILQVRWd
         kh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768524; x=1768373324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bnEylxTkLuKxt75YayPjSupmukY0oY6rK7ctJ7Yfyk=;
        b=pMkDwsDOrM5GULl2PfFfRb9eEzqyn1ywjToWlejy+0oBK7CS5MlHGVnxlUKJRxK8Ho
         BVK/eMD/lKOH5pPrx1+GPELLFSLPIHc654iqX2G4/J0jJST4B/LVfNXfA2Qa/6XaIR//
         +xBNTeFKgjQ9dkwJISgmSqjBqe9P8cVxA4aBM8xNwtri3Gk4JlPZYeACBL97AI+B/Ar/
         94uaqQOfrbrM8j2Uq2I3wtZR+a1PrqZNqsVjSPj2AB6/heiVuPjrwRkKvVnamzhzTlp9
         JleR5T3iqtEgkHVHkd6nt1KYXCcT8cH7w3wmrACibeZJRR+qkeWawIf18C3GoFQ0uGli
         JgUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfM7/3UycZ6uk2eaoXXH93gh3TuaIZxqWavaof9Kmj2RLBjmJeShAhhVrryJcekRutSMMDO57ZOdV4S68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yjubGsHhF0MnFgNUiVjj9ALP6XBMRBpdqtBZlgi/doPHNgv7
	0+WgAqfhAmPBgL9Lo97Bk/W7SlIZickiOnhKpiSwCTsNPXdI9oGN56ycXRzMB39/eD3u0N9MGiP
	soKqMZW/0e4Wnk2ZEEE/1NH03mZD4fMpZuFrFMfzkHqB+cPN8SHzqDCKqh0Nvu6t1Hvk=
X-Gm-Gg: AY/fxX4LczSggOd69/QzvIGPdBaUty0hp2TXpg2ldWVVWnqoLxZ3bYJXI+aqiQcKbEG
	hhnSQN7Ll2lyt4V1SoKvTYX5NxJJUdMRY0Q6Nw44H8p+S8oqOw0SJo+KVKDuq7UA5orhWRQoiaD
	lzquzWL5Eef+Nlcsnl1gbTdqMv2LmS2+/sT6zZ7W8fr+p3uex6xwv4eiuRjos0J79BXpx2+BZUO
	hSaTrDTyum8CmojPmCve2KtMF8vvVAA+hn/oTJkrLHZE2O91NmOWkF+apx8HG/jhndXRh7Xpmz+
	JrX+2E2b/nQt5OQf90qHMafXP9fDq4Gx+BRSxfC0XTYAcvM0AeIvZqL1UYljCoN0vpLi2App5Mv
	NhNWj9WKhqEcrxD27Am/t13CLocDmap35ESfXnv0XJNw=
X-Received: by 2002:a17:903:90d:b0:2a1:3ee3:d00b with SMTP id d9443c01a7336-2a3ee43617fmr16424565ad.13.1767768524317;
        Tue, 06 Jan 2026 22:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJnyGcPH329JYVtNX5I7+iidPLzPe15TqpxTY0u7lIcQ9H0v7zQAVfgXxaKG7WhVN/L/3/jg==
X-Received: by 2002:a17:903:90d:b0:2a1:3ee3:d00b with SMTP id d9443c01a7336-2a3ee43617fmr16424365ad.13.1767768523733;
        Tue, 06 Jan 2026 22:48:43 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c4796asm40390805ad.34.2026.01.06.22.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:48:43 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
        quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
        quic_shazhuss@quicinc.com, quic_cchiluve@quicinc.com
Subject: [PATCH v1] serial: qcom_geni: Fix BT failure regression on RB2 platform
Date: Wed,  7 Jan 2026 12:18:34 +0530
Message-Id: <20260107064834.1006428-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA1MyBTYWx0ZWRfX81u2QLWWuYGk
 cXXMHDi+HTV7+i+RMhC0TBAuYtTrUfIW4D6Q4VUI26zFx9c+Iin2UQk05caQPdrhWi4zWLLF1cZ
 89SbhKXky/E0Hvhd9OKmGHzT2JxpPNSnAI0GFHLa/Qk+XBOTpfbS6mCr6hiCSqt9sUPyjWj5PMN
 EnUovQwoHo6HysBP8WsYQbHkVSTzjPFVGDxA+00tcpyblm0F8vfWs9kPTq36PY7Xxn5RtJJ24yY
 GA0oBqHv1z5OZvSuvM/uoXkIZ5TASCfKrBZmGhxG6MWBwh1g4DJXMJ1Tj1p+qF0uyDCgaKE16zN
 xqX9hLpLPxYTHaU5kn/LtJbLnmo2hsHnBzXy2CiT0+WNCU/CWSlE6Tdb4gKsVhPGCAxhRUtpshS
 jZiFt8z3cEVa+c2BAQbEpBv9QTcaI4YJaKqfckQ3qRdnCTsrptvy82uzJgaV02DBMdy2iFddu+l
 4PorekEW5RYLGVP78OA==
X-Proofpoint-ORIG-GUID: 2aitaIz9fC5d6PkyRT3oteEtbwjbQ9Ah
X-Authority-Analysis: v=2.4 cv=comWUl4i c=1 sm=1 tr=0 ts=695e01cd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZHrvK-t-B7cf9zsPnwYA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 2aitaIz9fC5d6PkyRT3oteEtbwjbQ9Ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070053

A regression in linux-next causes Bluetooth functionality to fail during
bootup on the RB2 platform, preventing proper BT initialization. However,
BT works correctly after bootup completes.

The issue occurs when runtime PM is enabled and uart_add_one_port() is
called before wakeup IRQ setup. The uart_add_one_port() call activates the
device through runtime PM, which configures GPIOs to their default state.
When wakeup IRQ registration happens afterward, it conflicts with these
GPIO settings, causing state corruption that breaks Bluetooth
functionality.

Fix this by moving runtime PM enablement and uart_add_one_port() after
wakeup IRQ registration, ensuring proper initialization order.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Closes:
https://lore.kernel.org/all/20251110101043.2108414-4-praveen.talari@oss.qualcomm.com/
Fixes: 10904d725f6e ("serial: qcom-geni: Enable PM runtime for serial driver")
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 6ce6528f5c10..46a9c71630d5 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1888,12 +1888,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	devm_pm_runtime_enable(port->se.dev);
-
-	ret = uart_add_one_port(drv, uport);
-	if (ret)
-		goto error;
-
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
 		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
@@ -1906,6 +1900,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		}
 	}
 
+	devm_pm_runtime_enable(port->se.dev);
+
+	ret = uart_add_one_port(drv, uport);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:

base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
-- 
2.34.1

