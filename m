Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1991D555;
	Tue, 14 Jan 2025 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736833638; cv=none; b=mmt+hqG/95XoCrgJybGbzEthfuUya9KayT5TaI64zd5H7bk2k6XcTQ7o4liyFajT9hqa33Xqf5XIupSTGg0Eq28bkamtHKOrERLkbTM+TJEe6FARX2gZXwIaQwKnB+NgrX8Lk7dwQB0LlimTGmpFc9kFpQISNloYhBsCnK6l6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736833638; c=relaxed/simple;
	bh=6CLj/TNA4WP1GR0jPs2VzXyDYyQjHGrHRsCNOtkSL6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPQn2JJgT/+CvpheLSKjJ7ZPTkq8tRtnMCRh5WHSSE2E5VxQD0A47thUcGlg76heOt70zTjNc28gTKJY//Y0k9UZyPVVlaml5Rjm+jbh3UwYwDn7pSzth+hDHcBSVF0k3M36n0r6Ylid+SJ/j3UxF9fcqxdquNhGOqXgMfGUWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 50E5k8gZ018409;
	Tue, 14 Jan 2025 13:46:08 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YXJ1v2JPSz2Qf5Jq;
	Tue, 14 Jan 2025 13:42:59 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 14 Jan 2025 13:46:06 +0800
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
Subject: [PATCH] dt-bindings: serial: Add a new compatible string for UMS9632
Date: Tue, 14 Jan 2025 13:45:53 +0800
Message-ID: <20250114054553.3376837-1-Wenhua.Lin@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 50E5k8gZ018409

Due to the platform's new project uart ip upgrade,
the new project's timeout interrupt needs to use bit17
while other projects' timeout interrupt needs to use
bit13, using private data to adapt and be compatible
with all projects. The sc9632-uart is incompatible
with sc9836-uart, Add sc9632-uart dedicated compatible
for representing uart of the new project UMS9632 SoC.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index a2a5056eba04..35fe9c301cd2 100644
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
+              - sprd,sc9632-uart
+          - const: sprd,sc9632-uart
+      - const: sprd,sc9632-uart
 
   reg:
     maxItems: 1
-- 
2.34.1

