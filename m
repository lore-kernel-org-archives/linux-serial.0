Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010076.outbound.protection.outlook.com [52.103.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63C1EA65;
	Mon, 22 Dec 2025 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766379322; cv=fail; b=a6m7C/XJklH0+GSsp8DZ7u/sUX1AjWGE5ruQX2+6XdvRQDuZqI7TN4aRnUkvWzztbllt+2cCCq9D3YLRQ8bp/5fsEhoRS40cccsd3o1FuXJqwh6tup7EKbAFjc5YvTei4cAzZiAQ6yy0aPNJU62TAx+SPSiUadUsqbBuYPwltj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766379322; c=relaxed/simple;
	bh=ZSQR8TgMi01wBQE5VAuWLGiKxgm0vHz9do8mqGWiWmQ=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=pdmSN6B+z+zQfcw+0R6yIHyYa7cJqt/YnVsAVWhEPKTN0dv8XhlZlITLPAT4DjBSsr2eB+sfI9s7COVWNnxADe3PVqSluigeFireic0XMVh6YylQFQFMLMhpyyE6eF+AoXDDkzDThK4kMAJZ3pjmurJjunCHbJ6hn7hFqLiAsrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KOY87gVs; arc=fail smtp.client-ip=52.103.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KOY87gVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYVjCl2gt+7RTwtGYs59nMD2s7KpT+fmNhGj++XlX87krXIzXEoHdy1aP4cH1LOdip0Q6P/GrxPf18r+QXMoI+7evXwoQAJBtfIVS3ARVuc9qHSynNNfuBGX481gkliNR62R34Lda0elOdOq9rJqRq+nA3eMo0HYgeLXOgxhT8B3dvf+A3ItrWhluzyKGyhFLx4c1Zbfz/uLk82SwBonnnu6YfH6+7lA1NxThknzw52Pi5o3cTVR3ArnkYsPe0T2KCv6SqqYSmSV+af+AoK6/qb1pxsFU48g2lVvL2FidCwqgMgvVg3kQom9w7Rt8Qu8AMrvYIZ9VGCu6Fj+qFrBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IWYoAORmpa74wWfdWg+nM8NKfDaKciKxkPw4GD+mV4=;
 b=jvVEhNPyNT6kAW2mvtX/JYgfJY0Ko/pVHNDgOdvsdMMVZ1gVxWgr3JmkmMt8ZsAEeMGqrV/S5vWAKJQX1NzbYOJ9vbsTP+GLicHIYxBNj4v6ZGw4JfXvrLlrz5oK/E33wW/xZtxCx+V/6QUeEzfEcUKF/w8FpOcsP6G+Cro+h/QRFBkPOXR90L26+aKueOwyQ/uSOJW78V12LB85jqeqmL4kTZ3aEXJOFZkPwIbybR2p0n1URYydipz9BkZzt087FADHJ9Sqz5Ib4EsLaILNXoTPy+BxwRlQmPR7+uMHMtBJUqcQrAshxtk6CXMcUsmyP+XeZ5yMnjFQNd3LjDmSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IWYoAORmpa74wWfdWg+nM8NKfDaKciKxkPw4GD+mV4=;
 b=KOY87gVsZ1VCsIQRJkCGgnxxJgdxxQjBdl7TequawR60AS9dX+fYG9cFyTwuOYmm4ijIvNjMeb2YtV1AW1lT6rTTL/06e4wjJHhx6mGUEg31zFEN29UsSWNIZkJSEU2eNMAX1NNiWDtgqn0tWj4UIM0YAICKyYwcxKnoJNVx6KAgeV96VWaP0SNB/Nm5hqvCX9xP3DjH8HLverw9unBbK/C/ykXyUpEbDFdsw77ORD/8sIAS6Shgju00tViURvdjeEGrN8r9CsCmTEa6/+I2rxZPtafIoR+ab36gPsoyHWx02KJV+HPwEs4N2oY5NcyOt9mPt6Ezx7RJFrvBeR+6UA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB10033.ausprd01.prod.outlook.com (2603:10c6:10:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 04:55:16 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 04:55:16 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 22 Dec 2025 12:55:02 +0800
Subject: [PATCH] serial: digicolor: fix use-after-free on driver unbind
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIACXPSGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyMj3bTMitRiXXOTVLMkIzNTQ+MUQyWg2oKiVLAEUGl0bG0tACcT3Zp
 XAAAA
X-Change-ID: 20251222-fixes-74e6b26513d1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=ZSQR8TgMi01wBQE5VAuWLGiKxgm0vHz9do8mqGWiWmQ=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhkyP81pyDZMuxB7dYWWyo2ZO1S7rxM3CGz8UnFJWtL89u
 0bqTZxPRykLgxgXg6yYIsvxgkvfLHy36G7x2ZIMM4eVCWQIAxenAExkriMjw3YV2dfbM5iELQNs
 qsSv5pwrKvuo8aB5/tt7378tPrs/r5fhf3XhxdJbvPLb+h6Y8tiKB+7eNaVhqmz1Ik35vqhyF80
 jHAA=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::27) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251222-fixes-v1-1-7dfcc6ea9f02@outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB10033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b92b499-0de2-4309-a3e0-08de41164b05
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|19110799012|8060799015|15080799012|12121999013|41001999006|23021999003|461199028|5072599009|5062599005|6090799003|3412199025|440099028|11031999003|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q09WWkZZYTFpcGszVWdHWm9RSEw4SU1ZZkdlWWExVDI4bnQ3OG9EOFFMWVdi?=
 =?utf-8?B?VHhaSE5zQmM1dmJ3aVJMWW00d0QwMkxaTVBPYmRaZTU2UktmbVdNUlRZWDds?=
 =?utf-8?B?WStjd1FnNkg1M2p0R0JRSS8rbXJKbVM0cHdtNXB2TURHMXBZSzdaQXpyaWx5?=
 =?utf-8?B?M0ZkU2ZSWHVyMjJoL1VlaG03UWtoeU9vUVBFaXppSmtKakVQRENiSk1FY294?=
 =?utf-8?B?WGsxYWJYekExNWxTTUtrbFZYRWpQL0h1anJabkEvV1FzaEFKUUN6dzVuNEM0?=
 =?utf-8?B?d00yOEwzNTZtQUwyVCtucUhteURmbnZKUkwyN0hmb2NHYU1uSXlMVWlianht?=
 =?utf-8?B?WWhiaWpVelJobFZBNlhNMWkxajlnbWcvRVp5QnVxcGtjbHBURUNmWlRiZVht?=
 =?utf-8?B?aTNHWDczQzd0bTkwS05DN3lMbVpLeTNqNHBIVTUwU0RQRTlxQlhlZUpMQzcx?=
 =?utf-8?B?T1IyMEl5dDhEWnBlQjBWRmVram1VZmVLRXQ1K0hpNHNqRXN6ZHV1M3IyN1VM?=
 =?utf-8?B?RTcremFqUi9LM0JaTndXOGZEaUJnRERrT0txY2NyODhJTTNyNXYzaTVIajBa?=
 =?utf-8?B?MDVHUy9PMG5HTjR3bU9OMU5DQ2pCSzNpZDE2RGtKWUpPTnJ6QmRyT1FoU1RP?=
 =?utf-8?B?ekMvTTdJN00vM0FZa0pHVVhZUjg5Q09SeDdhZFhBajJiVGs4Vlp1QW52bm9v?=
 =?utf-8?B?YXk4c0U2d3J4Q0x0ZmxxcVZhNkN0SHhCMGU1QmxCMS9SOW5iZjJmNzR5TGJt?=
 =?utf-8?B?SE1FTDJPd0xrcm9XbGlCdVFlRTJDTVRKam1HbVFLam1NUWFhQTlKV0QreEFG?=
 =?utf-8?B?TkZkU1YyeTFDOStiTUs2N2R5a0QxcDNqbjFucmxEUHFLeTFzMUV1RDE5b3Ev?=
 =?utf-8?B?MFFlNEFtZWJvR1B1eWNpekxMNXo0U0RXVGRPdVlGdTZmY3VMR2FadjZFWHJ5?=
 =?utf-8?B?RlpBS082eUVDUy9haGRKbXcwT0hsRlhocVkxaXBPdHkxMFZneGR0dVZ4aGNE?=
 =?utf-8?B?OU9tQ3Q2dDgvZVdtSmdBZ1I2OEFwWlRSMGQwd3BGU2d0MWZraFpKalhVM1VK?=
 =?utf-8?B?eTFlOXBCZGlNaHluRjhUcFpCSzlwalppR3NZL2Q1bXpYc25ZQWVxd1RJLzg3?=
 =?utf-8?B?WGRma2RDTktvMUl2VCtkdFZMdDcwTXM4MjJCaVMvSXZFdUxBQ1N1aE8vaGhv?=
 =?utf-8?B?Sit3em43UCs5N3o1TU9vWlBheHFIb3dkczZxNTE0U1ZoeDA5K1lucWtwUTN5?=
 =?utf-8?B?Z2poRzFhSktONmZ0cjc1RDdlcFJNaHFaSis0clVLTVFSbFBWUWJLa2QrTDFO?=
 =?utf-8?B?MzJkdFp0QmdkS2J5c1J4S1U3QWVJRVNEbit4QmNOM0VKeHFSOExzalhHZmxL?=
 =?utf-8?B?WlI2eXdvZmxKbVZsK2I1Wmx3S01Vc0ZYYTFxNDU3TlJESHExUnplQ0xWQ3ZQ?=
 =?utf-8?B?aTgzV1hyRWg1QXpiWjI5RlFoRjJvdFc0WTZNeURqSUhyc1hpemJjVmhWcHVa?=
 =?utf-8?B?dHZtdCs1STFNVW5PZlowQ1dKVjhQc0xaOEttb2FUYVB3SDZVbk14aWxSdUhB?=
 =?utf-8?B?dGh0alhCaUVFTUoxMzUwWWFjUnRJZ25CSW5KOUFpRW0wbmRnSEkrLzhQT3BF?=
 =?utf-8?B?cmhxV0ZMUVVUdTcvMVhEWURvQ0dhbUhqSlIyb2F1VUlwY1NmMnFOUnp5MFor?=
 =?utf-8?B?TVk5RkNhdWVnSG5tNlhpUFl6WG8zakw2RlJDTXhvSkZCWlZUTHVKazVwcGFV?=
 =?utf-8?B?SnRVYktWODZjTEQ5YS9TTFRTNER6bzhXeS9YWis3RFVHUDZkZ1lvaURPOFl3?=
 =?utf-8?Q?V/E4Bbc41dMtSVu6ex9JPebPS6NAAQ81uGOlw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkhNWWFQREI1Z2lRRFdHLzFJbVluVEZDN25SL2U2Nm10T3F3bmRMT1dBSmZy?=
 =?utf-8?B?QmtnK0wyMHU1aDNXNU02MklteU5wSVBibGFOVHMzc3J3VU5MeGZ2Ymc3cUpo?=
 =?utf-8?B?b3REYXh1Tmk4b3RwYkk5c3phN3lwTDJHMWxXZE5NclZBbGZWLzNiRFZzNlJo?=
 =?utf-8?B?OURBc3UrNnpobnZGV3BCTWgvbHIxRmZISmx6L3dxSDFVL3VxQW5BN2lHMXJh?=
 =?utf-8?B?bzVqVDNnNFpsNmd1OHZlSXQ2czhRdDZDVmQ3QWtUZlExK0w2ZStLNkFqa0xC?=
 =?utf-8?B?Wnc5YU9INHo4Wk9vVkxXMVJrNHpmeTIrNmFXb2p4L1NYelFlcHFwRnY4SHli?=
 =?utf-8?B?djhvM1M1aWkxVWhvczlDMXY0VFJMdUp4MGovUEJTMlQyNGowT1JKdXEyVGJM?=
 =?utf-8?B?V0pUa1VwTFhxM2x3dWlqOCtZWXhrVkxGK3BXZlhwMFlMQUlJc2pIUGNBZEpQ?=
 =?utf-8?B?TGhDMFZEK25jWVkyejdjNkRWblpEeUdEa2VhZUZJdk1MYklyNXJIeFMvYzVZ?=
 =?utf-8?B?U1V6TW8xR0RhdzZjT1NSc1FaWWNzVklRdll6WEJrSkhma1A1ZE1MM1h0Q0s5?=
 =?utf-8?B?SWlNa1g5QUZMcXF1ZWphdXNSNjBINlJvWnl4ZXovQXcvdGZ1Wlowbys2WDQ1?=
 =?utf-8?B?WTBRdWFaOGNZMG5kenI0Vk1CQlVwY0dVYXphTkNSbjF0MWF3bFJFcS9zdHM4?=
 =?utf-8?B?RVpQdk45Qmd0NEUzcXloajZwZ3lNcUFQK3pWM0NvWGJQSHRxQ1pYbGp5OGJN?=
 =?utf-8?B?ZnorR0FNanNnQTJHbGdTYUNpMXpUQ0JRenBGaC92SERrL2RycGVCT094M2hQ?=
 =?utf-8?B?YUJKL04xcGtKREdrZGVQMVRCckZha2FhUUYrUlFKU3NYRHhlUndvWldnQTRQ?=
 =?utf-8?B?ZjhQV2tRL0V3NWw1UzhXa3lqak96Y2tveXIzWE9XbEJFb0I0ekJwVzVlVm1h?=
 =?utf-8?B?SzFCU2JheWJkZmNuYUNzRENRRjYwUU1KWXdBVlFuZjB4VXdLZWJDNC9TR29V?=
 =?utf-8?B?NThwQURxMGVSMDdkak15V1FiNDVlRGNzTUZOY1ViWmtHUVdRUzdzV01mR2dJ?=
 =?utf-8?B?UFg0VUd1dHdoUldCMXZhTzBpNWdWUGRJT1U3MXJjRFFTRzd4Nk9PRXVncUNw?=
 =?utf-8?B?N2Ivb2FWZk1UOWcweTNkQkY1ZUpoL0dickJETzNqYk9Da25BbDRiWWNOMzFJ?=
 =?utf-8?B?dWpBc1dEb1preE9tZjVwM00yVDY2U2tHd0d4aWZ2bVBTZWI4RGpHaEMwTUVD?=
 =?utf-8?B?L0pHdG9OclY4VHpveVVpdXJ0V1FxeWFMR2U2dEpDRFBEMzg0bEpzektyUngw?=
 =?utf-8?B?VkRSNmZWbXcwMFBFaTI5bTBxL3VHZFN0NlNRb1JyZVQ1STRwQ3R0VWcwbjFQ?=
 =?utf-8?B?MVVmaTF5TGlYSE1vTjIzTGFWOVhyaFE3YjZuMVFNd1ljTTU4N21DUDd3R2lI?=
 =?utf-8?B?VGlEazZTeFdlNVA2VnN1RmdoaHBPR3JOOW1IQUZnRkVqdVk4THZPd1VBanFH?=
 =?utf-8?B?eTZVVzJPSHdUV0ZhQWRMTzduUUhIYzE0djZSZ1M2YjgxeG5XaXZYL0k3eG5x?=
 =?utf-8?B?cUgzeEw1RTRiSG5EYlVJWWRSSWdQOUVqeVZLUjdOSEJQS2RIMEJuU3pwelRX?=
 =?utf-8?B?TlNvRm1RR2picHFaZzNuNHBQYnBlMUdLS0pUWms0SFFNSE5TSFdWNVZ4dThL?=
 =?utf-8?B?MzdpeE10TWlQdFlWVTROZlc5VUlsd21RVGtVeExOcDFFREtLRWVuVmVDNzFG?=
 =?utf-8?B?MFg5SVJOTm8xVVhyR0g1MVZGRWlseTBCRXdhaENscW82WFgxUVROY3o1bXZK?=
 =?utf-8?B?VlVkTTZQRklUa2tvcko3TW5VWWFjUWpwQXU4RCtrWllqOWJxZ0hieFh0dWs5?=
 =?utf-8?Q?Oz06it2ijxLzw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b92b499-0de2-4309-a3e0-08de41164b05
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 04:55:16.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB10033

The digicolor_uart_console_write() function accesses the global
digicolor_ports[] array to retrieve the uart port pointer, which
can lead to a use-after-free if the console write occurs after
the port has been removed via unbind.

digicolor_uart_remove() leaves a dangling pointer in the array.

Fix by clearing the array entry in digicolor_uart_remove() and
adding a NULL check in digicolor_uart_console_write().

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/tty/serial/digicolor-usart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index d2482df5cb9b..5861be2072c4 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -397,6 +397,9 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
 	unsigned long flags;
 	int locked = 1;
 
+	if (!port)
+		return;
+
 	if (oops_in_progress)
 		locked = uart_port_trylock_irqsave(port, &flags);
 	else
@@ -508,6 +511,7 @@ static void digicolor_uart_remove(struct platform_device *pdev)
 	struct uart_port *port = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&digicolor_uart, port);
+	digicolor_ports[port->line] = NULL;
 }
 
 static const struct of_device_id digicolor_uart_dt_ids[] = {

---
base-commit: ea1013c1539270e372fc99854bc6e4d94eaeff66
change-id: 20251222-fixes-74e6b26513d1

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

