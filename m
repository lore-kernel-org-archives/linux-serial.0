Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33932DEA67;
	Mon, 21 Jul 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113061; cv=pass; b=N7URU2cLMGmJwZUr2ieosBhw0Y39HXDxDMOOngzA/p7lArGgGfF15fFRQfjnpuFvTLV2Ch0F9DjKZFUM2neo+xk4Zo5BVI+BCem3TRvH3hr8WBBSCgd9hYs6BSpTVQgF4T5xvuadv57UQIT/RfsDkKS9LrNnNQYACECb90Cd6eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113061; c=relaxed/simple;
	bh=j91B84Oz0Xq6HVsDM7tdgBQWUDMFq10BFaaKSucD9QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0ABT5BaFJ894RBKCqPxnl7Sc7tXgPN4PGz88MWAlqBdcINRLxYYHRoqleFbF6Xe9n4mfyL50LaT8DFz6brhqh4KQE65Hu4sYWrCKLGqQWDQekiCVs09H+LcIenZo/pr7L+/8kLihEwilDVn+ExOkgJco23h3mbMv3Hw94I7Xd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=iZgxFBEd; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="iZgxFBEd"
ARC-Seal: i=1; a=rsa-sha256; t=1753113026; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ASzWRge2E4DxTAZ7O2+zToB7hejQWb4MeqrCxw9/5juhhvCfCjMY5AMxZrgOabgLdtv2zWSg2YeK2N8rd3K09BwWwzs68fe8lidCQ9qMf7ICpN8vHnUI8zyFwnjZZh6imdKwtKw/Mx+2BurYlWxgN5dRrJ6GHjCY9uSjZiiQEk8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113026; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AEDeiqXtDmQkcpk56jyCMSDFww7SqpNp1DMsA4Q7wh0=; 
	b=GLjBSd3EJ6RwIYSBaNA2dfXdeh/okA8YHfnL9MIwGhZ1pWjX0ZWs6AWNnPXGbdnSrSV60v/2soHECf2V6Xm1j3P4vGMlDlE+vQDa09DoXKPhOJQ7CSI+MrFf4nVFHS4B0UsKpBrosRpSkX9S9baoDfBuKlhoGv6SmXgqFOyG31s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113026;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AEDeiqXtDmQkcpk56jyCMSDFww7SqpNp1DMsA4Q7wh0=;
	b=iZgxFBEd1or6UTAgUlfp6AO7ZZSPZZc2FjZ63mVBC9/UDfUF9T9O9p3ALv/U/s8l
	VV2gKAC7Q99OW+D0MZ1sK65GOch9tEVcE9/3LKMTd9AO3y3OyDoXOKQjVF1VTSJnJDu
	Vl1/9Hxbf9bR0oxRlXMPUqZaLvYZqwQjhjZAMmuk=
Received: by mx.zohomail.com with SMTPS id 1753113023425908.9710507115287;
	Mon, 21 Jul 2025 08:50:23 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:07 +0800
Subject: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Anlogic,
 Milianke and Nuclei
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-1-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=1599;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=j91B84Oz0Xq6HVsDM7tdgBQWUDMFq10BFaaKSucD9QM=;
 b=fbHnySqFeJ3f498DO5n0mhRqhnJm9JzwKI6jlV7mm0ae9fitrUBkVcNw+0Fln+cnrA8uZbUSb
 98mpQedycdVA0sYj8UZCrcWtRzGzwmWDuy+d6vcyJgD6N+vmAeUIrE3
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add vendor prefixes for "anlogic", "milianke" and "nuclei". These are
required for describing the Milianke MLKPAI-FS01 board with DR1V90 SoC
from Anlogic, which uses a processor core designed by Nuclei.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6c666c8b557c2ef385918e5e97bf9..6ace3c66ce58fc15ef7cc70e88fd1904cb8395b9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -127,6 +127,8 @@ patternProperties:
     description: Anbernic
   "^andestech,.*":
     description: Andes Technology Corporation
+  "^anlogic,.*":
+    description: Shanghai Anlogic Infotech Co., Ltd.
   "^anvo,.*":
     description: Anvo-Systems Dresden GmbH
   "^aoly,.*":
@@ -968,6 +970,8 @@ patternProperties:
     description: MikroElektronika d.o.o.
   "^mikrotik,.*":
     description: MikroTik
+  "^milianke,.*":
+    description: Changzhou Milianke Electronic Technology Co., Ltd
   "^milkv,.*":
     description: MilkV Technology Co., Ltd
   "^miniand,.*":
@@ -1081,6 +1085,8 @@ patternProperties:
     description: Novatek
   "^novtech,.*":
     description: NovTech, Inc.
+  "^nuclei,.*":
+    description: Nuclei System Technology
   "^numonyx,.*":
     description: Numonyx (deprecated, use micron)
     deprecated: true

-- 
2.50.1

