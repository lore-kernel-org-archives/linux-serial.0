Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AF63815E3
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 06:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667457; cv=none; b=nCVQSfO4CSf1rQRyEkSeeUp89FtOtx2OnEiHkrE/brCRaXfoFAJkkrRgz8ncUVQefc21qVYbrcCzZMiYgSD4pzChhxKuBc/Rlpl9zgoksXdHttdMJoWSJ2GGKVk8d9tiZGSUgHJZZzRK1e0pLjh5eNQj4xyfTZOT5oVsKsS2BOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667457; c=relaxed/simple;
	bh=s6pdxHoI5hvCRhFDkqXtAgC7HtCveanbHrTod1f/yLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DviNgYnD04jSAOisLiX8/+pEndbAPY/VFWCb/YovK/FPA8pC5kslJJTF2c/v58RwMeCugl5lEWsQ9dK0WDjftGDOH6Mu1Ada1jpMap2LBn2G7E7ki6So2G9hz76BOE+woyi9mENGjxd0OY792ndujmtIV8XJeRAFrAzR7ZxUvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aQwdBXjS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/J569I4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aQwdBXjS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/J569I4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K6a4cX382691
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 06:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D7K7654DJb4U5jc4p5qdGIOfHpVUN7aYFET
	3b2LG/ok=; b=aQwdBXjSXkfr+kOhmVtzoe+vG1mV36ULNo6iltWCRtAtsr0d9yV
	+l0B/SkB1DKB7dL7yT/C7mk33y0P9TX+r9naL+GTC+1zJg6xbk4gpFmc1Vk6N1Fz
	HO3OzUYxJVxiTCIaONEthrbEWW8SHPGtBVMnLsvXPrTM9nV3m1MWyNf9nK6oaTTS
	h1m1ers9emvTHG9Br79TSL2KU1/4LxmO1BxZQWNg9XLbdQozlyk9Ln6++WhGlBhE
	jxhqBApAhk5jW9N6z5WbexGAJPX4dzyHXOcAKKxF8g8ChxjFFr3PyRFm4Z2R3423
	D8UGuVZ1uQlb/fErKhbS5jOnBGeX69kzI4g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx4gfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 06:44:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c7169f3a9so4122107c88.1
        for <linux-serial@vger.kernel.org>; Sun, 19 Apr 2026 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776667453; x=1777272253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7K7654DJb4U5jc4p5qdGIOfHpVUN7aYFET3b2LG/ok=;
        b=c/J569I4owNeHUyfC6S8VhmpoCDiVLKEneQ2zXJrz6Hj4W3RPYqztJMvkeSyukk01H
         p0INkh2L+kF/MGbpb9y93d/DPKSAHhOYLmjkJto+Iuou0oqSc2ykBDKw2aF+70k5IYnG
         GDtkJ9Q+Ndh7QlhC8EUNoZsxQbZM5caH9JGyv/l4So45iyRzn11ciUPNJD8zrysMx+9m
         rvePKhyDBUG83/CMw+F4l2KzGqGqoxM85049aXy4mr/AEhL67HWDDyih2D1jDEyXMJcj
         ppS6uCzJkQ1H2CbgFkzRKh7i5VjjjWXPKMGKKs5LTYd7XrYLPB8/sreVM+mxn0q70at8
         9tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776667453; x=1777272253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7K7654DJb4U5jc4p5qdGIOfHpVUN7aYFET3b2LG/ok=;
        b=ZGvs1jr4w/dWPBES50CuK7gNbiWWL0Dlq5xEMM7ZNBEGG8L7DwTbUj/b10sHms9uv7
         HYSNWlr9SyqgzlT+e1z/EJGw0h/bWxHcpTGsJ2UMV82Tn2LDv2U8yMRdWE5toZ4MMCbG
         17qkbjyWCiKdlTtKBzs4mUbgaiYl5/x1+aT7/YqS4rApwxnzJGduQjBRbg//TMSjCTt1
         49zAACIOKgeESJN7ZpKhswtVSKPURh8dc0AuK3ffXP7mE6qrkrtsX4fVUiLKCHS83Tw6
         NkddlxmoCe1f58L4AGYOvB1pnOkEdRc4jrtJD80ZXGa8aphi1GjFFB3VfgnKiWcJwxcH
         p46A==
X-Forwarded-Encrypted: i=1; AFNElJ/bCBZXc//BmxS9nhCJt60JqeWeCk8GrR0KnTAS+FXaNFjDHGJ6JfWLrZUz2INm52fLyjLhPJDhVZseW/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrM6ZXGG8I4uh0QiftF44wO+Rx+s+N/okOPxfgxz3hum6eTrMC
	bWmfXAa96uR2gWoOQAkPy/vnF6PzsPqYdvUtqedVUqMu+PvwKX9WEP6XIAOykudZeKuCciBrgAu
	8y3I4l7IclTDBG4XHrL3KyhQqu2S1DUdgXb4HIUwFN+o1uOTcUq4SRZ5+ai5Mcgwgiao=
X-Gm-Gg: AeBDievtQthhDQgRwofkGFJY5MGgdIAYND2RutW5nCc2ZATnSmSseAdYqaSECgrl4Pf
	cxtmBPfb4IhabCn88p+rB+L3hftnXCU/0UxfjIGbCZCnS7ulYrvgOt7RFheXe0FxKepE+n+jXW/
	5+MFCq6tvtHCcQJCaN+MlftKz/WZpSwiSKzBpvhM3DHudOeUhNT7zIHm64RJb9j57h0FxJMoZel
	1hxpjGAcv9tj/tTLu0nWPaXirWWqHVhoBExP124kP7fplNA8rUGlDmlXDkTu2Eo+hc8jWjCkbQ5
	VqDRqGJOF7zCYPD7iGuHUD5lc1ePfTgnDcFN4wZ/wINtgxl2jM+NvEcxvbwfVFOUAD55f0/tg2l
	ujCAQa5Nzf2g2R29BrYAbQM+rFRosMo+F3703Qzgs2hrt/joJlS3GxWSsvoagjngiRY7gnpHRc+
	ihWg+xW5F7NyEtvKbY
X-Received: by 2002:a05:7022:eac5:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12c73f975aamr6675238c88.17.1776667453214;
        Sun, 19 Apr 2026 23:44:13 -0700 (PDT)
X-Received: by 2002:a05:7022:eac5:b0:128:ca6f:adf0 with SMTP id a92af1059eb24-12c73f975aamr6675216c88.17.1776667452659;
        Sun, 19 Apr 2026 23:44:12 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749d29cdsm13731352c88.6.2026.04.19.23.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 23:44:11 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: qcom: geni-se-qup: Add compatible for Nord SoC
Date: Mon, 20 Apr 2026 14:44:01 +0800
Message-ID: <20260420064401.1248833-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _kh15bfPWJ9MHJhkn_NnkZd62dVPXk1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA2MyBTYWx0ZWRfX5zYHftijksC9
 37NNRcYFqeqb/mUZU8AzKXePhWHeJrj9lawNW+LIJfWZhqv3HSsDh6SmqMz079Nbg0Kz7Vaj3r4
 VlmMxS7gX4ixcf8ucaMgPN77k/Qm4eygCbZtIQUstbZIc/np0jAsynG++uV8O9qyAku7icVeNKW
 vl8OUKq261FDopJNGyqMdwZ61jcPYW780G25hpJukQ8pBXZGuZrW3AudMsWBsZkt/c+a+du5WHp
 ip7BMTJMq1y3bnsn0zi3f1eXNGTjZTMGsoIYkSKwQOQytNmVJJQUk6jMpQPJT926slgLmc5W8u8
 AS0mgiOp6wjMc7HM3hQb5LGQAISCKYgHzWlvaU5cxuVKrS06Ka7gOkgirYNE4j3qwtM8n7EkGVy
 05QADobiHWgnb0+/1OlzhU6BdNDmY8BNObB9l/5S3eGi5tQVCtU1V3RqyBEayA8nazUpcKSPv+g
 3mz55YFedWP82Tz0iUA==
X-Proofpoint-GUID: _kh15bfPWJ9MHJhkn_NnkZd62dVPXk1p
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e5cb3e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=RtP18x_fKbAUknpFPucA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200063

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Add compatibles for GENI Serial Engine QUP Wrapper Controller on Nord SoC
with fallback on SA8255P compatibles.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
index 352af3426d34..d73f9edcbbdb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
@@ -19,7 +19,12 @@ description:
 
 properties:
   compatible:
-    const: qcom,sa8255p-geni-se-qup
+    oneOf:
+      - enum:
+          - qcom,sa8255p-geni-se-qup
+      - items:
+          - const: qcom,nord-auto-geni-se-qup
+          - const: qcom,sa8255p-geni-se-qup
 
   reg:
     description: QUP wrapper common register address and length.
@@ -67,9 +72,16 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - qcom,sa8255p-geni-uart
-          - qcom,sa8255p-geni-debug-uart
+        oneOf:
+          - enum:
+            - qcom,sa8255p-geni-uart
+            - qcom,sa8255p-geni-debug-uart
+          - items:
+            - const: qcom,nord-auto-geni-uart
+            - const: qcom,sa8255p-geni-uart
+          - items:
+            - const: qcom,nord-auto-geni-debug-uart
+            - const: qcom,sa8255p-geni-debug-uart
 
 required:
   - compatible
-- 
2.43.0

