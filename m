Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E91F152B;
	Tue, 21 Jan 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737460590; cv=none; b=sEKda5dk7jfbt22UdyMsdmpmtfcIKUJKLSdqKYDoF2ilp9GVdsSqSv9VhAfkIsoQsN8EkAJL51ktHk8YRhpoNyym2JRBgmZ4+OzQVoGwhCHtZ7Lt7erJF4IhG0LaGoYo6+hAL6biEcXPY23wuHrc6n9xtxNWHjUT0TuPTloFU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737460590; c=relaxed/simple;
	bh=A16fXmKsvA2ofqtFTJOBTIZqs1/jrwbOmz8ZCsbdAHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3gwKLIi2oz5vIK7G2F+UDkRnDXwb/ppENrAuOyqqR5KiTXAoPR6RlVlb2jRFna2kHuRsCG5BCRpmSyQLpfPFSmfI0gef/lm0mZkCOyGd3koT+HxRxQ+7jliUpgWz16e3tDwy3SAJG2OT63kkQSt3N5UfLsVaOEcXOoUsQCJszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50LBs60p068522;
	Tue, 21 Jan 2025 19:54:06 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Yclrz1DfFz2QdbSk;
	Tue, 21 Jan 2025 19:50:43 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 21 Jan 2025 19:54:05 +0800
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
Subject: [PATCH V3] dt-bindings: serial: Add a new compatible string for UMS9632
Date: Tue, 21 Jan 2025 19:54:04 +0800
Message-ID: <20250121115404.3612588-1-Wenhua.Lin@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 50LBs60p068522

The UART IP version of the ums9632 SoC project has been upgraded.
UART controller registers have added valid bits to support new features.
In order to distinguish different UART IP versions, we use sc9632-uart
to represent upgraded IP and sc9836-uart to represent old IP.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
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
index a2a5056eba04..ad968fc2493b 100644
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
+         - sprd,sc9632-uart
+         - sprd,sc9836-uart
 
   reg:
     maxItems: 1
-- 
2.34.1

