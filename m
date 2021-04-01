Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B1AC433B4
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 00:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18113610CA
	for <linux-serial@archiver.kernel.org>; Thu,  1 Apr 2021 00:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhDAA6S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 20:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhDAA5t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 20:57:49 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53123C061574;
        Wed, 31 Mar 2021 17:57:49 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3B062ADE;
        Wed, 31 Mar 2021 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617238669;
        bh=VeSdxtND3tSvk8Zkgif2XWXT/Is3+dLyTKL7yc7Qvoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qw0d/+b7JOOOzLuE0outZCZECFMgfxfVMs0LradvxSyvSqCYckRGnvUOytFASHby/
         nvFgoetdI4403Wy/K+GX26I48WvL7XsyEeMTRwGdzn23gHUEQkepDyi28Oc/cxXZev
         Wv5fooTglZjs1VKGHJbGL3pTqaRMuSbkpFNFuSyE=
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
Subject: [PATCH v2 3/3] dt-bindings: serial: 8250: add aspeed,sirq-active-high
Date:   Wed, 31 Mar 2021 19:57:02 -0500
Message-Id: <20210401005702.28271-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401005702.28271-1-zev@bewilderbeest.net>
References: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
 <20210401005702.28271-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This provides a simpler, more direct alternative to the deprecated
aspeed,sirq-polarity-sense property for indicating the polarity of
the Aspeed VUART's SIRQ line.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 491b9297432d..e79bb6ab9d2c 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -12,8 +12,9 @@ maintainers:
 allOf:
   - $ref: /schemas/serial.yaml#
   - if:
-      required:
-        - aspeed,sirq-polarity-sense
+      anyOf:
+        - required: [ aspeed,sirq-active-high ]
+        - required: [ aspeed,sirq-polarity-sense ]
     then:
       properties:
         compatible:
@@ -190,6 +191,12 @@ properties:
       applicable to aspeed,ast2500-vuart.
     deprecated: true
 
+  aspeed,sirq-active-high:
+    type: boolean
+    description: |
+      Set to indicate that the SIRQ polarity is active-high (default
+      is active-low).  Only applicable to aspeed,ast2500-vuart.
+
 required:
   - reg
   - interrupts
@@ -228,7 +235,7 @@ examples:
         interrupts = <8>;
         clocks = <&syscon ASPEED_CLK_APB>;
         no-loopback-test;
-        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
+        aspeed,sirq-active-high;
     };
 
 ...
-- 
2.31.1

