Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327593DD500;
	Mon, 15 Jun 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519281; cv=fail; b=tz8HJwo0sNhuJCZn+dbaijFg7Jk+tg1gJstIYZ1MiaciuWySCrOFTXwrjSTe4EN458Tun5wacLTkrKjUS8Mp6EDj9piafiFe2zWswkTtfq4wLsPBk3yNZ3/0eqpC7K6x++9v0PGwihcFN9IUD9gL6GCqY1zFz8kYkMREFBO8kL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519281; c=relaxed/simple;
	bh=ZO1A5ITiOiroVpJYXW4Ef5i/C3646kEprY9k59mL9JY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=cozMng4nFg8NvSZoNFLvwausf/KwZyeJdSP8nDDpDHGcUZVFm6Pgjrs8wze0mxE2ASPDKozcYdAImj3PAs6bnuWkDICLV2yOqM+bKBTuR3YYyIpekQH+dW92TwXKzrhCpZf1Z8oloWT1NpSD7Wxphewj+PUC+uaQxG2cbgWdOjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=vJW6Y5My; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="vJW6Y5My"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/WwkEI6VPGJpmTyLNWlgyJ2d0GRSw+9VF18elPze02+g8DwMHdj46fuOmUim2kB6yyCB+Tv3LwUVcBZ3hByF8TPhegd1fPUqnfE4NGxqWJ6TFs99YsKy9GcP8TKOM7CKZ8X/U6D/3rPmTxFIpN7NdwkEewUSyGumGlJKLc2JCHReJBj7dCpGu+bFm3g6SNuxuDMg142vlhsfTvLhaw+vtv6qEBLD1RHC4C8e1MSVikqhEC8XqsrInlapfx7g1QdgT3aQNhOIP0iKgZfJvs8hv737qQkcGF/R9pG85KdvIMQHlJz+5QJzv4zP7i5g7LAyuetmTqhA3NvHREmpr32og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtKwOA/+n6xRTKXxkbFdFm3zc/j0fLAWns11Qenk9DQ=;
 b=dfm/5QQ4ONRYNO8TL1dpETVc6avq3+GeGP2/WFIdYMDPm/0yNKHr2lyEoGpY+wapWJgGN5SdRhlbTOz++Qk+W0OuH/9KxG6viZuotHMhmJ6gwvm5y61NA2h1ssJs4iSM6aDMob0z+KhVc6Uof8GZdg/7prJd2uTgB/mqhk/UD9cmyz3XrentLqOyuxIB+JFO6liHJ8XVk90woABpARU0tOL2FHez/P4JCGbp5zscUYV9qYeao0LFnwoVz7AWQUBuu3ASazsXYBixU3aFeJVD3icVsPKSKws8yAlvsZwZVxztVtz5jhC3xoGpcq4nlm82wk1Nvny8Qw9Du7xmHIPdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtKwOA/+n6xRTKXxkbFdFm3zc/j0fLAWns11Qenk9DQ=;
 b=vJW6Y5Mym3EB7z2cb91siPjKp5FbyRCx74hi93ltK53YXZiXlpKU4ndZR8gSPwbs5IAyn6DMx4XRjsCIVXvba71JYqevbozlcyDP6q557eeA0LKUjuv4dPd/KZd3lLjRzxoKXz3nN+9DHgMBnm+2tls/FtyzltYSIV0v6aif5voN/ZJ7w+OQLFSltu778xY5cD83LCUoGteNb7tpJO/jjFgHHTCEHo8EaytqzbPweTBmsdfQT+W7UF2wgbG+Mh+iZFabeAE0xaGKGLyGL6AUQlHszMJ0semnkwV1xXzxj2Y6wuUpB2ArPyp9y0o+rTOHqe3QNbi1ermY1ksbpfl6Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB8005.eurprd06.prod.outlook.com (2603:10a6:20b:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:27:44 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:27:44 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v3 0/3] serial: max310x: honour per-channel DT RS485
 properties
Date: Mon, 15 Jun 2026 10:27:34 +0000
Message-Id: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbTL2oC/33NzQqDMAzA8VeRnpfRRlvtTnuPsUPVdBbmB60Uh
 /juq17GYAxy+Qfyy8oCeUeBXbKVeYouuHFIkZ8y1nRmeBC4NjVDjopLlFAX0JslF3wBH4pKQjs
 D1dYKNFbrUrF0OXmybjnU2z1158I8+tfxJIp9+9+LAjiQaoSui1ZKjddoXDBPc27Gnu1ixI+iu
 PitYFKM4DKNrajk38q2bW/x4QF2/gAAAA==
X-Change-ID: 20260525-b4-max310x-rs485-dt-ebff12af9976
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781519263; l=4243;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ZO1A5ITiOiroVpJYXW4Ef5i/C3646kEprY9k59mL9JY=;
 b=9+gZsmXt2UmWesb7u7L5ooSf86qMtvzDwYEacimTpE36uQXkroq6dm3CuRmj3UtIgNsuEEuTR
 HW62HLIm68uCaHY2JHyYoMN+jmQ4bsR26I1xdS/TiQwWRUPk2VdUblk
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
X-MS-Office365-Filtering-Correlation-Id: 204f09d7-f9fb-41ac-36b2-08decac8bcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|3023799007|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	hp9EYkYiZ37Bi1mijmlJcLguGphXox8g58htgXsF7ChXE6OtwXVQwLSpH0sxZLaiNeZ3LyJy1XhCc6uRJe0SaQIFv5e/d5OjJf9Qy4jZrHw5s1uz1Z5L9Xb7/oXlJc7WDmePCeh0lxAaBwhgqJLiSislCAMJ1NaSYyDUcmJBHHFeQGevjWFI8xTgL4v3JkcNSLqLs/kOZLreHydE7bGxo2RlO+bRgXCXIY2vumt1bOzVQLKdaPVWPllpXe4R3XIhVkt2ORdStiVga9A+kv55/tnYtLZnA0AbCwPCldbu6opZUF64VJEqhc7sgCplgNKTpwOmCdqM/yrgbNb7o+ZFYFQtjYK53RskiI65aw1nbBmvyu1LosgOJoRgIARsOqTuPD006gkBBPLn6cEp/9lvUEw7cbafQ3bOiTSqOEMRAgCxJt0g1A552JbzEBENQOzQ4YdWU00YVAEsK51IpYhA0pQ8CGSN1FVRUPKgQ5VMCr7Jnvk27BRMrX1shzRFtT57e2FfN3mg1/XnJcPQsnyjCzQPVwqI9B5gzhiU3kPQH6geDRzlylauDcOrjGPgSHqp6Ni7DjlbRx4oFZt2y4WUoGr/et5u7lOUKRgaZz9GwFbPQvIzr9iDPLS6mB5fJ8vZ9Tll/NG6+YJh0vNYFltfx44jM7IVNAVi+HfGywAGCNWSnOh7TN55ia9dRlbt/XEPKRlRsYu/9k0ei6i63ec1XxAFGXNRfzAE2dTuobvmVCiBHK91oz+dtnKDyw6lRItE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(3023799007)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlloWjNQVk1iYW1SWlp6QmJPSHZhRlZTSXhnUGExUmE1VTc0ekJQcXRFVXFw?=
 =?utf-8?B?RHdiY01RQUlydzJoajloVWNTUlJFblIrYjNta1NDMFJyNE0zUEJZSEYvdXdO?=
 =?utf-8?B?K1FwS2JkSHFBYnNGNFg4UmlsNUllMFlWQXNoMGlTbEJVbVdLR0p4eHpCRjBL?=
 =?utf-8?B?WENFN0syTVFoREVqSTlOREM5U3pWNDAxdHQvY29jNU03UTBmL01CMnFXRWFp?=
 =?utf-8?B?dy9kdHhOZ0tBUEhIS1l0U2dFbmlWZkdLelZFVmRxNWtIN3d2VnNQZDI5b0VV?=
 =?utf-8?B?dXJUL1FQVXZaWWVVUTMyc1M3dkRYb0Y0S1duTVJDbDZxTHl4MUxtUE9NWjJ5?=
 =?utf-8?B?R2FqazhPMnQreFZJWE92VmJCeGgwaDZLb3NrekVHaHZZbmx0ZXlPTmVBcXJW?=
 =?utf-8?B?MEE4cnJaa2hzeHFZaXZzNUs2UVdQR3hXZnpGM2RpaG9hc3h2ZVlLVitjOVE4?=
 =?utf-8?B?bHh1T3d4cDBUVWd0TDJlelRncXRsWjJtUXFKR0xrbTlveU0zR2dtMzdUYm1x?=
 =?utf-8?B?Tnk3R0pLZENKcUMvMVk2OTVBQjFlRm5HL2RERTFCVGVQQ3lTNlRsQ0RzVm9T?=
 =?utf-8?B?NHZkRGQycVcvdU1LKytpTmcyTSsySUcxYjFEa2doTjZVOC9yRTc3M1RGUko1?=
 =?utf-8?B?MThXNS85U3YyN0M1ZGZ1dWw4K0ZDZEkxZmNlL2huT1poR0pVek1iNC9ySjZl?=
 =?utf-8?B?ejUreE9hT3Z1cVpWYUlRVTZMNW1wU2VkTnEzU01HR2Z4Vzh2NUY0RndrWEdQ?=
 =?utf-8?B?NHMwd3dNN0JJU2xjVUZHL09pNW1SaTZVRWdrYzJNMSswbFpudkkzRVNnaW0w?=
 =?utf-8?B?a1hqdDE4bUFBT245MUZRRUp2WXlDeTN6blBhZWhIeURoSEoyMG1FYWtWbWd2?=
 =?utf-8?B?cGZBZTB4cEtCTTJWS0hJbkpJTDRaOWxCdkh1K1ZMQ0JUZ0ZRWHBnaHZrZlIy?=
 =?utf-8?B?UnMwMGd2bnVxYjE2dE5MRkY5cld3TCs5Nm1PZUEvL2J4NGNLZlM0d3E5YkE5?=
 =?utf-8?B?OWFmMUlNWVhSbUxiU2xNaVZlVDhmL1RFNHd0d042RXNDRFNjNUZMT1p3OUtJ?=
 =?utf-8?B?TUhoSE0zNHZPOG1CN1QyRnpoUHk2cUJBOTd4ZEtGa01tYVU2K1lKdU1mM21X?=
 =?utf-8?B?cnFBTFVzRENZZWtnM3NQekhYVWNha2lHV1dESnZGcHR6VmdxcmlOUzc4d29v?=
 =?utf-8?B?NmExbGNGZm15Um51Q0treXdyWGpPS2dlSnBFbWVqbDhhaDVRektqS2VyeE16?=
 =?utf-8?B?dVowVVIwdnFuMUhnaDFzdklONjNEMHBaUmhhMHBJbUY0VGZNM0ZXbWN4dHVq?=
 =?utf-8?B?VXJ4cS8zeUg5dFI4ajQwWm1HbXl3WnIwNTI0QWs3VFZBNkhzODJlMVpxK1Nr?=
 =?utf-8?B?TXJ2QmZ4Q3RPYk41dlRvK1hwS0FkUHlNOWN0SExJcG44ZUtZRXNNOTRVVjRr?=
 =?utf-8?B?VGN1bnlUQUpoc0kxUmtvdm5maitrYVZWOTRPTElTdEhNVnlhSWlPSXpmSkpV?=
 =?utf-8?B?NmZXam8rZlJDUnRrb2xKZU43cXdCNytIL2I2d0ZqUUNVSkF5WEZVTW9TaFNE?=
 =?utf-8?B?Y0RleTNLSHpFSXduWGZ4ajJ0TitGQ1RyYWNsbkxWb2pZd0hudFZuM0xRcVR6?=
 =?utf-8?B?QmlKMUE4T3E5N0V4N0s4V2NqOWRzSUVuZFp1bU9CcG1heUtEZkQvZWJhS0JD?=
 =?utf-8?B?TDJ4Z1RXL0lRa2F4c1E1QmQ2U2cyV1VBanZLb3VsZGMxcG5lakhLYVFva1I5?=
 =?utf-8?B?SWF0V045YXBKT0RzY1hYOW1tNVArdXMyYUtLYklhMmxJYmo2akFmcC9FdDlM?=
 =?utf-8?B?QWYzak01OHV6Zm55aC9nUTdSUlFoN2QyQ0M4SkNLNVJuMjJrbDc4enluUmpS?=
 =?utf-8?B?d1ZyaC9QZXZqZ0NxREJTVFpadWd3OEE5M044MkltMTNhSUM0REsxRmtuM1Ux?=
 =?utf-8?B?SXgxMG9Fbk0xajc2VVo1N3dKWnBEZGNBR2orYmZlbzBZSjZ3cGdUTy9QMDNK?=
 =?utf-8?B?VXpjblZwSkVNOFF4dHMrSEV4OUdIeFdGak9MdjY5MmdwcHBFMll4bHpOQ3RJ?=
 =?utf-8?B?TWh1NExBeHlydFRLS3N4UExsMFBNZFhDbEtLbmc4dGxaZXlWK25Lc2NoMEpM?=
 =?utf-8?B?cTV6TTM3OTdiZkdvNGZPZjBoVmp3VzNLemdPK3hQMzFFNEtPbHJTSzBDditq?=
 =?utf-8?B?SklPV0ZaQWpPd2lCOEx5QjlTbEVCS3ZCb1ZRdUExNWkwV2NHem4zTSttb2py?=
 =?utf-8?B?Z0ltMlJGSGN4RVl6NmV4UXMxVExsb3JXMGRvdnpyMkV5bkVSS2lQQ3pvRnMx?=
 =?utf-8?B?SEM4U2lmWGlMQkVhL3VueWhYOCtsTmIrWGZoR05jNnRjaUl4aS9DM2lUbjdY?=
 =?utf-8?Q?oA1+wwb9e3rH+83Y=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204f09d7-f9fb-41ac-36b2-08decac8bcbf
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:27:44.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6dUKzlHDOcTVhZLRiJM3BrVYO7DGQw9ckL+7736iB0oEdNp1Z5td/hugsjl52eJmGr27ubr1nmw0G1Vk3KC/q+NcEe/pguFNRG3CCrPBJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8005

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its allOf
list, but the driver has never actually called uart_get_rs485_mode(), so
none of the advertised rs485-* properties take effect at runtime.

This series wires per-channel RS485 DT configuration end to end:

Patch 1 reorders the probe so the gpio_chip is registered before
uart_add_one_port(). A port can then reference one of the chip's own
GPIOs (e.g. rs485-term-gpios = <&max310x ...>) without -EPROBE_DEFER
from its own provider - prerequisite for patch 3.

Patch 2 splits the binding per compatible. Single-channel parts
(max3107, max3108) keep RS485 on the chip node, which is itself the
serial port. Multi-channel parts (max3109, max14830) describe each
channel as a "serial@N" subnode carrying the standard rs485.yaml
properties; the chip node is then only a container and is no longer
itself a serial node, which avoids a serial node that is also the parent
of serial nodes. Being serial nodes, the channels may also host serial
slave devices. (max3109 has channels 0-1, max14830 has 0-3.)

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
Changes in v3:
- dt-bindings: split per compatible so the chip node is a serial node only
  for the single-channel max3107/max3108; the multi-channel max3109/max14830
  are containers with serial@N child nodes and the chip node is no longer
  itself a serial node. This avoids a node that is simultaneously a serial
  node and the parent of serial nodes. (Krzysztof)
- dt-bindings: move the device/DT-model explanation into a top-level
  description.
- Rebase onto v7.1-rc7.
- Patches 1 and 3 (driver) are unchanged; patch 3 still uses the temporary
  fwnode retarget (idiom flagged above).
- Link to v2: https://lore.kernel.org/r/20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com

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

 .../devicetree/bindings/serial/maxim,max310x.yaml  | 92 +++++++++++++++++++++-
 drivers/tty/serial/max310x.c                       | 91 ++++++++++++++++-----
 2 files changed, 160 insertions(+), 23 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260525-b4-max310x-rs485-dt-ebff12af9976

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

