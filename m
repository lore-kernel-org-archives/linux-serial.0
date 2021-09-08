Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39564C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2375F61154
	for <linux-serial@archiver.kernel.org>; Wed,  8 Sep 2021 06:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347781AbhIHGri (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Sep 2021 02:47:38 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:38939 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346902AbhIHGrh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Sep 2021 02:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631083585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXs+WYTq/GaAVNusxxkSdxl52boJaTfb9zSvXV8V30w=;
        b=dEyzzjLXrQ/njXDSYO6JZADvlW33FZbqG44uf8/n7UORN6nkfD1l3O7BLUJ5yp1EbM8Liv
        iSIJhAyOAvPWRhCmmATfNUuxvNdd18A4xOaQCtlA0h7bBDC/sGDpADsZYTlhNox6t2ylj5
        Sc5WMcXW5x9DldQDoaoynT0smBsVkfw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-BohjMXJyMLqhkveZDyTWdQ-1; Wed, 08 Sep 2021 08:46:24 +0200
X-MC-Unique: BohjMXJyMLqhkveZDyTWdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta0Gyp00wp90cdUXjxiHBHr1kpuMPOhLw+/rcl7cCRLTErLsh6RfCAK9cwqgLXTDL1PqShHRxOsuWougiQI0DK3idDQzPuTwQJfp0d2ZozTEzFiQzgj0nCWDRCSXdG6+4IzND1fFwy9c0CiXHp/hps10gvBvPN5sZgE2b5KcTRG8Qdrclarq9nK1IHSSfFcEHy+aFfmKage/D23hl473g8DyaIc+DAcBJFnzxmukOBDVgujmfJ5OH+ZzOygkIjLLRhT1ynO2FvfG5k4si1iq5gTSiJsHq01D36iDen4Z48CaAjYE5Jq7PZRLYR+3B3Yk0ZpQrki8mCxuQJLE1Do1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=221xen13Gu7ESpQH05i1eewNp1uXACOdaALHazKZffQ=;
 b=dBNWVjIuWXUq0Pr0Sk1quwaHRc16f8P1R83sG5s7TnuhpYzj/voNROTBXmFCBwWFZWADLzBNNaFt74KFYBLtEEV7v8vPQcGgJGD5yLTn9NDa/HcBolDTaS+sPYmq1DWzMchg5ttTvWBVghDCpuJE7YI4KJf49gj6+bate/6DbI8cTpGhmxEhJkAtjZhxoiprmsrwEkh0qWpsYvoMIKiV2ChlFIsMVcnfvtD6Zsvx4yN2ZSRjcdCl4vSTzboSGSuDB5R0staHaHDkmy+ZFpu03XYCtfso7+4OoQZ/zDkcHuQCPheWeUJ+ZjQnn5KfmajOx9VQUIw1C5gxHJX4oicAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4000.eurprd04.prod.outlook.com (2603:10a6:803:4c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 06:46:22 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 06:46:22 +0000
From:   Chester Lin <clin@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     s32@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com, Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH v2 3/8] dt-bindings: serial: fsl-linflexuart: add compatible for S32G2
Date:   Wed,  8 Sep 2021 14:45:23 +0800
Message-ID: <20210908064528.922-4-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210908064528.922-1-clin@suse.com>
References: <20210908064528.922-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::18) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (36.224.129.215) by AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:46:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0894763-a39f-4b1e-e1bb-08d972945ebd
X-MS-TrafficTypeDiagnostic: VI1PR04MB4000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4000EA2B494EA59D78950BA5ADD49@VI1PR04MB4000.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxKBr0BZPGbVdZtFxQcFgMFdLATEdgnOcIxrgb0o2YCjfg6Fz9Ye+eW98SHM+w7U/QVhYJwW6ifIaHemKTdr9mk+V0fya5/ELUqbOSF7mjgkLFuxwUZdRHC6qIzxxhj0LAztGRt4n8vk6Civ1CliZiCbWIZTDrxmFQ99Bu/pMx38RHNcCiQbXas+X1ePDCOOCi6F6TIZ6301GzMtWWKBujVC1FMDicP0T862+z+rTosPxoyR8EWdtq0Cd/kt55DqNUf7Fo6oIr/ZfhN5Fanj9BhOUzSXZOdNnzIoBW9SPVUZ83Gykyn+JKT5Tnd0I5pXsB7TstCAlMdz1nUraFq0w6Tvo41SDR9kkY+psulLg6sRJNCGNnDjRWSXGoeiinwmNduoKpo7n13D8GiZUv4Imj1Q/Bgzc+oTkgyc2s7YYtoEVrVsHAr1uOoGvoyEbqymwpoXbzZjaQAK84UM2Ix3dAKmb9J5ynGuleG6SaTun9oL3xErLvEnWymII0hvaAyKVkpHgFsm/W6VsQFy9z+Sq8yQGVg3LERcocwhPF1hq9ssCSLTGU5D1p5Z1wUyY7/w51KI5j1/NK80LPFWy/5uwmdOSageMlLbg4DKOoNbkxggYH1arcsV0Vwqeru4/WnhvG+Tj3H/a3iXs5cpOkTsUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66946007)(38100700002)(66556008)(66476007)(86362001)(7416002)(478600001)(2906002)(8936002)(83380400001)(2616005)(110136005)(186003)(5660300002)(6486002)(54906003)(107886003)(8676002)(36756003)(1076003)(26005)(6496006)(956004)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNdDJV51qrrA08zcoVT8VWuOKM4ET+rAovXZyb7ZJwZVs8V1eZrgR5sKp3I0?=
 =?us-ascii?Q?kNkkhOp6iIhjA1qEkJKFADqaUGPqoqljf9AgjLxEV8FfpKc4EvPVrjHZ9tSc?=
 =?us-ascii?Q?6FRyV712FGipJzRcSZ4T4tcLOCSsEZwjfuFlobQDXSZSsqpJm6xgSCRQnKAT?=
 =?us-ascii?Q?sKthw0otHf1Qt3Skq1el1csMtpE/TOvQxfz7GxMpkX8FKkJ1CG79FYwCU5Qt?=
 =?us-ascii?Q?GRF6xR0fY2OIzUmcgKav021R+iNzKEaCalWdMIG2zmJ46NJ96QQjcbjtNfCS?=
 =?us-ascii?Q?hfjFD6R5eNVrzDa8Eg+odcfFotTim2bm3LNeeUpAAEoGM/Ao133V5jIhZ8FN?=
 =?us-ascii?Q?ucB6kNPFvZFxXjQ9Q4Xf91hn28xa/hFuC1331y/iZsHQAVIkItwD1FETJIfS?=
 =?us-ascii?Q?3WXAeDxz/wVAyBTc65jRAwqrQM5QnBtBQcS/wdp1UhrTesosJAi3qYZJHMVr?=
 =?us-ascii?Q?bqObJrlluirw1sSNv8fP2XBnEE+oxPfURfHhEOiVbo+WM5lWndhAyPtPdin8?=
 =?us-ascii?Q?oj5O2E2AA9L89g0ao2X6WiBeh6ZRPPLhW3XVOPKbOHZleke/8Bsqi9r7mKmS?=
 =?us-ascii?Q?N1SDcCA/cNA0tlOpGLeTRJgnBOCnzUVhAeXqXEyOIJ2XDBQKEqWa/o5KDCxn?=
 =?us-ascii?Q?WZrb47hQcImV5uEEPIspxzpgR+BVAKre9rylSFPgPGXjD0pl1qfK2vpzcR0r?=
 =?us-ascii?Q?zYFgWEXTvvt7hXUmBQyXHZujyuGR39bV84dPYqZd/75kiu40QN6aP304MhR3?=
 =?us-ascii?Q?4HiGc1+Kh6+VxOnF/bYuOKhILj/UzzicdSb671aVvz+b8Ciuld0ja5HlWf9o?=
 =?us-ascii?Q?e43VyzGSPpmcU3m/PyA0bbREfoEEFibtAZylFlBScR6Yl2v2ZoMZrxx3WPau?=
 =?us-ascii?Q?YHzxI8ljI+tHRTrLzZGywa+yJQVkfpPtsTG3izetNb5nzuZkEH2FwGC0g/76?=
 =?us-ascii?Q?HYwOoKEE4UHC+F8XGns0NOxEhFWH9l4QTKu2WsSvK1M5bnnUvF1VqyP6O9c4?=
 =?us-ascii?Q?a2FtYxlhasnhS4nGJyrR5XU/bIPEfqitYq5P3yiVsH4wUFAjHwFMUI3Lzsb+?=
 =?us-ascii?Q?QYGXCLAtcsJrtCa24DSp+wnkokHEVJGymWPe8Iym0P5gj1GiSs7SDYZ9u7Vz?=
 =?us-ascii?Q?DeKc5M1KqbpBLce9o2bRlM96B900VoJp4mYY7QUcRHESSS1ZRZYawbzGeo9u?=
 =?us-ascii?Q?4h4ZE7N9Ue1aBcClTmo5PqMq4BCRkFsoUqKCj7nWkD2KacMtuL0IStxrzOMn?=
 =?us-ascii?Q?rOIxdfnHPSosp6Y2zt66tPuPKGA82u0ZPf2zUtVaPgZv68n2SbJCtYuwhm84?=
 =?us-ascii?Q?TXelViqN9mxUXxzrNd0MUbV6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0894763-a39f-4b1e-e1bb-08d972945ebd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:46:22.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah/VJoGH9iHPvYcdij5E5OJTGdt+jGbfhtrc6o6F3NdKRt9ppYY55dv3In+GdaoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4000
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a compatible string for the uart binding of NXP S32G2 platforms. Here
we use "s32v234-linflexuart" as fallback since the current linflexuart
driver can still work on S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
Changes in v2:
- Remove redundant minItems/maxItems from compatible properties.
- Remove the redundant example.
- Rename the vendor string to "nxp," for s32g2.

 .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.y=
aml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index b6fc123e8375..8b643bae3c7b 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -20,9 +20,11 @@ allOf:
=20
 properties:
   compatible:
-    description: The LINFlexD controller in UART mode.
-    items:
+    oneOf:
       - const: fsl,s32v234-linflexuart
+      - items:
+          - const: nxp,s32g2-linflexuart
+          - const: fsl,s32v234-linflexuart
=20
   reg:
     maxItems: 1
--=20
2.30.0

