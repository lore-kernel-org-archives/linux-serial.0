Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716243998A6;
	Mon,  1 Jun 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309557; cv=fail; b=c9KeAdNk2i18sRfRAwUUM7Hlxh4KRFD+vFnVlg1Q7//giC/acZIG0DlMByouyXsDK/8ZcQGxzx76V7kl65cY+yyTdRDKXo+6gS7JhwfQNHs0/CKDLm1vRBD/wmUSlY5BTZNV++B42ZodJh9zvd54AYmvPUv2nzKTJrrpwANz9ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309557; c=relaxed/simple;
	bh=bBwsUYyRhs/z+5jtts6VgakVFmYXRZAW6vr+TaU50GE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bKwYt0xBusfmMetOFEAJv3vgzqstgOx84oi5OSQW2uxe3V2JPMlsbgTTyzH66hN0P5r6p0MFUCr8J5jqSLLC6vshAA32Hd3bt/F81xp5zJgFGNk8Ekh699vGVA77cum/5aDcb54bMC/FZfQFUSkcQUCDec5Smie3efnUmmi7bbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=FUvwZpdI; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="FUvwZpdI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUCi+hz0JhpW9N+aalVxAyqQxFozz621OddnwJsvn44+ua91m9rMv9gqnVqo4vS+/pq/u6Fyt748LJ8ODgVf3lrp3fzdkBtrqnAz7CyCPINJHbk04dPT61nWmu26BqEa9RAVWimuZO8GCEQ/omQqLUXer8zsiMoAfQDJpbLyGXS4nChZy4lWixVijq+UwQCGCXQNB2OSXNcJlwBV4UTp59nGloExBGATdfAgpNfCpNHc7rSQhZOkGo5csTeV9FYMsigmDM3F6ItHF7lzJUiMUF3xkHvi3xjAKhcZss9T8J/1fdjRCWg2k/AtlCPEsNq9VOiTMT689v3gqzMDo75trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7hvwAB11vYCiXDry19nOE0Zwpow52IlZpwDAkwTcBc=;
 b=rwYwFXwzHuYpbmQ9FR5035b36/da/AsqKNng4cUex3vUUeq5/ehMl32PHA3uIXdKOweOCRfjepbqzfhBjHCZupuVT5350UMHbYE7vrK6muDr8Udu5AIBYspo2RKV1UeXtzLpNPV+pjTiC4xig4HCfQDlyuJl2jkBLveKfmbn8IdXfp3Ymj+xlc9yoJ58coSoac3bKilJTosv+DXn60UXTjkfZBa0FSVDnPTbRt/sJ+zxeLjB4pOgKCApE5cH2CK4Aq9eMvRtYIQBE5dxTm7x3hSD1IfYn9uBKFOmfj127XGgX3UARLVpk3w6BWrs9dIFGpwMvGov5tsEsf9Vuyklog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7hvwAB11vYCiXDry19nOE0Zwpow52IlZpwDAkwTcBc=;
 b=FUvwZpdIj4qWTqT6+qSx2X74agnOGVx2qA4z0+VvxiVvgHSv1mLaGxNyZtDqqQ+mkY0LubuIK0wuZfLuExE8uj3Jp5HBON6FVvqo1sz9tTVO2OKoVcgkhFIsVs35JTS8LP+ZSkcZbBDC5aLJmn6YXAb5YcnMnjsncfQpy2rsKJshEKIwa/orcfPE11seVfFUy11S4ci25Cr8NB/r+9wab/zDgc/KKBOT+Vl52sPcs1It5s0A2tdlS3PKH5FixX5MAdQ1210Qan2uXlbU4hjMbOYgW8n+d2ojfZZENU5FQjvSQe9cYzoZ5N+EzqIFcYV1XdpPQ+KL1Ut9id/5ESXrKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DUZPR06MB8775.eurprd06.prod.outlook.com (2603:10a6:10:4d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:25:41 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:25:41 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v2 0/3] serial: max310x: honour per-channel DT RS485
 properties
Date: Mon, 01 Jun 2026 10:25:30 +0000
Message-Id: <20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpeHWoC/32NTQ7CIBBGr9LM2jGApYor72G6oDDYSexPoCE1T
 e8u9gAu30u+922QKDIluFcbRMqceBoLqFMFrrfji5B9YVBCNUIrjV2Ng10vUqwYU33T6BekLgS
 pbDDm2kBZzpECr0f12RbuOS1T/BwnWf7s/16WKJAaJ01Xe62NemTLyb7t2U0DtPu+fwEIeekUu
 AAAAA==
X-Change-ID: 20260525-b4-max310x-rs485-dt-ebff12af9976
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309541; l=3341;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=bBwsUYyRhs/z+5jtts6VgakVFmYXRZAW6vr+TaU50GE=;
 b=jcVHbwMZcfbJ3TWZWEkuP4jX5KIISTVAT8rq0WhrchYsFSQb+oA0Xznqa/2sbQNwK645oZGkO
 PVE7kcna4vSBjeXDOuaJV3OERvG2EolNaAWXtGWoUl1rXg9vQ1TJrEo
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
X-MS-Office365-Filtering-Correlation-Id: a3fb6c23-c053-4ddf-9675-08debfc82201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|18002099003|6133799003|3023799007|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	MAe98wzA+MU9+EWDXxyQXm24hWq50dt3Lwt3DNIQPIFUn4/VxBgn84Tjt2bASIrNkxt59p8/EHD56Jvfwr1azAja2aiYXHTc294AiPrYRRXpcV/OVG8EYVR7T6tQTIewlcifCISHVAlH47o09TJsvX+Jak7RJ5JxESd3jP7LGdPCbNf5XD6Hfwi6aVAjSiJaGwNUf5yFyEmTKeMzFdBhABQtZi++CS0DGuy9OlDSsu7IPAh3ZPSh3xk8oHAqDI9Lh+l77OtQ1O6j3vGtuF9/KAZuPjAV3ASDxvUDHUZ4nHRc+P4wENWLpleNq88DrywiY5QP7bAOtPn3GXVaIW70LKF8YvataGTc1/IzDh0A05k92g1n8c8tiIRZ4LxQ9qyqEbH1BWwEKaGvSteRY8eC9NIV6tY4A1heNx7iu/Se1xxvNrr9Xdb3R4pW8o2ZvoORc+7uGUIgoZyC7LfHh9GqsxJh8BVOf/7izqFrnXL2Gs7lw8EB+JIhZwSbG7DNjecgwGskqd9D2vnbDxk7yl4wTGakGqHQL5ZNKFCZcYRHo3Iyy+VTJm7hMkcKB/hw3mnosC80nOoKfmmJgtoDpms7dHX20HKCU03pnDJ3XgQh39uDllfJjbJsiY/6NsT/32SE9BEyO6Sryjj+DZCgpMaeqGu8/+Sf79ZL6MtPUBh1om8w6toD1KbDZRw/2Kv40p2q5bohgc6I/obQjNKSb6s2fLIOHObWqWBPk4CpoRSz39NDTVvkW29do9wnTSVOdUjF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MndxaFZ1SDFjaW9CN2ozdlNJT0VqV1JraXRmdVNxcHR5blQyT3p1VTV3UW9N?=
 =?utf-8?B?aGdlSGJGWkprM2htYnh5NHhNUXdqM2g3clFZWGdzT0MzRVFkRVNnaVNaUzNZ?=
 =?utf-8?B?R3JDRVY1ZFk4d1FhYWFaaG5OYWVXNE1KeUpUSVRVbExpYXpxWEhtZ3RkbTlR?=
 =?utf-8?B?bnZiNU1xRW5oV1RsOEtLc3p1aVRLTVhTcEdLa3V2ZjhhL09XaVEwemRGVHhw?=
 =?utf-8?B?TEgwb09jYk8ySS9ma3hFamZzeWliVFVHTlppUi9aN29xSmJIcXhHVXZ2UzVh?=
 =?utf-8?B?MjVLYXBTR3ZUY2pMWlhUSXpDWnpCSW1ZWnVXM1F2QUdPdXNTK2JTMElhcEZJ?=
 =?utf-8?B?Vy8yRDVDU3NDek44RE5mYXNXVVg4MXFzVE9aanpKNVQ1bUFrZjFvejc3QWZx?=
 =?utf-8?B?M2JuN2dDQmlJRWxuMlBIV2xWK05yaWhqL2tmbkFmM3lUNkU0dFVmbzhUZHNO?=
 =?utf-8?B?MERiVWJxTHRGTjEzWEpBTXZLdkJRYk1RMExHRVNwcUhaMTc2d1JzWHRlYU51?=
 =?utf-8?B?U21HT3pveWVpUENCNi9QaHUyNURIYkpmZG1wWXVtRVFMMnRsSkJGNDVhZGkz?=
 =?utf-8?B?K1ZGRElXZW1JM2owakZDSXlNMUZaUE5tVnFZM3lQQnlUbHFkU2hXUFA1eDRK?=
 =?utf-8?B?WEgzYTF4cDBqdFdJbndzcW5kR2piY01PRGZzcXE1MG1lOXpPY1d0WXpBS1lo?=
 =?utf-8?B?cWRiTWdqbHM3dytxdFJaMU8xaklieXZpblB3UWR3Zi9hMVEvV0twVGFydHZT?=
 =?utf-8?B?STIzSlZWUzZQRDZQWkU5QVlNRlN5U3BoZk5LNUVrL2g3YmFaYTdCRHNKQlcy?=
 =?utf-8?B?VElUM3JZaDBKSFNrRldtTnhaaGM3U2NIKzgwbGc1dTN0NCtMMUpCWDhWc2pN?=
 =?utf-8?B?bDNhQVNFNTlGZllteWIzRHJkemU4eTRlajF2UHNKVTI4ZTZOaDBwMVMxRlgw?=
 =?utf-8?B?bE1LT2FYYnNZdlVCZU4zUHF2aThoUW5oaGIwU0x6OWVYd1ByVkQrVVJHaUVX?=
 =?utf-8?B?bUl6NUJOeTdJYUlkaUs0UXVRSlZUTUM5ekc1NzBGdzFPckxqL0VmL0ZuK3dT?=
 =?utf-8?B?UUNjdnQwaGNSRkdsVjN4Rlo2ZE5jMysxMVcrNjY1U0cyN3B3K3o5VEpLVmtp?=
 =?utf-8?B?cFFXWTZKYi9uV1gyWE5xb3FTSmVpbk56bWdaOHlTUzhzcWpKa29Odm9ycW5C?=
 =?utf-8?B?eHBaS2IyQW5KNTFOZm5EVUVPMW1JMmxhMWhFeDdNK0JSS1lwYnp4Q1E0T3Fs?=
 =?utf-8?B?RHpOU05RL0ZrL09wc2tGWDdLcmJTdWx0TXJDWG11WUpxa2t2cVhqR090clpJ?=
 =?utf-8?B?ajFIL3B4eTRza3BMdjNQYkpzb3VORk85NmYxajczN21FNDBHTEd4aXI3L2NB?=
 =?utf-8?B?WTZ4UzkzZXBCWGFZaFcrS1dpSFdxamYremZYOXUxYm94RS9oRUhrNnpoeGRO?=
 =?utf-8?B?dyszTkRSTm5YRE9uNzVyaXNoRFlQK1NxMUM3cXVrcC9iUXBmR1dMQ3c1aTEr?=
 =?utf-8?B?Qkd0azNWREZRL1N6T09sNU9DVzE1ZlptNGxUUkFzeW5uZWlIL1I0NjdzU3hV?=
 =?utf-8?B?bE9DeDVybndLMGtuUkpBZUZ5RnEvNVhQazVpTmNVVE0rTzF2aVorRUdoeUM2?=
 =?utf-8?B?KzZmVEk2cDdTUGw5aENHSnB4SGh1U1NteEFlRGh0SWg0YlF0Q0pERjRjeGt0?=
 =?utf-8?B?ZmRYTElKVGRVcGFqSDZoVzFhOTFRZWF6UHdOYTJsemhnVkNRWkJvcWRRYWpu?=
 =?utf-8?B?cndRS3BxbnI5UmVWWHBtSmg1TGRvM2t2QXVnSThldG5wTXNEcGxFeUdMcTBQ?=
 =?utf-8?B?WngxZjN1TE5wQ200WjlLTHNIQ0tKU1Y4dXRvUG11MXpBQ0crd0gvM1lCcVND?=
 =?utf-8?B?M0c0UXczZDVNWmpTeUd5ckdiRlFBaWFRanVQRkpMa2JtUkI1d3hKUnlJRzlx?=
 =?utf-8?B?MkpuU213bWtqcVlPQVk2WDg1MkNJWDdmbXd0Q3I1eWpZTGRDbXJkaDR6NHNx?=
 =?utf-8?B?MHhRY3duVlptZGRPR084WFdOZjRHZXE3VDRDWWptOERzZHBJSDg0SmJmTlpw?=
 =?utf-8?B?dFd3SHRmUjN5V0RHWE1STW5saVNzRmxpaHFaMURrYWJabWsyZG82SWVpWUJE?=
 =?utf-8?B?MXhiUUNpNEVQNHU2ZU1ZakRkcEc2MmtERmpNa0dCN0tRK1dqLzNCbDd2endh?=
 =?utf-8?B?SS9hUmVpWGNEVVdYUWU2S1RzbTVZRFduRjJwYUp5eE9ua3FaY3VxL3p3M0dG?=
 =?utf-8?B?amhEKzBGR21tWVkya1J1UldPRXJCT29INmRNbHRYaHFPR2liMnVsdSszT1JS?=
 =?utf-8?B?ZUVlK1RlOFlrVkJEQU9uQTdoeW9PT0d2MVB1UjQzUnVGcEwrdU5IVFhmWkhU?=
 =?utf-8?Q?wnKFqjnNes+UmJZY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fb6c23-c053-4ddf-9675-08debfc82201
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:25:41.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4YvrMi0i3bsogs/2opMzbvBSCgrmbCf5eLgxdZeL74kaEa2uljpWFZE7BicfudRbNXQDOfkx/Mh0XDYB6R8fGyge71RZEwVgRWGbutbLDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8775

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its allOf
list, but the driver has never actually called uart_get_rs485_mode(), so
none of the advertised rs485-* properties take effect at runtime.

This series wires per-channel RS485 DT configuration end to end:

Patch 1 reorders the probe so the gpio_chip is registered before
uart_add_one_port(). A port can then reference one of the chip's own
GPIOs (e.g. rs485-term-gpios = <&max310x ...>) without -EPROBE_DEFER
from its own provider - prerequisite for patch 3.

Patch 2 describes each UART channel as a "serial@N" subnode carrying the
standard rs485.yaml properties. The channels are constrained per
compatible: the single-channel max3107/max3108 have none (RS485 stays on
the chip node), max3109 has channels 0-1 and max14830 has 0-3. Being a
serial node, a channel may also host a serial slave device.

Patch 3 reads each channel's RS485 properties from its own subnode by
temporarily retargeting dev->fwnode while uart_get_rs485_mode() runs.
For single-channel variants, falls back to the chip's own fwnode when no
subnode is present, so existing top-level rs485 DTs keep working.

Note for maintainers: patch 3 mutates the parent SPI/I2C device's
fwnode around the uart_get_rs485_mode() call so the underlying
property/GPIO lookups resolve against the per-channel DT subnode. Probe
is serialised, so the swap is locally safe, but I'd appreciate feedback
on whether this idiom is acceptable. If a cleaner shape is preferred (a
serial_core helper that takes a fwnode directly, or one struct device
per port), I'll respin accordingly.

Tested on max14830 (SPI, 4 ports): each ttyMAXn port comes up with the
rs485 flags and delays configured in its serial@N subnode, and the
termination GPIO sourced from the MAX310x's own gpio_chip is resolved
without probe deferral.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v2:
- dt-bindings: rename the per-port subnode "port@N" -> "serial@N" so each
  channel is a proper serial node (serial.yaml) that can also host a
  serial slave device; "port" is reserved for the graph binding. (Krzysztof)
- dt-bindings: constrain channels per compatible - max3107/max3108 take no
  subnodes (nor #address-cells/#size-cells), max3109 allows 0-1, max14830
  allows 0-3; out-of-range channels now fail dt_binding_check. (Krzysztof)
- serial: max310x: match the "serial" child node name accordingly.
- No change to patch 1; patch 3 still reads rs485 via the temporary fwnode
  retarget (idiom flagged above).
- Link to v1: https://lore.kernel.org/r/20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com

---
Tapio Reijonen (3):
      serial: max310x: register GPIO controller before adding UART ports
      dt-bindings: serial: maxim,max310x: describe per-channel rs485 subnodes
      serial: max310x: honour rs485 properties from per-channel DT subnode

 .../devicetree/bindings/serial/maxim,max310x.yaml  | 90 +++++++++++++++++++++
 drivers/tty/serial/max310x.c                       | 91 +++++++++++++++++-----
 2 files changed, 160 insertions(+), 21 deletions(-)
---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260525-b4-max310x-rs485-dt-ebff12af9976

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

