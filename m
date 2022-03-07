Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD5C433F5
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiCGIxB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCGIw4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:52:56 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 00:52:02 PST
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4238DA7
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646643122;
  x=1678179122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekguUk0KzuP5PfnRbRQ7Z6M8KIo5vTJCTcKv41k1QyM=;
  b=Op+sjrDUnQQ/ftcxdZlgVaWOE7LEDZFo8qH6jERNtMMyu0gQqFegVQyH
   OcRbW8yXIwOsJ+M4yq57tH0bF+fr0FiznwkeByKmv0T3CnzQ0rTwBJZ3D
   9+u4JapG0/fQZFVFOvTfmVMbzFb2cQExWjMJYk2wT/b4LxYkrxUDW3Xrd
   CiELcMSp0/wlCbfzH6i7LQTb+sxDRzPBKF18cZ2ybRMjGNAbiCb4noydN
   dpf/9yu5RsIxusNs51nByv/PB7P5dIGMvThj4eilonM/qRi4Xd7qpSOsL
   8kA/w3SkiMc0YplrdwqZioBGvFxmZ4Nlb4FNg0EPRzqfYsoHd7sRatMSV
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Date:   Mon, 7 Mar 2022 09:50:52 +0100
Message-ID: <20220307085053.1636475-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a compatible for the UART on the ARTPEC-8 SoC.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 6aceba4a5f79..6f11f2c92f64 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - apple,s5l-uart
+          - axis,artpec8-uart
           - samsung,s3c2410-uart
           - samsung,s3c2412-uart
           - samsung,s3c2440-uart
-- 
2.34.1

