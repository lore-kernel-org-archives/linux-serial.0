Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350474B1295;
	Thu, 17 Sep 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653982; cv=none; b=nt9eC4DtdX8q2Av0/s3SSwkMB/6rgSgyoZOYYZKQgOOQIVdEhXwPbjnBcyCK8gY3wWTDZytHcZFSF11kQ6tOjvdjRPhBRgTOdyzr/GSKm7bzbocVI9qeaq4FbPvojDJc00oBIqebz2JuHCYv7YUWioNkWZriS/403bK3xfv6ngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653982; c=relaxed/simple;
	bh=Js2iTFi6Khf8j3RgU0piqC/VpgzUNiIM+izeE9+OBZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g37wet/v6FcbFYeeKFX+X5BXUlKuQbdONTUWCENptFv1VDReGqGCD4kRAygHtf9rOFgFJuPcX6QYvXj/3mFIfxAUEyam+fRGQ2iQPflJGQV/72v40FShUqxsc1s152IQsuOjXVeteyH4yEGy6y3esUtJRiI+5tR6fcB2Shz9owM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D5F1F000FF;
	Thu, 17 Sep 2026 14:06:18 +0000 (UTC)
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
Subject: [PATCH] dt-bindings: serial: renesas,hscif: Increase number of DMA channels to 6
Date: Thu, 17 Sep 2026 16:06:15 +0200
Message-ID: <a08834717c1df2c8974cb0b8300a20cc33c426fa.1789653869.git.geert@linux-m68k.org>
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

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

