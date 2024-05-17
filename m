Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803714A8D;
	Fri, 17 May 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927613; cv=fail; b=U0xvQTZHrY/IEDBh/Jqv7C+nCc5czC3Xm3baar4gfuuVALf8HdNSXzoGSUGJqZ43frfWQRGnKNgrbmVFDKeLJ0d03a1EU5wr4Z57pDz5YF4BKbDBXqA5OS4jblZc91IG1wJCwaDGPBmxOugg1RtO8uvHqKVpSkW9xu9QHGAQW6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927613; c=relaxed/simple;
	bh=jZ1ztcx+2/OLIQ/umOI+WGE2LFrwSZY4s6bMGVmqcQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxJBN1CEfOJa3vT+/DL5Ri8ZRzwJBibSh7NOhoK/25DBaaJ7wflLOumqSA0BT6EivzTZ+sm70kUd+Ni4XKq8hTiPu1S9Ip76CrWmXjKvAscEZfCUY3/QHzjUp8UdrXKdpof4PDKos2VZftG9/KOJ/hEma8u8pdgJtjoODNmdq10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obvvncvqV4to1mD9KlDR+Dn2BodOQexcBdBY2G0aIWdGpI7I+I/7nVs7yhueMzFAATonNQkb1gR25U0uFrnd4BR9J29HrrRuw1I9kADz85Qwy1V+upjlSlahHI/iORQe7+dJd2c3MTtb4WnUdNltZ0Tsg3Sf5teCyoGbNbXKE1rC8IoAdwsWQ2UPJg5POxRf325484SO8SSyWhljyKMQ2SCBOe0UZQkV8+cOvKS7iETzh+7+rcar9jmFnweyRs/ipv6xcwHgKZeZgW/40YpjTFWuxHQRxkCgD4bfYuhronNnW1yI8klRhY2LoQ8buPsnFr0ZBZP05wNPgPELyg8MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6x/VoBMpqInPKkxtbaXfZMRYiwiU5924jOXmOcVaY=;
 b=K/3HzueQpoXqdfT46IIH7fMUSUDO8ASr/fKXp7pnCWdcZMRZofLOhqNTZMoXe0I51QkbvjwN0RtqyLaOTlcocWoooJ1weybgaM0gPVxH+duL/ZMjkqzctv2VBuz+36sc3vBwAXjpbF8u3mxKMdWNLD8uVyM1MDijrUd2emyFIg/y4OmOkrSj+rKNKCF+FwYC3UoU8S2xYrFcv6AGqXJr5t4zS6TkSQBMIoHFCWc8ENI/mMxAllnF/dp2hNipOjjRis/RVmcUimzDUAa3o3ewtKnZtb2JxA1+oOPnnGVQZNRoPji3vSbV6CFme8NAVgvF4r+Q+Tc5gCxPAbUNQlliFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 17 May
 2024 06:17:21 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Fri, 17 May 2024
 06:17:21 +0000
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
Subject: [PATCH v1 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one more reset signal for StarFive JH7110 SoC
Date: Fri, 17 May 2024 14:17:11 +0800
Message-ID: <20240517061713.95803-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240517061713.95803-1-hal.feng@starfivetech.com>
References: <20240517061713.95803-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e2fd66-11c2-4aee-7123-08dc76390325
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QJvU46QM/PrShUnkJaBBmMqYFLzEXPH7GAtfpiJWu7Qt7sAKUflg+0V0fpytrfsbKpgDAIyZl/nfmMdKG7mOQmL0WwFH4EWfV2TTXdyOYO7OLtByZFNQfIbGkgSto6MXt+ihb38amI2gzsWfJWBroKfwgajyJSqM6SDauReivSGtFXVQtcqfG1NKPta9zZa5lDgPghkM7lPwZYqE0OO/1GThJU1SzIzpUf+SWl87pXOOZY1PQOtTio5BZEKa8rV6xKSHR4zesvh75mbxWA47DuGtqPvLXd00EQReOa4gV9qPjnJFELV8wGhRu7pk7bcKctwdezj6CZE09CVBxD9DtstIxqymCgER4Ttb3SUOSpbXJ5aqVnaHHQT8QgR3RRq/savy3p3lVggFFsx5ZB36z4hL5Ii+eHR2gblmTJ1T+GnqEUGpbuu7/s8KEurpssX/m1/EZXNr7DkX8sPjwaiLThungAn06v0mrVqsGLArIjBSAPQIwX2ZKNpRr9ijkhNp2yX7ZGeiQewD9QxBdklf9DzJxH1cS4vXISMpvYKDNPXa/ydg/YV33u5fxR2TbG+oIIVajs4A3i++i3nOFj9Wx6KFp2NVAyfGV6pROmPMTmljwjMZmX4fUPzDqc8IBhDxVsqy6Sxu0vlL3u0d/244Bw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tu6E3Lrl4DAAEfdGKllE44DlCZr8xCSbc9t+m/vu/x1H41/Wr54rhUBq7wWz?=
 =?us-ascii?Q?aHCfOPskfzg+zydHXzuxzPnoazvhNpCLuQ4llpQqUwX2w0N6IGoCS6feD/Cd?=
 =?us-ascii?Q?xRinKiq6M/xJUPiN5v9V3DkXH1PVBuyqvH4rkMKdtexy9QbWpY54DyYCQFyf?=
 =?us-ascii?Q?ND1IAQsg6EvBZ7NmO398TX81yl0IAijBCGc89P9cHtKJ9k8g5oBeFbQGIMxz?=
 =?us-ascii?Q?DFunYQZl80gS6jJ7D1+CqnmDUPpCJ6PXi+vvmdYqtMYDNly/XK3GTGCqDgpZ?=
 =?us-ascii?Q?huXF41Sk99tdkg/5gCuefNc1Ka05pCz0nIZ2LVfj+1Ej5nkzq0oL+zcRIbQS?=
 =?us-ascii?Q?j0qOuzzlO1zwQwBzFpQBQ6ivcqqSw/GNtImaFatvanzqMkRx481eHstE2LHn?=
 =?us-ascii?Q?zq9+8bW1/pkR/4t91vU6Lv1M8Z5JT5I2mgy9e2oqaQ26FNux3jjLlRHCo8pp?=
 =?us-ascii?Q?sy7Fu2Z7xT0xAOBUPEfkmWnL+tBeXnaiDdEDPfraszV4MKcBUeIsvgTgG7Tl?=
 =?us-ascii?Q?CGtwSvIZAvviZybTIMGU9hNaMgaSAgEUNk4OjnbyQ5whRMcpD8l530Cb7i6d?=
 =?us-ascii?Q?5HrkPiqpVQX93LpI7tXhh6kVv/CEOwALd6J88iy636jACsmk7T8C6BrkvX0c?=
 =?us-ascii?Q?WKsPD/QsRr9l825cH08IkVGpA+axoX7sCB6JkhRvs5zqcSvw9cTZf9J7jpK5?=
 =?us-ascii?Q?ygIgzZKpHDHl6sU7SqLDuY3U3mGCMD+ADkDBkw2DhxmC22gzjE6t4cOWHniQ?=
 =?us-ascii?Q?n7m2FzahNUve3Yeo9UwpSnLIFxGXzi/yLqDMc4EX4/nFW02u7QGq5DXU+q71?=
 =?us-ascii?Q?eS8L947tPUnWYdW+C4b2aAL0f/ce+arwxqaOg5ywyZehiOiwNSjUOUXQpkPK?=
 =?us-ascii?Q?qrSRgK3scQl85npzBI1Mv61vPnO8r1A+yzj2FlvuHAXBY33+EQybaWN1QPfJ?=
 =?us-ascii?Q?7P4lSh2oQBS7zugTX1Yd/MTvomzwpJ3ZEgAHh3XG1MNu07F9Zz+RE78NP4p1?=
 =?us-ascii?Q?on6I/zP29zfsN1A3sRYbpnPV2UoDwRwpl68wBHWDrAIMDWnocqG1HOJKw3WC?=
 =?us-ascii?Q?LkkOnIfe3EFj88hu3gcXeiWHlvGP8V0c/v9RaeOns8c3z9/dyd3isF+cEsTh?=
 =?us-ascii?Q?ITk2iKGNFdJXIxTKXg5opzxWNQ4pTMER/AbF60I7QaWjyL8hy7/UT2eM3fHS?=
 =?us-ascii?Q?35fguPnPUpHdOq5ffwOp5J0ith1p86Me1NOJsVvC2VMCuwTInMMgoHL9KZJO?=
 =?us-ascii?Q?/sDm/SUxx4b7sMHp8/AzLh+ATgb7ubHasEW6rCJNzCf6u5q0mxqH0glabua6?=
 =?us-ascii?Q?A/++Ml9fRyctOn6tGF7Ul5Gyg2uYcM/1TKkVw5qzja4P2qbTz0pJPU1wxvUR?=
 =?us-ascii?Q?O2aflCqAq7jzcFBbzsfbxGBkcd4Vk8CtGrMEJVcXzWDbAgKuNRUs31ivsVYh?=
 =?us-ascii?Q?IrmxDhwjsXK0tycdXrDKbYN0/37anHx/WAEsPZV/Ewv7Wk8vwme5ch/NLlWZ?=
 =?us-ascii?Q?H3DCoIp6sb1R4WGubJQaXUcAQwkgHLmpp2jJJF4/IH9aKr3JDBMUTsoVBI4H?=
 =?us-ascii?Q?hRdVZyXBohZGzzHM4+oXFkSfiBMExp/js2S1S3NM0FIsed0m2rjwdJ6dxEru?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e2fd66-11c2-4aee-7123-08dc76390325
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 06:17:21.9056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxv6BNre2BjkiX1InU8+0nh1WpKXeU9ZIsAAlEjWeRErPrwx+7IiUEus0kZr7RmuQ45p84saIFBO952vDjtz5W9eL/Q2CIUKGC9CNbe5f2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

The UART of StarFive JH7110 has two reset signals.
Both of them are necessary for JH7110 to initialize UART.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../bindings/serial/snps-dw-apb-uart.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 1001d2a6ace8..a6396c5cbfb1 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -13,6 +13,16 @@ allOf:
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
+
 properties:
   compatible:
     oneOf:
@@ -48,6 +58,7 @@ properties:
           - enum:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
+              - starfive,jh7110-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 
@@ -82,7 +93,8 @@ properties:
     type: boolean
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reg-shift: true
 
-- 
2.43.2

