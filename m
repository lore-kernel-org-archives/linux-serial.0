Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4C1EF36D
	for <linux-serial@vger.kernel.org>; Tue, 18 Mar 2025 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288059; cv=none; b=d2qzwvVJJ5MuWLNJErPFOzbwmQR+tVRVGF0e4Yvx6gtljLZq7fAHFBeLY8jrmJk+Cs1EDdBx+O0ZPZxQ2VjVxFd0FPRLc0Hr6Lt4bPqvSqxUH4ON7CW303h4jfxLIF6YePSjZuC8X9+m+kRLKftZNX0yxUktkCFuUd19u0ngZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288059; c=relaxed/simple;
	bh=Js9/nS+MIPxyikfrAQwlchDX6ZwWrhrB5CNrGfZ+bo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cewA2OQN5p87oeoxebO5V0fjiWc23SbEfTYLXrjJcMWan+biuZqhfUmKSUHT/5Mg74kNFfDsUaCmDEin9XnzT+tbzcv6+OhbWtRFjbMFC3d3pLiJ2z8iNKjXeyDA3EaW5zzgExs3d7Tha4hO6ZTd2x74xDfbsiR7rP65hZRsRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hjs+AQXy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hjs+AQXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=2ayO8Klm1vIIw2
	4IPuB7XQ4nODfqD+hrTlr7Ibbi9e8=; b=hjs+AQXy1ZWv1t3r++oPCwtEhGKvzW
	2g8sEqKy8vHUWkw/hyir3kQ9XJ3KfK3MatMiz9W5Uo4PnZMPQthJGCkPA4g1o+8A
	GVBxDoRI57WC/1zCGqsi8yzqNsO/dfWzrY9xSZePY/G/pRIfwyIVOgCGpuDUj7uH
	1vhd906h9TXu2Nu2NKpcrLr2gpAJpcsbiHlSQ0xfun16p0xYxQaHgSnh8h+LqlXG
	LCC8HoWfqMJtg+D6uRjxTxhkX4xk5ElErsI4S+MDw5GQzvZaU/27o8fqvsJrUv61
	5ZTcr9VroDBUI+kWmcGvzceHV4t5MTAloa1c4rULhgJC9YfEvfbuyi3A==
Received: (qmail 3650562 invoked from network); 18 Mar 2025 09:54:13 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Mar 2025 09:54:13 +0100
X-UD-Smtp-Session: l3s3148p1@/tp6DJowMNggAwDPXyTHAJp038nK7dx+
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: document RZ/N1 binding without DMA
Date: Tue, 18 Mar 2025 09:53:53 +0100
Message-ID: <20250318085353.18990-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/N1D has this UART with and without DMA support. Currently,
only the binding with DMA support is described. Add the missing one
without DMA support which can fallback even more.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../bindings/serial/snps-dw-apb-uart.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 1c163cb5dff1..645b14ffde90 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -13,6 +13,20 @@ allOf:
   - $ref: serial.yaml#
   - $ref: rs485.yaml#
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - renesas,r9a06g032-uart
+                - renesas,r9a06g033-uart
+            - const: renesas,rzn1-uart
+            - const: snps,dw-apb-uart
+    then:
+      properties:
+        dmas: false
+        dma-names: false
+
   - if:
       properties:
         compatible:
@@ -30,6 +44,12 @@ allOf:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-uart
+              - renesas,r9a06g033-uart
+          - const: renesas,rzn1-uart
+          - const: snps,dw-apb-uart
       - items:
           - enum:
               - renesas,r9a06g032-uart
-- 
2.47.2

