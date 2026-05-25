Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DA3E5A3D;
	Mon, 25 May 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702252; cv=fail; b=hzRsBbJfRsQdl8i9CrbGQpvtg1sHLYk121Uyn/ZQVx13tu+cW9bZZ62Xjlsgu33iP2P/I2nydB+AaHsHv6FiQkMb8OTxbky6ZbH/1fMNtd8zg5E2die9jONCd18UlOpKylX/ygAgK2cMU2EcmmrAgoU/xbOBa20oWywR3mgu2DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702252; c=relaxed/simple;
	bh=CWoKuZok1Id0RNXg7eCMdRdk8Sm6v7s8s4aTrwel40g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Snc6AOMHLjWhBp3cK4VqIRiBbdMMhZu7uE0KQ6DzedOEuNtKlXi0xW0R0KOTlI+/4MqZRTwrgkQ6rNkWTQnxgGfpmK8bUvj1t5MYraUmDOC0LplLAODJouJ9HqLqluJ1K0KyD1o4JngqZfJ+e8hXGrfaN/yHi9hCDSr6p+1z/do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ZnjNkUXl; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ZnjNkUXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV0B8LhfiDYXIAV5ZVI3s5E0Wse1oCTL0l+pCBoY4KPNIBnlIt9Vg0KQu2Rg+eQtNUXnGi6wUMS3iSyCr6TIjwru1eHZZZ2i/I6buict2t/RWDUdfbpcEo2moMPTW2ykLsyTEsQFMSN9D0dCWRNXCP9YjttQcps4e9KKuPOZfGW/6eCfGlHRpkYoLGy63z1qxjAhsNDlX3vRPwyVTMpVqlKMxvPE/b1v7l1YbZKf2YgVbFFkF+tIQeO2YoVL20GphwLsyKXwTNLujKYhqoPdmEdd4oOpDhAjFFySV4l7+G2MICsW4tKKHTmuGFnuBxOTMONY53TRGuN0J4IcQ6eqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl6L27BRiUgtetfHLQ3RqL8eSdQHjQGVaNTN7Yy5QLg=;
 b=ab0xck6bnAoe2gsB2WwYXDIgM4kE9eBSsJQRJCVTXvxMQFdqrL2GuTw54QmUxIdkpJOp4Ghqx0ta76YLXkeY70nT7f7FsM8IsCH/mRP0elupSgud8SfrV4xrR8r8798c8YJZ5UU4NpPwoA6s3pD6A2ZUhP4LgH6WwpgqLQi2ZXOzuUJDKtGfxkq1yEItu0yJwxC6bLKjHgpIR8WK/w/PEWVQ8x8ZxXVcEBOxZGUAjHr0kvVxTxQfZ+h5VLJU6txDkDvu61M0+feP+539nUnZP/qPrlcmfNnF+cVNho+kMnVayfyBQJDLTI2GRvA0TKIC3aX5CQhNP6k1t/JwL4lhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl6L27BRiUgtetfHLQ3RqL8eSdQHjQGVaNTN7Yy5QLg=;
 b=ZnjNkUXljt0+K2G0e0mHJh2ZIQg7Ti7WLm6NlbHNAUwo7MFyJv6DW1adDY2oRe8lpUtyNyYLSmaP+cHxfUE/qNu5bl0I+i817GpNs5mPnLUSBFxBXVYoC2uKzolfAOHp3tq81lIuEWUxWfUMaBTLHgQzpg+jnHNBOByo67XH87M/lCcfKoYMrE1ytL7mURHPjJX3zmE9Z4OclB5y9bGVhHYOlHUOAtdQPKiYDe6pTPXN0B5ZfgIJ4M+Us2Oilw4khFVZ7PXumSXHvHYrLSCDOqFjltqo3SeVhP5D1I7XwbeXXIhUArealseue9rphNqaPbVeiElLeAT7elmtllcWyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB7608.eurprd06.prod.outlook.com (2603:10a6:20b:337::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:43:52 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:43:52 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 25 May 2026 09:43:38 +0000
Subject: [PATCH 2/3] dt-bindings: serial: maxim,max310x: allow per-port
 subnodes for rs485
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-b4-max310x-rs485-dt-v1-2-e6c19b4d5592@vaisala.com>
References: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
In-Reply-To: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779702230; l=2837;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=CWoKuZok1Id0RNXg7eCMdRdk8Sm6v7s8s4aTrwel40g=;
 b=c4hna3cVf+ox7Evoc/A6Gq2xIpekB1WX5X7GC6Dc+ytPlDCG4sp6c/kZdrCjieB91o9xhgyJD
 GkojnAT9fQACi2qmu1SC7ndIoecGrdSXSQiBF0dfP1Q28VelhlowvmC
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0004F082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::626) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 01694183-25ee-4990-9720-08deba422147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|3023799007|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5ZjzzEIFKOJxAtOLMZwBmClp3VEGElfj85v76Hc4ngc2KzBsutaFr8YO4mGVjOPWfWi30aKqxmQhdIa7t9Hm5BDpV9OozX1iO0CXHuzOs8fhDG7WIKV2DDfTCgpqtUDBMGov7lFF8jvpHXOqL2fAxH8BfBPInzn8BpP+N0ANa9OgxPJHonYPTfCBvHT/q+eNZUcUqtXQYihVuPbqVK/jBc5nN3lkl7Z6Y1f0QLe0Pwk1DJQyPfJcwxYSO80VCu75Ht1LUE4/fORdOc4ExABjpOR+eAbULY/xzVyIoCsopi89H63UWaCFrORqNLuJsWU+YAigP8Ag3/nNBOFSPozqHvZXDWs8baDLovmGF+GV9gNewRpawmh4+4RaAhaMrS0S7Q6ZxkSk/NsH/8Jk+eJoCI+8QWtdA8/a73DT4knz0MeH3vVYxsh0rAr9x0+dsF30rvUej92aA8tUQqbTJ1b4LJC4UV37p+DvFy1f1m4JQFzJ1G19u1rhjx8rVJ57hKfxApz/dpzItfy2HgbXiBEovxYwhrKHOK+PKW7TE04UhdhUvhM61DotJLv2rhnUujwtd4m5RbkpxMuaALYcxXVrhNaZ0wTl+QJDmKsRoKhCdcjBR6nPqBm35IDAlKlqVr72blrOd2N4eC+nwLZ6h4q6tNX0ZHPNJMvae7D+xaCaC30rc2n/XPpSG+g7P/nif7NkIKo6gpyawMJT8rbIteLHldc0Xx0lzxs2lpmTq7bEuSMlPn/jV7LexqsZN01/2DyX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(3023799007)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmJGUmk2QmNzZTVJbldIYzVZWm9CdVgyc3VoZ2VTOTRFdGIwZis2VVNUcm9z?=
 =?utf-8?B?V2s2dUxSWXo2VUI4QitQc0kwNit5eDExL1hkeEo0cWcvQnhGMTE3MlF2K1Bt?=
 =?utf-8?B?OENobG9ZaUNuT2ZDVmF6NGN1c0p4bDM1STNLUGdxN0NOb3d4TzVISWFMYk1J?=
 =?utf-8?B?M2RGbGxPWGFFQnVXeWs3ekl0RisyRFVNMGptc3FTK3c4eHZPQlU4VVFVaDVX?=
 =?utf-8?B?RzVGSEhhMVZaRUNJcGExYUZ3T0RJU3RiRklXQXVwMlNMenE1S0Nja091YjNi?=
 =?utf-8?B?enR6cGpBemh1L2lWOWNBQ3haVm53bGllVnZmY1FleUJUTzIwKzNBc1YzdGs0?=
 =?utf-8?B?RFRhaXhOM3hGdXV4NGs0NklIcmhYQ3FqMHpDb01Cc0p2c2o0YUgydkw1UkRM?=
 =?utf-8?B?bm1YWUt4Y0xOZCtVblBqL2tFWkI1d1c4bis1NGE0b1dwSjZoOERDV1pWU0li?=
 =?utf-8?B?aGM0WXlwUFVOZG0xdU43d00yMlhZWDl1a01HeXpCVlpMS3pWS2M3VVo0cmRy?=
 =?utf-8?B?eWVleGhvWVZDVnFsV2RSSDY5emdzZHJyWlBLcUlOTGlkNTQrQ0NWd2dtSW5R?=
 =?utf-8?B?NCtxemFEL0ZpYlZ1aHl0WkJBMUV0TU0rV2xQdnhrbXFkN1ZTeUdVOFNVelNC?=
 =?utf-8?B?SGEySno0OGF2bmhNYUI5SUMyZ1ltWWg1TjlXcWdrdTQzcUVWeWlkeVgvUjNo?=
 =?utf-8?B?b0Uxa3NLRzQ5WkRqOUxhTWtBL1ZvS3ZIV2FheERJa3J0SFRrQlFLUStxRVM2?=
 =?utf-8?B?d2R4RFJkV0wwZ2ZTY3MzWVMwRTBnbXBVV3VJT2tYUW02aFBxaW5CaFFPcm94?=
 =?utf-8?B?N05PVEttQnhTU3o3bkVHN0srZVYxOERCeXM2OWhDM3MvSjd2SEpaaDFCK05L?=
 =?utf-8?B?OVozQUFYcFUvN2cyUEhKVHg3T1BhL1NjK1BIWWNDSHJVbTl3L2wzY3FySGty?=
 =?utf-8?B?WFI3QnpBRGx5ZWRHWHhmRUdnRUl1NnQ2UDhYYnU3M0JWc3g1aUl2OGh0YU9a?=
 =?utf-8?B?VmlrangvV2VMSFBuenJCaEdwZXBvWkZDakdUMHozejExL2ZqS28xc29JYXBU?=
 =?utf-8?B?enVOOUlnMHozUjYxYy84L0x3MWtQZ3M1K1Y4bWFXZUZHNDFCSzNrL2N6YVNC?=
 =?utf-8?B?RXNNMWU4eDJFUDd5WHJ4aWZEYWhwemNHUjVaOVVaa09mZTJ1M3A2blFPRTZj?=
 =?utf-8?B?RnpMME9HenJvTDNFY0F0OXpVdXM1YzE1RVU1MFh6ZTM5VGg5NjlSOUlZZ2F5?=
 =?utf-8?B?RHBRSEFZYTBzb2FuOFF3eVVyMW9uaGk3UzRaTndBZWtXWmlaRDVqOU05MWtF?=
 =?utf-8?B?WVdCdDhrZmZTWW9qTlVHYzdQOWtpQjh0d2ZqR2dqa2RDL1ZGOEVkc1gwS3hE?=
 =?utf-8?B?ZEdlVm5JQXIyWmQ0YStzOFFpaHl6UEJpZlRPbFp6ZzExWlNwbDF0amVXbEIx?=
 =?utf-8?B?NjFKTTVzMTk5MExKQnJhc2FIeWNzS2NRamU1RzQ5d0l3RGV0VGJNTWwwQ2Ri?=
 =?utf-8?B?aEhDSVhhNWpmWUEvamZvdVdhTHFkSVArUWhJQTI2K2hXLzh1RFhvQWgwelhl?=
 =?utf-8?B?VVNCYmpMbW5VQTUxREhLaU4xNlBsaVN5N2FWWEU0c1A4RldPMWdXdWR6Y3NY?=
 =?utf-8?B?cFFpRzhlTXB6RERvL2lJVitLQkZ3R3FBdlRvU0lrVERQWEhmSVNiTWZNUVk2?=
 =?utf-8?B?QlBXWllwSU84MWV4TWh0cnlvellHcFJ4T2pWU3NkN0kyR0xRaDhBWm0yN21k?=
 =?utf-8?B?SDhJZFBQOEFyM1luWWIrWmN3STlzdkUwQkNLMWI5blRXaGJ0dVNNZG1SVUJP?=
 =?utf-8?B?THBZaklFRWhBcElsbHVIcUhVSHUySm90REZickU0dlpsRDVJYkFFTWtkZEpq?=
 =?utf-8?B?ZjZpTEJwYlJhUTdMUmlYMWdxQ0NtZXRMV2VmRzZycEY3ZEZBMnU0S1J5UzNN?=
 =?utf-8?B?WEwzTXh2aCswOTFmdE13aFBoVHpKcWxLNmtDSkFHWm01V1NsQndVZDAxbE1B?=
 =?utf-8?B?NDQyMTFjRkh0RitGNDRQL2lIemdTQ2Rwbm02TmVXbzNqclFFOVhMRk1pSzlW?=
 =?utf-8?B?bExuL3BTNjdLZWI2VFhENTRsVjkweGJmQkxCNVhJL0ZLY3k0cnBrUWdQL2hZ?=
 =?utf-8?B?aUgwYjhKUE1YQWxRUWtENmUxNkVmT091NHExdSsrZ1NRd1NjWHcrR3lQM0tq?=
 =?utf-8?B?aXRMZitwYUUzSHFVTkw1Zk9VTGlVWi9uMFVpQ0lVcWF0OCtHdEJxL09zLzdi?=
 =?utf-8?B?bFZoLyt0L3k5VnNsekpUMnU1S21TazBzSm1YTE5VMkM3Zk5FQUZKTTMwUkg5?=
 =?utf-8?B?aG50TnFOWmgvU0JaeEZqMmc0ZTRxcGNjVDJRcTN0VEpMTkxyZFpQaEpyeTFh?=
 =?utf-8?Q?aVYhIpolT3LbFMaE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01694183-25ee-4990-9720-08deba422147
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:43:52.3033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9RtY/nNBkeWWMud/5r1+4+ecQDj9zwzY6y0Sv48tEfRl6PZkravDF4BgNmCnobtu3ywSqCs+ThyDPcUBfJwx8DW33CI0ps5P6oxnjHbGuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7608

The MAX310x is a multi-port UART (up to four ports). The existing
binding pulls in /schemas/serial/rs485.yaml at the top level, which
only describes a single port - sufficient for max3107 but ambiguous
for max14830 where each port can have its own RS485 wiring.

Add a "port@N" pattern (N = 0..3) carrying rs485 properties on a
per-port basis. When port@N subnodes are present, the chip node also
needs #address-cells = <1> and #size-cells = <0>; allow both. Top-
level rs485 properties remain accepted for compatibility.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 .../devicetree/bindings/serial/maxim,max310x.yaml  | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
index 889eeaca64a027b4d9e8ec87bcf63fcc8fd9d55b..b7095c9abacde81e69c1138e817a1d5bdfaf14d7 100644
--- a/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
+++ b/Documentation/devicetree/bindings/serial/maxim,max310x.yaml
@@ -40,6 +40,34 @@ properties:
     minItems: 1
     maxItems: 16
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^port@[0-3]$":
+    type: object
+    description:
+      Per-port subnode that carries the RS-485 properties from
+      /schemas/serial/rs485.yaml# for a single UART channel of the
+      chip. Only those rs485-* properties (and the per-port reg) are
+      accepted here; device-wide settings stay on the parent node.
+
+    allOf:
+      - $ref: /schemas/serial/rs485.yaml#
+
+    properties:
+      reg:
+        description: Port number on the chip.
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
@@ -72,3 +100,35 @@ examples:
             #gpio-cells = <2>;
         };
     };
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
+            port@0 {
+                reg = <0>;
+                rs485-rts-active-low;
+                linux,rs485-enabled-at-boot-time;
+            };
+
+            port@2 {
+                reg = <2>;
+                rs485-rts-active-low;
+            };
+        };
+    };

-- 
2.47.3

