Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0D2FFF8D;
	Mon, 15 Jun 2026 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519277; cv=fail; b=HKXieDeLfhLYq/h3CmgVrPCVMAcD82zMZEv2AIJ/2vgmGZeaTMZF7/Nu5pSPS7GoFiv5BSgXLEshSI9yxkl/QX8TVWDYyjhwmWKKfFIGRhj8IawY1j8+GHv642FL208d20JP3B6Uf6KCSQQqpte5nz4tx82UrBmbnWEL/ZCqOzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519277; c=relaxed/simple;
	bh=V9CeCauJF3f4uEDGm+hN0bF7hqyMDh3yMX2uZeK37ME=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=g+5kYWNEL3RhARZZ4JFw/7nkB8yEgpL74gb+a9RZg+CNEpixkzZCk1OPPnOgb+8b8dZGJy26LAZ4owss3eE6Qj2okfnEyFd4gfvwMW5BCVwN8FA+SAXS6GkR5Agxd1HH5YztJ1w11VPibaWQr3RGty0qAfeZog7q0usgQ17L9do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=F8WG9NgO; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="F8WG9NgO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBXtZHe9P3D//VLRc9+DSO+6eSscns4qUzSqFG+kDqGafB/sH2T1nQQJp73INZlQVz9gC7RstSSRHFU7B3dL6ambBec5UUabWCR4MtJdkeivlB4JFdGn/FjhjQRjFdnFSEPOL0Kzy+eJrCsmIieOf3Wka16ATbw0gnwj+E0gAbO6rbwp5v6wI4viiW7ZBv2RodAr4N5GSrckZuxDp/7TIvgEutsUk1wSBc5ZanyetobEJ2lVpA/vFtxTwPiS2pIekw67xhbnQhqikPPE4lFMZOCCJurmqMwkMBy0Q2Tr8C/kqI6forvL8RRSHbfGyYfuuXF2TobqHThN1xjfX2jsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KEkYQDb15Lsqifgf4qJhELR7RTz61Y70z7wTXrzep8=;
 b=bujEwR37S4U+obNqGk8v1bWvDSMs2aXrq5oXYUKX7WaltZI2OxV7jcfsficoX5lhwcIwCAj/mihuvjEwcJOmv5Xz1eEUko9b7q3jMdF/Bo1rQqer3OitgJ6Sk/rRt3k4QKVWSAnMrBT9F1t8HkK2aNEyksjFLrjHJyjAaXHxj+qO4imBfAjwPHA+LLYPQCa7ni875aLR1ZvRBjkACljiUoR04C+0U6QuQz0TizdCS2Skg28KpP781hW2leUotXLV5hDcdBtNPWETqo11LKUuFBNd79fnJCRcTC+m7hWeneZu/OeCTw+29JJy5MnIdFH5kG1vQDn01fgJEUZywO51+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KEkYQDb15Lsqifgf4qJhELR7RTz61Y70z7wTXrzep8=;
 b=F8WG9NgOhqpzWg5uktRehItD3ZZEuj4NBpO+E93iB97pRnVoucfdNgb8xUIzTom6WrgX12u/a3vnKp09du5msTZCYGyyZQCyVXMyxqX5eZw3dN8T89XRUeFCafXRQ6Kt2ZaLGXLsLRm9PagxZRTr2yxVE9rJUjvw8L/OcOtbcZAPQNZDRzgiV99vTnS6hQ9l63hyZzcayYQ+DxYkJcoQd3kZ6xQs/ZPOyZ1IOc5ypegZI+jMloFT53C9WEWI1JLHWno2UIZr4n6zMEz+sg38Y/vCckHX4by97YK2tm5ov8A9rBNd957hAlgdldiPORWjVhi2wk5hsXAEyEwbjbuObQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB8005.eurprd06.prod.outlook.com (2603:10a6:20b:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:27:46 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:27:46 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 15 Jun 2026 10:27:36 +0000
Subject: [PATCH v3 2/3] dt-bindings: serial: maxim,max310x: describe
 per-channel rs485 subnodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-max310x-rs485-dt-v3-2-7e79f064bdd7@vaisala.com>
References: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
In-Reply-To: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781519263; l=4745;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=V9CeCauJF3f4uEDGm+hN0bF7hqyMDh3yMX2uZeK37ME=;
 b=l9JTN44QFFg1RyJje+RpLG5Ho/3VRdTsfpZXokSs24iTP0CiHThy6ahyVhOpfHqyGCzEA8LPD
 OelH+PcAQ28CRid/FwH//QPaGc4A8IgQf1iThiq4uqDubyuhUeuSHhH
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F72F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2cf) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1b4e17-fe0a-4c98-a8c8-08decac8bd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|3023799007|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R9swuv9OOAPeJMVR1dEMe37K+p9eMIcgX779lZWsmi/9R8Jew6Tmogfm3MkW1NMK7/YjWdn+AYiiA1zIuw40mwoOytZ2ZO2ocjft3+qjL85PeNLiuwl+AwgC45DgpEax8iJV504ezht8BKuWctgEsAkMVZVbdx1ERg9oNzH8DcCv5v5OJPoXCS3Px7NVZo+xAkmPBQJvz+1QQ2ySPGgQP2JC3SHArpdttYXzYKejcUl/0b5yO2aHFAvz9slHawGgQL5IxZxAMCvHnJCli757AKo8nCtStlTrHd/ST96v5fdE3T5MmLKjdzPWMsRE6PAFVfQk1e1a/5U9hdB1oWjJGk0U/QIb6jEA+LbhmT2SoOdHdKr7rQOE0ShNztW+vxGBp+ymLfVSj7VVq0xyziRt1jZl94XRqKqosRPsDPBkAwxVJTSPVBLEtJ2w515x+EAJ7hkRVM/MNbE2OGhtpOO9t3k2yiU7eBjPpxBI5T7GV13FWw5g+Ipe9MpBD96QZDI9kdXbFX4/SKE9YdO6njMkQNtDhxZ845HKhpOUyfjs7DCp7swr6SZDLKvxjXJyyBoiolwxwJFnyO5915FrMb78n/CvuDHHKFCK/gMCtpFiqFWPmvD2v4lSv0uSJQPGmX6YySLVBNhgDMs+kX1SF7Y8KgiCzl0pcx2gWq9q3etmYMI/WBYRG/cCRqQ/Cv9eUM/A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(3023799007)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW9jamxXcVZPdjJWbUtvanFkL2ViN0ZvdUh2WGZ5dG1nYi9NMWp5ckMvTkts?=
 =?utf-8?B?eStwZUlSU1o0TzZveFFwR2NhUlBjOW9sdWZLTU5vQ0dBUW9ma2N3Ti9lRy95?=
 =?utf-8?B?UGFtN09LS2xiWnhEd25SZnhleVR0anUydnE2UHdXUmYzT2YrdXNhWitOQWJ1?=
 =?utf-8?B?MWx6SDFLZDg4MlRWT3RLaW5VYnJJWHA2MjVBMzB4YkhDY1g4LzJ3amdWbHBm?=
 =?utf-8?B?QTE2UGJtZ3BUZ1FhTktOWG9MdUZTck1wSDJGTnUxNlZvTFlheUpKMld3b0Fq?=
 =?utf-8?B?RGxtZ3A5dC8vK3BKVCtTa2RCRko5M05iT2xLaVQ4QWdlaENyTU56TVAyWmMz?=
 =?utf-8?B?b2Q2K0kvZWd0RStRU2J1WVVzR0ZjMFlxSG83UEJJT0pyT200SGZQRmlRTlQ2?=
 =?utf-8?B?YjZxbE84QitzRzlhZndnbE9DcDRuWmZLKzNqSlJLbVZFK2xJMGNzTStJMW1i?=
 =?utf-8?B?cHdGYXBzUFlNK0R2dk9kaVpzOVBnVTFveTZhUHcyUUo2R1dLKytYZW1qQ1JK?=
 =?utf-8?B?dXBtQkVtaHZ5M2l1a0dXQVcvMmRhSXRaUURnSFNxN1NPamxjL0NZNjdhYVNR?=
 =?utf-8?B?dTZHb094dXFOTzhpc2wyYWExZW1ISHp3eFlTN0EwV3pMOCtFV0hFcStPaFJs?=
 =?utf-8?B?WVBURkxkUmF6V3MxQkRWdmcrajRvaWgwakR1eTF3akxYREtFU0tuOGpGV0Ry?=
 =?utf-8?B?ZGFxQzZidEh4WHhJZlBvYWhHbjJGM2pxTUNzVXlHYVhYdGpYV052REN3dmhN?=
 =?utf-8?B?eVY4QWRJTldseVd1ME5ZNWN0RkZvdEx6OHArUmZML3M4dnF5aW1RemtmL0pH?=
 =?utf-8?B?RDVESTRzaWwwQ3FwQmF3SHVpaTdQeTVSejlqbEdibXBzNFlWTnlSUTdOMzJF?=
 =?utf-8?B?bEE0M2dxUzhPOGhqbGlDc0tkVHhmWnVVZW1VTTRvVDBxUlVHREp0djc5MFdm?=
 =?utf-8?B?STQwallmSXZHWmVKTlFVeGFXemhCWjJaOHlaVFJiZWtsV3JROERNOFFIck4z?=
 =?utf-8?B?enBEYVZLcEJPWXBvUFdsRXgzVmgzWmZScURYNmhlOUVWdHdzMjRqR1kvVXY1?=
 =?utf-8?B?Wmw4OWRoM0lsbjN0bTRUS3hqSjBtQ1NGajN6YXpuNHhJaXgrOE1JcDRlelJJ?=
 =?utf-8?B?RlNwcVRXdTFlRUpjZmdvQVlZYzBnNlFlUFJrUXA3MmFkYmRUTm5tZUJ0YUgx?=
 =?utf-8?B?SVVNejRFNEx2RUM2MWZOM3lJZTltbHQvZnlPZXJPUkhOdnhza21oMWFMdzRv?=
 =?utf-8?B?cGRlS3BCeStOSzVYQ3FqRnZEV29zUGtVelRGeFlNRHIxaFNoRU5SMXlEMWg1?=
 =?utf-8?B?MVhpWXhhZ1RpOXVYc01ITmpLN0YwRnJkK28xbFFVdmpxZFQ3eUM0Zm9GYWhK?=
 =?utf-8?B?Z1BSL1hvNzJhNU5RYXBKK21kV2MzWWdXY2V3TGF2YXRiUS9qTDltb011ZmVC?=
 =?utf-8?B?dHpxd01uVGhhSEp4RGNkbjJ5Y1VHbVBjL0dtRmtMd1ZQZldFOHI5MHNweWQv?=
 =?utf-8?B?aWpzYURJdUZMYkVYNHB5OEZFenNXcUVTS1dmOUN3NGJSQWJOMExPa1p0UlNC?=
 =?utf-8?B?VzZJWVM5UnJ5bElLbW9QV3E4NTEzU05WVVJJVTB0S0NicFVBM2xWWmttVWo2?=
 =?utf-8?B?RW1Mdjlua0NCVS93ZUpJZFBYVDdmR3o0R0RmdSt1OWlXamVOaFFMVVN5WXdw?=
 =?utf-8?B?VU9PUGI4cWJUQXRzU3VZajB1RUlzc25sbnF0T2lrOXZjUURua0szOGFVMllQ?=
 =?utf-8?B?clVzby9UOVhtWGlQaWJUKzYxOGVLSm9HbnJkTGVFcGJTb0RHZmd3VmxLUW9W?=
 =?utf-8?B?R0dlZExQWktlZ05RbVV3NzZ2MUJQa005Sy9PRE00ZG1DdU8yNGw3NVFMSWx3?=
 =?utf-8?B?L2RUSFV4N0drNWN6Z3J0MzlscFB4c1NsZFBMUElyYit0cURQNjZEazYwNlp4?=
 =?utf-8?B?ODFIS3BUUWhkK09YbVBzT3E0ejNRSElmMzVJRGs5Z1hYNk5DMVBzSGxWdWNr?=
 =?utf-8?B?czI0eXQzTmNUUEU3YVIyM1hEMDM5V0J3UitUcTVLS1JzTXdEKzY5OXJBbnJr?=
 =?utf-8?B?UDZXUFc3dC9qUHgwRExiMW5DUXNOSHhhL0s1NTNuT2JmUHIxTlNsbEo0c3kv?=
 =?utf-8?B?bmkzR3lRMFYzYWNjdWZyNUhGajZMbHM3cmt4TmUrMlpRSzNKckNncTh6SmZv?=
 =?utf-8?B?REJERkt5bnJrQVMza3lwUVJ2anpDU0JaMllzOVg4VXBQU05uYUNIdlBLdDNR?=
 =?utf-8?B?NHdJdFl4T0N4RVJzaERHMlVFWmxOWENVZUgrR09xK1pmTG0xRGM1VDBJT2w3?=
 =?utf-8?B?ZC9nWDJjUGJnTXdFOHhHU0VtdVNBK09CKzlnQ2ZHOXhhbTBmenRTZXBYelY0?=
 =?utf-8?Q?nLhuP7e5WVb2AuzY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1b4e17-fe0a-4c98-a8c8-08decac8bd9b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:27:45.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3GfOMxQhV8gDt3UHH3VzHEnruDhY3qW7TudTgsW+vpuJ3x4K8YdRjCd0/0IpedeidrUNh8sBYbRjrrB/X3qJCGi9iZi5Kl+yWfvhCXatdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8005

The MAX310x is a family of one- (max3107, max3108), two- (max3109) and
four-channel (max14830) UARTs. The binding pulls in
/schemas/serial/rs485.yaml at the chip level, describing a single set of
RS-485 properties - enough for the single-channel parts, but a
multi-channel chip can wire RS-485 differently on each channel.

Split the binding per compatible:

 - single-channel parts (max3107, max3108): the chip node is itself the
   serial port and carries the RS-485 properties, as before;

 - multi-channel parts (max3109, max14830): the chip node is only a
   container and is no longer a serial node; each channel is a "serial@N"
   subnode that carries the standard serial.yaml/rs485.yaml properties
   (and may host a serial slave device). max3109 has channels 0-1,
   max14830 has 0-3.

This avoids a chip node that is simultaneously a serial node and the
parent of serial nodes. The driver still reads chip-level RS-485 for
single-channel and legacy device trees, so existing users are unaffected.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 .../devicetree/bindings/serial/maxim,max310x.yaml  | 92 +++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
index 889eeaca64a027b4d9e8ec87bcf63fcc8fd9d55b..e598dda4d13f514820ed8012f2fb2fc2aba3e669 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
@@ -9,6 +9,13 @@ title: Maxim MAX310X Advanced Universal Asynchronous Receiver-Transmitter (UART)
 maintainers:
   - Hugo Villeneuve <hvilleneuve@dimonoff.com>
 
+description:
+  The MAX310X is a family of SPI/I2C UARTs with one (max3107, max3108),
+  two (max3109) or four (max14830) channels. Single-channel parts are
+  described as a serial node with RS-485 properties on the chip node;
+  multi-channel parts use one "serial@N" child node per channel, each
+  carrying its own serial/RS-485 properties.
+
 properties:
   compatible:
     enum:
@@ -49,8 +56,55 @@ required:
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
-  - $ref: /schemas/serial/serial.yaml#
-  - $ref: /schemas/serial/rs485.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max3107
+              - maxim,max3108
+    then:
+      allOf:
+        - $ref: /schemas/serial/serial.yaml#
+        - $ref: /schemas/serial/rs485.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max3109
+              - maxim,max14830
+    then:
+      properties:
+        "#address-cells":
+          const: 1
+        "#size-cells":
+          const: 0
+      patternProperties:
+        "^serial@[0-3]$":
+          type: object
+          description: A single UART channel of the chip.
+          allOf:
+            - $ref: /schemas/serial/serial.yaml#
+            - $ref: /schemas/serial/rs485.yaml#
+          properties:
+            reg:
+              description: UART channel number on the chip.
+              maximum: 3
+          required:
+            - reg
+          unevaluatedProperties: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max3109
+    then:
+      patternProperties:
+        "^serial@[23]$": false
 
 unevaluatedProperties: false
 
@@ -70,5 +124,39 @@ examples:
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

