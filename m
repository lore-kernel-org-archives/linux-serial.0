Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03859C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 30 Jan 2021 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C485664E10
	for <linux-serial@archiver.kernel.org>; Sat, 30 Jan 2021 14:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhA3Ou6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 30 Jan 2021 09:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhA3Oss (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 30 Jan 2021 09:48:48 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E4C061574;
        Sat, 30 Jan 2021 06:48:07 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a1so5930920qvd.13;
        Sat, 30 Jan 2021 06:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0102XPIBtHmkqk//PEwHujbabWX9vQEJVN3acCy3Bg=;
        b=C4xiYY1/KwPSgtvAoSNYQZtskqWzVtQIU5wHQCyILHtiTZCFJc2WwOpkbkeUkC9LwQ
         t1QLmLalao9nUownX0xNS3iR3PxgwfDXYhOWRp42cYihMG5aPNgmuOaiD/SWVK4ZLa4i
         0V7mmMQHOhjljhjlJ8DVFC9KE6C58BeQADiiK5mB90AGp7TyN9baq0XGzaMF/tFkXVZF
         U2ws0rH/AWBHOJUMtzrL2jmd5vr4k4rH8KoJk4FPD88qwg6knGUTQSTfKt8SlzUAruZ8
         ojZMbv+LZDr+E47mt2OJyvU59Vi2OfG9CXrg+6viK+nrO7FuDUfs1W8fhM9MgJk1wwCu
         sDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0102XPIBtHmkqk//PEwHujbabWX9vQEJVN3acCy3Bg=;
        b=fFB6U0cZtqSkEOI08vCRL0xDQgXtyC60q57My/xqn3XGBF8SFQ8Y9qP6i+/OY6ljHz
         YVCqNy5CSVzlXbRcXIVt4bycZd8RsTOlYhS+LAINbYc8ndw+XUEJlu4ZKmKCCLeO2/gA
         SyzmbkEQpFKsnkbz6xNMh8bKBOZHciGWp9v1S5CkagO2Ps10x2wv9m7nEJbXzIDpECbT
         VpUhmZt5lbp9U/OuADKY9b7DZqMF0q10cx/0U5udiuDn0r9h29F55LM2U90INUz2ZxYK
         AkRQcpIxVs5VfZqlpvBo4cEe7KROUhMl9kpnZiwucxlIqkhPYj+9cd6x7cdc6E+c8Dk8
         WryQ==
X-Gm-Message-State: AOAM531E5N5pxqES85dGcV4RyI+y9DRWFN0U2GTORkjzT3smf6gD9+PN
        qiHQoxu1sL+ouQszeUwkLD8=
X-Google-Smtp-Source: ABdhPJza6GzYPfzdBkqIrTaVyFw8hpdEhhRKKUNYH41Trrei11W65ijDLgHa6Wnm6WtNcYoqQkSYLg==
X-Received: by 2002:ad4:56ef:: with SMTP id cr15mr8407666qvb.45.1612018086979;
        Sat, 30 Jan 2021 06:48:06 -0800 (PST)
Received: from localhost.localdomain ([2804:431:d77e:d35b:c52:e75f:e3d0:6528])
        by smtp.gmail.com with ESMTPSA id h5sm5212129qti.22.2021.01.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 06:48:06 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: serial: imx: Switch to my personal address
Date:   Sat, 30 Jan 2021 11:47:51 -0300
Message-Id: <20210130144751.133641-1-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

My nxp account will expire soon, so switch to my personal e-mail
address.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml  | 2 +-
 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
index 9702c07a6b6c..2b06c6ce4a75 100644
--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
 
 maintainers:
-  - Fabio Estevam <fabio.estevam@nxp.com>
+  - Fabio Estevam <festevam@gmail.com>
 
 allOf:
   - $ref: "serial.yaml"
diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
index ce1d89496342..14c7594c88c6 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Freescale MXS Application UART (AUART)
 
 maintainers:
-  - Fabio Estevam <fabio.estevam@nxp.com>
+  - Fabio Estevam <festevam@gmail.com>
 
 allOf:
   - $ref: "serial.yaml"
-- 
2.25.1

