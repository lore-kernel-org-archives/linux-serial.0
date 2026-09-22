Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647C5187E0;
	Tue, 22 Sep 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071219; cv=none; b=KQ0jCiiErUqSwLQn3ZcgffrJKVRqOXODHlfF4zh5PIehIFrN8JZpQexsHzC+welGxeOlr+XS6fK6MzECsp0ozbnkv5YDIOUS6jDPz+MrpM3uQkCED/I+5aNmnjtnobkXQgkNHtO8XvCINfCc3XdcmjX6GZrkLM7iKTg5F0k20wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071219; c=relaxed/simple;
	bh=hOEdRsjyt9vjraMb0o2F7Nqk6qnmGBhCD54jeoMRqc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1cHsQ0RoUWltCohzVIRTsFj1NhyU/deOOtknYue+PkMOtghdjYXZlRWvisFFLgRZbpcQB38I9gqJbtIOzujcDAJetPKUpfhXAFPcW5nZ5XALvOBst5t4T4Njc1rCku7r6qofX+25EuoWv+P0qhgoKpIl2A0cSsO/HUF6OpMp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD291F00893;
	Tue, 22 Sep 2026 10:00:13 +0000 (UTC)
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
Subject: [PATCH v2] dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6
Date: Tue, 22 Sep 2026 12:00:09 +0200
Message-ID: <4dc02f4ff8a63c2bd41b15359828ce9befd2da2f.1790071199.git.geert+renesas@glider.be>
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v2:
  - Correct authorship,
  - Add Reviewed-by.
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 82f54446835e6a5c..b465c93c8357fdb2 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -145,14 +145,14 @@ properties:
 
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

