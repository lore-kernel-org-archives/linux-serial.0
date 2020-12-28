Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E4BC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 28 Dec 2020 11:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B4322583
	for <linux-serial@archiver.kernel.org>; Mon, 28 Dec 2020 11:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgL1L2A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:28:00 -0500
Received: from www.zeus03.de ([194.117.254.33]:37504 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgL1L2A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Dec 2020 06:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Byoyy+B9mzgrx3
        L4cV+yYJa2qI4pVWuNLLGAgEHuFlw=; b=ZpagOnKCjEdIswsOfd9pm1+ZAO2q3F
        iSyvnIEBoaBndiEOCLgM1fBySIyp8dyDkY+T9LpvVd7PomhWmvroAvWH5RPmWniU
        Uu2YxsVHHko+6HqcoVJKPccADWdCDpM1rRuvkspk0L+/E6FYwMT/Tlax+2f8KI5M
        +R+Gx3UG6XjDU=
Received: (qmail 1739073 invoked from network); 28 Dec 2020 12:27:17 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Dec 2020 12:27:17 +0100
X-UD-Smtp-Session: l3s3148p1@nU12joS3ypQgAwDPXwIpAOUwDQytQs2L
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: serial: renesas,hscif: Add r8a779a0 support
Date:   Mon, 28 Dec 2020 12:27:10 +0100
Message-Id: <20201228112715.14947-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228112715.14947-1-wsa+renesas@sang-engineering.com>
References: <20201228112715.14947-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
index c139c5edb93e..512a84942f78 100644
--- a/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,hscif.yaml
@@ -51,6 +51,7 @@ properties:
               - renesas,hscif-r8a77980     # R-Car V3H
               - renesas,hscif-r8a77990     # R-Car E3
               - renesas,hscif-r8a77995     # R-Car D3
+              - renesas,hscif-r8a779a0     # R-Car V3U
           - const: renesas,rcar-gen3-hscif # R-Car Gen3 and RZ/G2
           - const: renesas,hscif           # generic HSCIF compatible UART
 
-- 
2.29.2

