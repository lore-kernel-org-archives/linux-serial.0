Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BF4F215
	for <linux-serial@vger.kernel.org>; Wed, 24 Jan 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095644; cv=none; b=Q5zMlmgReGuCDILOBM+PuGzxf1qKegdz8/rojghU5upOCSwaAjrjIqok1BpQ5vbjx6zdb8rby9JRS7fgMGwW/XVyP0oapL66rpCdLthnpUnVOpkl8Gum/rJlvfmpoM0F7RBeg995TmY1GPEVzmDaGu8erJV7wf9cbWUw6YAWmm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095644; c=relaxed/simple;
	bh=6VDh3wL5ti4wgvGDaxABXFql+P9T7N0Vzenk3+vbTjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjEfrAHbi48/wRlpEJPPzpH1Yrn+wNRTPOiWC+UGKTPA9OlL6rF+tarDSWbQc7YYZ3RK1QC9aCBE9Y9R918XSnJUCKAL6SFnYAoDg0loG0t4tjWlgWEYnLAIEqvveDoOMXCEiFmcYYC3aXqy+bT458tYzxtiWjNLvGB/v4Qs++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by andre.telenet-ops.be with bizsmtp
	id ebTJ2B00F58agq201bTJ0u; Wed, 24 Jan 2024 12:27:19 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSbOm-00GQaV-JD;
	Wed, 24 Jan 2024 12:27:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSbPa-00F3vH-Fp;
	Wed, 24 Jan 2024 12:27:18 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Nghia Nguyen <nghia.nguyen.jg@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: serial: renesas,hscif: Document r8a779h0 bindings
Date: Wed, 24 Jan 2024 12:27:15 +0100
Message-Id: <55b458e0ba9824e1246e556075bf882032c37279.1706095578.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nghia Nguyen <nghia.nguyen.jg@renesas.com>

The R-Car V4M (R8A779H0) SoC has R-Car Gen4 compatible HSCIF ports, so
document the SoC-specific bindings.

Signed-off-by: Nghia Nguyen <nghia.nguyen.jg@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Split in separate HSCIF and SCIF commits.
---
 Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
index 2046e2dc0a3d190e..9480ed30915c9c4e 100644
--- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
@@ -59,6 +59,7 @@ properties:
               - renesas,hscif-r8a779a0     # R-Car V3U
               - renesas,hscif-r8a779f0     # R-Car S4-8
               - renesas,hscif-r8a779g0     # R-Car V4H
+              - renesas,hscif-r8a779h0     # R-Car V4M
           - const: renesas,rcar-gen4-hscif # R-Car Gen4
           - const: renesas,hscif           # generic HSCIF compatible UART
 
-- 
2.34.1

