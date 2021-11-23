Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC26C433FE
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhKWNqw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:46:52 -0500
Received: from buffalo.u-blox.com ([195.34.89.137]:48537 "EHLO
        buffalo.u-blox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhKWNqw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 08:46:52 -0500
Received: from mail_filter (localhost [127.0.0.1])
        by buffalo.u-blox.com (PF_LO_10026) with ESMTP id 97F4F3A224;
        Tue, 23 Nov 2021 14:43:41 +0100 (CET)
Received: from ASSP.nospam (localhost [127.0.0.1])
        by buffalo.u-blox.com (Postfix) with ESMTP id 391C639E54;
        Tue, 23 Nov 2021 14:43:41 +0100 (CET)
Received: from unknown ([127.0.0.1] helo=anyhost.local) by ASSP.nospam with
        SMTP (2.4.7); 23 Nov 2021 14:43:41 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fifJj+0Jfg2I2pmyAyqC9msBPqVBV3NPVEWyNAs0tfgBi5g+YIYFRGtfEp1bziqeSNQHqRSQV5lJ/vll6q+VEuv9e2GUu0MRF1DIDriSTtwpoyTRz0PFE3Cq4iR2UW2zYhKKc5yWMz8dg3gJhSTQE94/L2RYIOIkmohXKFulw78L9IuSChi0cihWE25C7ygriGNyU5G+dEZe8YYNNMffGj85gO/2HVvp6SLEK3ZjhiHvO4tjUijvsfstkq8vT0z1SXHIVfT2NbQUfGV96cabjJbRG1gzBrGvsZ6m0wsoS2B0yDI23pO0yQ45ssCLRdxfmfiTii44c9m3mFZJyZzOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrEHge+esParzzZc1AHn+32I0MVgvWpqqXJu2N10O1w=;
 b=lszT3QB5tqjp2qjZTHu0yv+xy0UUzwG+zJm4jZr+LL6r72gdP5GgyByJlOWVQi8eO/GBOChhHdqxJuR1f//ZBD7E/7UtNI/AWTt2oTuylOlhgM/Cb2t5vxe1+mOjcDQj07NvhbQaStbwe05SdyTWQZ6Xvxvn5cdE4si1yPXA0MXiMSL8Wobh9dY8ScAx+VDx4VC6/3J0s/1ZTOimQ5gLR6/k6cXSC7MWmCpsZqfL0gpTuXKE5i3z2sxzrqmK7kNOcSU3GoHK5r8fGXsbN4TIzeoOCKVhzGIGoV4a7TRf1kkZLxpJaePKUgR4qMOrQzvKvP8pDr80jTdZBBhgZ5YpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=u-blox.com; dmarc=pass action=none header.from=u-blox.com;
 dkim=pass header.d=u-blox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u-blox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrEHge+esParzzZc1AHn+32I0MVgvWpqqXJu2N10O1w=;
 b=WaQfcIb/k7yvuliE61kS3M6VjSxLeKKW8N865SMWtuLmSvHAXYYdUsRfHKeA+Fd3qQ9aistWzGLZNJXda+NFKZp/iSDmxQnGpkwLGjbRoudJSt78YIoPCC4CuLZTzZCaM6TCjnsZ+Q6WCBJxp6OV1O2K9I5sI8dc4oQ4B1se2DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u-blox.com;
From:   Patrik John <patrik.john@u-blox.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Patrik John <patrik.john@u-blox.com>
Subject: [PATCH v3] serial: tegra: Change lower tolerance baud rate limit for tegra20 and tegra30
Date:   Tue, 23 Nov 2021 14:27:38 +0100
Message-Id: <sig.19614244f8.20211123132737.88341-1-patrik.john@u-blox.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0031.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::7) To CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:7c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b4d5b7-493c-4fbc-30bc-08d9ae8528c0
X-MS-TrafficTypeDiagnostic: CWLP265MB3619:
X-Microsoft-Antispam-PRVS: <CWLP265MB3619AFEEBDD80E086B651F85CC609@CWLP265MB3619.GBRP265.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN3MVPoJnKz11h7s2u9i6Mpe7mVGpQ0wrJr16nStB8glH7Q6KD6934VKcfaFkvdCJ067rLIbSV5VvXgVhiVrKHjDo1ZMrPEcIsxugNYUmSPqpnCkMTAv6qlzYmjrBcM45NcYgUkFV/R0khtaLbEo25uBT5R1lRxUPblVwDLoEjm4rBTMCeXyX9Xu7CKCv9vJ/oH7CgzQ0qUQJ68GSjnpUjhuzrHRL5A+ywTxEGaBxyvGMglRcCiLgBnEtBa+BBJ8mlTs/LCcYct36fJEKS1baFM4tMsLuLayNFBsHUxtWPIX7OA3JjuR9HDSHuL3t6TVptVCj3Z+AwCgps1op7e4Yc6pnDFy0iyG++qwlUNbdkLOYjK7l+PirS208FriX0fE5TeJs6cp3fXJdPwnaj1J8T1ZMfWBRRpz9JPvi907UpQ0t6HW90bHsjn5f/sCGmdB8n5Cu90ZvkaGkxSK648eLToUIMK8oNoWmHzUMLsUI7+wcVTsfiAxuSUQqIhrqruoDQ+EmKqY3IymoPm3txD2ZvYWmJaXFj8LzZDiKpYFBbMTO6Ipbxyi6ivBSpITNXq5CdTEe7QuIIKLF7f9WaYykz+g50IgKcfTN1vLYV3mtUb6TuL6xOkGIB5m4tSVRxV85WpShF6yP/e6BJNY/M7SY9+LokQar+KETOUkRGAwhPhCzMEdlrcGeJjlTdOn0vRfA48VWvqWXCR7slwziyou04wipbAgqvG4QnAEUF9T2FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(86362001)(8676002)(52116002)(956004)(107886003)(2906002)(2616005)(6916009)(1076003)(5660300002)(44832011)(38100700002)(38350700002)(8936002)(316002)(36756003)(4326008)(508600001)(186003)(83380400001)(26005)(6512007)(66556008)(66946007)(6506007)(66476007)(16453003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMNcjuy8IrpHaHYvD+TR/YrM3h7aIWpx1EppvLR2W/OmQflDHTpacLqJxYtK?=
 =?us-ascii?Q?lfT6be4EvoV9hDUOrUnCoWuXHwK0GBbRjrvO6xtdHDO77XECc4IWMvJSnUIO?=
 =?us-ascii?Q?kFZl4F3WKxFOixm3t4OAJCD0gG56Ks8vkfTp1WzpxepUodCh8pKH5Vg2ZnJP?=
 =?us-ascii?Q?aZczBntXC5Hor1jHRSSuyfZ81xU9xUujKMvtHvBHsrJ2qAvsZIrdyp01Y+jv?=
 =?us-ascii?Q?qhJN1ZY3wNHzWaNsMbsVk3Jnln9EE9cNZ6IuHXkvjB6sQqTxmILJm1w7Lsfi?=
 =?us-ascii?Q?qyCMUJMD0MTsRCUp/phXbS4yUsxJORW63MoHttybSqHG0c9VDuUXtE6M0cqB?=
 =?us-ascii?Q?95F6+Ur5WCQDHW6jWNUEVlE2Pe5Faplc72mgfx9X/JVIF6cBdXY5hXiL8M1W?=
 =?us-ascii?Q?0EFUj50/R96x3BltdcmOLhxHby7VYq39t30ZPiQZbaWFsgLrxvusmPV8TieQ?=
 =?us-ascii?Q?asm32LdfU5CD3PjxTc2ap9YPKRkL8LbNCAg+tZp6N0D93nzpuM0wmGytY4vp?=
 =?us-ascii?Q?AiEeoodpPiA6XnMl8Thm6CHzQQ6iLaMS4EjoBpAfq5fo+Iv3Ev+Mi2+QtwOu?=
 =?us-ascii?Q?7xpPdCaxJm21YusJzKIzk7mCIyeNS2Bv4hTtxUooWELCBd+NNCPhyWJh3lzs?=
 =?us-ascii?Q?oSZV1g6eOKIeA887WF/3b+S3lf+TamaknJ5neix2NQbbb1Q7i9ulgulu/YG7?=
 =?us-ascii?Q?/Z+IEQ8k6tQRgs0sgOSbxCyNbWTGgA7nSOdwwE3bRn7sSSBvnldipoyUQ4xP?=
 =?us-ascii?Q?NzvQ0DoF3tVwj7Js70vnoee+Yr5s59+aEee0iGz5aB0HgSQr3tut0X7U4z/X?=
 =?us-ascii?Q?EsWrTecQ45L1PIFyBA79yfBRvZ5WPcPC7slfT38OjRSCP6O5412k5887dfxk?=
 =?us-ascii?Q?0HG75NEYLWeLw/Rsnb1os9uM309KRRGjR7/hpdnuc/3nknK5lUDR6rlo0J5C?=
 =?us-ascii?Q?C2LwzQSE1Y0M1grke4+bgqqaAqT7phK2gClVXTvl+9iNoUgM0riXV30YN0Sc?=
 =?us-ascii?Q?xdrtEWFHjD9F/j0g+c4adIMl3MCMRpFWAMOOzn1uEvEvTg3F9IveFvuwHY29?=
 =?us-ascii?Q?EFGxBF65ZQp6I/RPYfaZV5UJ6rvWesP1UC6pcw8SsFjccHZ7hyw4FGq/YsNn?=
 =?us-ascii?Q?5InKoIrgMhC64n+2K61NBaeVduSuVKTIdtAul+3+RiO8o+MzsQ/Ygxh0Nt4J?=
 =?us-ascii?Q?H5X1mrl2Xo8QHJWjVAOjyYp1J/UCMbWO8bYFkPFviQxHaS/UbDPffdtK2jKF?=
 =?us-ascii?Q?FkFHJXY1o3EKzwvcVRxjwJvIOMKZuqB7rEcT6iPXtrxMm8id/ugzrPATGd9q?=
 =?us-ascii?Q?w+xyXtYuz9Xs/mbqICKDkxjwcdVa4j/8gOVpg0psuxfDv9N+coWW2lnIz2jP?=
 =?us-ascii?Q?YLaUFkCyWN4a175Xk1xlAhEyjgE0A8YsYMgVkAV8gBiRwRcPO6XJlMejFaYl?=
 =?us-ascii?Q?vbCDkqf1cowrBJw4vTbpWuepWyR2JaPLOkyIzKL/LbszKEZS+tmZEk0iaN3e?=
 =?us-ascii?Q?9z6qpZMK93l8gzORhMvnPTxFPBWIgY73JHV84FCNVmeNZG7cNJFYiDmXwPYG?=
 =?us-ascii?Q?ie+BzcU+by22Nw3Pk3rqqs9LqFFRRC+maL+SqYDekW/mDkqeLSOy3+Kwg4m4?=
 =?us-ascii?Q?pGwcXrcKaWcD5wmJ5NxG2y8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b4d5b7-493c-4fbc-30bc-08d9ae8528c0
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2072.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 13:28:38.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80c4ffa6-7511-4bba-9f03-e5872a660c9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pB4zbZNoWFPGIdqjJCKudj0k5oCeZkgebMTTtFuONCDY1B19MuRoQzjjEf135ylt0TebksRAEkuX1nzbe/VyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3619
X-OriginatorOrg: u-blox.com
X-Assp-Version: 2.4.7(16004) on ASSP.nospam
X-Assp-ID: ASSP.nospam 75021-21789
X-Assp-Session: 43F7A368 (mail 1)
X-Assp-Original-Subject: [PATCH v3] serial: tegra: Change lower tolerance
        baud rate limit for tegra20 and tegra30
X-Virus-Scanned: clamav-milter 0.99.4 at buffalo
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The current implementation uses 0 as lower limit for the baud rate
tolerance for tegra20 and tegra30 chips which causes isses on UART
initialization as soon as baud rate clock is lower than required even
when within the standard UART tolerance of +/- 4%.

This fix aligns the implementation with the initial commit description
of +/- 4% tolerance for tegra chips other than tegra186 and
tegra194.

Fixes: d781ec21bae6 ("serial: tegra: report clk rate errors")
Signed-off-by: Patrik John <patrik.john@u-blox.com>
---
This issue has been present since 5.4-rc1 and is applicable
to 5.4.y and 5.10.y longterm releases as well. 

Changes in v3:
- Changed Subject to be more precise
- Reworked commit message to meet guidelines
- Added Patch versions
Changes in v2:
- Fixed errors reported by Greg's bot  
 
 drivers/tty/serial/serial-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 45e2e4109acd..b6223fab0687 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1506,7 +1506,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
@@ -1517,7 +1517,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.fifo_mode_enable_status	= false,
 	.uart_max_port			= 5,
 	.max_dma_burst_bytes		= 4,
-	.error_tolerance_low_range	= 0,
+	.error_tolerance_low_range	= -4,
 	.error_tolerance_high_range	= 4,
 };
 
-- 
2.25.1

