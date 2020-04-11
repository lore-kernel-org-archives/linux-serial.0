Return-Path: <SRS0=8TmY=53=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E033C2BA2B
	for <linux-serial@archiver.kernel.org>; Sat, 11 Apr 2020 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E930720757
	for <linux-serial@archiver.kernel.org>; Sat, 11 Apr 2020 12:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+PpyUVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDKMeF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:34:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45175 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgDKMeE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Apr 2020 08:34:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id w11so2156848pga.12;
        Sat, 11 Apr 2020 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQZjjDOSKI1dwPpV3FbOsZ5gJfjZttSefQqUm/3OBQg=;
        b=X+PpyUVoxb34SkOZe94dRXLLKOaf/NrlBDFCW/7o6fXNq6i1hGOIJanRVeohvhYa5S
         qFjX3RvoAdheJHZg36gzcnJSMZHMOhMzGxW46UjPdtjO5hMo4Rylv3rlBQBlh2XjRVue
         PT31xvZg5K/9JFYiqOhRpmz66+IgarSSUjJvkX8/kdSbBjYgmuGOHhFJOue5+nVvLFDV
         i4rb3uQtBr4331ZUYcszXbpYRb6sLU6FdAvm0PVTVKF3iW55PdbcP44pNWnC304Pm+Ad
         7a17EqGIDc34Yu24z+qxlDZlZEylr/9wRrpQ9zFHlaZgi2BiTEyaWze4e9RGpX9ympJo
         Qjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQZjjDOSKI1dwPpV3FbOsZ5gJfjZttSefQqUm/3OBQg=;
        b=fmCvpnHneFLzXnq/wwrNC6/fY9AEnF6+PYzT9C4N8TQoHIv5Yrk9zZxB6Dpt76O2FP
         7tyz2JVRuZUYzrxdI8k8XU7Vevi7Qfqvy7p9ISWgCjDWVqKBT+fWV6t01PICS1yiPYem
         nErEaeXWTM/m5QZIEQKL4MBr45/oCKme23mXY2Y8NacujtoY5WksJ43PZQGIHbPvK5bI
         oPqdbJ2vfLQFUnl5Z8hGFnbLIMmguJwuwEemZg+FCNX/eMGG5jpWYLOcff3ICjNaQn8F
         cSJt5iJHAwhEKoghS+n5uyijp0u8VKTlFynX32MOOZOoyZbHK/KDs2GxTL2EOAhvvmim
         ZWbw==
X-Gm-Message-State: AGi0Pubn00pmPIgjGw5o+Wcy1QOJKtXPd32DWxsIHTPeVMbvmHR8alBV
        ArB91rmFnPeRZTMGC199zwk=
X-Google-Smtp-Source: APiQypKwguyuODBP4CsjPnGILxlyGR6I8n0khzaIAffSmN952rST7qQadqSzM2F6GTqMUEORbi9vWg==
X-Received: by 2002:a63:2cd5:: with SMTP id s204mr8547295pgs.71.1586608443019;
        Sat, 11 Apr 2020 05:34:03 -0700 (PDT)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id g2sm4117641pfh.193.2020.04.11.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 05:34:02 -0700 (PDT)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org, krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] dt-bindings: serial: add reg-io-width compatible
Date:   Sat, 11 Apr 2020 21:33:25 +0900
Message-Id: <20200411123325.30501-2-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200411123325.30501-1-hyunki00.koo@gmail.com>
References: <20200411123325.30501-1-hyunki00.koo@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

Add reg-io-width compatible

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v5: first added in this series
v6: clean description of reg-io-width
v7: correct build error on running 'make dt_binding_check' 
---
 .../devicetree/bindings/serial/samsung_uart.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 9d2ce347875b..a57b1233c691 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -29,6 +29,14 @@ properties:
   reg:
     maxItems: 1
 
+  reg-io-width:
+    description: |
+      The size (in bytes) of the IO accesses that should be performed
+      on the device.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 1, 4 ]
+
   clocks:
     minItems: 2
     maxItems: 5
-- 
2.17.1

