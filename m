Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189814;
	b=gqRvN9MchFMXp+fbxMCdlDl0vaRoEacIDzFzVIMC/BMsFBw0eXrP9bSEpy7ecMb+LajX
	 eYjEDNZRyOrprrPfuBtWil/Sk0KKIft0Wd6DC/3Nq9zQRQ2/H21Nz4oei67Y3Q7NkdBQs
	 BEF4+LPFeKzBRpIdC8FT0H9f+GfHwkXGiS8XcHQ0J+LkUEgkLVoGhbNfE8qXeQIdsdhNw
	 TXZwq1cOdTya4jZxUalE/bVclzDghkmEG03DNuRuImTMFCNAorIU7DUZWzL8GdWWVJ0ov
	 FTK5WR3Y9YVuJ8Hs+h84kmiru+qz5b1+yHN2km7QzvuS9AGOJszKPqvfXECPi9POHfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189814;
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
	bh=VC6rWigfFFRJBU5JPuYNCwXyjgpsJS0EyoTK/XWi1Og=;
	b=WxKTRS2I1ZR0gHHowMhnbeNOyC0Thc9uNkXE6eyb0pP0W/a/suRSStft3BSmgX26enm8
	 pi9y0exIkG4GEZjGEnkca7+XOuNsEPwknCXKhv6iefCS5hKLIlyDwPPe1Sa8QFq89NUzO
	 pxkXFcSfbZEMMRP0A9IFRtLu0JcILizDQXrXg4fKGr/yAg8Gvwfdi4UXe3EuNjtHhFaOu
	 riYM3FFaV6NV9KGBURPGIFj90qUGLnaSQU2MtFE8ovMxq4eMu0i2fidmOeNaIJ23+79qq
	 e5pgxzf055VeFlRtfB+nW0MAExEh1oDwN6rPXlfUJKk46GfhsTb+wRBiAuDSBSXiT0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=V79P3zOp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.11
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010011.outbound.protection.outlook.com [52.101.229.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C69606A336;
	Fri, 20 Nov 2026 15:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C69606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=V79P3zOp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myqNPNvwjrut8qZfFLRycJRIA8gf+pNzSIeioP3jV/sVDPMkwvZtMukqhci+niKCFHrvceTCFgG6ZjH14A+026FXwx49UwiqRlvbI33eH6ozWKstqrQZNFAAk8UrtTAOXmZz1xEsedHwBaSDIKotC/4SRkzA3Z6CbFXdPWfyZ60mjVSax1IbuPBt13QhqNCwPy7UTB5/e0trZVkIkCMWGQjaf0vSPYCzGOtBvtB1gAS3KODlw/GE+JRq2VOQzuvGtVOlrD5MTGMQqGn7CpqQHDdLRSu5lx64PZCzO7Ig9bk/3PqGT2Bdz6Cx2uQ0PjwjYySMstsL27HTpJkcpnzFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC6rWigfFFRJBU5JPuYNCwXyjgpsJS0EyoTK/XWi1Og=;
 b=M7WdsxybTYUDoGiVbLj/st/8rlaHZTFnSziarzQ6FeCYgz7cM/Si/g1+yE1LWYiWQhc3dPK+wwOFKYS4JBjTre/c9bqcSAy+t8vjD8eOgHR7srcvbh5EmvdBWor1ZhhEDkaPMibTSMu/b5B2tzw8MTbrdTUrtlyRJramceQ52QNUbw3WF2SVCLp7aFILoWZQKnoI1egaAmkPwcHfV9MSwVsmZsWQdkXi9d1lVbK8pMTme+X+T/2UZkQYf7jl9c1s34FEfOGncm/EO+ZifY2RWBx8DrHbtYkmAEOZAlAb3XwNSmZSn3PFYoL+YWYPDFp+ZJY4jx54d1fn2dUCtnwOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC6rWigfFFRJBU5JPuYNCwXyjgpsJS0EyoTK/XWi1Og=;
 b=V79P3zOptM/pLFjr/c/yyhnAAiemIbU7fUocg1ZgwQIMFChCRqUvG6F0xCSOG4gtGayMzYfnQICGz/N0PE/p3seZ8E9ySYH9KBdIs/z/1k+INE9WSfsROGbAuodclNo6E7QRL+UznZ4W9SNj7UCmudg2svvvwA01+aAUaBqZew4=
Received: from OSTPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:604:221::9)
 by TYCPR01MB11027.jpnprd01.prod.outlook.com (2603:1096:400:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:50:09 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:221:cafe::2e) by OSTPR01CA0021.outlook.office365.com
 (2603:1096:604:221::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:50:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:50:09 +0000
Received: from [10.42.0.1] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.16])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 28FC5300023E;
	Sat, 21 Nov 2026 00:50:03 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 20 Nov 2026 15:49:27 +0000
Subject: [PATCH mainline-linux 4/4] arm64: dts: renesas:
 r9a08g046l48-smarc: Add RS485 support on RSCI2
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
Message-Id: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-4-a989baae3559@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189777; l=1569;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=VxAPEzAhIjudLMiuISbJ9wg4QbIiXKXnkPSJG6SB0fg=;
 b=sdIq1QEKl9rbRMljXWd5A3/WrvnmnHCuPO8MIa2YPFgz7cxkAp9Voo6rKdRCClVDM/sxUajrV
 qwOroMwjGhwBoD7m1bu9hZ7bVMg/us6tMUYe52opkk8mSmUpLmTdxL/
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TYCPR01MB11027:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2e3306-4968-421c-9786-08df471df4c4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|36860700016|1800799024|22082099003|18002099003|11063799006|921020|56012099006|10067099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	lWq2GNUJzOg+Q20TIfaULcNabhthTVpSpcnwEEyWgIaX/g+zHWSJE+PqwUqMT8lf5sSX+dGCCgOMo77gOw3YxZTbPRIbjUFKfqU/KYXgGU7J+Bg//e60dKfMgHjVxV/Ref5xuiUgNe1LMuF0lACpjEKAb+t2Z5Ixi1mWVw8IWkVVd68PQdURZ/t4Iv4cLUCq4sTSFV4hQwHS2kXzEFtm3joor7FRLhOzRsXgn/dpoZhakZPLzHVF5oxCR2lpPCmGu7vLQQE90OdYPy7gKfrEL7FckFQpYMPmgDdDwDEMhdmA5XoRiMJN62NyCteazCg0uEFWGbReofrzG/fmMYuj/BBjD/BV3kZEJmZODL+8ygZEiaYwUBY69AWVHvA3FCNjRjH6uP8WuR+Jg9ltpytRsHOzB/EwLE5HwlrK2tSHRmf5zU8H6M6JxcoRBI1aenOiFwqB9/9hdwzXQOub8+3jXVJRgH7C5POQD++Pw21VGLuSvM9/OOzAZw1Yprq9SMfz8z4F30pfOCNyDao2l+LuivfZ8BnGmzAQhH234n8sqHTFHYrYPdFaD/HjxTJdKeRKQoozO/3P0GkijotAgM6E25DybJDfyPmukZSpI6N1ebogP4p401zP1SNnIuTQd21i2QSOIEBx2FCA3YdEUxUUNiG898KoGvEn5Hg3QBlt9mzP6SBHyeHgbW1IrbjpumRsluWoA/RNsCeVOA+VFgcpxKFlJCm0+igh6J8FzTI03DJ/noa36DYVzZNWWkH3RIaE
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:JP;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(921020)(56012099006)(10067099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y4FB7YqhV4Mt8234wqFGMQbB/CXb++1mleNclchlYmIallR4tkUPRyES1rFuBcrXTxfxgDkoOrROHSx1OTI0o4OPEoY1bgkatLGR1+3S1mXItkRzJAeuWz0lj5FJkbhdTWQf5OgvD7Uk19VheHsuECXrSuCQiceBVVf9TmafWi8NDEu8BslGCTQXBZohge2PnTbYOOtjzu67uPa5Z/njO+lkLfV1uQmFoBHdKerNgISXeAMj9CcFROiCihYFN0MJ/xJR5p6tU+uxM4Z/jt4ngSTPNq4zObGiMEgXsVygVbg7Us3A0M8uBwe94I84kg41gyEnPbIFcrdihPkOG6uAGwcDpft4zH2ET2AsYygYXCCAitcn90wRLWf5v0uRQb7OiA7g1idcbSAvtWEvSOA7m57q2000trMAtefPVQFrEkxfZIA5n1sJVwgzcD8z7mjk
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:50:09.5415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e3306-4968-421c-9786-08df471df4c4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11027

Add an RS485_ENABLE macro (disabled by default) to configure RSCI2
for RS485 operation using the RSCI2_DE pinmux instead of RTS/CTS
hardware flow control.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index 68d7b579e352..d583f52e61e7 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -23,6 +23,8 @@
 #define KEY_2_GPIO		RZG3L_GPIO(6, 4)
 #define KEY_3_GPIO		RZG3L_GPIO(6, 5)
 
+#define RS485_ENABLE		0
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h>
@@ -185,8 +187,12 @@ rsci1_pins: rsci1 {
 	rsci2_pins: rsci2 {
 		pinmux = <RZG3L_PORT_PINMUX(7, 6, 5)>, /* RSCI2_RXD_MISO_SCL */
 			 <RZG3L_PORT_PINMUX(7, 7, 5)>, /* RSCI2_TXD_MOSI_SDA */
+#if RS485_ENABLE
+			 <RZG3L_PORT_PINMUX(8, 1, 6)>; /* RSCI2_DE */
+#else
 			 <RZG3L_PORT_PINMUX(8, 0, 6)>, /* RSCI2_CTS */
 			 <RZG3L_PORT_PINMUX(8, 1, 5)>; /* RSCI2_SS_CTS#_RTS# */
+#endif
 		bias-pull-up;
 		power-source = <1800>;
 	};
@@ -235,7 +241,12 @@ &rsci2 {
 	pinctrl-0 = <&rsci2_pins>;
 	pinctrl-names = "default";
 
+#if RS485_ENABLE
+	rs485-rts-delay = <1 1>;
+	linux,rs485-enabled-at-boot-time;
+#else
 	uart-has-rtscts;
+#endif
 
 	status = "okay";
 };

-- 
2.56.1

