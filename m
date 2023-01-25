Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B7C54E94
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 22:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjAYWPs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbjAYWPq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Jan 2023 17:15:46 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BE6469B;
        Wed, 25 Jan 2023 14:15:24 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id u13-20020a056830118d00b00686def09868so118367otq.7;
        Wed, 25 Jan 2023 14:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDWel5D8K3OWTSDRy2nSxUcJCBLjJjPnl4lOnIvqk60=;
        b=usXyUAy9x9Le2IEIEb8ScuLGO/B9U6xfIdXM080zddQqK3ibXi/u46A5QyAWs9ZWWP
         Hukb/1wbVQM8x/QlZ4iwuDPH42LsGMGJOoe4AsSd8Z4z9Lu4QZVDtJat+cX9ynooZMBj
         qwHNEVKWYWEdIeUbQRbYzJVvb1PiIjhkgVo8Rm3d5WlGbM14MHJwzkqkfMFiJF86nO9G
         RWzNEM5EwkoWpqZVJuLIB+OtXq47VctJQyCpiDx/0B/5vgYLTnfC/z/kuQpho3LVQ40Y
         Ud2W7tG5aTm8hcGHt3l7siMzbx7vGJSWECqPKqy2IUenpxjU1D7MKXrxRtQ7aUWDUIYA
         V5Ig==
X-Gm-Message-State: AFqh2koHmna3mxCYfeo3j4xi2FvZ8jxRO2qvS16K9hYsInSqzn5muuzO
        hKF+KKLaurHYypvi2uFqLJAwnG9XAA==
X-Google-Smtp-Source: AMrXdXsfm+5e7bP6Ez53apRcW5O7aj/QeYKkciZJmLD3Ox1GllFhzNP9fOTlr3s8pMI0Dnt1dM71FQ==
X-Received: by 2002:a9d:7096:0:b0:686:95e1:262c with SMTP id l22-20020a9d7096000000b0068695e1262cmr12246951otj.33.1674684923266;
        Wed, 25 Jan 2023 14:15:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id br27-20020a056830391b00b006864346cbd1sm2682359otb.35.2023.01.25.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:15:22 -0800 (PST)
Received: (nullmailer pid 3059341 invoked by uid 1000);
        Wed, 25 Jan 2023 22:15:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, - <devicetree@vger.kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: 8250: Fix 'aspeed,lpc-io-reg' differing types
Date:   Wed, 25 Jan 2023 16:15:12 -0600
Message-Id: <20230125221513.3059177-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'aspeed,lpc-io-reg' property is also defined in
ipmi/aspeed,ast2400-kcs-bmc.yaml as a 'uint32-array'. Unify it to use
'uint32-array' everywhere.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 34b8e59aa9d4..bf570f17459e 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -200,7 +200,8 @@ properties:
     deprecated: true
 
   aspeed,lpc-io-reg:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    maxItems: 1
     description: |
       The VUART LPC address.  Only applicable to aspeed,ast2500-vuart.
 
-- 
2.39.0

