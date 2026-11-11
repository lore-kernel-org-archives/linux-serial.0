Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400109;
	b=DW4c4FzocvuScexipDtue721nYSUfJYfBLufHYMvcikNM825CjzCb+Z6/YbxuvUzWq34
	 W7gDRx+P7W+5BKbFVcf4N0dLZ7xTFryCje8hrdRx9ftTEptRxOCFzY9r79RP1LNrcPrbb
	 Nh5qnW6FqrIXxUj+AKB6mQApAibeAoU+0UR+IP9pG9GmIuIbr3bmLwvm4v5arRzd9T/NO
	 kQyJ0d2w1lm1eYpR0g5MuffQpBozGMuhHcwTOLy0CS+0XRbG2fsMr3/Z92hX5YGnoDNgC
	 H8wjGSQk3m12klC9qz54duTq7q5UEQlkSyk+/oPtkzhrLMeaI9RxQ73/ZC/vZPYuvuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400109;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=apewl56pHpx4biiezOEDT3L4ElVYgufIy7WM5C6gGoI=;
	b=RBQlaPgCwkr6Vjn1g8wcLnCmmr8kk3O0YuHKc0k3FPaKs69dcmBYkHA1rXtxIzP0Vnmw
	 c5mgUofiYhpaNkB8O4/SQxpYzsQyKr3GsfgZUeRjVDQCWqLPEFQvVp1jFhnNYfwjwr52/
	 VhCKJZyOW6h53bjjZx2e3+But8k6yhT424eiJWTANuXE1jqZkWyDBM7hqrKca2UKBabQr
	 HUd2+HzF7tbDskopxAkjJvVLGRhMkUwBfmcI7DyoUYLBH3ij8Rm3GQQt3SCAOJro2hHP9
	 E+YLhFzpQpskIv8VsMpUL4p30SHiMr5MU7PupfeQFw4c+g1C7yPfyagLnF+X+yhMKWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=gUOahmtn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.122
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023122.outbound.protection.outlook.com [52.101.72.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F505606A324;
	Wed, 11 Nov 2026 12:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F505606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=gUOahmtn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGpYb1y0OhuN4ic1pZN99B7T8z5JuDjkdAXCfuSgLONKK0XIkQs1S2uueCMicGkTtDntGUl43LMPyofeTSJPfCDAn9brRsOuj2+qgi6QkqUxm+KPgf6v9iQLrbjdIZgCQG+G/j6fLKcbOJqsggpcQqcvX/eyZOBKM3BXoyqovVYleC9B5pcP1s7yAepiSvJao7icDZ0162BprMJQxXkAkhKg6vqxvrCU2l0oF1mEdBDHfXb2asB5waUX7p6TaOlsJIME5WKmWYEXnMr61wYbTaHSuV90gBO8e/+ZsqEf0LglPYxmVdUmTu/6d9nEU5qlV6SWpNMBMe017BeZ/KzmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apewl56pHpx4biiezOEDT3L4ElVYgufIy7WM5C6gGoI=;
 b=SH5hlkjascymZis3XTRPuaGMIuxY+HaytmoNHVGOHx7YvwaI5L10EkltMYxhRk4/x1DWCsRJpLTMZHzLxqPeXyQWVNNDI0aNOeVH14/qdMyDNkumS8XQZ3n53CG36JQaJJFU6Dc66gvNnYNYaBk+sEpjSVqa4fu0XGjimk4vG/FEwx7t6zwyLe7dyiUGH7rQwJw5TCxJXxmrEXsddNkEB2Jfut3z3/HKHMhjfzri+qP83WexNgEJAiJGfS4Rd4jPUFPO3SmdMOVZhZgb8o+kOoMhLyLGkNmZRbWN8p6LBLwd6HtnF9q7KoOcwaRAZ9Cfg5571dib/mjtcpNqiUUTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apewl56pHpx4biiezOEDT3L4ElVYgufIy7WM5C6gGoI=;
 b=gUOahmtnFAAl4nBb5IwCwzaCHTvCpS6czSl0N/1NuBv2QN/eHlWoImcyHbhiyNBIQlrBl7VqTw+vHCWil7IllUl1EcHcj1eRN6wSqP85Agk9F6Dqz5DmgJdEsPuVn3rBLRN99XxUoFX/X5P4PUZB97nxCZJ6S1glj037xll2Q0NQMzNArUp9PgboNuMnrj4fAOGl5kjWL+BaBxcsvH8RlDCZLcZmnFons2pzJOzURM1YREDPIhqhyN0kLSY8f7WmlB3V1IaVzT1gpqQLYQIrpnL12d8dNvCYPR1LIdk9eH5F3bqNcObBmcR+k55ZH4nj9r6YZG9cf9BWj0GMsYJ23g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI1PR06MB9023.eurprd06.prod.outlook.com (2603:10a6:800:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:28:21 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:21 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:03 +0000
Subject: [PATCH 4/7] serial: core: Power the line transceiver with the port
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-4-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
In-Reply-To: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=9862;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5AvjNdVFXdOQYfSfBndfzJsUbBnaeF9Z5rUWUKIfNOY=;
 b=TMhho8ovsy2G2Isq55kyosYkfGmuWDlrwYm/GYzhmqI7m7Injk1m/8OPOZ+sMmDmDOpVVYhtJ
 7/5G/EgrWjiCoIglAbdAGeMSNSC5OpPTgK55xiGU3/Vvk1M25BmGh6q
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: BE1P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::13) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI1PR06MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 227eb1e8-39cd-4193-8e2b-08df3fef443b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|23010399003|366016|261009223027099003|10067099003|3023799007|261028144727099003|261102130727099003|261009221227099003|261026140227099003|261026121527099003|261021123027099003|261102123227099003|261022075727099003|261021121427099003|261022105027099003|38350700014|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8QWNYpz9y+oT4JLiPqsTu0MdMhTR3NxBbzD2wMOv9qolHTKwcsC56zIxwMM08xvU/Co3V1bPldQp4SXurA6bxAni5nDBKaQ1oZY8LcyL5hYCMrFui+jFN2UBX/O91tkw7Jj7ehVzHoKXZgpB3VBpNqB3P/UHQhXJ3ua/UuVUoefYOZ2SEgYHLlF9TQ9ePd5znVJSkUR4tZdAA1LEjx5LGo4mLwPz43e4+lpWd8OK10m5hp9cOqjdhNvA9V0g4kI2/GOTpxpuk+yHrzl9h7g/VnsxlDd1X8J3wa88rqicX1pQ/oGzsIXdMXmp+TFcUHs4i2T+N12TOKLoA2dj7959N79mhTOb9U9ogED1ddMNTnXDJMGWnIzuAO0cDVtQH8UBbwG8YPObFwC8LyVE9TfdezRb9cUh+CDZG5sTlk4uFY4CjDzxs4urVs8eOqLStdjYLFHw8UBApL2WVCJOQfcPiUt4tHSSJ2mORA3hm7EimuIt8sRoOcp+mFT4NgW/pyDK4cM/4vnIBpvSG4iu0dh718oEsW38Opdxsw0xkC6jHvcWd6Le8183IPHYUXHVNuRdT2ftaveTykbJH4eQGZn2V7OWoocUsCw2Dnh/m5+5G6Tw+LtTiWJoh0j1qESV/6Ez7GIJWoHRMZoPib9M9N6yhzyp6mGKsr3S1rJd9xdt3DN+FVhK9CDmBGBuTsGwsHxaGFzGPBcL02BXW5YTD4a3HiXkVnmHC/XPWgbWLwZ9Ctk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(23010399003)(366016)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102130727099003)(261009221227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261022105027099003)(38350700014)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNkN2p6RmdBRWt1V09aVFpaeWpTUDNxb3k2eXZYQXJnZXVRN3ZKbWl4K0dV?=
 =?utf-8?B?Uk1qTE11bUpQdDAzandndS9oZUFyUGgzakJVTTFOZFZaQkJqeUg5OXBKRFRR?=
 =?utf-8?B?WkNNL004ZC9pZTQwcjBHL285Mk1MNEppbG81L2c0MDJlTjFsNDVWS2pvVlo3?=
 =?utf-8?B?cG5WZHRYS0hxTkczRHlnbEVLajBDcVZzOThMb1cyTTdsd2ltWFE1djRQZEYw?=
 =?utf-8?B?Z3BaZEZLTEdoSnRpWHpHWVZVYzhtUDkvVm1RczhOL3pVMmdGSEZBdnkyald0?=
 =?utf-8?B?SkpUUXpzeGxIR0N2a1hBSGdCMjR6SUxrNjJPVE9acERLcHp0Vm1KRUR4ODF4?=
 =?utf-8?B?VSs4T2dvRFArTHdmUU5zMHlXWXUrNFo2THJ3R1FpVkQwNzVaQUVwbE5mblY3?=
 =?utf-8?B?VWo2bDNyQ2RRR1ZrVFZ6ZkhKNlZrTk5BT0ViRWo0QnB3R0l2dnJDSSswWXdW?=
 =?utf-8?B?NmdHSzFvb3Z2cERrOGRTVlZ2djV0TjBaWWszbVZmbmVWN0VXTVljczRsT3Jy?=
 =?utf-8?B?eE42NXpMWGt6Tm1pbTlmM1E0UDhvT2U3Y3RtTUhiZzlLOE1DaVc1RXljbnhY?=
 =?utf-8?B?WGFwSDFPdk4vMlRub0gwK25seXVjYVE4QmlGT0lvMUNrRiswQmY5eXBId3B1?=
 =?utf-8?B?clhrMlNvT0JGbTdpVXpKWnU1aUVxNzFZY3dRK2t0L05aeHp5ZmdPSi8wY0gy?=
 =?utf-8?B?aXR6T3YzTkNJbVlkTWtQcmlUazNsSkVtRUc5SXlYRWFIdGNEMzZkOEJ4S050?=
 =?utf-8?B?TkQ5NVJrOGxPMFlRdDVEK2tPR0hSSmJtSDBuOVJDeVV6b1dwNkpWZVIwanAz?=
 =?utf-8?B?eDRORFhMSU9SUElkWm5oMWNHd2VLaHQwUFBTbHQyeXhhMWo4QmlsNlhTbkM0?=
 =?utf-8?B?bXBnSVhTVHVjOHVENXB0bHpHbmdrZkZIQmpCSzZ0MXEvcUZKZjk2eXZqREdI?=
 =?utf-8?B?SGVDNDFsUllUTjNxYU9VaVNKd2lSVU82SUFEUGFmRjBMd0JkWGsyZ05ROWwz?=
 =?utf-8?B?SWtGeStNM0ZLSDlXeWxKcENCaTJLUGhFTWJhMzJheXhIa1EvZWpkUDJ1WkNV?=
 =?utf-8?B?QzhzR1d4M1cwOFhSbEVHNDVWN2p0aUsxc2pmaFc5YTBHVlJyYUNneUsrNE5y?=
 =?utf-8?B?Nm5DaGVLVUozL0F4TDVZWmdLTEsrRjFweWdhR1ZlbXhYb09ZaVlyUnVmcnQ5?=
 =?utf-8?B?WS9YN20xV0x2U2RkbzR3MXNYUXFwNlV3dkZkbTFTZnNkMTBUTnhqL0Fob3Vl?=
 =?utf-8?B?WUFMNnFyYTNaU1lNZHZzWmtHQWNmanN2RVhJcXR3MUJMRDNVZHlDWUsxTjY1?=
 =?utf-8?B?V2p2M0dRWFUyTS9JTWVGc1FBUld2K2xaNEt5a2VMQWxMY1M3VXluREo0WG4w?=
 =?utf-8?B?N2daMlhpNWxLSlo5NlZQaTBCT0EvenFmQzFJWlFpbCsrRmhhRXk5ajJpZy9n?=
 =?utf-8?B?V3RhN0tQRXdMdWcxTlRkcFU2V1ZyaExRTlhtYnBNVmxTaHFpclhJWkJKbk5S?=
 =?utf-8?B?b0lKWjA1UHB0ZmtvSFBVeXZtZlY0alNHN2t5cWtSTGExdERUR2MwOVdsa1lM?=
 =?utf-8?B?VWpiclc5YW1Tb0VrUHZFR05qRVE1cTZ0R2N4SkxWV20xclg5QmR2TUo4QlFr?=
 =?utf-8?B?d3hEQzJQa3VEWXdzNXpHdStETHJka0FaWUVCSHdsN2pWcXRHU3lPeVhYNDZ6?=
 =?utf-8?B?Qm5ZUjlpbHNMQVJuVFZUMVRocXpYTUo3Y3ZCbXF6UUpyTUxab1VkTlJiRHFT?=
 =?utf-8?B?QU0ySDN1SjhneFNKajRHU3dONHYvQm9PWnYrTDQydmZpWDgydm1RREJwZE5o?=
 =?utf-8?B?V0JUN2JHS2p3MTdtcmdWcjNwTDN3QlBrckNGRk10Q1lQVm5UbkZPNk91YzBS?=
 =?utf-8?B?VDVQZ0Q0Sjk1ajJ5dkF0NGtyb3pETks4c3gzZ0tSNlVVc0diclpNWDFReGJN?=
 =?utf-8?B?R3VYeW5mV3dlS2dvdEF0S1Exb1lxM2VITmx5QjFaRjVKVC9GY25LQytLTXlt?=
 =?utf-8?B?QUpENUtZNnVMd09kK0dxaVk2TXZEN0xBeHBGQTB4T0RKNDJKVEJ5NTY2TUtV?=
 =?utf-8?B?QUJvOHJBMmc5TjBCMFVGT3VXRkdoN3pvekdUaG5uQlpRK0JqdlU4RXIvcmUr?=
 =?utf-8?B?SllVZ2kvaGRZRVJHeXVJbDNxMHNYeEwyT2ZjTVNFeEljQ1J5dksvbUZ3anpl?=
 =?utf-8?B?dlVDNmdpZDV2U1kxN1Q2WkhUZnJJZHBmM2E2MUxacTVjUEtHM2xtUUZwaUxS?=
 =?utf-8?B?Z2JCTERvRCtQNzAwSFVacG8zRlp0R3VsbDBZWCtFRkFNVnFJdDhzSDlJYXVN?=
 =?utf-8?B?V1M3d25scmx1OCtOYjh3dm51d0xMbmZJYWNGQUV1YzRoUlkzZzAwVXY5SlB4?=
 =?utf-8?Q?QVjc5cyaMhEVJP3o=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227eb1e8-39cd-4193-8e2b-08df3fef443b
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:18.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfrMUEwwgy0GJJAHkGBGXW0DPb1skTHxVE9xQFMfUVrmKFgQxV+20u35SOTq4hTY4ohRNDekCw9GFN3KSTEtR0AhfdLoRXm9bLQz3DZr3s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB9023

A line transceiver that can be switched off stays powered for as long
as the system is up, because nothing ties it to the port: serial core
powers the port up when it is opened and down when it is closed, but
the transceiver behind it is unknown to the kernel.

Implement the transceiver properties of serial.yaml. Serial core
requests the enable GPIO when a port is added, so a driver needs no
change to support it, and from then on uart_change_pm() powers the
transceiver along with the port: on before the driver powers the port
up, waiting transceiver-startup-delay-us for the part to come up, off
after the driver has powered the port down, so the transceiver is
never switched off under a running port. That covers open and close,
suspend and resume, the probe-time power-down and the brief power-up
for /proc/tty/driver. Whether the pins stop driving while the
transceiver is off is up to the driver. A console port stays powered, as
it does today; its transceiver is switched off when the port is removed,
after the driver has powered the port down. A never-opened console gets
no shutdown() at removal, so a driver that three-states its pins only
there keeps driving until the power-off; a console on a removable UART
is left as that corner. The GPIO is requested driven inactive, so
console output between the request and the power-up in
uart_configure_port() is lost; earlycon output before probe depends on
how the bootloader left the line.

On a port with the transceiver GPIO, the rs485-select-gpios line is
set from the port's RS485 configuration at registration, before the
power-up, so the transceiver comes on in the configured mode instead
of the one the line was left in; RTS reaches its RS485 idle level in
uart_rs485_config() after that. A port without the GPIO keeps the
order of the rs485-select change.

The lookup goes through the port's device, which is the chip for a
multi-port device. A driver whose ports have a firmware node of their
own requests the GPIO from that node with uart_get_transceiver()
before adding the port; serial core looks at the port's device only
for a port that has no GPIO yet, which serves single-port devices. The
GPIO belongs to one port, so on a multi-port device it has to be
described per port.

The property is optional. A port without it gets no GPIO, and serial
core behaves as before.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 99 +++++++++++++++++++++++++++++++++++++++-
 include/linux/serial_core.h      |  3 ++
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6c0a6d9dcb851b6db0acd91143e651bcb33ce5ae..d36bffaa100b89b519e84c20df2f61f507e6e89f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2348,12 +2348,32 @@ uart_set_options(struct uart_port *port, struct console *co,
 EXPORT_SYMBOL_GPL(uart_set_options);
 #endif /* CONFIG_SERIAL_CORE_CONSOLE */
 
+/*
+ * Power the line transceiver along with the port: on before the driver
+ * powers the port up, off after it has powered the port down.
+ */
+static void uart_transceiver_pm(struct uart_port *port,
+				enum uart_pm_state pm_state)
+{
+	bool powered = (pm_state == UART_PM_STATE_ON);
+
+	if (!port->transceiver_enable_gpio)
+		return;
+
+	gpiod_set_value_cansleep(port->transceiver_enable_gpio, powered);
+	if (powered && port->transceiver_startup_delay_us)
+		fsleep(port->transceiver_startup_delay_us);
+}
+
 /**
  * uart_change_pm - set power state of the port
  *
  * @state: port descriptor
  * @pm_state: new state
  *
+ * The line transceiver follows: powered on before the driver sees the
+ * new state, off after it.
+ *
  * Locking: port->mutex has to be held
  */
 static void uart_change_pm(struct uart_state *state,
@@ -2362,8 +2382,12 @@ static void uart_change_pm(struct uart_state *state,
 	struct uart_port *port = uart_port_check(state);
 
 	if (state->pm_state != pm_state) {
+		if (port && pm_state == UART_PM_STATE_ON)
+			uart_transceiver_pm(port, pm_state);
 		if (port && port->ops->pm)
 			port->ops->pm(port, pm_state, state->pm_state);
+		if (port && pm_state != UART_PM_STATE_ON)
+			uart_transceiver_pm(port, pm_state);
 		state->pm_state = pm_state;
 	}
 }
@@ -2638,6 +2662,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		if (uart_console(port))
 			console_lock();
 
+		/* Select the interface before the transceiver is powered */
+		if (port->transceiver_enable_gpio)
+			uart_set_rs485_select_gpio(port, &port->rs485);
+
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
@@ -3282,6 +3310,12 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 
 		if (tty_port_initialized(port))
 			uart_shutdown(NULL, state);
+
+		/* Only a console port is still powered here */
+		if (uport->transceiver_enable_gpio &&
+		    state->pm_state == UART_PM_STATE_ON)
+			uart_change_pm(state, UART_PM_STATE_OFF);
+		uport->transceiver_enable_gpio = NULL;
 	}
 
 	/*
@@ -3364,10 +3398,18 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
+	bool core_transceiver = false;
 	int ret;
 
 	guard(mutex)(&port_mutex);
 
+	if (port->dev && !port->transceiver_enable_gpio) {
+		ret = uart_get_transceiver(port);
+		if (ret)
+			return ret;
+		core_transceiver = true;
+	}
+
 	/*
 	 * Prevent serial_port_runtime_resume() from trying to use the port
 	 * until serial_core_add_one_port() has completed
@@ -3378,8 +3420,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
 	if (!ctrl_dev) {
 		new_ctrl_dev = serial_core_ctrl_device_add(port);
-		if (IS_ERR(new_ctrl_dev))
-			return PTR_ERR(new_ctrl_dev);
+		if (IS_ERR(new_ctrl_dev)) {
+			ret = PTR_ERR(new_ctrl_dev);
+			goto err_put_transceiver;
+		}
 		ctrl_dev = new_ctrl_dev;
 	}
 
@@ -3409,6 +3453,14 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
 
+err_put_transceiver:
+	/* The port may be registered again: forget the GPIO */
+	if (core_transceiver && port->transceiver_enable_gpio) {
+		devm_gpiod_put(port->dev, port->transceiver_enable_gpio);
+		port->transceiver_enable_gpio = NULL;
+		port->transceiver_startup_delay_us = 0;
+	}
+
 	return ret;
 }
 
@@ -3710,6 +3762,49 @@ int uart_get_rs485_mode(struct uart_port *port)
 }
 EXPORT_SYMBOL_GPL(uart_get_rs485_mode);
 
+/**
+ * uart_get_transceiver() - request the line transceiver GPIO of a port
+ * @port: uart device's target port
+ *
+ * Reads the transceiver properties of serial.yaml from the firmware
+ * node of @port->dev. Serial core calls it for a port added without a
+ * GPIO; a driver whose ports have firmware nodes of their own calls it
+ * per port, with the device's node retargeted, before adding the port.
+ */
+int uart_get_transceiver(struct uart_port *port)
+{
+	struct device *dev = port->dev;
+	struct gpio_desc *desc;
+	u32 delay_us = 0;
+	int ret;
+
+	port->transceiver_enable_gpio = NULL;
+	port->transceiver_startup_delay_us = 0;
+
+	desc = devm_gpiod_get_optional(dev, "transceiver-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(desc))
+		return dev_err_probe(dev, PTR_ERR(desc),
+				     "Cannot get transceiver-enable-gpios\n");
+	if (!desc)
+		return 0;
+
+	if (device_property_present(dev, "transceiver-startup-delay-us")) {
+		ret = device_property_read_u32(dev, "transceiver-startup-delay-us",
+					       &delay_us);
+		if (ret) {
+			devm_gpiod_put(dev, desc);
+			return dev_err_probe(dev, ret,
+					     "Cannot read transceiver-startup-delay-us\n");
+		}
+	}
+
+	port->transceiver_enable_gpio = desc;
+	port->transceiver_startup_delay_us = delay_us;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_get_transceiver);
+
 /* Compile-time assertions for serial_rs485 layout */
 static_assert(offsetof(struct serial_rs485, padding) ==
               (offsetof(struct serial_rs485, delay_rts_after_send) + sizeof(__u32)));
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fe90a8aada98cacf5a80f20ec2a91e249c92d0ed..419d7b46302e5627f7bfbf0b3e658fde37e06a96 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -580,6 +580,7 @@ struct uart_port {
 	unsigned int		custom_divisor;
 	unsigned int		line;			/* port index */
 	unsigned int		minor;
+	u32			transceiver_startup_delay_us;
 	resource_size_t		mapbase;		/* for ioremap */
 	resource_size_t		mapsize;
 	struct device		*dev;			/* serial port physical parent device */
@@ -601,6 +602,7 @@ struct uart_port {
 	struct gpio_desc	*rs485_term_gpio;	/* enable RS485 bus termination */
 	struct gpio_desc	*rs485_rx_during_tx_gpio; /* Output GPIO that sets the state of RS485 RX during TX */
 	struct gpio_desc	*rs485_select_gpio;	/* select the RS485 interface */
+	struct gpio_desc	*transceiver_enable_gpio; /* turns the line transceiver on */
 	struct serial_iso7816   iso7816;
 	void			*private_data;		/* generic platform data pointer */
 };
@@ -1341,6 +1343,7 @@ static inline int uart_handle_break(struct uart_port *port)
 					 !((cflag) & CLOCAL))
 
 int uart_get_rs485_mode(struct uart_port *port);
+int uart_get_transceiver(struct uart_port *port);
 
 void uart_get_ioinfos(struct uart_port *port, char *buf, size_t size);
 bool uart_iotype_mmio(enum uart_iotype iotype);

-- 
2.47.3

