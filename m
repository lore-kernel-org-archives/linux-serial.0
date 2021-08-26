Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6BFC4320E
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78E360F58
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhHZTXK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:23:10 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:17536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243360AbhHZTXJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdv0ZnwPPM837o2RxdfEcNEzpOZKT9Dy85b0J+uQcsbpsFKWTk/9wPSBbo/tcY1PXBf9WSENvJbv/7Wpjf08V07gAzhKLq1PauqL7tPDSuh0JGVa3C2NvRfAfDbHamk+rrnRdYdHQ/y2D12hU2Myglp6fKmnJERnjR65cvl3I1cS/LocmqQEvptfnbbBR1uzJca4NmQ1L3JUV7Zip+xzKQIy19uAHn+A0OsmT1wpyRYjBrIVMC5d+p7Clxpvv6yTnNGXEegIdlwJ+q/SCO6hBMgnSInRNGzK99/qXH/XyANXiY6rXOg2sZhWQZm9nr03ethfBog97ybM27cs6E5WSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACoRWMJ1AriHpNFpfrl08YsAmKtKRx5N6LUWTgMdAxE=;
 b=TjWdSmCHTz+jrJWDLjB+ovaFR5/hloKipkAxSm0xiKorrrT/+9S5wAtmcx1rAO0iD8+W8Tpr5AUNAOo4Nfyd1AyqPyFUyx6Qrbc68eVIxwrYvlLh4LyMK5pf6iFaLuPJkZedgAZgDBlFFi9RZJ+DgZO3TqmJ+eM/C9/UrR5Y47hDgG2mKfkNCo5o5fDPOXRT5rHwS3/On+pFaNvA487tHOCSq0gqhNKNfQ31P+AhA5Xke8b38ogjJzrlg+thjPERJ1yIzwNGwjXOkmE+zfZv1ysHcEyFqi9sA7gUR5NspNgrQoKEy0gGWPztw09y+i+w+0xWobpysAibjrwJFVpo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACoRWMJ1AriHpNFpfrl08YsAmKtKRx5N6LUWTgMdAxE=;
 b=dD4IKlzVYXOSX+1nJuxUOK9KZNmHAM6XusR9/f32zs+fTFzcV6n1XOR8Zi+qPIHNXoMK3N1KwnG+rj+WaKo3yaGlKTOKs9HMNHXVqk4PDfe/cjiRwSFTje0PoTCjPoHxp5XW0Ll9edusSJ3j2I3cscaxWWzx0WgdVmdPm7PqC3E=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4859.eurprd03.prod.outlook.com (2603:10a6:10:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 19:22:17 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:22:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 3/4] sh: j2: Update uartlite binding with data and parity properties
Date:   Thu, 26 Aug 2021 15:21:53 -0400
Message-Id: <20210826192154.3202269-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826192154.3202269-1-sean.anderson@seco.com>
References: <20210826192154.3202269-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:208:257::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 19:22:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c15f14d-05c2-431b-26a0-08d968c6d0f6
X-MS-TrafficTypeDiagnostic: DB7PR03MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB48599726E5708BBC26A5D15096C79@DB7PR03MB4859.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJ2Q13QgLCCBgGZECs5wkfOarExv31i2Zr63nED+Y4ySZc0Fqlzjud7DxSX3KWAG9zUjIJwA/JNT8QBTImgvWIJeSN7+sQlhCOMxNypkTKQYdVbIvytoFlL/F2m+fT7cNSBbg8vgfUTxGwbvCGSNqRQaUpBS5bYv4ktYJFGOr2ScECOZ4+EiNvz0+YBfEYDhGcJ8GZgde/tw7YFi4t84ODnRlSsjWt1WWygSzXA8Kh6wDIQjNIhUTwgekGIeDxOXRrMt11zJyY4oIG8z2BdqBRc+MJO35mTq5CAcDqLIunBbmYJNstu5qgvFMKsmih4PY59jOSolByqYaUbFcno+5Zsm0B4CBeWyjEnjQA/rMysk0mrncgjmGbbsni1lHrbNimo/raKw+4b5dPp5da3xkfX7+jJLzQUmNzUFktgetxwk6sWYOVnxp/DIEWzBWtts7Uiyu4/X0hjRoUJZPd97vUdgbXXariJtOhDl5Vblq9NA5WT2iwmK9pFfj3dsUfPrXBpDLxfelL++nHrHZLff2+lfli3o9ZSoCnN3pd5Kk1eTSb0QQChBYxurJ8oGbEnyTAUFvwNV5MketXCWcHHO/Iw1xNY9Wq6etkD3geHKLeA6nO/eyWlU84EXO5pEEmK8jpa5O90Df4rK5BVc1SEoEydJ0HEKJhOUXUNHwEQki0IyniwOzorKlBuSz13AGX0xPqz3/j1C32cgNO9QxfMt4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39840400004)(396003)(136003)(86362001)(54906003)(110136005)(478600001)(6512007)(316002)(83380400001)(4744005)(5660300002)(6506007)(1076003)(186003)(8936002)(8676002)(26005)(66556008)(2616005)(4326008)(6666004)(66476007)(52116002)(44832011)(66946007)(38350700002)(38100700002)(2906002)(956004)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HpnIaatensttCPDUpi7C2nzwWos4ifIAweGZ5/vx8chBnypJrHKkz030JiyN?=
 =?us-ascii?Q?HmWFmewKaYFUWKi1STdmh8sDvOEgbK+fwGxfgjU26Qko0SUnOb2Z7bPqyBs1?=
 =?us-ascii?Q?ihUS9YbJ1uxPT8d+JxdrZa/F3mrS/WeYZXrm4+rHlua3+R1LzNxjCeGfcASr?=
 =?us-ascii?Q?1ENduqnk5X48P1lxvgEEHYjVJUu9cllAZ7rgKaHItPBdvSROdZZ5fy+905Ya?=
 =?us-ascii?Q?3ga2Q4muWFsJ4mqp1sj8ev7sW2Gj3VpjBtoUPPemks2Xc2Xqjxsh8DqjPvbm?=
 =?us-ascii?Q?rQ4aKqZkLb4U4Om32TGzZm9gAZT4D2jMP1c56Ck/Oo5fNc2dIhe7/vpnbcAb?=
 =?us-ascii?Q?Zh/CAwI6hG4ZW2wEVrjO9l0UgqCEH9ibOlm3rAVuhR0r9sAjmZ3eDv8AoMpB?=
 =?us-ascii?Q?ljbZWn8YPctOhXpNSsQIonKFrZ1ORgGkdxEhDts1jPYGATcK9B1nbKW1PmTi?=
 =?us-ascii?Q?WmQH/oQgJbKOfb16dJHxLy00rBaIfiDKxuOGYpMqBmFxH8F5nnw1QeaHfgp0?=
 =?us-ascii?Q?9jch09NZDR9g4ljvgYva0Z7CAD9fFo+wwOrEjnU4gsK16b6feNghxKNYOrMV?=
 =?us-ascii?Q?sm6EMo7aPLilmUN3wxgQDS2wzMDxawKPPT3FDTLBM8+c62c2hmhXWff4O8JD?=
 =?us-ascii?Q?9L42s7PUl1gqjct0jvJM43h8R+rYv6uV9wLNnM28Gu3Rw5dvB/eYviADwmOk?=
 =?us-ascii?Q?/dTQ3JZ5srg8fiKKjThQzXMfPPTBAwnZYQzK16Zv5g0FTmSvsMcAbxcLzqgp?=
 =?us-ascii?Q?6ep/Z6Tm1jiEKn5xx6ipecvKRni5/efYH6QR/ZUDB/QbBKuDoL95UGr9zyML?=
 =?us-ascii?Q?QOt7+OVfggGqJoPkY1woTdR3Y4XIvu7ao2HbnN5eUO6KUKPeI/yLNbigpGVZ?=
 =?us-ascii?Q?FXwthDUuFHff1RJZJFBpxUrvXVHBjZfRYMehDjDPB5X8GKMsLVUU4TaEYFk8?=
 =?us-ascii?Q?97hByBYHlz9CwLd3qeCUKkO7K+LidjDP3rxk1t9m1pFdKQ2HZyE1u81ossH9?=
 =?us-ascii?Q?PzC2b2cxbIVNuOpVwHEq3gSee3jhYtI9GfhFzQ6HMu8x1boAS7t0Q81vyqfD?=
 =?us-ascii?Q?sF5rAi4zTbX50A3hzpRM4cQdnbJdUfda8hsWqQLYHTxl7X9ryMTMnkONbcxO?=
 =?us-ascii?Q?6C002GnT0tLaxpK/yjGxyl5PfPHXvM87f54bGKDWaT4xHYQmK24aYQzCla2R?=
 =?us-ascii?Q?DAoxjl6+CehSb0CsTyoTYWFpEr/eFRF1OudbvD4wQ/d/jlCaaOORPMMHEyVu?=
 =?us-ascii?Q?yqY4G1aGYqphjACTqctlkgw2JGhysMNEgeqTxREfb2dD8Q5k15FnB82F+Hil?=
 =?us-ascii?Q?kbLOB3RGqDrALBn50QhLdQA9?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c15f14d-05c2-431b-26a0-08d968c6d0f6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:22:17.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW3GIS8v5JZeCnDUy6r6oNYV0dMPnbaoLIYyUniTeFtCUXwIonmEPFHzdjYW5Iu2fceChql/MMdkej3imRsrbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4859
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These properties are necessary for properly calculating the uart
timeout. I inspected the J2 source code, and believe these values to be
correct.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/sh/boot/dts/j2_mimas_v2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
index 9f4742fab329..fa9562f78d53 100644
--- a/arch/sh/boot/dts/j2_mimas_v2.dts
+++ b/arch/sh/boot/dts/j2_mimas_v2.dts
@@ -88,6 +88,8 @@ uart0: serial@100 {
 			clock-frequency = <125000000>;
 			compatible = "xlnx,xps-uartlite-1.00.a";
 			current-speed = <19200>;
+			xlnx,use-parity = <0>;
+			xlnx,data-bits = <8>;
 			device_type = "serial";
 			interrupts = <0x12>;
 			port-number = <0>;
-- 
2.25.1

