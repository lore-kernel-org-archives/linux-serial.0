Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D51531E1;
	Mon, 20 Jan 2025 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737343417; cv=none; b=KIS6wyYdng0h5PWQZRT5szeCoQ+LkfjOgKA+gTGRjDXen16jR7mNt3rokT6S1vK+tkE6FhuoOsIf3078x35htFnCBVEcjFX0lQ6RRHgcf/voxv6hJkAE99jigTuPsaOm0tltPY5cHUre1TCNLeEXrUYWEqYNKiKHbSjCkEl9xFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737343417; c=relaxed/simple;
	bh=oqVAf1SnfzPWSBzI0w8FcbH3Ro76+Nk97QcOPhV6VJw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vkn9c2WFnE9twUFSgw+UGoZd2lGGp2c7VqtBMwVUspijNOwdFjcpYFllEBdkSErjUAC+DQgZxCWdJIFjQ0EBJnhJNoYRiETPv8DyMlLLMtn3Ah8DvN3cyOZFnQtbLYRyJMuLoPvsbPu9GOVz+UMTwGz5J4bakEfKUIHGrlCzKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50K3MHWi022226;
	Mon, 20 Jan 2025 11:22:17 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YbwXv5zxFz2R3d9k;
	Mon, 20 Jan 2025 11:18:55 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 20 Jan 2025 11:22:15 +0800
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
Subject: [PATCH V2] dt-bindings: serial: Add a new compatible string for UMS9632
Date: Mon, 20 Jan 2025 11:22:12 +0800
Message-ID: <20250120032212.3579184-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 50K3MHWi022226

The sc9632-uart is incompatible
with sc9836-uart, Add sc9632-uart dedicated compatible
for representing uart of the new project UMS9632 SoC.

Change in V2:
-Change commit message in PATCH 2/2.
-Modify the compatible string of enum in PATCH 2/2.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index a2a5056eba04..83582aa6c750 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -17,13 +17,17 @@ properties:
     oneOf:
       - items:
           - enum:
-              - sprd,sc9632-uart
               - sprd,sc9860-uart
               - sprd,sc9863a-uart
               - sprd,ums512-uart
               - sprd,ums9620-uart
           - const: sprd,sc9836-uart
       - const: sprd,sc9836-uart
+      - items:
+          - enum:
+              - sprd,ums9632-uart
+          - const: sprd,sc9632-uart
+      - const: sprd,sc9632-uart
 
   reg:
     maxItems: 1
-- 
2.34.1

