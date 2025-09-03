Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55212D3739
	for <linux-serial@vger.kernel.org>; Wed,  3 Sep 2025 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881108; cv=none; b=IpYyHlpJUGm0iYtdMg7KrsFhK861qa9b/V55hQ9Pj/tvM2oDFj1DtXnCu+InCqBE8uXDG37Sb6T7DQ7F0l6/+b3+enFQ+H+ryvJB7qTlwgKYe3H+h+DAEY7Vx3ewXZxwv8uk6dVHBFss6Vcrq3f15uR6RCekJDHsbUDd3d+GQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881108; c=relaxed/simple;
	bh=gd+e8PkPaHQz4TbcG5ROfS1XVpqPXlZqbngCmfx7qKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C46ij8q7sOlV+iOnfNdoUJjFiv1MlG3wP91zREvdRCM6MHzO0f2Nz9/kinmzAUM6WJFr1+JGTBPN9/rhN1k2kVo302ygZzC7fvERHbXdo2t3llAfXrNgnCXLT8ih0OmCNyqnPF75GmA4Fo/Qj6mpTh5UnaV/nEQmNk7G3WJ2yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LeI/YoJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LeI/YoJb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58329uxk025278
	for <linux-serial@vger.kernel.org>; Wed, 3 Sep 2025 06:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y/J8Cg3ZGSwSv1XTZtLVvIMGVBbC7tLgM/b
	9mrjrehM=; b=LeI/YoJbAwWl0l275WDyKI8PZ+XuZNntVmgaA85/fPdy9hb6tOg
	gRDS1NnzSbZdJ4IqbY0NmgWUS9wom6MVs/Uwqv1VqXZPkAX0qNRPuwnIozlMao0D
	LeKyM6MXUh/Br9dlN+819FBPY05sLgsliQKN3+w3oCFqdIXZ9VVvMP9UAk35ehqn
	2f2OFRCXbUkmjwQFmv9/5f6qSEDK1e3EBKDDod9dogGnzVY5DjI5qwMDSHyzZx8R
	1LSYMm8mOKro9Vc/7g49t6CQ2SNEfcolH7TAbbso7d/OUwA14L5Zg3MaJ7t/88ia
	DqP1jEMZj6JFE/8WZiBTWFTeFZJU27IviYg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv2j0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Wed, 03 Sep 2025 06:31:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77253535b2cso3257564b3a.3
        for <linux-serial@vger.kernel.org>; Tue, 02 Sep 2025 23:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881104; x=1757485904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/J8Cg3ZGSwSv1XTZtLVvIMGVBbC7tLgM/b9mrjrehM=;
        b=Ukezu+NWHIn/JpVpkwqXg8rrlC3q7NqfUL96wO63bvVGqU/JhiGbIyEYN7nu09J23k
         3EvBUBdwFp6/tJf84fpYIXxm4EtsWr7pFX9pl7Etb6zmFFz/ej/lcH6S+90jEzRxaya9
         iWKEKuJgU0NQHwpudrW3OH7fhAy2u701O1KuDxRObJN+J45n7GEzwsldxbjAaZZvwaEL
         AVDELSotZGO+FwkNqiyNBbA5rqt/iqwjY3vvPPrH16686FIaJYpZlPFRsAySgkukXOfx
         6CUQsVIXIGXuDJroPfLw8lWX/Spz9IUdqWocmnt1bfk1gu0qOOLdDVDlD2ywUzh7mVVe
         mTgw==
X-Forwarded-Encrypted: i=1; AJvYcCXPEIngRKFlrdKuocubwnLqrIwdmgZIcFiy/nqlyYMVB278TQ3vVJcVWYMsWRibHvCkVQNz99zIN8XXFbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcRabwRfbyeNwkKPpti9EUzf1Bw8BOMTEMq80ZB403LSGzsG9
	9Cfu0DmoNXKwHnpObjJMApzM9oJ8Fd8uddna2yAoYNJDRgVUcx0U4OgI/cAgNaooQupJ8u6auSU
	JtRyM3Nve5gNLe/ZCdx32jVhJxXiXU9yzAm3iEfiBR/1EoaMYrGmhiUy54O7P9FWlwWs=
X-Gm-Gg: ASbGncsZjcSNxIFdeQlVjgDbvqX0diAY4r0IfyMv4Lq10hR9c9baQIjbVX4sSCGLbMe
	WyAOrw8gPPGWDlabkn7bJEBPjWIiCqM0TCTeLQCGPf/tPI2kYdcvPfqG6teWx3VhP9144926Rou
	Ycx0tnizz3lrH3eHSU3++D79I1nJROw4jCr9ptEo7vIVLARLZ9F3kMoFza5gCV0NtUUbv2oBhCL
	BwbapGeSU+bw3tshR9lkvsv7mCTwFr0G8i9b7MWv1x4X65LMugUmHKq941ciQtIAdfGSJSiwOPz
	Sh98Ze6ZcxDsRwWUSGMa+yNw4hrghh6umGHd7UlrUsMSKmlVyxkCvlwffsQ1y1BqpbJgKzGLsM1
	d
X-Received: by 2002:a05:6a00:3a16:b0:770:54e6:6c36 with SMTP id d2e1a72fcca58-7723e1f4f41mr15217289b3a.7.1756881104041;
        Tue, 02 Sep 2025 23:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpNGXaOZuyxyrAG6vq4lgWuT/ZgOmFTHhMJL9wIB5ccUUes74PZbJ6twk7++1GBkDckKxQKg==
X-Received: by 2002:a05:6a00:3a16:b0:770:54e6:6c36 with SMTP id d2e1a72fcca58-7723e1f4f41mr15217265b3a.7.1756881103511;
        Tue, 02 Sep 2025 23:31:43 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725e419913sm7506150b3a.55.2025.09.02.23.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:31:42 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, bryan.odonoghue@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH 1/1] serial: qcom-geni: Add DFS clock mode support to GENI UART driver
Date: Wed,  3 Sep 2025 12:01:36 +0530
Message-Id: <20250903063136.3015237-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX1NYVtOWvsxqh
 H7dHh6ssE7uE4zWXAsSRheemxED4XpBi3JOr6tekZoObcmhFpfMNQ51qL8OedJ79kXRi+De9k/X
 FFhFjR/hCcR4DHeiZrkH/Y2/p2rbnJxWuhC41jcixMH1MkCYqwRxGuZ3unF5gafI9m8W5/TpEQV
 xgKAhqEtgPbkDz4+Ht4XwtiIeA8Ud61Ja5YR9NXWLDn+teaqPlUhHl5wn4B+4HBxpWsynxKBilU
 vsu/VSqkoN2CnzCjCB1XpMlUxwApzFpLaNwfCLc5TrcrQeD+pt3EDvfC3sqwZNdOuSidjgEdYty
 27Mnbl3PbGNHDM5GYkJmcWIjyRPok7lXSAK2wj/iHK+whqUgUQICQy4FLKQR5Bdct+c4qw+wXT9
 tRuI21Rd
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b7e0d1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZUYIRPIop1y0tegngwgA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: FQNmQ2efcrKP6PCogmet1UtGyPaSkl6a
X-Proofpoint-GUID: FQNmQ2efcrKP6PCogmet1UtGyPaSkl6a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

GENI UART driver currently supports only non-DFS (Dynamic Frequency
Scaling) mode for source frequency selection. However, to operate correctly
in DFS mode, the GENI SCLK register must be programmed with the appropriate
DFS index. Failing to do so can result in incorrect frequency selection

Add support for Dynamic Frequency Scaling (DFS) mode in the GENI UART
driver by configuring the GENI_CLK_SEL register with the appropriate DFS
index. This ensures correct frequency selection when operating in DFS mode.

Replace the UART driver-specific logic for clock selection with the GENI
common driver function to obtain the desired frequency and corresponding
clock index. This improves maintainability and consistency across
GENI-based drivers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 92 ++++++---------------------
 1 file changed, 21 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9c7b1cea7cfe..59019fc30e47 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+/*
+ * Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
 
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
@@ -1240,75 +1243,15 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	return 0;
 }
 
-static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
-			unsigned int *clk_div, unsigned int percent_tol)
-{
-	unsigned long freq;
-	unsigned long div, maxdiv;
-	u64 mult;
-	unsigned long offset, abs_tol, achieved;
-
-	abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
-	maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
-	div = 1;
-	while (div <= maxdiv) {
-		mult = (u64)div * desired_clk;
-		if (mult != (unsigned long)mult)
-			break;
-
-		offset = div * abs_tol;
-		freq = clk_round_rate(clk, mult - offset);
-
-		/* Can only get lower if we're done */
-		if (freq < mult - offset)
-			break;
-
-		/*
-		 * Re-calculate div in case rounding skipped rates but we
-		 * ended up at a good one, then check for a match.
-		 */
-		div = DIV_ROUND_CLOSEST(freq, desired_clk);
-		achieved = DIV_ROUND_CLOSEST(freq, div);
-		if (achieved <= desired_clk + abs_tol &&
-		    achieved >= desired_clk - abs_tol) {
-			*clk_div = div;
-			return freq;
-		}
-
-		div = DIV_ROUND_UP(freq, desired_clk);
-	}
-
-	return 0;
-}
-
-static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
-			unsigned int sampling_rate, unsigned int *clk_div)
-{
-	unsigned long ser_clk;
-	unsigned long desired_clk;
-
-	desired_clk = baud * sampling_rate;
-	if (!desired_clk)
-		return 0;
-
-	/*
-	 * try to find a clock rate within 2% tolerance, then within 5%
-	 */
-	ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
-	if (!ser_clk)
-		ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
-
-	return ser_clk;
-}
-
 static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned long clk_rate;
-	unsigned int avg_bw_core;
+	unsigned int avg_bw_core, clk_idx;
 	unsigned int clk_div;
 	u32 ver, sampling_rate;
 	u32 ser_clk_cfg;
+	int ret;
 
 	sampling_rate = UART_OVERSAMPLING;
 	/* Sampling rate is halved for IP versions >= 2.5 */
@@ -1316,17 +1259,22 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 	if (ver >= QUP_SE_VERSION_2_5)
 		sampling_rate /= 2;
 
-	clk_rate = get_clk_div_rate(port->se.clk, baud,
-		sampling_rate, &clk_div);
-	if (!clk_rate) {
-		dev_err(port->se.dev,
-			"Couldn't find suitable clock rate for %u\n",
-			baud * sampling_rate);
+	ret = geni_se_clk_freq_match(&port->se, baud * sampling_rate, &clk_idx, &clk_rate, false);
+	if (ret) {
+		dev_err(port->se.dev, "Failed to find src clk for baud rate: %d ret: %d\n",
+			baud, ret);
+		return ret;
+	}
+
+	clk_div = DIV_ROUND_UP(clk_rate, baud * sampling_rate);
+	/* Check if calculated divider exceeds maximum allowed value */
+	if (clk_div > (CLK_DIV_MSK >> CLK_DIV_SHFT)) {
+		dev_err(port->se.dev, "Calculated clock divider %u exceeds maximum\n", clk_div);
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
-			baud * sampling_rate, clk_rate, clk_div);
+	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n, clk_idx = %u\n",
+		baud * sampling_rate, clk_rate, clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1346,6 +1294,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 
 	writel(ser_clk_cfg, uport->membase + GENI_SER_M_CLK_CFG);
 	writel(ser_clk_cfg, uport->membase + GENI_SER_S_CLK_CFG);
+	/* Configure clock selection register with the selected clock index */
+	writel(clk_idx & CLK_SEL_MSK, uport->membase + SE_GENI_CLK_SEL);
 	return 0;
 }
 
-- 
2.34.1

