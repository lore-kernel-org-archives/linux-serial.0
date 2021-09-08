Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4604BC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242476113A
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbhIHGrW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:22 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:45576 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345271AbhIHGrS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdnlOeGSjgNfKN2uJx/PLNkvhRpwyzvadS7vHTpn9Nk=;
        b=klETr64J6X42H+hiTwHKMpx+eC5dVcTmlA+BaDEvJODTV5MHsDHzb04VQ3/F9eO03YGoEg
        1wiLZu1SRXU8PIvrcwfdAjeDXzzbwgjcRTkTmgmIBKcEfiA/NaieiEGI8X4rmb/+YvuvH5
        ZhX3MRK7586/xVXORqtJL0xD+fpygfo=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-14-7SzPX__TOhqATlCbSVIaUA-1; Wed, 08 Sep 2021 08:46:09 +0200
X-MC-Unique: 7SzPX__TOhqATlCbSVIaUA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvMVAzKuNC9H9JkvPyv7QU/UR8Xu9n0GRCZ+QWA0P5HBDR4Oj/9qjUPnYmrv5OGGgDXnVLX9jyXW71dFZvUalxI3DBhMz/VDOQ31zKHV0t49/S3di6Pgr8D09YyVH/aFnhZtcggLPfcYY+rL+T6/cr9Y6aaumWhX9RZJVjsRXt/K3Owlz96v/4Iq/UxncxTQ+tSXmahktD+CdCXigKj0hZtcGBzaEGN35ji+noRBuNqg7x8b54i0FPjcQ9qRKqMp8EsycaSLaqmxTgrarnlszDj2wgvrLwB/gCIDyzZsXAtNlPJM4zaDmN615nzoPUJPALNqSQu1AXs1BRj72hbXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lcEFoVa3KHdbTGzE5fHmJqhLolW23XjfCrQ7qkpujnA=;
 b=ft50BclOX7EXPOHWTE5pSrEZx0EDMqbdxgEg4R4KklLihKTKjftByofvWulEVSXCWgGkEQdXuxVdGN6v6Zi06BQweeBDdKVRGGhEgeyrfORH9jZ2HRLxK2OwfuaegZqCftZxh1VKbZB3Mycsgv3kHCIrERDuw1Z663X3yvLxvI6r21ytcN3jYPt/5iv2t3CBGbE2RHsy4k9rOWkuiedSdHE+F/AtCxqZ1jcSzHRQvP58aL1+3uvyoEPtdXALZQW/95C9VZOu/JE4EF85hsR6juwzqdl7JRgI4QPpkjV06aetnaH8eJ0KGbvCpZVec1oP6HKIGixDSfg0UvuSGA1Pxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:07 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:07 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     s32@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        ghennadi.procopciuc@nxp.com, Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Date:   Wed,  8 Sep 2021 14:45:21 +0800
Message-ID: <20210908064528.922-2-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0021.eurprd03.prod.outlook.com
 (2603:10a6:208:14::34) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by AM0PR03CA0021.eurprd03.prod.outlook.com (2603:10a6:208:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f4e61f-a315-49f7-102a-08d97294555a
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40004BCA7D4FB712A2908FDDADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHJ3FsfcEEVZcWntvbVCKc364+YtwpPmkgXkyxvs0pjo6A2AnSEVrRuJYsrp4VRMjIS1e7WJw6gbXnpiwTnWnqXaazJd81OLmJ9dA1kJriOu4Wv7OuQSdyPsmdaXReKCIGziKy7B8aQnYcHn7QHdVb32Aq1WvOUJ1iD3o/UXv+ybS69xFc+I53D9leO/9Ggu94uvdA8zCv39BsSQcC3eVI7uh6VUUGxZrfPm4EN7LiX4BKyIVK9sZ1Iobf9SMjD87rzRmJTYa/Z1YD5Q1bhHBLjCjBlqvpaTQXatc2VJToHKe9svDLIKZ+kSmE/AQJF9CG8MHNyCLWvYu52DD0l6KuXAfUz3/GIC+LTc3luUz+Fu/9PyMMgsxlX9MYBTjwxLkamQUsjbx0N8GLu6Nh6jRLJVV1WlxcDR5KbxmplgA38zj3XDUq9I29QESyAwyh7Kt2sNH4u3vYrFa78QTxYDOSU1bfYcsX+0EvkUw6zISi7tmCLCkT6QLBFO+KuGCme89x7SuLVF/Q/Jcylxos+r0i+3CyGyr7rj3O3L5icMJlIRSTl42DNK05RaED4+BOQtg7X4OzkK3Q0CpdsMYpA066Oea0nYOirsOPDK0opoxGuf+MbsupKK+69fHCC+Rus6go81hwqOdOYcsMApxQOF2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(2906002)(8936002)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(8676002)(36756003)(1076003)(26005)(6496006)(4744005)(956004)(316002)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVYZjRW0fXymcvac4z/XYhYfqm34EsVweU2cQ6BkdHWU6IPxWbg2k4erbuWw?=
 =?us-ascii?Q?jYpX18CQxuIpDYFLsw4g0OmkNNtqANScBFvq98BZutsbl/lXNXq36XlUvvwx?=
 =?us-ascii?Q?2bHn0vcw/wEVBQTILYz3fAkWcUVSJyNkWZjen3Bw5viss80UQB/GtPUCmYYw?=
 =?us-ascii?Q?FAnqOoYblwd3EzV6QgjQFJZXlnUKFC2TIPSOLh/UG/rJzfqfTVibfmgahyTl?=
 =?us-ascii?Q?jprWxOujgpMGLhaUZSriWBYKDhMJaS4lAmy9M3vlP++sjGkf83ec2F4+jcLy?=
 =?us-ascii?Q?MOJhiFhgxjVKFE3CAuOU1C90g7w48SNsBDWJe5GpbuNEZFvosHxfFHXqKZji?=
 =?us-ascii?Q?FQjrB1cUEv4itVwVI1fqjmQ2Hcdmc6SqblxgEGwhSl9ysHQNx+3AgMAl7fSM?=
 =?us-ascii?Q?U9W//CfkNK/v9a9d8dtN1mldFOKmIfOVkdXSIv1agreM/JC20YWdoKMzmDbH?=
 =?us-ascii?Q?aI0YXaThzXMcbJ4SkbVtu7AMbAHV39Mdv289UDzJ8Tc1JRTzR+yAnsBmbkIp?=
 =?us-ascii?Q?MTsNH5qsTjQDLD1TD+mT8dDahOOFYmN1AwIPxXd/7linUreb3ZmyHELvz6w9?=
 =?us-ascii?Q?DH1iQFpoHr0E9iZuJ/qm0gdk73bk2go4ydGXM4gxK1OkWrrcyMuZWV+zCxvQ?=
 =?us-ascii?Q?s1Djm9D5uqDtM2/wgGIiqTL0WeISEGu1mDI4NiNnH2hJI9SGWk9xV4Gr+mUT?=
 =?us-ascii?Q?azWJd6AOmhJO6q6boxs7A60bxjudhwZ4fKTt9kmDOyUX9uwq9LhNPWHjuBCS?=
 =?us-ascii?Q?rBnQkhfF7zkLlfFYLaCMSwl/dt37e72934+poiamIrAs3As6NMXyJCAsXqDx?=
 =?us-ascii?Q?Ogy5ynO7CzM1eZIFcAiyFUuoU280oajHum6HHG/25dKt+avuefnYpzn1+VsH?=
 =?us-ascii?Q?06i4AVnJRll1sMpRkczvDqIDWp80nM671Gsa1EXIQXSbJwQ8rh86tEED9ftB?=
 =?us-ascii?Q?3YxhZ+TXULGqOKtUjKVn8Yfgl3IwDJCzIzTHoyo9GJPNl2USAp4O2krJ4t3g?=
 =?us-ascii?Q?x5iLd0O2VGRmUi7RLoXlct/M/t+MeHrt6hYzr+HXYJYIx0fuDYK4PxiW5nvy?=
 =?us-ascii?Q?CGSwDuiZ753z7+aSSggpN33RL7OShCI0Ih74DPAEkrFzFjvlg42VJYQ41uUx?=
 =?us-ascii?Q?cQdNjP03bVhckiH2eQnfUoVn4lpwKRvl+VygSecv1baZIKXfkpN7iqu+LsZ/?=
 =?us-ascii?Q?9OCnl5sib7CVdS9cJNAqoqBmgBtdGVaOOPEgpZsVY56QCA5EsaO6IzLSH34l?=
 =?us-ascii?Q?WiDkLs6BovyjxPrkJhakxC6xneqjco9FZtiFV5DyozRcgM86uSgNRAsk7VG5?=
 =?us-ascii?Q?t36kBVquKKTdpqVszHEMqhVe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f4e61f-a315-49f7-102a-08d97294555a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:07.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEk81zZGp+nLtj6QD2aDuN/f/MJ93tGgmZLft06VlYeSIBdqG4OYAbvZgQZO0UC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
design board 2 ( S32G-VNP-RDB2).

Signed-off-by: Chester Lin <clin@suse.com>
Reviewed-by: Andreas F=C3=A4rber <afaerber@suse.de>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Rename the vendor string to "nxp,".

 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index 60f4862ba15e..12ab7ac565fb 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -990,6 +990,13 @@ properties:
           - const: solidrun,lx2160a-cex7
           - const: fsl,lx2160a
=20
+      - description: S32G2 based Boards
+        items:
+          - enum:
+              - nxp,s32g274a-evb
+              - nxp,s32g274a-rdb2
+          - const: nxp,s32g2
+
       - description: S32V234 based Boards
         items:
           - enum:
--=20
2.30.0

