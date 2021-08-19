Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098CC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F46610A1
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 01:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHSBtH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 21:49:07 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:61331
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234194AbhHSBtG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 21:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3avpGGWceFLRIbGJZJjrYcHvQj/GgTiXFizSxZJV6xNZwse2rvQtQnr8HOdJquTskxdtbJ8u+xii96kxSfSNwD2szzNZqy2XnqqMVMN1j7ncEz5obZrax7M1gC/KfmLlHEGm38UQuTnu2vPOREok8LY1OXzu8J2Mwz/u4Uuci6fP+U8et11n7I23NjlGUyTtjf+YuwPL3ZkjSX+KrJL0KfUGab0HT85NaEw6+vM2rY+RPdgGOFD1w1NrBtcmibMsA6brop5QvLX2HvUa1SRVlUS2ha7C2PQn0BfNBHUl5ScHMpYfRPGbr9h1ZUgJouBHLxbAYBTvos1fRSRg+hLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32onaJ/UqjStkgjXeCVAmK1Safb+VBdCQq4qf76+P3c=;
 b=BPdjQbZqTZabxd1ILofPLWOPNr/yJZZtEguimU1HVl26oP8l9kGc5EUvR1rYTwvm4BPvP5DoXN6W8xkzS9j97NRfblDeIpxQfy746+dPF3mxNE+esCNwpv1qGAutMYydVXZZHu+5ZN0tjAA8JtNIyaILC7aAs93a4/mJR6R+qDW1hzwu5+B5YHaYvkc2sx/8OAUKCKdJksUMjJTQi0ych/RR6jzLK0i5pmIspMWdos3Qd0pJuwquOyMd8DB1BnQgpDz0BuDnVKPNiXLcG8yZJk+2Edh22Stkjiyc8HuR+erZ5PELcEmqodX7yTm0n0a1H7OMxw7LHQ5RoOATZ4NVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32onaJ/UqjStkgjXeCVAmK1Safb+VBdCQq4qf76+P3c=;
 b=ROVVv0xA/Qw7mSulyzZO+MhWQxhSn48p9Lpr96ZyBP25GJGdm4pldVeZ/cl2f3VAw+IHlRAvsohJ9GpmiJerCq+/4EmO5TncskcEmoYM30JinF/tJ2BjoUIsSmwVDQ+9Ffj23AS5Y18Ah5qHhfWujALPIB92SK7f6NvRw0sM4go=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4776.eurprd04.prod.outlook.com (2603:10a6:20b:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 01:48:28 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 01:48:28 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: fix the wrong mapbase value
Date:   Thu, 19 Aug 2021 09:47:08 +0800
Message-Id: <20210819014708.32039-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0235.apcprd06.prod.outlook.com (2603:1096:4:ac::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 01:48:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b82d0c-876b-46ce-4703-08d962b370e4
X-MS-TrafficTypeDiagnostic: AM6PR04MB4776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB477668D00A6AA24C8B39730992C09@AM6PR04MB4776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27Cu5k+aq16BTCY6ysN/g8VhxwhokHdXvh2VBjzsPmqoJn6ffr5+OzR2RSw1ORSd/kdhMpVs/g9Q0CjPhzQhaDXc9Zy0n9/vnvkgG2TxaNcHb6cwtMLzaleS6BK5ncjkmPkEX2HN1KKKVf0H+Ka6qsgaDkDQt24S3fAhY3gFPBtdUBcwRkYA7daYyjBrTZ4JkaagVzJOM74ohwZlUKedVtS1mIGuSUAP04fu1jd9Rm44fIMfpfAem+8dYU8VCSIxfeHI0kNnO7Y01heqtdXF79wT1N/C6DZJfE9fDPsFJwTrzoWYmbkLDgW9uQ+b0aOj5bbFbn1lBNf2vup1vhb5CMg1HY1g07fICaeaL6AUOEOFrHSxdOIMCSoBCg0HfV94ZKZi8ki+0EwrI0quyKEaV88tqhtbMqqIdfGLRR9v44HEjhg+5DJhBwwFLci4d+KhFF1GF9zFmBqslHeg9V5XmpfyevwwDcY0n3UslYXK134SYg9O4+ZJYpv5hu9Bk5CT15G7wYSMEpJ038HRn3cAFxW5lfbCB1xaM3vVjwe0s6QVzBZsiPpU9EU2MCV8sZ1snx5ZtomZ3y8eoPtWlpLLuXdVFGON8nF0RJgzY8yUMUQgKkD1g5OhdzfNME8yk/WUCB8DMgtpZ7WBRSI+td3uZM0hHpJ5tkr9stTdEdxcVQPuL3f70RepNbCwB8eBzbFiZIEX34Jk3+US+LcO9f9TGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(1076003)(186003)(83380400001)(38100700002)(66476007)(36756003)(4326008)(66946007)(8676002)(316002)(66556008)(6666004)(86362001)(52116002)(38350700002)(8936002)(6486002)(5660300002)(6506007)(44832011)(478600001)(2616005)(26005)(956004)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Da+M6MjCYwhjxaQxl3DINFCpA7y3j9SZnfXaGIUmBdGMGBb4WeTZgX27yfDh?=
 =?us-ascii?Q?0ou04A54Mas87m4NLalv+l2e631TPvuiBMrGeqKdiMl2UiEsuszar5EG+El4?=
 =?us-ascii?Q?R1ZZXXxIWJiusJbSe9SxWF7hseFA2LSyi6eFPnTZn5tudGwxaaROwh3/Hh5s?=
 =?us-ascii?Q?rCD/Qg2unKzvwDGo2ovFC0OUQ4WU4cvjTdrVWPfSRssRNCO1Zh265bTngmy6?=
 =?us-ascii?Q?lV5/lNnVAIBPFPL5vVTdvleL9BvFaz6iwKGwN0f+FReqJYDcCFsoggMI8AzL?=
 =?us-ascii?Q?noWeM+CWxsCBn3SGlSQ0GP59JnngTlXw+OTtxhx89mQ43P4HLLJlgmuutCF4?=
 =?us-ascii?Q?XVhB7ddOCL++Qdrgqr3CEQkkTfpEf/l8onXc+HmwvKzMR1ZRN5mrnxTwSeyA?=
 =?us-ascii?Q?V2tApn1aP6JYEqtack/5XsxpEmNl56Fqu0Q8wXqTMroT8k+XORrI4znI/Y7I?=
 =?us-ascii?Q?OFIboMP1hcXm2TsLhME8FJR5O2lLKXQOHaXha3OSmqwzs5PdIW7KXZp2zpQH?=
 =?us-ascii?Q?Bs6/U/qRT02PvUwO44U+tz8SLYC/HQuKHTDgeaIlAkvB5KBzxa/oohZiXxxF?=
 =?us-ascii?Q?s9sbzdyxavtdmmybSps7TTyRoowE64DO4sFUI8LcxwCirEPbp1edMo4peOHR?=
 =?us-ascii?Q?J3jPHJNyOc0ABhRwBhbtYEGTczmIEapD0mqeITMQDlGWWr0ft00/y+hj0TAs?=
 =?us-ascii?Q?dyu12NTDTGCp7Ct9TKZYjF4cqhaYcua1RnH1UHafvrIy2rg+vXs4FtuQTlfz?=
 =?us-ascii?Q?p3T3gMYXl+PXIM/daN7jTOUbNSMYvNHB0rCp1kk/F0Hpc5FSWzmCsXAbFxfP?=
 =?us-ascii?Q?pm2y0sxyU+ephsHmYqvzX7WAY7mFnlQUNTXTgOWYJ5A5HPiYrAFC7x8aaltn?=
 =?us-ascii?Q?jEbUhurBT6YmK5QOtdpm7MrQj+X+lCURjSg+5oNpfnCGN3Ih2I/piFbP8i7+?=
 =?us-ascii?Q?cpW4civYGb6TgBVyNsOXDEbt0IDXTN1puuvLXzmsAnDQJosZ/nHKvYhqInf7?=
 =?us-ascii?Q?d94YtLUFGpYqKdqm2k5IDFl+zYn5lz+fwspBHDARSp/qv7a9FYZfqLz5CHEJ?=
 =?us-ascii?Q?+hVFVa395S+4hf8x+Or4Jx51yecuqIwPtMoKuOquTu3THSWzo+c/DMOKp5yh?=
 =?us-ascii?Q?YAxyoTmPcDg/vFJWpiqXLuhv4cefVkak0n14sZp55yQy2spILwnTXKhaVFhh?=
 =?us-ascii?Q?+YGR9DxBP4IqGn6/vz5r8+aDizQ7UemkB1CYgoGPz83igxtZnobgBE2W5JaR?=
 =?us-ascii?Q?VBOQ5L8FEkdpLpUDhOqTzt+qTtuF1BlgLhOGeopC9stRzI+vlJWzS7dxyJF2?=
 =?us-ascii?Q?iQPNSa6m8VsRdFBsku3ygndx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b82d0c-876b-46ce-4703-08d962b370e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 01:48:28.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE8ifIeMDTcXIQR+pN8f2LhNi5t9v0ILcaRQTRJoSs/Hc7ixZ5uUgR2w+WPswQExbpqBMvM3JJgsg6WK3TsFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4776
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

Register offset needs to be applied on mapbase also.
dma_tx/rx_request use the physical address of UARTDATA.
Register offset is currently only applied to membase (the
corresponding virtual addr) but not on mapbase.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Andy Duan <fugang.duan@nxp.com>
---
changes in V2:
  Add author signed-off-by tag.
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 31d715c4787a..117e011aff5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2615,7 +2615,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->port.membase);
 
 	sport->port.membase += sdata->reg_off;
-	sport->port.mapbase = res->start;
+	sport->port.mapbase = res->start + sdata->reg_off;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
-- 
2.17.1

