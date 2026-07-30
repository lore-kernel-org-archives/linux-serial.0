Received: from mx0b-00622301.pphosted.com (mx0b-00622301.pphosted.com [205.220.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29A40B102;
	Thu, 30 Jul 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409595; cv=none; b=SAc/tnKfm93CapobtcnB81Aa7JlH93QNWIEemuS0odz+YemUVYsb+qGLxTkuskRgjaqLQ/+v1+PLaNDqDv4rgPc2wvwMdQCsiKTBJ6/WEb6KCOd3M5urSZsRtILW9XlCC5DVIVjyB3cdv4Jz8Y3Y6tqcAt+KoaOuoVVj1dxmUFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409595; c=relaxed/simple;
	bh=636J9EQYRe7tVVCazXdLYj1tEmn5J9pbvmLzgUJ4iMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HurxAFsKA37Z8fFiRhF51Wf1sb/jFzn1gpINSWGGlaDfdDyXWdGXfQcbaBsvmREqO/EWQWlEshUwF1Eb3RbNkLmeUdHds5Fxy6LwLmDumtZC1BVuBz5QVYuuB5FbMVUGx1f6FB6Xh4hR9umOLmz709RQeOV+fVbqQHAtDVZhcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com; spf=pass smtp.mailfrom=ambarella.com; dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b=I+eJwk2o; arc=none smtp.client-ip=205.220.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ambarella.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ambarella.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ambarella.com header.i=@ambarella.com header.b="I+eJwk2o"
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
	by mx0a-00622301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA3stW3328748;
	Thu, 30 Jul 2026 10:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	com20210415pp; bh=4LxfYmHR5L0zBw2a260tAcDoh7shWgndlmIo8JVY22s=; b=
	I+eJwk2ohZai5wjE5R8jZ6eLR4eTSWvhyVoxviNcnM2/eRjry3up/lKquEFze/in
	G7q4a6m95lA4E/p8wvcQ1AZp7P2BDzcIVL2KUEsUpaWlIbWGVCebmUSJQwVnNulW
	rsa32xhlsuogapxz5PuCr8+yfjPOa8XnfCYpgjAGfCevq6N5Fg7wJp69WsFO6A/W
	4VdajiunOcRG6/s2ll9ax1oP4y2nkC/wMjaC+6JpZddqpRhkwVg70wz21lmbA6iZ
	3D+3SswQHgtjlM4X6Edz8YlD5ddMHTJuiW5ScbhA05rudShSkokhODacctm1gaZI
	19cgYocDHEZ9glwEBQTWZg==
Received: from webmail.ambarella.com ([12.30.244.130])
	by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 4fq8twhnb1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:43:41 +0000 (GMT)
Received: from ambtw-ex-se1.ambarella.net (10.2.5.164) by
 ambus-ex-se1.ambarella.net (10.1.4.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:40 -0700
Received: from ambtw-cas3.ambarella.net (10.2.4.228) by
 ambtw-ex-se1.ambarella.net (10.2.5.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 03:43:39 -0700
Received: from shbuild7.ambarella.net (10.4.8.70) by ambtw-cas3.ambarella.net
 (10.2.4.228) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 30 Jul 2026 18:43:38 +0800
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
Subject: [PATCH 02/10] dt-bindings: soc: add Ambarella secure scratchpad
Date: Thu, 30 Jul 2026 18:43:22 +0800
Message-ID: <20260730104330.81367-3-longzhao@ambarella.com>
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
X-Proofpoint-GUID: w0DM6PpSMCrvEJjKZKVss7cCGHSuMjvq
X-Proofpoint-ORIG-GUID: w0DM6PpSMCrvEJjKZKVss7cCGHSuMjvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX5eO3aDpGcYYy
 BmCX+vFIW/tVcXB27bqAGAqf618xMTBWLS0o+EsxHkRvFICQedSGtSlsDJDkpgRQzJf+ja6nQri
 6i8EndLeWr647ocnln7D7+L8ZeWlsuKo/B+QmpOkOIMIL+4tg1UKjap75Awc3qO30abMd3Zh66r
 vmHqrn7pbP5linBitwVJr7tTBshvWVtFSjuAjOO7kSGe9eLPQHvqwuuGDjhBp81erEjsZohcYsH
 NDyYUN4SxCfZRXHQfABfVVFRRkfPxPOOQqHptszRtVa+1qNO8sIt/RH+c5vHEPawkj33mxrj88y
 c1IX2dIrlyaUDtwU3nTA17PcGM+nRicaAKgIGwhy2l3Ja9jejAUO2XQJmO1Nv2ZvxmXOxDdD7XK
 CEp/V+ZjuafjvdNuOho1KZ0fP6Ne2sccK00OjMP642BFKHIoyz5Lssa+VCX9MPFPSoqPTRaYH8S
 Gv5nSBn3/i2UP33ejzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4MCBTYWx0ZWRfX8F8tty7wmKtG
 P/fTtH2HLAv3/eRX0jkQ7swIKwftonN9qEEMjflOy9ujg8aoq87KlC73JYdoP0l2oftfrFd4TYA
 3ashrTRpzUfupZ2Q83hQ4Kc7udlIVEG9K+XykO7XpEUCpc9CjrUN
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a6b2add cx=c_pps
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

Document the Ambarella secure scratchpad syscon used by CV75.

Signed-off-by: Long Zhao <longzhao@ambarella.com>
---
 .../ambarella/ambarella,sec-scratchpad.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ambarella/ambarel=
la,sec-scratchpad.yaml

diff --git a/Documentation/devicetree/bindings/soc/ambarella/ambarella,sec-=
scratchpad.yaml b/Documentation/devicetree/bindings/soc/ambarella/ambarella=
,sec-scratchpad.yaml
new file mode 100644
index 000000000000..2cca277674f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ambarella/ambarella,sec-scratch=
pad.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ambarella/ambarella,sec-scratchpad.=
yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ambarella Secure Scratchpad Registers
+
+maintainers:
+  - Long Zhao <longzhao@ambarella.com>
+
+description:
+  The secure scratchpad block contains shared system registers used by
+  other Ambarella SoC blocks through syscon regmap lookups.
+
+allOf:
+  - $ref: /schemas/mfd/syscon-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: ambarella,cv75-sec-scratchpad
+      - const: ambarella,sec-scratchpad
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    scratchpad@e002e000 {
+        compatible =3D "ambarella,cv75-sec-scratchpad",
+                     "ambarella,sec-scratchpad", "syscon";
+        reg =3D <0xe002e000 0x1000>;
+    };
--
2.34.1

NOTE: This email (including attachments) contain Ambarella Proprietary and/=
or Confidential Information and is intended solely for the use of the indiv=
idual(s) to whom it is addressed. Any unauthorized review, use, disclosure,=
 distribute, copy, or print is prohibited. If you are not an intended recip=
ient, please contact the sender by reply email and destroy all copies of th=
e original message. Thank you.
