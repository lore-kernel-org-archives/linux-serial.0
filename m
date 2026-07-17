Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020074.outbound.protection.outlook.com [40.93.198.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D070367288;
	Fri, 17 Jul 2026 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260304; cv=fail; b=CIIvQFrqXXVu63cui9JdlaBZn6xpksjFU+USmUM26d3zE9H1WIazwY2zGY/K3FJqv7+cBznMsQldUAOI3p9BwTGkKH3e6+S99mOO3SBpIbMA81LX5G3nmyQXVKfSE0Dwp+Rsf8yLWXiBJXWnN9cGHidNHFbTkPlgCyUzfTsVezA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260304; c=relaxed/simple;
	bh=Ym9+cZXmLDdaH+ythzMbiblf6XH7THBis8PtxMq11yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erLPxSqsYsgBszl0LhxhcZi+IYpfm9EEMD7POhRA+RT3chQSYSNs1qXbl41NFV7CMUrAAg3F3xftRV6Q1yqJmgxM8VopG+BlEXWPvL/FffHFQO4J++fWFtyr2jCI44VbXKdquvu9sBu+Hp57dyDYqIrdQQQKcE69QR2QzAYly/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ZwV1Cxcu; arc=fail smtp.client-ip=40.93.198.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ZwV1Cxcu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m01nFM5Z9ggU3pNFCUgMYK3IUAo/K70AyN8uU06IS6FpJPDGsuHTcBzqn/1jKbZu05LFTTbyBiNgowdbtG0tSQRjBMuUuN1da3zrE28tuayXJbj6rau/PzzobWELe8DqzwUGhxKEIm8EmNFmcmhXdRoIgef0lXq/jJQc1SflTUQ8LqPJIB52cegdYknq1fYLv9U2qS5H+IAqRsfGcqGur4Ry0R8Z2J4UQhOwOPgPNdt/wSdYueCFeV/pgMhdrH+BTZGkts/RuvQa5E14JN+49jIul2cPPnuO/YK61dZj0X4eReHsyC6jsIfb2a+s1h9QO7ujnn6qAkRN8VvzZmFlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opLkZlPrW5iyydvYszF0o4pQO4Jl0Q8dvcw4t061brM=;
 b=tU1eXL/zawa3W1ygBsJduG7zSstO9Id064Y9Bc5tJK0t1AlgzADOitci8HNdFVIlcxqjw3AKJwnpIr24TY7VROZ51sFr8MFSkt6ypb2ISTkahb7WKHjFeNLuMMMLBumd9If9p7uogMY6tuR58mZjBYuEr8XoftxoRtJZw5cJ0Pw45sTho4LT6HDNRjQVrIlplBas6qxe3w04Ee9TEocyInvaLjZy78wVxBflKXDknDxCtMreCBZ5uXo6LZZ+HTDTqKFF/DnaehA0s6jRrf9S3BFJBUr8a6r4L57h1rpTYjvTbToCnMiIpNVxMR6FBrYBzEt4GZYGTzZeVmrMgxCfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opLkZlPrW5iyydvYszF0o4pQO4Jl0Q8dvcw4t061brM=;
 b=ZwV1Cxcuv3R0l+bRuv/0ZQT1q7/GNc2sCbxhjKLGWqhL87ddsI1Y8ocIfxFMv7ah3+pC/suXsBY7+RzqariLHpH8MdNw1R69lm9ckLXusfJ4QtMC5Pw6tK8asjmgvUINHK4qsIx1rJiUJgUjfDMLK7t6a1LGxIXl/EatE490IXDqw30fEg3Dg5EXInftWpfz9DnCZykFC7SzILNEX5fJIIuz5oPYN+jL3LiVnDSfPikyRa3uSJ6AI1jAcjDXVq/0lGBuZUqloRkEcs33UWDrXBsKANkgA7aybD2KBB0HkmK6TZWi1x2cZiu7yzWczWg/T4sWGuGj4rxHuXSOvEhe5Q==
Received: from BL1P221CA0031.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::10)
 by CO6PR18MB3955.namprd18.prod.outlook.com (2603:10b6:5:34e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:27 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::8) by BL1P221CA0031.outlook.office365.com
 (2603:10b6:208:5b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 03:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:26 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 3A7D64186B59;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:09 -0700
Subject: [PATCH v3 2/8] dt-bindings: gpio: cdns: add Axiado AX3005 GPIO
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-2-c429095143ec@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=syang@axiado.com;
 h=from:subject:message-id; bh=Ym9+cZXmLDdaH+ythzMbiblf6XH7THBis8PtxMq11yU=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXv65IyM7/enOLPcqX1Z0Nr/81vXv1nM+ytdpu0xS
 tPdxMDdUcrCIMbBICumyPJV51v+yVzte517V5bCzGFlAhnCwMUpABPxjGT477Jsgl9RhUKNVNNj
 Wd3Tdrxd4RsnubsWTb6onviKPYNlGiPD00uf7Ry9dgV/PpG94mGkzq2bRVyR1lfCv11oZhE7xtb
 PBQA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CO6PR18MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d35dfa-af18-4676-584b-08dee3b6adae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|56012099006|22082099003|18002099003|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	HUU7QYtBjQ+W27DX63WMALYAwdB8q2815AYaFKLam9Qtf/uT5EOCbBL7M89pR/v+SqJerrH668zKF3a847QEDuZcVuzjx6Ppu2tHPY/8lb50mFjuCCaK8/q7f4pS1HGVEcrZ5fGDvVXOqHoc3cxC66xMTBaTG/3DCoRDIV/VZxHCXssBb0vvOkM9tylNXch01MmkmL5Ikp12+2kOiAJbKRnZ8ASxGMijI0GhBW6hwGhDbY2iODjsIEwctQJ81PlB8IUcD7XeOiBigFCzQhHtnYvk0VYZBXReZ+uhTb/JCfGdUVppPArnlvsTEcRWuQR5ZXSB/tXzSEj4lxTffGhXJjab245AeSEaSzUWNpA5T9/3n47VBwvEQvTtBrnbRBj0gLXPz2bdyIY3oonZkzmBK9J3xE/eFaoxIrgLjr3zH++oKaT59VxSwTU39ckIalNWnqsyGBiIgVO+BiANAS0TeJGKcXp0sQj2InAaHEGhJAc2MWz+S85e72vscT91CfvD+vAf1Fr8dZXaolpLpZt2c3I7hze0GDCuPblOQIPiGcZszqbM3q5oY68o3l3+SAUfVFXtwW9n9bxEwRcKUPsEZU7K5LhBPyWjR34tLtU5DTVA4ynsgULfr8OOW0gQZlAnBXxGC2ewUyndgDFrNXlfi8V04t0JuOZg4SWDmHMR3jvQ5/q4WlHkGyF8z8DwK5QbCBba1qibi6VoEx7w77BSwSZesRNFAqF9OKNcrWQY6K8uXxMQyPqnVQbsdPQ62S39
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(22082099003)(18002099003)(921020)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d+8EDA1FqRco13/Mf/jYq1YznQY9046K3Wj1Z7BIMsb1/gXXkqXqrlPjB3SbilMOVeFWZO7tBh0WWweMt4MWCZ6WBhiHwuLL+sxoo9wxzOks0dLEOHDkQnFgggwa2GATcuYIDy+ad9BK3DPBRaZxKIzMnSsIENmyOA7772jfRYfYlcx4DtqjfdI2a65Un8Ew+vKpg3TkfZPKtRUu0wu2lTH9VzgVIeGoN9+cNCefhrIyWy11u6wqy+meiguvbJHADHj4B2k4JjqL4XQ5ufVdIBJyMP+NqWedKdATEBIqBvmdYE4ChwD3XUAa5bNS6OtkMKnbc+2ipU7ytoT+eEkKKk5kTNbv3qRSTyYm7KVPdcaDqRbcI4ROcJDlREG6X8IsgfarFM09/FHQgjB1R9EoXBVxKVoecFWviypMfLEU+sAS39ejsQpl0I3a2BU+SzjL
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:26.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d35dfa-af18-4676-584b-08dee3b6adae
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3955

Add binding for Axiado AX3005 GPIO controller. So far, no changes
are known, so it can fall back to the cdns,gpio-r1p02 compatible.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/gpio/cdns,gpio.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml b/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
index a84d60b39459..7eacf5af6554 100644
--- a/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/cdns,gpio.yaml
@@ -14,8 +14,11 @@ properties:
     oneOf:
       - const: cdns,gpio-r1p02
       - items:
-          - enum:
-              - axiado,ax3000-gpio
+          - const: axiado,ax3000-gpio
+          - const: cdns,gpio-r1p02
+      - items:
+          - const: axiado,ax3005-gpio
+          - const: axiado,ax3000-gpio
           - const: cdns,gpio-r1p02
 
   reg:

-- 
2.34.1

