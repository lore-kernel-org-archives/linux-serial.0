Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CACC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792B461B5E
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKSFWd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhKSFWb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 00:22:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10680C061574;
        Thu, 18 Nov 2021 21:19:30 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id o4so8358987pfp.13;
        Thu, 18 Nov 2021 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ma/KLieP86oiS9Esoj2AvGkt6gOa901E6yOfSgkEDg=;
        b=Igf6rlaXR/AbJOGVPS7mECsIWGQ3gHFdbm1pJ4bD9AcyV3bQOkslMgJcggHsuJ+0mH
         j7LUeS8/FpG/bnZdcXPJNTL8fkQV+M1Bv3dizbciM8lK2Pm42sKl+HdlAxUmbOnR+OGZ
         XPV5/Nb94Nz/NysXFx88Ii3H7JAPKJBXzuffnNQbwXJBMG8WpjHCvzjLmigr2e/iv6bY
         wGWUXeCIfLA1MoqWks6/NQM7r61q1rwTbrzqTIyHI005Aoz/czT/oH7StlMXK3T8jFHO
         4dUFZt/TzP943KTgN3hVCQ1LHswjxt5jq/I3TsoSZ5HDTHoIBtLpfjqopIG/N3QWY2fh
         XqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ma/KLieP86oiS9Esoj2AvGkt6gOa901E6yOfSgkEDg=;
        b=MBYIYh488ett1+bUGTTfiQIjLDVqoFziPDD4PVWI1nNAjz3r2qtgXT1WxF1CaSv39N
         CBQlA8EAXoxKNM1K3922yoQystyv7eL05I4F4Iw0XPIppz9jAxOS23+TprgASIAlun53
         4X0TXMWIYQIpOHwl58IWMnkir/PKMj4cB5RzDhRJmGrxAA2RqQs6lx+zuLtwJS2KzfJx
         vAqijBdvUfJAq0MVPi0vIhs4EXaD395FZT4ViMWSxIdDqqkapOvyMNHA1TKDlj75Eb7i
         pf08QvxM+/DIFPhyLhoKrGveqUl3jJ/e+3Fuay0jXMfQfgXrs9eG+kG4aicjFRKiabJI
         52pA==
X-Gm-Message-State: AOAM531M7SS/a5oSyB7JcVoyTkIRwB6yAgwoY6FlG2xdsnMYdcJkqrda
        se9K8li0SG30s8zqNFUF0Zw=
X-Google-Smtp-Source: ABdhPJzLuYK7HsdRXxIB9hiI3hHBMu84Ee6hApRWNcVt4MB0oJw9XrSnBrGzNkOSp41msNarRTiynQ==
X-Received: by 2002:a05:6a00:2151:b0:4a2:5c9a:f0a9 with SMTP id o17-20020a056a00215100b004a25c9af0a9mr20742360pfk.39.1637299169628;
        Thu, 18 Nov 2021 21:19:29 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c2sm1332935pfv.112.2021.11.18.21.19.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 21:19:29 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v3 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
Date:   Fri, 19 Nov 2021 13:19:22 +0800
Message-Id: <1637299163-6460-2-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add bindings doc for Sunplus SoC UART Driver

Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>
---
Changes in v3:
 - Modify yaml file based on uart driver (remove dma function).

 .../bindings/serial/sunplus,sp7021-uart.yaml       | 58 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
new file mode 100644
index 0000000..df11074
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
+
+maintainers:
+  - Tony Huang <tony.huang@sunplus.com>
+  - Hammer Hsieh <hammer.hsieh@sunplus.com>
+  - Wells Lu <wells.lu@sunplus.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: sunplus,sp7021-uart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    aliases {
+            serial0 = &uart0;
+    };
+
+    uart0: serial@9c000900 {
+        compatible = "sunplus,sp7021-uart";
+        reg = <0x9c000900 0x80>;
+        interrupt-parent = <&intc>;
+        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc 0x28>;
+        resets = <&rstc 0x18>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..f2ee40c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS UART DRIVER
+M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
-- 
2.7.4

