Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0344C4338F
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A373F60F41
	for <linux-serial@archiver.kernel.org>; Thu,  5 Aug 2021 06:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhHEGzS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:55:18 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:46727 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238064AbhHEGzR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 02:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628146502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jW9BYPafQwz0hqbhPn5gBZcorXOxbUdqUq3e5515oco=;
        b=hM6stuI7Zta6QyezVSZg7xone7e2LyoMcTM2kiXGf5esTXoikFEpIxpYaFufWv/24Se/WW
        JS1ADTEymInf6zkSZkp64QmVCD72NyMmpUlKcfCeO0jpCpazk9rslB9YyFHariD+mmZ9bY
        9bph7LCVXOJ6wi1ADfKeUq4bs1EAOC4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-hGukeIE9Ob-A5Jjpgcqoqg-1; Thu, 05 Aug 2021 08:55:01 +0200
X-MC-Unique: hGukeIE9Ob-A5Jjpgcqoqg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE0NFsxiWmmC42XSLZrsDJMjVxe8tB/Z+l8OUVxnX3rX696BT5mOAVo8oImiFaqB/uYKwc9BaA/xyWvJa3a7sSQfB6QspDF5/gCE42pnK8Ko5emQwfI6X8DL3GDxRNu/ZMODzANSmRPEUVVh+wlE3G9r+JLgURJnr//bkcHGQ209v3PccDfHj1kNHST9QoR1rltTH0nWlBXixHPW0aZ9U0Bf8I1dZrxx2JsYTpu5GyUmEOWoZLrf7adEAyf7fzzO7BMFznYmHGU9qjnT1beqWnmm1k4PEWdx9b910dUw682CFhsc+C/P66iM2wwOGmssWKsPbW4aTnN0WG9KRQnUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1ovP23rpWdyLFH8xgDk09nUilByYr/YFgxkbPX8K+I=;
 b=AkzGMMUWk7HNlSE6FWv2R4p2k72yRmKE7b8lmSFJcxYQLS8lpNg3uELxo62NoGQiCwDvHI1uVG7KOITYw/BCYQAFrwISzlvxZJYvOvgF9seFFvckmNvpjaoDe/tLSWvy/n5M0OsmwXxDNPw3tqOOwk1l5daPG/3d/5Nz70eUGk9LYJKOGJpbg8ysh1j5lJF7dGZO/7RwNUH5WaMHZEBvI+D3Oi5/UrsGZKmUJeZdFYNaHRqkO+gcmiieYUFf/q54cdJbhoakAJTSELGI+Jkw0Q4SZydSCi4h0S9H9DzlfpTgcUJAJ14+VkGJQTujTT37lotofqDKBl4Pq8sYzfi1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR0401MB2368.eurprd04.prod.outlook.com (2603:10a6:800:29::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 5 Aug
 2021 06:54:58 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f1df:db6f:4ff8:a667%5]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 06:54:58 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
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
Subject: [PATCH 1/8] dt-bindings: arm: fsl: add NXP S32G2 boards
Date:   Thu,  5 Aug 2021 14:54:22 +0800
Message-ID: <20210805065429.27485-2-clin@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210805065429.27485-1-clin@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (118.166.54.149) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Thu, 5 Aug 2021 06:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70472e2b-0900-40d0-96f0-08d957ddf051
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23683DBE8004BE7444803C9FADF29@VI1PR0401MB2368.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zedJeQunFkthDpeelHl6B7w376lhP++5az2tdcEvePTg0XmLGnS+e3IItpzL8JMl6fZ+HSad9JXnyrtx6E+bMLD+8BMSxtyLQdM9z0tiCojYeqkFtA4K2WMxsNEpLQslsIbjhiv0aGW2ZN3S9me+PlM9GFFqRY7H3HLQhcxGesw4+3sTnL4ud3fiBO3LO1aB6+UTzn77hG/z0V6LIkTJubS9z0YEPZRVhklpbv2dsP/SOayrpOnG4i2+nWC49XOKbeGJo/X2zW7YaO2aaP9wj6sTa1MgdrcxcGgrnnMhQvxfcb/KX9H+NN8TrQeTDihUBB4tul5LBgiw5BWGSFYJySy9qIR6iKNMpyNd6dRRpJuW+vgiZINs4+rFj2pxE3HzbXS0mPxtk/orgOErSmzZ808+N6SHJksBeM6qgH8cf8jaT169FBQJG7MILK308vt+nCakoqVvn7sU7U8fh1hXZcsP1YsNZFn6hmy/LqndOeQv1MPwEbckY68cbcnD2yt6EzBO7cI4AKWzLW+R0fI2KJ5hE2XCFIWbRYlgOEGn2QTpmfdI9a8fr5+mjuAh9dNl39zs7aRI/Mn8dyy+bEq0X0yCdr9qNQbKhQI6SfFdJ7Bt0Ybs6qN+QnNk7f+dout5prk8pft2STWuDDO7S/Bn8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(6666004)(8936002)(4744005)(66946007)(66476007)(66556008)(956004)(2616005)(508600001)(1076003)(5660300002)(26005)(4326008)(7416002)(6486002)(186003)(36756003)(107886003)(2906002)(54906003)(38100700002)(55236004)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gFB9hm7JONgt00H/nNzQiFdECu/gXcOdLHVBOnUFHbOvpMoGMWzYhDgDX24n?=
 =?us-ascii?Q?8xH7WNWAmkekgSWAWQncU3q5geTr6yTayRCvAUYABZrssLj+pqvjxd0inKVU?=
 =?us-ascii?Q?MYf+P9yi/atWjPcjQJOExzxkzgNrKpFKfH5GadLuKfZfnomgfWhyutYtZO8G?=
 =?us-ascii?Q?mjgUI4NxAKqpcEmUaRyu96ZveOqS9S7IP0lPH5w11PmR+5aqXEQFjlT2F2zx?=
 =?us-ascii?Q?/upVULJfUeS51K2+26m5nrG2zQ+TIV7xIyVaYFUIHZhAeG+0cw6gaWK7AiPl?=
 =?us-ascii?Q?GEdM/6D4GtDwsyy6GgrNPdVnHUYGs3X0fvbLRDJZ4fyV6UdfQa1cWG2a7ukj?=
 =?us-ascii?Q?VwxNWvET1093jD5HeY7Zpq48l6uke7onpMIvkVWjQYBsmhU/9L61RtnBuybL?=
 =?us-ascii?Q?iKEVTwXVxXVJg0/mLeEh/Dp9rojOChvSsCxm1Rb67nCLPEvQ6pouEVc9ahIF?=
 =?us-ascii?Q?Nrh+XIm3azzIur3lE0mUZUOquob//8TdtPlIXIW3Ql3/pXrRZRpLwYRPKt/B?=
 =?us-ascii?Q?HghesNt+G3hZY6VWzDZHn/cHNBorX99ReA/nYPY06JJswUhlYLrHk6coGl3p?=
 =?us-ascii?Q?WyjfAm7l+7EhSb06ibhcB6oRll//REXVAXXbvtRUkAgGHSWTGzIbhtJqlAph?=
 =?us-ascii?Q?oLDVpyfbmbjdBeUk3zuCQfONCZp3xzrdLnN6nmTu3eQj6VzL3PJ4FMTdWJSO?=
 =?us-ascii?Q?vMva+57Zxk7hcIjAHgDDaLGh979YG0gatqH2kxF3p7t5t11tHjzGp10mdqVs?=
 =?us-ascii?Q?2uDDWe/vYCgLQc4AT/UrmPk3AVIgmEm0BDEApcZ1spK5QtU6CVYnZbtUBZsy?=
 =?us-ascii?Q?lc1VJnSfL6qUc/vDczfZYYbbrVs7vq9ea9jj/M+we+S2CdiP4aG/YjIfvMmu?=
 =?us-ascii?Q?UJ980oDo37aXkVolRP7dpHEvhIlOl6D26fWxFLTsg+gF4uk0Doo0hwM4JSzz?=
 =?us-ascii?Q?z/9HwNlhOwcbos0pUytjqbrYPRItdmO1zxusm7Bihna9YZldtRV1W3wjklAl?=
 =?us-ascii?Q?YzqYLTDTI/t9pnUEUWscVphO5OaWa6githEUiYE0GWkY5Op7ZZhC+e3JWChO?=
 =?us-ascii?Q?0nRNOiOUxqKx3uii0kgLxr1XUhTJbNGehYaB1PAoW9QxOwMBj1974bBlTLjq?=
 =?us-ascii?Q?BJfeZh23407pKEFFGp4iA/nSYM2W4CcOo43TvToAmLqqkZzSLaok0Hv5Ifi9?=
 =?us-ascii?Q?smsgBXRUJOI1NOlRU9mJf4jsor++BDMID/DXSCVIhCA9yr33rKI9RtCkzpuh?=
 =?us-ascii?Q?gG4lTDFVo2lZKQ3ZHXjrwhSwB+/vY2n20fIsGNF8v3U4Tzx/NqczLIRFcQ5W?=
 =?us-ascii?Q?6r8Ln+42MO9kludkRcxEjuRx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70472e2b-0900-40d0-96f0-08d957ddf051
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:54:58.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzfgOs+XCR6frG7VjIgWVl7AlljPDFpk/NMZawP9xuX00EQJY1CcACudc9HLA83j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2368
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add bindings for S32G2's evaluation board (S32G-VNP-EVB) and reference
design 2 board ( S32G-VNP-RDB2).

Signed-off-by: Chester Lin <clin@suse.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index e2097011c4b0..3914aa09e503 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -983,6 +983,13 @@ properties:
           - const: solidrun,lx2160a-cex7
           - const: fsl,lx2160a
=20
+      - description: S32G2 based Boards
+        items:
+          - enum:
+              - fsl,s32g274a-evb
+              - fsl,s32g274a-rdb2
+          - const: fsl,s32g2
+
       - description: S32V234 based Boards
         items:
           - enum:
--=20
2.30.0

