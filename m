Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57070C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEEB6105A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhDZHw5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:52:57 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:30358
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233709AbhDZHvj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 03:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBnVcl8AAqu2+HlCeeEN/7XDlv/djWT6H8URjfO6xboJFL5BgqvDW4Z/r2X1v+AeZ1luz5uLND8JiMr8Vtuag858YmeyTyhV7iEhhd4LShREMqAJzueJcjsiXqGe4tJgA2CKKOhmNSb0Oe1IK00/NY0CqL01ahmEV23dcBFHcJsIKJfnnvHE71QwH7ycBQH3LJ58yGm1U0uWA/uldS5lLm7EQleojf1Q05YW+qFPCiTnZKL5EdumWZOrsY/MapoiXaG6leNpd9qK/lN2Rji/vTR9xYENXgnoAvZhFT1R3TmYkw/RuE99qfhFAl97sBbY3yBqKcxKKrkb8uv3iaO51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/YSzRIZAraiWWZUV/xx3V40uSlLdK90XLYXfnygyM=;
 b=IsO40JATRfV60hzqKyIvv124h3Nd76CaT72lqxB2l8Pc7WuEoxc87SgaR6KKH8jIqiLnSYQ3IhAuXPO+Cs9VmgN6Z2irO3bbrjQ2VI5Pfw859U+2GiOh8v5F8WmJXt3vDARA/BHWUAvHhsLV3eahFXv+GnIHdcxzaSCcJ38GjF3yXeo+QEQBGXoxBkwAdx66d6iHlfn8ev5nbO2jHTWxtyYrTyZIRdkR9FyIYiU1Gii2q58JMD/YOkrvEdw06l58Viu5eNVssOZsWglUvnBJES2yE4kI1WGWbNj3QqZv2KteghHYdDL/tzpBoHtzMH5pA8n/8JY/AVGESnRnNSK4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah/YSzRIZAraiWWZUV/xx3V40uSlLdK90XLYXfnygyM=;
 b=WULmAYv44L4GG04eLJJPgC/h6wOD8dz3EKqouXRLeDw7hhcaev5WD2Snju/i6DhptcqfnFI+X67qlhPuP++HstcyQNYs4rFbdA00zQWTs4dVfw8skE8FmrTUOh/vGvJPxEO8RXrDi7yEuY0xOydXsT4RKvzmkRer5Pye0ew8TNc=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 07:50:56 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:50:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/2] Fix two coverity issues in fsl_lpuart.c
Date:   Mon, 26 Apr 2021 15:49:33 +0800
Message-Id: <20210426074935.11131-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:c8::16) To AM0PR04MB4947.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HKAPR03CA0011.apcprd03.prod.outlook.com (2603:1096:203:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19 via Frontend Transport; Mon, 26 Apr 2021 07:50:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8f15b4-3548-4ff2-06ed-08d908880616
X-MS-TrafficTypeDiagnostic: AM8PR04MB7762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7762EC2A1E29B98226ACBFEC92429@AM8PR04MB7762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvKuqVd0Lqhxhaqdgkqz4JkiuI2Kvb6oOgflW6fm4XfArn1dT6XYt3+/rZlGn11XtxCDSWT719zcuuDJIe0tyF4/cezFWRiAsr3YApUCswuOlz7LoWPDY/kHtcFkDbvFKvzoeG0f9o5geZkA+7PtzUh9aEfAvUxyMTpuwNF09Lpw77yfa+Xz226F6QjD8TFhF4jKBX2mpYwKv4YzP+HbVX/tXLACmSV0mr38Vtipti4/pa+15u2e5EXKFvpy3GfuKHmSWENc61j/kFFtuTMNuRuYwdjJWoEiYumTtkZtMEwaZqF/Kz4GgepHfdERxXCnplxsod3562SjemE2rSQeX57GPBBeDSr2Nvu9AC4TcEJOnBX8xA/oR/5etg1QGi0WSXO7CicxAvAs5AownOVnj2WewHOkbaHb6emH08+2tIbi/FBsvTPU+AzjABteb2vWXgS7CMvu8zr+I+JXiRfHg866ERi0RfRA3+A/g1sja1yPOJ6yT+Wu99LJUkkxFPlvMoTeqF9yiJrKcklJPmtQzt86mKslBZTKJELhJN3/E9QZdaDs8+EnX/uDD18if9jkJeKiVHbFg5iG+JqdGJ71z4zIWM0KayYtFsCU6YHTzVn42rPpfh5opALaqHLxvSlPc5N0T+QmA5/wdB57h3MCNDTag1JaHyrB93aOmGGgTrf846dnMcP426LiUIthXih0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8676002)(316002)(2906002)(66476007)(4744005)(4326008)(26005)(186003)(1076003)(16526019)(38100700002)(38350700002)(36756003)(6512007)(44832011)(52116002)(6666004)(86362001)(2616005)(6506007)(478600001)(5660300002)(956004)(6486002)(8936002)(66946007)(66556008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+qlSSNUCcFW4k9JujL2XHyR5rPIoUSjHujodiIJQ2fqfQb5VXIJ6gKv7zCFU?=
 =?us-ascii?Q?1zr6rHypYzllQ2v1mt9x3EtCW6zHGNG9o9lmnf9zuUkXmEivCe5DAgGAk79X?=
 =?us-ascii?Q?1034mEev2rgXTFlfFUH2kIJUiDvbaCwZ+muT7Q/5eyFS3TyyMPVXSauNJo8p?=
 =?us-ascii?Q?LgUezBrwNZM0c9C0CozZtYu6eg6XgQZkYEnaDu15IVo496g9ncvHrWy3Qoie?=
 =?us-ascii?Q?lkWh2d+RUN5PuSNLKbBIDafAQxG48Ub5JadW1wxjBD2gVPiGm8MfeKdi8dbQ?=
 =?us-ascii?Q?9MKWJmX1bXa2JaxkykDMlqnDbdhclxl/HtZFuUjCajfORG7yxcsnMnzaPpcX?=
 =?us-ascii?Q?kl/GPt/ZXJkr76dDt6AY8PFo4ULofzzguDG2qwqIeBWMxX0E8M3BcTV9hjc+?=
 =?us-ascii?Q?qaXG8B7ujA0EqAIDaJvGUbflJVQmXC2ZAa4uCbXn2qs0lVqG2YwDZftzv7m9?=
 =?us-ascii?Q?qnyxotHPcYEa7qRpiL9VY1odybrZKzWfYsGyjlbhlZ5gt3+EmCJ3xjOww2IV?=
 =?us-ascii?Q?Fayji4eYg/Lins9kn4rr9Q3xOJAwBcBiAuh1AqGNZean2mBxaOecuTXyw9Dn?=
 =?us-ascii?Q?4hJ/NRXPXpNIuHTk7UYwZFilnob4AGMk05kN4uqeExMGWFuTJrEiIUMz6Yyz?=
 =?us-ascii?Q?5pF744j+JPGK+TMQpbbnf0JlCY6fSxO8dZcxX1NEanGP8Ri2e3L8DiT4X1lq?=
 =?us-ascii?Q?eiEGCOBnRpQ3YC2tut67CjtP4QIjZDGPE/aT34HEKJsHj8Zn93tNIpfxByRO?=
 =?us-ascii?Q?rH4ikI6URFxTYSae8eIffguyM7Uty6MG8DLI7Eu9lt+3CusMj2P1eqYq8nU1?=
 =?us-ascii?Q?TASyieem0lJzNGSKhzW1Ucb66k6V3GVOveNYdCsmmKRj7utPViCvzXRCPv1o?=
 =?us-ascii?Q?G1/VSVT+y8dTNr/w1/E8b9igQWtERtkIMZmNJ5d85jEBUeITmnShxymodKku?=
 =?us-ascii?Q?hkKAxHWXF0Gg1VbRqEE5pYSNWpaz/Pj49indjHT4ng/QcvvVomNqUZQhzxZq?=
 =?us-ascii?Q?26HgHy78QHRGYGMjm/+64YdRU3meH58xHwVu9i4au2qQAxg+JYtqt8dz9rUd?=
 =?us-ascii?Q?VKYQvk/XpV1dJ+yK8ttsIgj5zubXwKJSAgx2HUwd/b0H08emlCB4fweQhM7F?=
 =?us-ascii?Q?zFOVo8jY5FYbBHViy0TX/5F9BKXn21upNyeei28cMUj7p8VEMakFd3fL2qSY?=
 =?us-ascii?Q?HfbwCUWkEAkrtrhCSgOX31/nsG0i5lcNOmSvTL97sx8sTpn62ZrJimX7MfTm?=
 =?us-ascii?Q?6vl2HrYzi0glN1nfkA8FGt/352T8/X/YJm7GdHupXmJO7gV+72N740As34zS?=
 =?us-ascii?Q?vBHFz3fwrwbVWw6iANPylRmd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f15b4-3548-4ff2-06ed-08d908880616
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 07:50:56.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: La4uOMQ+mrAA3Lj4+fT9nCpJvGbCzu4weO9S6kUtK5P2fIdrZ86jYQoStcbIg0wwCX3ri9kfJ/RUaq+Ww9ZHVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix two issues in fsl_lpuart.c reported by Coverity Scan.

Sherry Sun (2):
  tty: serial: fsl_lpuart: fix the potential bug of division or modulo
    by zero
  tty: serial: fsl_lpuart: fix the potential bug of dereference null
    return value

 drivers/tty/serial/fsl_lpuart.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.17.1

