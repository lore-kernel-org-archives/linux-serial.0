Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD012F585;
	Wed, 14 Oct 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977151; cv=none; b=KEd96Qw8VTwpV7BTr7qwyBmdyQJ3WsXcmL8NyMEoA90nUodlIX5Cz8oLZa8oNpVQUBmS2drOwLhQIgcsQq5THRV2fR52hs9+9gAdiJgaFAS3TFisivX9WONZPioRbapV09SAZSxzzQFumvDzZ08Ab/x7Mv0Vuo1la6KZpPv9XJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977151; c=relaxed/simple;
	bh=oOREu23JJHbA6Zu7YbD7/cWRc3qYv+PmEAH1EsrxXPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJifP03rtqF1hwnrt2aMmk56VAQjTGPUnFu+zGmJ3BFvlYV22ewLqG0XVhWRePijAJwCkyUvgGGTrx41K9EUfaUG1FYvW7+ttU/1KxvGV4UJrGwNDOqSkpFLEi62GCavILG+SQpu8lh3+cA2KPbEZzM7k5AjlDgl6ib9WhqCVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCPkXxaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCPkXxaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608351F000FF;
	Wed, 14 Oct 2026 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791977150;
	bh=8CdH2/cgXpSNGpOP+3xFwnPUW1IiBkjXh0lWbPTJ1iE=;
	h=From:To:Cc:Subject:Date;
	b=jCPkXxaf4AtQRbmirXUtTxsR/xUdAVFYEiYGd7xuZ+H9kyj9ktH51Dr6XC4Xdfyq4
	 YB+V/+LEY4zqh5wVQA2bjOTULUyX92q3gbPYeLEOUuOLWNOOba8rhuWpMKSuylVgtl
	 UmsQWzvWuy7BxEl9w1yGq6Gx3TEM6kgDH16W/9WAv3TTiBC8XD0EiKc10Iu+DX0W6d
	 Xs1CmgXplxMdz3srKPbUvJxWz1DnxtZn6D7pvg4MMAoHsKPSEQW0WEHr7Po0r1BaIy
	 yLk8vwrrV2OiAU1Db75isNZwDB9TWlt6pxLI15APbSWXREVQMnNn3eHx3NRa4rLi94
	 c/vA5rAQ7V4ug==
From: Jisheng Zhang <jszhang@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl2610 uart
Date: Wed, 14 Oct 2026 19:05:46 +0800
Message-ID: <20261014110546.415-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the UARTs of the Synaptics SL2610, which are
compatible with the Synopsys DesignWare APB UART.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

since v2:
 - collect Acked-by tag
 - rebase on the latest tty-testing

since v1:
 - use sl2610 instead of sl261x
 - send as a separate patch

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 86dc25919311..e2ca126d58ba 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -34,7 +34,16 @@ allOf:
       properties:
         resets:
           minItems: 2
-    else:
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - starfive,jh7110-uart
+                - syna,sl2610-uart
+    then:
       properties:
         resets:
           maxItems: 1
@@ -80,6 +89,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - syna,sl2610-uart
               - ti,tda54-uart
               - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
-- 
2.53.0

