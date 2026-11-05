Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.83.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793862786;
	b=YyYY2M1vRI8ltQhZzLNtb8jRBnsop4fYyWHGS3ahVSGfmtRr4MQxvQmdGoWGkRbkULXj
	 vBFWIghKyrhCsJgQlS76AZNLQTgeVRqsHfHTsZ08yHvh5qTzCa3WurgCgS9oSniNLoOyF
	 4M78GZX5m99v31/PZqEzbO2mapcwOMRu7dRhEdzKJBJfysdfY602kBsmbCoTivAcBrNPW
	 UeOtbTwnAmxRYY1/SRck2jGN1+SmW2Sk405kuiOkAq4h4LqkZ5zPTScIWkf6yX0m4vuAi
	 RrOl5KlT9h8IRAavkMehbaE9gtAuhje7Z3s1KaqbVCPNz5xoHKILRas1U4hedcEjdVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862786;
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
	bh=NKd0qhh0Mp9LEaBKsFhmgSQ2vmOfq1rjbIvW/25DcN0=;
	b=5SyfpvNq754vgPpKTeAbXgOEuHc5havEdFEHdqp1gyvr6YC1ahfZYgDQ1Xv4A0TFWqbS
	 GpIga47BIVFxwn66cN1M0qkfKLsl65OPg22YlPmOz+aGxepcTOlxVkyO1azgrAqJcJS5N
	 EchmucRLG1yx3sCvmiNeWJ6sVleZqyxkY7hLzka2KnugXeYqYZRe6gQJ05Y8ESiES77wa
	 O7c2DEUALdZSPJb7ZD/5xtsNpk3IdkBqqx3lalwIieLD4u8zKKKAtBeqEZGK8xmUquXHH
	 YRxvKpYNvi9iDH7NhtRAAsR4cBwI0qMDfgYMZlZpi7YkYPawI2aDGAxonCaqPhjFm6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=H8WuoPfy;
	arc=fail smtp.remote-ip=52.101.83.138
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023138.outbound.protection.outlook.com [52.101.83.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED414606A328;
	Thu,  5 Nov 2026 07:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED414606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=H8WuoPfy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUSFTxVERQ72NJKlGH6wU/aSB2+9ZNraiRm7lrOJJw3sq3HoT8k/Re84hGeZZsyXTQZBNqThfKZlpcdIg/P3kwJHGWvi5nYN3P1kBBWLQNii5JLADW9mFtpRBXQ6j87LgkrttWEEL7sLtBeF+lJyc3YiGC/NbNt1LYMaZ7f3uDx25xSZ+ysw8xjmnJhSTeG017MAQxl2mWU1OXKUt8MDmqneGkOsspxTQTbblArK5ZdmgUxBvhmVI2mgfd0RIZZlKd20iHEYVyPvA0LKi72RksaqkFIYpMrJ3cRLnOu1Xdg114lyAV0/Clfy6ONsJA2GF85e6YFh2V/eF0OfBEUbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKd0qhh0Mp9LEaBKsFhmgSQ2vmOfq1rjbIvW/25DcN0=;
 b=mdQ/w8WLD9r9WUNWLb5QveSRKmRwB/d1Y5S8N1kNXcUOqhNFtjV00A6DAeeGDP1oj4kJQuYuvhtId9QdCtWJRUOINpAJfA0jl9C3EGwvLjJcKXPRFQY7uILmNedXnTl4LaZwBJbTuzLbar7D0x4mHHpvJV6H1QKPUkoeAcagYoxahBaV06o1+quMuaNpc+9Zp362KbtFCC8xCNqImrr/CAet8pZkves8uy9mnAmOYgrSiEt4UohMlWIHQiPCUajh31h+3D16mjRcOLNWnHrPSJJknmqJpvmofnl8WMFp3uNquyEkciZqlHO4VSPKjnd8qABQswmZ5ukfqfHQtYksqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKd0qhh0Mp9LEaBKsFhmgSQ2vmOfq1rjbIvW/25DcN0=;
 b=H8WuoPfyXpvoxffbM5NgQtdh7FaXPS/xOU/JJvYA3vw3AY/a0pBux/ZokB+dqhj5lbtvQ9BkVXdZMgYWfsy3y3HngbZ307fdCs1w0cs0oQyo0smt0Y0wTYLnfzeevzzxTa7li/CgBJGQ+aKz/ZE12636hIaZFw3MYEyB67a/BrvM02Ox7V08epg1AUecwOK1d4tkokyttCwF8bYAe1JvnJ22n8N8rSEYp05XqjMtz1MmaKNudbaXosN0/rLgCk+ikXE6OO/1YoG3GR4VMQi7V1EJjJ7gvf+rSrBiGJ7TmCZ61s1SNx2MHQ0+MD7uSAcYG3SId1YvlprfiqPMRTCBKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7877.eurprd06.prod.outlook.com (2603:10a6:20b:3c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:12:51 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:12:51 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 05 Nov 2026 07:12:21 +0000
Subject: [PATCH v2 2/3] dt-bindings: serial: rs485: Add transceiver
 interface select GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-serial-rs485-mode-gpio-v2-2-027e5348892f@vaisala.com>
References: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
In-Reply-To: <20261105-serial-rs485-mode-gpio-v2-0-027e5348892f@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793862767; l=1621;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=yEC8bjKKaOOGidH4z68y0b0FadnxW+OJXS+c1U1mxPU=;
 b=PLEr4D0UsPsbcvA6o4grxZVf1eDxCrGThkMZkx9S70eTl/0fF/JmbIRNhE7zhVfSenmvTBquy
 bTAwRR8IP6wAja9yVq4Tj/lUGn8Xsg8JgacnHWP3KNQ4bhKdXCNAyfl
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00046789.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25a) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: c15e9ac2-c22e-4ca9-2d45-08df3b0c346e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|52116014|376014|1800799024|366016|38350700014|11063799006|56012099006|261102123227099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	p4PTUNgFTcRjwUROGPjUt2chSr5FFRvnuWnI1kArnv7k2dhFjs2f84yHYR/fBgbkRSuqlD4qktYgnF1ZiFpVK5oeU5sZdvsGX5RetYr9MOWjRm8tpOoYgZXFo44yhbPrtl8l4NcS4aBSOPsPkKpyhldb/YYywbZ2iS9DdHVpt640XVxX742QKqUmjt/1/aVgwZljKT/LPS5GTtdges2m3DqGG3gRqqJ1YS+x5E+JZqXLQW43IztaWUM65oeFAKD3heAqt9zPTkos2LJhbpm1d3y5OGPqVGdUYF3L80n9BwC3m3GK2f6AaQUGTMlN9EV92saoBQd4/vtHfdmXpDAtGv8YI7l1QxTA8lHp0vUwL4mylesrQ2oqlhTBvutCJQACwc6B/rSuAgW4JoOZEoK6/HkIY7NITWj1oSzkxkW67iSMOA2TtQs9C9LUgW03Kz6R47Dz1ntTvtjQp6aYzXOamJ7Ezgcpbx+9CCZeZ3OyCq50cGSBPa0OZlj8LhgyKVAjxoBRDzBcE2XeSUjW7Nt4zUTZx4BKG/xlQs2TKxPBfRFKGb7WOUih9hb8xct+3FvWZABqO1jUi/XoNtAsnAbB2vgQ9ozEaIxOAOBWlFWYhBlItcD0aYmDdgFSgfgZWSe9Q8zVfEvKPRYkHqvu0F1HXaBEa6SA0pa/9arwPyE0z1J3z9mG3aUE6pY84XnxX/lDuyUMLqKBWT1vTJL/c95YcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(10067099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFva0xJR0FxaUpPVjEvbVRWSGJmKzY2eEFHbS9KQ1M2NXJONVptb05uZ0N0?=
 =?utf-8?B?cGFQc2JBbTNSQ1d0NmcwbHQ2Y29tUktpNjF0OVl1Rm1ldGpSYjJQUHV4T25K?=
 =?utf-8?B?MXNkY3VuVVd2MVk4dkplOUlrR3RXLzIyWEpzMlhqcVllZ3JLSFZzeWZlcXgr?=
 =?utf-8?B?VXJOaUw2dEI5cjZoZGZlZTZJK2dTYWplaWJGVzRWZitRSjR2Y0NVMVRpRUdu?=
 =?utf-8?B?OUNON2ZSeEVnYzBzcUJ6MS94U0YrbTF4NjNadTQwd3I5Qlg4dmxHdHBiM2ln?=
 =?utf-8?B?aU50RkZ6U0hldlV0NGY1eUdsYUE1MDBQYVFONk9jLzNFM24zemJ3NWQxellP?=
 =?utf-8?B?SUVLRWhUWDNxRXpwRGJwcnRST3lWQUt2aE5ibWkxblcvWUF5dnBWeGhBd3Nl?=
 =?utf-8?B?VnBuSkVoSExRQ3dROGJ2Y01ySWlETE9vSW53aXRMNGtSeCtkc0p5ZkNxNzhl?=
 =?utf-8?B?UXBpblBKckl3YncxbWVRb2RiM0d6a2NNR01TQU5NdzhnaEIxY1A0M3pzZDBT?=
 =?utf-8?B?dUJ6eFFDa3BpckhyOGJNRlVKVlZFdm5XdzhSd1h4NUR6dm10a3N5cEtQa2RI?=
 =?utf-8?B?THVESUwyRzBtSkJlZ3R2MlNVSVJBbzk5K0VnZFVnczNOSW5rN0VRYVJkU1Zn?=
 =?utf-8?B?NXVBcWJhcnV5bDIwUDRLdjBFdEhUZzBmM05wWHFSUG13Vm1SajRYZm5yNW55?=
 =?utf-8?B?cnV6OExtQ0dwWEwzdXBBdWxMalgwKytQS0ZZdXRWbFZEYXlUR3dUWXg5MW5m?=
 =?utf-8?B?YnpHOVdTUEtEdjMyNlp0THlFOWZQc1F6THpwNGtsbHJOd291MU9TS0lIa3da?=
 =?utf-8?B?bEFybGlGeWI0MUhRa1I2cnVnbGUzOHFqL0JrMUg1Y09uV0pIZEtiZEg1a3Bp?=
 =?utf-8?B?VjlMUjFENUN0NS8zN0w2SEdsYVdKV2VrUHhDTHMzOXBuQ0gzRzNiaEh4dXJl?=
 =?utf-8?B?bzBTOUxJSjdySFZ5SVJCNC9ybDlOYUFqQ09IMzVydEpGRjVPTkxBY1Y3ck1l?=
 =?utf-8?B?NjYwYVpTMkR1K0dYanZ2Ym5XTWptMHVYalA0RUhROHlrMENyU2pmWDh1WjVX?=
 =?utf-8?B?Q3RJSkpQUUZuZTVPeG1nT3loZkdQMTdORlh4ZzFLbGx1ZHhieDlWbDBQVUx6?=
 =?utf-8?B?TDJtbkdtaEw5eXlvNHpRUWVLblpKdnNoNFhtaWhHcHVRVVhBOU9QKzFocUV2?=
 =?utf-8?B?TkNxSE0rK3VFOHMzRW9TMWE5OEJJbTRjbG95UjhIcUNXRVBRWm4xN0NtOStV?=
 =?utf-8?B?a1d4S1NQb004ZjcwdFNtdnhHaW5IeDlKK2NrSUltS3ZPTHlqSzlDL1ptTHpv?=
 =?utf-8?B?MkJyd2hsTUpDK3orNUh0aW5RbC9EVWRmZWVQZjEzelU2azVrb3ZORWlpcFRh?=
 =?utf-8?B?NlJMc0toQ2M5TSt2VjMzSDgyMXR2TEpPRys0UUtraW55T2ovelUxdG80OHRv?=
 =?utf-8?B?aEVPUGdxc0xoV2w5cDl0ZGhxT2Z1YmRRWi9IS050R0lGTG11NDh2T1ptV2Jh?=
 =?utf-8?B?Z3BaRC9yMHFRN1E2K3VBREdIWnRlYmV0a2RKM3ZOL1Joc25oZitoNG1jWjJP?=
 =?utf-8?B?SG1SV3FDanpVdEZ5Szh5bTk1YllaRzZpRVk2VjJmNHc1R2o3VW1yTitzNHhR?=
 =?utf-8?B?YWNKVmprOHhwcFdQbG1iTW9XNHpxVWw1bGg1OW9mWmNHa1RuR0ZONWJRclh6?=
 =?utf-8?B?Tm5rVzdTRE1PVWkvQkN4akRVQWN4TnJ3alRGUDVtdkZaQldvYkJ5MXB4bXZt?=
 =?utf-8?B?WXdqcWdoY2JSN2hUNFhPSGFzU2R3VHpXRk5DMlFnbEpHbHRNZTlDZ3dXc2M4?=
 =?utf-8?B?YkxuSkhUTE5FRWVVTUR2eFE2TWppV1RQTmltWHZXOHFWZ3F0bjMrL0JBNUw4?=
 =?utf-8?B?RTA0anZmTkxtUGRjVmRZUCsxaTZRRTdRRlpISVVtWVJEbTFiS0pkRURDc1hT?=
 =?utf-8?B?Wk1ZeDU0d20rckVVckFkYitIeHlGUlVXdi9nSjFHU09idjFXSmtWblVmRUcv?=
 =?utf-8?B?OWU5Z3J6NFlmUFl6bW1IMDl1MHV1ZFBxcTlUT0NxLzNobXRYWWE1Yk5FWHhQ?=
 =?utf-8?B?cmRDVzlnaWVaT1hsN2cveWNrVEJwdlFXV2p3WVYyTytra0VFRENrZmJiZnpj?=
 =?utf-8?B?azN3TUNYZS9yeUJkdWM2SDF0eVZyK013NnVUQTNxUjVMaW5tb3lJeFE3VHg1?=
 =?utf-8?B?VWZGRGJWVHZ2Uk9tc2tONG9hZEluNERDaTZVeWdOY3hYaTFkNVV6eWJFelpP?=
 =?utf-8?B?WVVXamhkeEVHMys5M0lpcDJwOTRrLzd1MGdBZnBUUTBkYXgzMnJGWnRMVTk0?=
 =?utf-8?B?ZklrNitWbUkzbEZaQnVlLzlRS2Y0RG5BUlFlT3pZdml0d1BYdjNTUVBOaXBS?=
 =?utf-8?Q?qmGADHgHJA3pxI0g=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15e9ac2-c22e-4ca9-2d45-08df3b0c346e
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:12:51.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IcTqw3HXK+QaHxop2WJOWnaP8rIayGqwwT+GiY9ZPGYv73iRpqoWXl/v760OCT0Nn0MiXm2CvP47JaI15KNRfxcxlpmNwrHmhXRMp+qoQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7877

Multiprotocol transceivers such as the LTC2873 provide both an RS232
and an RS485 interface on the same bus pins and choose between them
with an interface select input: on the LTC2873 a logic low on the
485/232 pin enables RS232 mode and a high enables RS485 mode.

Add an optional rs485-select-gpios property for that input, next to
the existing rs485-term-gpios and rs485-rx-during-tx-gpios. The active
state selects the RS485 interface, the inactive state selects the
transceiver's alternative interface, RS232 on the LTC2873.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index b93254ad2a287ad496f791e3ee90eb9defa0609d..2b5fd405e164f308b6036331edce7eb61da2f3ff 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -60,6 +60,14 @@ properties:
       the active state enables RX during TX.
     maxItems: 1
 
+  rs485-select-gpios:
+    description: GPIO connected to the interface select input of a
+      multiprotocol transceiver that provides an RS485 interface and an
+      alternative interface, typically RS232, on the same bus pins. The
+      active state selects the RS485 interface, the inactive state selects
+      the alternative interface.
+    maxItems: 1
+
 additionalProperties: true
 
 ...

-- 
2.47.3

