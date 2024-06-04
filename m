Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961911411F9;
	Tue,  4 Jun 2024 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490876; cv=fail; b=SFkpyfJNW+dWXUF8J+qMq/i0DhUSZjb9UQhiaCiRtrZ0MgPHgoUEhQJFAn27z/3Bxkf6T4aW/tTsv5fAgCzmNzk10C/rrdpdyJ8F6jdu3bh4ko9DR+sNH5SOxYV7w/1of5T4RrtnDNuhe8T6zKY21VebxBzN6kB/5oROZwGKaXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490876; c=relaxed/simple;
	bh=fM6BV0WArCc+osOUSYvbS28LUOfczMafGt1nEFntIJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkAD7KzmYUTmFYGV5y2GD2fxxtcR/mUy7pOc5HM3jsmfJt5i5WjRCp7NAQERSHUNq6sqdo8Pa/tOK2xB0sYshKywyOoTrLWfXAVaM+ivaJi58jXG1ge8us3maQVYe+LMk5kDnDuuDafydLfVr2aGuhaYpW9J4biCVXqHGd/QCvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdS21vbxGCfO+8ZQ7jE2w9tkLbLOYBBkzntingv1VUjpxlQq76PUEg74QWtQz54riZD0SJRmVNvL9204pjcDTJrMzxRqyM4Ssf2JGT4Dt3n3RheOvLt+JcIr5P8OUqniZMkGIEAijLCUwBQgtsOeoaOfMTD/Ojk42nImLthLWLZZ+CHNOZBBfw0/lnWr2QodoyCXyQTiz7AsHVX0K57mKzMhX+7cX29lsyZix3LfL+fibBZNhIlY7UH+3Wjf++kfN2x/q91ysv26KQLXFCP8CnXTErrtmlNAg7KmjhdAVuR1UjHsB2hcdVtING0TaKpc19EHKxsN0lInQXJ2AVfLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5ZtSD0XZ7E7OT7Fkx++/LR+5p51ryVZk7LhVjMw2XM=;
 b=n9itA2WTZbAJJ199c3U4NRLbgZk8aqlNWZB7liLmMQlNf5wTAxiG2w5HuucLPZyT0Bkc9YLDKMZp7+uPFdCNN0BPgjsUhFELr0xcPz4GHx0aN80r2pH1XlQJ8bv7pIP1zk5ewHCdLxcPTPC4zXvIwN5Nf0rzJ/s5J8or0ibnKzEfoq2iSKpjro1DidHLc3Qt0Nl02ETA20qD3HUydMvrWU2rRN3WeAm0qggjs22V8PL3kkQtEHfVE1XNvb3AcfRwl7ftzPDwjO0XGCrBNFJ+hXSe3QqD9qS1HcxuvYfjxBelIpkWKTMRBLtwnZWlUOkYR0x2sCX71cJBG9CJv6oaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Tue, 4 Jun
 2024 08:47:38 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Tue, 4 Jun 2024 08:47:38 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one more reset signal for StarFive JH7110 SoC
Date: Tue,  4 Jun 2024 16:47:27 +0800
Message-ID: <20240604084729.57239-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240604084729.57239-1-hal.feng@starfivetech.com>
References: <20240604084729.57239-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a4075c-d3ab-4666-ead3-08dc8472fcc6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|41320700004|366007|1800799015|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	gKFYE3szBuMQ6IDWvE53WTvKoI7ET262NE9nFrh8brxg1xBpT5xA/FHcNtMOL5v+PQsD0YrlZP5hwQJTgkFnq3Hx3V/PMZDutK3mHLt9tTC3rxptizOKIVwxBbR2JPUxEZohhRU+N0a0oirmNPCC3PL1jVehZiNoEAd5uGbbBuee1W3OZhnwcrwYUoMrjOtawo7Vl/1REyNFXNPCMOCY9P9Hg1ZMAts4k+Fs9M2cIJWGJTkwokqeBWjxxweG6bLwC0ETfU9oD5AArXOlr54UZtshW/nr2CD+hx1pkW69/JxZha12zF72Zm4HU8tczCH2uI40o27f3FV2XneaKCigtOZa9coS1liCP7Fr4HJue07boT+Rci8dKWFTdraPdafKiYlCIu0VslAUNZU49CCoRbSzip/9XaOdYfwbIWKKzhz3156KVRzvvGh56hGFEvpswIK3WB+DejDWYFNwMg+8pQxr57i4ss13sKRiDqq26Tq+a94of09K1qTKt9oTb4lvQhZx450M4u605OgrH5+TMRYA4zgP4CsuYm6o7AlTzP3/3hjmP8F7os6eRdbL6V04cyubVldgcsfczt0h9nBRQcHLip7o3cx4I4gTHUVvJrX+pbRLebIMZTqmxaKQpvMlMrX5jfb7mV3fH2weegdjlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(366007)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vk+89XakTVVrRV49Asus6LGL9pQCdQ7dlawOXqwCJeG2WOg6OrvGXj1i7c/+?=
 =?us-ascii?Q?cssyBAR+kueCLNjdaxu36mIgAXD7pOhkd4bc04yCpAWIO4+HpVefHN2Zzo8+?=
 =?us-ascii?Q?1auDO1W5VzF+vlgXrldakYKBeNXxhf16la3WJgSipyS+s7pLeGDnxX0Bbk+f?=
 =?us-ascii?Q?aWpsFS39OkDJSw0QFTA22ylcCWMR79OUX+WjTBhWKO1okYE2cwaS8mSDULB7?=
 =?us-ascii?Q?emozOIc3o5LuiZuOna0ZfqfATz/5vwoFDySdP4KaCNQH8wg3xE4dZToktSwS?=
 =?us-ascii?Q?Cg4vm4cMh2BQ1pIyUtvAhepkJ4wDKflHNM4QexuOiHhEoK8TBvlDFMWuwwWQ?=
 =?us-ascii?Q?EEDshyT/W9kUcDRVgT+pt4+SomhSTO+6zu16RXlIU8Ar2ygk28Rre3BJof6j?=
 =?us-ascii?Q?byYugg4QO4QP021H6ZmySQ3bMT+uuAL0O0OQy4dMWTdmo1Kb7EpKgoGzanfN?=
 =?us-ascii?Q?HWMpJNyns4XmDglIUBw0IXJ0jCcrjabK2ZLQSjFb8rtLzudOSTgSDqa6suig?=
 =?us-ascii?Q?8aHxMWhnDCENustAOuayj+LyrB/eR+e4x5iw5yPXvPIQdNEj4dd71DKPyd57?=
 =?us-ascii?Q?yHwkz1L8X1sYyAkipMtyvEgpbS1KfrVJk05EHKeiq88ofTSXShrBZ5WQ3o4k?=
 =?us-ascii?Q?msSTjE6AcUEHDAk2CotjqnVMC+r3cc4vQBBAWQ6pBe1oUYsnaI8Sc8gq2yMg?=
 =?us-ascii?Q?HaXHGSFC2dYE4r8XeoyrPDCg95vU6lE9HRtDAmJEnMBD8xBMfW7+KabOWKWG?=
 =?us-ascii?Q?OsvpczhOeLBmhll0i/umoaEinX66EAk9Li2fONVzMAqt2WCbgHbKwCx2T1NG?=
 =?us-ascii?Q?USLUsU2b4wsZuVtAkERb9R5kFllSX5SrQfQZRwtfTJbSY8OvNbfmjCpgulU8?=
 =?us-ascii?Q?9rjQUTVSwsq4mVcdtUCVGtjdSCb0BeLuolzDuQ5vmryEfAKDd9fdb5+sWhKD?=
 =?us-ascii?Q?wA+6zED4M1kM0FAGPcQEXPOcS2k/V4s85Z6mnsffe/+hBFB3IzNPbpz6/Mw4?=
 =?us-ascii?Q?Fp4RsRk0hRRJPfPkSmCpXlrdjLv9bBxBTVIi5P9d4tx7hgPFwkRrpkef6bto?=
 =?us-ascii?Q?ma71OydFasowuj4RqkfxuAJ46TJFsJn12b+tZotiVuyKXZAGjDP71+R3nGSv?=
 =?us-ascii?Q?sFzQoQ52IRU7jnX32DREjzojRhKDCANn5n+OgaBsVm98SumncZMGpMMslERU?=
 =?us-ascii?Q?ORvycHU/CKRxdzp7ztFMxE+cqpYItbjCqQ03MeLf2xSda0kX1EdwVeykKgh5?=
 =?us-ascii?Q?qfehsI2SzT1F8nr5ZEloWQsMK00lrKJxw7FMyf8obJVU10ZLUfSwvPlOh528?=
 =?us-ascii?Q?m8xA/11/jW/aNK8gZiaFqnAEUgpuYakuXMTvk3CowcCdmGML1KQHiKPC3x7e?=
 =?us-ascii?Q?uWEWkM9fc/+frmHe3bJOhpsCNx47QKRs7zAiOAaJU4RA7vnp8BHmTVKSvb0f?=
 =?us-ascii?Q?UbheiCkxSBT9fnuiIi2qxt/ZKK8w6VZENYhAEkT48IcSwWCOBwij6favmLc8?=
 =?us-ascii?Q?boAhfs4SAllmO9G25RpRiZIjZ/jDE3vOLCaCJ8uDqQ1OG7EY/iTo6vfEfpKH?=
 =?us-ascii?Q?mN1+MVJPBeclm9vTh4e/Of/I1VNGUgrI818x73RXLq+b+xdVG/jdTUIvntoo?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a4075c-d3ab-4666-ead3-08dc8472fcc6
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:47:38.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpIKJmUIKC1SmMEQJzl/redXBg9JP3qz89LDnkwNJOLRLfkWWn9IuwxgXTcOrTzBX8Cbq+pUv77IfdBxsS9ZVeV0El2sYvIUiYMl/9cTipg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324

The UART of StarFive JH7110 has two reset signals.
Both of them are necessary for JH7110 to initialize UART.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/serial/snps-dw-apb-uart.yaml      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 1001d2a6ace8..4cdb0dcaccf3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -13,6 +13,20 @@ allOf:
   - $ref: serial.yaml#
   - $ref: rs485.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-uart
+    then:
+      properties:
+        resets:
+          minItems: 2
+    else:
+      properties:
+        resets:
+          maxItems: 1
+
 properties:
   compatible:
     oneOf:
@@ -48,6 +62,7 @@ properties:
           - enum:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
+              - starfive,jh7110-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 
@@ -82,7 +97,8 @@ properties:
     type: boolean
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reg-shift: true
 
-- 
2.43.2

