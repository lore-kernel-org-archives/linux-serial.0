Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648714;
	b=qRKOKDCm5VcsVHQgZ3QjmzUZu7+eIluCyiU3wnqW8KfFp+6uIxBgDd/wRrz3xIX7//G1
	 LZq1GrcxyV5XQKM1FZu8RRrkf7MrPqOcjCNc8YBUKvRudoIDuyy1ZfVG6gI9899At7pBI
	 +21G6xquJyGW8692AZMrfjwbKzoO0+NRF/mynXO0myWSrJH6uM6I+nScfs4KdM9p9KqhV
	 kUyuuzU4RcyyyPPt5ACLMj47paeFie05/EBPYJnp+nfvfGr7vOgriO1SgJRc4HLCAQT1h
	 YEfbVCNQJsyBTtPUd9Txu8iqM8sC45VYkwC2g59Zx1PX+z0vxKQiYSRegDRQdiRbDTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648714;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2skKssvMl7NrG/EIFxQTg5In1tC5JMHyWGqJ1c52uyI=;
	b=fJSa6x6ppIXIpZuepexgL4lVF9dF5gpBG8EBBvZpNYfE2ttbqdUEi3Nst6VMrsPO1hQE
	 v7+nX7latPwmxiycSFmDTIWWWRynBBXiELITLrkTqLatIj479E/Z05xR97v1AdTVbnNJw
	 pEqXljAXLHj8jaqT0wdCZN5PfCxxz7wn8CfP3azzuIEJtXAlUNOEtgkyZzA0LOV/IvhRt
	 hTQ4okNjAem67u0XwHSieeTru8aRg9+vHpjO/kdRGAVTHzf3Jm1MinqYMlxs7550mugtI
	 1/t8fRZEcvgb+zGQ29yyVODR88RRsO1tOqNUba3Bx53A4ZWsnYAI/5qGY+NtxJWp5hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH3Q2rpB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC1606EE80;
	Mon,  2 Nov 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EH3Q2rpB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793648713;
	b=sDw2f1cF1aagBONm5vhjndWF7iueeeRFJE7AfQWBAruYI+4xwFehhujyjowi8wkWsu6S
	 +IRNXt9k+TrHFqJexfzsERGDXC5yBH+oec++ZS9vlfCawFMylLo+n8f4L1wsxyIgTRlIP
	 dw1KRaZokd7+CuftWLIb6MXCaNwF1AGvp0bucEn7xLPBlxaUatERc6YqEb76V5UCewGEP
	 MWBEeBDJuWkv79OWiDHTZ3IY88VyMJlHwuuS4ZVLsCIT/5qNrFdzqUA1zH2pSjCn6KrZI
	 EsqFjRwSwD3KjiV1NtV3JavTZSQauyuaruhh1jIhQWpTQJPt3yM3DSsXFNOwFr5rpFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793648713;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2skKssvMl7NrG/EIFxQTg5In1tC5JMHyWGqJ1c52uyI=;
	b=H4GnM+hW02wAOxg0MgXdDGN3KzhbGpNucpQMd4x8Ik1g3ReqlXMbKWNDVblehqt9dyYQ
	 kCk0pUQtZe7VTOuO2iqAKsRsEUkYsW9VdPLr2QXXoAbKJELJYl5oiNQH3KRiNZtsns8Ma
	 NHzfDzquNg5L7eYg2ysobhM2n04oyQRTlWoppsNyp2x9LYsggmOadKPOvxRq0AP1FmoPu
	 p04G524D2b7/O8ky/8Swol8GvJDYMZA1g1p6Yb4EgbLO1gG4tpz3f3Bv27oz3pfRaQKFm
	 QszIJyNpWVXcrRReCqNM8BU+0//lVnEaU6gsBHxbpWNyVF4RV4+xLFMP+rzw5YzpI4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15FE11F00A1D;
	Mon,  2 Nov 2026 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648713;
	bh=2skKssvMl7NrG/EIFxQTg5In1tC5JMHyWGqJ1c52uyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EH3Q2rpBgrh8OKuqCSJVGVrDZeGvO82NbyyyFsXJ/Mr3pNZHPxFi3XZBtGtTw/H7J
	 w1/Qm2Nkgu/wex+AD06UYDY+9hQ/yRKcfeVAaSdCrUQhjod0ubVLUmM5j/cho4En26
	 saeh2OlGUijb2iB2lSHkW1x1lR1Wrtd8m7XO+zx+71PHPzs4aWgl83yjUPsTtlViv5
	 3ZuZivdxFYl9IHdM9b4ftTpjM6nX3TT2vrvyrAMIRpaeOLmj222FWY0Ukr6VToetxM
	 2lwUVfZgfUrlkajMR2VKF7suVIDF83h7cyeRbP/Z8ond4uDLYJNlhIoE04BykIYe3x
	 g+594D6zfY2zg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0932546619;
	Mon,  2 Nov 2026 19:45:09 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 03 Nov 2026 03:45:09 +0800
Subject: [PATCH RFC v3 06/17] dt-bindings: pinctrl: add Zhihe A210 pin
 controller
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-a210-scmi-v3-6-ee6b31580808@iscas.ac.cn>
References: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
In-Reply-To: <20261103-a210-scmi-v3-0-ee6b31580808@iscas.ac.cn>
To: Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org, 
 linux-serial@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793648705; l=5149;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=ViPTWWQQeexsnyAa+LU8olyP5is0pfShY5chI2/PszU=;
 b=BUGfjsDUMGXJ2Xsl51TLYgelij2NnYdnV7+1jqBYXjvnS9TJfLhs32lM54YtvZYZw9lZI3FfS
 kRmBjNho0QBARTjyq1+DvWmWrg62TTXpZJKnuFH9TXcD2UGfrsUCdNY
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn

From: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>

Add a binding for the AON, PERI1 and PERI2 pad controllers of the Zhihe
A210. Every pad is muxed and configured on its own. Functions of the same
kind share one name unless a pad can select more than one instance of
them, as with the UARTs.

Signed-off-by: Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 .../bindings/pinctrl/zhihe,a210-pinctrl.yaml       | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
new file mode 100644
index 000000000000..96c46b59d147
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/zhihe,a210-pinctrl.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/zhihe,a210-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Zhihe A210 pin controller
+
+maintainers:
+  - Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>
+
+description: |
+  Pinmux and pinconf controller of the Zhihe A210 RISC-V SoC.
+
+  Most pads of the A210 are split into three groups, each managed by its
+  own pad controller with a separate register range:
+
+    AON pad controller   -> zhihe,a210-aon-pinctrl
+    Peripheral 1 pads    -> zhihe,a210-peri1-pinctrl
+    Peripheral 2 pads    -> zhihe,a210-peri2-pinctrl
+
+  Each pad can be muxed individually to up to 8 different functions,
+  though for most pads only a few of those settings are valid. A few pads
+  in the AON group do not support muxing or configuration at all.
+
+  The pads support configurable drive strength, bias, input enable,
+  Schmitt trigger and slew rate.
+
+properties:
+  compatible:
+    enum:
+      - zhihe,a210-aon-pinctrl
+      - zhihe,a210-peri1-pinctrl
+      - zhihe,a210-peri2-pinctrl
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pclk
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+
+    description:
+      A pinmux group referenced by a consumer's pinctrl phandle. It
+      contains one subnode per set of pads sharing the same pinmux and
+      pinconf settings.
+
+    additionalProperties: false
+
+    patternProperties:
+      '-pins$':
+        type: object
+        $ref: /schemas/pinctrl/pincfg-node.yaml#
+
+        description:
+          A pinctrl node describing the pinmux and pinconf settings of
+          one or more pads.
+
+        properties:
+          pins:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
+            description: List of pads that properties in the node apply to.
+
+          function:
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/function
+            enum: [ aouart, aouart_ir, aogpio, aoi2c, aospi, jtag, reset,
+                    por, pmic, dvs, uart0, uart1, uart2, uart3, uart4,
+                    uart5, uart6, uart7, uart8, uart9, uart_ir, gpio,
+                    gmac0, gmac1, spi, qspi, pwm, can, i2s0, i2s1, i2s2,
+                    i2s3, i2c0, i2c1, i2c2, i2c3, i2c4, i2c5, i2c6, i2c7,
+                    i2c7_smb, sdio, isp0, dptx, usb31, sata, hdmi, zmac,
+                    bsel, dbgm, cdbg, pdm, tdm, pcie, sen_vclk ]
+            description: |
+              The mux function to select for the given pins. Functions of
+              the same kind share one name, such as spi or pwm, unless a
+              pad can select more than one instance. For example GPIO0_16
+              selects UART0 or UART1, so the UARTs are named uart0 to
+              uart9.
+
+          bias-disable: true
+
+          bias-pull-up: true
+
+          bias-pull-down: true
+
+          drive-strength:
+            minimum: 1
+            maximum: 25
+            description:
+              Drive strength in mA. The pads support 1, 2, 3, 5, 7, 8, 10,
+              12, 13, 15, 16, 18, 20, 21, 23 and 25 mA. Other values select
+              the next higher strength.
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+          slew-rate:
+            maximum: 1
+
+        required:
+          - pins
+
+        additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl@2026000 {
+        compatible = "zhihe,a210-peri1-pinctrl";
+        reg = <0x2026000 0x1000>;
+        clocks = <&clk 0>;
+        clock-names = "pclk";
+
+        gmac0-0 {
+            gmac0-pins {
+                pins = "GPIO0_0", "GPIO0_12";
+                function = "gmac0";
+                bias-disable;
+                drive-strength = <13>;
+                input-disable;
+                input-schmitt-disable;
+                slew-rate = <0>;
+            };
+        };
+    };

-- 
2.55.0


