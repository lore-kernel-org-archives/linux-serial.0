Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AC445AFC;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751603; cv=none; b=SymQE9BINfdIMhB2Sm25gzHvTcj/lDMDuYj04T/FumoSooNPPvXuIVXgzJtK2HEy7SHXKv9c3PyDz/lQZpDOH7xeeUFveYeGyuA0F3wFZ8jh86wFdhB5deL0hqJlTbETwsGuDaC2hoizMdNnzKSDRrfYU0mYsO89/IuKH4vGzsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751603; c=relaxed/simple;
	bh=QjRO6YZGHXvZGdT/mc9TcJEDwxHmvLNJx3B2ngWy9RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQlDEkx/qXsjSIAggGamdHF6kR+dK0o2MCEJwfyEsSdNDwI3TYa7MTiV29nwIX/X+1IhqXHQxpPjL/HWZsbFUgrCGxyLDGY5yzDiCAG/FlrNCGhc4o8pEaGtXnXOtfZPtR1HuHlN22quDlFp/gx2jjzxOqcbAr/u78v9A/AYxnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmVDwBrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmVDwBrG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA0E0C4AF15;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=QjRO6YZGHXvZGdT/mc9TcJEDwxHmvLNJx3B2ngWy9RQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pmVDwBrGiYBq5GVfleLnaItnonx7aExLoRCqUvl+fR1wAn4EezdbGY0dukbEmplTz
	 S+BryWXJjDDjG+irENxQub4E3YflB0MtjY1mDglijVgMkE1bhGOaA61zgHgli4qtVo
	 X605LulOJFEXlzDphDyWeEJNPhqRo2FD8xKTSmPyziu4EZUQEy+pB9qdXS/hb2GKhy
	 3q9GXil0Erfe8vqVph9OIMWDJhlaW1OsfFLXlPNc7TXqsMw7zPiko4e6U1Yan+QDzw
	 pdlPhwMAd45mMTrwm5cRRzcV3TbmQjGia5kW+FRUFvvrewRIvcJsClCl5ys2mDrWmr
	 XNVhynjL90a1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97324CA5FB1;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:01 +0300
Subject: [PATCH RFC 02/10] dt-bindings: arm: Add Cortina Systems CS7542 and
 Securifi Almond+
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-2-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
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
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=1549;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=wHnN5POb8APv+OhJajwLU4PZK+CzDHpusgd28toOLM4=;
 b=Y1bGkteHhJqHO9tB5sjyNgkBhnBBOlOAKg73JLRY6PWGhJGlY68Fvge8cR55JFu2BZm9ZxyFi
 rdafMGCc6xYAY1IlYNE091P9lnlAMDfN9F/h7zD/p3Y0hLPURVxThOr
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

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/arm/cortina.yaml | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cortina.yaml b/Documentation/devicetree/bindings/arm/cortina.yaml
new file mode 100644
index 00000000000..1c04b178159
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


