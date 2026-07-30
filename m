Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF4407CEF;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=none; b=OLASdjydyrdXQV0QN74xhTslzZBZGf5RTnXekr4/1PgsFnIVv6mwL7qE+5qgfvrXiYaOXpEL40AWwzOclfIZfUAxI0jD/a7XFnP/tSieoKztodMDvUSxRZX9EyMa0YytcChNuKjNUOeqybQw5zIs7iWOkgz5jj7Ls63/gvZF7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=0p7ks+j+Mm2RIKbThtGIfAPI35hoL3Xb+WKRpdDFKO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnaRFh/595OJlC5Cekw5Y3lmc45O6a0lKRlLyVv1tge2hb6+u2UUk4UCLWLtG9SQEava9kVJRAF0BOv9zFFdLdahPoif5kPptO18k5K1AlxOal4WR0zSR5IIWZ1DsGs+sjyYLp3iAU321wXbLryqcJ23yu3CBBlUPZpg/OCRcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=ZhVj1/dy; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="ZhVj1/dy"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA4EdG3329173;
	Thu, 30 Jul 2026 10:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=clTDBq8qZkrW9/CEcJ9Y7WMRta02AxesktgnmWtQ8pU=; b=
	ZhVj1/dyUYArHEtIal2eGBYV0HQBVcHVlZFTyjoR9TA/h7t5NFMHIjT6XUpQClFi
	K3BKti1UqdWNlR3tbknWCKM3AQMYGEEsMt2FpMHfedgz9Pyg2pZmZIlxoGvf9pz+
	iGAlirp4+I+DgNl6XG/beYwE+tFKRn3kDsVgMS8OKoRvQigTW4gRXFLXgrHo0rWl
	epYigZFfrerXnKbrOTR++Ppm9DPZLlMlEc8+w3XorkEAgPPduMy8Voq2Y+lzGffo
	0kI1Dylntmr4yg78gd1c2sCSGkYh6ukn5RsiX93cgFbiSjUgNr8BJAQtOefYXEsk
	+vB/pAcJCq42A78YBAWSLA==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:47 +0000 (GMT)
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:46 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-cas3.ambarella.net (10.2.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:44 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:43 +0800
From: Long Zhao <longzhao@ambarella.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>, <linux-gpio@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        Long Zhao
	<longzhao@ambarella.com>
Subject: [PATCH 05/10] dt-bindings: serial: add Ambarella UART
Date: Thu, 30 Jul 2026 18:43:25 +0800
Message-ID: <20260730104330.81367-6-longzhao@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104330.81367-1-longzhao@ambarella.com>
References: <20260730104330.81367-1-longzhao@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: GxdOfglfAGbBOPYYrSb5aY5c-96aeUqe
X-Proofpoint-ORIG-GUID: GxdOfglfAGbBOPYYrSb5aY5c-96aeUqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX/np5wtxWtVjW
 9xvQpPcT8dCPouEjtATAUYW52AUJRPD+Wdke2ruiVuWIxR3wDyU6Mg4lc2fCRRWxao9XGQI5UbC
 6FQ6S2UwLSlt1UDG4AfXYYvS5PEDKLEzN7C+rcRAFe3ndIUFzE/l0wHqQI0KybLs2A9ycUioK4c
 u9OCUXRbSnT6a+Yazqgh76tee+kYrMHUNChZQqbICdV5/QqmdwSHXjvd+yJA71NgKRbBaMUqtid
 2KSH/KnOmewSOhUcXZuxGH5DW2ir0q5cl2iw/ncVCh8+jUfuvDKdV/63tC5YKIhAeD0KGnxAgOk
 D9uuBlaSMANwVvODQX1Uu1BOq0SokzE44gUuS+maBjeBIi2sqmbvUlVmY2BkBdEqC8jlBJdH6Bh
 aZ63FPAIzyNGwUU7pMsKEoR47zzJ7s/4YPZ3oJQeB9OVfN+ElFxsAKt9SBb8xUS1bsDsWrDYSVX
 9VexOGIqeCjdkWMIZ6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX3BnXUuYDkgOB
 U4FHfyrFTATNOQX4931MekxCYRU/6U+wsujKPRpmgww9aR5gRiDuseWMF7tOLX/mfEzRcAa+/lw
 FPgeHBOigKtpjs905quCGrS7z/OcOz27M2hl1IZin8wlHwZWmX9G
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2ae3 cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=gEfo2CItAAAA:8 a=ppJngBeKAAAA:8
 a=Y7lJEgl3tIs_xKLw27oA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Document the Ambarella UART controller.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/serial/ambarella,uart.yaml       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ambarella,uart=
.yaml

diff --git a/Documentation/devicetree/bindings/serial/ambarella,uart.yaml b=
/Documentation/devicetree/bindings/serial/ambarella,uart.yaml
new file mode 100644
index 000000000000..43c98499d99b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ambarella,uart.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ambarella,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella UART
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: ambarella,cv75-uart
+          - const: ambarella,uart
+      - const: ambarella,uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    uart_clk: clock {
+        compatible =3D "fixed-clock";
+        #clock-cells =3D <0>;
+        clock-frequency =3D <24000000>;
+    };
+
+    serial@e4000000 {
+        compatible =3D "ambarella,cv75-uart", "ambarella,uart";
+        reg =3D <0xe4000000 0x1000>;
+        interrupts =3D <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&uart_clk>;
+    };
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
