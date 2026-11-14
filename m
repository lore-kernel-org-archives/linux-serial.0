Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663672;
	b=5sC8264NFnVo1iZVwoVDTMlCENfIVumHRC/tXiy9Zj5aGFDt7ZVrojOas9bfzEWIPjRp
	 OEY/VvV/7L3hUW6UVxqa21c+41ZUZohsfuLIBD2jzLiBnHPPGZdJ37WInOmUf+CyfBGdG
	 AfcnoDBesKyqk1bAEFsJVD0bUKvBm/Bk5et4rYm5zbr2BM2/0k1uyySBwZ3AOkuVTUHub
	 8ld2iZeYJms7hVVNxU6PvfgHrgk7GOYyMYEAZhpe2oxV6xZ/hcWznIDUCMVxR/ZHlpjZW
	 EkDK6bFymsHT1tGzrdcokFPipEMcA4VKgVRaVp5VIozVwaP/rGT2QBME67kJar7GUGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663672;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZogHg7F2r1KKspZv8agum3WlkUtYxRkISXz130hGnsM=;
	b=mDaMG3LQtfR+kV6NR2mPVGBrQnFGfs3ja3JK4UN6KCmzH8lJt+TWyi3bnBheaoG1iu69
	 /RP+kSvzo3EYtg26JnNtAAQTd3Npa/w2CzdfOrpynZRmhBl2jPnoZlDQM7f3mfFiBl96o
	 F0TppyxMo8l5lNBkgX6j/zUdVevdOlvR22IU4dMw1B4ncwSLQWSLbMEnxAQ4AkDvBM0g3
	 R0QDsFSnnROlt0zlTxZXw2owTyaObsv5aXCgj3IEtAuTKuVKdCZ5d2iMxNVPcGnGxdCw9
	 6wObkpLyxNH7wBVtZRPmIb0gA6FaoXNi/EdWhQaC2iFlX0IWxbKd7XLGdyENfzqJ+SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwksd7F4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84F606A337;
	Sat, 14 Nov 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwksd7F4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663672;
	b=gS4FrVQ+MuyHeDkvDiSuhtuNjadI5X5DfyMd+69uKOGCcTQPYu5ZJTSUMIQUoAegA7au
	 DZel8+fchBnXu3SV09ZVoCW/Z6SiM8tOljhxrqMkz23nH8Kocsk8+WVUECbnNzGefOynw
	 Zw3flwG3PTo4mn76eP9/v51Psa3X5tGsj8UaY7VcA8p0AE22PtZEdyhDBa/pyrdasVRKC
	 QfqQ1D9DHYy9ldb0EpeuUtkNCk9m2U0FDyvC0LnzkBDpNh1vCgPx8aTWI7+2GKQC5QIe8
	 rpVDfI3AW/p/ReIhWLBXZn+NeoORGqbdmLAz04yeGFFJKOHe8lvzwIx1WoVeoxvn7uA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663672;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZogHg7F2r1KKspZv8agum3WlkUtYxRkISXz130hGnsM=;
	b=w0CJgRylVXHanLa//h6Hsa2mJvAgajNBmWqAhrZvAYQNUMebTZkPmNd3Vb7giYoeStae
	 4aebim+NmxcuauTl6fNgN5xvqv3JQmQC3viy+vwbOcVdFgk7c6cKa1goNrKVuKePAuYVw
	 KaZMr2rIGw+ktOE3qaVnaW2ALP7O4yIAutk66e+66FJLFmeYb0ONQD5/sdj+kJnjbbHqM
	 eAwpD+/xR/UkVG8kDgi5VHJq21pIM4KVj6h+674aPRr1pWEhrbfNkQiq/vf8Zze8oY4kQ
	 hfSKswwbrZX2dDZxtD78Pi9lZvSKR/2+e15/ctlJOuwSGirnWD64PR+lcd8fs4H/g9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D0BB41F000D4;
	Sat, 14 Nov 2026 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663672;
	bh=ZogHg7F2r1KKspZv8agum3WlkUtYxRkISXz130hGnsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hwksd7F4cfbIOIFVVqbbbRmblJSabZ+5urjSbTVl8fjTSHm8S+BkLy2GSs6upJwWg
	 bz+dt9M1BQJnSWu+vGvHjCUaQ5wpfwh+9JtsFmf4AX0JH0fQjU7i6TDlAjnPC+nBEc
	 pQ1/WJ7hr0Q0dxo3vjqaOR0kfJv55206IwC3ASW0lTq+x8ktgmelJNdLSuGYVYsfAC
	 p4FLZ30rEyB5hFVC8wjGwpkTRd+ByiyWg9e/4E4jqWjwxrQwhOIMTPfkC1xjfObz5F
	 fIxg3ynqi7HQO44OvaBbtjEuOHBGngTkIrxyZ5BJsIW7MQFq96kkfdJZCW09FFBO2+
	 jY34X7T51qJ8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 88D9B49DD2;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:11 +0300
Subject: [PATCH v7 06/10] dt-bindings: serial: Add Cortina Systems CS7542
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
Message-Id: <20261114-b4-cs75xx-v7-6-8f17f38821b4@gmail.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=2007;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=4OEni5PfKeJ3reVZQoQVj435vRxLkT5dV42lrfoFdbA=;
 b=ZVWYjbNLSMmz22q4aHwiNy0+RQR9MYiL1iFv+uzgICmrN3fcg5q1OtoBr4zURwqQir1LQu3pJ
 QywaoRMn26RC6NtU9wcykTZheboe0YisQk5kT97vfzHxHbb7hWyIZ76
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
index 000000000..2879a7188
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
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
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
+        interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&apb_clk>;
+    };

-- 
2.53.0


