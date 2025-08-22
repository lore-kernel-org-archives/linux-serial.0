Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95C2E9EB8
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847632; cv=none; b=FlRkfgvTGvlr4r8aP858qTNhZPcDCeLS0EzW1VX8ve7peAeBbHQoZEJ6Hl3YY1xzNarVL6+E8xkqtiIVhB/mIXdwRaJbIX0SvR9m+AtzXllJ90u/TtE+xVfYnzwauMZlGlerd2zAzFfB0+D81OWnR2DZQtnvw504cP9Ga2y2BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847632; c=relaxed/simple;
	bh=CLvam64GpjkvK9z9EBex7fnXV+Xe1Yh5pbFJp8bR21M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzDgbKwN6n/ZwJqVE32x1Up0tC0v/onCLGisv/GGUALvfqSepGD8nRPEUHV8YIN0uWWPU+330PnfUYLtM6x4xDXkzpt8B5Rk12UgEeV8EmZq/YKHnjiC3PqQToByqYfGunUmFxjKR0ozaOzWZe6auFDGEoQCnZihWKnNzFPU7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VrxRkAjY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrxRkAjY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uXe4027807
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CgYC/weqOyG
	d9M8cE9Fo8jaIsPKmSKrevJQt6OIFqZ8=; b=VrxRkAjYRFYtY1uJpVxGFOCV4i3
	Nf6fA4M3nksP5zGbPWmdbOLJ2Kj0EpKReni8pCtQCVnvyKxOj0OwBf3Paqw/6ovm
	XykPBouT9fRPG6nMwYgxFWdP9UhngEyVN/A6jbX7ltVZlruMGpLl+qlhi4rm5RZg
	U7/EYU9qmTPCSi0RNsRMD+Vh7ECVd5KcbfQjmS15uNW07d7SyBHLJQ0hg5LXHpRK
	AmlVSDjMGcv7vJ1CR7TqZHFYVv8DDoaP6A6Bb2Gbefyg5JxDRpu45bIYOVrXdSqG
	9Bv9Y950SzIhVuMf1ZEA/Ttc7emwUnmaWtyWYEBgfP7hhRDqmw61nwhg/Kw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cr7q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 07:27:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e46a20so3212281a91.3
        for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847628; x=1756452428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgYC/weqOyGd9M8cE9Fo8jaIsPKmSKrevJQt6OIFqZ8=;
        b=rMXdh6dGqjPkM9KRDE0fZ7UtjOUUcb6JaJwFTnC9Kt06PypWqnFPLaJCSjKV/ySBFW
         EewQ2YpGAFJi6J6kaa4Ce2I8niF8xZx+5LyQ1S2yfXAqvQxF7+AM7LulTYjoNlJo+B9V
         k7rl3qjfickeh4I3qyhZ/o/N/f8zvIpTap66yuv8x30qwtP5ClUXJyieGJZnT/ZU4uxc
         +lm3PaXHypW6NDCsoSqD9lDo+DW7btj6e4xYD2d5iGOtKHL0jtBAW1V5QCMchGZdFOqo
         ayzwemGWGsjlOpvtNdU8aaSANsLuec5jsLzDuJgdFLVmobZaUoanaymRsnvJ9xFKC0y2
         n+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWGyBkLwv23nVbFOcobNq4k3ZZB7EcI3azwxPjlbp72YXWhUVySzC+rp7AOCuo9GwHhVfX9m4q0gQ2JTlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgDO2Uzd8n+SctvbjNk0NQc+wSAsh8LnBWOh6hK4Xwjr2wT+r
	y5rw67nZQFaUFCwYlBZUdZITj+bpiRNFud1JJEpVwnPsvY1xkjhe0ITnbnpfZhs68wBzPQEamr8
	scB2Z1YEMzQ8mKEilWcBev3164ighnJcm4odYJk6sNhEXPkRzIhFwyXJeXDmFVc/WPcU=
X-Gm-Gg: ASbGncuqCzCttHwFgFunZJgsapj3IC2CdZhihfkzZSdk0Sl7AHwteNkPtisZp+uFh8x
	ZlnrIsjSbVlRDxojr2AmcJCjkMsKUFoET44XM6i8RXWQhkBsynKYMekP4pUWeOuxOl6KxhX6gfe
	DNw5nUi44dGphiwWZk0yoE+kAh8WwSxSVJ1FQapMl7ZluqK4cCROOMgWhQDR5+BebqSv50RE/C4
	Umc/gxYNqmHilyOf3xeJM3gSohYARcoH6CbCsYD5f2SWcWep+TPTYNo8P8Q0o8cCBnEwhcmNlge
	asDhXJQM9u0/tA0m+P6nyLxujnu0hLdDu5xeoQS8nWaeOoODYV+sTVTKPUV6yB4uRLCvrd/H2L2
	e
X-Received: by 2002:a17:90b:3b8d:b0:321:c4f9:e5b5 with SMTP id 98e67ed59e1d1-32515eda512mr2721220a91.28.1755847627839;
        Fri, 22 Aug 2025 00:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPXSm6bqwkB+lq/+CeeHKNmwDCs1TpmePhgenu74kzGX2ngcV6qC7lpHpf4+TyFgCMwrYB2w==
X-Received: by 2002:a17:90b:3b8d:b0:321:c4f9:e5b5 with SMTP id 98e67ed59e1d1-32515eda512mr2721181a91.28.1755847627235;
        Fri, 22 Aug 2025 00:27:07 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:06 -0700 (PDT)
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
Subject: [PATCH v6 1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
Date: Fri, 22 Aug 2025 12:56:46 +0530
Message-Id: <20250822072651.510027-2-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1p9U685Tij5VRI6zHE62N_A2szo1uVza
X-Proofpoint-ORIG-GUID: 1p9U685Tij5VRI6zHE62N_A2szo1uVza
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a81bcc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=M1Du_JTgEIh7wHf307cA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXweCHoqPBc/4O
 L+7Yloezq7dcS1s5fKmnZrKppBy8Qbyoo8w7kiuYn2BmiF3LlwUeBmNOucnHdFP1cS7dTf/IFlc
 BtCGaJC2hyyh3uzRNdT9M4nASr5714ehUtQ7Z6cHOiB9H3Z+cGJzPHqxZ85WpLIcfC8Ut8KA0aE
 mRUWyXuyE6ZJfo9Y+2AQTuw5kolsdRZRbpafJ9hrwALZTpUpY9CQFWk+1aBtQ29kI4EEnPKDh8Z
 rc1FZShB+Nwqm1vZwbSjzj3Rtx9N2iTVWr/12X+x5jfS6jtnUypd32Vnzc9R5ckzUOhLhHPROzQ
 nA28LXeOGF1lZutZnr+5OSefZlxM3OOX8Ha8FtiQOLYRlmkpLJjJMlBpATmkUdSTmHNsnhvde0w
 twXTv9sXItiV7KRSye0WwAMbP0+SQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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

