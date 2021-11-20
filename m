Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216AC433EF
	for <linux-serial@archiver.kernel.org>; Sat, 20 Nov 2021 01:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhKTBTn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 20:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhKTBTb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 20:19:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CC5C06173E
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 17:16:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id c32so51122202lfv.4
        for <linux-serial@vger.kernel.org>; Fri, 19 Nov 2021 17:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfNL1m1CLPfpevL/yilfuuoESUnF/c6kj518C8lay0o=;
        b=ckzmd2K6lpwIL+o1cbtwd+XLDq007guvpKJFLuT/e/TncNkmS2j9stWk4gf8+ryxtz
         zw8aW03/DoGXCG885ITx4EbPabf+1YO2jE9MFu7I3cSnqHximbyrbB0kz/VDU3diVFAH
         i3dVm/fY+IO/CncSQiGs5Z5eillPziSsS3GFKjCXmK+5uW+CNyR/9OxJC9+lPsV8Ega1
         l6RCxmW8RsTTW8mlNJgL4IxXMRIEkvfw7XrJ6bW4MCYj2pZfP1X79iRxTDpw6egju5yr
         PfusR1JXrnq++qfnEnyb/CRnEloaW8eiZPGIVfj1caREZuaIj5TWb+/f3MAFlX2q4A8J
         2UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfNL1m1CLPfpevL/yilfuuoESUnF/c6kj518C8lay0o=;
        b=FN0teFedQ/mjtvf18+l8ySegZKXYntfcDJDXfvIgXHAJiY5bCLi7CV2JtmjX0nr54c
         oihUnbgqRTy/F1ZlDMVMrWZliOeFK05V1Rz4wq1CP6lkou5TONORYxqTktdkZw5MnCOD
         4OMscOe8GjN8sakFRj7jGeeqXOH5ttT8XjSpOnwITF7NVEyR5Pei9WPYUSvI8GukYF0H
         EvH5eFywM6m8rn5E50sYYRz//Uy5RU1zGsc/foqybqqH/rvKLwaDPRmidKcatxMjcCsr
         G7sLt0+os1akL1TluvQNW3dsI5MEVNE7XKObhOqji0v6pyEsCUtTNjq/h77LPPpB4eIY
         CwMA==
X-Gm-Message-State: AOAM531i2sebS8LWb+ZatJNzqzcPIq9CjJF3IagaKitis3RYGrFl549S
        w3MsflwPqmSUO0lKBfg0FWJPmkhAWNrOKA==
X-Google-Smtp-Source: ABdhPJzq2lm9mo1ugsiCxGdish0u5kuQxXZTMPX+xFE1sXE9G0HeXkUGyb8Ioe8n6Z87PmXuFo1XMQ==
X-Received: by 2002:a19:f10a:: with SMTP id p10mr36273378lfh.487.1637370984874;
        Fri, 19 Nov 2021 17:16:24 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id w36sm151392lfu.81.2021.11.19.17.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:16:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: Add resets to the PL011 bindings
Date:   Sat, 20 Nov 2021 02:14:18 +0100
Message-Id: <20211120011418.2630449-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some PL011 implementations provide a reset line to the silicon
IP block, add a device tree property for this.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Probably it's easiest to apply this to the DT tree.
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 5ea00f8a283d..d8aed84abcd3 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -91,6 +91,9 @@ properties:
       3000ms.
     default: 3000
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.31.1

