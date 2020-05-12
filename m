Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD2C54E8B
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E22D20674
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgELMru (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:50 -0400
Received: from mailout3.hostsharing.net ([176.9.242.54]:54785 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbgELMru (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 08:47:50 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id B829C101C01C0;
        Tue, 12 May 2020 14:47:47 +0200 (CEST)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 14486627549D;
        Tue, 12 May 2020 14:47:46 +0200 (CEST)
X-Mailbox-Line: From 3d32e182ebefce6144844adf12fe481a35580633 Mon Sep 17 00:00:00 2001
Message-Id: <3d32e182ebefce6144844adf12fe481a35580633.1589285874.git.lukas@wunner.de>
In-Reply-To: <cover.1589285873.git.lukas@wunner.de>
References: <cover.1589285873.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 12 May 2020 14:40:03 +0200
Subject: [PATCH v2 3/4] dt-bindings: serial: Add binding for rs485 bus
 termination GPIO
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
introduced the ability to enable rs485 bus termination from user space.
So far the feature is only used by a single driver, 8250_exar.c, using a
hardcoded GPIO pin specific to Siemens IOT2040 products.

Provide for a more generic solution by allowing specification of an
rs485 bus termination GPIO pin in the device tree.  An upcoming commit
implements support for this pin for any 8250 driver.  The binding is
used in device trees of the "Revolution Pi" PLCs offered by KUNBUS.

[Heiko Stuebner converted the binding to YAML, hence his Signed-off-by.]

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index d4beaf11222d..a9ad17864889 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -43,3 +43,7 @@ properties:
   rs485-rx-during-tx:
    description: enables the receiving of data even while sending data.
    $ref: /schemas/types.yaml#/definitions/flag
+
+  rs485-term-gpios:
+    description: GPIO pin to enable RS485 bus termination.
+    maxItems: 1
-- 
2.26.2

