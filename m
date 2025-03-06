Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474B204C27;
	Thu,  6 Mar 2025 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281069; cv=fail; b=iRRSyriDal1vvD+uKjRUsc2bypReebcD14iaRSUmLqDKIU8Iu52kUsup+0hZR2YS6JyM95KLUXp9rJcq2TF8lmPU0BefRZd2dKgaSoSKNRn5vU1tUJDyzZ34oIsHR0+EfEfHHWhP4YmKjD/G2e9QgHqFD7SHi7PRE4iCS72hytE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281069; c=relaxed/simple;
	bh=Sm4DdcIfK2oQqLkrQ93cpmuvAe9D0m319LH4XsCCaSg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y+2vCE4GNj11wpshN4VzUMCMYMTJdLyhefZs6NO4MRpoatd1wrCjfXzFUdEx9WsXA/ZuZIaHFspJObz1vLZ/p3iPcMi0uOFdE1jasl4y7h6Ie5MnPKLbQzVyDgZhkKY8JjCjl7yqezTdD+7/7fCBWqQnbKtkZxaG7zaZ2pKFC7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AmMKu9K2; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmMKu9K2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qk2JWui93hvRfqgUY82dhgnsVVvh3x+vORN1AE6+nD0CGx6dndzlelNcdmAatv8YJBjBKSP/bdmWaTtQ16FWVR4z1fT0RYO86ezNJcIj1lSodB/dlhy+PjiqIOKmcfXRulFNFWjph9tyZZv2eCbnK/46ry/6hjuCpTfdo0HDWI8xepj1a8pl//xjMmFFqWiSkd/Oe2OBo+VTWqi1LZNMB1LJVvLeEZqdO0HiID1ccuOxJi7NA5WkUToImy/nTuqHkkTs2jPa0DisApHKAHrIfv2fstjTQBbeB1W6ZXMFQR9x69ahwsReolVFSRskZlYv/1rqmHt8aA3U2SGf7UV3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXdg1E7VgmQ7lFdaN6Jztu1y+tJBSHUpDBIOgZQ1qJs=;
 b=ivoXFKYAyPqS0p6kZspGpcmCQe5zb7tRI35pyDeDnuE7TxF+bZ/qc3XGwPtEa/hujbpUET41ytyDJIERCbn0q1TMlsKre4xAeRUl2N1vNNDV2qWNa2BrFu2dirsvyjlEaB/UMZYQEZQK+isFl8wSmXWemKcyIc0rQZ9uwSJLTj3zzoHs5KrKfEzVC7+Npyt4Wa0DPMLFG3gPgboCdrQLKDAqwvDgXH2xCyeU4mabTwJ4hx8w8UOx3RBOmGUz4/B273xn4KDz3CdTnZjHixB+kWC2tqrQMNbdUBpdqXhaPU0APsiJ1vO69wa6fyQAmqo3VRgN5RIjJkcjYGIipDaBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXdg1E7VgmQ7lFdaN6Jztu1y+tJBSHUpDBIOgZQ1qJs=;
 b=AmMKu9K2x/I+zwY6p+kAZjz0+F+oCHlWYQJ+oLYUfWzG60/KtXaeV1qq983igSUS42XAuJzcsChPpaoOZUp8w8QEg9wIHj7Ou/6Vp7h6jVa8IQPTJcnZCRwFLeK/cnG6NyWu3m9rnKYgsng92dEX0rDPx5dnQO5J7FgGXIzLpa7rEiTl2GOef1wfi+CgwrxlH6nj8n1Tq4Ev0hRDzGFndKVIhyKTme6gAQUYW81342amvUH5YA0aKa6VDhMJ2u4BCvvs7/q14Za+kpwlwrqtLG+vi3kR4UsyCVgFx0bvg/mCDnGxH0P8F4+YKoLVYsVpVBygnpB8eQdgoaV4AD+Aaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7306.eurprd04.prod.outlook.com (2603:10a6:102:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 17:11:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:11:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fugang Duan <fugang.duan@nxp.com>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: serial: fsl-lpuart: support i.MX94
Date: Thu,  6 Mar 2025 12:10:51 -0500
Message-Id: <20250306171052.244548-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 88880318-8ffd-44c8-96d9-08dd5cd1e0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZHJ+h+0O2jWc4Oqghsk4VpsgbPKQQ59F55jW9EjqFlHKfCD/VQ9B2F+hV8uB?=
 =?us-ascii?Q?H6NDr0LaKPORq20EsIitIE8P0jFxKESdVV8a2qs/4an/7UkmJEH26DQVMyy5?=
 =?us-ascii?Q?MAOL46cuIvCnCBuRij4MYlM1AARFWy3XJceH7jRuE/icr9GwWg/+u5GDVgwV?=
 =?us-ascii?Q?ETxZ/CHq9ucAETEGQRUf20naO8skvwIL6T9mgGsYNPyeRP+nkQkVUo1B/+m4?=
 =?us-ascii?Q?KtZgHn+lxBWsFKNK6K7DrjVS0VYur0QRFWdX2rwNRhKSe3YpaZovwHOAwtXM?=
 =?us-ascii?Q?rclMwVs3863Cy2m3vG5Hm7tMI1eEFWwCDBGvu7k3tf+rm5SR8LJVF+pG/2pb?=
 =?us-ascii?Q?qyK/WMlRUp7bBNDihYPjH7C3fW2lcS2dmyIOoxlygvvSobrMkyJi5en/opSg?=
 =?us-ascii?Q?cPoFGg8unwdkgziT02goBAp9OAJclyDOE/0Wv3zRA7kzNr9OHcAX5SY1rRio?=
 =?us-ascii?Q?rNOYx3j891sEZtKLjrP9/D9ItnlHUhlEvASC043P33MYLD+JUM4B2Aq3aHlz?=
 =?us-ascii?Q?4PARkvhA5sd8IV8Di6K/dS9fjTfGRZzwvOt26JRFf1WZhbZ2ScKGVVLfd1nD?=
 =?us-ascii?Q?XPPm2dKKuld650mHtTVFVrfrIh4PjZA0diJRiCWdwmkOhH/lTgjHOlzUiYW+?=
 =?us-ascii?Q?F57DZB+zDD9Km4PtBU6G82qMgVHS+9Dpd0IHBQDQIGMfQdda9lCRr/bJ6GO+?=
 =?us-ascii?Q?aSB0ugN1PPL2uBkD3PxWXvQkh/t8xLxWRMioWLbBGVC3xj/COh2XwhuKjd1L?=
 =?us-ascii?Q?SLyIy8+DHpvNvUSMpKGSuwBrMN2S5LPz/EhAHS5mJQ2L7Tajl7g+Ls3UxB/C?=
 =?us-ascii?Q?B6VKwOUsgSe3GrLThHpUw4MSUmaf+u6m5pnUNgO6m7qZr0mZlhJ1amRX1kcy?=
 =?us-ascii?Q?qk98UfXUc8wriYaPqF0S4rINSYlmweYNwdFGDxRHjHRMHHEGbOkDwPcqso+C?=
 =?us-ascii?Q?yIeormVGxwSCmZM5ObTEFDAqunDq6zpFbsmfB6nmGPVEkCWX5SyH89NNi3Qx?=
 =?us-ascii?Q?NwRbjRU+PuT2ZvgP7zdU7fs00fxXaC+fy3cbrv0Os4y9sHWEwBiBC1krT/Jd?=
 =?us-ascii?Q?Km2+E7nIV8aqOWpwzVo5Tf6rV1OlNReGuivQWTBGvuhr9ip5fOM6vP32adRp?=
 =?us-ascii?Q?EPtJU8vWflPLbIj+RfjBboBkdfCSaBDEZ1m1cTdEmYJgEpgO17QqnKnrM89y?=
 =?us-ascii?Q?GPa70g+F5R01eU3WM5KEu7DQVAX4l8trgIU4WYE+lXjE77a3f2/eitrTCu7o?=
 =?us-ascii?Q?xZ+TytpZWmqBwAWu2K0DlwegklRlCx4TkFDiR6VRImqvMSOdX1xiFQKAy2+v?=
 =?us-ascii?Q?uceeeopB8zUbpcxbp5PQjto2r4n9keAWjnbl8WBCSyfeOhTVPOCvswEnk4J9?=
 =?us-ascii?Q?C/phHw9pslAFhdOZ4FMmABBxfG5zKYgsd2bXmBCwtjcCG6fmRrXYJn/BJ+/T?=
 =?us-ascii?Q?HkXfHeK7FB185byoQZ7paLCbpYkPywu6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ggN2npV22hE2wiFDSIVANoxf6FFwmk2RAwjaXOsKhPfCigkEmiPSa+h7Kbo?=
 =?us-ascii?Q?c780GZuFZ2ZbTw6bdhNAhX+yIsgXoD1d7lMvDCMcqv+nYO/hDw0dmlPg6CMB?=
 =?us-ascii?Q?eBMw4L1vn8higHM5fnUjfhY9npZAPY28TV9UqHJCP+ptS8n8El+o0mHa1vBl?=
 =?us-ascii?Q?sP2AgVhs+M/eoa1GPt1U02dOXxiyEgTjojYpvKd2RvbERP05qrgZFJ1YSPE3?=
 =?us-ascii?Q?9rC2J8q9dUQg6B9Ymstdg3si5xbQOj8/GqJKs6HlVXIzNTcPLR9lSHhwksbf?=
 =?us-ascii?Q?Z50unJtdmuF5Gp4LLVjC88vuPSyT52ZhLPZYwxhlhqnMDLihx2vrbeObEevl?=
 =?us-ascii?Q?SfHyKr/zJbc2TPSiKpp3K87QEHbprIRCyC1G4SHdP1gi//SCaQgV12KQbQlG?=
 =?us-ascii?Q?x0JXOA3OXw1gbQuaVNQfavzzhhoycp6FD50kXphzOSDVa2sKTbTOwNHEBIdv?=
 =?us-ascii?Q?ugGxh/Q8QvQm0t73A4huqQF9hK9gpBL/LJ0ps/8mh7IQAp27P6yBlGkGFaw7?=
 =?us-ascii?Q?vBV7L3kwL44ieeEYCRxrDTCONzg30hd3GKHqpkhIohVgqTjPCLZfuuqWjWAz?=
 =?us-ascii?Q?EHtZsh4KNofDcKIO2oNuFoIaA5wNnH11LMu2ByA2RVoEyrnCI/mViH1yBfZQ?=
 =?us-ascii?Q?/xAQArdas+TqjClbtY+0XtRwnoJgw3MgisCiChhKMAZdv4+z0KiZLihijILf?=
 =?us-ascii?Q?tRorpt5nE/yko7QMg8UtfI+OoYTOthtTqflvXEIKdWnGxe00ucDwd77vAIFc?=
 =?us-ascii?Q?45PNLeBZTXSzfksSo+4OT5R3ChG1qDcN1J3jX3DYabIeYUYSRavHx4K8Gnst?=
 =?us-ascii?Q?dIimu+VS2qodZqJf0JoniWstLT+herUp0BCeJOC/Zs/KhSOcwYk1W7mu2eCC?=
 =?us-ascii?Q?AwZa1apz1EgVoYffpGlOFBWWfjJn/DscxwLKEDuvBzfqHauzVLXyHcGX1fBC?=
 =?us-ascii?Q?i84mDvEaCpLIz5KFM0O5GXErYTsDLyP5OLfTueg2eY+Zpln5QPfpNEbjqLyo?=
 =?us-ascii?Q?GLY5xZl6PS3qRpx6RHam/mMbZRQwt4OaGIuB661FgWRmhSHbAJBdOOWjO0Bo?=
 =?us-ascii?Q?XyFT6JPWnxZGY0r1NG+5du801WobT03mFBe8d2SFKcJztqO7X0etdZ/VFX+T?=
 =?us-ascii?Q?L68mR6xMAYtkFUjTvEqJyGDEfxUp4liztYBN3wv3YRGQtzhTFlqQLf3yRmyL?=
 =?us-ascii?Q?Jjo7GX8b07PfHa+tcukg5sb3SzE8lIxZoWr1Kajxkx5lJ8sCIKwMBtjcuvRa?=
 =?us-ascii?Q?lRpNdQRjSvhP1+971lHavh9h2scyHClUjH4KE3G2Vxxpl2s+KEQcVoDpNrmU?=
 =?us-ascii?Q?gd9Hzl9HPNJK46fs1OaNJfmmiAFHaKPVUgcjXrqSJMK3WPpIq+H+KuxtLRSu?=
 =?us-ascii?Q?n8Z69I9SrIIDVx/PIS4nXGkHBGgawYmqFeY6HhRYL1rVKLPo829jqZRKwO5v?=
 =?us-ascii?Q?EPnJ2y8gLlcmpENJ9fsO5TWJsKDZ/+YwJM69+rcsvcM8u/Hx9QeinQqbDekL?=
 =?us-ascii?Q?+aauGLief8XJAqjEPD8ha7Xx6rIPsZjJJrGxP8a4hrJ3Ot07ngTCB1A3WKCm?=
 =?us-ascii?Q?BKWukPD0UqSIQPqD+GpsRN6sp4TpGvkrRBlFctKZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88880318-8ffd-44c8-96d9-08dd5cd1e0c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:11:04.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZnIWzMHXCF95k+zBs0NrK2qh7taCPlgB/qokalzIvh6ZVHVocB0jSZ/YmjtXbGwi+zIUrn5g/kUdgSJcihhfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7306

Add compatible string "fsl,imx94-lpuart" for the i.MX94 chip, which is
backward compatible with i.MX8ULP. Set it to fall back to
"fsl,imx8ulp-lpuart".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 3f9ace89dee90..c42261b5a80a8 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -30,6 +30,7 @@ properties:
       - items:
           - enum:
               - fsl,imx93-lpuart
+              - fsl,imx94-lpuart
               - fsl,imx95-lpuart
           - const: fsl,imx8ulp-lpuart
           - const: fsl,imx7ulp-lpuart
-- 
2.34.1

