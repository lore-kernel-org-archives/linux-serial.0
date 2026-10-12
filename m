Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE5438037;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788313; cv=none; b=rfyJL7yCDfBPelbXvG98ciSPPL5sKaXGmhNOcukO+mL8911HUL5eUDVYwRkIuJUuCsA1c5fAb0xec8fezXWXS2yMMpXk1Qz19dYH7V9BwLiGJSYOPOs6meeKcOAYf75Yb+OdXC0m+mV0uYVVvsVOWIS/JkVMRkEcBm51myA+CIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788313; c=relaxed/simple;
	bh=N8m7KBF7NQ6WTdonuJlgr8ReC1ccHJp/7yH4LqgQIjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpje5O7oU2Y0yZqHyBfpNo10AnYFFWzhPH93ymqDCgzMKlY5DkhrSaqOyRXD13o4QpvsmjN8aJZ384Cp5X/yS6nPWhlyLTV3Q8UVy6UmN8DxQUBViH2NDMsNkYAzimindSEoWR6Q4RD4JwK0Cm2Ul0NT52jLeugnDHNuRV8F2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrUl7zZG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrUl7zZG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16828C2BCF4;
	Mon, 12 Oct 2026 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791788313;
	bh=N8m7KBF7NQ6WTdonuJlgr8ReC1ccHJp/7yH4LqgQIjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nrUl7zZGf2aX9gtigUieDXV9kwDND3v3mr0tYeISiWlowyl9sSRZ4XA5ZUhHJANn9
	 Nvr+AZBKAkWP0zOqFCXUX/2WM0ws6DhN8E9sRLLkn51ZMMpKLr2P02J8ob08OEg5Ly
	 rYeKmPg/ue43fn+WB2RikqK0YyO4n3SYcOesKXwdJ5FT3hP26zX11NYBhuHvAf+G5J
	 YgoGkYwZnMQrSUVvd8ZrUYA1mMiFZLWNbaHEzbn2zQ5V28YCiVxyRBQx7RzeyYIZew
	 X6kv6mqZbW7t/WkYO7auKoqoY/8yxDP6IdJLfmRbXisQ5fWJYaqZWezg+jvLxYLCEE
	 4uh2Y9/qX8H7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5B1CA9ED9;
	Mon, 12 Oct 2026 06:58:32 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 09:58:32 +0300
Subject: [PATCH RFC v3 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v3-2-0e0d17a098cf@gmail.com>
References: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v3-0-0e0d17a098cf@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791788310; l=1646;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=iqp1aP4N83y9unmltEz85GKl1p1MyHyOFw1KaFYcgAM=;
 b=9GViLMClt1wKk1+q7AdJ9M1fQ7u7z/e0i+UMrZVjQ8gEeRgQjvOV3FvOI5LODtNkiwO8iYN28
 6oorr1hiNXSCZ1KsJOiNQYbHbEJlGymfETbDWQvM0kh7d/2dyYrKUw1
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add the top-level binding for boards built around the Cortina Systems
CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
the first such board, the Securifi Almond+ touchscreen router.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/cortina.yaml | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cortina.yaml b/Documentation/devicetree/bindings/arm/cortina.yaml
new file mode 100644
index 000000000..1c04b1781
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cortina.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cortina.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS75xx platforms
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The CS75xx ("Goldengate G2") family are network processors from Cortina
+  Systems. The CS7542 has two Cortex-A9 cores with an SCU, GIC, private
+  timers and a PL310 L2 cache controller, a packet processing engine, three
+  PCIe root ports, a NAND flash controller and low speed peripherals.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: CS7542 based boards
+        items:
+          - enum:
+              - securifi,almondplus
+          - const: cortina,cs7542
+
+additionalProperties: true
+
+...

-- 
2.53.0


