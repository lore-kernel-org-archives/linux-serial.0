Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F98C3F2D8
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9227020838
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgCCNn4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:43:56 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:37122 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgCCNn4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:56 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 9pjt2200z5USYZQ06pjtH2; Tue, 03 Mar 2020 14:43:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0001GY-RS; Tue, 03 Mar 2020 14:43:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j97px-0005oC-QY; Tue, 03 Mar 2020 14:43:53 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] dt-bindings: serial: Convert slave-device bindings to json-schema
Date:   Tue,  3 Mar 2020 14:43:51 +0100
Message-Id: <20200303134351.22270-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303134351.22270-1-geert+renesas@glider.be>
References: <20200303134351.22270-1-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert the serial slave-device Device Tree binding documentation to
json-schema, and incorporate it into the generic serial bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/serial/serial.yaml    | 53 +++++++++++++++++++
 .../bindings/serial/slave-device.txt          | 45 ----------------
 MAINTAINERS                                   |  2 +-
 3 files changed, 54 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index d408335319f00215..7381966449b62deb 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -7,6 +7,7 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Serial Interface Generic DT Bindings
 
 maintainers:
+  - Rob Herring <robh@kernel.org>
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
 description:
@@ -59,6 +60,45 @@ properties:
       "rts-gpios" above, unless support is provided to switch between modes
       dynamically.
 
+patternProperties:
+  "^(bluetooth|ethernet|gnss|nfc|wifi)$":
+    type: object
+
+    description:
+      Serial attached devices shall be a child node of the host UART device the
+      slave device is attached to. It is expected that the attached device is
+      the only child node of the UART device. The slave device node name shall
+      reflect the generic type of device for the node.
+
+    properties:
+      compatible:
+        description:
+          Compatible of the device connnected to the serial port.
+
+      max-speed:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The maximum baud rate the device operates at. This should only be
+          present if the maximum is less than the slave device can support. For
+          example, a particular board has some signal quality issue or the host
+          processor can't support higher baud rates.
+
+      current-speed:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          The current baud rate the device operates at. This should only be
+          present in case a driver has no chance to know the baud rate of the
+          slave device.
+          Examples:
+            * device supports auto-baud
+            * the rate is setup by a bootloader and there is no way to reset
+              the device
+            * device baud rate is configured by its firmware but there is no
+              way to request the actual settings
+
+    required:
+      - compatible
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -93,3 +133,16 @@ examples:
             power-domains = <&pd_a3sp>;
             uart-has-rtscts;
     };
+
+  - |
+    serial@1234 {
+            compatible = "ns16550a";
+            reg = <0x1234 0x20>;
+            interrupts = <1>;
+
+            bluetooth {
+                    compatible = "brcm,bcm43341-bt";
+                    interrupt-parent = <&gpio>;
+                    interrupts = <10>;
+            };
+    };
diff --git a/Documentation/devicetree/bindings/serial/slave-device.txt b/Documentation/devicetree/bindings/serial/slave-device.txt
deleted file mode 100644
index 40110e0196209fde..0000000000000000
--- a/Documentation/devicetree/bindings/serial/slave-device.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-Serial Slave Device DT binding
-
-This documents the binding structure and common properties for serial
-attached devices. Common examples include Bluetooth, WiFi, NFC and GPS
-devices.
-
-Serial attached devices shall be a child node of the host UART device the
-slave device is attached to. It is expected that the attached device is
-the only child node of the UART device. The slave device node name shall
-reflect the generic type of device for the node.
-
-Required Properties:
-
-- compatible 	: A string reflecting the vendor and specific device the node
-		  represents.
-
-Optional Properties:
-
-- max-speed	: The maximum baud rate the device operates at. This should
-		  only be present if the maximum is less than the slave device
-		  can support. For example, a particular board has some signal
-		  quality issue or the host processor can't support higher
-		  baud rates.
-- current-speed	: The current baud rate the device operates at. This should
-		  only be present in case a driver has no chance to know
-		  the baud rate of the slave device.
-		  Examples:
-		    * device supports auto-baud
-		    * the rate is setup by a bootloader and there is no
-		      way to reset the device
-		    * device baud rate is configured by its firmware but
-		      there is no way to request the actual settings
-
-Example:
-
-serial@1234 {
-	compatible = "ns16550a";
-	interrupts = <1>;
-
-	bluetooth {
-		compatible = "brcm,bcm43341-bt";
-		interrupt-parent = <&gpio>;
-		interrupts = <10>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 59c14ee9a917a794..5f5d074c7b3927a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15034,7 +15034,7 @@ SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/serial/slave-device.txt
+F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
 
-- 
2.17.1

