Return-Path: <SRS0=Hdmd=67=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81470C433E3
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D4A20735
	for <linux-serial@archiver.kernel.org>; Sun, 17 May 2020 21:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgEQV4e (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45126 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgEQV4e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 17 May 2020 17:56:34 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaRGe-0002am-L3; Sun, 17 May 2020 23:56:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 2/5] dt-bindings: serial: Add binding for rs485 receiver enable GPIO
Date:   Sun, 17 May 2020 23:56:07 +0200
Message-Id: <20200517215610.2131618-3-heiko@sntech.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517215610.2131618-1-heiko@sntech.de>
References: <20200517215610.2131618-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

RS485 has two signals to control transmissions "driver enable" (DE) and
"receiver enable" (RE). DE is already handled via the uarts RTS signal
while the RE signal on most implementations doesn't get handled
separately at all.

As there still will be cases where this is needed though add a gpio
property for declaring this signal pin.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index a9ad17864889..c61226c235f0 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -44,6 +44,10 @@ properties:
    description: enables the receiving of data even while sending data.
    $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-rx-enable-gpios:
+    description: GPIO to handle a separate RS485 receive enable signal
+    maxItems: 1
+
   rs485-term-gpios:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1
-- 
2.25.1

