Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C02C433B4
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 00:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE25061108
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 00:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhDBArc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Apr 2021 20:47:32 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:37985 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBAra (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Apr 2021 20:47:30 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 49A4766C;
        Thu,  1 Apr 2021 17:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617324450;
        bh=HUuWcisgz8mM0j4K+ChnHj6gISdfazbbEe9S9nqNiL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsi59j2u4pDUkphWfoAPzzlb+deVykDamP5bGLzw0UbpDznBfSNvKsznlLR96dD5d
         M0eHugf76C2KPTxgxqmGtyoJJpzdV5qV1uyHHhVXjjPKXwO+6gtrCiYXiU/4YIAd+V
         TuFKG4klOxUAoH2DpcQPAEPii5svqXK/BvKWZUcM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
Date:   Thu,  1 Apr 2021 19:47:13 -0500
Message-Id: <20210402004716.15961-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402004716.15961-1-zev@bewilderbeest.net>
References: <20210402004716.15961-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This property ties SIRQ polarity to SCU register bits that don't
necessarily have any direct relationship to it; the only use of it
was removed in commit c82bf6e133d30e0f9172a20807814fa28aef0f67.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f54cae9ff7b2..491b9297432d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -188,6 +188,7 @@ properties:
       offset and bit number to identify how the SIRQ polarity should be
       configured. One possible data source is the LPC/eSPI mode bit. Only
       applicable to aspeed,ast2500-vuart.
+    deprecated: true
 
 required:
   - reg
-- 
2.31.1

