Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795294933;
	b=LunrGz43lHvWjSMPKeuW8ogPVWU7hZpJkqMVJcOFsPHNn/52n7Ia6dVxO4ff4MJ5hvfr
	 u3Dyg6nkw9WMEFcNdy83oYR6fYzxPTP60zRHODZIR7+rksrNnYsatSdAKHnVibNyN51us
	 h7r/7K73iY50SlSASxWutTLQb3j67/pGCTaGLHbjgqyaBWmw7lEvZgWCCmSk+Bs2I+3pM
	 nzGuCHjOWXpWYob2gTNEhErVodjRKf48NA9lMpMqCNIFyvZD73ykPeO/jYuMxNeoVtls6
	 YBx4Gxf5DXLACAi2t2UC7v8t7Vtz1GJyRyNW8IokMROnsknVGLBCKigkAJxJXOo/SCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294933;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=h2ynOQm1OZV8Is3Or2mq+TNJq0A7izHSMy1uGvM4VSJRJ8Z573Vu9RzY6Z7dt9rsVB1+
	 tTk1cOULz9heBjWsJNBCwxc3q9fxw8Bxc+Z3HAq5LHdzaGWPlG3Chxz+NmcDnbrXJY23e
	 jgBov0p3cw0gWUSgr4nXjmj90qqHX00dhOJRy3a2Uc4KFyUbEOfpKbMzsLNSTpBMZY42X
	 Qt+HheOboYlBk422cvjDO/wJl02ZGaXkjxSzeDQVCBFWDvyRV07VM5QQCp+NtWWoe6sae
	 oran87MpR8IcKiLqD1qrJBRzhlrMcnWmOfwvrg+oL9VQF6/IH2j2LP4P6/pLBhnQY3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NATfXn7Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616D606A33D;
	Sat, 21 Nov 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NATfXn7Y
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294933;
	b=uepjgrM0oh2zfTFHzNDg5vc4J0yzbVBdbe94hovPLGaifR8YsD/FaHBtBKABe8hp6R/+
	 TctZu2v+EomdwctJeZJSt589P6uRBtR3osNyoFEetOnOYWW6GLaDTV7tjf64oWaWqS267
	 bK2IiRgSaPxwsAOxJEHp0dIbOMfjxbhChU5DkKckOInjcneFfmMx2ZW3T2NiP9i7DaOkZ
	 kCHCoLCqNV/YGHOM7YO5w3lzQy8/42cPIGYjMwvQsmXYOVRkgcNbTZWxI7nxL0oYluZ3+
	 QOPJQYWzeB3tNP9SVm0XM2aY2lUR4NnQaKC2BAbon9uqPdfvyYLAcJHLRX73UgFnd0w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294933;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=RiXdwUYNXinrdc3gmDneYj3j0hGWMQjVv5ucLR08vvjYHPvuG8SCYu5/LIr4DSNH917A
	 WBqscSPLWKHju6S9QWU3tHcVERYEZ219I5UTYRLf7Y8LXjCuO7407wjEikOXdxG8343QN
	 1EJU6/MttDuWsk6l4CD09ni2V6UhYLog+g8KkLHKhTSemvpqYJlk8qqSLZhNxiTc/OoTu
	 vp1prCYyN32wBSgacVDZlDWX/JYfLrTeGbhnqZ4eCaOA3i3oiaQFuxwS4eqXfJ+4vTPOs
	 ytdJnPHWlblzeoaj7gFOmNVTWBxJVvF6zhYvV8y7wod+pPhSMSMDwYJdlDpGN9QolqQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D83E81F000CF;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294933;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NATfXn7YwJD6t4rsNY69dnuHHbGWdKPpmZp8hv/F7YKSQ0yJRwqibuNUnjt3WTk1k
	 bP91Ag8MCSxEbS8pvtVaGhIQdE7uCr1rQRA44pBuNsJEP9mH5Chjm1eYlPk3WtpxUM
	 fiFrqIEqzBLMMlVRUZxjJK5G8YXl1EppniGP/D+ZAFzbJydN05AEF44C3t/JR+EjNc
	 nJraG5EfZqipFpbJ1qtiyEdcfLTgk5VgHkzT3GpcPALgL4ca6FObGYJgZ9TvTtF8GO
	 6LUi4GVVJPitVc/jQA3YNg2xTwuO3ZskXF7cpgsPK+Sbc+w56eFlCxbdXltCVnSvbZ
	 xJKPLe1tJ/Wuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 656304BDAA;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:47 +0300
Subject: [PATCH v8 02/10] dt-bindings: arm: Add Cortina Systems CS7542 and
 Securifi Almond+
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-cs75xx-v8-2-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=1646;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=ur5Y90DJUCyqB+ubnyEmmsptLVPvVwYRa4Bevb+7QSg=;
 b=B5/+P0DJsOW/YHdPo//fCPFgKUQixMQbYcIlqD+bgRJXcRJMXCKJa5fH3XrbmRIcrZBmnG2tV
 0bEsaHtWg7KAFyrxjSaBzsCqQey9+AeRg9e+B/zGFwccQ/w2l+IV45/
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add the top-level binding for boards built around the Cortina Systems
CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
the first such board, the Securifi Almond+ touchscreen router.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
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


