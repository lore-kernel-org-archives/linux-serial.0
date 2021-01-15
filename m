Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D7C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 21:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D22235F8
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhAOVRE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 16:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhAOVRA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 16:17:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0DCC061793;
        Fri, 15 Jan 2021 13:16:20 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c12so6269642pfo.10;
        Fri, 15 Jan 2021 13:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ISDBl7x5aT3VMD5118I7MhqiM7zCHqmwmWuDdXc0/xo=;
        b=UUiE4q1bkDp1VcaszQgw5FwxFUXMrtcEWrC8KFI1/g+Y4eqrqbI9MAakqZG7U0IpvF
         FJP6iKO4dq6qKLjdOsAKVZyNH+7DKw+BAcqCvK0zdVJ+hLZyXhhXndY4yofr8Ljahs8I
         sGraAlrpSiCnDTCmontzxJLpXdaBhfhMs74/ONrE/0nLvIruNW99z5qKdpNtjXuYL+gV
         qTdboF01DTMpQMMHKMDPXg3kfpERiTZEmv9rB2TFDZ+EKVl8m9OZ/4wckXlFyhzrGXfV
         ZPPQTsJpx5Gxujn8C04SJGAUi3RHfA6Xv4yYQa6WLjKubI3nelVrwwRg79jCzrvi8ABT
         FjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ISDBl7x5aT3VMD5118I7MhqiM7zCHqmwmWuDdXc0/xo=;
        b=FLFSgZeZxr3iXFw+2jHTtchj1LABjnM27g2IsdfiEmSbtVzIj5T4zPpnFB49neZKV+
         yp7iWdS2x19v/3i3zkawUPqx9ZF5RWNTcgZ/Ub5TKPxTxTHSV3yg0GAkmiGBOn7C9XCN
         CgElkDTd5D1yJMZ9sjf4935XfzzAFQHHwD1iVnV2TDKDSh39G38gAtgItU/RDTnx59Pd
         G03kx7flf2dYfQbEb/OZyNpZwq+1MeJ5lRzqbsnyRIQoKP6ZPojgImge39ULHlf95Ew+
         iXdJIkBw/qmaFT3XQasp2uqeIgbUVQ9IYq3WPvQeTAESs/5hei9LRZLJ7qIsfHIYeuhs
         pfPw==
X-Gm-Message-State: AOAM531XlYs4S9R++F7L4WAzQEqIndkcI9T9nZoQw6chN+HeNpM8ZLAP
        0560EfZ3dQ5R9Llpb/zZoKuDvPJQXa0=
X-Google-Smtp-Source: ABdhPJzCH+5Ld/dT91x/6imFZ6vNgB7/lnUlMb+N4YY11D17HudNGRXEyaVPMSiw5rXCLyccG3jrEw==
X-Received: by 2002:a63:4966:: with SMTP id y38mr14332040pgk.428.1610745379638;
        Fri, 15 Jan 2021 13:16:19 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 77sm9321827pfv.16.2021.01.15.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:16:19 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: Add support for the Broadcom UART driver
Date:   Fri, 15 Jan 2021 16:15:42 -0500
Message-Id: <20210115211543.33563-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115211543.33563-1-alcooperx@gmail.com>
References: <20210115211543.33563-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add DT bindings for the Broadcom 8250 based UART driver. This
UART is based on an 8250 but adds additional functionality. The
additional features include the ability to use DMA for transfers and
a baud rate clock system that is more accurate at high baud rates.
This UART is backward compatible with the standard 8250 UART.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/serial/brcm,bcm7271-uart.yaml    | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
new file mode 100644
index 000000000000..76aff2c21394
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm7271-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom 8250 based serial port devicetree bindings
+
+maintainers:
+  - Al Cooper <alcooperx@gmail.com>
+
+description: |+
+  The Broadcom UART is based on the basic 8250 UART but with
+  enhancements for more accurate high speed baud rates and support
+  for DMA.
+
+properties:
+  $nodename:
+    pattern: "^serial@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm7271-uart
+          - brcm,bcm7278-uart
+  reg:
+    minItems: 1
+    maxItems: 5
+
+  reg-names:
+    description: The UART register block and optionally the DMA register blocks.
+    oneOf:
+      - items:
+          - const: uart
+      - items:
+          - const: uart
+          - const: dma_arb
+          - const: dma_rx
+          - const: dma_tx
+          - const: dma_intr2
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    const: sw_baud
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description: The UART interrupt and optionally the DMA interrupt.
+    oneOf:
+      - items:
+          - const: uart
+      - items:
+          - const: uart
+          - const: dma
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    serial@840d000 {
+        compatible = "brcm,bcm7271-uart";
+        reg = <0x840d000 0x20>;
+        reg-names = "uart";
+        interrupts = <0x0 0x62 0x4>;
+        interrupt-names = "uart";
+        clocks = <&scmi_clk 190>;
+        clock-names = "sw_baud";
+    };
+
+    serial@840e000 {
+        compatible = "brcm,bcm7271-uart";
+        reg = <0x840e000 0x20>,
+              <0x840e080 0x8>,
+              <0x840e100 0xa8>,
+              <0x840e200 0x4c>,
+              <0x840e300 0x30>;
+        reg-names = "uart", "dma_arb", "dma_rx", "dma_tx", "dma_intr2";
+        interrupts = <0x0 0x62 0x4>, <0x0 0x75 0x4>;
+        interrupt-names = "uart", "dma";
+        clocks = <&scmi_clk 190>;
+        clock-names = "sw_baud";
+    };
-- 
2.17.1

