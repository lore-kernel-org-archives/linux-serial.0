Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47ABC2D0E8
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9251620772
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 23:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCYXPD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:15:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40172 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbgCYXOm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 19:14:42 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jHFEH-0007ug-Q3; Thu, 26 Mar 2020 00:14:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        matwey.kornilov@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de, lukas@wunner.de,
        christoph.muellner@theobroma-systems.com,
        giulio.benetti@micronovasrl.com,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH DON'T APPLY v2 2/7] dt-bindings: serial: Add binding for rs485 bus termination GPIO
Date:   Thu, 26 Mar 2020 00:14:17 +0100
Message-Id: <20200325231422.1502366-3-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200325231422.1502366-1-heiko@sntech.de>
References: <20200325231422.1502366-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

Commit e8759ad17d41 ("serial: uapi: Add support for bus termination")
introduced the ability to enable rs485 bus termination from user space.
So far the feature is only used by a single driver, 8250_exar.c, using a
hardcoded GPIO pin specific to Siemens IOT2040 products.

Provide for a more generic solution by allowing specification of an
rs485 bus termination GPIO pin in the device tree.  An upcoming commit
implements support for this pin for any 8250 driver.  The binding is
used in device trees of the "Revolution Pi" PLCs offered by KUNBUS.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Sascha Weisenberger <sascha.weisenberger@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
[moved to yaml rs485 binding]
Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
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
2.24.1

