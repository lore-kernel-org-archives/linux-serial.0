Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7021C7EE23
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jun 2023 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbjFGMK5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbjFGMKu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 08:10:50 -0400
X-Greylist: delayed 5675 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Jun 2023 05:10:20 PDT
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C031FE6
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 05:10:20 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108]) by mx-outbound21-6.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Jun 2023 12:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBiLna8xw3OOL2GwazjJRBplul6i7T71GCZlgJMovVDAQTqVcsNuPyl2Lkvx8Wji3X4h3ZaGOyjK+31LOF2eDtutgHF/rTlJYN5uV7bAqVMhzIMiCbpA2PsN3Iz2mWCKY2N3aEUCJm6wQHAW/Ui+bacqbHVdpFrWlMlLSbD4pH3QwkabpjEJCInpzp2dsID4Er5thy3JgZrjKC5O67WUUFalFIiRMMnmpHH3B25arWY20Gw8uk9kh2PwyK11qyvDqE7pyMTteBDRrH6UuR4yMzrC6AY7JyRE/J+uu4x2VZ73ZmfIXR0mxaAhz7UkEwKdKSwiZMsBT/1qMi3FQriXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4CjGiu4LHO0SBSzc/6CnNNS5OG3JTW0sOam7yme/No=;
 b=HnEg56AiEi/FPwoXd06yjBeJYGkoFUVnSSnzJZwnUyCZ8vkJ+2okL1y4ObLbYLOgX6YvziO/2AIEuvTQKvtoS6fISfI130hzeRo9MiOX5pNtJnwfq/i5lZh/bfG3oWLRafQA1W0KdTWXVMjvqJ7NdVjcLyZgJBJLdOXhw4HVj3pmB1kWionpgSCaOZfe4JB1/ShSe9I537/6HMANdQHEgCV8RWhyD48JJ8WBRoSOGPwybLawUZWFwIImq/1ncI3MjyrfnVQfPFpjRV81HTT5uG48aZqwCgV2oz68vE8s49/5fGeyOQyXyRV2tGeQqncGq6JD+1n1Ys5P63a2lINQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4CjGiu4LHO0SBSzc/6CnNNS5OG3JTW0sOam7yme/No=;
 b=iPW2dOCrDg/m0VL0Q9PT9ymk24Im0Tlq8695LB+jz4QTChsnT/Tir5sntUDZA4S2Ros//pJi37jhkiCDCOuVaidv6d3S4ejeAWZFn0MbYV1+tkuBHlLH2tLacuJNh7oXlJd9SjOL1PZbQbPPdxltLNcF6FZZ9RLL+rFx0kgphGL6b/MQ/9Dxbu7opFpiuj2Vcd9DbQLA3hNRVHUhxXoi5mEh0BrSTa29MJWm0UiqnLjSQb9Li3l3enQIrk42BKNjSa0KKuka//IiQTOCTth6jYHrkJj8c2SQILH/NicfVj3R/7uCLfLkSVudpqwpxh3foSEyF/0FOA6LKIeagNdIJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SN7PR10MB6497.namprd10.prod.outlook.com (2603:10b6:806:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:35:27 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:35:27 +0000
From:   Robert Hodaszi <robert.hodaszi@digi.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, sherry.sun@nxp.com
Cc:     Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case"
Date:   Wed,  7 Jun 2023 12:34:59 +0200
Message-Id: <20230607103459.1222426-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SN7PR10MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afe8ee5-ac1c-4821-1940-08db6742e89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkXhsqYaIMshtCU2daDM4DiJlk/KHSKx3kTAPfWYXTS5PVIZT7C9vj6MJfV9+OtdK79cYKHz1cEOAji7mkfrcdw/vNIk1VTVbXE7STjQOF9ZAOqJZVA1yKeVdvjnKacCpgWrKP1XE1eJoocDwcuTIKgKU2rYzYagF2v/E/Lo36AbMSyIR2MeGjV1t6bt1gc+aQt+KZda3emqWi7o6f8RcTjyIS4OsqcXayfexP66H4b7N71oo1myrUXu3u1fDguGxauvCIYiSrvAHGY19o9Vb5RTSKGYHPYFko9pa1o099ZiqEWWOxS4ZGLyjvHbTxEViDcj9pNrxSVkKB1uVw5xNSEmQ/EyddqbGnBdsJtOItShV0osJhBPA2ZW+ULwtgGfLgtvWTGJU0N2elVr29yj+hy8RIPxVj/vFAEb9ADBJDFEz9g+BumWB6uQX+BPJCjXZdph9fSEK3dJEio/AFAHGh75QTlFUu4Sx+OR0t8LF/EpFYotBgu6AZUSM5ZT0meXxV22qcLY0EXfZ1P9SBwuxnWIoXFbFFSa2jopRuOjMeAsYB3blcj4A6aeWIen14C56MKh/iPU+3vxCTpgRJSZLOshkQTcjfyvrhfhhKOfHldCEuIthCrRWPuwQ7p2tDrJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(346002)(396003)(376002)(366004)(451199021)(52116002)(6486002)(6666004)(107886003)(26005)(6512007)(6506007)(1076003)(36756003)(2616005)(86362001)(38350700002)(186003)(38100700002)(44832011)(5660300002)(4744005)(316002)(41300700001)(478600001)(66476007)(8936002)(4326008)(66946007)(8676002)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivxLKuwNVQdC0abyVPchmGiwGpNAh3pvp6CrBKNpRnq3/44/RZfwROpxPpbg?=
 =?us-ascii?Q?AllY1OGw/xzF4h7RNmEHij2q8lTiWpfTmYDFazSTzfA8Cet50lkXKV77fsbn?=
 =?us-ascii?Q?RrpfYjcR7c8pn2+5ivcTaggFW0onllznwefWT3Y1Gfe0bpn3xRWcoTQOe6yQ?=
 =?us-ascii?Q?CKNyJ4fQkMWkeNig7y+sfPlp7BmuSSWj05kb2x8JTVqNOmBuV9vhm/IAvXu0?=
 =?us-ascii?Q?V1aflN8r3+3SddlEq5TznhNBzSRWFFZGE3XeK0mkoBNR/rdD+npzyzcMoaBj?=
 =?us-ascii?Q?pLKLPSVsYkXwX6PvQ9f6iNJ6jTNjdhUz6+h7SJci7mtDZWIa049+X3cW1etk?=
 =?us-ascii?Q?GBfmfkSKH89v0saM5BMAhH00kzrbHTcxnTp21LnQUOqTi4AnX88YuPvEXW1D?=
 =?us-ascii?Q?ZorC2Mqg5OlO28DPIMzmMes2YS1/AhYjLsTVaABLtvHaU1yqm32tPjArrpyw?=
 =?us-ascii?Q?htvHsNiljLwZtGgm6JTopd7BZOEdHjJ2P86MaR36hbM1+eg0h1+zWC+/bOp8?=
 =?us-ascii?Q?uMBzcmGFcqKK+cWhDu91V391ne6lnWlDjxKCoPAa4DfPfJhN/m6oppCHrRPa?=
 =?us-ascii?Q?5AzM4qYk6VcJGEHo5e/TQPQGM573CRjYWibckKRa3GDIF8LVHlYpMmI40xuz?=
 =?us-ascii?Q?IvJ/+LCTYqkB0W86GTI9xujFsC3ZAdcQ+icEzYbLqL3SQwRtclcYkNpMoxO4?=
 =?us-ascii?Q?ZN16x5z2Vh734iFTesf3gkPB5D8M0RN0vqE208l7NFyK0bWK5DmTZDkcqaco?=
 =?us-ascii?Q?ExJbu8XQRWkkLoxSBWbA5hupSi1v7x/SfzJZYlrFPznyYNb942Y9BXZNC04+?=
 =?us-ascii?Q?DhwVbmfeVYUKHKVmp1De/5V8PzGjrnRVZV3RdIWODMvu1Lv1HaZrTUr7j2Us?=
 =?us-ascii?Q?4WDxF5e50sSwTmWAUBZ/amOnJinVZKEoZDmoedlGGz4bqOswDdHyrjmPq1PZ?=
 =?us-ascii?Q?dHtAD4a1VxRjaAacrAS0eeTOAH4W1xcBNm5fgEx69MMm6cfiM+Z1oWfKbi5m?=
 =?us-ascii?Q?FVSw2WJxfekOaNo6wG33ijmlXrBQGZEBjRZYl6QKHnnehXot+W4UogKXTNRm?=
 =?us-ascii?Q?4d6Iw4fUpRrgeoH9B38g0B8lm+g8aiD7PjN/n0zy163FUKYNzyDKJxrJJnR5?=
 =?us-ascii?Q?y9AFBXBvfjdTE9MEKGLnseAWwOCht1W1G+1q60+rouTBszKwddGzeu/ybg0w?=
 =?us-ascii?Q?7Y/AXNS6S4sqKOZmjC8kcLUnxI3iIl7xK029x2j2B8Nv/obG+o2j5UIDUHjn?=
 =?us-ascii?Q?VWoPYDQ/bhG6nbij0rqmRpjRwj+2yOnH4DSP2lG1ucthpdEcyIaQ2qV09d5R?=
 =?us-ascii?Q?UL6nlAGYuwR65R+aRZLqHAo9/T+N5cgOsbExieO93inOJ4oYM9/lpEouOSuw?=
 =?us-ascii?Q?DxzsKzO0FJlQcZ42OuoCEPclEMpFH61V+09RxrOQz9VqUbyvhk0AdqGBW5AP?=
 =?us-ascii?Q?1D8rhJnb/Lck44S9oz+Giwlgr90KSBhIypq1PKFimcfdd/lo8mORJ/TCm1Lm?=
 =?us-ascii?Q?s1Q8zzCI9axUGQX/zBafAcTxVxyPrnk9N/eqjnn6QAuxY8EmyakxvYg4Ro+y?=
 =?us-ascii?Q?647SCe8wOcvDogzXH5nKzpZN6sikXi1zrZO+LJ2x?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afe8ee5-ac1c-4821-1940-08db6742e89a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:35:27.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DH39Caw0m/D87W4TQdJ+aEpv03FDmxYJ75/+qpzQmh/iJGgwoYbEOmaM+55ARCWsN6KhXmqEDNTipRTWKYuKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6497
X-BESS-ID: 1686139795-105382-15137-15903-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.58.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGhqZAVgZQMMUyOcUkJTUxKd
        XU2NAoxcjINDHNwtTUMinRwMzSPDlVqTYWAK710fZBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248652 [from 
        cloudscan16-19.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 9ad9df8447547febe9dd09b040f4528a09e495f0.

LSUART's datasheet incorrectly states that RXWATER must be greater than
0. Having that set to 1 is causing a one character delay on the receive
path.

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7486a2b8556c..8f1bb0a378d4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1762,6 +1762,12 @@ static void lpuart32_configure(struct lpuart_port *sport)
 {
 	unsigned long temp;
 
+	if (sport->lpuart_dma_rx_use) {
+		/* RXWATER must be 0 */
+		temp = lpuart32_read(&sport->port, UARTWATER);
+		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
+		lpuart32_write(&sport->port, temp, UARTWATER);
+	}
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
 		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
-- 
2.34.1

