Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A94BC025
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873514; cv=none; b=hWPkVrUD6W2Y13FHaY2mq0Kwf2KKoncTAfbLEPvGnfF+6o/QenuQNbX+z/BJyITZ2rZ7hGnBQJPHlrmSQkeugH4q4qKM7gCa1xFuQz2IrdTNM+YtgUb/il/pDbCHvwsm3X4TAfHvEOHOg9QmgRtMqx1b5cpzHvv1uZNffHQhiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873514; c=relaxed/simple;
	bh=FEu5Wj/gdb1pkJZnW+0/Hj1a/viGsgLA7fb1NYBorE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkOtcEnrn/H5wWD9ULJ1z7lJLS7ApX0siKXsgXou8lf8Mj96bhlPJDEyAhTBzCeMIG/8R/QiZwBQjMcv8xMQlhQYay0RGdZABjfFB7UgVPaoEAruIRkAJaFGXUSRqUShpLXcW621IMIeLXhByyVIWrRsoGoyWYxCY7sAL3kcxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSmgC9Au; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZqMs7k9o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSmgC9Au";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZqMs7k9o"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlLR5641249
	for <linux-serial@vger.kernel.org>; Tue, 4 Aug 2026 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=; b=aSmgC9Au1DKE1XOJ
	FexsggIJ+mMPiECRoYd1RBnaupA4mPpsyHwk8ZtGCppG6or3bvP1KtLQWwkjw3hn
	PDbdJJ5RtaePuj+nTzDQJlEJ8My5FMuYdHv8vzA6w8v6moFi1d1iSpxW2rRkz4ij
	ZP5c3czCDhLjx6lqqb77o4p//mMMbdfojQapBOjAZoAcb2jO9mnllB0iYb5D5qSo
	K/gCIit5puzJjFZYqSuzSmYh+F/3NbT3hc4BiQ3GRF9kbiEpqezlv4Nu/lrZTUXO
	1Hzjy5UFY+nZmO8ZQufxOjkGeKxuZ+9sZN6RDzGOBcV0XYjaavQlPUlxBHAo/Hkg
	ZVCx8w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3nrsxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 19:58:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so157378a12.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873510; x=1786478310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=;
        b=ZqMs7k9ol/FrgKbPcExJY/17Fd+/E5jzvNuINsTncShPpx+6HWVTNLwrT9k/tgHFMC
         vRnCSrSRAf0MavaQtY0Y4vkkpyBR3pzOPyYJLJ4Fnj/QmZPFHC/y/r6D+cIm4erKuBQR
         Y+cL6zUtPB6OFjEYsbjL7P34m8IZ0RN1x/poRzDrm+SBXr7zq83PYkSbzKicxsoimfu5
         y87vqHgSOnlWOXTaxucMyqGimtr74haDoxfC0qUUfApY12ce7kQ3UcTEpRBXPnBVvhNF
         dCLGEziP6lZbCVCP/sxxaWXg3btkvuTBwwRWcSO9y6fjMjS+XTj7obGISgU5bNyCiuu1
         B/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873510; x=1786478310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=;
        b=lUpSBLcjEEkxCIf55ut6dZZuZOb63+MyE4sNkOAxNyHyLYrXt4/SP8yVuBeuWzriJY
         FNze9NgoEzrWXhMLGBlTngMdAHXYguqc9ET+YEVMxA/WJiZc92cOIPLDQudEBqTjVxL/
         sW2sjvX5zsufAhp2fxYws4Si3PX/K8EyDrokXdkvECy8eDRr+eP4R5zjdm3vu3FUMSWs
         +aMGuPUvkcbX5rV3r2I3OdUYxIqDRE3694Q0PDMZKvjnhycYM4sX13qUjt2335ODVzWe
         /2CxqtMl8bk5FkGvnKbh6KnZIDJPISFjfpjQdoHEDfOTp5GfoYc7A3eXYp6xbeEU5nSF
         5vwA==
X-Forwarded-Encrypted: i=1; AHgh+RqoCft07TvWMNLB8H/hjnDjczdH5F8AQ+gBUOQfA+/cfjreTtLwi9dlvStk2XTPAadQ4rOg2o45XzPKCGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUKPXPIwDq9Jr7DjWg2FW4hl7vaKhxs/7UnPvuRySDpVzVPLM
	LKv6SQF93aAzsVXyKqL3jyamDYlqIL10vh9GfziYoXdl/zmam+uE10Ezab0hi/q7CgQRVAy3Ql9
	W1qut0Mn+T6O8n5vKSSIEOpOGxsXOOZ5OLw0vfA9c0VoeA0shSP9gShsv2gfd6kHMKhw=
X-Gm-Gg: AR+sD12AYAeL5DOi/ub6gxGaU6g+aV9MiVg7oc2DhxWQWrIXO7rw18AadER6zgGwL2O
	gzXB4jIQbjbK0K+Xt2RNBRzykVpgtd6LZf66Gq23GjGUUJFA35Hvy8MbE14txrfH8UwRELkbRFG
	B+QtGrb1pL3ldXd+7xcNtx63APVxbqwzUCK5u27wNYZz0Ch1sBW1bViB/su+KN3amclT+9IdhFa
	Ft3okQLVjBwulAM8lv2ScgF8vcNt+gSTnqi4FcrLHw0D2hxxUyokca5KkeP4AXGKiM7O5v+OQQI
	xL93sLz4jzDufOLeMlYN6e/Lum8sJA9q13U7eBYQjladaFeCOHWy7LniFGLCb5Ba9Dex2aEQEFC
	gLr6xuRuuFwGH4fBVmPNvQlr+K9F2G3KiqQ==
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cb85df12fbmr1244083637.10.1785873509906;
        Tue, 04 Aug 2026 12:58:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cb85df12fbmr1244031637.10.1785873509401;
        Tue, 04 Aug 2026 12:58:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:28 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:42 +0530
Subject: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=4780;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=FEu5Wj/gdb1pkJZnW+0/Hj1a/viGsgLA7fb1NYBorE4=;
 b=1xxf2D4WP4Iyk432GQjmqyJtyjVtVZJ8WaRIgbdkv/2bnBKC2G3p4HN/Ai+M7RWQuCiMorxQs
 TkYdNIors2bAmHG8UlPjBB2/WQz9ddMwufxkzwnyeHuOY2ZHvbWS/9B
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXzyR69e8DxTLx
 Ik4TNkOQDoYGruQ0z6xYQveq0fZcl39u20XSj08T1wm+9yZb1QrkNQWhRuB/WIpzI366eg3qoHa
 tie5X7gBvgmDdKz6rgY7sto6h5v+z3stYDQDSXklqjJgwaxYg4suMgMLwtnsR/X7AXatNrnM9na
 2Av5CYFGHrFdp7fWU3nAUfaAlmaXJ2LR0fHCC8VVbz1YCXah+ScY+jytXDd0p3BcFZSxXtqUYZe
 djHl1GvbpX20ZxaqgKiS/rlQq0r5f39SX7f+eczf00rmKDEJzsLx4OuYjdpPfNbk03lcn53t6fs
 IFqONweU4HvyfIB6Ya9kD99kxy0DIxgHAQy+qQFwsnMgYBkxOCOLkHvkVIvrBQ12VbpBmG6z9QF
 e98qYSEVbrfmgNh6w4sA93lkQeUanm7E4mkuM80Eg/qUKABy/BSYY/F5GvmSxSXPHceZJcZKkUi
 tj6+6jvi3PridADSTKg==
X-Authority-Analysis: v=2.4 cv=AZqB2XXG c=1 sm=1 tr=0 ts=6a724467 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KQElQ6Bo8OdNfGCL3dkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: IXVor6SxogfKzyCE2uwN5TSnGMk4NS09
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXwjdEeRl/0+SB
 Xc/by6UDi4o3dVKJOxgJt0xxfUnuMTlHgNmzTX7CNJy0zHlYEzNwbY21HFQTTOEhR/UVsQBFjmc
 h8P15fGscU562y4aMj7jRJDGwcICisQ=
X-Proofpoint-GUID: IXVor6SxogfKzyCE2uwN5TSnGMk4NS09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040161

The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
the computed source clock frequency, and dispatches baud rate handling
through a per-variant dev_data->set_rate() callback that either
recalculates the clock divider (Linux clock managed path) or selects
a performance level via geni_se_set_perf_level() (SA8255P firmware
managed path).

Now that geni_se_domain_attach() populates se->clk_perf_tbl from the
perf domain's OPP table, geni_se_clk_freq_match() can resolve a source
clock frequency and divider on the SA8255P path the same way it
already does for the Linux clock managed path. This removes the need
for a separate perf-level based set_rate implementation, so
geni_serial_set_rate() can be called unconditionally and
dev_data->set_rate can be dropped.

Switch to calling geni_serial_set_rate() directly from
qcom_geni_serial_set_termios(), and use geni_se_set_rate() in place of
dev_pm_opp_set_rate() so the frequency is applied to the correct
device (the perf domain device on the firmware managed path, or
uport->dev otherwise) without the driver needing to know which
resources_init variant is in use. Remove the now-unused set_rate field
from struct qcom_geni_device_data and its per-variant initializers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..cd1940eae084 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -114,7 +114,6 @@ struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long baud);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
-	dev_pm_opp_set_rate(uport->dev, clk_rate);
+	ret = geni_se_set_rate(&port->se, clk_rate);
+	if (ret)
+		return ret;
+
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
-	ret = port->dev_data->set_rate(&port->se, baud);
+	ret = geni_serial_set_rate(&port->se, baud);
 	if (ret)
 		return;
 
@@ -2040,6 +2042,8 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 
+	geni_se_set_rate(&port->se, 0);
+
 	return port->dev_data->power_off ?
 	       port->dev_data->power_off(&port->se) : 0;
 }
@@ -2047,7 +2051,6 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
 	int ret;
 
 	if (port->dev_data->power_on) {
@@ -2056,8 +2059,8 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (port->se.has_opp && port->clk_rate)
-		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
+	if (port->clk_rate)
+		return geni_se_set_rate(&port->se, port->clk_rate);
 
 	return 0;
 }
@@ -2116,7 +2119,6 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2125,7 +2127,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 #endif
 
@@ -2133,7 +2134,6 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2142,7 +2142,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {

-- 
2.34.1

