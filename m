Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821B312825;
	Mon,  1 Jun 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309564; cv=fail; b=GYLo8ax6UItCJoo4HiJgWDPAafFMFTZmyuQmh9vj4eAEdbMbyu0sDGF+VMtrDyNWXBhXMxny1Gs+qK6YWVLpPzGnxU1Pq06sfmT345HCR60nfS9YIrfF3UGyXufAi0gjIIyBF9o587NRmEkLfzrdfw7umn+lCCZxRqREXxI4Ijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309564; c=relaxed/simple;
	bh=4hrr5g62tjOyk4dHhfr/ondB7yaoFBZzUjHT8BzMoRo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PM43kM4v3DlQMGYO8K3V2Sa2YGBvw++yOacBz+0jHqTo+Mk4FOQvYdpGxiK7vIpOe0kr0opi061YcVqXAgl3o7B3gJj0WFRmH/9sUBPeNFrjIJ/pYnqHRk5q0hyhxMu2PtyN2nBYC2slc8/e0QEvhnoBrxT7q8BoEde6rbYTl8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=kjkltweh; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="kjkltweh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyt7kDovVUcMuMxe2OvzlkXfbQuSKp1GyKO2pcdlspG2hJu8ZMVcF81z3tO4USgaY8/erj59CxnOEFtD5VE5cnY3eNzbpLf8ZVPYBL5bL4v92mLeDbdFipYqAV32kc6dcMtZ//VTUlSEOtw6t9IgvhRDvMCmt6x5DVPgfKiZ3KUXaQYuZYbs+dd9MCQD8YLk/wEhnzQcOucW0XHFgiqa2R63Kf2gg7JM07LEN6AXzTqIpMfYfCuwSPjhy1saJJp6f6UBIPiu2o6aPRqa4mRb2UdBwKbeHfBz1gFJUwlV8XQzNZA91t0tSZGoeNZ92aKrW/BxiLKSQ5RlZw+65Ne8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWE3yVKoBLGrS2Io8egiaNagFKaR0rpQ9NKWDf7oz9U=;
 b=g1d3e/kSuksYt70tgDwPvk4UbdEH4FvP3WUI2JNfxa/1QbHKm1kxWxwAWcVNnRz+NXaLmTaM4QvNIx2ZTOP3PopgG5bfm9SlWLXvoKa47qkhBefz0dLqXKOZfkYWvRLPCnIqO2bjoMg5Zp9cQWJwhK0p2+DXAD5rpS1QaTL3Lm64O4yAVc7JP6T01VwCGcwsJeNAHcLsG9KE9quRtp/16aoCtY4p9NlgDYBKjVvIzw1Ve/yXVXYbwsFrn9BCmjrRR1Y9DToyKjJ6/oFF0xpCKXCOUDDaz0pL4sCNdLeb1r2K3bY+Zi3v7r+4Qenegdot8fd7Yvzezb8dKx8Ph6yHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWE3yVKoBLGrS2Io8egiaNagFKaR0rpQ9NKWDf7oz9U=;
 b=kjkltweh3s7jfPIa1vGlxCW5QFRpiII2yko6BPIHnA71uLV9VKJRmw51rzgnJeygV9VoAvP4s7YZuJb/6wWfPE6TVLAMEgiC2SpRzuvEShru851OMYFZYu+6BP60C5k/g0peDOHh5tiQzmmXvLQq8F+VqwhMB490t9J7I5nxmzAnB/IUQLmxjCUrTDYz8mhfrqcIxcsb2JHHvzCeb4jvgYe+bvG31eMPDFdbOTimM4H6hV7fU5y4qKGjBmBLWTqhzeWfeGqM+YypR4jYMNsSXB+Hod6Gng397CHzb10/eAycwyNL6Oztc3mGmwLBtcCEBv4Tz6u+hqL5IqN8f7pL1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DUZPR06MB8775.eurprd06.prod.outlook.com (2603:10a6:10:4d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:25:43 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:25:43 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 01 Jun 2026 10:25:32 +0000
Subject: [PATCH v2 2/3] dt-bindings: serial: maxim,max310x: describe
 per-channel rs485 subnodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-max310x-rs485-dt-v2-2-a105105f8e70@vaisala.com>
References: <20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com>
In-Reply-To: <20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309541; l=4213;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=4hrr5g62tjOyk4dHhfr/ondB7yaoFBZzUjHT8BzMoRo=;
 b=SrJ+7qk9FxVcObvLQHgVpizTVUEyoqE1KgxgiLX/6IAcoBZ0zYWQTYBM+23js5YlX4SH1P+sW
 H9gSAtvhYpkCkYTIls7w8iAmI+tSoFRr2O2YUsocxW7s4aOSfno0EfJ
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F6F8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25c) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DUZPR06MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: d2774218-5b1d-4a72-fd74-08debfc82301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|22082099003|18002099003|3023799007|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	Nw3EyWKtrat1w1ceNv+pyLIYSQI8Yh+unmc7voNObmX7bzZ0vBGIwcU7InYX6kyRl6ekNVU0loFeJW4frP7eHjRJ4eMg1x3AS6NVjGUCuP6hokKHMwEdlJyaILUYJ25cnoZw1CssPYgjV4kLyDZBJENQzoYiOhPXy81CGhktFxScGU0wc7PoMw7Y+9A7nVmQpt3RBDIR65TOQyiGwqWPAArzr29hOxxnv9U9zaMFEmOrhj4S8urnXooJWKw3ZnDW1Kgl4QBO3HkZafi9Zqp4jJfy3FykXa9Ra16xlfkU+DIP7Apf/VJTcpUVuHxP71s2xIwHuTixmWfBnr57C2sMTL5EQWr07bYfQhTDzzDNK89deb2kKxjQUmukfHMb5vCx/+8mLU+bSDyz8UmInYViFFDS66xKEsZUozXMTORqKIdK7UxXzJupCvu4kAheXTbZQ5Nt60YF8vqivuZjqzHRzl6ocIgjc8fwBkqpH6VZHNs0IE8WvBDaKgPC+U/Y/XDhT+vc0V7eNeUT0nMUX1equRsszge1wez8NDfN9du6QhDQlWaXnASiIPwsVsWwcwZoVr3c7V2w58ku6CrgfYEIFeUXcfk7IVDwydlJsFdbyNfdzZirLXALbbAoi/IfK7ehFqngL52SR2/O+53t3XSEjl6I3Ts8x3G3KMJiMHgSrJqoZuYE60E9jPBf1VTOkmY1ntuG4PtDHIW/fd7rTmiEojhzxsJJNFJ9W4iaU6t2lbMmd54t3N9TxlFurxjCFjqh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SERhT1NLYlF6YUl0dUxnelpvd0RNbzh6T2lJc2xkYkV0NDl2RWZmYWdycWNv?=
 =?utf-8?B?eUJVYi9lbjI0b0VHV1RZbmhUZ1duQWtGa2J6T1lQbGxIc3JoUW1WRUNMMzJG?=
 =?utf-8?B?K1d6WmsySWc5bGREZ0JVL0ZIUUxIWmVBNmJodm5UVkN2Y3k0Y1dGNkhGNEpU?=
 =?utf-8?B?bE9MMXlVSTVKQUt0U1psT3FTQVIybzlXTzdEYjJQTXU1dTZaQ2VYL2c3dU5a?=
 =?utf-8?B?clVXbVNKR1RxdUpkY3BPT3ZQcXZQVXU5OE1lYzJSckE5MnFBSjF1UWZLYkUv?=
 =?utf-8?B?cjRoUlgxTXRrRmthZ2pJd3V6UnhxbFFoR0ExbCtZUFc1RDlNcmRhODFPQVhU?=
 =?utf-8?B?SnpYbHgraFk5eHJIZmVXeFlDSm5wcHQwZ1JESGt3VVdPR0RhUERpRFdpei9l?=
 =?utf-8?B?dHhIMVpqT1cwbzZqK2dZamN2MFFvdmhiR2xicFpqQnpKcTlNL2tqZ2ZxVlBW?=
 =?utf-8?B?RDJORGtsdml3OUJoditkTWV3VFFFc0NCNTRQNTRsWEd0UitUdGpmYjNqcjF4?=
 =?utf-8?B?TzNuMGF2VWtnYVRKNUV5cjg3U1MxTU9JTW9QUjhLYTB1eCsvSG5qbHBNQzBL?=
 =?utf-8?B?Sm9Uc04vbVJTZHpURGVlTjdWcWR2bVY0TFA1akNoZzd5R1dtMHl0UlM3UzNT?=
 =?utf-8?B?QmhCN3YrTEY3TnErQXlmdmpid3o4eG9td3d4RWdKeWtVWmkwMWZkOC94NFBI?=
 =?utf-8?B?ajZrcTdXVzJVS0hpYnpjYklIREJXTzRvRE5XaVBkWHlDOEdaZThRM21rWkQ5?=
 =?utf-8?B?aUxJYW5sRndtb3ZiR3Y4dXFqREtSaWNYRDdQV3BvM2NuTm1YU3c5RmM1NW9B?=
 =?utf-8?B?c1dNazFqamNCQkF1R1kvOTlCRTFjSHMrWXJEc0ZaOHBudThpUDJtNU5HVkxH?=
 =?utf-8?B?d2R6cmx0RDhrU2pMVjkyYlNyTG5USVBYME4rWVdYZE05ZFVVUTRGUWorMUZa?=
 =?utf-8?B?WEV5V3YwWGh3ZktveTE1RW0ydEd0T0taYnJiWkNYTWJUQm95c3h0N09NckRT?=
 =?utf-8?B?RGhPSEh4YlB5WGxOWTZWMXF2WmRPaytVdlUrdU5HanFub1gxRWRrZGtRRldt?=
 =?utf-8?B?ZXRSamFxUFArOE4zS2ZNQ3MzeHg3S2dHcXMxelpSN3pwcHlwN0Z1MENmRkZp?=
 =?utf-8?B?VldhMzlVR2t5L21EdFR4c1N1bmNxZ0dwVXhYdWdxYkF1emdrZ1oxSTBtSEJD?=
 =?utf-8?B?Sm4xcVpTWXZyTXZCM2JoMy81VFI2S01IL2d5eTdwQzl2OXJkNkl2S0w3blgx?=
 =?utf-8?B?c3djQzR2R0syVGpNNTRqbE5NQnFtV3Azeit0UlNGN1dQSGgySVJiYzB4N213?=
 =?utf-8?B?WHlCY2xMR3d2OWg1RDRIWjl2cEd4NDRRQTRKSWJFWDhWS2FnQVdBRDZ6Zy9T?=
 =?utf-8?B?REZlOENUMkk2SWc1L0JYYUp3RDFVV0dkemlmNTJ3SVdEUlJ0WFIvNzdQWkdx?=
 =?utf-8?B?VmlaWXUwTVpDemJSV1NKNFdvVXpxUnV2S1BKVUNOM05FTmtGNFMyYm9nVnFh?=
 =?utf-8?B?VEF1Q3EvY3BWK0hMVHppNXBHQ1F2Y1RLcmhBMUpZUDgzOHFsV1lIYUw2ZGtY?=
 =?utf-8?B?STFwSExpbFdhVkxXcU5KaFVtMDNkaEdmcFQxbmpQTWVtLzN3UUtSYzNCMDY2?=
 =?utf-8?B?UUlpQWYya1dHRVFTM2s0RjhUeEZEdWtBRkJKazlkck9IMEozWDNwbXA1MG1G?=
 =?utf-8?B?NEFPSkNzWmV3RzM3QmM2T1QzMnl4YnFXK1ZhRmcwdStxM2ZJam5lOGVqWDlH?=
 =?utf-8?B?OFY3TC9qNlJuaUNXR2RINnFsMC9wQTlDbVFvWU4ydDlGaXFPV3E1U0V2MUdm?=
 =?utf-8?B?ZG03SExXTUppWk9jMENicHlhRVNZdWVsNHIwMVBJczBJRGsyeG8yeGNKenRW?=
 =?utf-8?B?cUdCUFBjSzlBRkpQUUFHYmhIaXErZFBnN0VmeUxkMCs4b0RXQlVZMWFhNDY0?=
 =?utf-8?B?L25qNXV3VG1LNTRVWTNvWENjNEc1V0FXSG8wbTRxbW9LKzRFZVo5QzFXcE44?=
 =?utf-8?B?cWZtaW5IbVU2UmY5WExlVmpHV01ZSGR5ZElNSVRHUkFHcHRkc3BrdjBjdU9F?=
 =?utf-8?B?bjBMMW41bHh6QmVUeWNBQTZBc1p1bnZhQWs0OXdoSExUV3NiODdsYTdqcUFN?=
 =?utf-8?B?djF1R3NBZGxLSXFCSFFRV3VMM3p4RE5Hb0xLaHl0bFBDMG5QcURiaTVueDc3?=
 =?utf-8?B?Y2JydW9GYmVweTNyaU8wTlJJOGRkQi9tUjE0ZmZZWmgxRmZHckJkY0tMZXFj?=
 =?utf-8?B?MkF3WmV5ZEZlekhIMXAraUY4WjZ1OWFTTytod2p0MjdJZEVuQnpYcytWaW4x?=
 =?utf-8?B?R0IvOHo2Mk5oMDAxd3dnM1NzMWp2VjNlUlllUXZUbGJSbjg1UURRNDZCTVNZ?=
 =?utf-8?Q?ZOHA5W+kX3kPdNSI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2774218-5b1d-4a72-fd74-08debfc82301
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:25:43.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkZscQ9IUz/I6+UL3cIVnBWiFNnUMoESK0/pSl+79PwN+IDLERe/QXiNNgTVk/1zxDV4U/i/GcOr2HbiwR9baUVLwKyuzWRotsG3WveGT/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8775

The MAX310x is a family of one- (max3107, max3108), two- (max3109) and
four-channel (max14830) UARTs. The binding pulls in
/schemas/serial/rs485.yaml at the chip level, describing a single set of
RS-485 properties - enough for the single-channel parts, but a
multi-channel chip can wire RS-485 differently on each channel.

Describe each channel as a "serial@N" subnode. Being a serial node (per
serial.yaml) the channel carries the standard rs485.yaml properties and
may also host a serial slave device. Constrain the channels per
compatible: max3107 and max3108 have none and keep RS-485 on the chip
node, max3109 has channels 0-1, and max14830 has 0-3. Chip-level rs485
properties remain accepted and are the only form for the single-channel
parts.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 .../devicetree/bindings/serial/maxim,max310x.yaml  | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
index 889eeaca64a027b4d9e8ec87bcf63fcc8fd9d55b..988864e7957416caea2d86c38957a894ce57c6fb 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
@@ -40,6 +40,36 @@ properties:
     minItems: 1
     maxItems: 16
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^serial@[0-3]$":
+    type: object
+    description:
+      A single UART channel of a multi-channel variant. Describe the
+      channel's RS-485 wiring here with the standard properties from
+      /schemas/serial/rs485.yaml#; being a serial node, the channel may
+      also host a serial slave device. Single-channel variants have no
+      such subnode - their settings stay on the chip node.
+
+    allOf:
+      - $ref: /schemas/serial/serial.yaml#
+      - $ref: /schemas/serial/rs485.yaml#
+
+    properties:
+      reg:
+        description: UART channel number on the chip.
+        maximum: 3
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -52,6 +82,32 @@ allOf:
   - $ref: /schemas/serial/serial.yaml#
   - $ref: /schemas/serial/rs485.yaml#
 
+  # max3107 and max3108 are single-channel parts: there are no
+  # addressable channel subnodes, so RS-485 stays on the chip node.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max3107
+              - maxim,max3108
+    then:
+      properties:
+        "#address-cells": false
+        "#size-cells": false
+      patternProperties:
+        "^serial@[0-3]$": false
+
+  # max3109 has two UART channels: 0 and 1.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max3109
+    then:
+      patternProperties:
+        "^serial@[23]$": false
+
 unevaluatedProperties: false
 
 examples:
@@ -70,5 +126,39 @@ examples:
             interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
             gpio-controller;
             #gpio-cells = <2>;
+            rs485-rts-active-low;
+            linux,rs485-enabled-at-boot-time;
+        };
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        serial@0 {
+            compatible = "maxim,max14830";
+            reg = <0>;
+            spi-max-frequency = <26000000>;
+            clocks = <&xtal4m>;
+            clock-names = "xtal";
+            interrupt-parent = <&gpio3>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            gpio-controller;
+            #gpio-cells = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            serial@0 {
+                reg = <0>;
+                rs485-rts-active-low;
+                linux,rs485-enabled-at-boot-time;
+            };
+
+            serial@2 {
+                reg = <2>;
+                rs485-rts-active-low;
+            };
         };
     };

-- 
2.47.3

