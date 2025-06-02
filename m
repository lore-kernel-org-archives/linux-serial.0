Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261E225A40;
	Mon,  2 Jun 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874481; cv=fail; b=d7D/53GHk3r8V+Vf+g/quR5+Vwh0/eUfD4ZJijwmDf8V2yOQy6aD8BfgloJDP8Rrrq2rd1M/6JtS8tSanXc4IwkCtPVQjbQUVRP2pFzUxH9SzL2fgLGrdgY6gbKhxaAIse10gQjg3WPqe6zCj8avsB9EQTPeqe86Temh7pMMvfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874481; c=relaxed/simple;
	bh=+h5mwVlmCAyDvzPoAasBQsQZcBQfZU7WHxD9MmljQEE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rBjcyNQFzziLp45pmYu7GSOj1rrFu6uHEGlpJ3ni66xV/xsM4YavtvaxIcnjLEaBQSDNvxtB5coSeIEifZwUTdgquvepmfQz3mta9MUIp5FwaSr08OWd8tVH/KQKSLL05SgpaL89IjSQVHxcsJVrZFo8cOjUmZ2bJI7/Q5Sb0tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iNH8FLbJ; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iNH8FLbJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMmFY5L57sAIB5CzOLWwa2VmFNDNbnxPMgJM/6DFHXcBV4Lq0LJ55SVO7bsnV88ngfP6uh4U9roFqhvNqMKnr10Uymtmmfr55OD0aFB9vYKqn7W/NtOp1TP0y4OP6JAHLrM+7Ajs+SnPtfGd6qlmA4BiF1vvyyUYRGMrUBJeKiiagz5ygcBNjius6zkP9AGGNlkyuqwxe2DRQibuM9IDuF6iOw5NSEMw1p5G67qu4n5jG+03B/vGa6WD4TBAlRl4LaDc8aMfcj/FfEbLJODC96EYRiWOWqpww+GufMgHDBMp+zqi4afQIqm8qHVmfRePv/xvW7Z8oFsCwPL/TlS7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqcQBwAWhFBN4Gu5RBtWMMFq5V/xZfhs3j1srztBpws=;
 b=d6soub1ka0wch8JkgJ77BHBqUleBAtbDlt16fBjs//0AKyjR9vePS5Rw3Qfs91cUJw6DQal2iUQGpU2SpU85SA7sZRgwcjNPqu6Rb1BSSTxbI66YsATHvISRqz2izGILkMwCMboaYuiAqqHFY21l7cQzr3lqGxWZHar2tWJkqna7yRhgr8IHk3OD6bYJGhYmTZVCYM2y/e8CTcVYVaECqp1IzR5EZaKmgS8xdGDWLjoiS6dbe6tfhPzjPHbOHJdWC8UelKXXTM/LpuSrjwMFvtFg+DbMlb67Ayw5xUTVQd83EBr3nFl/cI3RjCtdK4f6jIVFiEDodRoVXsVqYM2mEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqcQBwAWhFBN4Gu5RBtWMMFq5V/xZfhs3j1srztBpws=;
 b=iNH8FLbJywHAHycD8DH8cnnhqz1BNOo8QUU29jFfQYfMvZuUhQkrbEAjLJZEDFniNR8K5QPX1zrMArhF9b6N+oMWYwh0igIUxKMeQn4GJyV5dc+LFGbFtBrtnPg7K5lZnSAE9yT7YQujMLVxvJlSBXhE6S6vgTelXJJ51ny16D8tWY7vPvFOQDqm22GtIXAqfwc+MIz9U7LhwIx8n8A/McBTIOf2fHk+OepHAANrJWMpF8Xzyn3bKuJEeb4A7AZ9LAuc4sciVAtPx9cB6ue5GL6Q3xmdCJOwNI7nqzJ7zCXy7efbGcHC9haEBQGOOp7zSfYawUOZ9Ala5GrLoKnHiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10133.eurprd04.prod.outlook.com (2603:10a6:150:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 14:27:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:27:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org (in file),
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support:Keyword:spacemit)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: serial: 8250: allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart
Date: Mon,  2 Jun 2025 10:27:45 -0400
Message-Id: <20250602142745.942568-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0018.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10133:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d75bca-b947-408f-7d8b-08dda1e1ab17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NgEvH9/arr8hUG3K1lKDWBrNK7nxygyzas2Pmi9J37dwBYsYiZ0OsCjG5jsR?=
 =?us-ascii?Q?qlI12rjHP6NXciWYYWcLUPzZ+vf0Ba0o/od/lIIJiyrNL41LXQS4qkDj3UCo?=
 =?us-ascii?Q?MN/32DK+G+g83sMIHfmE60UDZnnrcTQCo/iakHmFUunoRLGSxMP4iUGzrKLm?=
 =?us-ascii?Q?DUt6F7C2ncOcdUJBDO6kevuRbNJTcM5L8T8B10r+hcMtSg1qVyR/9XhAj85e?=
 =?us-ascii?Q?zVxiEGeZNaiEaAC/6sdh5YnWzvwd2fbZtQX3Qhu6UJK2RKC84MaREw3I2H94?=
 =?us-ascii?Q?kTP/dj8lsh5MyNjIrGntOqspuGYjANKWoq8Y5Gv49BzNat4VDVPShfyDKAfk?=
 =?us-ascii?Q?7nkgZth3ACw8IoBMhv0UZdleKy2MQOmrrmXPTsQtCvwx/Wruv1h39S18IG1v?=
 =?us-ascii?Q?DBI6oeEC26H1CP3jF2VXut6RIAxPeOXwyBsrq2ubcP3zGHRQi6QfBX064YIW?=
 =?us-ascii?Q?sKsHy088WHe6V/CkEcwPHA8WuxxgdPgKrrALfTAFBw28tNg1NuolWH94Zp81?=
 =?us-ascii?Q?xxYJIuoi0uNWORQN7RMv9UKk4O99N1Adj0rnhNRGnlR/MXh3FL1m+Ozsy+js?=
 =?us-ascii?Q?PcKiQ7pYHcqOwGnlE4E1lL3Wt/6SyxE749X+Pdp+CfoUF/fE6mqqBcJaqlWg?=
 =?us-ascii?Q?+KQRydkx8vwBmIxk4uDoz1dWC4W5V/4pP/NxXiItXSvaBVGS6PDxGCHKOcBm?=
 =?us-ascii?Q?1QTFHbRY2mX6YD7y4FlVdCmaTvEESohnD0DGPbG53FiHd0Ec9XuYWg+V6TYy?=
 =?us-ascii?Q?zau45DHzIPQ+ovWFn/9dOAfMCLfz4EUTqzqZ27ptmPg4vO89tG1SveArCNjg?=
 =?us-ascii?Q?VE8AaIcS9TE+6hU+Jlcf5Abjrm4XytefV0QnWHNwCNVTD6JLpOy4Hdrk0LNi?=
 =?us-ascii?Q?5gvdO96n0e7MeFKyZrJtIF8dO2xyh31yyfHESCZEJJe3tLCCvd5oH+7mhqIm?=
 =?us-ascii?Q?QCYMWOG0qCO8nYkAUe1a9pEOmOSx9FRwRpeUm4c6Y0in1oL7nFyYTzYVpKPp?=
 =?us-ascii?Q?Hz4kp8R5bOsSoUmxvhQdKZm83g2g7HrU1SGm8iMwCPPTpxlQqvifKU/WeFBQ?=
 =?us-ascii?Q?awVkBpAyztbYkHEZEWH5KTrhrTIi91H1xoj2Xx/74hNXeIpS4UeEmyTdF7H8?=
 =?us-ascii?Q?75ueQAEfaaF7/Nz1IhqBKw8ekGKs29gChIfHTe7XTJRksii4YqR76WPqpjcX?=
 =?us-ascii?Q?EJrv1qC71oFyzs5Vtp6TH30agxX7OPwW8Pxkm7xaUIX2N7TIolGHn1cSHcTF?=
 =?us-ascii?Q?PXLBan5Im4zuhIEkQOkWhRnlJ24BIU46xp6v1g25ruoEZ5QU3X/PdwXwmYf2?=
 =?us-ascii?Q?R/Fzh7W4qf2DgjjAlevnjcyRKbsPWVLSkEaM7+UicWsmKW5wExOFPXiIwD8W?=
 =?us-ascii?Q?yaPC7Jsu9RPkteTbZ0eZ7LS4ndwngOelmup0whF6m6Wt0oqhRBsRPrR9EmFy?=
 =?us-ascii?Q?rXBGJlSjJaoo0OPHiCPOAxRmrdHDOUs521nXuCdWHTezeiRgxsOr9rPsOIrh?=
 =?us-ascii?Q?vwVkRUxzfjKOnQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHO+vW7dzDuCl5DXFp4Xq8VkvWt8uHOqhQMuY/WzxnWEn6dTPq2auVySIg1O?=
 =?us-ascii?Q?emDrGLh52LMEutSwJ56sWwaZx7gWGv6Gc8l1CPrWV+7YBnWeqUY5VrHosbti?=
 =?us-ascii?Q?UjbkJsKHMLpEtrKY+dlII0i8bnUkdMAK/NsVayTDW33uIIRra4JtQLvoo4xK?=
 =?us-ascii?Q?yiLnoFn56aOudjyIY5WaNy/FT37myfQsGHLjZ9POPkKhRA7+VDFDn2I5TYCN?=
 =?us-ascii?Q?2bj4vN4gDOP/05nhTDKtiMWtp6ipyUhi2fFn3lqpFZt6Me8YGki0chQyZhpc?=
 =?us-ascii?Q?V3IcWKYj+0PjeHOCVGzi0vj2nFjfeKTzYtKKlx1v4VwRBd06enT010O2EC7Q?=
 =?us-ascii?Q?ckD+IJq7wurUCooF01dUWCpXxSKvjnuXCDx2As8HhERPXSXYAix/EK77cnvO?=
 =?us-ascii?Q?GBv7PNIRvOJ6cyfWmmo+572nZi/6XF8xLHaol7cph4W7DSFJNIY2XXW8XAlE?=
 =?us-ascii?Q?XKHgwJbKsN6idhRJEqbyHnK+cnNbtKVPJ/exC+qx8DdJCGRW720Fo0f2sK75?=
 =?us-ascii?Q?xwK4h2vgjyGooeZGJK197c4fcBpnquflJdvcJtiznFOzzrQxart4wbA2taFO?=
 =?us-ascii?Q?Rr/Ob65LE85IT8dY6HPt4MRTGO41g/BIP9MWyGaIhDDRLsKj+e0VdKBmiPEA?=
 =?us-ascii?Q?Tu82rxJJe8ATPzx5WY8q/wQgpWCEyNfwpp2cf4fx62lo3uU9xJEHiT5HtM6v?=
 =?us-ascii?Q?U1TQ7x24NM8iqKMFc0hEokNE2rvt64YWo1biat68mls4furEmHKVu5vHozLS?=
 =?us-ascii?Q?tLL0Sblqj8aT9OT1eGwEhGi4mTxiEo7IRFCNIU2Cu9nCEQR3oEzUPfjs1xQ1?=
 =?us-ascii?Q?psai6zw5a0qu/xmEMaGGhFSnFp1nuY948fsjN8p/UORH8nUClOfO1WhWSlwO?=
 =?us-ascii?Q?MANkIumEPClp0OFb0C761hcwcVzAeUxG32BKnqBSwN2+xLJOXFS6pioAkUG1?=
 =?us-ascii?Q?ykRzoDJFptf9KOg//oRdD2rqCP2xVfFS7nykEY1A2o+d2tnw3zo8FJpS/upd?=
 =?us-ascii?Q?X0RG7u47OKabkOx3O3ZNBr9Xuel/oX26EHqwjk6dN6etMnWkrRovKnBJhuZO?=
 =?us-ascii?Q?4qCGV2GrJ+p8iuhXrH8gMv6kdKOc2+8IRpXik2665dI/+aqZ+fgwhqohnHZP?=
 =?us-ascii?Q?HKTntasmBFd9b6mcMTqkZ2Woz//csAQG9eNSmAaHMl0BUU/f4ddwJe/r+xTr?=
 =?us-ascii?Q?0vd+2HzWhB47OYQmMr1cbb4zG2zE3V1OTQDlbN/5308+Mz8sY9ke9BmhFrKl?=
 =?us-ascii?Q?GOe8Twi1agaZNY5g4u7fha3oLkkaZbYV+EFl9aNG+1O/0oIdZ4KuB3kxMNfK?=
 =?us-ascii?Q?YTQE/uKnT6QLILH61Mh8RmG2Y9+8fsXTWZTPH6y2VTnhlpsCSA3cDdmqnwJK?=
 =?us-ascii?Q?s2stXyT645JjyVczdRhPWt1bb9hyXZb9FtK4WU9y0a8jdqtOS0I3CNX49Zyd?=
 =?us-ascii?Q?ThbsQYyY1nXxaToatu6fgPbZ6J6TcXCd+IzmCG+Zbhs1/3Uu09suIQglTZeT?=
 =?us-ascii?Q?yrOaXyJMe4W9GC3VRQvlGql0Y2yk/9SCV+jJJQaEFJUZNQF8Koh0exXPxaOs?=
 =?us-ascii?Q?QQodsdDnz0sbuad5ZauiLBKt3PRaOYHE5WoRR3al?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d75bca-b947-408f-7d8b-08dda1e1ab17
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:27:56.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /h1Bwt6wcsQaLIZp3pqla8fcQflbH/TRkSHt24HR1vlHstcKMGbyxkhFA5oY+LRDOqnYczo2S268SsxxyG2+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10133

Allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart to align existed
driver and dts. It is really old platform. Keep the same restriction for
others.

Allow dmas and dma-names property, which allow maxItems 4 because very old
platform (arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi) use duplicate "tx", "rx",
"tx", "rx" as dma-names.

Fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dtb: serial@40081000 (nxp,lpc1850-uart): clock-names: ['uartclk', 'reg'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 33d2016b65090..08b8d7c6df0fd 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -49,6 +49,24 @@ allOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,lpc1850-uart
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: uartclk
+            - const: reg
+    else:
+      properties:
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+
 properties:
   compatible:
     oneOf:
@@ -142,9 +160,22 @@ properties:
 
   clock-names:
     minItems: 1
-    items:
-      - const: core
-      - const: bus
+    maxItems: 2
+    oneOf:
+      - items:
+          - const: core
+          - const: bus
+      - items:
+          - const: uartclk
+          - const: reg
+
+  dmas:
+    minItems: 1
+    maxItems: 4
+
+  dma-names:
+    minItems: 1
+    maxItems: 4
 
   resets:
     maxItems: 1
@@ -237,7 +268,9 @@ if:
   properties:
     compatible:
       contains:
-        const: spacemit,k1-uart
+        enum:
+          - spacemit,k1-uart
+          - nxp,lpc1850-uart
 then:
   required: [clock-names]
   properties:
-- 
2.34.1

