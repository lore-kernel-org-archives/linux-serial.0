Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45890134C1;
	Mon, 18 Dec 2023 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BIA3Mj0071114;
	Mon, 18 Dec 2023 18:03:22 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4StwGb0q0Jz2Pj8FH;
	Mon, 18 Dec 2023 17:57:11 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 18 Dec
 2023 18:03:20 +0800
From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee
 Jones <lee@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan
 Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 1/3] dt-bindings: mfd: sprd: Add support for UMS9620
Date: Mon, 18 Dec 2023 18:02:32 +0800
Message-ID: <20231218100234.1102916-2-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218100234.1102916-1-chunyan.zhang@unisoc.com>
References: <20231218100234.1102916-1-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BIA3Mj0071114

Add bindings for Unisoc UMS9620 system global registers which provide
register maps for clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
index 996bd4a17ca3..a750fa23d7e7 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
@@ -19,7 +19,9 @@ description:
 properties:
   compatible:
     items:
-      - const: sprd,ums512-glbregs
+      - enum:
+          - sprd,ums512-glbregs
+          - sprd,ums9620-glbregs
       - const: syscon
       - const: simple-mfd
 
-- 
2.41.0

