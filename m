Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668126AF5;
	Wed, 22 Jan 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530774; cv=none; b=TIlqj/dDSc9XoSn4ocUGwuhkaIPgNSVofX3t8nCBRtIPpH0h0eJRTP5eR1m9k7+NPK8mKfhSq5PVH9FqjLUoatd6hSZ/04U33r+XqnHIzNr5lveZF1lwj6G68LUl7DbRUbn7ZsMwm169wteOMKu1J3pI3HxnL41CmRTuDEK3Rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530774; c=relaxed/simple;
	bh=hfcNAiD9g/aP7gdeEuIhgjBBOWOVP5DQrr2POSIZT3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DL2imSVgsVpcNAn2AsSLCAnYS5I4Cc8Ua1ZiyftvCxmJQRggwNbXhaJEVOotB7Fj21USocN4ulEGlMHg8y+G1wRbiha9lQNF4bW4SbiArxuV2EAMD+SfmlCb/81oaEIMTkklitCoFJGsUCq40Ifq/meloGWS9mKze1RssTguqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50M7NtiS031161;
	Wed, 22 Jan 2025 15:23:55 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YdFpk0BR1z2PKC2R;
	Wed, 22 Jan 2025 15:20:30 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 22 Jan 2025 15:23:53 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu
	<Zhirong.Qiu@unisoc.com>
Subject: [PATCH V4] dt-bindings: serial: Add a new compatible string for UMS9632
Date: Wed, 22 Jan 2025 15:23:52 +0800
Message-ID: <20250122072352.3663653-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 50M7NtiS031161

The UART IP version of the ums9632 SoC project has been upgraded.
UART controller registers have added valid bits to support new features.
In order to distinguish different UART IP versions, we use sc9632-uart
to represent upgraded IP and sc9836-uart to represent old IP.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
V3->V4 changes:
* Modify the indentation format.

V2->V3 changes:
* Lists are ordered by fallback.
* Combine two const items into enum.
* Change commit message.

V1->V2 changes:
* Modify the compatible string of enum.
* Change commit message.
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index a2a5056eba04..5bf2656afcfd 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -17,13 +17,18 @@ properties:
     oneOf:
       - items:
           - enum:
-              - sprd,sc9632-uart
+              - sprd,ums9632-uart
+          - const: sprd,sc9632-uart
+      - items:
+          - enum:
               - sprd,sc9860-uart
               - sprd,sc9863a-uart
               - sprd,ums512-uart
               - sprd,ums9620-uart
           - const: sprd,sc9836-uart
-      - const: sprd,sc9836-uart
+      - enum:
+          - sprd,sc9632-uart
+          - sprd,sc9836-uart
 
   reg:
     maxItems: 1
-- 
2.34.1

