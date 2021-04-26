Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A96C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A538608FC
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhDZH5E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:57:04 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:28494
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232246AbhDZHwv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 03:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOczV6PxRlHuXWZLqan2L0TViiQX0P85vHteCQurfj5P/f8cs6u/s94Br8qaR5Fui2CzZMJiZMN1TqRFe2asbiZ5td/1OBE6KKdoSOYoFu7GF87igKDBavkQyQQU5ddfb5ODLOdo9ka7Oh2MfC69S1A0RYwgWrewp1xbKiZqO1x8uRS//V0G1rYGEfWguT7x9Cpdbk7TksodJ8W47SYBeftooifyIABMjBu2QJPadP0jgz4QxmnNvpEOxBK2o29i5giukNT8PS5KyftsB1TD+b5egrteoabtsiF/BFhP/dv5UIBjVZ5LPjxG/FiK1hnsnIsLNzYWa7K0EE36MU6j0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAGOBBlt3m0TBYK/BMAKXUH6cqyeMW2XA/eTlPTaXRI=;
 b=OC8C/abyiUJWEPNm4DTe1MOqwuabILy9A/b9kmcQFwfEsEuGh8VPEEMjaSbnRBIugS3BDFO24AA/OMPdSHhTKUOPEdAck++CinuOIb/f1hTDNaM0ZmY6RVYDq/09MJLGCP/mmT/56ygyBU3iiJfVrFAy/IQtiElE2b5Mre8dk7H7QVPWQbPRSSCwmhaFXlAfRbWzo+fo660PuqJ/muSCFeph+vxHffUU5heC3APWXv+bxGmMM07ZfhdaASxhqNMosm4+kqltAgc8YAmYAUSspq38GnwrO0ayXFzBf61Si9682l/0B8bgKWDq1TqASt9tvo6A/5FxF45mf4EzrJwGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAGOBBlt3m0TBYK/BMAKXUH6cqyeMW2XA/eTlPTaXRI=;
 b=kn9uX+5r12sKTiTe07LdMFpOQ+Bf7grs24Qt/692wk3z0dADYj28otvuhKmz3QIzSZd6opdM2H6CkIG4pTCB/id3cXSkvPkLVGSckjJKxf/qo0Nkje2PkxSdQiYcpzRR3yJDHaKMkFfsiBG3E+1hz2w7jJbLKz6VRrMSre+yAxo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 07:51:09 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:51:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of dereference null return value
Date:   Mon, 26 Apr 2021 15:49:35 +0800
Message-Id: <20210426074935.11131-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210426074935.11131-1-sherry.sun@nxp.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:c8::16) To AM0PR04MB4947.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HKAPR03CA0011.apcprd03.prod.outlook.com (2603:1096:203:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19 via Frontend Transport; Mon, 26 Apr 2021 07:51:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ebbeb79-4ca0-4fd7-a7b7-08d908880dab
X-MS-TrafficTypeDiagnostic: AM8PR04MB7762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB776217AE159F2BE4B126DBB992429@AM8PR04MB7762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GabREj8nesEB78CdPE/0khATxGMSSo7VWcqsLkvsmkktQX2zzQNP3xWrKHT56PKa9ykoZPCMCZ2l3YitpQut4niLbZi14JAARwD6EBQMOoNppqYdxv+03kQrCpb2pZtEQpV6gZal/5UppxS/ReQTmcOEszHtCQEDOXb7Tq0PTrrSWSrQq5PTR1i3GxIhfhvCWtwCjDwwyLdCPsE7qidiveE77TXlgdWViT7C6R/lumbcyOQlvNyQrLAU2J0kaXthfW3i9zHMwSvBZTlQPcn2Z+8u7br1+CWWVVG3bBMLPdHfMoy3qZR0Zyj7yx8M+MgokZzld5B1GANGm3vGO+wd0968SCeP3MGPGsFTl4fuRXs0GxQCglzRfKCzHmwEJVQakBcLx0Oj1WSWr9lqentLm5Tx2YxCyQMEa2hUt9wzqNTg1/4XiunyS+ki/zeTrz79c28I6IiFz12ZaVFjbhjr8YxeC6iq/VhmZF/z29i+qR6QFmqSGZO1Otpcmut0FlELUki2/+Ft5eykH0TtpKPZcXGglx7dfTN4eUF0P0ctcTf0hDRYWqFsSg7SwGxPb1THiWuXYEtp6dwmlvmxZA/tS6w1TIaM1wEj7Zb94mm3mXfi6Hz1RLIr2/FFx4T/8MNGfSZWY7P+Cm0Higw/yJMITB9NsxDGt2L3T9C3cvUm2kxqrG8HE73EM43FNELnDuMa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8676002)(316002)(2906002)(66476007)(4744005)(4326008)(26005)(186003)(1076003)(16526019)(38100700002)(38350700002)(36756003)(6512007)(44832011)(52116002)(6666004)(86362001)(2616005)(6506007)(478600001)(5660300002)(956004)(6486002)(8936002)(66946007)(66556008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/9T48CE8j4e7aD60xyegeXeKcwPZhSxPus62yYjDeZpC4iM2EGZEyUSuyRD6?=
 =?us-ascii?Q?TLV91k5zxldRC7sL7cxuN5naHusLRoUv2dyh5wg25YKwnGt2lR5cXndEZoIW?=
 =?us-ascii?Q?FQj8G2StAYD+2fWwa1eCxV7QvxbdmiKiNpXA4fBHxooRbBt6Sj2kJkOXu4wr?=
 =?us-ascii?Q?n7dmln8KH6dJCWgHrVUmkRGXVH0lFVOxVk3B0QHaXqB4jDvDO70LyRyFIrXF?=
 =?us-ascii?Q?+aKjOnrBBTyYzbXuzqRKeC/5V3GGd3nTj0mOKrDlTAncPnkVvAJOo6zSF8aS?=
 =?us-ascii?Q?FWuL1BAINhjm9yKlyvDK601ZzSKqAvx4Wd9Fw60Z8oJc73R/FWLKmYXh3tA5?=
 =?us-ascii?Q?Hzu7wQn4tZvEmoNzOQH8qr2s7YDvL0MvKVOgc5N+U9lBFC0T6G/NhYw+2Ijq?=
 =?us-ascii?Q?4qrnMuj6YiSbhmFf9Otcb1kieedRy+II3Wr4gREbTkmv0h5AEhQUMu2xuy/z?=
 =?us-ascii?Q?uSMd36BGeMDlm4T31sxo05DjDEVRwQc4V66bIgy0QnmxToU7vu/hFrxt2zIs?=
 =?us-ascii?Q?kqFpm/HrkniG9sx0wamYE96PmSADdmajWJJbv7/ccm4YYneMNpLnhilMAiYW?=
 =?us-ascii?Q?JJBJJL2cvr/abcbhJbHtPCwPMGkaB/9hdgBmLKJpsOwdMUhvxN2u5K0MW5Fu?=
 =?us-ascii?Q?hd3MWpq5DQmAh+gEbukInm+BqMLP6cWiwKogzid4NYVHVbTHLOEYLzDOpHyt?=
 =?us-ascii?Q?UMaGR2nEaliCZnl/6r8s3N14YToPLioAxLIJmxeIXVSvBUNIC2dX0d3C0P2O?=
 =?us-ascii?Q?uv6TM4hewft/+WRTTIE8DWwctDRWhg9FhVFauBnkYCOE0thXitS2P40Eh47H?=
 =?us-ascii?Q?1BcPoZULBa/MI2J//v7xrRIpE2gMMrOyukPFjCwxOn7RNWSxKMoyC4Xe5iSa?=
 =?us-ascii?Q?CKo55R0HgEOeLg/vJgdzivCu89+YfbnSCvVTjKjQY4rR+Ugabp9bjfaIWXKE?=
 =?us-ascii?Q?nftlrlgdilxpCrfzT456hyF3DvzOAebTdJraGfUBI6NS6Vcbagv++UR2CiPs?=
 =?us-ascii?Q?iFCpZ1Rmesnv5rhaSLHWOGCPIFNHrpI5wB9WdV3mJfV0f8d6DZGQaUdZcbfr?=
 =?us-ascii?Q?94n8hsHJ5+93ZrT9e1OiBiPhEf5YT0JPzX7YKIIY6PEQ20bm03Q+IIhHmbxX?=
 =?us-ascii?Q?tWK2XWsm0sOlhtZHXPHpAf1qvNKsElljWuy/8NlPu1iKe2C/eD309GydQzSt?=
 =?us-ascii?Q?kArjvZtvb8lTxt8bTgPXwtiv2n5BSoxUlQ4Tfc+PEFK2hy7fT858gp5biH5F?=
 =?us-ascii?Q?R5p3k8CttjH8R9bm4G7HQ1cF332/K3OMqnINywNBiNPuQ6nIwV4M0N6yDxlB?=
 =?us-ascii?Q?eEqa2PORq8n0otyhZ8KzRzKR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebbeb79-4ca0-4fd7-a7b7-08d908880dab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 07:51:09.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gabu5OD6DVpgEDdXtN4R1/8lkzg1OTH9s4uZUU2K17Q+GAOTYMUutcvPlp9U7ZRDX+5sslZMU4YvSn2OoqB3Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This issue is reported by Coverity Check.
In lpuart_probe, return value of function which returns null is
dereferenced without checking.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 777d54b593f8..c95e71fd2ca0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2589,6 +2589,9 @@ static int lpuart_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
+	if (!sdata)
+		return -ENODEV;
+
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
 		return -ENOMEM;
-- 
2.17.1

