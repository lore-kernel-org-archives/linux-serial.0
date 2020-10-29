Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8CFC2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 09:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FBF2087E
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 09:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u+MwJPf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ2JPv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 05:15:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJ2JPv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 05:15:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09T6rZJV027445;
        Thu, 29 Oct 2020 01:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603954415;
        bh=Uj2WSfW40NwYUeQl1IOQEoFY0udal0p+GCR1CaiIqg0=;
        h=From:To:CC:Subject:Date;
        b=u+MwJPf1vmkt02iyF6pOebULNpLxlVgj473d3a/HBSVfMHKrm3RPigaXE69zBb0PM
         SYmkmsEz+UVPzEmx9CY9KXU2TlBtSWBVe6r5g+zsqqealMhElJdCFarHqgvTcfZWrQ
         c3EQ0sHDCRucLRHluP/Gv3Yv47E8cIcOxb8M3LJ0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09T6rZw8027230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 01:53:35 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 01:53:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 01:53:35 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09T6rV7t014173;
        Thu, 29 Oct 2020 01:53:32 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH] dt-bindings: serial: 8250_omap: Add compatible for UART controller on AM64 SoC
Date:   Thu, 29 Oct 2020 12:23:18 +0530
Message-ID: <20201029065318.2437-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

AM64 uses a UART controller that is compatible with AM654 UART.
Introduce a specific compatible to help handle the differences if
necessary.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index dcba86b0a0d0..c2db8cabf2ab 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -1,6 +1,7 @@
 OMAP UART controller
 
 Required properties:
+- compatible : should be "ti,am64-uart", "ti,am654-uart" for AM64 controllers
 - compatible : should be "ti,j721e-uart", "ti,am654-uart" for J721E controllers
 - compatible : should be "ti,am654-uart" for AM654 controllers
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
-- 
2.29.0

