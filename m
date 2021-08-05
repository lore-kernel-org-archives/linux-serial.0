Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A3C4320A
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CE7610FF
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhHEGzm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:42 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:42787 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238268AbhHEGz0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fzP2am0mAceIOfn7bgIN9HS7l+KOoyWK9Oa0OawNj5E=;
        b=lt4T+hMq6+QA4figlZU9WlOc9LI6PzIzv3+90XR6/wQ4v1NpSWpLDVn0sj7OOdnm8llXHI
        rKKmFuoKcNn5nppN7D1/FC18XUPzmO9HDxb6S2CeF/X5AV1iwiaeGU8a8mZ89VqOOrvXqi
        PokSZa7D3dOF9EPNRvjb0MmCYkYNr3g=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-JuQAzW8SPu6Yrlzbjlh2aQ-1; Thu, 05 Aug 2021 08:55:10 +0200
X-MC-Unique: JuQAzW8SPu6Yrlzbjlh2aQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjfU5pDuvXyCwiW6TzMYF6dNDiNFJGoRYZqZa5hrF7pRyqEhRJB+/bQYf9QsTyWkRFKTHeedaB/c4AvCDPohTAoZ5xxLiaQDllvsyFixqLRPY91ptQO+8LojnsXv5NSPq5o4N4NAF16Ywlv/5UjVJl24vG4BP1XjykHj1SIA2cnZyyjnc/hJoOw0JZNuKT8opInVMTT3XVw6fduVyAB+sqcDj1LmQdlxh4aXqLr0FlUjVF/dXj/9VxEl6K1wtHVMTAO/vd/vYWbBTT0WI/7YpG44BDrPJkQGErNX74OSQlu701V8afDXodIhrkAQg9X+7+UE3EZf6TOYAXGFMr9GXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LJvtl16I+hoBAOeBVHcYMF8agvos6aS1wgLlSb9TqQ=;
 b=GEtKDAQ7G62a42lVpt+8tC+zF4d67+ahjhYVFl0E0zembADSneV0G95N0YWbJZaKGX02EiRMQsxLgYGjWNMu0wiTS+9VJTNgBi534QasU0eH80RoeCaNiOVcn2fAg2/qhungpjSM5yYamE8IGiAo17GDP/5Y6kqSSUmj4mkoB8NqpwKi/deiIyqlOGu82FA7lq3MaZtE0GgJMqSGw5X7p19kbKu7EMqH9K2DINl9gLqdmIJYPoBdbq7eHsd97gOS5gG5weD8iQRavnkfrzmbrY9aCGxIFxhn7F8nqlWjCDMXWLZww6aP/WgC30xZl4JHds+T7cOailFYIG0m8sMEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:55:08 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:55:08 +0000
From:   Chester Lin <clin@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
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
Subject: [PATCH 3/8] dt-bindings: serial: fsl-linflexuart: Add compatible for S32G2
Date:   Thu,  5 Aug 2021 14:54:24 +0800
Message-ID: <20210805065429.27485-4-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0146.eurprd05.prod.outlook.com
 (2603:10a6:207:3::24) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM3PR05CA0146.eurprd05.prod.outlook.com (2603:10a6:207:3::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 06:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce3f095-f558-433c-f832-08d957ddf611
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2368F61AC57F639CFBA14320ADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ip9obbrlElSRcGfVHR/B3GRHV9AzLcggm++0Ka88A7/yGRB5WeJQcgr2wvuqli6cn3pEIJw3eVAEVe2CJnNIR/Vciu00bkDwdt+SnlmfAcuYCJN0A2nkkBDXS6edJI1AlG3LHN/JvvCHrQoaFvgSlc/a5cEFmGNg5sMFBSCk0Sq/ETrlaCMtkD/zLz3gvvKwfl9lGS9bKwaO0ng40YFVBUR6Bc/ekXDvqQj61ID9YFeevwhhRWsllRvVu22qGu8isgP7OSnCDk6UYhSsZ57D1kF+Blc25K0sacRxqMkh/UCQdVEVNOKP3BmDZR+iLqjuCMBww7p1vEYu5bx1jshuiz8makptgRYH31Mqoo04ahA28gqbI/LIfkFfvWe5zpRnV3livEb2urM5EoQgYhiU6kQFCC+29yp1vCTfVqD0TH5zk+Vs/SWKcw5RqCzbrWTqvBGV5IHoNZ0hAIYkzNVkb0FmQHhYq5N8u8fZUBi5enPlM5rxo99D/WExlnqazIz2QZjMVMryYnIqDgMJFvTd1i6PkwPg1u6lw9jtHhC+k6Gu/tfzTothZmDEkVsrv5P3XyGfUmL4RLNixpzgb/3zYXKohlUUglSL8E2y7AL9bOR3LkhmCFKT1ur8PQVCuhvITDxbYgryOitAd47F+E9cCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(83380400001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(110136005)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygsW36Ijm+kjUOxbCZ8yPodW9eZEqtXFOVEDVjMkksnvGQxkRB9CbUigRIYd?=
 =?us-ascii?Q?VOLYpBOZbUCbrwXo6Zl9ZVdCg9+TELlgURbpxczQeF67nIoUFCEnOKI0xG7E?=
 =?us-ascii?Q?SwbKiIfx+K/mnxtFFhJBL3Ifucp89rJyI6kcpvQA/D+snczmeToPr21CTYC0?=
 =?us-ascii?Q?E0l9KVSRddXvzLHAObfWq0/YAkLSmO5Q6lb9Ub73RZJg1gKPN++ILUGADsK5?=
 =?us-ascii?Q?QKGsD8zpkSfEtxPi9Sg2kFqKuSQkIZVFlpYVX4geCwUPxmMeXEPKvAwTez3M?=
 =?us-ascii?Q?8IHTdoVvwXiKWHP1AXXYb4VPa/fd9Z5RlmsrlRSVeTOn3IzIC968KQUraYpz?=
 =?us-ascii?Q?QQXZEJTYyjGC0mJ+A7bvcL50PzF0BxGxah9Hd3qg1UHVgsxaQXhK2QdFe7fp?=
 =?us-ascii?Q?rMdaj0qsLqImp6ATC5bVnktGzELjm0njTR6sl8B5YAx9J4Z/TCbma+eXKN2O?=
 =?us-ascii?Q?7x/P5/nmdvo5d6Ldotm3eZkuNuIDBkRdWJxEMAIzftMwn8InJ1Pet7Clp0LP?=
 =?us-ascii?Q?yRGYKgNe2eJLoudgENbM9YzkZoxTjxvghrqFrtdm8x4oat7j+Gxyls2De9U2?=
 =?us-ascii?Q?Diw4y/PTgWPICfSSeRS09d4Gi8T55FsScbHCSGJjsn+I1r9xtGuE9VWxTHp5?=
 =?us-ascii?Q?w79p0fd6jnIOPxi4kYsSfeNUu9oXef9wtQhp5o3VEi4IpmQd5a6XypfVcUrH?=
 =?us-ascii?Q?duAS1QvvUAUe+urnOzgsiL9oIuvNhJI6jCo0mX3dYqaLCi9L8iNjX18FhhpS?=
 =?us-ascii?Q?odBv1/t39RiK6pFEVIYzQgqTPtkugyTibBtk0XFGyy0Y6N2hVTL2xJgypQ7z?=
 =?us-ascii?Q?X5Z77Xcj/k4CKr5Urpl3W8ZmxPpzDQKVmtyZpfwM3Jq/3uCJwpcc+MXqW2Py?=
 =?us-ascii?Q?sziWqK9p9NOOHjsBQmgTsirxzHCKidJM9ulfczu9QYhrS8C+nhNf7YVjJKpy?=
 =?us-ascii?Q?XBF3BXW3y6yKaiTghVfm2GdWLyoY9vUyj1GWxrPQy7Rjxa5WXFmv0RTj3wEN?=
 =?us-ascii?Q?EI9cwVsum1MmAZEjC9jE3jKJnVitfKWdZG4wPsvZSANqWb0dRM77qt/YwsXj?=
 =?us-ascii?Q?eeUnwKxmYwz1li4beNeRDjn9il5Bcf6t59+dE8nXYsgU5vVJjDzC0IZzaVdq?=
 =?us-ascii?Q?/a/wCwFDFftjTLGGpaFbPRwxJAcsDhKcMI3aYE7Y/XcHP4ZpZ2wXEsjD+D8j?=
 =?us-ascii?Q?rboWiWOMcTPlcqmPE1h5NBLW2A5FA5slNpuWHJGmPZcps19F08CUx9fPtAyt?=
 =?us-ascii?Q?qAsxWTAf0UJB/Wu6FfhBYpaebYoC84ca3F4ZEr7/OWSzcAbfU3B7YCyYnztv?=
 =?us-ascii?Q?VEs7DC75e01kPD7atK1ZQfMQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce3f095-f558-433c-f832-08d957ddf611
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:55:08.0395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLxGp7Ijy1h7RXnjwOpBEPslr11wMR1x/m39myN35qKOTIwpvIutG29O+o/Wvow4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a compatible string for the uart binding of NXP S32G2 platforms. Here
we use "s32v234-linflexuart" as fallback since the current linflexuart
driver still works on S32G2.

Signed-off-by: Chester Lin <clin@suse.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.y=
aml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index acfe34706ccb..e731f3f6cea4 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -21,10 +21,20 @@ allOf:
=20
 properties:
   compatible:
-    description: The LINFlexD controller on S32V234 SoC, which can be
-      configured in UART mode.
-    items:
-      - const: fsl,s32v234-linflexuart
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - description: The LINFlexD controller on S32G2 SoC, which can be
+          configured in UART mode.
+        items:
+          - enum:
+              - fsl,s32g2-linflexuart
+          - const: fsl,s32v234-linflexuart
+
+      - description: The LINFlexD controller on S32V234 SoC, which can be
+          configured in UART mode.
+        items:
+          - const: fsl,s32v234-linflexuart
=20
   reg:
     maxItems: 1
@@ -41,8 +51,16 @@ unevaluatedProperties: false
=20
 examples:
   - |
+    /* S32V234 */
     serial@40053000 {
         compatible =3D "fsl,s32v234-linflexuart";
         reg =3D <0x40053000 0x1000>;
         interrupts =3D <0 59 4>;
     };
+
+    /* S32G2 */
+    serial@401c8000 {
+        compatible =3D "fsl,s32g2-linflexuart", "fsl,s32v234-linflexuart";
+        reg =3D <0x401c8000 0x3000>;
+        interrupts =3D <0 82 1>;
+    };
--=20
2.30.0

