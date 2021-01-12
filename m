Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B66CC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CD0224BD
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404149AbhALKUj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:20:39 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:42942 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbhALKUh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:20:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id DD5B111FFA3;
        Tue, 12 Jan 2021 11:19:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446767;
        bh=ocLbPaAPw6x42QSryJRlM1mgOlVbX88827KPq5ELl0E=;
        h=Date:From:To:Subject:From;
        b=Ig9HroUN8InkXtAQHBgFEs/hoVRU5Co+GQmCvnTHcU/9J+L/W+AxNZisDIWJNCRu3
         1TXZOT7ZXiwFIcdiMB6cf20qraIvSj+TsLS9VfEOhUvOJatXY9n2LzrqElxtq2sRWa
         rNx9MjDksa54ob1/Yy4ANmxdPjvsyDuoFSnwwGZi9e8FwXbt0TSl5ZDz2wD87bSNx5
         p5bhYlBjDS7ODEdApkg85rFd+IDqGyHaU7IA2FlFo6RXC4+Wxp+2PVrwNMm0UxnTry
         q1OW2UYiG7Bkz0N1KWXj0VA/+LYb5q/EcKZXgyr80jfJ3jUoWc3pun0/wTClsCFlIs
         rOTjSh/XfIipg==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ou1rHFyF4LHc; Tue, 12 Jan 2021 11:19:03 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id 803F611FFA4;
        Tue, 12 Jan 2021 11:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1610446743;
        bh=ocLbPaAPw6x42QSryJRlM1mgOlVbX88827KPq5ELl0E=;
        h=Date:From:To:Subject:From;
        b=REGPQD6bFYQE19APFC2AfplvzseLLcrmgo3A8P/UVST/K6bOuTmTXHHic31Pky1K8
         J2k49h01/PSw5GuMBRkKazW7E2skCCl6N08ZEqNF87BbTNdeMx1CtlLbla9wiS6M64
         fTtj8QUiPkAtsHBeQ4DrrYMywyul8lu2GomnmBGtILnbnAmmxidNAduXTfw6UPjwY/
         cf/DMzRh61AIqpONq/jLe/oocW3msUKORRiEagtRU9JJDeh6NYPJNZ6QLeG+qA1oMI
         xC8YZRlDGjaMFHczxF60QjaxP+Tbo7dsSsUK61XtTg9kvIvO1mSYcfHVLc06YTgnLl
         n9N8lgSOarWxQ==
Date:   Tue, 12 Jan 2021 10:19:00 +0000
From:   Jozsef Horvath <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        =?iso-8859-1?Q?'J=F3zsef_Horv=E1th'?= <info@ministro.hu>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] Serial: silabs si4455 serial driver
Message-ID: <20210112101857.GA13976@dev>
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

Guide: Documentation/driver-api/serial/si4455.rst

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

changes v8:
 - fixed: dt: bindings: silabs,si4455: silabs,tx-timeout property name changed
   to silabs,tx-timeout-ms
---
 .../bindings/serial/silabs,si4455.yaml        | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml

diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
new file mode 100644
index 000000000000..6e6b020e3cb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
@@ -0,0 +1,104 @@
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
+  silabs,tx-timeout-ms:
+    description:
+      Radio transmit timeout(ms)
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

