Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F254C4321E
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 07:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbhKXHiR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 02:38:17 -0500
Received: from marcansoft.com ([212.63.210.85]:52732 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241267AbhKXHiM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 02:38:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2D62F4267B;
        Wed, 24 Nov 2021 07:34:56 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 05/11] dt-bindings: interrupt-controller: apple,aic: Add power-domains property
Date:   Wed, 24 Nov 2021 16:34:15 +0900
Message-Id: <20211124073419.181799-6-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124073419.181799-1-marcan@marcan.st>
References: <20211124073419.181799-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This will bind to the PMGR pwrstate nodes that control power/clock
gating to SoC blocks. The AIC driver doesn't do runtime-pm and likely
never will (since it is system-critical), but it makes sense to describe
the power domain relationship the devicetree properly.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/interrupt-controller/apple,aic.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index cf6c091a07b1..97359024709a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -65,6 +65,9 @@ properties:
       Specifies base physical address and size of the AIC registers.
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - '#interrupt-cells'
-- 
2.33.0

