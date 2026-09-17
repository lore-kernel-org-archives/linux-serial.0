Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4F57EDA7;
	Thu, 17 Sep 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654029; cv=none; b=jOewmoPp4Q9X6XF8O0YwyKU1yR7WHM8LIUhTh6Jo6Wyf6nrkmgVLbPkRbVlFCbYjqRmZ6Ri3QYQznr/hKJIUJkVBkn3IrxiuIcb8qeqhnCqqRtGYugKldRuroV9juo4JrLD89drCJekne2nwce91OMlciTVlh2cWojw15ViAJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654029; c=relaxed/simple;
	bh=tl6PVRa+8Qk3vH0h+QcFSzQQ9EfBKaq+zYMCN2rsh2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pf2R42njWEGsUSSfm+EnSqJBfYSedFwPUlLaor9+RGNnyup+7GyRDH0yJAPxoBDI8a+OjgeoFYwPam908TGrAL6M+bnOM5AcOxKWh479cdlwtGxMDgHmC8518vAJIx+kXpYsuqR9fDMdoRAn91uRKIzejXWSQOKTqifda5OKcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C8C1F000FF;
	Thu, 17 Sep 2026 14:06:59 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6
Date: Thu, 17 Sep 2026 16:06:50 +0200
Message-ID: <4d6e5ac045af387dde8ef3810ce08c7cb079fc29.1789653872.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On R-Car X5H, SCIF serial interfaces are wired to three DMACs, hence
referring to up to six DMA channels.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 3d5f8ca744783550..a30c79cc455264e0 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -146,14 +146,14 @@ properties:
 
   dmas:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
     description:
       Must contain a list of pairs of references to DMA specifiers, one for
       transmission, and one for reception.
 
   dma-names:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
     items:
       enum:
         - tx
-- 
2.43.0

