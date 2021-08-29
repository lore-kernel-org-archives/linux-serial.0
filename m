Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B91C432BE
	for <linux-serial@archiver.kernel.org>; Sun, 29 Aug 2021 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5F260F38
	for <linux-serial@archiver.kernel.org>; Sun, 29 Aug 2021 13:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbhH2NUc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Aug 2021 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhH2NUc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Aug 2021 09:20:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5DCC061575;
        Sun, 29 Aug 2021 06:19:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y34so25276350lfa.8;
        Sun, 29 Aug 2021 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3hW4yuRwNrs+bBNRiJtmklrcuViJiSd62ejta1cri0=;
        b=MCAVRP700ilSv+DnX6gz+ji1siO1G53lA0krI4dUH2ynY3W1v1asFGTpWXLjeLJKWc
         Pg7jvttZ9IXhPxhTUigLhH6ELnOyS88wbcTyIr554KteIr4DtkDWeAO22j31NI0TI/ZT
         aCi59yoffAi5rorY6IZR9ircBo8gCdwP30kxugjYKpzH/B34rFrK1KHLR2fkZ8YwRCv+
         KksTh1I5htDuZBJe/CTOiqyrufPhpEV6omP4BfklaowGnvNGDQU02eOfZ0MFkS5aDdq2
         TRDlXxcbUJCdayIMddwArvCen4rh2XdBZ9+7kwIRJsW+u/N1pHzEQxPOUaADQdFb8xrK
         GSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3hW4yuRwNrs+bBNRiJtmklrcuViJiSd62ejta1cri0=;
        b=Pl6aewz0RdBO5uwPTLmMPMIvlncSK29rrtZtzA6ESLDCYchBcfcPtNOl3A2vtaU9g7
         91DvYHTwpbLwpTQsi7LEvE1yaTfOmtl4UYWsrgqzvKN2z24izLSZ/n27aOqo3v1w+g+l
         1e6h99TA2YY9ldYzYaqv+bYWRr1KKRosC3cnVGMtjLJocZrnIbJXTJW0vjA6cr6c4l0a
         Oj9Mrp/13WSopEB13hrQjItRWvRaTQIb39rmuOxWUP7jA6Ny7i5xHEv6Q/z6ozp9nhvz
         ucJ4DWRSfd5TWplcuvalfsHONGDxx4IXrGnmqMil2ySTUS9yZQDKgXwmbKXEHjg66x6D
         8m2A==
X-Gm-Message-State: AOAM5327gOVo7Bi6XjjHJMLKjNiRp5owlC3LZ4fWyk/zQOlYkx3oyj3/
        ii3kIk45TwmhX7J1OAUdQV8=
X-Google-Smtp-Source: ABdhPJzo7fq1Lj/5IrffxQjvFbQB4F4Gtq8VQkPQAJNQO0YaixDnnZUnrT6luIW2kzi7CCfYNi5Kag==
X-Received: by 2002:a05:6512:3e11:: with SMTP id i17mr13549287lfv.613.1630243178477;
        Sun, 29 Aug 2021 06:19:38 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p4sm1542135ljc.135.2021.08.29.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 06:19:38 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH V2] dt-bindings: serial: brcm,bcm6345-uart: convert to the json-schema
Date:   Sun, 29 Aug 2021 15:19:27 +0200
Message-Id: <20210829131927.13682-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819134859.19537-1-zajec5@gmail.com>
References: <20210819134859.19537-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Redundant generic descriptions (e.g. "The base address of the UART
register bank") were dropped and periph_clk was dropped from example as
not required.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/serial/brcm,bcm6345-uart.txt     | 36 --------------
 .../bindings/serial/brcm,bcm6345-uart.yaml    | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
deleted file mode 100644
index 8b2b0460259a..000000000000
--- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* BCM63xx UART
-
-Required properties:
-
-- compatible: "brcm,bcm6345-uart"
-
-- reg: The base address of the UART register bank.
-
-- interrupts: A single interrupt specifier.
-
-- clocks: Clock driving the hardware; used to figure out the baud rate
-  divisor.
-
-
-Optional properties:
-
-- clock-names: Should be "refclk".
-
-Example:
-
-	uart0: serial@14e00520 {
-		compatible = "brcm,bcm6345-uart";
-		reg = <0x14e00520 0x18>;
-		interrupt-parent = <&periph_intc>;
-		interrupts = <2>;
-		clocks = <&periph_clk>;
-		clock-names = "refclk";
-	};
-
-	clocks {
-		periph_clk: periph_clk@0 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <54000000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
new file mode 100644
index 000000000000..a22285c43f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/brcm,bcm6345-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM63xx UART
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm6345-uart
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
+  clock-names:
+    const: refclk
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    serial@14e00520 {
+        compatible = "brcm,bcm6345-uart";
+        reg = <0x14e00520 0x18>;
+        interrupt-parent = <&periph_intc>;
+        interrupts = <2>;
+        clocks = <&periph_clk>;
+        clock-names = "refclk";
+    };
-- 
2.26.2

