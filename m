Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663670;
	b=l8jOy9qFc/0hHlM7Bv/bIsVIi5wVNSsnppupXwWyjpiiCSmuHEQRWtpxTW8nt8WGoYMV
	 GDLJvrh3J42t5yAu9GtXQQ2UQ091hvG6jJNF0bhfAU5frJIid1AKdGhpQvlZXz3gDxnjz
	 4eOi9ciMgPjl68HaXsM/8Sy9AqbvsUclZrCzlyYi7Pvn9WvPbeSBVAvE/x/B7Rb/Umvx+
	 32PQTGYIyhf9JyevPdxA8JYU2schoEP5d9ZKDfWcfFtW0r+uRHi/QO4xe+9vguAxXtGzx
	 N0/g1myfu9PKHCZ0/DjS5ANypuERGYZbDPJ/P1UOeQmMODz+EFwUgk7tDFafhiOoUYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663670;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=FPpzICsJGF+owznHnoMyWwMMXK1zBPrRjHaF3aZt1a11hcpzMrhYyJ9LtrcF212NawgN
	 MWVjITrEpAH+T5UGhoQLvVTw1xui30kaCNdcdycuY+HUB4te/IprQcL8JPBwcuSmS334r
	 GK2YcIgKA2IYCe84Zo3fUrCbYujml3F3I0jUOHjVOguPES/+aptnSgWJ33oZufsMbTp+E
	 agekwXf2bUf9rSbsCOlVe1a8ShTdiSabS3xvIjnuT/gxPRn0jYTM1x+BzYFyxGRVnG58i
	 VeofYaTqgX4qWYbj7IhjjrnDMMcrc2TKLnixD91bln3CcnF8NuXNimug/p6byWmj4Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj+FwcR8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AE606A33B;
	Sat, 14 Nov 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bj+FwcR8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663670;
	b=IPNJrC8KApvSd2/E2/U/GmDEfObB4IFAKPoPxupsRG681mFyBAxyf6Ax7reIvdOgyYNx
	 mqJg+x1r8eK8aQjjZ+2/eLrKdj0RXE3NBnFKtZXIz92mHZ7IZN+89gobLWeAdAd7wBdwM
	 M4I0Qr6kBTAshEiJAMmQrfk6S/3orkhFEhq1Edq7/sgKZbJ4ux6V05GgeQRwU8Wtjg6Lw
	 drPkJuPUOFB7WHP88sBeYrB2H7YiAjIYYp9AZ+NftNUavuLNk8qYuk3K2CN87LItqUgWW
	 I30cp0X8wV6AVO2GazX49shgw8Jc26XWfDc53UGTKdvJQ63VhfpYfU8DWEVymjiCSwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663670;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	b=zD0AyG+U5821+7WklTZukqL0nKVOf0bQeGg/DtjUZx3LBgCr+N6zNBgYhC+TIJ3q0O3X
	 shr6P6ZcXtF9zD/Kfq0CsO4pRTvUvS5KLKm3+71znio2nZVM4FUhk9hCNYhGBn7oiXZMc
	 68QYYHM+VD8a5A6JBdXj5/hVKAEsKfOvAS15ueujVmGUydGziWgq6xVEr365kphxeGVL+
	 1L5Q9OLqw6rLOHqx58Z5N04LoyiG3ybXJLNfFehbC1mrPr3a2uWQt4hHUG3nbpTyVg+tQ
	 FBmBG/1QORb6F+abeslcVpSAAspHpcjWLWzkVRCWKqyVTIqgw/4Vrw3g0ixL7N8qlrA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A83DC1F000C9;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663670;
	bh=Gvf3IdDLDeRNj9nlhALrJ/CcwWCiWPj0Ri5V51Dn7x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Bj+FwcR8o1xmxZdTU0junoaTXJAycT6PbhyS2fEIKM3dNOuFy11Aqi0XbXqMsEsll
	 qr9GPuKAA+LFvYnjNuJTilmTNSOnL05kRDg1vrSXs8vDtNX6INMdFvdDHc5XbTFpTe
	 Glnrt4R0O9OibzDYxXjpqYq/GmSK7qiiUekcB8o4Y1Q8IZLCRQuihLdxmB8TMkrd03
	 2M2lZd0pJYlYJkjP0GLdPUJarZLshBPBZCGJq5Pei7yzwyHK1vf86RvPnGJaFOG+vB
	 /Wf2J1Lugn4fhGQyAQcDpj0r84RYwiCWaMwo57R7E04yPTZw/ddCu6FGinToBYBRsO
	 1vQ+kCGBIGzgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3490F49DC2;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:07 +0300
Subject: [PATCH v7 02/10] dt-bindings: arm: Add Cortina Systems CS7542 and
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
Message-Id: <20261114-b4-cs75xx-v7-2-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=1646;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=ur5Y90DJUCyqB+ubnyEmmsptLVPvVwYRa4Bevb+7QSg=;
 b=U44ImN/w2QemyTtzTHNDHUp4VJhfXoXKy0TDTMjblJAkp5zeWE5YZFQkFyski+x+z3YL6/prj
 AJlEO7zOko9CIzrBvcTyqkJO9LhDYwU5w0EltC1ri55PjI2jxLYPrU8
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


