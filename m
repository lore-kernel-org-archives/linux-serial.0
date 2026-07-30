Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AB40B100;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409594; cv=none; b=E7K96HE9zom4havGlTfykbsREys8+XQ/Id41pnyBOf40O3QyQ42ywHBZG1neam826sXOKbz6TtLu2wxwniTurXd2quPSIw0hr5xWtkUIz0oXcwqrrt/GcsMMONeYrpKUA+wvXnecUV2sZOj2lZuK4bcChXY/wIUQcV9vrbJeXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409594; c=relaxed/simple;
	bh=wxo+wEhTv2IAYfktngquPtze0J4jYp5Iv09zO3fi2lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldVr7GNIG9BAoRQxeQIzqOZy8+eCnclx4eQayEC7OCMjnG3duEipkeh6kJVREw8ZMdWK37nCEbL8TbJe4whXvLVzLcb60Kvxuow7rlBQHLK2/xc/060IzVps30NF1CrwOOGIxCjbfToOzU6Ps46sRjp4RRDPExkySFaZj9YSfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=W9Qlskbn; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="W9Qlskbn"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA6Egj3332841;
	Thu, 30 Jul 2026 10:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=3FjhVKwJ1XMv+MKR1tO/UwEroy8aNNlMHT7UD5upsSE=; b=
	W9QlskbnjmMJO2H76xiu4r0bXDM/adNhCBwmVbNDEAtL4n5O6eYPuyKkaGsVJR50
	WkIVUzgrLMuPtwW2fMbM17APIzfjzeORSmNTeLMVTUUEKz/jnmtg1BxM8mNHVdrR
	PktAjKOJGxqCsthrQ3RYY0jihpZl5lhQLOHNmoFFlOcjpCzi1avzAru9i6kmMDhb
	iE+PCHA6UmZch/nbu2GKAejRa8rMISSlk+vimDm1VkFCW1SPU7UvRQussFDTwfLp
	1IjCdD4iKrv9QYYYDUBq5/rc2sBpCR+jlI4g/BvtesIMUtB5bHvU2AkWYLvuCmro
	VMt4SPIt1cpxK6Q+ZJ1xUg==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:44 +0000 (GMT)
Received: from ambtw-cas2.ambarella.net (10.2.4.227) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:42 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-cas2.ambarella.net (10.2.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 30 Jul 2026 18:43:41 +0800
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:39 +0800
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
Subject: [PATCH 03/10] dt-bindings: clock: add Ambarella CV75 RCT clock controller
Date: Thu, 30 Jul 2026 18:43:23 +0800
Message-ID: <20260730104330.81367-4-longzhao@ambarella.com>
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
X-Proofpoint-GUID: v5OtzRC0y0EF7qlAgSF6BzZa8N8WIv51
X-Proofpoint-ORIG-GUID: v5OtzRC0y0EF7qlAgSF6BzZa8N8WIv51
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX+e/w4Tt7Dgx2
 KVVn/3u0CfLRWnWSv7Bh6QOtUo01zphnrO92z4CU86BhGXwK9U+Us7QHyMD0Gpyz/DaCo6e0j0H
 kWFYr5+RmIoE7sQZkBTDzA1xIcE4FPiXc/PtcfIrOaMdmC7qIhmi+bnxIzR6KU6PgOkmOPfTvff
 CBSqlmYpKpQINyEeeKOeOCVX5vM6pg4lP1e9YmOubLXzJkhw3txc1s79ccXZIVWALIc7Ysy8ni9
 2Xsh3M/Xwm5B1ewKSSG1wgl8d5QCqjH1ODYFlMI5Arbk2E/m+LxljavYh+V2Y4t6vaN74/43pFo
 vcDxtNoF2oeDloDXtjhVgwwIGq3yWlVbZWtWlyPoUkAj4xy5csok17ADZVP2+r5M1MOF+t8Icv1
 QfgBD7DSPcsabrfQ2UxNjkfC9mKFVIhGa5+i6FEJUtlbrxwak5aI6r6kQrsgKlbkFHzgZWoDuag
 3vkB4QGwiK+wzTqxjcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX2ofOcpAFCXOJ
 MxcXM34eyHhbtsHz8cKzqEh/aMPRWq2deLQm+UKf8hvEeCXlwp/UiReNAQbAY5wbaA+eb7OhgQp
 UNJvRTB5n160Gb+xLNwXzmoLXBirvhsgStQnaWRqHo5GqE65dcDd
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2ae0 cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=gEfo2CItAAAA:8 a=ppJngBeKAAAA:8
 a=W2yGB2T19Uwhg7ofRhQA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Add the CV75 RCT clock controller binding and clock ID header.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../bindings/clock/ambarella,cv75-rct.yaml    | 94 +++++++++++++++++++
 .../dt-bindings/clock/ambarella,cv75-clock.h  | 17 ++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ambarella,cv75-=
rct.yaml
 create mode 100644 include/dt-bindings/clock/ambarella,cv75-clock.h

diff --git a/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yam=
l b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
new file mode 100644
index 000000000000..5ff5b6a4a0b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ambarella,cv75-rct.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ambarella,cv75-rct.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella CV75 RCT Clock Controller
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+description: |
+  The RCT (Reset and Clock Tree) block on the Ambarella CV75 SoC provides
+  PLLs, clock muxes and dividers for on-chip peripherals.
+
+  The same register region is also exposed as a syscon for other drivers
+  (e.g. pin drive-strength), hence the "syscon" compatible.
+
+  Clock indices are defined in
+  include/dt-bindings/clock/ambarella,cv75-clock.h:
+
+  - CV75_GCLK_UART0: UART0 mux/div clock
+  - CV75_GCLK_CORE: Core PLL (gclk_core)
+  - CV75_GCLK_AHB: AHB bus clock (core / 2)
+  - CV75_GCLK_APB: APB bus clock (core / 4)
+
+allOf:
+  - $ref: /schemas/mfd/syscon-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^clock-controller(@.*)?$"
+
+  compatible:
+    items:
+      - const: ambarella,cv75-rct
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: Reference crystal oscillator (typically 24 MHz)
+    maxItems: 1
+
+  clock-names:
+    const: osc
+
+  "#clock-cells":
+    const: 1
+
+  assigned-clocks: true
+
+  assigned-clock-parents: true
+
+  assigned-clock-rates: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ambarella,cv75-clock.h>
+
+    / {
+        compatible =3D "ambarella,cv75-evk", "ambarella,cv75";
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        osc: oscillator {
+            compatible =3D "fixed-clock";
+            #clock-cells =3D <0>;
+            clock-output-names =3D "osc";
+            clock-frequency =3D <24000000>;
+        };
+
+        rct: clock-controller@ed080000 {
+            compatible =3D "ambarella,cv75-rct", "syscon";
+            reg =3D <0xff 0xed080000 0x0 0x1000>;
+            clocks =3D <&osc>;
+            clock-names =3D "osc";
+            #clock-cells =3D <1>;
+
+            assigned-clocks =3D <&rct CV75_GCLK_UART0>;
+            assigned-clock-parents =3D <&osc>;
+            assigned-clock-rates =3D <24000000>;
+        };
+    };
diff --git a/include/dt-bindings/clock/ambarella,cv75-clock.h b/include/dt-=
bindings/clock/ambarella,cv75-clock.h
new file mode 100644
index 000000000000..3d3314446e75
--- /dev/null
+++ b/include/dt-bindings/clock/ambarella,cv75-clock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2026 Ambarella, Inc.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
+#define _DT_BINDINGS_CLOCK_AMBARELLA_CV75_CLOCK_H
+
+/* Boot / bus clocks */
+#define CV75_GCLK_UART0                0
+#define CV75_GCLK_CORE         1
+#define CV75_GCLK_AHB          2
+#define CV75_GCLK_APB          3
+
+#define CV75_CLK_NUM           4
+
+#endif
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
