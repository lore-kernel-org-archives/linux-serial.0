Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7637C4332D
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1DA20773
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCTRlv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:51 -0400
Received: from v6.sk ([167.172.42.174]:51980 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgCTRlu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:50 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 87B5C61094;
        Fri, 20 Mar 2020 17:41:47 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 10/10] dt-bindings: serial: Convert 8250 to json-schema
Date:   Fri, 20 Mar 2020 18:41:07 +0100
Message-Id: <20200320174107.29406-11-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some fixes were done during the conversion:

Slightly better examples. The original example was for an OMAP serial
port, which is not even described by this binding, but by
omap_serial.txt instead.

Added compatible strings, that were used, byt not documented:
andestech,uart16550, cavium,octeon-3860-uart, fsl,16550-FIFO64,
nvidia,tegra186-uart, nvidia,tegra194-uart, nxp,lpc1850-uart,
opencores,uart16550-rtlsvn105, ralink,mt7620a-uart, ralink,rt3052-uart,
ralink,rt3883-uart and xlnx,xps-uart16550-2.00.b.

Removed "serial" compatible string. It's redundant with the node name
(which, in OFW, serves the same purpose as the compatible string).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/serial/8250.txt       | 102 --------
 .../devicetree/bindings/serial/8250.yaml      | 246 ++++++++++++++++++
 2 files changed, 246 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/8250.txt
 create mode 100644 Documentation/devicetree/bindings/serial/8250.yaml

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
deleted file mode 100644
index a543702859e2f..0000000000000
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ /dev/null
@@ -1,102 +0,0 @@
-* UART (Universal Asynchronous Receiver/Transmitter)
-
-Required properties:
-- compatible : one of:
-	- "ns8250"
-	- "ns16450"
-	- "ns16550a"
-	- "ns16550"
-	- "ns16750"
-	- "ns16850"
-	- For Tegra20, must contain "nvidia,tegra20-uart"
-	- For other Tegra, must contain '"nvidia,<chip>-uart",
-	  "nvidia,tegra20-uart"' where <chip> is tegra30, tegra114, tegra124,
-	  tegra132, or tegra210.
-	- "nxp,lpc3220-uart"
-	- "ralink,rt2880-uart"
-	- For MediaTek BTIF, must contain '"mediatek,<chip>-btif",
-	  "mediatek,mtk-btif"' where <chip> is mt7622, mt7623.
-	- "altr,16550-FIFO32"
-	- "altr,16550-FIFO64"
-	- "altr,16550-FIFO128"
-	- "fsl,16550-FIFO64"
-	- "fsl,ns16550"
-	- "intel,xscale-uart"
-	- "ti,da830-uart"
-	- "aspeed,ast2400-vuart"
-	- "aspeed,ast2500-vuart"
-	- "nuvoton,npcm750-uart"
-	- "mrvl,mmp-uart"
-	- "mrvl,pxa-uart"
-	- "serial" if the port type is unknown.
-- reg : offset and length of the register set for the device.
-- interrupts : should contain uart interrupt.
-- clock-frequency : the input clock frequency for the UART
-	 or
-  clocks phandle to refer to the clk used as per Documentation/devicetree
-  /bindings/clock/clock-bindings.txt
-
-Optional properties:
-- current-speed : the current active speed of the UART.
-- reg-offset : offset to apply to the mapbase from the start of the registers.
-- reg-shift : quantity to shift the register offsets by.
-- reg-io-width : the size (in bytes) of the IO accesses that should be
-  performed on the device.  There are some systems that require 32-bit
-  accesses to the UART (e.g. TI davinci).
-- used-by-rtas : set to indicate that the port is in use by the OpenFirmware
-  RTAS and should not be registered.
-- no-loopback-test: set to indicate that the port does not implements loopback
-  test mode
-- fifo-size: the fifo size of the UART.
-- auto-flow-control: one way to enable automatic flow control support. The
-  driver is allowed to detect support for the capability even without this
-  property.
-- tx-threshold: Specify the TX FIFO low water indication for parts with
-  programmable TX FIFO thresholds.
-- resets : phandle + reset specifier pairs
-- overrun-throttle-ms : how long to pause uart rx when input overrun is encountered.
-- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
-  line respectively. It will use specified GPIO instead of the peripheral
-  function pin for the UART feature. If unsure, don't specify this property.
-- aspeed,sirq-polarity-sense: Only applicable to aspeed,ast2500-vuart.
-  phandle to aspeed,ast2500-scu compatible syscon alongside register offset
-  and bit number to identify how the SIRQ polarity should be configured.
-  One possible data source is the LPC/eSPI mode bit.
-  Example: aspeed,sirq-polarity-sense = <&syscon 0x70 25>
-
-Note:
-* fsl,ns16550:
-  ------------
-  Freescale DUART is very similar to the PC16552D (and to a
-  pair of NS16550A), albeit with some nonstandard behavior such as
-  erratum A-004737 (relating to incorrect BRK handling).
-
-  Represents a single port that is compatible with the DUART found
-  on many Freescale chips (examples include mpc8349, mpc8548,
-  mpc8641d, p4080 and ls2085a).
-
-Example:
-
-	uart@80230000 {
-		compatible = "ns8250";
-		reg = <0x80230000 0x100>;
-		clock-frequency = <3686400>;
-		interrupts = <10>;
-		reg-shift = <2>;
-	};
-
-Example for OMAP UART using GPIO-based modem control signals:
-
-	uart4: serial@49042000 {
-		compatible = "ti,omap3-uart";
-		reg = <0x49042000 0x400>;
-		interrupts = <80>;
-		ti,hwmods = "uart4";
-		clock-frequency = <48000000>;
-		cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
-		rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
-		dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
-		dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
-		dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
-		rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
new file mode 100644
index 0000000000000..88192f94385b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -0,0 +1,246 @@
+# Copyright 2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UART (Universal Asynchronous Receiver/Transmitter) bindings
+
+maintainers:
+  - devicetree@vger.kernel.org
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+  - if:
+      not:
+        required:
+          - clock-frequency
+    then:
+      required:
+        - clocks
+  - if:
+      not:
+        required:
+          - clocks
+    then:
+      required:
+        - clock-frequency
+  - if:
+      required:
+        - aspeed,sirq-polarity-sense
+    then:
+      properties:
+        compatible:
+          const: aspeed,ast2500-vuart
+  - if:
+      properties:
+        compatible:
+          const: mrvl,mmp-uart
+    then:
+      properties:
+        reg-shift:
+          const: 2
+      required:
+        - reg-shift
+
+properties:
+  compatible:
+    oneOf:
+      - const: ns8250
+      - const: ns16450
+      - const: ns16550
+      - const: ns16550a
+      - const: ns16850
+      - const: aspeed,ast2400-vuart
+      - const: aspeed,ast2500-vuart
+      - const: intel,xscale-uart
+      - const: mrvl,pxa-uart
+      - const: nuvoton,npcm750-uart
+      - const: nvidia,tegra20-uart
+      - const: nxp,lpc3220-uart
+      - items:
+          - enum:
+              - altr,16550-FIFO32
+              - altr,16550-FIFO64
+              - altr,16550-FIFO128
+              - fsl,16550-FIFO64
+              - fsl,ns16550
+              - andestech,uart16550
+              - nxp,lpc1850-uart
+              - opencores,uart16550-rtlsvn105
+              - ti,da830-uart
+          - const: ns16550a
+      - items:
+          - enum:
+              - ns16750
+              - cavium,octeon-3860-uart
+              - xlnx,xps-uart16550-2.00.b
+              - ralink,rt2880-uart
+          - const: ns16550
+      - items:
+          - enum:
+            - ralink,mt7620a-uart
+            - ralink,rt3052-uart
+            - ralink,rt3883-uart
+          - const: ralink,rt2880-uart
+          - const: ns16550
+      - items:
+          - enum:
+              - mediatek,mt7622-btif
+              - mediatek,mt7623-btif
+          - const: mediatek,mtk-btif
+      - items:
+          - enum:
+              - mediatek,mt7622-btif
+              - mediatek,mt7623-btif
+          - const: mediatek,mtk-btif
+      - items:
+          - const: mrvl,mmp-uart
+          - const: intel,xscale-uart
+      - items:
+          - enum:
+              - nvidia,tegra30-uart
+              - nvidia,tegra114-uart
+              - nvidia,tegra124-uart
+              - nvidia,tegra186-uart
+              - nvidia,tegra194-uart
+              - nvidia,tegra210-uart
+          - const: nvidia,tegra20-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency: true
+
+  clocks:
+    maxItems: 1
+
+  current-speed:
+    description: The current active speed of the UART.
+
+  reg-offset:
+    description: |
+      Offset to apply to the mapbase from the start of the registers.
+
+  reg-shift:
+    description: Quantity to shift the register offsets by.
+
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed on the
+      device. There are some systems that require 32-bit accesses to the
+      UART (e.g. TI davinci).
+
+  used-by-rtas:
+    description: |
+      Set to indicate that the port is in use by the OpenFirmware RTAS and
+      should not be registered.
+
+  no-loopback-test:
+    description: |
+      Set to indicate that the port does not implements loopback test mode.
+
+  fifo-size:
+    description: The fifo size of the UART.
+
+  auto-flow-control:
+    description: |
+      One way to enable automatic flow control support. The driver is
+      allowed to detect support for the capability even without this
+      property.
+
+  tx-threshold:
+    description: |
+      Specify the TX FIFO low water indication for parts with programmable
+      TX FIFO thresholds.
+
+  resets:
+    description: Phandle + reset specifier pairs
+
+  overrun-throttle-ms:
+    description: |
+      How long to pause uart rx when input overrun is encountered.
+
+  rts-gpios:
+    description: |
+      Specify a GPIO for RTS line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  cts-gpios:
+    description: |
+      Specify a GPIO for CTS line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  dtr-gpios:
+    description: |
+      Specify a GPIO for DTR line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  dsr-gpios:
+    description: |
+      Specify a GPIO for DSR line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  rng-gpios:
+    description: |
+      Specify a GPIO for RNG line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  dcd-gpios:
+    description: |
+      Specify a GPIO for DCD line to be used instead of the peripheral
+      function pin for the UART feature.
+
+  aspeed,sirq-polarity-sense:
+    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    description: |
+      Phandle to aspeed,ast2500-scu compatible syscon alongside register
+      offset and bit number to identify how the SIRQ polarity should be
+      configured. One possible data source is the LPC/eSPI mode bit. Only
+      applicable to aspeed,ast2500-vuart.
+
+required:
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@80230000 {
+        compatible = "ns8250";
+        reg = <0x80230000 0x100>;
+        interrupts = <10>;
+        reg-shift = <2>;
+        clock-frequency = <48000000>;
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial@49042000 {
+        compatible = "andestech,uart16550", "ns16550a";
+        reg = <0x49042000 0x400>;
+        interrupts = <80>;
+        clock-frequency = <48000000>;
+        cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+        rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+        dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+        dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+        dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+        rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+    };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    serial@1e787000 {
+        compatible = "aspeed,ast2500-vuart";
+        reg = <0x1e787000 0x40>;
+        reg-shift = <2>;
+        interrupts = <8>;
+        clocks = <&syscon ASPEED_CLK_APB>;
+        no-loopback-test;
+        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
+    };
+
+...
-- 
2.25.1

