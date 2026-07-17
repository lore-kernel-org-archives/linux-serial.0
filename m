Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020095.outbound.protection.outlook.com [52.101.201.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9735B632;
	Fri, 17 Jul 2026 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260295; cv=fail; b=KGPJiLRf62iWVVDBVOuTRjJxkQmV7Prmr93et0rj7ZYO+uDH5NzM3uBhNmVo9bdn8dglPICPS8VT6tfqNOE1ldS9s5yP5A/yOnO6/+kYhAJkeeYC+KG1B3D8Tk6CSU+Ql11DCZKsju9Gw6ARHXLhmh3gF5XIqwE30+OoVWKSTxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260295; c=relaxed/simple;
	bh=yHhhBGFmuPEPQQFXSyJwq9ADmAI+VASunnyC0foEJW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ujk9ZxAvbbWKTIh2DLENA9TY9Ppwd2Tl56a/uLiKWJfn8jVyPVbae+s9mV24NAbBHJtlLO4L8ipl4Ep1TouByOI4qYHMirCAEOGDyhB3ml75jJyxFwIYHngpAlGrUcMAcHLk0dxBh31eOr7jB67r3rBnTbMnY2Hijuu2ge0O5sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=If2oisRs; arc=fail smtp.client-ip=52.101.201.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="If2oisRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y717Z4f2X2TV9/l7eNX0jgdyvIB7kjXXsm5RGCA3soSYD4MgYPxIKIgge1ZVlTvV7Jc+Q/ZlffiLVq9F/P2QKIRjFQ7ThUfz/lUecSdqgD22pFWOTSM4Pvwx/Hgu8c91wrqO7rEJ+i0NXLuGQGF0mjGsa8AtBA0ed9zT3H/W1INA6qPNHt+57IEBuqj9WRMPKteInv7t7Oy/GFrGhMAennTkJppOPdxcPyarg+cB/OJxqXGAm7YfQx8QqvubowtfUxILFbXmITmghJ+m7AMH0VECurQczjzDO8rpjRs+DKaz+YWDMj2wG2vlAE+8EWJ81SG1OR+fYsJN4w9xPcki5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EexzYfzHsWuxpcubA0uZhUgZEehf/VK6/Ysue19Dy00=;
 b=Eq5nRSzyD0plgMnYOzAUBbpv5WuFKgnFgEABvVVUTZbiGxNWXZcyZzCwExaETum0YYLtaPN6f66Q0qgGWYDZNc0fa/4BgbGLugHRAqdhb8A1fjMjqskZEMrfEUu1Njc6vVjFsrd54HtpMM4EFBqL3MrU5eiKw5g8sDzATxXO7vgYV2KYkkl2wxYmflriGYnMTilLhJpoCZ30dcDTn5DFsS9Pis5byxPlDxFHQfgTg9fJ69Y3Awbm4qc5Wky8I87gWOxCBBoz673+kGwUFU3kGTP6Mwde9nfJEwVSG0VtjbIYp6vsBQIS1Yf0SIhIJPlgjlHHBQZCchz5UtwPV2UXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EexzYfzHsWuxpcubA0uZhUgZEehf/VK6/Ysue19Dy00=;
 b=If2oisRs1QMZvyRhQN1/g+0xXiXN7qy80aWmvh6WvwU4InmksIEKV4RKUMrK79ZNWWVP3NZZsgWVkHgolp0uKgCIdascF4gXDNwHoOHq6UaHedlnGWivdwDibTjiZBZyWyrWTpcswn9PbgwAKJvr7DAGQTbTcT2Ugc0G0C2nAxmIPUzSvdXvqt32r893u0VF9482uMdHmiLzC9oXOYIZ4WQBMCc2vQbjBd9nDB/ISUE4VrFN60hec3du0BPzAdQwon5k3Z4ypcVLXjvF7gvT/pqDpL5Gu0IcOXoi3Z75xFnLFQzurFDlQ4ZKwTl8abIzqUqsqFvkq0FjE9cDtRDp4g==
Received: from MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14)
 by SA3PR18MB5319.namprd18.prod.outlook.com (2603:10b6:806:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:51:28 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::85) by MN2PR22CA0009.outlook.office365.com
 (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Fri,
 17 Jul 2026 03:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Fri, 17 Jul 2026 03:51:28 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id 446EC40BFE0F;
	Thu, 16 Jul 2026 20:51:26 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Thu, 16 Jul 2026 20:51:12 -0700
Subject: [PATCH v3 5/8] dt-bindings: serial: cdns: add Axiado AX3005 UART
 variant
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-upstream-axiado-ax3005-upstream-v3-5-c429095143ec@axiado.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=syang@axiado.com;
 h=from:subject:message-id; bh=yHhhBGFmuPEPQQFXSyJwq9ADmAI+VASunnyC0foEJW4=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqzIZXtnzdu6z7JvyozARxemv5om7zONdZKktJ/VnZb2m
 kMsezgOd5SyMIhxMMiKKbJ81fmWfzJX+17n3pWlMHNYmUCGMHBxCsBE6l0Y/lkK7HpTrR157a9x
 tfNiuR0dBRPviJx4/ifl3zn99FzhbSyMDHu2XOPU9hFLMWqaYuhh235NcJn9JMbeB5qbbnxo+8A
 SywMA
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SA3PR18MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: ed304e4b-af7a-4182-85af-08dee3b6ae69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|7416014|1800799024|82310400026|921020|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pa/8eUXeL3tczcS799phfYkZomGtcoCavLuSNnweIC4fl4j5exy+DikagQg22uEGVim0yr/FbOLVz9NkcoaaqYFffOL9a1cYk/U8dY5JilQZTmvrdzta69XwMZe/3/u3LcPD5vwGi9McRfs2L7M6OZ8Hk5SWko7rgrlLlAuSUIACH8fIObSDFq7QGSKfXgcaXn3cfb0YYPefnOO+A90rVOYp2bxCLliJLZKo1+2U/WTWkomYq3gpXVfjIPi2JGKZif777rS/V+bkaSlhehWqGdcZIqluxPW2cGy2LmxjR+5JDlc5Pfza4Fjy6O5E/9SNxVrR4mK+OjQxrKvdPyqyZVwP93mc+RAbdPUmoS52USioBCNjFI4OEfiXBMpkgEe0/QR387oVqooq/XEZ9yPE9GRi3zY4sfoIVs5Wd7i2oCGY+aSCiUHAqaYtHfEiFplsgJQbN6p0WFdoS/zURwOOPi8YkOzHbED6+bIwsx82RyXvccIIxbv/FxLTofQYxCFh6Bk7PEjLo9jxPIn1RhCvoCWFlZJF0EzNKcnxuULaibnoTU9+cQkpt3fx2NROL2lPQzcWjG9pD6rOtYrFfqr1Y86qS2XYp2IX6iIqKJFr0Z/yhbhyTEcqkergX0vMds13QqB+YeSpjw34fAqh00Du7RIVXbA5dMwC67J69prEBYKqMMImQ/DZ6DuZ+XaJGVK2GH83RHxaCKf4nO5h3GcAiWQVQpPUpVBsd8cBL6bSgS1Pzm7YiJVgGjO0mUi1yy7p
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(7416014)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bSeWn4VB8m2GOtDYX9NHQAJoq1vVtPtUlPyYCmO0ZwUyHFinEubFZg7oeAeUp/k3b0wZP1bfETMu3R5ogaGRVKdEDX2BxYzC2HNoYlxY6yXX+26mtNhZtT/GALGRM7L0zk3zsmIxoS/ifMBNLtB53kFJaTcxS5+ujfR/+7w9x09DxHwBjfn9N1utmHxOdcCPo+fNorPhJP71ZjIZwldl0jIe9FAeEN+PFGf8bW8A+mVQpDV2anrWNijY4GN8Eui06wKEH+Jutqk95/FdJP9cN++buCJJAUtdlgm28ibOG8SN4X3BTXtKUCa6p08QLRp42WHShqXnpd0FmvCXCzhoOBZCzwg5lUhWQ/aaQkEUyfBCEyUhz+PBtTV8HrFivrHpujWtVpsgU2nip6rtKiTspZHjtdXajEt8N56JgG/DzFCWonxkoFWW81tLUc122abU
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:51:28.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed304e4b-af7a-4182-85af-08dee3b6ae69
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5319

Add binding for Axiado AX3005 UART controller. So far, no changes
are known, so it can fall back to the cdns,uart-r1p12 compatible.

Signed-off-by: Swark Yang <syang@axiado.com>
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 9d3e5c1d8502..11292de42c67 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -19,6 +19,7 @@ properties:
       - items:
           - enum:
               - axiado,ax3000-uart
+              - axiado,ax3005-uart
               - xlnx,zynqmp-uart
           - const: cdns,uart-r1p12
 

-- 
2.34.1

