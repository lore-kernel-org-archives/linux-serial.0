Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA26C433B4
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AFC61166
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDBS1q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:27:46 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:53625 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhDBS1o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 14:27:44 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 043665DB;
        Fri,  2 Apr 2021 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617388063;
        bh=mgtpZAxTDUHm/bMl07mKSDqadNdk4HKpdXOShF6xHOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1a9SlHApQdS0XKseplHgQ30GYXdRn/2yBHUlXxe/SQy62nD/V//KF6sNnNjYPTjT
         8ZOI1zPHZ8Te9kv0ybz02XpvzqrJxN/uRyTYuCHBrThvJgFDcyVtQhKhFdp4P/y5P6
         V4FqmZsFU8zxiFnExyODrFCUv75+lK1IlRsO/L0w=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v4 4/4] dt-bindings: serial: 8250: add aspeed,lpc-io-reg and aspeed,lpc-interrupts
Date:   Fri,  2 Apr 2021 13:27:24 -0500
Message-Id: <20210402182724.20848-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402182724.20848-1-zev@bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These correspond to the existing lpc_address, sirq, and sirq_polarity
sysfs attributes; the second element of aspeed,lpc-interrupts provides
a replacement for the deprecated aspeed,sirq-polarity-sense property.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 491b9297432d..0e82b076e199 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -12,8 +12,13 @@ maintainers:
 allOf:
   - $ref: /schemas/serial.yaml#
   - if:
-      required:
-        - aspeed,sirq-polarity-sense
+      anyOf:
+        - required:
+            - aspeed,lpc-io-reg
+        - required:
+            - aspeed,lpc-interrupts
+        - required:
+            - aspeed,sirq-polarity-sense
     then:
       properties:
         compatible:
@@ -190,6 +195,20 @@ properties:
       applicable to aspeed,ast2500-vuart.
     deprecated: true
 
+  aspeed,lpc-io-reg:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
+
+  aspeed,lpc-interrupts:
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    minItems: 2
+    maxItems: 2
+    description: |
+      A 2-cell property describing the VUART SIRQ number and SIRQ
+      polarity (IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_LEVEL_HIGH).  Only
+      applicable to aspeed,ast2500-vuart.
+
 required:
   - reg
   - interrupts
@@ -221,6 +240,7 @@ examples:
     };
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     serial@1e787000 {
         compatible = "aspeed,ast2500-vuart";
         reg = <0x1e787000 0x40>;
@@ -228,7 +248,8 @@ examples:
         interrupts = <8>;
         clocks = <&syscon ASPEED_CLK_APB>;
         no-loopback-test;
-        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
+        aspeed,lpc-io-reg = <0x3f8>;
+        aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
     };
 
 ...
-- 
2.31.1

