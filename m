Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021105.outbound.protection.outlook.com [40.93.194.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D71935E948;
	Fri, 17 Jul 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260305; cv=fail; b=tp3QIgqwnaFxXv61Us0ZeO1bkG7opr6LnmL1J39LCKhx2HdNvUGuH5MDZOx/CYPea73ynvc+kPc811SvIy7sfhvo0C8v9BucMtncreNdZaMWA6aux1u3xzq20F9NXtQ9aiuts8F8/TNPc1k9DmXZ7uZ9hail/y3vdeHbFQbay/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260305; c=relaxed/simple;
	bh=IUrtZ0zaROvnpfrpIxrdUlL26Fn8F3u8Tv3fpbn/c3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P57Xyb0ApNSkH/+M8qeAarRYU6/mgpGwiV7rkDOd+kkc0clcYoS4Qokrj7b3BUShqXyVLc1U15CSk4eTaK5j+SN/4ZYZ6GueSrLMl6bfbYMr5UvHIrSqJ0sdyDA93b66zEy0zQ0QhyIoHC5X9tBbuL/pAqSB7ye76Hw6yrOQWGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=hAv26w9m; arc=fail smtp.client-ip=40.93.194.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="hAv26w9m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjVJS5zyet45WHt+ckl0HFL3cuBxXRNpYcgMNwBHw5B46fDF5qPuCCG/lnfs8Us7SaTwRCA0KtDMUNZ/JVPw3CK+r9zlq+jO6bzGy3BVFBvasgPtUGjJQX4eug9sEvykXB+499mfAh6iPo1gJQ9l+rvfw5xt34pgB4xNqZVsnXSFQT6vqrafVDtk8THxx2S7uoEy4wA/ZclvapL9BBlejodz/i7Lnby722ZvGV0uhYYC148r98/m+Uria6pFNlzM4/kLSnKcEG2nHB6i9SCT9/59F1wXYJv0423+oXpoI2F/0UKTO9LD72NGMKsVMayfMkG4T0pL9FgrDPsYOhaJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQDX25T1cxeBrsY8qEjC2Nji5qMSjfvjVQYT5/xqU00=;
 b=gw+kPoXP6Uo1T3KZjhj2QwVLS/mpBvREAq+styz+PBwBcRGN7EnFbPArya/KbdnIUazCPoFoYoGf/JveX98yOhxane2fSzIH6XDPxRxqUlm4STzeWir4BnYTUaRHmma9fXvPUXEFm5OgXARLafCocMmbmddqhxWU8a8BRXSh4PQ5SzMUziZeVfzKOfQZC6RE/kbjtadF+UyUmpSzE9MXJ4DdXbgbP8v6Rr20gYfKdwg+K/G8bprtkIIcFtzigZnIlRKR/2KeQHFTbIO0TqRqYCSpSmGng7HK0gQGU9KfbrbKIx91C2OrDhOPQhdx8qUkJdazWjZtZScIY1fQ6T/H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQDX25T1cxeBrsY8qEjC2Nji5qMSjfvjVQYT5/xqU00=;
 b=hAv26w9msYa7trIUryhDvyZxWqsZmb0JSOPH0IzglRwgOW1EjSn2ibXxYh3p5O3f0+LXy/+dEd/a18k+vHzJfYjOaL8rsmaff5mRH65qEFr5XHZ45vTkjqRCDIbC2xMy9Y785vk5b6TzcsP2Vg2CWwooDsDNplp3d9iQIikTsJZHI0jOWlh2e3031aAmcOqq8z8LxJXRr2FG2dWbtnjMnUGpjU+BrLOHU9d8oJUOjw5ivn9tx8d+72cLv8qfqCuyILSRkWJ5IEBu579FT242i3Y/df1FevwjzWOHFW3WZW/C1CEMm48SdAv0A1tXZIWTSVTIsUGoWrkoBpTQoTonaA==
Received: from BN0PR02CA0039.namprd02.prod.outlook.com (2603:10b6:408:e5::14)
 by DM3PPF4976F8545.namprd18.prod.outlook.com (2603:10b6:f:fc00::6a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:28 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::a7) by BN0PR02CA0039.outlook.office365.com
 (2603:10b6:408:e5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 03:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:28 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 4820540BFE10;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:13 -0700
Subject: [PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi: add Axiado AX3005 SPI
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=syang@axiado.com;
 h=from:subject:message-id; bh=IUrtZ0zaROvnpfrpIxrdUlL26Fn8F3u8Tv3fpbn/c3Q=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXsdvHWyOc9n1Py/E8MaKhF6aL6I0LvP1pxhrtmT9
 9YyrZDrKGVhEONgkBVTZPmq8y3/ZK72vc69K0th5rAygQxh4OIUgIlsKWH4n8kTasGyR+d9cyvj
 08UT789onOPkZr5MNE7ztvq384HXLBkZljw9qLWIoUM9JZ331E/BzpIkbxsNwVVsrgs+mgYV/zz
 BBwA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM3PPF4976F8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4797904a-9e2b-406d-d358-08dee3b6ae6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|921020|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cBpi2gLmNWexQZrz1kjDfD+hKnL58+I/6qo71N0FcoqO4GRhyOBVEIE2CasL8kjgtK5UPlY9FzE65kcBJ6j/r49T18YTy2wZW7tk1vJUnhGA7rcOCbBkxoip//UEujJEom2Pg56H/N48zRoUiir4/xhV+Ln7Z8XfZ2V+LK+eYasRwrLmlKeK9qv/xXfPR3QExWTaDVTqTj5hTKQHkR+EnmAm4JwHTp3QWtshfBZJKneVeNz5fmeUFoxpPvFHCQfHyFe4BOedO/UGyefB11KKcNgu3EwJqdF/y7152PaL9xwLZN5TJyfAsVE600ZRmoNbrtnwP6CMIQ+odZbu5tERMaNBAKeDh5l0/1J9Yca9ERXa8bUq7Lek6ILsWtkuoWh0FvviVx4s8R7wzxIZbG/fmebdwNcvvWNSP65iruPO5O5Xhnoq3xJ5/FiPWpdi+NgG5+m669JD2A7aW7MG/v4h9w4U9u0Gi986QyHoKnBlbDQWnmpVCH6TtW0hiNY33tseHvMMfxgPJUnXYjAVPYIXKyrmOsyOmRoFOOGY9BjUJkiNuFobQ6JXf5y2LOAO6MlJqLngifYyN2ECIxqMKrslh02RvyjU++RaSP8TTWHuMD+Ok4Lj+D4suJJP8lHINxNnKRN5rs3asfnAV+AeZb3ekwi9ejFgZns6a/1XVyPMX1jcbYF+ivVZp8Ngo9TcEh93nYvE7anUJ/Iv9LUy1yYvOzR/B8jMXrSryra0WJl0cz1tNWjtzGfqOsUixICAtiGb
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(921020)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	McgCojHoHqYeksUiDR3ZH6gd8JSoW88y9o1++4QscyhCA1wHGl/qplrxmzpDnK+859nMJMjIKgiB0+bnRvtmVdRPSGs612WpCxZzVTo6zrU3WhvOJK2ITGbTSBISDzVc7fuOER8nJeHBsbcTsVlFONjq5IO5TnBouon0OZ89VW4jn3MKrF31HsfoVd/Hq1Imn2JMZ7KWoH7UFMk0xmrgdPE6wS7Gun+pDd3uZ0fEp5NcaBQ30xguqG2VelOl9RrFuQ1blJUffsaaC0aqYSpbxZXL0YDoK5tR2e6b97vLsfIUGIwacEsBs84CgboJ2YrfRUhSeT2n6gTXQb3SZ6xVX8oHIdvRh34ztxz7f0xQnIypPcMJSn7FPLl/ih4UcAir2u7e4+69dzPsGbybKDJC5QL53wafzGqEaV9nKAclMJ0uLH61hym16W7pD1xoN61t
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:28.1229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4797904a-9e2b-406d-d358-08dee3b6ae6a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4976F8545

Add binding for Axiado AX3005 SPI controller. So far, no changes
are known, so it can fall back to the snps,dwc-ssi-1.01a compatible.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 8ebebcebca16..7b16053d2244 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -41,6 +41,10 @@ properties:
         enum:
           - snps,dw-apb-ssi
           - snps,dwc-ssi-1.01a
+      - description: Axiado AX3005 SPI Controller
+        items:
+          - const: axiado,ax3005-spi
+          - const: snps,dwc-ssi-1.01a
       - description: Microchip Sparx5 SoC SPI Controller
         const: microchip,sparx5-spi
       - description: Amazon Alpine SPI Controller

-- 
2.34.1

