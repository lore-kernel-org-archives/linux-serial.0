Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E04C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEC322525
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbhAEKpF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:45:05 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:58944 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbhAEKpE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 05:45:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id F240E11F850;
        Tue,  5 Jan 2021 11:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609843462;
        bh=MUjJfk9WqP/192z0Yhwfz2yDLEpbXsF5/dNm7cec5Qc=;
        h=Date:From:To:Subject:From;
        b=pNKaIDv3mH4tfXwMO3e2ns0/2uBc1WuMjOW7HUt2V0EMSd8e1MKvxkfLqeqdgIIAx
         9B3aEoHB9qNBlpI5R3qV5baA1FkgTPD1kiFo0LirNvkMJ5vrisCvpP/CN0HuqOZTdo
         J8FP4rlucCcfYTlghQSFm5c2zf/ntsLpAA196rhPG1iRlXWvnKQ9+uzLaW3fUCKQz4
         IAY2Z4n3tPd0S+NK5cy/Y4UNnE3N87wSAGLYyOxXJCD60O90ZMuNnCnHO6i//kLjZ/
         5msqBlMHp94aFCv8wHfbTFVjnB5hss3fPJWjydL9gSFoLu2RRKZ4bs7Pp4t44NPGri
         aBjJMUiffhXTg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0SvJM_mBQCFY; Tue,  5 Jan 2021 11:43:52 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 70DA011F84E;
        Tue,  5 Jan 2021 11:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609843432;
        bh=MUjJfk9WqP/192z0Yhwfz2yDLEpbXsF5/dNm7cec5Qc=;
        h=Date:From:To:Subject:From;
        b=gl6sUBf9Hhf0AobIBw6c8dvq+V6+VT3buC2KAiZaKe7InKK+TGKncksVnQaaSCpPx
         wYLqMppQsbP1palQBY907WeodxCZfGfDDFMhZ+ypHK7Tv1qiobDMXJI3qtVfkrRr/8
         xcgcUOY4y6MGsuWgajwLkOF5zZ6r4ge7xMGNSDfTt9r2D4omQMf7wl3oyMvAgNfvGR
         Fv0RKZ77lH182xMSWSNU1MSdj4zWYZQQCtHgHHvfD1bdqrKN/X6CGEfsEfx3m3Srv2
         UJNgz03Z09AvQnKJIVloeKPGE8lsDHOTPVFFHeh9w+3x3KNIRNbk8KH9b+GKxp271C
         03yvPD6RkVhqA==
Date:   Tue, 5 Jan 2021 10:43:49 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7,2/2] Serial: silabs si4455 serial driver
Message-ID: <20210105104347.GA18688@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a device tree schema for serial port driver for
 Silicon Labs Si4455 Sub-GHz transciver.

Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf

Guide: https://github.com/dministro/linux-serial-si4455

Signed-off-by: Jozsef Horvath <info@ministro.hu>
---

changes v1:
 - fixed: dt: bindings: rename sdn-gpios to shutdown-gpios

changes v3:
 - fixed: dt: bindings: silabs,si4455: more detailed description
 - added: dt: bindings: silabs,si4455: properties silabs,package-size,
   silabs,tx-channel, silabs,rx-channel, silabs,ez-config

changes v4:
 - fixed: dt: bindings: silabs,si4455: $id
   from http://devicetree.org/schemas/serial/silabs,si4455.yaml
   to http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml

changes v5:
 - fixed: dt: bindings: silabs,si4455: $id
   from http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
   to http://devicetree.org/schemas/serial/silabs,si4455.yaml
 - fixed: dt: bindings: silabs,si4455: serial.yaml reference added

changes v7:
 - added: dt: bindings: silabs,si4455: silabs,tx-timeout property definition
---
 .../bindings/serial/silabs,si4455.yaml        | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml

diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
new file mode 100644
index 000000000000..8ba4956064b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Silicon Labs Si4455 device tree bindings
+
+maintainers:
+  - József Horváth <info@ministro.hu>
+
+description:
+  This document is for describing the required device tree parameters for si4455 serial driver.
+  The si4455 driver tries to represent the Silicon Labs Si4455 sub-GHz transceiver device
+  like a serial port. The required parameters for proper operation are described below.
+  https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
+
+allOf:
+  - $ref: "serial.yaml#"
+
+properties:
+  compatible:
+    const: silabs,si4455
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    description: maximum clock frequency on SPI port
+    maximum: 500000
+
+  shutdown-gpios:
+    description: gpio pin for SDN
+    maxItems: 1
+
+  silabs,package-size:
+    description:
+      Radio payload length, variable packet length is not supported by driver.
+      This value should equal with EZConfig payload length.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 64
+    minimum: 1
+
+  silabs,tx-channel:
+    description:
+      Radio transmit channel selection.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    minimum: 0
+
+  silabs,rx-channel:
+    description:
+      Radio receive channel selection.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    minimum: 0
+
+  silabs,tx-timeout:
+    description:
+      Radio transmit timeout(ms)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1000
+    minimum: 1
+
+  firmware-name:
+    description:
+      Radio configuration data file name.
+    $ref: /schemas/types.yaml#/definitions/string
+    items:
+      pattern: ^[0-9a-z\._\-]{1,255}$
+
+required:
+  - reg
+  - interrupts
+  - spi-max-frequency
+  - shutdown-gpios
+  - silabs,package-size
+  - silabs,tx-channel
+  - silabs,rx-channel
+  - firmware-name
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      si4455_0: serial@0 {
+        compatible = "silabs,si4455";
+        reg = <0>;
+        interrupt-parent = <&gpio>;
+        interrupts = <7 2>;
+        shutdown-gpios = <&gpio 26 1>;
+        spi-max-frequency = <300000>;
+        silabs,package-size = <30>;
+        silabs,tx-channel = <1>;
+        silabs,rx-channel = <2>;
+        firmware-name = "si4455_spi0_0.ez.bin";
+      };
+    };
+...
-- 
2.17.1

