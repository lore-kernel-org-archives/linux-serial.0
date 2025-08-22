Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEC2EB5D6
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847654; cv=none; b=kynqt5w5NT5Vxbh1Wic5QlLBzD0gN45EOymI5chvMAO+76tYhg6WHoOVM8BSu2THw7oF1XHBLrdQcyrk0dC+l//fuhl+KPH/+DdENJdeYjfcge4jMsAEDd5p9NG8uDsh/08KVC/rcGPtZiWHjXF8SGIcwJsMOY8T0ivC8Fce/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847654; c=relaxed/simple;
	bh=rppZiCFITLnyPFOZCvIesTPpVBituuK5qjfPs6kC+0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFUxMHbLRTV7REc9XqcThpTUWuVbu0f3lDPv9IuikQowWvDNLVd6mLBIOtIkvpyEZauI+ZP1o6VBGdaaJq5CJL1AB1DZ3p7SMclSL4mXATnBXLabuwItpvG1OzoG/roXt5/Bi2RlluJStOsNxD7UP1ASayL/ro64DIAT/rdMsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NRf2XMc+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NRf2XMc+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uu0V004738
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ysz/+Ec5M6J
	isJJhkm9lFFhDe9td6GUmPzcFlWR6xK8=; b=NRf2XMc+zx56s+AnjPt0XY6F37G
	Vjf/7DPFSiDx+BrD0KvcSph4UzlAgAK1FGWVOhx7mhTESVIUNPyHqpy/YiGlH3g1
	byRTCOWlOPxKGTCpCU666d2S97nY912g0jdqtd/tb9rc047271jdoXd+FQQMj18R
	CGOjVhzJyl4F4U1rxRUoz0kKXzl8+jTrwUB9MUvwrPrdjgYmOUPQiREB2Ai0I75s
	qSwaFi4UXgqVBvOpbRu0g0IHcLhVIpxRIpl09o4RISyPwSiuR9bpj9U56BXHXvhS
	RPOUQb7R+2+Ji7Y1FUQPqXCSCwxX2NhP+dNG0FtVjUVrdJ7bvypZyJU6J5Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52986d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e62284dso3761566b3a.0
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 00:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847650; x=1756452450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysz/+Ec5M6JisJJhkm9lFFhDe9td6GUmPzcFlWR6xK8=;
        b=B4K/3cSPR7GXlefaV0UWh7w+Cx0bqs6Ws4iYVvVicc0KlHKSBudPrXrHdnDghy5q8P
         DmDtOqSZBAfzrBd4vs44Rg5d5ynrq3S1cI++vycbwxvjHxlgNY2ljRWR9Eh6srEagBkH
         CUorypt+e4T8l7fTz8knuF3SvaWaVgIVQe7lnbKEpNfrFdtmvOjtgtcdae7RJSS6Fvao
         qbjl7WZ8kYLoX+e+VzJ7MDI2cJ/8adj37zr7spAPQpVt/bIRkkUJh1jInjKKDSReBG0q
         c/L9/EvNJGnFkHG91tswfwj06phl2L3DODVWnWPBs1PNRvQkOJPGWy5elEOIoq+lRyxj
         1hwg==
X-Forwarded-Encrypted: i=1; AJvYcCV099XHApVE+cL2RdpO0jP5vKJSYQaHJUxAiMQujlcbX8SGEcU2d0RERkOtYSapo+hyF89dC2j1qwUcFLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5nHbGewp9ymB0oaJZ+0lbrXMWOX//+yZQKIk3VlkzzBH8Fu/
	A/H7a02sYOW60p5eMeyJDpiKalBEDAsehuROsVrS4ee9hZvHxc7y2ebaqH7aKvoIiskNaGShgO1
	liRoBIJ8AhHz8oekhUwSvGC7/XOWsXnLTx7jKq20/VtgSxUFAq5UmDXuH7X67RlCLl+k=
X-Gm-Gg: ASbGnctnfJZxsT0PrhHQy4jKk1u4TrBK6XKnIAHZuBZAOWB+A/63MzYHFFAwxu108nW
	8QEBd+Vzrvi0P1vyy5KPwh0uh0kl1nC6EhILkuOw7pbfZ5O5wKr8bofjvzVTBwbp5OfZqR0HKmY
	Xiaqh4Vn6sQJVAhZ2XMCPhQrmzOSdM5V8UfnMbsCqdLwfpIp+8KaJwHMVwlUNq34Tt1D0bZd7Wc
	/6r/zNJxxYCvnsmspVioKABs7DMjUq7SRpisejbqk5KPOsvzMXjEzrdhV25JsjfTaI6vS2ktyyL
	6+wzK26bbgZ9RnOa9aKsZLIp4z0oeFgNK2kmIOtNHzGzhtVtxHasMtHDbNaO2ZfZsp4PQDdUzGA
	t
X-Received: by 2002:a05:6a20:244e:b0:233:f0c6:a8a4 with SMTP id adf61e73a8af0-24340cd2b35mr2920535637.31.1755847650480;
        Fri, 22 Aug 2025 00:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvoBlvqz1y5FRUG9Fc+luKJehc/ngc3SL+gHN/WY9zmSPlzuzof+f2xGAbzxY9Fav9WvGPcQ==
X-Received: by 2002:a05:6a20:244e:b0:233:f0c6:a8a4 with SMTP id adf61e73a8af0-24340cd2b35mr2920494637.31.1755847650029;
        Fri, 22 Aug 2025 00:27:30 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:29 -0700 (PDT)
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
Subject: [PATCH v6 5/6] spi: geni-qcom: Load spi qup Firmware from linux side
Date: Fri, 22 Aug 2025 12:56:50 +0530
Message-Id: <20250822072651.510027-6-viken.dadhaniya@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a81be3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=zIdmu9zckVospZd7ahEA:9 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cpV8s-c7HK9cw6QXqZ5KD8PtykzuAqkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/yTm2OO7iqCu
 aAA5rNoS4aRQKTGR6xgeMM1F0HmUj4Ko8Ukw04YTaGzsN0HLCZhcc2o4mX86ZVDxLBW7jNRTXWK
 XKbMQ9eqiba0swNHcvroOopEU/dyqVUzt1iO0a/cEfjcEl3Bv+DhGVu448Qqhq6h10k9I4j9nuB
 8eXWq+melH+zNwXN1dHsgWMeN4bmBKNJTwW2fxQQ0DIi6PMQ7cC27aNxcBOPQVX7RMKSSmFj5Ue
 ZJryXeNb4qJMWVKujilzsV4/15RN+MWtv0qFA94g89aIZndQV9pFMft0rkn7mPXobJ/0GWEqy51
 hOg3Uh2Ym9xY+ZihUyK9b3ZUUW9p5XLhH/FEciJTNdxsKm5ThQbOJ6UtLAT0WBI7uGgixds2Pc3
 LBv0cfgVX1wOY5k21soPqt49SL5RvA==
X-Proofpoint-GUID: cpV8s-c7HK9cw6QXqZ5KD8PtykzuAqkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

Add provision to load firmware of Serial engine for SPI protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-5-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-5-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-9-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-8-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-7-quic_vdadhani@quicinc.com/
---
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 768d7482102a..a0d8d3425c6c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -671,6 +671,12 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			goto out_pm;
 		}
 		spi_slv_setup(mas);
+	} else if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(se, GENI_SE_SPI);
+		if (ret) {
+			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
+			goto out_pm;
+		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
 		goto out_pm;
-- 
2.34.1

