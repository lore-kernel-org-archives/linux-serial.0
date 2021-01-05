Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59623C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC43D22838
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 10:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbhAEKbp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:31:45 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:56066 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbhAEKbp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 05:31:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id A71D011F850;
        Tue,  5 Jan 2021 11:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609842662;
        bh=MUjJfk9WqP/192z0Yhwfz2yDLEpbXsF5/dNm7cec5Qc=;
        h=Date:From:To:Subject:From;
        b=5GvGgbecUobd6zKEPXIp48h7ar+ES1N/egSVP1g8Bkfrj2/x87pkcXdh+7XKS5aHr
         lbgkaATbXmANQrQtkSiT7+megamFgCgAZkznffwLXVIDoutUeV0q3j2MdfGfsNe1pW
         w+OXQwewLTPFSjMLGCCL8b6OSTrhdIw/x5YdRs0ZwCtii4VoZDCbidlyIvGgp4KAkB
         S7NdMybW0yc6irt9Khz+S4+eCqORpGHuXgAEZnq2edXywciVfoD7ROCx955A0ImURV
         r3oSTN8B8vQnKCTkMFKXxFzprjHEgWpv2vCP7GhfBoYGd1A1OexKitXQPzX2bsrPcq
         mzQaONha8VZeQ==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r4ytmN6nC2QI; Tue,  5 Jan 2021 11:30:31 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 0211311F84E;
        Tue,  5 Jan 2021 11:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609842631;
        bh=MUjJfk9WqP/192z0Yhwfz2yDLEpbXsF5/dNm7cec5Qc=;
        h=Date:From:To:Subject:From;
        b=rXnXbZKbdxOUGd9Oq+UTUvKIMI2fB6ZFprpsw6cJ+MDFe+BFUuNe07V68AdCrYzDR
         miMAXsrIcazYnnhSWYufCXrRUoYp1hcljdetDZQwA/MH+FFz6LKukq2iUBQMfRNXqE
         eHQz69cJuAqsVVfhsiGFhu3jCJNI61ajnpxi3xLXyrRWfUgoOoPvzlmctTSz4bW2Kp
         6ECV8SdRUQBWHBVLirBdSQlNsZpLhRRxSF+gf54MDZb/EAem1L8Kx7I6AUoOfpOk+o
         U7HUgmVkaiYQOxMG9O5j0etYVg0wUJvry+pEgZpMT0e1MG36R4rQMnE5wLXstwUFBd
         mc6jLUB0/UZDg==
Date:   Tue, 5 Jan 2021 10:30:29 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7,2/2] dt: bindings: add silabs,si4455 schema
Message-ID: <20210105103027.GA15137@dev>
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

