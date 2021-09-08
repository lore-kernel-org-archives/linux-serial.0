Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6DC433F5
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E991A61104
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbhIHGsT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:48:19 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:26342 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347856AbhIHGsI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/aOwxCMYQNg63vlZmxMu2+gBNhNNIXKtR5si6qqBFs=;
        b=kkzgCDWArk6anSzDPjVBpMbM7szchNKhUDWE2ZLIfQBYrKNnQMDnzGWF+3SnrgVir1c2ym
        wHDLlyzMsl0VzHERXQLXnu7uNNn5dAbxNmj/BNs4n54rd0SVa/KGoGCKqSoyykeQWhUCTC
        DSXdFBSfi43mbFsUAqagCz4BrjYDJDc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-B4XMnQ5mN5acqB5QYIj0WQ-1; Wed, 08 Sep 2021 08:46:59 +0200
X-MC-Unique: B4XMnQ5mN5acqB5QYIj0WQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9640QTlY/QdgTU4dwznvoZwd0Nceb2Hi4oKV10kmpgITChTOK3wtddEvZhXJeP6PzgYwLIMz2awlEE/IDuuZqrlyMzq4hEClhnCjl7D2xhCcUKuqTfMCqO9MPa3Xjard3jX9wMxw7mXsyAOYXXqb+0OZY3PuyotSwFrSSQ1bJWdZp/NnGgaBo7xNHDwso1s1Ep4iOVRas8DN7zA3vK0/HSUgf2q4xbNVYidK63IXJ7+NSOPD8exSd11GNoOP0HlPYL1v3MiVJld19S/xAQ5DJMJcrzXbfcCSl4MUGPLGKukt0jXQScu54uB5e5hq2640nX8EUJhjB3E0IxlrrtBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9r9uHD+hcfh6e0xf8niimemSUB7qkRcxP/TWmksYsxI=;
 b=HvpB9ei61ENmrYFnEgxa6Ckoi3pvXu2BUeR2cgD3ac+a3a8rHkLHqIJpfDjK8CskJJANefT7dP4c7pFRk1nc2GDeFzm7SedfLB/4Z2g3ujWBdsTonBpB8JbKFVK+8cPhZofhWlrFg8V9GLWImLHRngghwsjEEiLxOsaBSsutVMbjM5AJBBYkwfGzkPOE5LPO6euhUecf7ST5yZnGqbNh6QPhuQsZQCGFfbpWWFTIJqwMajhLdjgKp5lrJ1gm/rRC69DTfa15V15ZYKd/rcK5tkkevl2Mb+AGp1QlnXzBu7kRt4Tq9ULo+2dCNUBEUgquZJvvypo45cJ7rrWYL+KtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4477.eurprd04.prod.outlook.com (2603:10a6:803:6e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 06:46:58 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:58 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     s32@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        ghennadi.procopciuc@nxp.com, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 8/8] MAINTAINERS: add an entry for NXP S32G boards
Date:   Wed,  8 Sep 2021 14:45:28 +0800
Message-ID: <20210908064528.922-9-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR3P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::28) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by PR3P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 295740ec-edd5-4ebd-20b9-08d972947413
X-MS-TrafficTypeDiagnostic: VI1PR04MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4477488C3675FF361EC76F87ADD49@VI1PR04MB4477.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfVxm4rvmuodDgSR+uz1jwySG2C3r3DE+l+tupTqLRqU0U8/aJyIAV1AI4djY6UJdqUWvrSp/0OJffAjrpQ9nqxU4AfxGmo7MA9f30E7kA3PYB6Ud8xhSnGo+XKv5dIXkt2Ut7mecsJSUI3ftz9M2RtnUUdZTiPHrf/tfMXl/nA3B5d3xK9Tfs9B0w65n4mzvA3TyDvSLwu1q3NZz17IkDoaik0BKZMY3cAf2+1LUU1cZOR15aoAq5oHfnyc8GkUpVzDXaAQ94wg4i/4a2aYDQ7RpxxWqh6ZEQkd4BYjXcqWfWDnjaoM1wqLDCqj5876cfwtxSCYAQ4/p59y27IBadZLpX3UI81v6LSCKWvyK/nm99wk5oZjT5XrYlsM2ZUDLBZ+OMso5Fp+i8Yy3LdqLDa73Vh/hjxLixRRAPmqRkPHIRQmDgn3oy+PdnQLfV8Qnp8JVGpixn16ThGHz6+eVc7UJWpGHvdUx2fCJ/w7ITLOjjnt4nBaGlqlRJYbrEPqPsAZcGsWZ35WU5AAuaCXHi4xNoMpkaHiE3uDOouhAHFOvXqEuXnjXi4XplMDB3Br+ubXP/3JKUYUXyA+pS5+dgsbLxB06S7oTUA4EodHIXkDGXsz5vHIfM1jSzfFlfc/Yyp3bhkCeqI7mvYsbnI3GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(6666004)(1076003)(316002)(956004)(4326008)(186003)(54906003)(36756003)(110136005)(5660300002)(66556008)(66946007)(6486002)(38100700002)(4744005)(2906002)(7416002)(8676002)(107886003)(66574015)(86362001)(8936002)(66476007)(2616005)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MD/MoYlcugtZvR9NqRaZIQJ9Q0d+6lHalDYLu9LF04PZSSopHE1e4r8WY88P?=
 =?us-ascii?Q?Pn5uNigYAc31aQG6NiriqD050/2tg1wmU1eIbAb6qUJObKEAQXqmroG+Q9/x?=
 =?us-ascii?Q?QG5IJouzZorUbjIWm2Yri+YzPff3RHwpJyXBhs6iYE3wdONkKYWDUP9Yi7/7?=
 =?us-ascii?Q?CxbfmK3nC1kDpSqS3Vdt/iGUFGdqOwPcYG2Sw8zzXxzaRGGGsB8CPIXkFxTb?=
 =?us-ascii?Q?AQiTWLIgY3Vo3OeS2TyVtB38Sb5V6oTWCl6RDgXiFx/lQA0+/P1AaF1vvqy4?=
 =?us-ascii?Q?ADXeIjFdYoZDzZjYs/1pWXBzbnKKchLw2q/SgTw4KzvWfoV8kIKQKSxeg590?=
 =?us-ascii?Q?ec9pbK+W/iVGj4wf7byhAAU3cq4VhpOSHloiCgWMQcf3j4CIf8KK23TqFb6L?=
 =?us-ascii?Q?sbvY4EPP4b+BakuzVm9ANCY57PaeqOY3uWCyleoDo3M7r+rBQpHVwSLSpmUm?=
 =?us-ascii?Q?E/zi4bkqECmyUq1GdMfsH8c/3rQrw8qA+ottGSEc+7UclpsSpYuswjwQX3Sr?=
 =?us-ascii?Q?VzeW23oOfPz56YCqASlQ3Jnnjh242Ehsawc4OGUFZdOeR2wewJgeoN4VmTtq?=
 =?us-ascii?Q?kf26GR9psoCzbpN2RA5wJMozAFW4hryCQvUEcQVV/TqV4EpYu52fJcpmnIJP?=
 =?us-ascii?Q?USZU50ccd5ObKILkeXWD/w5sQaYronJ1DnOdksTk3AQWrwedZkE9cIhdQtXO?=
 =?us-ascii?Q?isHyxELlabNXIa/rmuodV6vcBM3BUL5Pm/Fg9JZO0Gd8K8qZrb6+GdklhPw/?=
 =?us-ascii?Q?P4wUTzByojJUZr5qqT6TQxssKkrjgU4zzfk/b6N5Ds3W7zlH9s3zjuzeFyr8?=
 =?us-ascii?Q?22H+DRTQsaJ0oWH2cuY4e9JCKwrb4vchWdEUkRzXJ2xeKP4mUtjkKHbnJ6N7?=
 =?us-ascii?Q?jXt0AwNIRVgeU3inXRk0i6a/0heVGW/qxTA/vW89eYNJGSY4mJ1Vr1PBe3Qx?=
 =?us-ascii?Q?TUxDl+x8XDuWSnIbc1+6CKdlkZC0H1SJAO7UV1+PVz96phqCAVuqN7TC8CDA?=
 =?us-ascii?Q?rFZA0gkxTrGnGWYzJQnThhzKCdNDx400UFTsJi5bQNtdF34pmq+BPdIeAIn7?=
 =?us-ascii?Q?7mdZ2B0cH/mX4qj0N/WF9qIXAMyu2GLuEdUr5kTpISIe2hVJDCgbdsXMtUDg?=
 =?us-ascii?Q?1zZJlRCWLUanYo6FiQnhfH0PRCcM9/mBEELhnjoA2Tnscs+euRGbf8TQB8dG?=
 =?us-ascii?Q?L3Q68arKKISyK8eTEczZON86D0BdqkhSee8zWXvqTv3thci2QZ8sPywxEf8d?=
 =?us-ascii?Q?OAv1w2qiEKwkBUuso/GTj4xq3JV1QcO/0efQJuvSq/6k4o6FqDEHpTRKORfx?=
 =?us-ascii?Q?uZOAKWZTA1Ra3m+hHMS9mQOL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295740ec-edd5-4ebd-20b9-08d972947413
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:58.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omdGROYYJjy9yS/oUZLfzuMx3HuwzqJfh1xWe3BA8EX7P1sqRaWdcytEkJpQin1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4477
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a new entry for the maintenance of NXP S32G DT files.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Add information of reviewers.

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a61cb2d0cd4..6f2a3f8ae88e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2308,6 +2308,14 @@ F:	arch/arm/boot/dts/nuvoton-wpcm450*
 F:	arch/arm/mach-npcm/wpcm450.c
 F:	drivers/*/*wpcm*
=20
+ARM/NXP S32G ARCHITECTURE
+M:	Chester Lin <clin@suse.com>
+R:	Andreas F=C3=A4rber <afaerber@suse.de>
+R:	Matthias Brugger <mbrugger@suse.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/s32g*.dts*
+
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 L:	openmoko-kernel@lists.openmoko.org (subscribers-only)
 S:	Orphan
--=20
2.30.0

