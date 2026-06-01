Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FE2BE65B;
	Mon,  1 Jun 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309568; cv=fail; b=BlgAJZK0RHH3t1t4K9A6rMDQ6THYSF+fB9OXR6DVe4tFitYGEqbXeJOvFsFHVyZ09jen3oYsLuDFBI0kZQFpDSIhl6HQKJPdO1erWuYW3tCHnz58PbuHv1qDxqGY14YhH5h8eBMQlsV6dbpUTVUr3iJ4i6nHH0HHbebPOvvY/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309568; c=relaxed/simple;
	bh=eafmlWUhr82pQIFFXJx8Zsl6ZLF2wK9PVOEe52rhB+Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ti4xw3MJg3J1LSB+sxgxEKW6jMJEdGUWJo6wd5ktjRIDsM3wUt6gXHzF6JcVoD+gqPpMqGz48kNGYinKnUPm0l/MWIyVN2wLDDKqQB7Z/L/cYs1EwxxNAZdB6N8JNBiMTbzXvpuOEa/NO4aqlpONFbd6NgGiqoQprlZH671kB3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=KMc4ndbm; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="KMc4ndbm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOOF1zeHnBJriWxmzkkvVPy6lkhJBIa1A+EbsJg3UbOJGDNYFfgQl9Lb6m1pq6ToHeyJzCRLqF31yG9M/GdBxSwZub+jTLy9EB/JoY3S1GnKocGDKR/Hpjk0HVa8D+FDF/+A5AxbS3dkm0iIfKIqrYjbFkk5Po/i9W0eJM/BB5UEq6NV06KjRdznWKqv7NPd5dAf/d2OP6EN5wEp3V/TLZ7uqUoWYAwn+7tI3/QP4cJSf7ooA/DefyXykXhOEm+xxpgrGGcuR4lLNBFj9/x4YVycVvmXJJZ5aAJftze5jvCN9ucWuQSxMo4DHjGkLtOvWYPvTUG8c916TnRFUl1KJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkMAS7DTn6mm+dmxi5v4vykTAJcH1vP3sRzrceVqXPk=;
 b=gbXYm9eYz8HyXHFj9P/hz7OUzhBO1zrSIsCBseVk6jIS43dDfLLGPPZiKvZGeJ5t5maTqa1oi6m2WrdYhhZFhoq2lAWmMRhlDQyjzPaaBaZVfoM7rMxZWXFYgE1LruKbW33E62i1s5/AAvz96gt/rBn9tDqTdFsGUZTtpN5qqECQcFQZ8zB3Q+rWyk+Z+TxNOyDr8bgpgav3O0xdQxzUifwgAk8XiWx8dkt/mlSPtB6Z0+2gyvDA0iPZmWKH1whQR+nFHYGNm8X0HskcjdNRLqelJUzatwau6Nj2HV3uN/lyb+QHzhCn0V/S6Ery0zpTiafq3+sDyK3jJiH5tmrwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkMAS7DTn6mm+dmxi5v4vykTAJcH1vP3sRzrceVqXPk=;
 b=KMc4ndbm+Ni76QYqO8kV5pXZzGq7xgE6IjRoQX40CcLXF5SIOLu1Zvzo4DHd3pCTZacQcbBIk39Xu6VJTJ9gV4vUqnAZHzTvgo5rtB4JlhwqDJPVSFI3Oi3Uvmj6dhCw2IBnuDhslJLHGXgvDrjb9j1fZU9i4vpdhcY66ttza4G1w/PuoVVpBIhe2ut7irAnHb3+IxA4oTRmd8/AYKScDoqXnq+RpwBjFOJ8aBLeuRbnXI/NBNKqAT070tT2CiTzSM3BYLGDzlaIoyZ/r48d4fWyBh/JxYYCSgAdRw7EDt9Rrfnq/1TfHQhmT76zgSMG6n3aaI1YQios1wxcBqjXVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DUZPR06MB8775.eurprd06.prod.outlook.com (2603:10a6:10:4d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:25:44 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:25:44 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 01 Jun 2026 10:25:33 +0000
Subject: [PATCH v2 3/3] serial: max310x: honour rs485 properties from
 per-channel DT subnode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-max310x-rs485-dt-v2-3-a105105f8e70@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309541; l=2885;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=eafmlWUhr82pQIFFXJx8Zsl6ZLF2wK9PVOEe52rhB+Q=;
 b=QKB26e/vGdvChC8mv4lMJj6MDQdoFpD/ZZegC1NnEndmvne9TKxhClWbc4d7PrxKQW5mNVNEz
 blOLKY0H7dJCuEsAC1//wuqxmu+Ev4BRzrJYfdchz0EBla26TU3p/k9
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
X-MS-Office365-Filtering-Correlation-Id: cb9af783-afa7-4aa6-58e3-08debfc8236a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|22082099003|18002099003|3023799007|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ZW6WQEbUAB2WiOBj0S5eNDyB0jpUvwviSZdH0J6tVCbMTSeA7Pf24eFAihFPRYJYI8ZH3RYH0ak6wGSHqsMHNWdL74/J1u4XWSa99GdMSeC7sjScYmPA88PHnrcoWoFFf/vTGbyym+Rc2AM6FdD4TcndKGQyGW1R2kpcdTHhlNPBC1kLPqkGCpMsvyuSXuuKWfeTKbGfxNrqZsoy07DnHGEtrqBOfwgSAvAg632N4MgQXv7FmxWk2fXbRtjDr4YMG7C1XVj8HlZ88cn49MuDmh7Ih8jgVy3Oe62ndG2oLYABCXOgtG6Q43hS2y7RhiH0QlzYhgUpMTd233eE6GgTW38qMGIl353JF5Ox4zfk55034HYimciV9JXUn6M+XDGSRjsH6zi0dLj+YtWFTXwn4/HC5UOrxEOmtIyucZFIhL+3Mva/eo+WNSXjFT+iBb1mieAEUoIFomczUf+qR2Sy8fh0LPiVRm0yp9PK5JbH3fQn5wKwo2KC1C67mWIwg0LX0O/aA6zDtNmp/7wYQTi5LHfzxZApSY+EzIcYnWlLB1kKwA2cahjSo/XYPebmaxVxWyACPzRUsCUTuRQH4LAVM18DkAMP7yp6tlnPwFN8E1LTH1QCG5nlYxtxhxzEvtPHFoH9w6rai2Ep7Otlz48dzH03rnftsfbdRAZKaSF4NybiRehxYjJsp5RcUiUbVV6grYEnbjjzzKMuPJzXBYxCfCRCXm6ek0tRi2epGkK77I+EeXJ/tZrecnVSSyKeyVkP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRFckViRmd5ZWFyTUpOMXFZWWRhMklSNEZ2WjNOdGMwQUFiRm9oWFdvWUxu?=
 =?utf-8?B?QWpmT0JCUkNKZjFoQWl6YjB0bzR0VktaaGpWYWJxWjl1UFdCRDZMcmtPSjlh?=
 =?utf-8?B?V2ZSOFhhZWJuNVpLRWNCNGc0NWRtZkFRK2hMZTlEd3k1aU9GUkt6Y0xnVzMr?=
 =?utf-8?B?ejRiMnNvOUlsSXhiZ0x2Sm96REdJMmF5N2VqcFh0Qjc2Zzg3MENoa3UzeVY4?=
 =?utf-8?B?bDJ1dnpqZzBOUE1ZaVNDd2MyeWViRGJzZGVBWGM0NlJUcm5HNlBmaGZWQ0NN?=
 =?utf-8?B?QzFodlphYTNIOFNEcllKOWM3Q3RZYVhTQ0hQY1E5RGs2d3BnK2lEdUpqS3Fp?=
 =?utf-8?B?NlkrNTVSYU14dzFyay9CaS8velhkVncwaU5xVTVrcWZhZzJzSXZzV3d6RHBh?=
 =?utf-8?B?U0NyMXhsQ0tRblJjdU1tY2dJTU9SVk15TXVvN2tDczFyS2ZSaDFSOVo2cjNS?=
 =?utf-8?B?eVJQWHZ2b0EvcFAybFJuUWJQRHJob3o2bFVsNXREVkVXTTBhMkNmMjlET3VK?=
 =?utf-8?B?bExBNVZYU2dvcmNPZ2JFUHVOUStsYi9UR2lBRlh2N0c3VHhJcEd3eEd2ZVNk?=
 =?utf-8?B?ZlA1blVGRGlTWjNjODd4UU1IMTExaVJXZm1HSFBDdGVKcE1OcVdSejhaaFNs?=
 =?utf-8?B?eTd5QzBEUlVTWC9lNjBmYUcxc3JZQkVUMzROd1FhbUlsNEN5NzBFWStFVVpK?=
 =?utf-8?B?Tld6Vkd5SGxTWTMzTU1aMTFxL3pqVDVyS20xS0tDYlIwNEJuQUhOT21IL2R4?=
 =?utf-8?B?U2oyelNLNG52Wm9IVDFRL2xoOXRvRHZZNDNHT0FKdWVJdHhvcmZHdTNoNnRU?=
 =?utf-8?B?MHlpS1NTa202Z1ZjQWVnOTFDUjlLNWQ3M1YrTDlMZEpiNDF1YVBlOVMyQStL?=
 =?utf-8?B?WDRGYmxZTjJPc29xR1RIWkxjY2dHN1BmbGYxNmJHUzVTNVZVNWtlYTlLR2x0?=
 =?utf-8?B?Ykl3cmsyeFRiejUvb2k0SDgwaGE0YUJQYzNMMHRuSjNuMm1USS9sVjZ2VWUx?=
 =?utf-8?B?cEd0RmsweUJRWEhraUMzdkJYMURweSs1bEpSdXZ4UGRQZzg1RHg2ekJ0Y09L?=
 =?utf-8?B?bTdkZVBjV3pmeWVVYUFlcUd1Y1Z0YkRicm1VOU8wZzlRNnRlNlJxaUYrMXJq?=
 =?utf-8?B?Y0ZERTYweU1CamlDd09yMHZMRTNDc1BrbHhDTUNPeVVGQkwvalExcU5jUWNn?=
 =?utf-8?B?NW1mU0I0RGJxMURHUXY1cmY4VTdLTlUvSEJaRUpTbU5Qb2x1WnBBMmVtUHNr?=
 =?utf-8?B?WUp1c3U2S3Mwek5BV2k1Mkx0TmpDMUdkTzdWY2RlcXpoR1YrZXVXZkNzZGZI?=
 =?utf-8?B?NGNjQ2g4aFRITytsT1RsYmRsWm5zK2d5VjBiSzk4S2tsVnJCdVk2cDNJZUUr?=
 =?utf-8?B?NlA2dWlhMzJFWk9KOXpINHZKbDRyS25CNjYwaXNUME9sK09jU0dlSzFuci9N?=
 =?utf-8?B?OE9RaVBlRW5ocDB1TlY5MWdWTXVUK3NSODRlT1lmUkE2ZEpaellBVGgwKzlF?=
 =?utf-8?B?OGZIWnpIL2t5Rys3ZFhMQ1gxWXdPa3V4Q0RZUFZmNzNVcmlXREVLaTRCSFp0?=
 =?utf-8?B?bjQyR3Qwdks2T3ZsMzVTNmJ5REtYZ0I2aFNReEpFeVZCa0pkZUV6Z1VPUFZW?=
 =?utf-8?B?MXRkWkE4ajZUQXNTWGFUNmxlL2JPY3hHbFB6WkgrRmQ3VU03allqTVlKb3dh?=
 =?utf-8?B?ekNnZHFES3VHSXZtanBtekRybnFDSXZnRmtCNHdjSmNLTStiTnNycUxyYkFp?=
 =?utf-8?B?andPQ3RRWkVKcFJDTnFQRDVFaXMzV0s4VHRDU2xpalFQdEZuQkhuenFOOHFm?=
 =?utf-8?B?V0JQSmlOVW9pNGpCcHd4N1VhakhvbngzTXlqbjNhRmVoanljNmpmeGY0WkZN?=
 =?utf-8?B?WDNyM3pQM2w0Z083bFR2VC9KUFE1aTdtSWZJNEhmY1QvSFI2amI3U0hLNGxB?=
 =?utf-8?B?SmtteTdnSndRNGRlMUZHcks2ak1SRTg0TWVtSkEzR2Y1d1dwbnptV2RydlZr?=
 =?utf-8?B?QnFSRm5tWFJIc0NDUHRIMkREUGtjZmpTMjJPWFlSTUVsUm5yTjQrRGlLZTJn?=
 =?utf-8?B?QVlOSHkxRm1mU0FzbGdQa0QwcWVwQ2hXb0YyQlBxN1B4U0NnNFdKbnQ4UzRk?=
 =?utf-8?B?YlRiUUVxSXRxNTZJblMySlVSZHhlWTVnODlKQkkvblkvajNxYVg3VzBOQzNL?=
 =?utf-8?B?SkJVenZBcWczMktSL0cyenQ5Y1ZmVnpvZ2FTSERuamlIaXByVUY3MnRCeTd4?=
 =?utf-8?B?NFphVFdxUlBnQkNnOUxVQmtVL1pDeXpGZWpFaUl4clI5d0crMFhwYTgxTDlG?=
 =?utf-8?B?Vkx0Y2UrSlFLNk1oTSs4MkNwTlhPNm1JY1EyMGdDUEhFazIwQkVocENUc2lQ?=
 =?utf-8?Q?UL41zcAlhJNkY0I0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9af783-afa7-4aa6-58e3-08debfc8236a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:25:44.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwHh+TZBA1nXLE92Ho2cxbPEjmHQipE2EP8/VBdxHVGWoBwlBxR//DRFeeLWAy9ykXiqv+uf0Ar+5EhRdLfPAyJNs+w5E74YZCRdmVaAbf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8775

The MAX310x DT binding pulls in /schemas/serial/rs485.yaml via its allOf
list, advertising the rs485-* properties defined there - none of which
were honoured at runtime, because the driver never called
uart_get_rs485_mode().

All channels share the parent SPI/I2C device, so uart_get_rs485_mode()
called directly on each port would read the same chip-level fwnode for
every call. Walk dev->of_node's children for the "serial@N" subnode
with matching reg, and temporarily retarget the parent device's fwnode
while uart_get_rs485_mode() runs, so each channel picks up its own
subnode's properties. Probe is serialised, so the swap is safe.

For single-channel variants (max3107, max3108), fall back to the chip's
own fwnode when no subnode is present, so existing DTs that declare
rs485 properties at the top level keep working.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5cb7d01e404663dc25b88bc7b4f8df61be2135ec..aee3b75fff000385a7543f099663c8a0e4a7d014 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1426,6 +1426,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 #endif
 
 	for (i = 0; i < devtype->nr; i++) {
+		struct fwnode_handle *saved_fwnode = dev_fwnode(dev);
+		struct device_node *port_np = NULL;
+		struct device_node *child;
 		unsigned int line;
 
 		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
@@ -1435,6 +1438,40 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		}
 		s->p[i].port.line = line;
 
+		/* Locate the matching "serial@i" DT subnode, if any. */
+		for_each_available_child_of_node(dev->of_node, child) {
+			u32 reg;
+
+			if (!of_node_name_eq(child, "serial"))
+				continue;
+			if (of_property_read_u32(child, "reg", &reg))
+				continue;
+			if (reg == i) {
+				port_np = child;
+				break;
+			}
+		}
+
+		/*
+		 * Temporarily retarget dev's fwnode to the per-port subnode
+		 * so uart_get_rs485_mode() picks up the per-port properties.
+		 * For single-port variants, fall back to the chip's own
+		 * fwnode so legacy DTs that declare rs485 properties at the
+		 * top level keep working.
+		 */
+		if (port_np) {
+			device_set_node(dev, of_fwnode_handle(port_np));
+			ret = uart_get_rs485_mode(&s->p[i].port);
+			device_set_node(dev, saved_fwnode);
+			of_node_put(port_np);
+			if (ret)
+				goto out_uart;
+		} else if (devtype->nr == 1) {
+			ret = uart_get_rs485_mode(&s->p[i].port);
+			if (ret)
+				goto out_uart;
+		}
+
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
 		if (ret)

-- 
2.47.3

