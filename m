Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96B4C2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 27 Nov 2020 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1D022259
	for <linux-serial@archiver.kernel.org>; Fri, 27 Nov 2020 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="JqlO0PTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgK0KUP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:20:15 -0500
Received: from mail-eopbgr70138.outbound.protection.outlook.com ([40.107.7.138]:5895
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgK0KUO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Nov 2020 05:20:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+P9f5aVGIGjnhIbUlOyuw0vGT+8TeqBrqSMqjU2HegGOhrhTPhUqYGY79SQOD4Yudq/mgqOlmPXx9VdFMl5PQVHVqcZ/qwj1cxK6foQP7gbNeez96s+SQw5t3Urge9JxYGhvSk2qPwHovPHQA6i7z7tVY/6gLilGvsPzygCgFzQiklLpzWyJYpOH48PPHG03sEhBuLbS2LNn0kq52cHbOCX/coUJ37Ff0sJMmPXIrIS7CBNXqYQjcJi7E9v+rMrBi8bSD68aLGNlZzCs4e/NH8/ZD31nJIrfWWRXxZ+wjPjdDRml7T0uEToO/LLhMFUOEqXbnN8kzcoI98gsDOBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkwKw97yecCkhKDyKRsXe8bE2bT3G9X2MjZB8ZMSU8U=;
 b=mm8t8r7HA2ZsVOJ9K0M1eVo6rs8CjYroagI/OZyjverRBqAB1Su21V7chIBvopri/bd4b01vsIgbuxbp5WVek0Y0ViTP3W0TPf4tX2IZttYSBC4nLRUnGLifdjMZr3i8pFa1JeVwM7ehFV5h27gPcfbk9WdPD+obi4Dl+QxyZXz2JjdbaCeJno+JCEuoYHlXxccaJdk/qbSVT4C1zoHnOxs7VSkaLwU+5iFWb7Sq5glHf5YJ+3Ce+kL553hIEOMg5GsExppRq1gzmBVvivN+jfTJ4f3id1ojogsetsD2XA6Aq+N10XI5RmhqaIn0G6DsolXicdDgkQYnDL5wSc3Duw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkwKw97yecCkhKDyKRsXe8bE2bT3G9X2MjZB8ZMSU8U=;
 b=JqlO0PTCacwGB20UYgLODgTcR1l1nUTciHHsloxTHMj652IfOqBW9FPMbxGKi5992WbCQN1WXZeVSDLikucU9Lh4qLzzek7+FxVi6DGasbM5Z1mocWLMlFQJapgPZqN3n+G7r6as6fIk7Le2pfR2G7pUuxL5fJ0L3R6TbVVlRvw=
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by AM5PR0701MB2897.eurprd07.prod.outlook.com (2603:10a6:203:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Fri, 27 Nov
 2020 10:20:11 +0000
Received: from DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::4a) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 10:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net;
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 DB5EUR03FT009.mail.protection.outlook.com (10.152.20.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 10:20:10 +0000
Received: from ulegcparamis.emea.nsn-net.net (ulegcparamis.emea.nsn-net.net [10.151.74.146])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 0ARAK9Mk015152;
        Fri, 27 Nov 2020 10:20:09 GMT
From:   Alexander A Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-serial@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: uartlite: Support probe deferral
Date:   Fri, 27 Nov 2020 11:19:53 +0100
Message-Id: <20201127101953.23700-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.10.2
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 94f57444-c3d5-40e5-61a8-08d892be05ac
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2897:
X-Microsoft-Antispam-PRVS: <AM5PR0701MB2897750D8EE155FE985CEAD588F80@AM5PR0701MB2897.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uU6qGX0EWbS78JP7DftA7VlqeAXCjjvqcLA8P6ecSa2mj+1I4/z82tFgbhYB0XO3MO1OqfRvus2FjtCYsPGlvkh4vYrJ3I4kFvv3mqz/xnBECtAkuZb3MyWYJClC/2gd7wCANXS6rHj/wjWoD9BeOjGLNjcSzCPjDa3trJV2pF50ud93qCGxL6RFbB5qTXXk2BmZCSq2vNcRNhHSeFvKZsYiVbjHfo7x26v3FgcozEaysSZP1JDp/AqGED1lNbngR1AkoIx6NkfPJYlV127xpQLDSfgVcZ1ryrxRRXMU4/AQGv4PPBRSeHiY2vLigAukyYU3/REFGlmUBgu+AkpqCLi55JO+EZy35ZR+ssRDXI8q8GeSc3qSoCX95LHOn3WSqD32i3e47yu1lWKyBDmziA==
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(70586007)(70206006)(26005)(82310400003)(478600001)(86362001)(4744005)(316002)(54906003)(6666004)(83380400001)(47076004)(2906002)(4326008)(8936002)(5660300002)(8676002)(6916009)(336012)(186003)(356005)(81166007)(82740400003)(2616005)(1076003)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 10:20:10.8610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f57444-c3d5-40e5-61a8-08d892be05ac
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2897
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Give uartlite a chance to be probed when IRQ controller will be finally
available and return potential -EPROBE_DEFER as-is. The condition "<="
has been changed to "<" to follow the recommendation in the header of
platform_get_irq().

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 09379db..f42ccc4 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -773,8 +773,8 @@ static int ulite_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	pdata->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(pdata->clk)) {
-- 
2.10.2

