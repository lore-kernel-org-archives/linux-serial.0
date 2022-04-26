Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1083BC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 12:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349930AbiDZMac (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346338AbiDZMaT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 08:30:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875CE689BB;
        Tue, 26 Apr 2022 05:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976032; x=1682512032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWJ3/7cdmA0pgFsitZuEUw3jz9OX5cH4BT7oF2UsM8c=;
  b=SfWUDtC3YfnsmsilBsKAZkukokEz3xifK7eCSKiclox5jaaG7tQVYfF5
   kmgdRD9HdkI7sVvfj3SUBaB8Zpv5Plxcye+/AZyg6gIdiKLearmJXqHs5
   SZBJPi2l4j4BCCXa0EaWADsyu0dKtwqRzB5sgnZ4y2ZinitKpzqPHYql7
   BNF6olYQaaAszZ6CZpLq3U90zXraUQj7xx3pR58p7J63LScsnI+CEUNlt
   bZ3I/B8ZMfLimd+x3Hed4znkTpnrO/VbZ3SLQq/NWd5DpKiKtHyUbW92H
   o+ytgDgVTFyAurKcdEkVM2sOpAv+82/1ZuAffPP2pFQOSNh3/MKzgypqQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265724736"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265724736"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579864855"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 03/10] dt_bindings: rs485: Add receiver enable polarity
Date:   Tue, 26 Apr 2022 15:24:41 +0300
Message-Id: <20220426122448.38997-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add polarity property for receiver enable. Some UARTs have separate
enable pins for tx (RTS or DE) and rx (RE). As most RS485 transceivers
have !RE pin, the default is active low in contrast to
rs485-rts-active-low that defaults to active high.

Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 0c9fa694f85c..f2c9c9fe6aa7 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -33,6 +33,11 @@ properties:
     description: drive RTS low when sending (default is high).
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-rx-active-high:
+    description: Polarity of receiver enable signal (when separate from RTS).
+      True indicates active high (default is low).
+    $ref: /schemas/types.yaml#/definitions/flag
+
   linux,rs485-enabled-at-boot-time:
     description: enables the rs485 feature at boot time. It can be disabled
       later with proper ioctl.
-- 
2.30.2

