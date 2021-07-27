Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2CC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A011860F9B
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhG0WSW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:22 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:30900
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232171AbhG0WSU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwmr03pRnt2+VH/LCVLuKHqbEf1S1xlIWf8Dhe35hj6raSrX/Tddcgs4E8IoLdnhH3HfwJ3moyDAAwp04KVpfysiHjjIoW290uOued/jM/pVsVKRDdhdyNM3GC/WkBpyFdNcyCanumS5/X/QQEbeYjHK48rTLBBTk82MbpOk3Nt/8Vcy4Jfv8nKII1l5rftc2gp10e1/qtzGMjaKmkmdK6hfG4Q1UT295zGRp14hzwzT/NOEUrPQCZ5MRg6ji00JsRKbyLz4qb1BQosszGqQGlajNXLVN/0HfDpc4pBeQ0nDTpBKaNJb/tq8N7WbcwqcJzy1Ot7Wr7nGEVbWSg29EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACoRWMJ1AriHpNFpfrl08YsAmKtKRx5N6LUWTgMdAxE=;
 b=YMoZYNC5MPYoW75QRv096bDgCfs8kU0QX+mGMgvOxZ53uviOU+6XnHuinn1XB8Ag/S67nfnYEg5un+VJjpSnc44m3jnjG1VY/21Q+uKwyOCH4U6JrNpVlNi5YFjVEiQFA2eh5er1IpD2oC4Jx+gZbu7z0i3/EWCqNO9tQRl8GIzOiptP1n4Ml+qez/Pdzwxw8P6+xwSsT4wkt/w14AYOJr7YrHYMb/SIvccVRCFvEOVVczjmeZcQH4gsugXIqIKP11JpK3Igol506FveYVuYqvt4RrbWFd2b85/tFxsSy0lDQ6wFIy514X8yWodwjCcfuPxjPPLF+Lh+qjRle25uIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACoRWMJ1AriHpNFpfrl08YsAmKtKRx5N6LUWTgMdAxE=;
 b=Zp743QLwAAfwmcRJJSbChEnRTl+B2rJVJ7UhaivWSJw3vDzu5/0Qz0s0AiifcPKciN+GtP5KKnTozSH0/0z+0F1KHYVIuTlqrZs2oX20s9DzKWv/BgxUoYEMeW72aQ7yXvbXliR7h0p+92KFtCyzVGyRxsADBA9p6kAu7Leufa4=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 22:18:13 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 22:18:14 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 3/4] sh: j2: Update uartlite binding with data and parity properties
Date:   Tue, 27 Jul 2021 18:17:39 -0400
Message-Id: <20210727221740.1997731-4-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727221740.1997731-1-sean.anderson@seco.com>
References: <20210727221740.1997731-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:18:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b1f873-4a4f-4962-496a-08d9514c6cee
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB51411203B17FDB433ED562FE96E99@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byvfzxBFpxjTsRykP/+BVNqbU6nJ+y4jO+x0ukP/z7UVTvBz7QRfSyT0wK6OaoqRiDTbeA3aW7lY7Jb0ARrcUw9nTAwxEhHWUTu/Qu5JSXjrbZIDK8K2RiJc5CQKAg9wIXkqIKdvDK2sK5Uws0AUaEzEbRZYbeh4y7NcS5th85l3rn35E/kXXATV02xja9z+PCkqLHDLi1lWn9qbWbAZsTCBdckPtvU5gh9U4Bc3GJjPOrKPQBf+gj7oxX1QwAakxVb2AMewqvoveuuyM7oR6lM6judIwLQ/bidbzXch9fZGjy4a4oLTR743sXSPpeHmLoxbRDwk0vVUyutlvLtptEd40qgrfrj3b2iCSvVTf5Abf9Dfh3XtBL9jNQFnHBsExJBK7jttWQyhy1wYWhqRCexYk37B8w6T70V/aThaz48KB1ax2HJqSmkRNzvLIO5womYVbQh3fEn+N0FHqjSCjRaB33F8KmHWNvJ5s8V5pI8yD47eofqFRBVCwhSEaKfrCqtpkZBpERb7Jjsf+x5b/EVJdV+Qr/y1lup6MzserF13R6R79qqiVl+NdgKmxC3CjpjFb9Hj7ClhluD+BvhEbhmsL/mAX+xXF8n42uZ3ZftfCE/D1HNV/v8hO7vUJQauONSblcvZ4pYna0E2NbBONTi0KnkWzvQp2P8Z4iF+h8alz7qRIitdGr4IR8aViEN9RVc+a1426YY+aCZ6ajffjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39830400003)(346002)(366004)(8936002)(38100700002)(38350700002)(66946007)(1076003)(6666004)(316002)(44832011)(86362001)(26005)(6486002)(4326008)(4744005)(956004)(186003)(6506007)(5660300002)(54906003)(110136005)(2616005)(83380400001)(66556008)(66476007)(36756003)(2906002)(478600001)(52116002)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrrYNM/Djj4kQ4JPCcEgEKEgEY190VcsF7x3fdjFDeL4FrhpKD1ogzL/8DGz?=
 =?us-ascii?Q?+Snzeir9PjRruo4NOj7Kg9REM/G17S8BxtZOQ+fxTTzPrw5/s7nHpcNVNEDe?=
 =?us-ascii?Q?TMKXcrlD+02C1zWBgbgpEIn1BSx7v/eETeO2OSFZw04PJzWO/0SZdAduxWEi?=
 =?us-ascii?Q?Ux0LfbVI8VBXhPm9vKA5Q1HySuQ00aSJcQSQL+2mmUp45BhPKeOy3SpoU59P?=
 =?us-ascii?Q?g8L1TjZYVfl5JEvh+e58W9d6yi11tqAmH/ADIXHZjPLhvH57qtP52felQoqR?=
 =?us-ascii?Q?IRxpqgEr8gJPPZTnciwRhqT87OYR1rbc/scAUw7BoMuIY/TUL81pPhfanGVv?=
 =?us-ascii?Q?DQUSPGQDy5cDlhRZiyDWDuVKFwv67Wf4GrIpagqbNvjlItj723yX7BkfcaIZ?=
 =?us-ascii?Q?THfkLkx5oe9v8V6xFVz+KWLnr/YIIsWwEl1Mp13zYu2130X1XkLp3xuwzd3y?=
 =?us-ascii?Q?XjhXOJkzfKh3EMk7IAqLVWGkiSoSyIkd7lR49TvAMhQKBbAQotfHFFX7Hh2e?=
 =?us-ascii?Q?Qm38/W8+IKuXqE5tgwOC0wzSE86XLSYDRhFfOUpa4S3aTlG/a+Kwsq8VLWNO?=
 =?us-ascii?Q?2POjpJVbOqcH/9lhIYMPTAroLmocE/RY3YMhAW2voigwiC+dkmgQFmJavE9h?=
 =?us-ascii?Q?6k9ohkboQZ5EZxaRGxisML7ud4nrdMqHAGZbagle/T/th8IMk6H6pzK3JJwM?=
 =?us-ascii?Q?b+pkSx102FFX5VIOT8tAMJxuu2dU2vobqdQqmRd8hHKsGOFxXJ+EtoNJaF3M?=
 =?us-ascii?Q?xcg18V8d3/U4Bxh3HDksPyHmma/ItzmGcmZkxdsxF/m6vH7OPmvWFkpqt/HY?=
 =?us-ascii?Q?neDhTgzCdQzrpechVXK9J92NUQTg0ef/pD0GXolJH8vFQwZU+eK6wBA4sgS9?=
 =?us-ascii?Q?rjkkMKGPD75Tm49l0M0POhW9v5wdntbYgQfx6aX+lNtHdPHT03VzubY6IdCs?=
 =?us-ascii?Q?ndynoEdp/FJa3yZu3xoqajLsTSqX2UOZ8aqqL+wMf4/3jBDRLD0DrfTyle/Q?=
 =?us-ascii?Q?awr5BrU0HX+tD5NualTWOIO62F4YvK6wM7fRYQ2wph3KabJk8GYN5LfBOHi/?=
 =?us-ascii?Q?xwJeb0PpFk7iTsVGtPHaj+xXDLC0qUHDTjmZvzkB/I5AtD9pnRsI2dT1M3T6?=
 =?us-ascii?Q?ISTixqOEfVUUH4wMknRGx/Mk5zlnrNKckrdTqNx1PzZJwuXvA1PA2JeQJSHk?=
 =?us-ascii?Q?s5JqoU4UHkbIQyAj3c+/2JUfF/nwJgzq4zhUzMY0NisO+of7naW97X2E4+rD?=
 =?us-ascii?Q?deBBbjLArqhJfk0EhDS3RPU2LWx3bEgWqVPKuNgSnFO+0xHNWmN9EQ4IN1+W?=
 =?us-ascii?Q?4VjoEhhF/3Y8rNeTkPdxhG9X?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b1f873-4a4f-4962-496a-08d9514c6cee
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:18:13.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQAk9DZq5iodwDV9AJO7zTyt8yeaCwL+wIixzLO4pSEk0IliIe4n+htYUEvZivZNOOG3iXxJwqXcJwqTZQGUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
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

