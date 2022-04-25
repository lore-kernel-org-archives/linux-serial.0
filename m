Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBEC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiDYOib (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbiDYOi3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:38:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCF167D2;
        Mon, 25 Apr 2022 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897325; x=1682433325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dWJ3/7cdmA0pgFsitZuEUw3jz9OX5cH4BT7oF2UsM8c=;
  b=lW3suoFzqymKfFfHM0N/QyxjKep/lxCcKWZA4xmxRFYucCiAQaXEoIyC
   DqeVvOhC9rerYB8AbQLj8xW8fC7tLUUUGNkApDOTyt8sYD3FHPGTM1Yzc
   39s9swz25pJ0IhZdgx/LiEMnYyQF4WK9fxBwz0xNiri6UeWpkkKgXGPz1
   vBqvZHHtCJNozEajO32ysdc+3beAClqQLLLlPS/YiJagVnDXy1cy8I+z4
   zHkFr64FIJA3KcpSVrgxH29QWDfe5VTvixXeqKXQEU2ik1oGmUL2Nh1D3
   7gkmzwB/plvPtf2agWvvATNFOX3l97VpeCpRwhO8f4DxAfFkDZIEz3pkX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247191890"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247191890"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315891"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 06/13] dt_bindings: rs485: Add receiver enable polarity
Date:   Mon, 25 Apr 2022 17:34:03 +0300
Message-Id: <20220425143410.12703-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
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

