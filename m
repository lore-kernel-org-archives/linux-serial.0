Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C45A512C
	for <linux-serial@vger.kernel.org>; Tue,  8 Sep 2026 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894350; cv=none; b=rAivyWxBBASjjpOB+3gFmVFvP3+a+1lUNAn+Ct6qTBnLeREj2N4z6EOSFcXoOg8uqgEgR2hsTGYfYZPxLxUP2R/DtOeeOnnXNfAbd69LbG6LOGfr6dEGWbXZbK9LJ37YYb8uzv23WS5sNX0W9KplcX7b++nqIkVgZgvihMIGUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894350; c=relaxed/simple;
	bh=NH8hCdUqoEjwggQCxCWwuM/riw4/p5jd9e2lIyL0BgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cTprkfZqesvm93Dn2up6qwQ+g0skhkAlGHRBNHTwxlLgCusO59Kx3PgSK5cQgloJayKX9BMl7ziNEYYjLajmScqzloCPtjVU9PuKwGH4uORO17Pa9QhLicMXh2Jfm5IKqbHArocua70ZWLbXMmlOUyaGE+xHBSBIVtFYyrA+6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8ClQkIr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DmpBnqrR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8ClQkIr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DmpBnqrR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688IDSJK4102989
	for <linux-serial@vger.kernel.org>; Tue, 8 Sep 2026 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QMNCaqOh+eaKj5SCYMfOKgvYNnoP17b+wFQCBXGNPk8=; b=Z8ClQkIrJ2oVTy8J
	Ke5XPuu+5XQ/cRrQFDXx/hHzWErFLhAnC4oR4Xv4c4O6lqMn+y1D2DNlgQzdrBt5
	TiK7lcdcSLARZeWlQfa4y3vt8oTD9d4AFyyaG5OomjXbDajpssE3aVoC9IavWThP
	aiFyLiMk914XXaqkViSFyodsRYsR7LozYxYyjNTN0pyLh3T82m9wdEKSit1UoXVY
	VQgFxNyEPguGIYmMejfSxxLA7/9OQJ55p+3jRitcALGEhjjNoNPHbTb2/MBT+5FW
	k++sYSxTya/9O7YJnkZSLmaW/Z1aaiQ3oAjx6vcJFgH8H7CDtx42xq632tqQupq9
	pGZRGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqf1g7q9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 19:05:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3463986a91.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Sep 2026 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788894346; x=1789499146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMNCaqOh+eaKj5SCYMfOKgvYNnoP17b+wFQCBXGNPk8=;
        b=DmpBnqrRtqfu24LB2pIbfr7XKWHIoWweezRKpJi3kuMH/ilP/mZ54lf458VV5pleLu
         Ct3tEvpXAXfKnvzThkrJPKZ8Zjpgnk7+inIdFnMrvF65mL83Gxn1ti++gRVr3CHOySTQ
         sN6M4C522RS+mzMRUNsbHAkR0TNwd4mHkYYCW8qr0KKR+Gw3U07L3ZHI1D68S5J4CzIU
         a9k7f3lTg7p24QFBCFuK4GGuCOy0AgIw/od3cNJ+AHuOHRUKijSIi4co4xZO2yHZ4QCy
         lwF7/0eKdw2+TsNTxzP7WWM/MjZRKWpmdOoj4Eph6nd+KFgU2fE884paRNW1Cct2MeEj
         sTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894346; x=1789499146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMNCaqOh+eaKj5SCYMfOKgvYNnoP17b+wFQCBXGNPk8=;
        b=VXF+wlGqhpR2fR8YCiJNkK+b23xGqKa61+v8oAkHbskjKp6psLiOOMVKzgvNVIIUfN
         3kjTesRPQL0jYuBDRaMsX1ULnwSinITsAj42zFgrAFaXUwNnpbXT2tmE4+DX4THVVGPX
         DWXduvvAlOXMwdfS2lciJ1VFHGw6r1QhvS1nElfmZj/bFbMGfzGortJp3amTOsZIXgRW
         FbZ97K6AZLj45qo5koIaqjcogdD6+GrNeg9A+Rc57ixBA/9cDYazDIHXnphM4LF3qGkE
         c0Etb4W+GLrEc6pO9ures7fQvEynKL8WqyQg9T8A7VYMq9GtYxEnac3Qq709b0Xuxf5m
         /Nng==
X-Forwarded-Encrypted: i=1; AKwUvBw1YLpcRTF7N+pgrJGMI8sQBgrH20Y893qK2v2F6ozzpkNmTTJ8ZO4yPDq+OagZIh0585pOeDRlOfCsLHg=@vger.kernel.org
X-Gm-Message-State: AFuF++kqYA49LhwyrpnkV7ogFSKug9xhWbRP6ib6PQW36ogUaa7e/Hnx
	PoEyhFflB1Xl7V5D2f/6N6kQRnw0gFZP7RIAxtSHgrcNz9oFbRVHyKrrDNwNUlsWl9sbwwDAWQ3
	vZl4yif0/0XVbJJqeAM8lMjSqttPjA2uE6XPvqZD9FQ6+bZ2iuoLnLw8qouE9zZpmkSQ=
X-Gm-Gg: AYBFou0H8TgfVLtHymJvOrnGKGjnM73bAjzj0Kz7sw6KwFYwWluHItPn+aXwC2KbPKI
	03eMlTWxb7A1D/bqRe19gpjkPDWmoqUqqQqtsjUg5lz4/jXU5YXdiS3lg6NopF930+oOmgYBREA
	RfMnzDouZ8zgL1vbp3PabVDNwva2sF4f3t4DzhtavzVUNPtaUT9KlLC9wcJSL3a+LA4igT7j9YE
	Aj5t2n3V4H0ZjDiSsArNyPH6WdqGQTFnZeWRioCPsrmEutYTigHNju7PtDwWICfw/LzwUvNL9cK
	AzaCVXr5WXYZ+sYR40KtiepUK2UWugk3RPoYsI2riBJt3WCg7WyZMOMYeBmQ4hqvItJ6A8mDnxZ
	fS3lQTNLwK+Qkw/WfSEa+w2syHlq35pWgi7ln
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr43809675a91.1.1788894345794;
        Tue, 08 Sep 2026 12:05:45 -0700 (PDT)
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr43809571a91.1.1788894345226;
        Tue, 08 Sep 2026 12:05:45 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm37603085eec.12.2026.09.08.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:05:44 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 00:35:33 +0530
Subject: [PATCH 1/2] soc: qcom: geni-se: Correct QUP Core ICC vote
 constants
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-correct-icc-bandwidth-vote-constants-v1-1-fbebf6b3c341@oss.qualcomm.com>
References: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
In-Reply-To: <20260909-correct-icc-bandwidth-vote-constants-v1-0-fbebf6b3c341@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788894336; l=2116;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=NH8hCdUqoEjwggQCxCWwuM/riw4/p5jd9e2lIyL0BgE=;
 b=0Dcb91wtWU1eJCAqBwA1L1Y8lMdK1ndi+zysr0naGtdcBD/+1Xo8tHaMgRUId6ALC9wUMWI1B
 /GZ7v9n2Ys4DjSDUtNLfC5te1X5g+3I6CGLvIJnysAhLcJ0MTnentqA
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfXw8/KvUnsoMnp
 SJAkHOimCmbEAskKanx9KwoZG3ZGMHPHcPFEpY1DiqTVBs2J97fAez7mAyci/KssUwF00x6wRqP
 1RyPGpoNcWKxjwAYdMWkf/O1pXNJLCiPpuzx5oJmpBp8u5FFqinBlmFrQDPInmtBou7ax4MrvIy
 OKabyb0+uNVzZeSHQ3AZD7mekFa7fmgOKkfMZYl0LpqR2/aOs8w0A9TCV3zQrkKsja4iMpkS1/4
 +d7PkfsfYa9T11+YRbKn3kJJtmvYnkhdFW51mOuUEa14Z+Vu/6xVDOKBzoxG40jVc88RLyOkvZ3
 y/IY417f6KI8Jg2sxnm69/ejwjfscv04F2gdsuSU4S8saD86/uBK/9aVk3EMMprO8vWl/XS8zGr
 HjO/F2ttG4N8iqHQ8ubLvI6rJ0/uUhKK0hvSOF0FnmAuS92Axg0L9HuA19C20uAHuRIjEIG5haK
 OYAI1CiU/H6w/I8hpww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNyBTYWx0ZWRfX53/VhHNmkGL1
 U/gQgXtKZ4fmhKTX0ejI0fAeYizoaTtIm5d3KO5zuxPpBhBldwxPZdsTJrd1hP1RdN4W7WdFPM0
 ryWZtdYsyNnKRW2afuqF+Ya4Jieq+3U=
X-Proofpoint-GUID: _AsROO3EXzRgA6n7sa6XmusyMc-lRkxW
X-Authority-Analysis: v=2.4 cv=JY2Ma0KV c=1 sm=1 tr=0 ts=6aa05c8a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QsC0wKSHi7t2lIrDVIEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: _AsROO3EXzRgA6n7sa6XmusyMc-lRkxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080207

The GENI_TO_CORE ("qup-core") ICC vote selects the QUP Core 2X clock
rate. The CORE_2X_*_MHZ constants are expressed in Bps, but their
values are several orders of magnitude too small. For example, the
50 MHz threshold is represented by 2500 rather than 25000000 Bps.

As a result, clients using these constants can severely under-vote the
QUP Core clock.

Correct the constants to their intended Bps thresholds so that the ICC
provider selects the corresponding QUP Core 2X clock rate.

Fixes: 58ffbba6a399 ("soc: qcom: geni: Support for ICC voting")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 include/linux/soc/qcom/geni-se.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index 29a53bbc0dd4..2243005f5e2e 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -347,17 +347,18 @@ struct geni_se {
 #define QUP_SE_VERSION_2_5                  0x20050000
 
 /*
- * Define bandwidth thresholds that cause the underlying Core 2X interconnect
- * clock to run at the named frequency. These baseline values are recommended
- * by the hardware team, and are not dynamically scaled with GENI bandwidth
- * beyond basic on/off.
+ * ICC bandwidth values in Bps for the GENI_TO_CORE ("qup-core") path.
+ * Convert them with Bps_to_icc() before setting avg_bw. The QUP ICC provider
+ * maps each threshold to the Core 2X rate named by the macro suffix.
+ *
+ * These values are core clock votes, not GENI transfer bandwidths.
  */
-#define CORE_2X_19_2_MHZ		960
-#define CORE_2X_50_MHZ			2500
-#define CORE_2X_100_MHZ			5000
-#define CORE_2X_150_MHZ			7500
-#define CORE_2X_200_MHZ			10000
-#define CORE_2X_236_MHZ			16383
+#define CORE_2X_19_2_MHZ		9600000
+#define CORE_2X_50_MHZ			25000000
+#define CORE_2X_100_MHZ			50000000
+#define CORE_2X_150_MHZ			75000000
+#define CORE_2X_200_MHZ			100000000
+#define CORE_2X_236_MHZ			118000000
 
 #define GENI_DEFAULT_BW			Bps_to_icc(1000)
 

-- 
2.34.1

