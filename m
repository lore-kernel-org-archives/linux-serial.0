Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB3C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbiDKIgM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiDKIgK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67D3E5FC;
        Mon, 11 Apr 2022 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666037; x=1681202037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eUnDT/tQIKoHsmCis2wzCbJm/ia4pS4SboD/+n1ghGM=;
  b=ZiJS5xFd3+/s7ZVYjw9QFDu+N7nyvAHDFXold7GFh3Tu4NUxg22ONqfO
   vKxeX7e4ceYFPu6XEubps3doZJN1ET2SS1/bnxsauMjJZTWJv0fZnJbng
   jvrh5CXLFhygmZKjfrRhks2WhHkximPcX1GI1CW0tWm0yrQgcuTd9wSjS
   Hq8nCK1uW5wp9F3o6gylvT6+vlxN+2HFoXQs7jhncXA/I+x7M9j4kKv6D
   mk5xGB77FdE7Tm7EOOzHDZCmwhp4W6CsMEDOa3JE8jGY7SXIbD6bMVrKX
   X+5tvAlD/5I5hurm4g254cEwoaZr96IFBDmcCfGfn+RBJqdsLugPFiy+z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511578"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028660"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/12] dt_bindings: rs485: Add receiver enable polarity
Date:   Mon, 11 Apr 2022 11:33:14 +0300
Message-Id: <20220411083321.9131-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add polarity property for receiver enable. Some UARTs have
separate enable pins for tx (RTS or DE) and rx (RE). As most
RS485 transceivers have !RE pin, the default is active low in
contrast to rs485-rts-active-low that defaults to active high.

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

