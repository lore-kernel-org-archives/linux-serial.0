Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691C53E51EE;
	Mon, 25 May 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702240; cv=fail; b=HbwfVecqcROCJUJwg1ugDcR2Hoj6OSCV8XpjOnvhD9UcF8RjHr15HwHx4hFcjmeDwYgxWQmuFduBsC5JlaZvRaIaMJCk7K1qQ3DnJOli9tga1sXUjWNDsO0tbdluhP8kURvizN3OgCgy3dLXZS3PdkJ2vvAsfnBcGMWwnUSewY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702240; c=relaxed/simple;
	bh=a+LhQIuisedhNn1r/L9/mWyAqWnh3VSZdtI1HHhPFs8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HWxBCkdr/s4zLVKPO1KUYWUc6qyZr3l/6XRAvVgshcy76Gp7jsgcsgzxMpODcNpvIFCQKzIikGVLWnaP15KT6wO+n+TRLvE0wSNNk2tto3kz88ZkDVYhmpkMZEMx25K7d6Zxs+CWtDRSUpm52HffqpapYFA1bEH1XKMG8HpfrW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=SQbMjMmD; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="SQbMjMmD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ce8u0GrKydofVz+5jOQmRcDjGgS3swOrRRP4zs50gWHGCFBYMc74py560ew53jjTLi9nAUVEDMjskL+bDLt8Y2Jq2DLcvzuoRjdxGK/kVyHCcKk477SdczHCIiNUGoP3BsrXCqpF3VwzBri0Y7Wdz3bkbPVTmWIwqvqlH62ZJCj/ID6jaRsoVvEt9vMrmoJtDzzmd90U2+fFIb1n35L0HQg1n7RaEvtLIy8vt5vBAbHn0X4RopEyiefk14FZKZcMWrm6snC6l8JXXsNuD1RoWqZENyai6pOJM9/ltB5xlBc7njZw/i7c8wAzwvs5ejbiZJgjfSnQP47pyk6Vv1KIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8YzkMewstWRjl3DAw3Vm+gVHMxstOxWC1bEwEK9+7E=;
 b=gB7k3nBjcnxeYgTJr5zUYuHkFw+vG9C9j2ZJEzZfpjZDJfSyqyB1hn1z+jXdhwHAVBTVeYGrVIyjN2ngNQKqoCHYt77Sl6iRDdAe2/lW+dp+VlwZZ9sH93R+gCuthgGn9YXXCkYcHkIL7dDMVmZOPgqk6rrXTFziJ5ieqCELPTMJcaDCwCbSMJIiF0jsjxwSaUl6dNsXUMSn14C9kprR60jXsv4Gq0uK1sHwJm3kkW8zNTUEMIDpj5SRVB3+tQKtwlFkn/6aO6D/0Djn2ZB2t4WH4qAvAJHcP0QTk75L6YlxxiucBj7aeQl+70BaJ+UqbscnTZcWOXANIksCNoc/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8YzkMewstWRjl3DAw3Vm+gVHMxstOxWC1bEwEK9+7E=;
 b=SQbMjMmDIuiO+4kHlzTMH3ui50msah1FkVr6eGwr4qdrccNEkSOD0c0AUxSVU7Nr6u5Sy1bpRf7V+Rwk5+zb2/5FjCgh9fxFhUADIaRt8vFb5WRnZrTwvd+YJcrLvAdx7xFXVM8H1HnyFRz0KCkDdB+0v5QO0diVSXqbk/womA6ynBPvXpMXXIfda9fbj5/o7up4taoSdJ2IJqlFJH+/cei2fjxq1APeRoM/y6hCoQeE3WTEy/AGA33S7caS4zaMuVBdUdeaZAyrIt9qSOl8otZZIQflNbUtSi30CQgnl+3Clcut/DU/JONtm3wPuGXtyIDWd0ra1SZe9ipJ3PZ5lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB7608.eurprd06.prod.outlook.com (2603:10a6:20b:337::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:43:51 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:43:51 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/3] serial: max310x: honour per-port DT RS485 properties
Date: Mon, 25 May 2026 09:43:36 +0000
Message-Id: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgZFGoC/x3MywqAIBBA0V+JWTegpr1+JVpYjjWLHmiEEP170
 vIs7n0gUmCK0BcPBLo58rFnyLKAebX7QsguG5RQtTDK4KRxs6mSImGIujXoLqTJe6ms77qmhly
 egTyn/zqM7/sBFIfVOWUAAAA=
X-Change-ID: 20260525-b4-max310x-rs485-dt-ebff12af9976
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779702230; l=2500;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=a+LhQIuisedhNn1r/L9/mWyAqWnh3VSZdtI1HHhPFs8=;
 b=StR8cmpnNiCm536BSgo+Sw6g2iT4sPbkWRHVKmXqe63JpiAPTYnYnmXGUU3H7JsOWHCj6ieTz
 IPYo5p3/TSCA1XAM4AKrreUXhJoYi2edoB8Y1/d4oeLTp2uuxhq+bw/
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
X-MS-Office365-Filtering-Correlation-Id: 7890486c-12e5-4bce-7d05-08deba422076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|3023799007|6133799003|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lnRoouiB/ogNBaA/uhZ5kf9fEIJ9S/8OxTkXNypQap9C2yWbCXQOlUS7mOut5htKuoBfUjyFnLQVnNeCI8xl96kPaLyxWsUTMvrBrdDsj07QFLjIlVmWL4cEAskqSsfsUEo6he3pant4WKYTiMktq/nklGAsTBBRLfKhGhtS/HJB8MDqvD6PlrCUUAscJR13FEzgbPRjoEr8ilChW5s+ravxNsIQJUKdzZcFhxFIrWLbfg7kckZ2uGod3ffSddqgl9t70oqRa3nNmdA/EuxfhGqeP3QUX7InTnOZnj3hm4gRzS2YAtPPuhajKJV7d+8hasS4lFVKbg+juY77VcOvPHRAxjmfRj+Ylv3yg7+N1/M1VJ78mv2TJnDYBXra/jTT+nTgED+K5aEdcEN7SpmJJv0OmuYk1cWiN9vbofHN4Nz06yomP/bKXcWzD9PGFkFcQVeNyoC1QrQmgrhnmV7TKEKi/XJqAG8X/jAebfY+fkNmW7tAmtnqo6LTuzYg2GMRcTH9rVgXTGLw+8ecS3cX99FOMiKeE3313rQv0RnDF36LeyI6xf5dH67zQwWlvNEEvgyVYMx4GjrO3e+yMPqSKjQbZbQMeyfyB8XTQTcWAZXI/rvhroEYZILBTT5yhwxKZncUwj6Mr5F6+swdOta0GVkC23mhMyKiIUhQGgMztmy/TSLWsipgsTqRnRP+Vphpq0IwhmsrGrNDCBR0pwuXIc/qQ+3W6csQFUcDxdEXa7zo+1xx/LS4+Q395yFaZrFA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(3023799007)(6133799003)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWZSWVFIM0dxYkdINkRLOHVSOVhpN0NxeForMkRjV2p5dkt2c0RTa2lYbWZt?=
 =?utf-8?B?eFRYWk1WUXVMY00xVGlpM1dvakxzYitCWjRLL2dsQ1dxNVlyQ2VlM09OWXpm?=
 =?utf-8?B?UGR5N0QzQzVEQkVuMGZLcE96MFg5Z2t6bVZMclJPRmw3ZnhYdlVDZ1poeXpL?=
 =?utf-8?B?VWtXenJ0bFNQamlIaHFKVU55VnRvMDRzQWtrN3AyaUhGeTAyc3RwWmQ1WFha?=
 =?utf-8?B?cXhUbFdKZjBYWVg1ZTJkbWt6c3NJOHBUODgyZXBEcDVIYzJnUXJVcUVoK1Vk?=
 =?utf-8?B?Ujl6UlgybzQrWFljL0ZUS0ZwR0djNVlHWFVmelFjS3ZhYjhwbG5GeWRsVTFy?=
 =?utf-8?B?ckh2em9BaFo3Q2hodnloWFROS2pjN3FDbHh6SWRDWjNPeFVGTmhzMlVUeklN?=
 =?utf-8?B?eTk3ZWtIK0JXZWV3WENJZjNzOCt5eGlvenNGN3F1VzYrT2pCb3RMNTVDMVhZ?=
 =?utf-8?B?Q3F1T2tJVG85VzF4dG1weHMyT1NCZUI4NmxaNUJSVk5GWWNMUjRRSStpMm5C?=
 =?utf-8?B?Sm1kK3JaaE9vRzRVNEdnU0tpajFvWUNGNnUxTjJZeVcvbUN0VnFDS0JNRjNn?=
 =?utf-8?B?eUN0c3B1cU1ScDh1RHVuSjRRejBoSURxOExZZndSY25kbUZjLzd0U1RZNThN?=
 =?utf-8?B?M2V3c0Vsblh4cytRNVNMeFlPeU5RenJXSWdGdThYT1ZYb1VOMjVqSjVwek91?=
 =?utf-8?B?YmlieGZXQ2U2YzJZK3BGSGI0REtmeFZFNjBJblRRTVJLMlpRYk8xWEtnTFBo?=
 =?utf-8?B?WjQ5OGNxRHg1Mm9XNTZWV1AvMTBidTYvck9MZmRzbFE5SURCOUxXYUVMTitw?=
 =?utf-8?B?QTdlQ0FaR3pBQ2VBb1hMNDlZekxWK1NJdzJWOEg1U1RTajVTV1I0bEtVeis0?=
 =?utf-8?B?L2NBWXpoc2QxVXVoT3Y1WGFwR2NJTUh6SnJJejVibm0xY1FCU01lOWE2WE11?=
 =?utf-8?B?K0FLWnRxSC9vWDkzSjJQblgvelJHaDk0aDVseVYwSG9HWmtYY2VFb1kyMUhx?=
 =?utf-8?B?azgzT2NUVDVkZWEvSnJKSDNDcVFLNEJ5ZCtaMWZOMm5BZDluZ0ZLRkVLZ3dF?=
 =?utf-8?B?OEM4SVNFU0lyYW16SnViaGFrMHRWblFjR2tOLy85eXlaeXpDcytQK21zdkIr?=
 =?utf-8?B?ZlUzTmRyc1pOOC9DR1llUHV1NGZnZXY1R2tlYXoyaGRCVkhDNzlGTG5sWXM5?=
 =?utf-8?B?WGllck8wRkhhTE1oTDNhTldmQ3N2a2w5NTZkalcxTDJZRFREa3loUGJwTEdR?=
 =?utf-8?B?M0tUazR0dFN3WTFTeTJybUtieEsvcWRBZkZ2d0R5U085VkREc2s1M3l6R0Vr?=
 =?utf-8?B?MWlYcE12TGpqNDRTa1JTUUg1MTkrcWw2NzBZSkFJS2hBM3V3WDloZVNzN3FX?=
 =?utf-8?B?dXNIMXBIcmhObjFJUEV0bDA0QjNGdUo1T2RMT0ZIYlBiZ1ZPakk0Slhqb0Jz?=
 =?utf-8?B?dE5ZeVZlN1hYMEM5Z0lxREZqbFVHbUQ1RnJCVXpTd3NibEhvQUNMdUpuZlVP?=
 =?utf-8?B?TFpiRkpnVW54TDVTdnE2SXFkUGZ0MGFZUFNHNjAxOGJTdkZMd2xQZHdKVGVy?=
 =?utf-8?B?THRHcm5zR1d6UkRaSEdVMnhJa2xKcUtpUGlLNzdITXUxODVJUlNhWVIxMXFR?=
 =?utf-8?B?YlErQytjN2dzQmowT2xGdERCUmxvTy9FZ3pabkRudU9uTDhTcnoxRjFVVGhV?=
 =?utf-8?B?WUZtcGlmSjZjU2l2YllFeko3SjFBQ2lyRTdkUHRpSS9tY1lESkJpcjBTV3V1?=
 =?utf-8?B?N0toY3h6UUxzUlB0QnhubzNxVjZiN29GYVVoSFhHTkR2RjJzMjMzMUpDc2ZO?=
 =?utf-8?B?T1AwdWVpYkgxK2lFc3AvL216clE0clJnUTBQOHp1NzltQzJxNFdpMjJaRE5k?=
 =?utf-8?B?ekV5SEp6QTM2L0FUbEtUTWJsTXdJWU9GN3RwYktURTNFTXJBcFhYRWNscSti?=
 =?utf-8?B?YVNxMzZncDBwVDJkeXdIbVRTclE5RzN5Y0lyN2V0amJncG12N1Z0ZnFEODFR?=
 =?utf-8?B?K044Z1E4SlpPQm42ZFRxY2RjbUxic2NYNEtnVDBwVHl4TnIwL0FNQVIwYmM0?=
 =?utf-8?B?alAzdnJoTVpIM2ZoK0xaLzdnM29BL1AvWHc4b0U2NHRkZ1JUTG03QytxVnl0?=
 =?utf-8?B?dlduTkRDQUhJYXhWSThkdTV5cDBvOTA4MXpNWjErYksyVUUya2p1VXFVUE9y?=
 =?utf-8?B?bGRUcXU4eXAwTXJSQzN6NDlNd0wzL1JkM0lqN05GZXBWb0NhV2FXRzJ5YzE4?=
 =?utf-8?B?cFdHV3c0WDhTQTU4bm55ZnRmUVpkdWVCVVJFKzBncmN3c3hwWFRkRC9hNHFz?=
 =?utf-8?B?UHprRmNaVHR5WExJckdRbmo1aHFraHlLOWdKODgrOVpZeFZLMmw2cjdtdVZK?=
 =?utf-8?Q?VqO25jTtD516qN1k=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7890486c-12e5-4bce-7d05-08deba422076
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:43:50.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzIzSX11Oz+CRYIY7FZzaGWrS9z1Zz6vLx2iLKMPjDSu45gHgDPlaKqLxQ6C1HNg1rd8SVJpKLvhMgavZn9AVCnE05I21DaRsoNA1Nzm79U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7608

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its allOf
list, but the driver has never actually called uart_get_rs485_mode(), so
none of the advertised rs485-* properties take effect at runtime.

This series wires per-port RS485 DT configuration end to end:

Patch 1 reorders the probe so the gpio_chip is registered before
uart_add_one_port(). A port can then reference one of the chip's own
GPIOs (e.g. rs485-term-gpios = <&max310x ...>) without -EPROBE_DEFER
from its own provider - prerequisite for patch 3.

Patch 2 extends the binding with a "port@N" subnode pattern (N = 0..3)
carrying per-port RS485 properties. All ports share the same parent
SPI/I2C device, so per-port differentiation requires distinct DT
subnodes. Top-level RS485 properties remain accepted for compatibility
with single-port chips (max3107, max3108).

Patch 3 reads each port's RS485 properties from its own subnode by
temporarily retargeting dev->fwnode while uart_get_rs485_mode() runs.
For single-port variants, falls back to the chip's own fwnode when no
port@0 subnode is present.

Note for maintainers: patch 3 mutates the parent SPI/I2C device's
fwnode around the uart_get_rs485_mode() call so the underlying
property/GPIO lookups resolve against the per-port DT subnode. Probe
is serialised, so the swap is locally safe, but I'd appreciate
feedback on whether this idiom is acceptable. If a cleaner shape is
preferred (a serial_core helper that takes a fwnode directly, or
one struct device per port), I'll respin accordingly.

Tested on max14830 (SPI, 4 ports): each ttyMAXn port comes up with the
rs485 flags and delays configured in its port@N subnode, and the
termination GPIO sourced from the MAX310x's own gpio_chip is resolved
without probe deferral.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Tapio Reijonen (3):
      serial: max310x: register GPIO controller before adding UART ports
      dt-bindings: serial: maxim,max310x: allow per-port subnodes for rs485
      serial: max310x: honour rs485 properties from per-port DT subnode

 .../devicetree/bindings/serial/maxim,max310x.yaml  | 60 ++++++++++++++
 drivers/tty/serial/max310x.c                       | 91 +++++++++++++++++-----
 2 files changed, 130 insertions(+), 21 deletions(-)
---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260525-b4-max310x-rs485-dt-ebff12af9976

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

