Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB65134CC;
	Mon, 18 Dec 2023 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BIA3N49071157;
	Mon, 18 Dec 2023 18:03:23 +0800 (+08)
	(envelope-from Chunyan.Zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4StwGc1scHz2Pj8Dm;
	Mon, 18 Dec 2023 17:57:12 +0800 (CST)
Received: from ubt.spreadtrum.com (10.0.73.88) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 18 Dec
 2023 18:03:21 +0800
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
Subject: [PATCH V2 2/3] dt-bindings: arm: Add compatible strings for Unisoc's UMS9620
Date: Mon, 18 Dec 2023 18:02:33 +0800
Message-ID: <20231218100234.1102916-3-chunyan.zhang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 3BIA3N49071157

Added bindings for Unisoc's UMS9620-2H10 board and UMS9620 SoC.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/sprd/sprd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index eaa67b8e0d6c..40fc3c8b9dce 100644
--- a/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -35,6 +35,11 @@ properties:
               - sprd,ums512-1h10
           - const: sprd,ums512
 
+      - items:
+          - enum:
+              - sprd,ums9620-2h10
+          - const: sprd,ums9620
+
 additionalProperties: true
 
 ...
-- 
2.41.0

