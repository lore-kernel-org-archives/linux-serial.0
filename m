Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3061E1E04
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565197; cv=none; b=GYhw6b1dWMqq5G1AgZNXnoFb9GYqkcV904ekZxNuJxLVDF1HI8fg9R1YDY2MzWFQhQ9bxrhc/9BK/lAhsFzRVy/yrtfCGwD3DHuC3vzXVzaZQzcpiYU1q1MCvtTQgs/nHb+GywDq/Y0vOniPBWuvYB1igYcjGiY9RsI1yMqOoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565197; c=relaxed/simple;
	bh=u7L/ieaGhg4FYoxkoZgFlr/WX/CxQuv2qx3g+1jNhws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GI4EWbYyaPjzVjKeoQC5NcQAnmv+QZ2keC1E2G9lmO/9CnnFe5eRsXl1iHiIzqR78YglOhSs6K5ZjarUlbwAE6Q0qYRsy9T0Pa1S3IVbdrJtr70eZxOBJ13qcko1GwUNX/BlGbj9BHASCADXJjo2FYg1PhOXbJvku1dH2ewTdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TG60qSEf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TG60qSEf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2In1Q027092
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DURBzBBWh6H
	a/g16FF3Bk+BqdvbZOIe8eGRq/1RrkqA=; b=TG60qSEfMGTnbcblhWQlKtVl3w2
	Zt863BcUs6nCudlRypR73atLy36H3MyvP56cOJDC+pO0cICzA1g7yI53aKhpM7JP
	gW0D1ijnB3zyXYMgcxqhVH6vq9ER+ez5uqvS6xPGLtR/+LWvLRYA32SiXS21ds3C
	06Ua0T1G1vmkVEYc6e0snyZ3SVi++9rFquwPMuknPD9Laj+l0SPjtzfK4jgRXpAQ
	wCPjrhL3X7/PrbnoB2VwaeU00y1dF1f5I0RYNcOOA3MFX8Fa9MzVHhgql0dPkgpL
	3KT9KQjX1Y1dsngulspklBL5q6Mr2n08HjEXeqmOxX5YViFx4fjgrFEnsGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493f6h17xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so275347a12.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 21:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565194; x=1758169994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DURBzBBWh6Ha/g16FF3Bk+BqdvbZOIe8eGRq/1RrkqA=;
        b=pAtn8r0I6znuewtXJW86iDMpo2eFmwEDwOmrvq3QlvjVS2bzE0nlqNPQUfEC5hw62B
         REp1Th8BgBfjSZzAvTzkNTYT3VFKhM4i9i7t1fxvFJEaPi9TJRptR4hRkkWIWJPZtpDF
         LHqs7W4/70rvROtbyIMx5G38xH6SgrJ0GCJfMp0oZ4mK5DE0pcu5SNud9d70hYYmxRW/
         nal6NN+T8ryaKgTMsi/jJbJCW2wHmY/R0sKeFfzlembT49vyTcxJiKznt4qVYZJlbTBW
         Sd+ny57QnrKPWRVguYKsR+fj25iFz+w0eIWgbV75cTSxHCgPncv0i6m+5OZ+Gn2+ZXny
         omWA==
X-Forwarded-Encrypted: i=1; AJvYcCXmLwaI6IFWM3HD4HeGRBnE1W2a/yM3kPohC6RgW2hdiA3cVqytxySUnb2958MsOM0yoPDo+PIq5NClGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4m2u17Vvm2DQkCclUk8r4bslQ4klqkzL1lzR2iOwwR/gmt3g
	xVcm+jWzGzBC21gzETzHtgm548Y8VKW8XF0YmjdIu5L96/HxIovMqbW4aKke4VWg1+6bivd/6GE
	kr9AuBHs6nYCNC6/+btPP0OZq3GqVpd216ZJjsSLQqEIFh4ro3Cc9+9b1SWFmQVMMZSM=
X-Gm-Gg: ASbGnctPDekCd//zIdqGbMAJjbROc0mwfw6F5AxLhGzsE2odKKE8d/ktJYi3uxRjaDI
	c//QT43Reoj1j5lXbrcB9LLlgU3Xib97yjESXvGfe4I1HhWgFMKc3IX5E+R7fpkEEkVuNG8/oBj
	NRZRWyvN4GYGXHXBiNYZbcpW+c/Fj/qxkJsdmGfHeBdjpagB5dmA9uUDgIO4ifz3LHzwNXHbssC
	4PjeqHpbsnYv2Ql76YqMuwCjZnHgvO6uGI1Q/OPKwCaJuM9o1+bJhsPnepPc4aBV0qST51V2yvs
	AAX1NsI+n10yXStnW8FqXRGx5JgldeJgH3Cvvewt+SnXR3smPn67PuEveZ3Ad3d4TD53PVF5Ifh
	o
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id d9443c01a7336-2516fbdd4c2mr215944575ad.20.1757565193997;
        Wed, 10 Sep 2025 21:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtCrX3AKAjoCMmmGRU8ktHUd/jdfd6KhBt3qxvC7mXIES1EQNisq1Z7vaS59E64uyx449xpA==
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id d9443c01a7336-2516fbdd4c2mr215944275ad.20.1757565193511;
        Wed, 10 Sep 2025 21:33:13 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:13 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
Date: Thu, 11 Sep 2025 10:02:51 +0530
Message-Id: <20250911043256.3523057-2-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pZR39_5RJtCdrf4WIHLZNZ6e-pKVe1lo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDE3NyBTYWx0ZWRfX4Mhe5oeyIgye
 vobUtBHwzdwmDGkejZH5OKesXxQuXwF9P+jvlsGycd005GYed5MJRtb5e882qwYhIWVXgbMHVHh
 roqByOQ6rZAUZ1ERP0YBnlImsZiqEkskDQNxhc0gO7GaS/9MIHPT5on3NPwTXKJya9Heo7SHtzM
 9gNjaeVe5/2uJooqHL40+K7kHzh7DQ7VcWgoqG0VbJyXafG21c/d0XNr1MlG+MrDRP/xRP/qBT/
 QQivOqpsX3pgQd7hMdI1RjXvW30EhFatuSGt5m79YYndoK6B+XsuTx+Nfgtwv+Cx7+CZEL/rUyK
 UY+ijp7Z/jq3oEilmep7nWhwP74Q+9CpNBWHjRJEtOQUBN3ehpEXKgudX3zcGUQEehWIE+oQ9ha
 0R218IZi
X-Authority-Analysis: v=2.4 cv=WPB/XmsR c=1 sm=1 tr=0 ts=68c2510b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M1Du_JTgEIh7wHf307cA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pZR39_5RJtCdrf4WIHLZNZ6e-pKVe1lo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100177

Introduce a new YAML schema for QUP-supported peripherals. Define common
properties used across QUP-supported peripherals.

Add property `qcom,enable-gsi-dma` to configure the Serial Engine (SE) for
QCOM GPI DMA mode.

Reference the common schema YAML in the GENI I2C, SPI, and SERIAL YAML
files.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-2-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-2-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Add Reviewed-by tag.
- Update the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-2-quic_vdadhani@quicinc.com/

v3 -> v4:

- Update qcom,gsi-dma-allowed property name to qcom,enable-gsi-dma.
- Remove full stop form title.
- Add reference of common schema YAML in the I2C, SPI, and SERIAL YAML files.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-3-quic_vdadhani@quicinc.com/
---
---
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |  1 +
 .../serial/qcom,serial-geni-qcom.yaml         |  1 +
 .../soc/qcom/qcom,se-common-props.yaml        | 26 +++++++++++++++++++
 .../bindings/spi/qcom,spi-geni-qcom.yaml      |  1 +
 4 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 9f66a3bb1f80..51534953a69c 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -75,6 +75,7 @@ required:
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
index dd33794b3534..ed7b3909d87d 100644
--- a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
@@ -12,6 +12,7 @@ maintainers:
 
 allOf:
   - $ref: /schemas/serial/serial.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml
new file mode 100644
index 000000000000..6a34f05a07e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,se-common-props.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,se-common-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QUP Peripheral-specific properties for I2C, SPI and SERIAL bus
+
+description:
+  The Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) is
+  a programmable module that supports a wide range of serial interfaces
+  such as UART, SPI, I2C, I3C, etc. This defines the common properties used
+  across QUP-supported peripherals.
+
+maintainers:
+  - Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
+  - Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
+
+properties:
+  qcom,enable-gsi-dma:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Configure the Serial Engine (SE) to transfer data in QCOM GPI DMA mode.
+      By default, FIFO mode (PIO/CPU DMA) will be selected.
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..d12c5a060ed0 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -25,6 +25,7 @@ description:
 
 allOf:
   - $ref: /schemas/spi/spi-controller.yaml#
+  - $ref: /schemas/soc/qcom/qcom,se-common-props.yaml#
 
 properties:
   compatible:
-- 
2.34.1

