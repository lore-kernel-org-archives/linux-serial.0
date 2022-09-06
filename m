Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22299ECAAD5
	for <linux-serial@archiver.kernel.org>; Tue,  6 Sep 2022 14:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbiIFOeY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Sep 2022 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbiIFOdf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Sep 2022 10:33:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3E98A41;
        Tue,  6 Sep 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472736; x=1694008736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxAl4C/+GYl9FO0p6O+KZF0I5ZhxVC6ijXZxrd6Fv+Y=;
  b=o+7xicXdzFEcS32OeQr4f8AQxm2pgROJj0kZUBcwZ6GmqZJNc8xEYsNR
   J+/QcbAL3Ca76LyCyZ871EbGKg5eo59mXWpdYepkjjdEzmu2+smY8J36g
   ZGVD6DciP25grXEgi3ShktH1WBP/PuZT3wzuCZfkCnVnDCV617DCE8Ijw
   kU2Uvya1LABYvztvDPZEBrywhZl0r4tXZQ4B3zktGwlIgVgwYg7XJA1Jf
   qg0vZ7CxykWPrOIPiqQarQimFRncz5NvR+ADRIVsjGUP73RMuxDIyPBBS
   47JuhIxXmdr08wg0nbblosinfbuDJNfGETHHvmO3ag8LfW98YCLMzuQGj
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="189613846"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:56:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:56:49 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:56:44 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 03/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
Date:   Tue, 6 Sep 2022 16:55:02 +0300
Message-ID: <20220906135511.144725-4-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Another functionality of FLEXCOM is that of SPI. In order for
the proper validation of the SPI children nodes through the binding
to occur, the proper binding for SPI must be referenced.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- use full schema paths


 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 568da7cb630c..0db0f2728b65 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -78,10 +78,9 @@ patternProperties:
       of USART bindings.
 
   "^spi@[0-9a-f]+$":
-    type: object
+    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
     description:
-      Child node describing SPI. See ../spi/spi_atmel.txt for details
-      of SPI bindings.
+      Child node describing SPI.
 
   "^i2c@[0-9a-f]+$":
     $ref: ../i2c/atmel,at91sam-i2c.yaml
-- 
2.25.1

