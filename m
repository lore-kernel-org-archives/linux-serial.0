Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8974C6EEF
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873530; cv=none; b=uFmBrh3Xo5N+acfNjDrTzY7gPL2yp59k68tpHP/1d4CUcs+JmPk6McMn4TKOthXIj0wj+Ar9rQatfbjiImOJ8+tgsFTMJQ9zWLR6vjGtzlyGA3fIuKayIFe4fmbezj8Etv+QvHrFWELpU6038TeqGjNjuDRd/S9pl948RuAHNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873530; c=relaxed/simple;
	bh=kPzOm1yNF2GSWJ3AQU+hUVYpKCMr/c+8cF2aK6E6Kfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/CrMG8L3yvW7+FePqJ6ClYvqMmNskXnYBNjyaD0WJ4n+STP/7nNcmglgp86DWc1yjoKQYp+AEUPaYczmAYuH+AAryNQMzcl5M9GjVsacYktv46w3XqL6xzOIZolNOaCq86GgsPqgGkMZsbjSvNd7W1Bi0nHS27Bj5cvJr1CEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fIaKiKX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q1VXZfzK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fIaKiKX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q1VXZfzK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Jlatu016152
	for <linux-serial@vger.kernel.org>; Tue, 4 Aug 2026 19:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=; b=fIaKiKX01mNOB/a1
	Sy8oAkJeBryckX0ahyvUlp5dWd1hV51E2rErHMakYaNl2ppcMw4VMy4dmBv8k3BY
	aB7jvkegaULlaJQq3SaNCsLQ1HBh7pbltACET5mfF3IwzNRxhXD1bK10hBIyE1VH
	F88X7su5DWb8B0N+BFCuOcrTOiebmALLQYt7f7z/mXLe/X2zcP37H2HPeGjj+MBa
	gcgZEcO5vurNgreOIOaIosTKI7FK/KI3kPrvxakEjL/AuReV2I5k6yYmo282Geku
	qcmQmzVAswFbB/Aq707jBu6ZY3XMWX2a3me2UNmb7lfZdmErtPQi2A5RALOfLtw3
	y+fV2A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23jxd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 19:58:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb74d5db64eso132291a12.2
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873524; x=1786478324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=;
        b=Q1VXZfzK1tDG6tHi2ZuSGd5i+uxr+N/zNBaqVokz5+1V/j1In+P9zcaGNQ+NVGTmBt
         2OGXayPk8e8DB0BldEZ9fTwIRCGZMf+obfyxCEtWko4LRNm9QqUPlPi6oDCmTeCjxWxp
         mS9wz7RfrTg4pjIzXlyrZD0cBvxUWv1eYYs4y0uEJ8a+WdACLeQCXAgn3KqsoVne1s+O
         rqmxjxP4F1NWGguSYDxcLLk4g/OFv2QDWaB9MdXUJX/hdCu/T488/g1kGoc+6bw0KELw
         oAGwPb6xw9ccqiM4opxAjMkYVI66nzAx8gtd3mw74ExOfzNPu5g2YXONucHssirLiPUd
         iNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873524; x=1786478324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpHJgO1V/4sAv63uQnIq4dASzlYb9B2GR2EdD6oSXFg=;
        b=gsuuw21iwxeFxSrbY5DWtBeHVxu0a1baCzBNq0Zt/7MZ4c3U60IxJLF+KOAsM68IuP
         js0ydgddgUMQcIG1AnwapNutwzK4KaPMRZsm8jec83hBdc00jQ4BYwU5fezqo1RWXSJ4
         B0ZW2llMY2+rQ0XrPr9GOphQ/aDubFA9HM+6Eo0qufKB5UjXfkifVAca9EkGzLl5Zzoy
         DEz5PN7m7ltTXolDi59044HmBRNu9vIEe8p4yLzcFmbiQrdcsMqP1PlEzqg9XhkImES6
         Mi68kz1oECjuRbqOoRFJmpz6MvyteWmxyoP2Yzk4IX+OQrFMV0ynJRhDw++ywWjnVK9m
         BxqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYUtsaqRLZ56gniCL/ElAQxyPb4+I4F78cpQT975R4wH+TYbekpqc+exsFW8yVsDXP4qtLJ+Sme9YbGCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68ARD0Cd0eG4adD27dUfCKWXlD6upM51mRI3TaVEhd35lTRPG
	wKa8V3VtzYyPsaoL0glYcvc5Tr37pPC4xQKLsGgRFmM1GMXdsvznOHzNpe0GpJpkavpIwlKficb
	8CzBZSejCBs7Bze+6WpKWtIUQ+TLN+69qiWtQXXOA4JnGuIyFHJ7QpxYGOyKzIMaTqbudYFgFMP
	c=
X-Gm-Gg: AR+sD10B+/8oW+DWQtyQiK57nH3k9YE+dfc3puS/OT7YXC9UgWUuyeXcof/jwymC332
	j9F+BgK5gJZMmFx2Kb6sl8Tuks8PSJn3zHaK3BDb3gW/7IqCtsGGXTfjv3Z5TXPioV7O3xSPgLj
	jjtDXD6PW9VZtTvOjiNt7qjterZ1H16UrdHTHguAfVr4YhxaJHHtQjDvRKelkOxgrdBuFWLkurK
	rnWmkSV2jgDPQFsToqPPlf4e05hx7v/J0CaqzyCZVbyNP0aX8rKmL1+lJEAhIu9ca1Nd6BgOvZ6
	JgbpDUWS7v/qoZxdFae9zlUUh3kQlUVG21nKXVf3ONJJd4JY/mvpF0jc3xPQgLeWPXbfnAb8+cA
	7QrsWwxf3fkFLRAdp2/QXViwZnlGI2lv3XA==
X-Received: by 2002:a05:6a21:3a85:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3cb85dbd12cmr1203031637.9.1785873523885;
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a85:b0:3c3:9070:96bf with SMTP id adf61e73a8af0-3cb85dbd12cmr1202988637.9.1785873523367;
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:43 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:44 +0530
Subject: [PATCH 6/7] i2c: qcom-geni: Use common GENI resource
 initialization helper
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=3271;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=kPzOm1yNF2GSWJ3AQU+hUVYpKCMr/c+8cF2aK6E6Kfk=;
 b=BlEwMmGmdnL96YVYyWO8W4gJizfYcuaJusTDVCj2kLklLmnO0Q7DNPIEPA5R5plJuyZ4KrDUL
 SrUDtE2FutzAojctg5UwO2Ii/QrSYUr/8A7thKVWo/QzqkxlNUiQsaR
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: j3ITNSXF0qXpG4B0tPm0Hu5OIpjceT9w
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX5Y7HzZHaoWQZ
 xIWTmb7ussaqBLTiDehNDen2QmkFw5d4tIUZwQbFf967BmOHMlbzEM2afYL4klEAOzvi3FhxtEO
 M+qdPUlQRrkAlNbKikS5GhZGP9PxFWk=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a724478 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZE09iLx1Z5sgUNS67XgA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: j3ITNSXF0qXpG4B0tPm0Hu5OIpjceT9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX7cBT0CVyOS5Q
 EeD0N1M1qB7Mrs/ptI8J1/j7BsJ+l/CBtTh5Er3OalYTK9WFW5VX4WDoEOdGMdbjgXI3U4OxGzq
 frgkHRgqzbM2nGc6iHpH6/wV9l7c2/7oIMYahFTZ2WA85yPsyLiVMzSsA/eG/syPZn/y5EjvWGF
 UWxJjNc2XFqyBwGWDLowxtk7S0PF97Ppdu3uUbddocsHU0EEUXOlTy84G4gpyhvnLJzE1x64+Ye
 NxKLs8zDPte+fNDPH2FjTDGJRJUccrxcdaGy1oc67szE0mMBoKbv4u+yzv0kXTbM3Sb3YhP7Rcu
 lVGR2jY3dwG8xvckz/z9HdbaB+LKoNEp4/b/SUheNCAsWxZTOzDZ30eYAoAQCmxWfOHTrEBgVjw
 WT4BMN29eCjSmatMmzrpZIGmRcDCEWgh0MM0Pgo6/zq6tJj8LXpyTcSQjIrYaqaYEURih0MH/eg
 VwwpIZej1k7Vd7Wy2cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040161

The driver implements a custom resources_init() callback for clock
frequency validation and bandwidth vote programming. Neither operation is
required for resource initialization itself.

Move clock frequency validation to probe and program the ICC bandwidth vote
from qcom_geni_i2c_conf(), where the bus frequency is configured. This
allows the driver to use geni_se_resources_init() directly and removes the
I2C-specific resource initialization wrapper.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..a23554d101fd 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -228,10 +228,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+
 	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
 				 itr->clk_div, itr->t_high_cnt,
 				 itr->t_low_cnt, itr->t_cycle_cnt);
-	return 0;
+
+	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
+				  Bps_to_icc(gi2c->clk_freq_out));
 }
 
 static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
@@ -1100,24 +1103,6 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
 	return ret;
 }
 
-static int geni_i2c_resources_init(struct geni_se *se)
-{
-	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
-	int ret;
-
-	ret = geni_se_resources_init(&gi2c->se);
-	if (ret)
-		return ret;
-
-	ret = geni_i2c_clk_map_idx(gi2c);
-	if (ret)
-		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
-				     gi2c->clk_freq_out);
-
-	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
-				  Bps_to_icc(gi2c->clk_freq_out));
-}
-
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -1188,6 +1173,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = geni_i2c_clk_map_idx(gi2c);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
+				     gi2c->clk_freq_out);
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret)
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
@@ -1281,7 +1271,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 };
 
 static const struct geni_i2c_desc geni_i2c = {
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
@@ -1290,7 +1280,7 @@ static const struct geni_i2c_desc geni_i2c = {
 static const struct geni_i2c_desc i2c_master_hub = {
 	.no_dma_support = true,
 	.tx_fifo_depth = 16,
-	.resources_init = geni_i2c_resources_init,
+	.resources_init = geni_se_resources_init,
 	.set_rate = qcom_geni_i2c_conf,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,

-- 
2.34.1

