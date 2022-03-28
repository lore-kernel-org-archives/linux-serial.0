Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACC2C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 28 Mar 2022 01:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiC1B3K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Mar 2022 21:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1B3J (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Mar 2022 21:29:09 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 18:27:30 PDT
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8684EF6A
        for <linux-serial@vger.kernel.org>; Sun, 27 Mar 2022 18:27:29 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Mar 2022 10:26:25 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id BD9C12058443;
        Mon, 28 Mar 2022 10:26:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 28 Mar 2022 10:26:25 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 14574B62B7;
        Mon, 28 Mar 2022 10:26:25 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] dt-bindings: serial: uniphier: Add "resets" property as optional
Date:   Mon, 28 Mar 2022 10:26:12 +0900
Message-Id: <1648430772-21786-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UniPhier UART controller has a reset lines from system controller.
Add "resets" property to fix the following warning.

  uniphier-ld11-global.dtb: serial@54006800: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
      From schema: Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/serial/socionext,uniphier-uart.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
index d490c7c4b967..d14d8c9cfe4d 100644
--- a/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
@@ -22,6 +22,9 @@ properties:
   clocks:
     minItems: 1
 
+  resets:
+    minItems: 1
+
   auto-flow-control:
     description: enable automatic flow control support.
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.25.1

