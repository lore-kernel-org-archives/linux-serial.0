Return-Path: <SRS0=m38j=4D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FFEC2BA83
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CB92084E
	for <linux-serial@archiver.kernel.org>; Sat, 15 Feb 2020 17:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMfa9w4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgBORvX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 15 Feb 2020 12:51:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53920 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBORvW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 15 Feb 2020 12:51:22 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so5385194pjc.3;
        Sat, 15 Feb 2020 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WwHvpZLXwUUzL5832t8riOLNNuOlQyc6hyd24yYnpxk=;
        b=PMfa9w4gphEkhAlWRUVE+fe5gLfT8l+Y3B8MqBwnSTebRwmZqVBiS6SH/l+fNa+8Ba
         UKAybU0rYqaZNar7E9vrFt6uaSePMd9DACxeOdawFxpJ/6O/4cJF9Dpg4xIRudUZBbpi
         2MPCcgmsSZn2yljVD28q8adueOHhWOjCgHWJPVF4eZT8YjXIDgr3KGuofqzEyyuFFl0D
         o3u+buAcafThDKkLkbieva7Z4xROefwZkiXmSxN9016Z2zuOmXKOAXutbC73mRAk1Yp2
         EKTEcjyQFs+uwk3qs+HIFXOVFVwImuLFcd16+rw/MbJ6SkozvFK90NcWje+I1QI8R+Tk
         tXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WwHvpZLXwUUzL5832t8riOLNNuOlQyc6hyd24yYnpxk=;
        b=DfvsZn2vsB6EhWZ2Y+fd3QwJRPwS9nGkepHz4R9SHUYd+5RH/2rssHSBMdVwYqOmXE
         3zI7gBQlKwt9/JXtPVLlNQ3aQL9hfogUhnxdfaKjgxMwjUzcOeXkXyts2b5EoYMuXY90
         LVWnrhBbkXJYEY+E735H6EXOTEptcuVx2+0U7GgXXxU2fj7IGIMNrjIuyZOvcMwq8UEM
         9xmhK2yoAPtURO9hG6NYSpiXyFPh9Z5Q5UO9jc+rsw5+jVT+blFRefCQfUytOPJN139+
         nyV2Aac8jz9e/ikbeLHxxme/C3EBcQXG2NvXj6PpFi7fQRppi6ksichK9c8+C37yG0op
         xfIg==
X-Gm-Message-State: APjAAAUEqOkOgbV5Ih7lo/XnP68oDaV34w65Hgrlp36IOPFXXdnKpLAX
        mpmK9/oMFGZ/pvzJgXd5Kgw=
X-Google-Smtp-Source: APXvYqziT0+gc8b4jUEKNhE5oLAw2M1NggxrMr0l0dxD0ivFzHCw2+D5skAEdCdOzaEEX0dKuzysJw==
X-Received: by 2002:a17:902:b604:: with SMTP id b4mr8693221pls.340.1581789081726;
        Sat, 15 Feb 2020 09:51:21 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.214])
        by smtp.gmail.com with ESMTPSA id g13sm7176375pgh.82.2020.02.15.09.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Feb 2020 09:51:21 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: ttyvs: document serial null modem driver bindings
Date:   Sat, 15 Feb 2020 23:21:06 +0530
Message-Id: <1581789069-5232-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ttyvs driver creates virtual tty devices. These devices can
also be created through device tree. This commit document this.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v2:
- Made dev-num property mandatory
- Removed descriptions not needed due to driver changes

 .../devicetree/bindings/serial/ttyvs.yaml          | 165 +++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/ttyvs.yaml

diff --git a/Documentation/devicetree/bindings/serial/ttyvs.yaml b/Documentation/devicetree/bindings/serial/ttyvs.yaml
new file mode 100644
index 0000000..c919424
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/ttyvs.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/ttyvs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual multi-port serial card DT bindings
+
+maintainers:
+  - Rishi Gupta <gupt21@gmail.com>
+
+description: |
+  The ttyvs driver creates a virtual card which can have 0 to 65535
+  virtual tty devices. The card is modelled as a node with zero or more
+  child nodes each representing a virtual tty device. These devices
+  can be configured to be a loop-back type device or it can be part of
+  a null-modem pair.
+
+  Devices can be created by defining properties required to instantiate
+  a device (see examples Ex1/2/3 at the end). More information about
+  how to use this driver is here Documentation/virtual/tty-ttyvs.rst
+
+properties:
+  compatible:
+    const: ttyvs,virtual-uart-card
+
+  max-num-vs-devs:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - maximum: 0xffff
+    maxItems: 1
+    description:
+      By default, the driver can create upto 64 devices. This number can
+      be changed by passing 'max_num_vs_devs' module parameter to the driver
+      or by defining 'max-num-vs-devs' DT property. If both are used then
+      driver updates itself to support total number of devices as defined
+      by max-num-vs-devs property.
+
+patternProperties:
+  "^ttyvs@[0-9]+$":
+    type: object
+    description:
+      Node representing one virtual tty device. This describes, device
+      number and its configuration.
+
+    properties:
+      dev-num:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - minimum: 0
+          - maximum: 65534
+        maxItems: 1
+        description:
+          Specifies index (N in /dev/ttyvsN) to use for creating device.
+          Valid value for dev-num is from 0 to 65534.
+
+      rtsmap:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [1, 6, 8, 9]
+        maxItems: 1
+        description:
+          Specifies to which pin(s) RTS pin of this device should be
+          connected. Valid values are pin 1 (DCD), pin 6 (DSR), pin 8
+          (CTS) and pin 9 (RI). If this is not used then RTS pin is
+          left unconnected.
+
+      dtrmap:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [1, 6, 8, 9]
+        maxItems: 1
+        description:
+          Specifies to which pin(s) DTR pin of this device should be
+          connected. Valid values are pin 1 (DCD), pin 6 (DSR), pin 8
+          (CTS) and pin 9 (RI). If this is not used then DTR pin is
+          left unconnected.
+
+      set-dtr-at-open:
+        type: boolean
+        description:
+          If used, DTR signal will be asserted by driver when device
+          node is opened by user space application.
+
+      peer-dev:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description:
+          Phandle to the peer DT node if this node is part of a null
+          modem pair.
+
+required:
+  - compatible
+  - dev-num
+
+examples:
+  - |
+    # Ex1; Null-modem pair only TX/RX connected
+    # /dev/ttvs0  <---> /dev/ttyvs1
+    #      TX (3) ----> (2) RX
+    #      RX (2) <---- (3) TX
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+
+        ttyvs0: ttyvs0 {
+            dev-num = <0>;
+            peer-dev = <&ttyvs1>;
+        };
+
+        ttyvs1: ttyvs1 {
+            dev-num = <1>;
+            peer-dev = <&ttyvs0>;
+        };
+    };
+
+  - |
+    # Ex2; Standard loop-back device
+    # TX (3) -->|
+    # RX (2) <--|
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+        ttyvs2 {
+            dev-num = <2>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+        };
+    };
+
+  - |
+    # Ex3; Standard null-modem pair for hardware flow control
+    # TX  (3) ----> (2) RX
+    # RX  (2) <---- (3) TX
+    # RTS (7) ----> (8) CTS
+    # DTR (4) --+-> (1) DCD
+    #           +-> (6) DSR
+    # CTS (8) <---- (7) RTS
+    # DCD (1) <-+-- (4) DTR
+    # DSR (6) <-+
+
+    ttyvs-card@0 {
+        compatible = "ttyvs,virtual-uart-card";
+        max-num-vs-devs = <128>;
+
+        ttyvs3: ttyvs3 {
+            dev-num = <3>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+            peer-dev = <&ttyvs4>;
+        };
+
+        ttyvs4: ttyvs4 {
+            dev-num = <4>;
+            rtsmap = <8>;
+            dtrmap = <1 6>;
+            set-dtr-at-open;
+            peer-dev = <&ttyvs3>;
+        };
+    };
+...
-- 
2.7.4

