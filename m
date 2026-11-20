Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189801;
	b=iVzxfKGpPT6nMK/m4TTKDACH4QhvjxC/7NLD6uxwFyW+tkyf0hbr1qH+Sbw4Gr/2Dfyv
	 fvH2o4jOz5M/RMfIGHvob4bTREHIc8j5ffcXbbXu2eWAbSbB0O64pQvsN+MjkRJPbCl22
	 vnzuSERGE3+N64jZOI2YjZTbGvIPC/30/KzDtknAGv0Q/BOdBH2k0i/5uebjAXQF4CubF
	 /Vuvpeoi5srDUnj502W+wv7bWxcZvQ8GwnpLrMAH6UjQZQdTBPWBpleUstn7MtccfY8Bu
	 xpPaO+/0+/tUW74q+id8aDo6Q+cEEtvLODS4/AqDIty9BQFz8EOXjbLK0Xk49geC/Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189801;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=A6wDSQ21SEE91nUOWve73hiB9bTJvyeBI+da8v0neKs=;
	b=B4C7eXyxH6gkUk41VABMyxtOGmi6dboVdydc4XLOXp0WE2cFDuSDtLCfdjQ7f0tBUYw/
	 POjW4eUr7HJ1wuEqgtxnvYcqczt36KrJALy/Kr35AiMR0xnSSgtgESZIBcft6j5JIN8iA
	 TGCeLqjgap4hG43DqmuxUI7UfUY9QOY6JJzN2qkAduHxgmr2h9cr1Sls1kErCtj2E+rAD
	 TUQBXII6gVxiIT7BMINe4ygvl94DhUPLGiJVOERpm3sWaQYb8Cph4JFjJSwTVSVfcmVhb
	 lWTV6SBBF9o/9d3hKsuqpjwBQJB+WwLyqAkSuL5U/OO4v1UR39HzSZlx4yHI0b5b3vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JvWcslbP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.70
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011070.outbound.protection.outlook.com [52.101.125.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB23606A32C;
	Fri, 20 Nov 2026 15:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB23606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JvWcslbP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoHwAcaRz1R/qcAReLTOf9L7UInpksGUVngjp6/2LiiyWfPSyw8fw/sgVj6VOhKSZQrYvCulUpJsU37hXD+ITg1JWsMx8gYvCaN0r5T4PtKl9JhLCv87Up1KB3EaTAX71zzQ7SXxwoNT7KD8HOhme/uB+G/Yf0WWdRG2WqdQ/mDnvV3phTOE7fRy2Jl/kOZSQz1wtgcZdCOyXZ9k33pGRldYWRUICx9mViX5jLv5S+ZMntxqSFIm5z06vg27Qari96bYFkjFKGl0iHctkfDLHdy+n/TPBWuZfXAqSOrkJ58//hkxID5YvbAun866rdv0TPRTWBMxknehmq1H3AO3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6wDSQ21SEE91nUOWve73hiB9bTJvyeBI+da8v0neKs=;
 b=K7BeSucNnjKQUNkyBBXbLHeJWY6Ixh3dwnRRo43wi2TXNxA7gr6JNaXWfcgV1vvH1NcG9MzVDuk2AqwlEwP0Dmo/wHfHG8sC8UZ5TL66x1ZFA78lYnjMoBIrY7uFZKRP6rMT8CdfAcnSi8swg79HshB+/UhiKKCM9BCTp/CTst2I/1mdZsfXuup6U6LFox8EBvxrLjziDi5BH2xm7Lh9vrL9iSYAsjtoKwNpsRW8NWXAmqTzGlat65rjgYM2ju3gzIMLztxB80LJ6vMV1trDj8WycGSprVBR+4h9GmhW6mgMJMjDum9BxnF11GDR3Ck37M0VXcuKRVK+Zy47JEVa6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6wDSQ21SEE91nUOWve73hiB9bTJvyeBI+da8v0neKs=;
 b=JvWcslbPDoIm0i8g3k5nIpD/zscFUj5pQn8uXPgCX9GNH/953ZXw1JoPxBYlIeMi6TzcyOuZzvj8blraIm9NQSi3UPhxZ02wGR7NY6ik7oooc7wzjm1HcMDRBO0R36WO7nH+AtsCjsrWD+7Eerff6vPdmcagfRnkpw1pNWyZfQc=
Received: from TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::10)
 by TYWPR01MB10474.jpnprd01.prod.outlook.com (2603:1096:400:2fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:49:57 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263:cafe::90) by TYCP286CA0023.outlook.office365.com
 (2603:1096:400:263::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:49:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:49:57 +0000
Received: from [10.42.0.1] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.16])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 13C26300023E;
	Sat, 21 Nov 2026 00:49:51 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 20 Nov 2026 15:49:25 +0000
Subject: [PATCH mainline-linux 2/4] dt-bindings: serial: renesas,rsci:
 Document RS485 properties
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-2-a989baae3559@renesas.com>
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
In-Reply-To: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189777; l=706;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=X2XqqV4Ie4f+x3PE89YvHO1HcvcYFzgLR/yEpd+XjJ0=;
 b=Jx5lmoVdTvW4bVxiy2tE7Lt4MdAOVYOrO/7t//ZHP8CIMJ9mn+BcwQfN4hqZX86Nqjh32bOt3
 Jn+SwLpNXTGBOUDra+biIOIeYWAbqWQjiCZTk3wCG+9i7QQpTLP+rQo
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TYWPR01MB10474:EE_
X-MS-Office365-Filtering-Correlation-Id: ac391c3f-a31c-46cf-6941-08df471ded95
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006|11063799006|10067099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	I7qzMzk9lquohf2X8gSL8t9dsUMGOqsmvgX59zSvOgj6WlJ7zon52PjJ46WkCceuzGTfeSe1eesJ1SQhX0kLVdcOdboa2zp9mKrz1rtiCTPv5foB6E9+Hj0j7KIOkWoRpMDRV5b+NmiLdgu2iRjG67xNNpEPuLcd+WhpiTMktZGPePeckwgu7l6SRWkbgDdTV1l8OO/zKG3dy2XqujSHYWRBXq9ZwUXCOENj4R0O5BvSGZ7psD+gYhNOUx17/+AJjBPhCZl25CIWbEQ9TD0VtkN6OzYDB2FbwsiT5WJqLm15yyKuVWFZxaGdKH+9BnKph9EH4TiCA9MMcBznCzqmzg5otthB0xnDRtVpfQYztkqrt7VFKbEyXy19Kbgwz+slmUYtJPNl/l1vf75olYgLNjvuj7f8LBTUsfotKC7FTC3/elOtQvByV3+ll2GglRRFr7VKEmxKgk9VAiFt4V81QYkhTNqvqYLim3LAmuWv3/LYcV7QZxQdqNbCYpK1pHr9PjqD/XJP2LWfCPDpR05z7wTMkBLiTykfy3MapLabcUTfE43mnDswrTjpgQt2CWreqtCxYhxDUdKNnuhbn6tgvJod4xGGJ/mTYtQ8uMUFJHHwotA/XFMP7JgyYx+ed6H5q2DcOi8zDyDrAuxundgqXTi9NcgAZPXsgZwMpDFWh8Uv4FJUuKpBw1IOyn5CDPO8ti51dslaHqZ4hIYtWQqloSt6ROSaALfLLIj0WaFkWwX0jxRZocoFLVRJSOLKfxpK
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:JP;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(10067099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EjKXrQ7Z4V87/cgu5huP726twjByPFDH3+QPI+2lRd60p0bCVjeiCIluNQQ1vGI+dihkPldng+cJcELfltrrLz7RKlULTs9Xq0ZjeGFws3EI2jUvtXzvDNoWFjz6Cmbsstv3QGmyAdl8kpF8GRaLpnyd3Gnu4UHZsVK8NocI4gkQmyNK7ly/Sm0i4SutkmDjUUcEly9jSiMDvAPigHqoKbMpwjL3N/KmdTJ7W5hmZ2u+cnFDJPe02PdJhx+uAQaBjRyjNwLL0aC695ra8iljjZvvLA+F9XgNfEA2JW5K+SWUf1mzdc7mUwNvnshI78JDmv8XcBdTthIqzFvIonozk9jV8ecKgL+CK4j1J0OsrhBiCZi2+QhIcOVogDfW1xY3SCfQyZpRCUAbh7nGechBoRNkY/xlfP0udvKhNBdOgo40i94MBRO80kSKuLNUrXr4
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:49:57.5012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac391c3f-a31c-46cf-6941-08df471ded95
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10474

Reference rs485.yaml to allow standard RS485 properties on Renesas
RSCI serial controller nodes.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index 85ebb3056066..9adc7878127d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -97,6 +97,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
 
   - if:
       properties:

-- 
2.56.1

