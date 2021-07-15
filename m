Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36444C07E96
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1399961362
	for <linux-serial@archiver.kernel.org>; Thu, 15 Jul 2021 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhGOJ0l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbhGOJ0l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Jul 2021 05:26:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97242C061762
        for <linux-serial@vger.kernel.org>; Thu, 15 Jul 2021 02:23:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b12so4622123pfv.6
        for <linux-serial@vger.kernel.org>; Thu, 15 Jul 2021 02:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tGxs+ledb1QN4h36o9TBKNkqwYbwPt1Wseu2AbjCrI=;
        b=xgR65XM8/M3g9Zqj7xaqRQnhswuu1Z76iXjfUDZynZ0GS4tz8L9cgKpkL1U8DuwUE4
         7VOaeCOwVVH0ZXi3U6GOqsHKpduCxBXYzkYkXtp09u5PLbuKXkSC9A4Ozc7k34H+7wKU
         raaRIyy7bGhKIDr1KotUohQgu7rWcYnO8ljkkbZMilciT6KZmyRiL+hfEF/PIM5bs/1g
         PyXnJ1GkuLYhLDJisULz+7mJ67spIpQyT2JlNRvijudzGCurIhXBep8qEI9VF5weEl8r
         eP3ubc0RpE2dxVov3JlMz+8Tz+4NTCt1dXPy7yOm8r9sK5QuJ0UKsmRg6b82ZsiYPCDe
         61Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tGxs+ledb1QN4h36o9TBKNkqwYbwPt1Wseu2AbjCrI=;
        b=V/BfRuSKxVqTacOETDxv1/6gKr+y7PvJy+EZiP1VcaAn8lpklGl7bqpiucU4uZkVCx
         dhWzSbIeCX2Js+gpjf8LSMpRu5AsHrWQqSu6PBFdZyDpm0iX1nPJsYMBLDQJFwDoRMiv
         /K9crQFZOeu1px0/dWRkjfagCcOc3YwT3gCtFntLKIkQbHUJx4JpoYRRl0giJQtNr9sN
         k4bSSJkYhBbhtdNI8s1v7SUfZOs9J4uM8LOjugB8VG0oMFhJT6npfVnW/LnniOlRU29v
         fzg6Db7gZmedbX3Dykq1jBDT2IV06U1MWwpfimmrKbv7lWbzGa0dHg7LmEaBeQ9qWtDi
         OqvA==
X-Gm-Message-State: AOAM531pXHeGl//OkWwcJRT3O7Ym4W/tVe+gr/qSFNz9RA21NvAD++WV
        M7ILJg7rlm5RSEKt3tLHaDN5
X-Google-Smtp-Source: ABdhPJx4F1nuZubI9ezz8OqE0sdgK+YOulDXehCFHx24pniSxpNbY0ka3i68k7ATg0f+fUfw0ThspQ==
X-Received: by 2002:a63:5117:: with SMTP id f23mr3605556pgb.200.1626341028027;
        Thu, 15 Jul 2021 02:23:48 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id w18sm5298816pjg.50.2021.07.15.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:23:47 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        navam@xilinx.com, peter.crosthwaite@xilinx.com,
        shubhrajyoti.datta@xilinx.com, soren.brinkmann@xilinx.com,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] dt-bindings: serial: convert Cadence UART bindings to YAML
Date:   Thu, 15 Jul 2021 18:22:52 +0900
Message-Id: <20210715092252.225740-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert serial for Cadence UART bindings documentation to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

---
v2:
  - Fix enum of compatible
  - Change from additionalProperties: false to unevaluatedProperties: false
  - Update compatible string in examples.

 .../devicetree/bindings/serial/cdns,uart.txt  | 27 --------
 .../devicetree/bindings/serial/cdns,uart.yaml | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
deleted file mode 100644
index 4efc560f90abbd..00000000000000
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Binding for Cadence UART Controller
-
-Required properties:
-- compatible :
-  Use "xlnx,xuartps","cdns,uart-r1p8" for Zynq-7xxx SoC.
-  Use "xlnx,zynqmp-uart","cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
-- reg: Should contain UART controller registers location and length.
-- interrupts: Should contain UART controller interrupts.
-- clocks: Must contain phandles to the UART clocks
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
-  See ../clocks/clock-bindings.txt for details.
-
-
-Optional properties:
-- cts-override : Override the CTS modem status signal. This signal will
-  always be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin
-
-Example:
-	uart@e0000000 {
-		compatible = "cdns,uart-r1p8";
-		clocks = <&clkc 23>, <&clkc 40>;
-		clock-names = "uart_clk", "pclk";
-		reg = <0xE0000000 0x1000>;
-		interrupts = <0 27 4>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
new file mode 100644
index 00000000000000..fcdbe6f87e9808
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cdns,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence UART Controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: UART controller for Zynq-7xxx SoC
+        items:
+          - const: xlnx,xuartps
+          - const: cdns,uart-r1p8
+      - description: UART controller for Zynq Ultrascale+ MPSoC
+        items:
+          - const: xlnx,zynqmp-uart
+          - const: cdns,uart-r1p12
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: uart_clk
+      - const: pclk
+
+  cts-override:
+    description: |
+      Override the CTS modem status signal. This signal will
+      always be reported as active instead of being obtained
+      from the modem status register. Define this if your serial
+      port does not use this pin.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    uart0: serial@e0000000 {
+      compatible = "xlnx,xuartps", "cdns,uart-r1p8";
+      clocks = <&clkc 23>, <&clkc 40>;
+      clock-names = "uart_clk", "pclk";
+      reg = <0xE0000000 0x1000>;
+      interrupts = <0 27 4>;
+    };
-- 
2.32.0

