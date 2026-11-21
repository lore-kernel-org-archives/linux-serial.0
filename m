Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296963;
	b=ZnusIsVs51r0c0E8WxX+vD4JEzPRDzUB300s6Eg6U7HAL392e31gzwYaMyE80jRG2N8/
	 /FWIvYyaK92FV9uEQmG8TB0H/xdWcOHSa7rS2PryWu/KQIsh0nqM+ZwPUg+IqVGaKnWSX
	 XbYLudHzTx6HprTxOEmezRSlEdwwqp7qaY+Oz8xPE2NTX1/70WWSdIUvXeJp4VxriLmc0
	 UEnn5bL8+uI14NqUlIN5zShQR5Wgp5/YBhWvkuuLCHHbYSAwjU48zjGBhag0N8tyewiFW
	 i2oO+ee6/8jDx58VrZUeXzTfMXTFLmNHIJy2Ke7NIyomtFqkij9TpTQMHgN/gDvWeuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296963;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WZVIFiJUDu2/Fg3EPA3lEzUb/a4f/sw98rZcKXqawYM=;
	b=5R1UwdOIJiobGaJ1X28Zk2D2FgJmKHbpffGFvg2gy+NQ9q/HVCGNZJ1uIEpSadSliR3Q
	 LbJbOcjwwm8qCp92I6oWJIatF/ac3buBFP5Lm3jXmrMF6foSoggi8kuMnIZYBDJYTgIMP
	 EjYSdDGBoWskAgV80ZM1FSik53Rl9W3VjoJykDasNfT9Idswpx6vK13aEtamLY9gQuZ7f
	 xELXolRkDhTx+MZKrWPKde9tXiBFwvd9eRRFeS+oJvcN1KNbYQ0dcQUjXkeuDSOpp+qUT
	 jfImg9C4K1s7Lotp9llZGAPDMaJtT79t9wNc8t2scD2s7tq2LYWUmhwaES9QJuTpJpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGNflnUw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA2606A699;
	Sat, 21 Nov 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGNflnUw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296963;
	b=KOBIIFv/vRVd28m86e57epFb8LmMGdAcq2qehXnXGxUMyBq34P74nObglhghqLpNmWqM
	 RHFbs9CtUNLYLP+Zu2s20CBLv77K5pGr1drAB6mZVCq6+IfrKMG9QU7L1f3WP0zWB0DA6
	 CmziXyvl4x1ObhMxzopNjq8FtUKxfLc1mfrW1SAnz90Cl+cTHwYO736BOLrMKmG1WRet+
	 oHp2SOpzgp/iCQe3mTcpIO7KCVh1+FGFIAfUaiD8AqgCtMsXjGvRF9ddQCGwbKcqIwyFZ
	 uvp4jbQFxKNgecVSLh+bLhHxlKbMBR5ImDh1mQQBpwlFSxDteSQX8T8SjkP/pACpj9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WZVIFiJUDu2/Fg3EPA3lEzUb/a4f/sw98rZcKXqawYM=;
	b=22ij5gobq9TnSf+N3wfgyt2JjqR/SbkXRjzOQbQhZhOgzsTuROmUqxkjfxftHAtVJ1z9
	 KyUnzm6Zke8GXbUo69bSbtJCMwIxWSs5O3S5960TfXlKhb5VfHlZt4u4p2DJlJD25fNuf
	 CoBS/fnzkYSKNxSzO/GQ/1J2/J00KSXkEO5jatU+nw0FXx2SyGFIFYfBSnc3H3hYR7Y9m
	 xXpDmyHopbDcUmfvPXYAlHXUjplwhbreZNhjauMaK36jbcCB6jXYP0+tBRFpi9+rGRwyL
	 38JKGeXDmeCu/kFvmN66ATW80CCfn0JMIpGRCTRMCOGungC8eumqfi8j4bWubOtRqLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 590811F000CA;
	Sat, 21 Nov 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296963;
	bh=WZVIFiJUDu2/Fg3EPA3lEzUb/a4f/sw98rZcKXqawYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZGNflnUwbE6xqmdZE4U7L3r2y8mHRB763TMPyknX8mfV4K3mHhPogkFGY7erJ5RTD
	 jnLiSqTYmXEfz2LfEJtcfKl3k1HUG+MQCY2GrHX8qcX6UbmSRO1EGj0gafVul1Sa2G
	 8HcISfxkK4gIBhMdM15ytZ08bYSVgSQb/jMSiEyjF4HSufc+bZTMp/pNBjNgWHzGwf
	 TNXYH2WQZafmVaZQU+vpcQ5BmDDDsWYD9N3/RqMy+P9HjxO+R7HVGXZulUfZ76PvLZ
	 xr1W6F+GgdGKfwRmFZR7M9hlPtF8LM3zINJfXyUPGnviRHfTnWnAxA0QdMxq1L3Qpg
	 gKEwJLDDOX83A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0C2C24BE01;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:51 +0300
Subject: [PATCH v9 06/10] dt-bindings: serial: Add Cortina Systems CS7542
 UART
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
Message-Id: <20261122-b4-cs75xx-v9-6-1fc1b90bd097@gmail.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=2007;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=zTU7TdprhBB5oPgA4d7D2ACpTGMQAb+yACsbn1DZcmY=;
 b=p3aLfZRKQtlY6rQSevp2fIFA7aYp/G3pwWWVe/6fbfXbENMdr6fm0b43mO/YgOZ/xJgpWlEeB
 gY4+EkbmTicC2klt6J/jJ5kEoqViNTqpIwvAsOg7PBjgjVYX200GzBc
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add the binding for the UART found in the Cortina Systems CS75xx
(Goldengate G2) SoCs such as the CS7542.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/serial/cortina,cs7542-uart.yaml       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
new file mode 100644
index 000000000..62f80d722
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cortina,cs7542-uart.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cortina,cs7542-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina UART
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description:
+  The UART found in the Cortina Systems CS7542 (Goldengate G2) SoC. It has
+  transmit and receive FIFOs and a 24-bit baud rate divider running from the
+  peripheral (APB) clock. Other SoCs with the same block, the rest of the
+  CS75xx family and the Cortina Access parts, are to be added with their own
+  compatible string and "cortina,cs7542-uart" as the fallback.
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-uart
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@f0070110 {
+        compatible = "cortina,cs7542-uart";
+        reg = <0xf0070110 0x30>;
+        clocks = <&apb_clk>;
+        interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+    };

-- 
2.53.0


