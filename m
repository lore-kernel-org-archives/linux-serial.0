Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A92DC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Apr 2022 08:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiDDIcC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbiDDIcA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 04:32:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E8B17074;
        Mon,  4 Apr 2022 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649061005; x=1680597005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6nfPvqmO8X54BLq371zwzoCjgOCeVVDag0cH5KXjvY=;
  b=jIJ0BVnftt9DTPbXTwdqpsso2+JDs/GKSQNqFjFIm5b1h9857x5qrnpP
   ivKbFz4GFkPlDEBj/8sSLlSR5OrZP+kywy6QDgf0/ljFhIziJxWw7qnE6
   OM8WX6qN0kxI8O1O/v2T6R8wLviVkh4DJl3G/KWAkN1yd7Y4TK/6x1sCa
   /d5Z0HW49ZpxT8zQQ2j5n7UjTH28gce7Qpof9varqOKPN7gX5wXovGs0f
   Qj7T4lHyqxBjIYe5vHLXj+qeJAamsFTNsSqQxBZZGyMGJ3uC+s0NFeg2B
   Vgi42BYIM6TWR/8gvKEzGgvsZxEPMmXgWHiXDZm8mtqsE2Q4l7F8ZYtxi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="258046448"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="258046448"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293413"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:00 -0700
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
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 05/12] dt_bindings: rs485: Add receiver enable polarity
Date:   Mon,  4 Apr 2022 11:29:05 +0300
Message-Id: <20220404082912.6885-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
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

