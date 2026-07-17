Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020080.outbound.protection.outlook.com [52.101.46.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629B33F5A9;
	Fri, 17 Jul 2026 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260293; cv=fail; b=dMVUjpBPIj4LKpMvxq+fXVtbK0l3FGxXRjMcZcY11CsIe10ff7QCRp8DWCDSl7Qs7Rh7l0Yqbvl/lDp1banOKLr79yfyAU7I1pEdl4ji4m9+9TQyJ/ZUDyfSgV0ClRlaF0hxXSYUBB2PotsqIftonalgVcha1EweLD28NXSkFuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260293; c=relaxed/simple;
	bh=CQh2z2uNqnXzk5ByqPrD1md+pHnsCGo/NsON1EVbwHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uh1OoCQgCzpgfcY5d1ItP+f/Jg5HcfLCt8IUy0hWyEGvLHqfrLU6zCFDqOh1KIzW8Off0enyFQKevnYtAI1372SECjjuaY0NAdExMHODeKwG+6FBzwxNHwLzS6LiV2XXw7ba2TiuMxg3qUszdQHtden98sUQarUPiRM2mIyw7Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=WVVtfatT; arc=fail smtp.client-ip=52.101.46.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="WVVtfatT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAjKZjabCfQKxz8onUHDLNVBqu+pMgDMjXuQT0Y5t8yHe7AkW9Z0iADV0Y3/yHQBQ3dSq2/bav0YAK5kJ4zgyRm+TD/hyyYrd47b4NdK1Aymdib721QEwirvsSujutsyxRpB8HAUYgMMVOFPZv/qJ81F9I2fssIrmh88JdTCByZeNyEMVS5XhfxpDk9LhqfK83a/1Sq7dPqklTiwsE98FJRRo6jtY8Od5sUM1J7UPDODZYvk+Gsc98fYoCk32OUrtMDB9iVmArAssepkCsgEaqV7YP6H4i4WBeD4v5L7hn3XXiiHtTg4IpGh5AA25v/TrfiKBL+L1ngzfP1VomgrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdA+b8Si9um/Amzm2X55qXer/EowQsn39kDbVPtOek0=;
 b=OjeMCnHrWN2lOSeTLxXlQiszt3RMUuYls7uzCG7/KH665/k4T8vmF5AFEjx9mAPl/Bj+xoRJSrBD11A4SQ9oXSQG6ZySNKr9Dj4noG6zqEW8RSP/i/YsbidsLLL38stJkaIuwwS256iUjBiNY6+MQdmK7sI/x0SLGLOm0DrfHn1t7NS7hZy0maZ8JMmyqfP3D3dcE/37ot5+S8SvOtPouZUudCEf2yaw+DbEbZfW9MDYC8JDAsRgnm4SzqLKiipzS9Q0yAZgCi7nnN9p6oDkcDHPi43z4Z3osp0+PKLy8W1y9K+aQ6WGUKlnRsCbtbhvOpiPaMr5G9dGtWPnBVGC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdA+b8Si9um/Amzm2X55qXer/EowQsn39kDbVPtOek0=;
 b=WVVtfatTB636gDF6ZHnl6aRu95p0mqVU+FTFc0pMQHEtOXY3XQpE/eu0F4uQ0hARZxtVb4tcYStBeQ+skALTbRZ4FZuKqzWp7haNMdbZdpAiluuikiq5QEfnmIELYqtMmKAiCLclYIUPd8EkKdZg5J48ivBdc9pbQCylzKCG8jWJuF14JJCFMzzinbvkKZL2jMIWvDIOgUzSryHe4L9UTP6vuufW4JZqISPpQHGfwiZqB88DBBHulXET1pABHlDiUigI3dmVsl5rxxXZPUD0MVukZFHmL5J1boG34GQShSGutoHPNq3tfL9qc6RrWIETMl6vu2XISMCmu6Uc/WGaig==
Received: from BL1PR13CA0341.namprd13.prod.outlook.com (2603:10b6:208:2c6::16)
 by CH0PR18MB4258.namprd18.prod.outlook.com (2603:10b6:610:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 03:51:28 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::82) by BL1PR13CA0341.outlook.office365.com
 (2603:10b6:208:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Fri, 17
 Jul 2026 03:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:26 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 3DC734186B5A;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:10 -0700
Subject: [PATCH v3 3/8] dt-bindings: i2c: cdns: add Axiado AX3005 I2C
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-3-c429095143ec@axiado.com>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=syang@axiado.com;
 h=from:subject:message-id; bh=CQh2z2uNqnXzk5ByqPrD1md+pHnsCGo/NsON1EVbwHI=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXv6Kw5/Z12vyHH84976WxP3O2hmbU3e3F0yS8nh0
 rsripKTO0pZGMQ4GGTFFFm+6nzLP5mrfa9z78pSmDmsTCBDGLg4BWAik+0Y/seqNr3bcmHl1JT7
 ClINu8+8mPjRXe6e7m3eDR87v/Kb80sy/BU4tSpNl/FF0pP4Hz82sbg6C989NOHV+0WneH+cMee
 dGcAFAA==
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CH0PR18MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 11482943-5ec8-4067-2064-08dee3b6adb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|36860700016|82310400026|1800799024|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XOafQ4ajy9qGuh0zgMq+z2IXvDZAG7Exs8Q+tyZrKZDeSTlW5WOG8v3Unt0pvcXAkk/Btw264fx9lk0PgU4ATmj9t+1rk1P9wflbdnf6KNch+i412WZGMSeFgnYQ3LlUtqZ+at9SwKmwir0GWhxDel47fkiVzt52ExpAjKYbDULEH82TlIPxyylbSvLQeE5duWJ/ETrgVl0sT9MrDX5jqqj6YcZhCXhNa1dSmjzjaJYKbB/kkbRDeKFWF0ngNQT1vjnfKsweOT9p6OS3ae+hgcXdS7W4b1SOl4oCd9Odx9U6yQblYRCvm7L93rxcWub6yjdGJS/GCPS5jIi7005oKn9Kk5x5J8nRpXPn9SNxR4WI8u9C9MfUZA66MIzH6lUxPZ4M7x5VY+sNFVRIRyn8auXdPUBhMcA8SEbPOcq/DzoJ7cWrak4sEs90M1DOfpvcL9HO0XD57PjKsUWuJyrWO8cxB4svS27QN6nPf/EXORxLqd0RKeErrRWoQT+8MwBbUyHmgAHF2/XpFF/nTKPo+OW8EdJ4Sa81/0r8E8EAzYDxQrPva9R4Cgcy4uyCU1aCYGlL253Fxyg/skkH8RR2weyg8QJ7vaxvij6mgG2RmW8uf9JC54M/mZC5QM7wQGcQJ7GPd9Auov5uQ3+XHtvUbXweeKjX26Wn1EPYHfZrWleI8YHN8JYcCa00Enf5CFvDUrN+PTUYcuwrH8VIdAexA+NVqyQmTvZwZQdqcIw5ixI+aWXkTqTp9yAMCEUPXBOe
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(921020)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TIovB7T/e/Ad61CjInigwWvEmCr1tpYsvTzI8r/rgPZyQF4B92lpzTz0qqC3esF0LNsmTzmSS5YvLp6UQN2lvbgWuXql4qjqrINANLme7M7mloER9oBGA1vRzcAihN+2/bEOcQRPxrmIYJU+FW2fL/cTjGPmLOlPYdIzQk9cssPETLKJC5y1qKPsrydLfIyRi9nubOoRERifGT29/56jrMl5fDftm/gReIDvXp4w38PsXsepnoNm3++XslW0pHzxhSrkSk1zLGQPcw2jDmU+w0sHr/q1tDroOYP5XgUBFN99yxbAh70HWzjTdOCCoqr+4Vk03M9GNNaB6UiiK3QM0RoVjVOBqw6xCZw94YFoKj5XZL8FcaRGxSiYc7zs2C8qGFk1DKwFAQu2qkX5u9dx6GDzteEdTEWKZ4yzjZ4CHs2BFR+mBOAcVjLq8+RNGGNy
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:26.9371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11482943-5ec8-4067-2064-08dee3b6adb5
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4258

Add binding for Axiado AX3005 I2C controller. So far, no changes
are known, so it can fall back to the cdns,i2c-r1p14 compatible.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
index 9f1d35ce1fe8..4dc69d54f75d 100644
--- a/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
+++ b/Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
@@ -14,9 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - cdns,i2c-r1p10 # cadence i2c controller version 1.0
-      - cdns,i2c-r1p14 # cadence i2c controller version 1.4
+    oneOf:
+      - enum:
+          - cdns,i2c-r1p10 # cadence i2c controller version 1.0
+          - cdns,i2c-r1p14 # cadence i2c controller version 1.4
+      - items:
+          - const: axiado,ax3005-i2c
+          - const: cdns,i2c-r1p14
 
   reg:
     maxItems: 1

-- 
2.34.1

