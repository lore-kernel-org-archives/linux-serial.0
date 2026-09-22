Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEB4F7CB2;
	Tue, 22 Sep 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071189; cv=none; b=sJpZR37EfiALYCsWmGkN2TD4dsq0/wc5wO82YW50Ya1yKy9lWtT/+XC5YwAnOcxuARETQzA6wMxgHAVGECS1wrvoFakExvROmuCyQJsP0Fg6a81TkjSOtJpMube8EW0P8MjJtqrj2s4r/5nesOQIgvXojOuiBCqL4CoP0+O6nqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071189; c=relaxed/simple;
	bh=y/bBaJsvbZDw0Ot3aHE4syjmNluaHUJHma+Um4i/rH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGzby3VlDiRuby6/qtJjpzusGR+zW41gQo0v+a02mG++EHiltsLE0hkywtRzonUFBOuFEgjK8Zfb0+R/hqJlKgCONxiIEqC5EcYFZTYXIetyf2R6fVA+3Ctowzk5yW1wvhYqhIXlA3s+/dDcCQHyjpaV5wOOyY+AMDiSJq2V0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891D31F00898;
	Tue, 22 Sep 2026 09:59:45 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: serial: renesas,hscif: Increase number of DMA channels to 6
Date: Tue, 22 Sep 2026 11:59:42 +0200
Message-ID: <0fac2fa211f591d91c6e59fa16bc98791afc6559.1790071098.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On R-Car X5H, HSCIF serial interfaces are wired to three DMACs, hence
referring to up to six DMA channels.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Correct authorship,
  - Add Reviewed-by.
---
 Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
index 4b3f98a46cd9ded0..409cab32de3d8932 100644
--- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
@@ -97,14 +97,14 @@ properties:
 
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

