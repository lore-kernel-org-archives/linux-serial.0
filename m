Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF941917F0
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777251691; cv=none; b=kGOmsohteorXuq8UduSK7Qji32fNRV2Bsq7cs95VWD00IxM/L7aI5qr1/jv3S3tEkNKw2BDVJtAX80LROQxQVUWJP/uAuZ90Mg322VRYBGujPDxZkv+idMVR4KdJda4QeA9QfS/rnWu/u8WuxD3e0p+NIIfl+IR6jnoXPWuCYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777251691; c=relaxed/simple;
	bh=64X6gRZj24EJLRck7nWbtxsgY31WTgogrdqax7U5WCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGrRyTxeDqiJGKspMsA5jRu5RoJp3Td3m6BY21vOX6K+IeGxwnBmDR8bZH3dQw72Llg7eEf6jZkKVbxPWvCpH4Ion0gxDzXpiq7P1/p/qBRpWEb+c0yChivbT0ksq/od7LI9MN4VdSPaB5Wa9aK9Bn+RE1rLLeQMn8DW2IwsilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GiFcGBJ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bDG4mo3w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiFcGBJ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDG4mo3w"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMCmgU173900
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 01:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b8d9RUs3iXEEZexOSccbKlP+1XK/y+cdxl/
	s6ARmPiM=; b=GiFcGBJ/kfHCmFu3BQ5wUarQy51kCJxLR5KzjFS7bt3UoXIVH7/
	FwfmpENr4IuMdvOL/WKdYSWo1VY++SuvK+/SswrJKR+4w1c1VCMbZ/sYkh35m5iM
	gIEgPyOOvER/QmUWJYiU2IeTEVlUmieG1ky9VF+SYhtLdZuUT4NJTLYtGrlPC750
	JzYdpDHxE5FmExz7m3QqFufD9xZpbL33zuxSxrFowsK+UIKaY22f5AWOVz9zMNvu
	B+iyJjLCutVYFR1tp95f5I0DoEKODVAOBGV67wsSMYuxMb8qh/w0GSZWYifhmqKG
	CY/EIUQZ/aE0KW6Ehq4dSrF6qaWqlDmA3lw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrktnw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 01:01:29 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c20d5d7f4so47005717c88.1
        for <linux-serial@vger.kernel.org>; Sun, 26 Apr 2026 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777251689; x=1777856489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8d9RUs3iXEEZexOSccbKlP+1XK/y+cdxl/s6ARmPiM=;
        b=bDG4mo3wgS4AUKEI+sYRyMdmp7O/KrYa0FpDO8oFk3I7gvQ84XdVxv0zd6+RG9gMZ5
         0nl82pmRP3cp0swNnBnHnuZ4bPsOltlBH09OUbMIaG5GF8Fv2/Hcmq0Ps5ifW2TpXQMC
         V6UzQl2+rqy1Eqh+jpBGS16XHI24FOC1C/Rd+6a965HEgKeIqXtxNlZLZvyUg9OYmzo/
         z154r/LQeA7JBV4qk2jxSDGTaITGC0k6ojDuiStShK0aavg9+MJ0vNi6TCO0JCofjHu8
         mHCLiesrRBK/JVG+7WJFa5MDqfCpbIOazQ0s2phrb1jX+uo8RtA0LfA2VJqZvy7fdokw
         izJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777251689; x=1777856489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8d9RUs3iXEEZexOSccbKlP+1XK/y+cdxl/s6ARmPiM=;
        b=Oqacc6c7FQfigN08Lup6djbAuKO8joV2gkxx21tf/FiabJ3KDsmIyyVB+BJct6/CLr
         OlJGHpyABqq30XhS7BfE28GlcmvTPBNhhxqnEJPVbC2B1tMDrn2QslgwzJvfspDHF6r5
         mQXJSoCi/RTw+aRqj6qbW4Vu9BQetwP1qv1EomZq6EQnULIO3bjLd4UZf59rI80c68Fz
         EJuMkubhZanjgv6jmXqSa8wBCCcqNHAVMOjwJ7FwmKA1why3fz2w9IVUv32LcJtCoD0j
         iD0NmT8XVeg6/n+kf8XaTfOPKDv6FcXWWXeAQU9xGtm1E9K1WW321/39pLU9mk3Dp7Xx
         ctZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NVEIVRNzPLxvZiI9cD24Xpd9wQ3n1QdOc4n8r20Znu1xHRZLVCEIoroxzFHwrJG+cxmBjLyo+qVotuzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwz9YayLNm1p1JHk8K8SWUwtY05DyQBUSAUROPCbFZ5SgruCfb
	LNgS9od+iROutktmsvq+h9pPXGHxwGQWh0qoeb95+2c8vFbya5oLnjH9gQR1EouCuF67OoEaLSi
	DBCrni6tVZdVKfu4MU+wrMkPfo3PIWPEjvGKnLxkywPxXSFYxjo58+II9ItJpYHI5bKE=
X-Gm-Gg: AeBDieuMfcWV4BblBQRHlhJYzdbx4seM43zYFU/12VQ7X2mRCD6Hu9HG0xkFgcYTDfU
	ApA9S+knvBqQbg1LY4CXWEfKCd2qpNFgESR8y8RgqHdOGicRu+8CSVFjfRZCFwj+kmgDtn+XIa2
	tUZC5g8tN5MqJUklPkm1uOXrtFiPJITetd3BvgSu4ce6kYKKKZ+1lKN10YAUc1Nn6uMyAj5XHfV
	jFfGl/dupCyCIAKi344XqWNAuREYDFIkse+X9D7d4EXdRPInfNmfzAVCGoJya8EYliT98UnEO40
	cNXYgYkg6vjqzSloZiOxk1VQtL1khHcbCdaY5U9O+9Vrfco57tCFzIFsfVdmV2cBDWV4XnTjRTj
	3SE9ESEKSNGmegHhWba6ggF49UUp20n2hiADBIP5gCv8A3KnSHNwfss5lxG6l1csuuEifjycs7b
	0Z8wrxYbL+km4JN96o
X-Received: by 2002:a05:7022:6889:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c73e28127mr24549050c88.0.1777251687997;
        Sun, 26 Apr 2026 18:01:27 -0700 (PDT)
X-Received: by 2002:a05:7022:6889:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c73e28127mr24548879c88.0.1777251682930;
        Sun, 26 Apr 2026 18:01:22 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a18a2bsm64223410c88.10.2026.04.26.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 18:01:22 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <quic_ptalari@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: serial: Add compatible for Qualcomm SA8797P SoC
Date: Mon, 27 Apr 2026 09:01:14 +0800
Message-ID: <20260427010114.230341-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAwOCBTYWx0ZWRfX+vTq4ye51f/Q
 4cw3CGbOjv5urgGcIQ4UmYxwsaQ9qe7cvK+onfXCBUHakzsjkvTYxxaiM3LWSaCu+NG73h/Lo2i
 9/+B/wzShlJNz8DYu1nsrnz+yYCCDSWE/WkbUHfu8McEvgnA8Dsjc6GaRS6sAW5Mjdt2Xh9el2A
 750ONUbH60zAHmQaT3Xn9KsdSR34kvLWw4IEhAiQBcMTtnC1RUvQ96XMW4O+FyKOpc9s7ATAWz9
 to+1x4lQC31BtnyTGrIHNUMhOe5sl/xg4X8LYX+MbpoB5d61anOuEAq7YGQlpEeTpnJzQspWc54
 DMB+CyG5bBi453eDZcnkgjDLGvPDUG8w2fWSiKnTrxc/4LNnXMUkuaR/cqjeqSB8OCwRGbdUVV9
 URQwFafmE5OEhWJeE9gdnjNBYlQugsCWWz0YiJq71hBYpy2pW6h/ovVm0PKXu0TBWv1FZo0FQ9E
 uNFVqe7r6EtkkkGt83g==
X-Proofpoint-ORIG-GUID: P_BZ7NtGfCVG14_MEEmR8qgTqskpHp5S
X-Proofpoint-GUID: P_BZ7NtGfCVG14_MEEmR8qgTqskpHp5S
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69eeb569 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xQiCpKoPW3SF3YnsE2AA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270008

From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>

Document QUP GENI UART controller on Qualcomm Nord SA8797P SoC which is
compatible with SA8255P controller.

Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes in v2:
 - Use 'sa8797p' instead of 'nord-auto' in compatibles
 - Update subject and commit log accordingly
 - Link to v1: https://lore.kernel.org/all/20260420060524.1248432-1-shengchao.guo@oss.qualcomm.com/

 .../bindings/serial/qcom,sa8255p-geni-uart.yaml     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
index c8f01923cb25..8496f822dfa5 100644
--- a/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
@@ -14,9 +14,16 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8255p-geni-uart
-      - qcom,sa8255p-geni-debug-uart
+    oneOf:
+      - enum:
+          - qcom,sa8255p-geni-uart
+          - qcom,sa8255p-geni-debug-uart
+      - items:
+          - const: qcom,sa8797p-geni-uart
+          - const: qcom,sa8255p-geni-uart
+      - items:
+          - const: qcom,sa8797p-geni-debug-uart
+          - const: qcom,sa8255p-geni-debug-uart
 
   reg:
     maxItems: 1
-- 
2.43.0

