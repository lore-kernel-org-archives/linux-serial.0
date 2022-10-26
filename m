Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8EFC38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiJZRZV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiJZRZU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 13:25:20 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 10:25:18 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85C476B672;
        Wed, 26 Oct 2022 10:25:16 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id CAF475E898;
        Wed, 26 Oct 2022 19:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666804052;
        bh=ZyqBHi0qzZwUyvfT3QboVMHj6xLTnCn8xFrtj9J/hwk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hLqRmxCNpFO+6liZwMXIb5SVN5jpOh6FG/0zLNsGRYa1OGHbQ5ikup6X+orq0erIW
         oUt5HkVCSIuYvUCzKGHeAsy8IzIE9/fxoe4XbG98DV9Wg9BaSCss6Hp55KciDOeejJ
         lf7ISmEztIvdj4lQaQFp1dOC+1QXJiwirRTsMcNr1rMBiciC1voR3+NQYky+JvkrIL
         dxd4jcqAMP8OLss56FSTEUb7xCNq3aZOR4SqOaqEwtzfBl/tid0h0mJx42JvIRJZlk
         xyVQF1ngHkJIBgrurcYR/yb3oRt4DrcC5WlinRB7SYGmaQIc4JIWG39A/K9GQ4QN49
         Te1E+fFfuHxMA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 26 Oct 2022 18:52:18 +0200
Received: from localhost.localdomain (172.16.51.8) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15 via Frontend Transport; Wed, 26 Oct 2022 18:52:18 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/4] dt_bindings: rs485: Add binding for GPIO that controls Rx enable during Tx
Date:   Wed, 26 Oct 2022 18:50:46 +0200
Message-ID: <20221026165049.9541-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the binding for a generic definition of a GPIO, that controls whether Rx
is connected or disconnected by an electrical circuit to have the ability
to receive the signals on the bus during sending or disable receiving during
sending.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 90a1bab40f05..0ebd7690f85d 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -51,6 +51,10 @@ properties:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1
 
+  rs485-rx-during-tx-gpios:
+    description: GPIO pin to control RS485 Rx enable during Tx.
+    maxItems: 1
+
 additionalProperties: true
 
 ...
-- 
2.11.0

