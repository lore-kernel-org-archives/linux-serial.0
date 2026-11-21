Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795296961;
	b=CaSuyPo1OQWr5bk7Du/Y/p+iXosn54VWOS3RAIOoa9AwYaDD7sEaZyEgy5u/ugl7JWAq
	 fIsP9MaHeLH+QkGPqtuO21pIwZmOMkYCl4A8YciNHjOMgpo8BIjoWdtkrR7TKwrHxZZRx
	 7cDI/6Hytk4nnIxNOimDx1AMtMeOBtb0Fq6REQ6wUdEVyD0NxMZzA6sPATok6BP8iyn1T
	 zc74aoFeNtsfUXKUpoNlVkHjjKiI2pCrVORCoryRuPVXPEEiYYUnuYf/BgRQXa2HhVKh4
	 rt6O4wVmuEKlPwJXdyYiHMADsf99pI2jLhRyYnvAElfwHt3YIPCRT5amlaVn66qziZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296961;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=xmQGru2zgI0ZzCC3MmeG4Osv19lLYsh9ye49hx0FL4BQ0s65MUSEx49oie8DXh3lBFEj
	 KZ70CNuoJCXR+wuavC+arWjkpQz/eYw8rc1rj+VpqxA+wFhYdSX+EhnXj6J67yp+h77r8
	 V8D47BSMYvv8hbt5T0f9wzohSbdCkRi60Ua1eGRxr//zqMB+4lSRzY7hHsE9sKfq8PyLx
	 C2eDgrNiUotcudhBblk7MRosjzwMZsrBC9roVJYoRpso0t3JYWa9YkcwMoxWafOReM5pq
	 6fiqDhSe6JhxvIYxQxWMk84hHdcSWuvJgNB5PCGq6iSsm3ID0PX2an76AjPYKSJ+9Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYmicm12;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3C606A32A;
	Sat, 21 Nov 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYmicm12
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296960;
	b=vwT7gxucorxk5ygBxgULg9b88PCFgZiQRLO3qBAyOS6hg0JauOa3uQcYtsRsI/AN6QfL
	 Y0ZDW/RjOGDJXPIaJ43PpEe0XkPcKmAaKwren190XnlyxH78JbS0Pa4ppiC+SnMcz27db
	 MsBv5zDAOZZY27oFUKAbXKs5tZ05gWdTGXxflsdAgI2samudHWlgPOb82pWInJUvp1On/
	 99YZavemtAAxVADgTWsSK7VLJ90Oyfw2lusZEQ2srY/wf0IDTtKBqQMq52B01emHQ4DIj
	 pms+QBNJziVWBP6TyufebScRBwWbULdkZQhnkmXSEjBJQFPM85d5TyY65UKSoiyqaBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296960;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=WdS/UgEclw3l5aiC4gRQNtGbtd+G8xteBE4h1WWs7g8N/9UPRlfOm1rX2fOM5A1zXQ4A
	 RB7lgXsljuQBDY09c71FggJ4YxdQegj/y5IalzwvQywUI3MJIy1eovvrVdsNkXittFamV
	 zLKkD6oXpPxdQYl1TvOC2VpVwHw4HWLjmbR3sbC8q/Nan7wbnZwkvZ77TMJ3NEvJZp8WY
	 cN529TOjfyf5J0S8e8nEFqLj3Xl/nePtTcb9G8XxOwRtPg/VQgZUxazmpaXa4HQ2qBYgG
	 0eqHM5zaX5pbuO1Sw2PlHacjHWg9/OHgcTkc6Ye/2tEv4YBTGjoM1jxlcdEXEAgHT+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 12E7E1F000CA;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296960;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aYmicm12+lYvbdJ0MPJGUjoOaFtO8vhOAiETO9tkP0Yxy7JxWH3g4PU0IHKXMR0Ix
	 qP8/pKqHPrQyolKSLQPf9qCAZ7rQRagmbNfomy5JjPxg15KuW26TRv4h5CpRyXvuDZ
	 UsUYA4X0eu18v8t1A2rbTQiRyL72sPiwrXqQkdreugF1OfBAL35PLOzIWebvGh/vfj
	 CAHmplg99NKK1OXyx/SorQ2R7CnnriLjAsDIiSoyTJvlWTxHgMOgMshlKm3jwR/ftt
	 WVqR1fM0e7u1B1I9nb4aVb0nOnEaU+dJmZubgRynzDIKyVD5PR6EqYnzubpNWJLDsY
	 FcnyzGQM3jnIw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9415E4BDF1;
	Sat, 21 Nov 2026 21:35:59 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:47 +0300
Subject: [PATCH v9 02/10] dt-bindings: arm: Add Cortina Systems CS7542 and
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
Message-Id: <20261122-b4-cs75xx-v9-2-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=1646;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=ur5Y90DJUCyqB+ubnyEmmsptLVPvVwYRa4Bevb+7QSg=;
 b=Z2vBiAMUHknExlzA/PRjJFmk8HT5qsuEPNQ6oXY0lQYko0o1V2Tp+gayf8LFE+n2XmAytUWnf
 7O48VkrAPZWB9P1VO8RBe42pYcA5WmS/5shKkb1D2PA4XT7EiifQ01Z
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


