Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C440B101;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409597; cv=none; b=Pi+ZTQBpHFIVxUoQBdRSP8MCbqYtBi7eSi4hvtCVyI5RzsFgQm66GBRgTNSJmY90QfWNZdscxWcOcVvcQZhv1MJgaq/tl4h2iSWiP+geQRg7Rip3W6jjy2b1MuI+dHfafeDmavSrwCEI1SV5gvUozTTEfpqhD0LtME1TthDoHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409597; c=relaxed/simple;
	bh=eLr0Vn/2I92CrX34zOLYRe654PX+PK/WtYF4C31qxvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyXabgD3JSvxGQma66Bs4jmSpx5z9EQ8z7H5SvftYiVGN6okB0XLa1tzc6Eqrh+68y+OSOgY13zWvzwmmOsog/BgcIQEh/Vw9gvawnIXVTMSN9hiJaGHwuG/gLm/MmGo8P6CIPORkUyhVxK+05Thcoxx4KaA4AVhRNTbYL5S1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=rnqAndxD; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="rnqAndxD"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA3stV3328748;
	Thu, 30 Jul 2026 10:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=Tm29WJHDkZypVhkqe1yczWklrS1QFhNg/PGuTL7KiLY=; b=
	rnqAndxDKw24dSMgEbF/RzY0bG+gjl0Jf/CiU4dflvhRr55LYwyr+qn4Fjb8Quxt
	hdSaMFkE+y9qMkB8V9PQTVVYVxAdHbspftXM4EO8a26uX7WGbfPR8I5t4UwjAvzf
	zf3zjXMpkPBE1p6twpaeOAX0ejildU9MGeDznaHGQjzF4+lgdpE6rhdzDjdaURWl
	Ej5XUd1x02VA8ESlybBs9vX00xebOn/PiJTO7Amq55qD8Ca7yWshzPfidX2XbdUD
	mjOG62+YcbN1tWfqEtvZLH0u+RQkuNAf0xjvYFNZWUa0JyWSDUDiWq34vJViVekH
	CU3lA4N0c2hor+raX8WZdA==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:40 +0000 (GMT)
Received: from ambtw-ex-se1.ambarella.net (10.2.5.164) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:39 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-ex-se1.ambarella.net (10.2.5.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:37 -0700
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:36 +0800
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
Subject: [PATCH 01/10] dt-bindings: arm: add Ambarella CV75 platforms
Date: Thu, 30 Jul 2026 18:43:21 +0800
Message-ID: <20260730104330.81367-2-longzhao@ambarella.com>
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
X-Proofpoint-GUID: ZnEWJoNJ6-Z8UXPPpcpLgS5ydF7l6SMl
X-Proofpoint-ORIG-GUID: ZnEWJoNJ6-Z8UXPPpcpLgS5ydF7l6SMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX4oVRt7qr3dv2
 bNAo6GQtKSCzzr6jzPOgkxxq3k1aIWOARSM77lpv+0aMQLxKVzFx8xDeqUmYasPonUPWR6W2EO6
 B2Aq9uDyBiWhgA2YEDi9qTiF5mYiz0uVxMIkSEZlQysggs8aqlJgPPhIxa0SbPtj9B/0wzbcpJb
 h7ialt7rEMTmyfb50Aay9xXV/Es2xVZq0nNwWA8TLVlM2deCXcfGFsZMsawsgyl5czvwaLrjhEK
 Z7ak9ROFP/3AEA+oDWuaw7KIYqhMTgfftz/SG+Y2hjzgyNwswG5X+iVLvvEEsewmPsPa6URhr5/
 ZtpV9248moO5zLWO3GIaj2j5RHBZJMtW7L0kUrksGoFTmOIF+ABzfujiZuTP04/1/Qaq48jlwcf
 LuO6pwBgNKwBp6ylfERM0cTN7p3CsBQFJ8uvd+7ocIpQIzfxTMM8igeUPc1Z+zn1bKSkHPafqjM
 Gh5aehlzA1W8v2k/OEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX72yliCGuI3ap
 bL3wJSPp6bvc5e8SQ/GlUMX4Dl4WHrM19YJncPbm8ky0fIj6scY80H7rxUI5QoI7gi2biFZptOQ
 5KpoGKJlJIooXjUAeG4A0472XkPpjpmTJjHtNr0rCR1Im9GSU8UV
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2adc cx=c_pps
 a=DgnZYc2JwZ3KnY28M5UqXQ==:117 a=DgnZYc2JwZ3KnY28M5UqXQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yXVIz-0bn9infC194UBj:22
 a=KblO7da7ppA7TBl3N-nE:22 a=gEfo2CItAAAA:8 a=ppJngBeKAAAA:8 a=vggBfdFIAAAA:8
 a=UchuEpcx5bk8SsTX1YsA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1011
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300080

Add the Ambarella SoC board binding and vendor prefix covering
the CV75 EVK.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../devicetree/bindings/arm/ambarella.yaml    | 23 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella.yaml

diff --git a/Documentation/devicetree/bindings/arm/ambarella.yaml b/Documen=
tation/devicetree/bindings/arm/ambarella.yaml
new file mode 100644
index 000000000000..347148530f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ambarella.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ambarella.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella SoC platforms
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+properties:
+  $nodename:
+    const: "/"
+
+  compatible:
+    oneOf:
+      - description: Ambarella CV75 EVK board
+        items:
+          - const: ambarella,cv75-evk
+          - const: ambarella,cv75
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 85a27937832e..f48aa6dabbe9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -112,6 +112,8 @@ patternProperties:
     description: Amarula Solutions
   "^amazon,.*":
     description: Amazon.com, Inc.
+  "^ambarella,.*":
+    description: Ambarella, Inc.
   "^amcc,.*":
     description: Applied Micro Circuits Corporation (APM, formally AMCC)
   "^amd,.*":
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
