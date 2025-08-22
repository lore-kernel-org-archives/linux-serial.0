Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CD2E9EC9
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847649; cv=none; b=TlUFNQMVAD9KIKxVBnB2QS5qJ4acikaNzbtYl3hNVMfNXdU1zVvaYHZOgBq6ml9PyvmANEOGtSzdCkl85fqkG8BgwcIOG8/Ya/TZskf6lr87BMJhdQEpwziewllvvbBLH5tLhzmwqYBcGMaqOiSa40SFb8GF+DWwaeKhnJmSK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847649; c=relaxed/simple;
	bh=2PNVuXq+ZYwaLuZ7rUo4rH3IJfNSTpQ7FJZqxFzNtv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQkW0sFVTqkNQ67XExRdJW7bj01HW7XmBzWKTWiNKYccIXAWL4V0T/L9xUdMTKPulPUCK15+MyAgafd3iu6clLhFpHiHyk0j0uDnwCJVOgXrrorUBVx+5sODlDXWuQ2k06XrJ/QCzu/4ygtZIvz9C6AC9mWE6yEggSUaXsq8wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YXeN0NDY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXeN0NDY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uRBU005990
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BrYCSYr4l+R
	GAx5Rr4vA8mbuZgqIc3xnPF8sQ/ZYbOc=; b=YXeN0NDY23TjYc6Osb4Xc1Snjgy
	cWTy4GYkEnPkHjchJKge2Sz0jG7nTeCOy70pMQrr9Xp5ngFMyoTOKKEqpNFMLrWU
	+Hh7gzzMZ1JJxEgsxzwyARvkSxpcb7Equ5PZUGYGhFJigEh9BKK+JNdbhG8GIFWd
	2LySOA+KYlrqq1aO3SUb+I3Nu8FsuB1BKSAi5+ZW+w1Y9G6Xcuu8kM+uFkbX0lQJ
	cqPRABd+ES97dCcMVTESy3/V5JtLtXUPI01lwRclIX/pxN2Ooe+SeryRSO+sVYI4
	oZg40WJ87TbQNk12k/FDljGYu1Kbx6b6dfXpmhsaULWMzyJS+K3AquXllGQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52dr4u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e8ae86ab3so2052997b3a.1
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 00:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847645; x=1756452445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrYCSYr4l+RGAx5Rr4vA8mbuZgqIc3xnPF8sQ/ZYbOc=;
        b=j9LqmCsx52kENhCV7sv2V/pefn2wI6n6qdKmaTOg/HMR9CGQvFnuo8DctE4Tlbm/37
         1h4lx9zzKeEygLR21x+1TXcEq1Uso4SIOXJLHCpXRrP3AMp+vsgJdGxWBzBzJyoyARWJ
         zCpv6/y+iOq3r+xj/+92ufiFgrNKdLO7FFJl4wtzHh/bqKMqzKmqobVyBkad4X0jlRPF
         BuOBb5/VhMntShODqlNzDRSebfBJZZ2D/nRYZvzmabBhKe52jO/+5tjxVH6H32s4jR3f
         kYZuxSqsePx8HIKivNcd++H9s6ia+JH8KFIz6SDCzCJhFK7ExscTVuC3vIQZJRs/8BgA
         bLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXhzs1OtPKTv+J8wMi73CnNAga1giOF9tC1pXakB60xS0jXfK0iDpXRmRXbQMBHYmzofgQGrUUPVNYo0Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUULoVVij6oBnu+SjPDBHhzzfT7qqPB75toHMZTQijknEzY5d8
	iEntTANaFPgkbhd1pFCjHIdoS0zC0gY5KeOiehrqcS8V31GEkyNHkAqKO97pyE2tlNQMK71qDR5
	C75Ajfd4nKQ74Qed1kwBWpOCNLsdwKmkF935ab7RMZPftBLk2MjmxHtGV5BcClLuc2t6vc7fPay
	g=
X-Gm-Gg: ASbGncu0gUwd9mESeAtRkdCv7t6mZIY0W6tdasCnnwJoFRmUq9SKhaNJz5D6vCGX+OG
	9diCUCxw+EgMThWZfYC/F5ec46oMq00HM6clMvzwpv643uork7yZ8UNgFZKk8vtqmAt91yNnANG
	E5MBV4iYZ5EJMIPkDnubKgoYfmmd/7MMezEF0sVa1SgEvOlMpi+mag4DWNiqsRyvaQGM7cCD6o6
	EhXzSTzvqSW/UmRuCO5xjYgNqSzNAa2qqMT/O++Wytcj5daT3+uBCRCzqMwrLwEy0KX6Nl+4TNT
	xM1toO788eDtumxRDIjVrIUj7XzJWJ1CNB7MttArtc8sAd3/noggqp9jOiwVO1qcqnVjHds5GKV
	E
X-Received: by 2002:a05:6a20:6a06:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-24340b7c7dbmr2399223637.9.1755847644795;
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGueuQAtbJyunfN/7SGGX9fsHuG9nFd0VIDf06IMkL0qz8ftPZLBXEwTTKRWnxH8rIeBR3Ihw==
X-Received: by 2002:a05:6a20:6a06:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-24340b7c7dbmr2399187637.9.1755847644346;
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:24 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
Date: Fri, 22 Aug 2025 12:56:49 +0530
Message-Id: <20250822072651.510027-5-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX22GSB9UVLMBp
 oaVN6p3PIlWMNZZp88SabQlPhfB+rBpMcpF1JESTemY7XBq9edP1DqNh7Ushnk37MwWS+wLnSeH
 6CNWJqNMwgbIy5T3BMTd1+RX94dXW7U4nXETawGR+OdIPpYoOTEQTC+BLvH6HII5Q8nQp7rz0sf
 TidEX17YG5LrPcxnCa4PxUEzjcPjO/MNSA7YD9kMN1iolw/TZwZRE/lInAoWxUIgoFhXuN+8LzN
 3Gfj/NatLQ0nwNc+EIoDs+/stWy+I+T49uj4Spl/9BvSOvVGQSLwzaolahht3dDBa/b17TavH0P
 pKMweIDACYrnMaHuqacdCztj49D9fnc1BvgRp2YdUEe81sVcYdk5LzhZfYlBqUcv5Bt/VHUUthD
 kPRYM0sniTzpnUFUHUJUh7aRq0lsbg==
X-Proofpoint-ORIG-GUID: Tr0MqdZXI8nyEBBZNmx9yDsj6DZyatT7
X-Proofpoint-GUID: Tr0MqdZXI8nyEBBZNmx9yDsj6DZyatT7
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a81bde cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add provision to load firmware of Serial engine for I2C protocol from
Linux Execution Environment on running on APPS processor.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v5 -> v6:

- Added Acked-by tag.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-4-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-4-quic_vdadhani@quicinc.com/

v3 - >v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-8-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-7-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-6-quic_vdadhani@quicinc.com/
---
---
 drivers/i2c/busses/i2c-qcom-geni.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ff2289b52c84..95a577764d5c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -870,7 +870,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 	proto = geni_se_read_proto(&gi2c->se);
-	if (proto != GENI_SE_I2C) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
+		if (ret) {
+			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
+			goto err_resources;
+		}
+	} else if (proto != GENI_SE_I2C) {
 		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
 		goto err_resources;
 	}
-- 
2.34.1

