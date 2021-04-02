Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E72C43461
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D21461163
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhDBS1i (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbhDBS1h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 14:27:37 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52297C0613E6;
        Fri,  2 Apr 2021 11:27:36 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id D76055DB;
        Fri,  2 Apr 2021 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617388055;
        bh=HUuWcisgz8mM0j4K+ChnHj6gISdfazbbEe9S9nqNiL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pB+66UVkVi2IC14YG9aYR0ILjwUk0epzoMy1KJi1bbimp9ivSjLXimvKme7Ctg3PB
         G2fqQzGyGA6i8bujF25xgEmG8AJ7EqC9DyU5EOJ6XqiMCMWXNnxqmbgq3npKuAOwX2
         6v00Ct0NTWFS3/L6cZvAxHzYYSUf3yrwwqIryy5U=
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
Subject: [PATCH v4 1/4] dt-bindings: serial: 8250: deprecate aspeed,sirq-polarity-sense
Date:   Fri,  2 Apr 2021 13:27:21 -0500
Message-Id: <20210402182724.20848-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402182724.20848-1-zev@bewilderbeest.net>
References: <20210402182724.20848-1-zev@bewilderbeest.net>
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

