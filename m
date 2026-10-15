Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3A52F27C
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069135; cv=none; b=d7N8Gr60zJd/LBinRa+REnAAeyrnjLEzZEvOhDH/fW5b39Why0ngJoJ9sB93Pt3uN+7w1fO5583mqk8eqK9VnS4+Yno6Kmi64fX2mBwqwoGokza4DltPMDg6GZOqYUMP4BDkkvu3b7AoeP9FEZrdMQep6aSxNbmvlWbvI9FQfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069135; c=relaxed/simple;
	bh=B5rjEQXDz77PYSnOLzLQNyCWZ4XWw0tCjLYWjtT0x8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GM2S3k6Mhlue9AQqF2L684Nn2HRo/Bk8897a3lARhANdIaFoZ+QOAgN+EfSnqtXZN8NqJDor2PyqpR5B6NYY95f9Suf7Vc7Y+FwTfOsLjhyuIqI4lNKcnLLeQEFlhN9rQWjRNJlITY1G1mQHjSlfpOHYM49kICyjkUCaH1dDsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nAeLzacW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PeMtPhhK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nAeLzacW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PeMtPhhK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jWtg2416945
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GqEMkMS1UWG9eflld+AAF+sV+TXAn1oaplLJNUKG9zc=; b=nAeLzacWsclf+9uJ
	wJVuDr72fkssoG4HjAYVGgBC4CpOVOyVSNVs5KvJ5KlfYN1xTknSHqK+r3nAr7tl
	TvS3P9ekuoFTxGkeIO8XKUGvBI6rnC1Yf5PAelUkKl0FybCZCdEOHBlZq2Js6C7m
	tuzMeO6QaivnsX8r4+mKDcOBGmUFia8HU8QJRLTzDN6LK7zIfOQ7E2LofOXr1K65
	1s47mxbMITGh3HuggcLln9yIoByUQWU0GbiH2uijH59PhDLK0us0YsmtQWMUgiOV
	JpJrJp3+w4j6U5EMIyH3hlT3cr2QYyImGO/juHdNcrHkhrTnpwaM8D0DoAP5kJvd
	n/Yj2A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhj5ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 12:58:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb687f82eso49504065ad.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069132; x=1792673932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqEMkMS1UWG9eflld+AAF+sV+TXAn1oaplLJNUKG9zc=;
        b=PeMtPhhKAjqVtVT5UxVZL4PvcNryt5qauc6P3R/vmloY4ChpXa9LHyozWtRa+wi3z6
         7OTwwrtfUcUWrlteVKwdyrAiozL+KN94JxjSeOsM+QdRljDDy+PZ9zmxTqbZDzHmQyBk
         s+faUnzMjA6/URCqPIDDGqIIOZkXSoDvDZg90GIVikDLx/EUvN7r+5nWBf7mDPEohF2Q
         EX36xwRpgufoseO0vpNOoW1t3XUgFi0mMohxL/7mmalS0UEQ20HXGPri4mpJZZAs6gSt
         xLD99cYiEhUHes7e+vPVOerrT+TFTkbnrubhufEx8sGdOsqrbY4WTdXQyQb6dYuRgNaa
         nAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069132; x=1792673932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqEMkMS1UWG9eflld+AAF+sV+TXAn1oaplLJNUKG9zc=;
        b=w2juqkbP/ueFWxJzwoZbOs/GEwYmxgJNiWnze3zwv5niQDh0VIMBko6+SyIz+17/Aq
         2faXrbqEe6kvO5iJGSaog/UtRPss+8/y+WhluKT9C5kAQrcX+4I9TJZcnLHh4zbCKk0U
         oSatBuXl5wBzLZ+qtf8GnDlbMlpK3q7fECUk+VsIp8kUOAFV9SX6JfRVwpNzsN0XJcXx
         c9FMutY7nlqiQ/WL5KBBiac2PZU3S+RPiYdNCEpHxPA33c2xCagSjm4JtU1rOSGzirV3
         8iTr/SJZXoEgrySyHsfSkQ4wngTH6OmhJSzuLkrDTRWpsNHtIfQhGWYnij6BgiTx6WD4
         th4Q==
X-Forwarded-Encrypted: i=1; AKwUvByNvXtNyYMYiE9UJ8ppmizUoTzgn2E/Ng3aqCQCK3VJ+HiKzuy81/qI1DU5mwgyxSlJ+lwO+/IYElGt+nw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrBi1vd2OiHo/0RhskJJHkauNwABjQ4mwdOa3SlDwWrQn7w/UA
	Bc6wnbHWvkC6uN+CJ+94bjgljc+HcesWZ4OxtLu8Va68CioVROlXP1D22Whq7w4fifT1HVdacHM
	049Z2eJzsc6JtPYLUdAUNCHhDIYND4NX9X1naewDkUG2BolXMbhguCJaUwBElbbMvRSg=
X-Gm-Gg: AYBFou3jhhoh6HnsKmgL/zd2oecoJ/l9VycTiYLlO5J5Ic1/FtlC9mkm7fxj6g/YR0n
	rrWQpNyCfbok3p8SpzA5iLXVACCHOMbzGmi5yP7HSZBHgshbS7Nhj9mCC3SDWQ7P2BZyCOa8EvM
	26P0Hxc+fuGpayL4P6Zx3KfkfDPECqyFKZENdM//L+yhzdBZH1FhZaA+2s0wYHrnCHQBMjZdNPb
	52kKhNl/f+0Hizuw5wt7M30bQhr+Z8JvkUK3o1Y29I3BXaclmgI5kX6S7nYY2jYBHE4eBa1HDjl
	o87IgHuPtLW/Qf9xReRTYE90SwPugtTpgFkJgi+IK+7VcZ5blimX76m/VDfSu8SJvg8QXxrk5O1
	AdO0WgapM11eFbWrJyLRqlaoOSDlpqFPFqA==
X-Received: by 2002:a17:903:2449:b0:2e6:913:57ed with SMTP id d9443c01a7336-2e8429a83cdmr169905175ad.14.1792069131922;
        Thu, 15 Oct 2026 05:58:51 -0700 (PDT)
X-Received: by 2002:a17:903:2449:b0:2e6:913:57ed with SMTP id d9443c01a7336-2e8429a83cdmr169904715ad.14.1792069131268;
        Thu, 15 Oct 2026 05:58:51 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:50 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:22 +0530
Subject: [PATCH v3 2/8] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-2-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=2852;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=B5rjEQXDz77PYSnOLzLQNyCWZ4XWw0tCjLYWjtT0x8s=;
 b=U2QFjtpzZGOlYt9TZaHvmdhUmvcBoKPpx74C8L3IBU4co+eXkRokP7yEBGDCksyBHnGMVIh4g
 xchAoYT0tttD0LTVyo/JTwAd36IwQnCvFnD+TOWtDEZIQFG232sHKKr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX8F7cEDBMhGJT
 W+V+GfgJ1ykYwG8AbC76IIdrVzi++pgZ93sRdV5qvO3FxajW7AlGbnBTpRk3bjbYcL+EBnOyYYA
 QN0VhX1i2eJfQK3YJDlHV2sGGE8pdFAo0ViZkivc1h7P73G+jZZBTsuAWg4wiAIkpChj5xv2C9k
 Co+bnei8jhHJNl5NlwpZfnBb77UMQDtr2yycjskiUxCEgSN3xKuRNgKtGNpkZaseDcDQAiVIVdp
 dByoBIFc4skB/bQXlzH9m9c8WWfhFIMUyRahOaLtIC529XX+2oV8mF7UWwnkPpfgtxNTb91/TjI
 OWo5H41Jkxz3+/NpVTIGPamXxwO37LivitaJ01W1bjnLi0X+CaSBWmg+tu2bKrtOxmLdhO7ciG6
 8TIoyZHQxZjRo80M5rTW0sZNs3sAbmVXc1OAMx3IEUal5RjQD78Z4B/y0gMbFHYWiKEs/n4BZcZ
 j86+JsS/ju8xUzIkF6g==
X-Proofpoint-GUID: hETJuoK_t9i-Hg4PViSgYj3dO4zDpSby
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0ce0c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=590DCAjQX6RtSPayVpcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfXxP9mUzzvhVj9
 ShANAQRV2A1FRRHchL1Lva2FmLfs7phIK9yLdyEaI/zISyCvtOb+qEmuhBk9lQHXHQTHHr98ivE
 taZ5u6N639t+vYDE9sxO2sIPWXhtmSk=
X-Proofpoint-ORIG-GUID: hETJuoK_t9i-Hg4PViSgYj3dO4zDpSby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

GENI protocol drivers need a common way to scale the SE source clock
through the OPP framework. However, the device that owns the OPP table
differs depending on how the SE resources are managed. For Linux clock
managed platforms, the OPP table is associated with the SE device,
whereas on firmware-managed platforms it is associated with the
performance power-domain device. This requires protocol drivers to be
aware of the underlying resource management model when requesting
frequency changes.

Introduce geni_se_set_rate(), a common helper that abstracts this
difference and applies the requested frequency through the appropriate
device. The helper automatically selects the performance-domain device
when power domains are attached and falls back to the SE device
otherwise.

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 22 ++++++++++++++++++++++
 include/linux/soc/qcom/geni-se.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 95eeb9438a29..97905bd6d363 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1153,6 +1153,28 @@ int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
 }
 EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
 
+/**
+ * geni_se_set_rate() - Set the SE source clock rate via the OPP framework.
+ * @se: Pointer to the struct geni_se instance.
+ * @freq: The source clock frequency to set.
+ *
+ * Applies the given frequency through dev_pm_opp_set_rate(), targeting the
+ * perf domain device when the SE has power domains attached (firmware
+ * managed path), or se->dev otherwise (Linux clock managed path).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int geni_se_set_rate(struct geni_se *se, unsigned long freq)
+{
+	struct device *perf_dev = se->dev;
+
+	if (se->pd_list)
+		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	return dev_pm_opp_set_rate(perf_dev, freq);
+}
+EXPORT_SYMBOL_GPL(geni_se_set_rate);
+
 /**
  * geni_se_domain_attach() - Attach power domains to a GENI SE device.
  * @se: Pointer to the geni_se structure representing the GENI SE device.
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index b3372a3147a0..8c3c5b68151b 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -597,5 +597,7 @@ int geni_se_domain_attach(struct geni_se *se);
 int geni_se_set_perf_level(struct geni_se *se, unsigned long level);
 
 int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq);
+
+int geni_se_set_rate(struct geni_se *se, unsigned long freq);
 #endif
 #endif

-- 
2.34.1

