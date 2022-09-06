Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81897C6FA83
	for <linux-serial@archiver.kernel.org>; Tue,  6 Sep 2022 14:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiIFOhU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Sep 2022 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiIFOgc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Sep 2022 10:36:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE582FA8;
        Tue,  6 Sep 2022 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472806; x=1694008806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=noxCcCO9xTSbTKYwLuG5H1vEfcZMJd3F9cqwqynfP/k=;
  b=lkxebIk75zkzSB34+lRT2w9u4ii5/gsGX1kP5KRF12NE/r+BCl+Xa3PH
   I1sKlgFKjtQrGpvLDpXVX4AhBaYzeUoJ3yHocBUqUhrQVh9ELXX89X6py
   iGolX0QatOb9clgQDTgGe7SbpTMUiMyDzEArz5OWeEDEBLdiVkSzxYJVh
   k1GA5UPP5ojtqM6I6xK5/U+DielLXPcZIEkG+c9kBK1wVaiLC1OrY0Euc
   Rp+zTxZ1ZE9f5FhqF0mYijvKq2P0gi/x/OjP5Z5ATcH0IrJP2rg1tJUqC
   fPpOcjRfvuYbx0Z6dxDRw0OrwoMgDDlcBRah5npEN9SAN+oFh5B48Lp2H
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="172589921"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:56:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:56:38 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:56:33 -0700
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
Subject: [PATCH v2 01/13] spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties
Date:   Tue, 6 Sep 2022 16:55:00 +0300
Message-ID: <20220906135511.144725-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The DT nodes of the SPI IP's may contain DMA related properties so
make sure that the binding is able to properly validate those as
well by making it aware of these optional properties.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before


 .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index d85d54024b2e..4dd973e341e6 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -34,6 +34,16 @@ properties:
   clocks:
     maxItems: 1
 
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   atmel,fifo-size:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-- 
2.25.1

