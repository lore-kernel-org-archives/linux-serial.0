Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811EC47085
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D9E611C9
	for <linux-serial@archiver.kernel.org>; Tue, 25 May 2021 08:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEYIXQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 May 2021 04:23:16 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:37792
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232315AbhEYIXO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 May 2021 04:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laSKR+f9ivM1cGDOpG0ZuQOzqXPEPc6/+fvddiIElTu35qWN5qX4ruc8i0Luj9sdniSLg0JPFOWH7dFS5zMYr/KiYy1rFgwYEikPGuIeKyH9xo4NsTweninwH1XHIN+w8A2CFMxHPOSGpjHJ1sHiUDBc9vQgH/vCbYH5gb5uua/lakOCCkb0T5V32d6Px9AueJg2oXCeP0sAb6utRr5OqSIytfSfwWox3yiFvr8IJObgJJzKJQ09qpm3Gk42tFis4nxsNnBcYkwazta4mKvyk4RbeKZQtL85tIq90mi3nte2NCX09diFhCla9KLYxdhWvykSkoHrgM6VQDBxCfk1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6X08xsbPcIOne/6+VZ93CMNnGREyW+vgAdrycJDELk=;
 b=Jwzi1eTHhbQe5QXOhcDPrCOLW86urbU0Ahr+ufX+tBVwhP2RaUi7aED2bWi+3EU0Wg+xc7dhTnq//s1SYcuCd6B5o3duFxG7Qa0iB3vxrZNnBhCAX5kTZ8Xaq45zfM4zZCzEiHicntucNZptcfdyngOXXyJWVTb0UA4a0mY0Qlpj7Y/AivDoLI3thxinA5YlR3cVUHlsxkckypNu3VEwQ75TroC4pVxOfGO1b6WTAxaPBGnPoF1u71MeK/UrvHaZs8QgNG9MON1PPSF2iKFSy/EbfoKHicpcEWx9yViEXb2uadaGXnmcsm9PxewAVWFKPRKgg4wIljB5vd5d3kf6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6X08xsbPcIOne/6+VZ93CMNnGREyW+vgAdrycJDELk=;
 b=o4B12Up+6rv0zSVErjJrTrEIxo3mdUb8hTmEq4F3KDe3nNlU9wQZ/Mz/aAh2F6WtkBPKTq5FWX4ERWZ9oHaE9R3ljty/eUFuXjSOpNugBTONGfIoVCLIhzOAD+YRsRY1CcO4qHeG96+XGH85GWH5xfcQT0FR7m1sk4cOST48HOo=
Received: from BN0PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:e8::8)
 by CH2PR02MB6072.namprd02.prod.outlook.com (2603:10b6:610:4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 08:04:27 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::c8) by BN0PR04CA0033.outlook.office365.com
 (2603:10b6:408:e8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Tue, 25 May 2021 08:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Tue, 25 May 2021 08:04:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 01:04:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 25 May 2021 01:04:11 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jacmet@sunsite.dk,
 gregkh@linuxfoundation.org
Received: from [10.140.6.59] (port=58378 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1llS2s-0004Kz-Fo; Tue, 25 May 2021 01:04:10 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <git@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] tty: serial: uartlite: Disable clocks in case of errors
Date:   Tue, 25 May 2021 13:34:03 +0530
Message-ID: <1621929844-19727-2-git-send-email-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1621929844-19727-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9d40c4-d783-482b-e4b0-08d91f53b7ed
X-MS-TrafficTypeDiagnostic: CH2PR02MB6072:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6072DE370553DB23351BE757AA259@CH2PR02MB6072.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1DxjrlVqcEE/sOjvruBUlaVPOTxTfUpcMfeEbt/e/zWvAYiJKmJOqYJP/uwWHPYgTpHJQnEDH+vW8pMwxktT3bQQk1pcCv2LwteF7/agzh1mRsoZwFKIcTL3vjV1M2CTbUQe7t4OY9ZuDN5DVU/uEx+h7YETPkNY2yQ6KQ57pw1l4nbac/500KDukG7+kf3pITLtMuYm5zMu46eTOUQk1F88kN9hix1kRH+as1BDXJSexhyjGlG29QF1h2uB03qjxXJCdk9VgcRFm00H9iLKrqYdd1p69L1Jpi/GcoMxq3mWSHGK5MW552IurIpt+0e+bzMzI2/wwnewfvrlycAJvIm/EHJFbhUfwHWh0iUR2+vI867+mkOicVRwbzIQXnZgOUbJP3TlaU6el/OQ2DHdTNlJOv0MQz1IlsFtA3aCIkuT+iHpMlVc+Jzr6nBc31jirpXVqQNTz8wqnddEIJrxBP8D6jzB/+n0mHJk9+KwyxXUjhku/hQ/53Ug9ST3CTSf1gxuSveoENhiTprbHyu1Fq3HtkhiRl2VVeF2eTOgnA2vcJwuO1cssWhYXg5P8D+7Eg6jP6BbKsTbqrkqzPV7+engId212ZdEOzrpCmMT9UmOEsAIwMwRJXrfBZfguiGiIm++DesUIAGPSAj1QZPfdVco57zzNlusfts+nB6HtdC9srRVL8iEuFGSaYfY/aK
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(46966006)(36840700001)(8936002)(7696005)(83380400001)(6916009)(6666004)(2616005)(54906003)(82310400003)(186003)(478600001)(426003)(9786002)(70206006)(70586007)(44832011)(4326008)(336012)(82740400003)(26005)(107886003)(36906005)(316002)(8676002)(4744005)(36756003)(5660300002)(36860700001)(7636003)(356005)(2906002)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 08:04:27.6724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d40c4-d783-482b-e4b0-08d91f53b7ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6072
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In case the uart registration fails the clocks are left enabled.
Disable the clock in case of errors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc4..39ea495 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -799,7 +799,7 @@ static int ulite_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&ulite_uart_driver);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
-			return ret;
+			goto err_out_clk_disable;
 		}
 	}
 
@@ -808,6 +808,10 @@ static int ulite_probe(struct platform_device *pdev)
 	clk_disable(pdata->clk);
 
 	return ret;
+
+err_out_clk_disable:
+	clk_disable_unprepare(pdata->clk);
+	return ret;
 }
 
 static int ulite_remove(struct platform_device *pdev)
-- 
2.1.1

