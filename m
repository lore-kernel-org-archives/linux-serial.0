Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D90C352BE
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6429220771
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 04:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9ukk57M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbgDPE4b (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404729AbgDPE4a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 00:56:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD7C061A0C;
        Wed, 15 Apr 2020 21:56:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so1131858pfb.4;
        Wed, 15 Apr 2020 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SzP7bHD5Hc4jVvputS81h7AwLyVMTVzgcy2Av2iBbno=;
        b=l9ukk57MXClJMRH+oZYY1IMPAWfCKffwTD/MRHif0/vKJsYekb3MIVZgfvcgkEHoYa
         4sMiA4FxoPD/1hgm9NXfi3Lluo/tYMsdUiul3pPyUeQxLQ7v9ntrttcNADiP4u9rARgB
         HZWncVdEYBU8T3Jyq9egkIVT7SJ3kaBznGu2t0k1Uh9ZBcXJY/OQrFdM18Z2Yausafrq
         qB67/H1wyWEqeasZs6jHiBnly5SGVtnKvHxyD+Uu+xU+lAhmt7y+s89mzhMeXxL3Dla8
         SBSxEV8WYkh8j93pGCSUvcDMtS6NJyBO/FQZ0Nl0JsIoSYxDBAdfxG4pGFkEcp12Mky+
         9jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SzP7bHD5Hc4jVvputS81h7AwLyVMTVzgcy2Av2iBbno=;
        b=FolfxKY8xP183t8qmeVu2ZSBHrntfq/TwUNfW8GvNnmYEzkSgs1Xf6C342IjGshWlg
         FAgsq3Ev3jV9HUyt74B+Z73eS5tF9yfd965hZUf8FTBBJGpHKa+6rv02DrugoJe9ec7S
         gBImCiYHzsvZBGMKiYOBhdOCjZYm9S4npYClDGR5mA8/WbJG0lNzPZA6p86Txxvdr1eK
         v0rOCyFqaR6sApOkRqvtFpP2EiOOWql8+3YABiK08zYiHumz2HyQD/xrjg4EAq/L0WFg
         m9Vs5UAkLUoAwaf66kykOUsfYGf3v1OOYKV37pVspeb5q1pDQIyM20rS7ZbybP8qsAjY
         CJ3w==
X-Gm-Message-State: AGi0PuaewoDe47H60DQm8QYZW1EiQOG+zPrM/cL5VPUQvVTMtkrJ5as+
        nHlVEpbXyeC1nvGMH/i2S6h592aTiNY=
X-Google-Smtp-Source: APiQypJa7VvdT4JFQmvU9sh/Orly6zGOEZqw9Ndxdm2WZL5BeFtsHXB+ih3k/RAX44DLyazVdVVF4Q==
X-Received: by 2002:a63:c149:: with SMTP id p9mr29292799pgi.389.1587012989254;
        Wed, 15 Apr 2020 21:56:29 -0700 (PDT)
Received: from localhost.localdomain ([183.82.182.213])
        by smtp.gmail.com with ESMTPSA id 3sm4749198pgh.75.2020.04.15.21.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 21:56:28 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, andriy.shevchenko@linux.intel.com
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v3 1/4] dt-bindings: ttyvs: document serial null modem driver bindings
Date:   Thu, 16 Apr 2020 10:26:11 +0530
Message-Id: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ttyvs driver creates virtual tty devices. These devices can
also be created through device tree. This commit document this.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v3:
- Rebased on top of v5.7-rc1

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

