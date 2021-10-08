Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA045C433FE
	for <linux-serial@archiver.kernel.org>; Fri,  8 Oct 2021 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24F760FA0
	for <linux-serial@archiver.kernel.org>; Fri,  8 Oct 2021 23:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhJHX4n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:56:43 -0400
Received: from ixit.cz ([94.230.151.217]:54570 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243797AbhJHX4n (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Oct 2021 19:56:43 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id E98F223B26;
        Sat,  9 Oct 2021 01:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1633737285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Jjj+dkLqcm62HXFhe382RlEs6G3aC/Y2l1+WVv+UoqA=;
        b=b7TQs3ZQsaGwmjrwgHMxr6Q1+A4FeewOid4w0kWt61k3Di5KF7t9lro8atCfMRDRvYSNU5
        FgyDc38pNJhVL0JvYr01JQE8UAu0RaJw24+v43UWeeUJd1j9wneP+yPd6mAh5cfPsJWqbt
        8AeLM+4PdZP7Q76tmVwd0/2KXc7bdaE=
From:   David Heidelberg <david@ixit.cz>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] dt-bindings: serial: uartlite: drop $ref for -bits property
Date:   Sat,  9 Oct 2021 01:43:12 +0200
Message-Id: <20211008234312.61688-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes warning:
Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml: properties:xlnx,data-bits: {'const': '$ref'} is not allowed for '$ref'
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index b8a2bfe14bed..f7617b88c7c3 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -38,7 +38,6 @@ properties:
       The fixed baud rate that the device was configured for.
 
   xlnx,data-bits:
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [5, 6, 7, 8]
     description:
       The fixed number of data bits that the device was configured for.
-- 
2.33.0

