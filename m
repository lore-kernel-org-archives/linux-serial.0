Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C84C388F9
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 11:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7603420795
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 11:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DBGCCTtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKKL1A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:27:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36290 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKL1A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Nov 2020 06:27:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ABBQvqs038461;
        Wed, 11 Nov 2020 05:26:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605094017;
        bh=fWo/pDkDPv2VDqDbwex0pM/XKhddBQVetHiGj4PDgPE=;
        h=From:To:CC:Subject:Date;
        b=DBGCCTtB9c4Y0Np694tQRWcr5LWMn8MVybCjUDINbwYFrOq+Hnte8h5Yv1ArUEoIM
         mPJ7tMx1AU9VW/OLj4DgaB0nuk8cD/AqExHgt1Rc7IvXzUUAGbL0KU+GTMR3oyw07k
         WaYNdJwp9GA/9DQwHNdCwbZRYpMDTf63r0zPUkTE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ABBQvfw030692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 05:26:57 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 11
 Nov 2020 05:26:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 11 Nov 2020 05:26:56 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ABBQsLB076461;
        Wed, 11 Nov 2020 05:26:54 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] serial: 8250: 8250_omap: Fix possible array out of bounds access
Date:   Wed, 11 Nov 2020 16:56:52 +0530
Message-ID: <20201111112653.2710-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

k3_soc_devices array is missing a sentinel entry which may result in out
of bounds access as reported by kernel KASAN.

Fix this by adding a sentinel entry.

Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 084e7bc51f0e..ab18ef035659 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1199,6 +1199,7 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM65X",  },
 	{ .family = "J721E", .revision = "SR1.0" },
+	{ /* sentinel */ }
 };
 
 static struct omap8250_dma_params am654_dma = {
-- 
2.29.2

