Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F14BC017
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853591; cv=none; b=O6X5wD5OsDxLoy/FVnQ7c5lD0nyrtpPTLieacjfQk0Hy0C+hVjKYicwc5ZLUwRI+kDxyOckah+ufnKn1iAjXatPrjslsSm8HjXiOeoMIsdP5ScDswt+5xzgu3JN+R1EIdzpyjje6SUKcn5Mx04pBHmLFDAaBqptYWh3jDwXWU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853591; c=relaxed/simple;
	bh=AdwimWmojgUMjxZge10azUFM2Iq4ZF78vSGW37hlcsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4Q3VKe9Uf5VBu1nMPusDoehUm2+UC9v4iQj09pzCOVKIY2dV94t4pk2nIV1kzlu2dIjvHwnVBvsbE6DWMcvpjMuTWFRY7gudzka013UigzlEkTeB6hHA7g+Rk52Eksn9qIyX7HIpuond1tqVhxF4RFaAUXOA1c1d09Mzrh/OoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpmrNDUr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U4HjNyu8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpmrNDUr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U4HjNyu8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXahr4178238
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=; b=XpmrNDUrTP07n6Om
	zBk1IGwXBnu3yb6XzL2oGK7gsqtUKCn6hDgZyCHHa7L5FhB/hQj3Nv1jb7iQrrzc
	1sA39PPj2avc4zoUd1+AqtAYOghG335Xec0aadP6pH5ylM8IGqxx0bk0RBuHe/Mq
	NF0fQaRf8nWdCrOLWyg26rbTv8CuOBxtiZdh6oYgIFPt59lqWaywE0xV3iZHd3gN
	4rBZGHoAKI15tzYYyKgx2xn/UrNbV9pI8hrrENjTdKkKlMkXS17y8oPLCKY5Uyn1
	rRQ3sYupp9dbf2YMGE/xvwJNkYee1Turn3TvMRFnAc4w4i0aFS2qk7W1BnZ6PInG
	YwQBDA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw14t0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 17:59:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso345026a91.2
        for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853587; x=1788458387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=;
        b=U4HjNyu8rrZVc3jMyBDxEn2O0251uvAUIHfJ9WifGgtbUTfTcQ5xM8Uf9cA5FsSvPh
         PNnkpmtRWKpvlBKgSsAILSrzchzdeSx6lAMiaV+fPaE89l/eE2h+vC65rk740rItWQSB
         yl8DiRjB16WKzCbCLIDLn2NxaIpRjKCK4l7oFB3t7M3uS/RF4A2C2QU7B+2CnDYuXsN8
         4JqhA+XLbKO80gqqHeNfiGwLJ3KqFC/Cy2HPrnhjlJY9e9anC8PVkGJI9YLYGOwegoAU
         I3qIRNk+YpCLkGQKadxXLj9Nf2cOvmS4bn2suYNOMa6hYxHr1jt58v8Vyr9VylpHS0Mh
         azAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853587; x=1788458387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqu+QcbOtbM8Rimddb61w33ixiI0vj6whMYuEwbL0po=;
        b=KPxiVADPhlJWylDAIw6Mojm1DdfGq7HXcmjoV8ooV6JqR33cA3u0aWha3NNsmGHys7
         hesqEJmqY/AuQP1DxToqb0ldH6pd9dojg8QCglLSCeEqR3iGIAGGc06zBwbO7fVVHm19
         nqf2llgM8fOh6aSb8+IE5EWVd+HNP+ybgwej9yIjbtmQXv38OgCNS5454ftKZhT8XHmk
         OyxotyeaLfEcid3JL4n1wNWrlkYUUk2dxt9k0QrMlYHucwVf2h2tUwaT7pdTpi2xm/Nb
         ZodRw6ckeTp3LtNftnout5ItsmmmvQbeBNGZUcZz+XIsQSG/HrSektxf2UsndXxiOsxk
         Swtw==
X-Forwarded-Encrypted: i=1; AHgh+RoFnJ1NyKDVO9FcHrhBxuYbK3YIjpS3WQl+oe+R9EdvWMSIUio1vbLSSHN8ZUBm8qX2QziejFtAdl9ZD+8=@vger.kernel.org
X-Gm-Message-State: AFuF++lNlqWa6y0OIkCqgXDYQtEp0Q8sR19JIu7h04SHFkSKEbzinkPm
	5Xa9TaaTX7p0DwQUvMZCByW70W+H4o45p6vaBf67+1khJ1jKZ3lKmqmGt+6DN0ia2Cclr1QjFAu
	mfQAb5kkLiLB1VHxjogNv0dpQEFRHYOYXNf+izwD/VqrFhddUTkwNTIVkpEYQeM+VghU=
X-Gm-Gg: AR+sD11cE5QY8AYSO3iXWKZlOrXhiggi7ltAlEfhi7dwYyan9VGtKNmWxEVsnGAQf+q
	VhU8qUJHO+J2GqyQxxK/sVUlskiGtWQ82ZQj+DcZx2vkKevzwmSX2Ct2gLbQ4SQDNfk/EEiFLYn
	NrhIrQWTsg0zP7KoIxPgyzkQPuIeeybWZmIUOGbnDWPbDUOcj5gBvqDG61ibPQxN/SHMyaUEDM6
	r8wOAH+9S9xZN6HE0oOvMoU3gQ7ESdrgORTGlU7+IhKUxmtZwWnZvYpIf5e95o1z6muNfrmKJBg
	kK0s5JkppY8Fq3mQtX1i2HxJa+TVW1DOnmnGoDLwFlUZRmYgkSA6DjO5pqtHzs8a+hWXT1f3oAp
	ViH41wOp8swl05Stcl0W/7VEeRPMCFrLcTw==
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396d0f2391cmr1736508a91.7.1787853586859;
        Thu, 27 Aug 2026 10:59:46 -0700 (PDT)
X-Received: by 2002:a17:90b:380b:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396d0f2391cmr1736384a91.7.1787853586253;
        Thu, 27 Aug 2026 10:59:46 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:45 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:19 +0530
Subject: [PATCH v2 2/9] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-2-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3349;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=AdwimWmojgUMjxZge10azUFM2Iq4ZF78vSGW37hlcsY=;
 b=xDUNaR1wqkINGiOInqWE2jn/v+OQHLBDBZ+Fh1roliGz9vW+grwzgz+g46Wp/y3TBYYP/MmbW
 uAIRm9TQvphA1WS8qhacIvgyjp2JvGqodTTkFyYqG2IdHsmXGD2eSj6
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 4FGHbgyAoTHBaVGSJl2BxfJCHvdCqIbV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXwveMHv91C+/Y
 D0lXy4Z57eLqGame8LENd701gr6j5OuseDySjWgWbRejR+kqKhwTiaU2OXtiLVFddtI6ItuZfRG
 xFLuDzPDNYGbHxikeQwVluezsff+yZw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX7LfsnMhCtTQm
 xWL6rfZF4Y2tU2Knyk3/G4pX8/TbqLxs/Jsx5Ab/smbDVDFaaKNXZqgjQOihFATV32JNxLOqeNv
 Ps2bZUk6tQIiUuxx36WxOYSUg/f21vTqBXZ9jI883vCKuk1Sds8VNbDyWaUemSL+tKwQ6xu3LN1
 5dpjSeO56wgcCGkh5MpKkNrj2B2CfH4nFy7QPKoYEaFf/nPWLwUpjJPiCXyX9dT0VkzOgqifafH
 TZZBkofuQ5DtUxGtubmje77mRLihjtUZAHF0Eg0RFalHE3LU9+Agc7kAibM3VXwcqQxQ2Q4hjMy
 I2Q3WQbw5MBZREpMg0ujlhf7QeTyDbtbg6Ecis38pyM7vAC6Vx1OdbpN2qqaEwF+S+bL4CDEVJ8
 x+XkqXhsqrbqc6TWdv3YcpMzA6Ny/cUG/Y7Xi8iW/5rvMFE5wmU0nP67Ip9KrtB1HmdqQzag1K+
 EYcoUptcnZu4iSGdQVw==
X-Proofpoint-ORIG-GUID: 4FGHbgyAoTHBaVGSJl2BxfJCHvdCqIbV
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a907b13 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=CVJBOM8IPza3kUTEG1YA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Currently, on the SA8255P platform, protocol drivers attached via
geni_se_domain_attach() treat each OPP on the perf domain as directly
corresponding to a protocol value such as a baudrate or requested
frequency, and simply request that OPP via
geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
computing a source clock and divider combination for a protocol
requested frequency, unlike the Linux clock managed path which derives
this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
applies the matched source clock frequency with dev_pm_opp_set_rate().

Change this by treating the OPP table exposed on the perf domain
device as representing the actual SE HW supported source clock
frequencies, the same role clk_perf_tbl plays for the Linux clock
managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
iterating over this OPP table in geni_se_domain_attach(), so that
protocol drivers on the firmware managed (SA8255P) path can also use
geni_se_clk_freq_match() to pick the closest supported source clock
frequency and calculate the required divider, and apply it with
dev_pm_opp_set_rate() the same way as it is done for the Linux clock
managed path, instead of relying on a direct frequency/baudrate-to-
perf-level mapping.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 873bfbd6b2b7..447b9cc6babf 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1155,7 +1155,8 @@ EXPORT_SYMBOL_GPL(geni_se_set_perf_opp);
  *
  * This function attaches the power domains ("power" and "perf") required
  * in the SCMI auto-VM environment to the GENI Serial Engine device. It
- * initializes se->pd_list with the attached domains.
+ * initializes se->pd_list with the attached domains, and populates
+ * se->clk_perf_tbl from the OPP table of the "perf" domain device.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -1166,7 +1167,12 @@ int geni_se_domain_attach(struct geni_se *se)
 		.pd_names = (const char*[]) { "power", "perf" },
 		.num_pd_names = 2,
 	};
+	struct device *perf_dev;
+	struct dev_pm_opp *opp;
+	unsigned int level;
+	int num_opps;
 	int ret;
+	int i;
 
 	ret = devm_pm_domain_attach_list(se->dev,
 					 &pd_data, &se->pd_list);
@@ -1175,6 +1181,31 @@ int geni_se_domain_attach(struct geni_se *se)
 	else if (ret < 0)
 		return ret;
 
+	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	num_opps = dev_pm_opp_get_opp_count(perf_dev);
+	if (num_opps < 0)
+		return num_opps;
+	if (num_opps == 0)
+		return -ENODEV;
+
+	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
+					sizeof(*se->clk_perf_tbl),
+					GFP_KERNEL);
+	if (!se->clk_perf_tbl)
+		return -ENOMEM;
+
+	for (i = 0, level = 0; i < num_opps; i++, level++) {
+		opp = dev_pm_opp_find_level_ceil(perf_dev, &level);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		se->clk_perf_tbl[i] = level;
+		dev_pm_opp_put(opp);
+	}
+	se->num_clk_levels = num_opps;
+	se->has_opp = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(geni_se_domain_attach);

-- 
2.34.1

