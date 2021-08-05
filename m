Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C65DC4320A
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550F26056B
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhHEG4Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:56:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:40128 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238528AbhHEGzr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWZQwouCRguyRVYUrbJB0b52caFxPb8vLemC9Kxx0AM=;
        b=U2LMr7NFNp0Xi6VvJbmh6kmoA83k9PfiMui3QDK6Q8dkdFc+q1shrB30EmSre7QQBZIQ3Q
        2morhTubgCywfJvjPO4M5DGJxLNrHTNfm8frZ2bVjG/7d6565hIHijaq5xQLwg7yGMn58y
        zuwkZzYfVWC9gayDAA/uqdwRYimQhDQ=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-NXpk25gSNxOjCPCS7cMEkw-1; Thu, 05 Aug 2021 08:55:30 +0200
X-MC-Unique: NXpk25gSNxOjCPCS7cMEkw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr0n+Y6CR/7Xm67ohuAtqYxz3qj+KsTMJxMtzaVIxLBbP45jcLHYwYiJcWTEYDVzYuC9LF23ne/C2ZFldhAnGMcfGoMcKuqUXeA+mg2N8aUsnQXXLGIvj049ufM0tw/NWPe2r9VI7e2nBBHv2HLw91ky5P4+vRFQX1nTRhEcDFwtcVNItzezykTJCDOEHk5FpkjUuwNmMGGEB03AjS+VS3DVEzOJqEM52pFVH8RZYY7/7F5OgGjowg7urPZ9nKopqjc624Ur54YSY83AV6ogbfmJj2b1SXZYaWUe8EBaOJ2nAGjHH7SrjvoEWOTP/zkXDDAM9bd/Ei7O7mDImNa3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osw/i73KgwmK6xFxOMQmECeYBvjJJnhr3Z0jaUZynVs=;
 b=BJVA7nCBpuZgm4VFH4mmwLeD9ly7Wax0j2PM4B1+uZ0XzmvNa6loDNZWUl19HyYiP0CNJJ3Ac/7d1k37eQMO3q+LQMwZE3uF2W574Hld9gIUFZ26eBLu3wBOp3QTZicR5fXuN6joUbnj4LxpHiaSvKgoAUPNbpI9tRdfI2L4k5sZsJnamx+CfLe/fS19hFDdqN19xMsppxJzvKVdxdTuaI42S+fF/JMfv8mntuIWm4PofpSg9yhwSZAUhm87O9XZ+MVkpTJ8PiXuXyvN6JTSD4L/P+rHYC7awaCdWWmtGprUZE2TEKcSMUGd91/7ON8oz1DqufAMv5V0WcrI9MrsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0402MB2735.eurprd04.prod.outlook.com (2603:10a6:800:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 06:55:28 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:28 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 8/8] MAINTAINERS: Add an entry for NXP S32G2 boards
Date:   Thu,  5 Aug 2021 14:54:29 +0800
Message-ID: <20210805065429.27485-9-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:200:89::29) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM4PR0202CA0019.eurprd02.prod.outlook.com (2603:10a6:200:89::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 06:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f83ce73-99f5-4650-688f-08d957de027f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2735E6B0E0A1B5D82458F02DADF29@VI1PR0402MB2735.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KR5ECY8LNiXGK2ypmeYUsjE03XoU/4Q/a77YqEiYH+r7ebIz2Cg/vgBTwbv+fyx3Sgp2m5FCocf63u0cuHo3QqVy62cF8p989YKptgcq9txUV7xVjNXT59s7KyY7MqUZlrMqvOjSYwRqfKqoYJULUO813agSW2+3/LVfYJS4plNGYhH7/8GuoKm35XcaxSTTCrXLqpLVtIr43xXO0cDhGsSzfglDx5UTmhsEbW8SRUp9JkITZtCA9f0Ysio3IvSh7vf6d2+cGnbM/7UhLdy44BrCcMUwUonqQTAtd0sFZUX5T7qsB3s5Cdr4kgBwypdTjrHAwx65xOqfBRxMwstz4+I4Qr3OhHBAWVVkg+zVkXszaUYy8mpVaUqOgToLIvAusl4PoxWuM0J5BgCa+GbMMxtZLNdxGR99QDgCviDvo8VdrvgttZsrbHwu81AmbUZXSHXwdZ9I/bnlXMKoQUSlmIwWqXZ1uk7yek1rmmShTLSDLReaa+u5LqsXrNWN2apoRYoHXhUAfMAGyXrTd1DuYCZ69GbOnvlzAM3HcPdHOTicrYFfq4m+pb3MSkaqSGzrW1RTBDxLNhuEcj8U/yod++UTVDANL9se/tHoSQ0gLY/05kUJeDRxwU7+1Nfc+vYq0tZ3Gnr8j7x8gWOrpIlwjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(346002)(376002)(366004)(36756003)(38100700002)(66946007)(2616005)(66556008)(66476007)(5660300002)(956004)(8676002)(86362001)(1076003)(4744005)(6486002)(7416002)(107886003)(186003)(54906003)(2906002)(8936002)(6496006)(4326008)(55236004)(478600001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Sl5Lo0eoTkHL9FNYNehbfHq0jRc2t5zxDNiJh1UBttZjrcAbi068Hbo3cDr?=
 =?us-ascii?Q?QsoALRztwJqcIuH3iTXBn8CFZQKkruJW4/7Wkh6AY7w/6n3ecLyuDhrjGCSB?=
 =?us-ascii?Q?qdMlcW7s8BFslk08SnGwIE1ONi7f0bfNZr62ZUZdHFYtKgkxCCNwlFMJmtZy?=
 =?us-ascii?Q?U1hnMdLN8AVbHLumU+6YBJE/jI+WYhv8lEjhDk1+vzyCJ6rKst5LBCZBnqR1?=
 =?us-ascii?Q?oRIG0CSG7wUvJqqi+Kv2+X9XTlMGgkZFmh4c5wDwyVjheSqzOuh0UHkHgLXx?=
 =?us-ascii?Q?tjE/RecEp8ZIVDlNLWWSWfMXUzwZvHHmskerP1t4ErllB87pbZwW1bJlhQnc?=
 =?us-ascii?Q?rqOxKOUO4iuxdXguuMAGISLkpflVUFEVTvVnslPRJrhMipHkRAIeaq084gUB?=
 =?us-ascii?Q?uhOmZ5X2K70r70JKrfDYX9x57oSqb/29POFFcHCUIK8HvRRoQXIo4zpHslYJ?=
 =?us-ascii?Q?9RN87W5/m0HbIhknNJEpqj1yHtuVODnf93kZTbqJwCnynlwIw/hxd8pEbKca?=
 =?us-ascii?Q?uRoptJeMmrewRdVvp79QfcdN5QD+VFjMVRaX8JXapNIGvTAbe/q44aEvn9Xa?=
 =?us-ascii?Q?VhXeU4x6KFoSi9CTxfUvqTLviS4SuPgVnI/6mAB4U/cH2J5m/kmE2nPes+2G?=
 =?us-ascii?Q?74Ek1Phx/E12uBmRlPPtWa3MdciC5Ab0GdYWOrM05cf3SZYXT2iXim/gw87H?=
 =?us-ascii?Q?LNrxbrF9Ui1e03mAtTu7MVThh6hJqUcd8VhKsR43LMJtEbzKbOtynMVwBqFS?=
 =?us-ascii?Q?gNxeP9dV4TcMYlsaM+6rzB+6lXwaJKYCwmKFEBBaUZPTXxByjtXg/Lv7lZI/?=
 =?us-ascii?Q?ZMyP93RWnQE0/QotOIcZyjWv9+bDkBa9Rnbl9zptWiXYpR7Wi/T/YGa6cW+u?=
 =?us-ascii?Q?yTuLhu8amV01BTeB8x8Iw/FCg2LSY7y9Q6msmunpEK/Sl6+HM90z18EAMZk5?=
 =?us-ascii?Q?A7EWKD3IhVMOXRGd7DzvmN+fxNkj7U/k6+9xSIEbDYc+2BjVfz2ZkhamGWd7?=
 =?us-ascii?Q?6KNlRKL8rJQ0V7QQrPQIOu9uBDuvpZ1zVD6aKtt0Lvfnbu6tOc2XnA4fME27?=
 =?us-ascii?Q?B6mXRLaBbF9mr/03PCUFsnX2CMyjUMlpYIKFoEeVpHA0VdMPf7ScoloAA2qd?=
 =?us-ascii?Q?VPoLk3VgIJ1oy2JBDaIWbHKvQtCIkgGBqSlIaxBwZcuCczfWcmbrjtV2+t4D?=
 =?us-ascii?Q?OWbmCAJ9WtN9KSfljy9dEXzhGPinq2KUzT6CIi94NpOnSeX15GJT5x2bB7U5?=
 =?us-ascii?Q?sBXfX0PsO1YfRc6tSrbFKYFkrMCcBDQ96aHTh0TNQRKwdwtxdpiZ0RotjpiF?=
 =?us-ascii?Q?89+9w6Umd/DXcH2mXUqTwKCi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f83ce73-99f5-4650-688f-08d957de027f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:28.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAO2e5JKAYLfSM5bn+m5LgqO5YpsRI5HWx4gcnp3cLKEjU6YBq9C1BP9XqMD+BwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2735
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a new entry for the maintenance of NXP S32G2 DT files.

Signed-off-by: Chester Lin <clin@suse.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36aee8517ab0..3c6ba6cefd8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2281,6 +2281,12 @@ F:	arch/arm/boot/dts/nuvoton-wpcm450*
 F:	arch/arm/mach-npcm/wpcm450.c
 F:	drivers/*/*wpcm*
=20
+ARM/NXP S32G2 ARCHITECTURE
+M:	Chester Lin <clin@suse.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/s32g2*
+
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 L:	openmoko-kernel@lists.openmoko.org (subscribers-only)
 S:	Orphan
--=20
2.30.0

