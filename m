Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021124.outbound.protection.outlook.com [52.101.52.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CA277C9E;
	Fri, 17 Jul 2026 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260292; cv=fail; b=rNVIfZp4lHOf7SkZ6VFUqwO67/KggKWnkyapcQZtP2ARuPPmimnVsso2E5RqAHgkKqwe0LZZfKWnYXWxYUbnZ2LBY/5XbcAabWKw3fHdEj2aZ3GSq8vlN/5sGT75xeu4N3+fXkNJVGYwoPn2idGJ9ZA9M97xW7cu2av0pALJFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260292; c=relaxed/simple;
	bh=lRd5fEURFEd7L6FVtJkfNOmGCkYyQJoZtmef8h3/52s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyydvFrxPx9BVXUJSTsOT1cqRq6ZvH2w9eq3uBSSJhMarUy60m1EpXClF3Z+JqBXXlo5DuZSxM+aXwMsYHMF4KD97Vt+tUm8WwR7PasFn/2X6hdy0XIZyCwrX9xlOv9RWyHvc8pgsG7TGJikICaSnEb8SSxSMg6iXATKWLpkHJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ucv9OBm2; arc=fail smtp.client-ip=52.101.52.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ucv9OBm2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE3+uwE9fxcidfQOSlxAj5dyFLIV0LlsllOK0gT73c8ilRkgopeY3YihIh7VqFERuKZzM2SmmZW/A4SwSBQ95I12S/c33TSobYPdKPnqwpFZJVS7GmXcX9l6cljD+866b4MWPu8rHkQ2eO50uu96+D3zB8WySxG9PnlG71tj5bOxOv6IPnx+AIhshiwLaUjrAo3teUOUuCqXPaxBwEwqt9V5hxb0k5v90C045LHjWJciWP3QR4He/LnyRWQ/MJkECTNb9JQCoHa2OAge0QvYJe22lap/f1PJ6GsFdZaH6CFgxVn5en+r0o2Xu/hTg30ydms72kp6LWvJ0y+HWa7oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ywj/R598DHvTK5R2nBVRB/G7elq9O/Ae5ypwi9az0Q=;
 b=LZ9++RgBH58QWBj2TrICFZ2EMA0JW2yRwh5IaVmaHZ9LiU8DLjt9CT2V6/bTpIaBgJ5u3FfcfTz8JI8S9LE32/UHkwMBnOiNRzJjoQXEBYqsq06yL6XU5N2DEB9adnnNNDx06UC2ic9zMcns704d7vpsBAnw/k5fN6QWfFdoDU7ExesyWqR+PbV80pitiS2dbX7s6e9q7R7J2eefm55R+Mj/QO6JasdoEm2t642aY9JOUTw7OKabJHdvfPFep03WEW8kBKhMq7jACq6qHNPkvIn8os6XGqTgjCoVGp1W2ATZyqozzTSwWQ2kn3NIGjUhq4BR8i607wejo+gnrCELvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ywj/R598DHvTK5R2nBVRB/G7elq9O/Ae5ypwi9az0Q=;
 b=ucv9OBm2b8DLu+X2K4+LVze6NfGiUviC3XQSj/2B7goHEkQ78yVGbxOhFuWZT9YKM9AFbVUi4mwW1kvLT/U2S4/DSB2TdoQVqoEmh++tPEkwM5ORtJGbkovmrNAfCwMYGLkNvMQkY9JpOT+6DPdigjpTYwqMiNLbDm4fODKacVFVnvjx16boLa1eX+C+oxFuWxBW5dF9PWCX9QZwn3MBDS2vwwLBoNM4y/RulBxcFam7Uga1UNki55NsxDSLsnx9M5vKIQvCJne6/Adl7arJ8WZOQlY0rvj7H7M5tskIZ0POLvE6LQg/6Y/gc5e6S4NYwjExRcjvbaAXGziEEqN5OA==
Received: from IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::12)
 by IA5PR18MB988632.namprd18.prod.outlook.com (2603:10b6:208:607::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:27 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::22) by IA4P220CA0003.outlook.office365.com
 (2603:10b6:208:558::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 03:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:26 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 365AE4186B53;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:08 -0700
Subject: [PATCH v3 1/8] dt-bindings: arm: axiado: add AX3005 EVK
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-1-c429095143ec@axiado.com>
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
 linux-usb@vger.kernel.org, Swark Yang <syang@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=syang@axiado.com;
 h=from:subject:message-id; bh=lRd5fEURFEd7L6FVtJkfNOmGCkYyQJoZtmef8h3/52s=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXum16rf+c65p3sP28Z3h5rZ3oV7c0XN2z6/d94S7
 QOs27RmdZSyMIhxMMiKKbJ81fmWfzJX+17n3pWlMHNYmUCGMHBxCsBE1hUwMqzPt1OP9PSZZ8Zy
 xH5v97aj/HMTHweedjU3irk//8u53rmMDIfmdvH0J+XulD3oePtJ7sqMrvatVoIea86v19N/u/2
 5BisA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|IA5PR18MB988632:EE_
X-MS-Office365-Filtering-Correlation-Id: 6512681c-b003-434b-f58a-08dee3b6ada9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|3023799007|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JodlnM7YRwBR+OcwmEWuCyroxszfRaCe0qfj0IYMhgJRlBE8sHYebDwENpIWUH0upNfIE6nMZjJhSwUbc5fpXFkpBXo0wPsNqprynbXpBtKwdbGzbUqQTU/XM6vWst3blbeEukb6dR+bK51+ETVHXZrSNmxHZyiEOpvh8IhC8K2nwKevRgM8Ib2odxDrpUpm8LIpzw3/vjpC4+ooHfc4CLdHpfEV7Tg4+BRA0DPXPlNhYjAqjq61oLFV9AvQLEKyybejSaqi8xufCSuy+G1zO77V47NwS9k62yMhIsuWanl9QzE8cxkg9YFQ+Z6NMT5gjPC8jqYcWy1N20TOYpxb/MzwIqh4IkvqlTu2pI6nv4N62MWGZUq/vl1g91CZdLgMxX0nzXJOxkjoSljS3DvtqHzv3BJGKgSyVNzj325syQIRTvWVA/9GqWLIPlUSGMkOQlEgoMFCHPWBFjfTosLXS+gOmlpHj4d1qfHnzZwXb1bUB5aRJy/vHXqwG17mhyCnx262JsM+SnDOWtSJvgguPjt9Vy4SpiiuzOdUZxxedfQDt777+3khMDHGVR76xOrWr4irJGvWOaeV1QQONIjt7+ROBm5ws3ezTOGZ5W9iPlCxeeY0giLIEwyxI06NMJ7/NO81+iPAWXd+VHgl+FOTtriqlFw1XULpd1qUpw4SNxZHId9RnGiEvzHfnGvL+A0KRavjSfhjy2MVTYGWZJqpA6pO5peR/pFO+PCfPGyI7xwB6q+w/10CDajDURVEgCnl
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(3023799007)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oEVgZjNBsbdm1gT8K1nhaV/Bn71iNDeBNHhjaZal1h13WzEqbnQ7QXGpYE+jSIvBPIEU+q683zcSsYTjyXMGpwaR1+qZfUasTau17Uq3Itc7s00P2i/xmd2QQearzda4k0wwgpPguIcNsmJnKD99eO9GVFjHJfCxpDViQtkfbKqt1FEJYVGYADdRAM+o3/Z9ge4woBlx33m1Codn560COEVit2MWQEiuVD2+TlbcBrydi6pHk+Qb87nwdP+71L1rsrwIAtTU2xFembq76AqLNAoYvfXLM7Q1++hErNkY7eVkgld9pHk+Qu/0eYvk06cd+mnv22vD69EGwva9VxnT7RlIlildfRj2fqhc2sA9sge8BdXHO8cw5IUXGals8WVQFe4FUBdFli2rQlH7WRGWZjEBlBqUxblQJbIQ6a/kL+tHmiDydA8NrLqcLewNaXKm
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:26.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512681c-b003-434b-f58a-08dee3b6ada9
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR18MB988632

Add device tree binding schema for the Axiado AX3005 SoC and its
associated evaluation board. This binding will be used for the
board-level DTS files that support the AX3005 platforms.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/arm/axiado.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/axiado.yaml b/Documentation/devicetree/bindings/arm/axiado.yaml
index bfabe7b32e65..008d2b1d4e62 100644
--- a/Documentation/devicetree/bindings/arm/axiado.yaml
+++ b/Documentation/devicetree/bindings/arm/axiado.yaml
@@ -20,4 +20,10 @@ properties:
               - axiado,ax3000-evk       # Axiado AX3000 Evaluation Board
           - const: axiado,ax3000       # Axiado AX3000 SoC
 
+      - description: AX3005 based boards
+        items:
+          - enum:
+              - axiado,ax3005-evk       # Axiado AX3005 Evaluation Board
+          - const: axiado,ax3005       # Axiado AX3005 SoC
+
 additionalProperties: true

-- 
2.34.1

