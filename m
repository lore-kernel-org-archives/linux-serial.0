Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055B20EA2C;
	Thu,  7 Nov 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979988; cv=fail; b=UC/l2pUCj2wTGdslMIOvTzc8F3alHbEEfR7gPBuc94XT+IrSOZILKCKaL1ns9v1Wz7k+5ciwZZJNUiyyTqhsE5OxXNSylsg5v72isywiNIVND4wm+1G2H+/CnVaSTPDm9ig9x9CrEuDkLMydUuOslyOBbNARJUdZcCMkL5BdQys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979988; c=relaxed/simple;
	bh=9BS8rkL1QTTXNs58BG8bOTv58bYul+z+3qK+ATtGVwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Br2qPmLiqHsS0+8CuVTfc0tCopft2U+0zwQvgFocjwXoanfV580eh8ELoD7NaK0rwT5w2HIKW9NBdcj4r/PRGHAY5ns8eRMq1T6mU0fge0j54nPnv9sknE58LQdN8gv4KgMGKg6HBvtqjQDHvZbvMSfj+TmTCo7a77+Uv/V/Q2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Aa247MX+; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Aa247MX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIhTLDgj4LNyYwZJoPOdfcerFmqlHecrG8WWkoicek3Of6xAzfjQUJZBwQbtnizaeb2x0yXOexFTrVdVEOtRFUJvhp+W6xgpsoxy5zP0mR5IKvK26tUYQpJj/AISMMdJAVWGmLzIdtGQSdLZ/q+vpvjQrngeTwUPN7BthAJZH4bAu3PwURNTD9YLTPDg4jVkKOoJeGJVZDiBQZnDomsxK/QLG5jBqHaS2UUgkdk3CkSoTf/LOZMcOPRAw95RiMfIvc79LeB6SNsM8/z7bQWcU86kVet+7znbtazqK+K+JaCb9SDyWleoFJ0w366rpZ6OtEbCgyAGy2DTXJMF51IJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=hLn9ci0cQSgBteF78wEgCZyyIrQebPY2S3dNjNovnano6yYDHvUI212xJaYSMLj3RKl4mHedfjShRwezad5KcU1NtknDBhYS/KQ5uOXQ1Gr6ov2rZwqQal7HVcDkAoYPR0BKD4013jSQ7roivh1fuBChdlk6uYM0nLCBNClzAIWk0fzZ8PYhgxKsjYljJtDsW8pCnoVw/aBXMzHADxYQqWS3qjUFtfKxdHPofeTWric6sn1+Y66nGwN8mLc8sY2R4yv40a/yDgz20aT0YHeKMDxGtrPgBJ3yvdBGabmoaDdNtj6u+SYxi2v6MdnY5isKCEJpzSeFB3k/oSIWi/DASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yspjoETqEAdBLiFSRO+LbYk8sVc/EX4lsqm7Ql8O2EM=;
 b=Aa247MX+UByWEDmmg8oVEHTaVLpSM3nhy35/Pgt2ZW7OoRsiN4INZ3YY2GNhrHQKlYe93DV84F02JbFzOvy2exktURhrwJEW8OXyjzSgpcZhpP8NUeV37PbMKa7+JN8h8soDalSiwvd4qSVWSlsM6pVzO55SKqd+p9ZMgnsyCMv9kS1gbzNX0NR5lF1xzcUYORL+ppRHcoEaum4RtnkQZFmMOMBRP0HH7cdW6iqGgi4nEb5L8dUvsG/g6jmdW3JbHaNTcaeN/2pVu8MMX7udlxZbr8CQN0uxb3MnJWaaHmyBXyA7MUvD8mOcG/b1C1O8kXwNsgoNA7A9w/BEvGgB/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:46:21 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:46:21 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 2/2] serial: fsl_linflexuart: add clock support
Date: Thu,  7 Nov 2024 13:46:11 +0200
Message-ID: <20241107114611.758433-3-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
References: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:208:55::19) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: c9045ccc-782e-470e-82b4-08dcff21cc3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFrOEN5ekxETVBOYVdyN2l5LzgyOUMxbGFmcjNtekU2RGNkaVFiNFF5L0l1?=
 =?utf-8?B?WkdtWjU0RldzcEQrck0zbU9WOEtOanNBSVpEQlcra3ZRaUFESUVmaE5pVC9Z?=
 =?utf-8?B?UTlZSEQ5d1RySXlNRjlhajN6eDMrWFZzQnhRcmxUZnBnYm8wTURqR21kQkR3?=
 =?utf-8?B?TFV1UzU5b3FySitYalB1K0I5MTNrby8wcmNMd25KcHpCQTB6YnAzVW1seHZD?=
 =?utf-8?B?cXoxTEk5aVRjL2FFY0NzenBrb2hBeEhreFYvNktJdUJMKzJQM0M2Q1UzOS9C?=
 =?utf-8?B?bHlMa3pseEs0UlFUMFpzRjhRNTFJZzVGOHg5VzI0KzNaakpVaTVvWEJVZHg1?=
 =?utf-8?B?bk9rQzhQU0NUMnUvTDc1Qm1jTEgwUXRQTE9hQjhwQm5EZC9WR25raTFsYkZz?=
 =?utf-8?B?ajdCaE84ZmFoMnpUS0hjWEc4aTBua1ZqMkRiVlAwTVFmeDVkelJ2aFNvb3JU?=
 =?utf-8?B?TGx5RnVZNHVzSVNsUUNpUFVMVkgyLzNVdlhZTnlZdkc1ajBSOEY0VUhzL3NO?=
 =?utf-8?B?NlhWOFMxaU9jUGg4eHNRNjdxdEplWnE5NVVTT3NEQ1gzd0hPdlJUc2xWK2dD?=
 =?utf-8?B?eHAxckZlS3YxcU1lbkU1WGtFZ2xyMFZ1eW1BcnB5MDZRTENRRnJ3M0RYZkxY?=
 =?utf-8?B?R1p5dnNsRCszSkxjRGk3b2xUY2ttUEU1QXljRnFQb05kRHVmdFlMT1Q5QitQ?=
 =?utf-8?B?RzlRY2FyVmdCKzRZRHRKWlJhQVZIUDJpYklEbWJJVE41SXZiRFgwWkxieUQ5?=
 =?utf-8?B?UFN1cTdHM2ZqaHYzTml3c3lvZ3JWMmRTdDAvSnhGVGxmT3BYcU1PamFCZ3Zp?=
 =?utf-8?B?eWtuaEpwaU5CM1dsQ2p2bzVSTkZTTWJjVWo0NVRoems3aThjVnVNU2FNZmpm?=
 =?utf-8?B?cGplaEYzckx3WXNyd25QMkV2T2Z2QXRqUGlOZDJySTE0d1hJUDMwSHlQQ3RY?=
 =?utf-8?B?UHdWclZ6RXNQczZBYVFBNEd3UVRLMDRDNGNsQTIzNUt5bU1Jbkd2Y1FmTHJK?=
 =?utf-8?B?WUw5U1dxS2R6YU1EZGZJOW5oNmRZcnczN1RTdmpaUWJXblZVV0lsa29aQXZF?=
 =?utf-8?B?S1V3ZXc3STQyVEc1ZkR2T3JVb0VQUTRzU0FnVHEvTTZpaGErYVRjUjFLeEtW?=
 =?utf-8?B?QkIyZDZ4SmxabDVtcXZuMVlMakhBdklCdGw0QzhndEZ2dFV3SUppU2cvTmpP?=
 =?utf-8?B?Z2xKNndXcjJqdzlqZW41Y3lFWXVBTHJMTW96TWRtM1g0WEQ1NFg3NW00dzFI?=
 =?utf-8?B?SnNXTlF4ZC8vQUZEeFpiRmM2TXFJM3JXdlBCN29EcDg3M1UzbFJLNmFXbURE?=
 =?utf-8?B?UEpONnJCRTl6UnZHaUVBMHZrZUc2L1VDVHMwQ214M0syUWNiaWgxNUJOREt4?=
 =?utf-8?B?dUgxWWtERFV5MG8zRzc4UW8vOWF3YjNsbjJzaHl2THQ3aldmTjM5VCtWZTh2?=
 =?utf-8?B?dmRwT1JhcWIrcjlYZlNhK0lOREFXR2tTRXlJQncybU1MVmUxV1N5ZlhxRUxU?=
 =?utf-8?B?a3plSmQ2c01wd3hqRWhpczBtR2hLUmpXeUpOK2JFZ0RtRkQvM0tQRmhNQ0xQ?=
 =?utf-8?B?b3BQdmlKemROZUNjTW9JbGlDTEpoYnJPdEtveFRWZ255MStoajJGM2x2SFFs?=
 =?utf-8?B?cjBaRCtuVEFPQXl1TnI5MlNNQ2VZMGtYb3ZXME9lTGcyb2RHYUM2WkltSG15?=
 =?utf-8?B?eG5jeDlyQlF5Rk9CR0REY1ZpbzdpUXBuOGhCangyQUFZTzNHcjZYdHBvL25l?=
 =?utf-8?Q?bLGTYI72aRW8D5RtnHQqa7oHyNm5CeD4toTQ1gZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVMUlBNK1A2QTljaGtyWE1RZ3NreEZDaFFYNHowT0NHQXdIZ2tET3E0Wlhk?=
 =?utf-8?B?TGJEamNkaDd5RGcvYU9qOWJKTDU4UGU0NlpQZ2IvSVQ0djRxRktld0Z6WjlS?=
 =?utf-8?B?MVVuZlQ0bmFieDBHNURGQW8ycFlObjhIQ1RoQnVXanhTcXNLOVUrUmJWZ1hW?=
 =?utf-8?B?V0N6ekhQZ2VTdFJhRko2YXZIU0NFMDh3bUlOR1NyeEdQWm1zVnpZalFVTy8r?=
 =?utf-8?B?YUpoc21wZG96bDhJSHJsZzBDakVMTUVHaTc0NDkzd0JaQXVmbFZYak50a0Fv?=
 =?utf-8?B?YmRobUNBWDFuS1k2RGgxdGNLeXFkNEs4RDNIY0Y3TVI2OXlZRmt1WVdUby85?=
 =?utf-8?B?eTRnWGI4RjFSYWJYTkhGWHpEOE93NDlGOEplVmlxM1p6UFdma0YvN0NaNzhz?=
 =?utf-8?B?bmNZVzM3M1VIUjhYRXhsSG5QUW96UHJmZGMwQTNTdGRUY1REd0h2R01QY1Zl?=
 =?utf-8?B?L2tRSUpIR1M5bHp1Ty9xSmVHYWdmYVk1RWtsYktHaTJlVE9yamFDdmhCclBm?=
 =?utf-8?B?VHFRZFlZYUhUU25DaVRENGNyNWFSZzRROW52WkYyRjFGRkNTM1Nia3FWR011?=
 =?utf-8?B?Z0VTN2t3WXFNVHlKbzNpeFIrZ3FtWFlha20yc1FCSDhsVHM4NDRLNzZXV0gy?=
 =?utf-8?B?d2NoRWwzdmRNaURMZEhxTmhyRXJLcytJenBKaDJnS0RVcEl5Tml6Q2lCM3BX?=
 =?utf-8?B?UlE0S090QXd3U3BkcSthNzNlRk83a2pKcytsQXRkK0RTTlF6cFF4dkowZUR0?=
 =?utf-8?B?MVNhaUtBd0ppZjU5NExldTluYmxZWm9ZNTNpUVZoUTJPUGdBWkFJYXluRzlY?=
 =?utf-8?B?cEJQVk1peWJLMlJNOTVhcWgxa3dXNEU2MjFvckUrdWdYQkZ2TENYclBPbTBN?=
 =?utf-8?B?RGRqOGtDaGU1N3ZVUlB4anVUdExSdmJGbEJEc0RpNnNTVnkvMGQwQ2o1Unlx?=
 =?utf-8?B?cDhEYzlvSzB6WFVjU3hUck5lb1g4dkxabm1vMEpocEQvcWhKZUg0Y3FkVXJy?=
 =?utf-8?B?akV1Z3ZzQmZHOXJFQnhMMlZpOGJqc2pNRXVmYlc3a2YxUGJYTDF3Wlpaa1FO?=
 =?utf-8?B?MGo5TUE5WDF5aVhkaWdScHN1YVYrT0FmKzRmaXVRYzNOMWlieW5lQlowMFRi?=
 =?utf-8?B?cy8rMXdhcHBQUU9XTS9NWGkweTlYcUtsS1huanlvVE1saU83SU5wSmhGello?=
 =?utf-8?B?dG1kU0xNZFc5RjdNNzRwWmFoVU1tdzAzeTBENU9JVzUrYm12SnR2dGVDcXpz?=
 =?utf-8?B?eG56M0lLTUtGZ2tneVdmeG9QYVRFR2pHdllxRlZKWVU3VEdmNDd1Q3JTMGE0?=
 =?utf-8?B?dUM4L2hRVkF1VnF1VE1TbnIyYjF0blNFKzkwdlhJUU9UcEVIekFGS0dpU3RG?=
 =?utf-8?B?YWpVL1hpNWNlU3VSSk1rcFJTbktvaC8vTjNwQ2VpY0xNUm1JNU5QOWZka0JL?=
 =?utf-8?B?QnlDTTFKNHRpUjYxSU8yeFlmUFRkV0hKSllhSnJjcTNTWHNTaXZlVlIxRFAy?=
 =?utf-8?B?d210NGl0WG0vSWIyNlpKanAyYlpXMmdHMDNTdlY0STZaNmNFZW9YNm1tdTI2?=
 =?utf-8?B?bUp3VXJkVFYwc29TZHovQmpyQjhyUExPR2p6U0NDaDlwcHhCR0VlMnh2LzAw?=
 =?utf-8?B?VFQ4MTVXazJBRnhaUzcyM08zZ2wyL1BkbGFZQ3gzYWIyU0tFcHRaYmxkVzY0?=
 =?utf-8?B?MWU2Yyt0cjAvQldoN0NBODE2OHZaL3c5cHdZaXE2NmcrTGxHY2xwcGdmVFU3?=
 =?utf-8?B?RmUvMlFUVWVQakczaGhod1pTcCs2b3RXQmVJRzdwdVdoNFkxZ3ZoanV2cTFw?=
 =?utf-8?B?aWJqS1Y3U2NIbUVRVFlxcjd0M3luckwzVkg5T0ZHN1pBS3ZmaGo0QkNwRFFl?=
 =?utf-8?B?eGV2U21EYXlGS1NKS0NiRkFTTVcxQ1lNNEF0SUVCaXR0S0hteW92VFpuNDZt?=
 =?utf-8?B?UHQwYm9Wek5TRWdZb2lSZXVMR1A5UzQvK2twaWZrRkREUUVlck02bnd4NFJJ?=
 =?utf-8?B?dnlWbTRnb1NHUmxFQ0kzbXl4ZllpbE1KNjBqZkg5ZFhiOW5hdUo3YS9XaVZi?=
 =?utf-8?B?bTQ0RGVrbU5rM0R5VEllNWdOL0RMdjRiRU9TR1hIUS9DY1duR09KYkhYRUwx?=
 =?utf-8?B?c2tJWVNGRnl6TWVtcmN0SUliV3RhME5hV1B0RGF4ZjE3aGlQVCsvZW1jSU1s?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9045ccc-782e-470e-82b4-08dcff21cc3b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:46:20.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78T45TPhxU9UJjkecnTa+l0Sm1lgOton/iS1gHYtD98U4AUS8a3XWUFtZFKh9nxvtAO85vBzqjcnplu7JpvVhppJAPH0kGNKxZg2lp0BzBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clocking support to the NXP LINFlexD UART driver.
It is used by S32G2 and S32G3 SoCs.
Clocking support is added as optional in order to not break
existing support for S32V234 SoC.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 67 +++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..23aed3bbff6c 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -3,9 +3,10 @@
  * Freescale LINFlexD UART serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2019 NXP
+ * Copyright 2017-2019, 2024 NXP
  */
 
+#include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -120,6 +121,12 @@
 
 #define PREINIT_DELAY			2000 /* us */
 
+struct linflex_port {
+	struct uart_port port;
+	struct clk *clk_lin;
+	struct clk *clk_ipg;
+};
+
 static const struct of_device_id linflex_dt_ids[] = {
 	{
 		.compatible = "fsl,s32v234-linflexuart",
@@ -807,12 +814,13 @@ static struct uart_driver linflex_reg = {
 static int linflex_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct linflex_port *lfport;
 	struct uart_port *sport;
 	struct resource *res;
 	int ret;
 
-	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
-	if (!sport)
+	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
+	if (!lfport)
 		return -ENOMEM;
 
 	ret = of_alias_get_id(np, "serial");
@@ -826,6 +834,7 @@ static int linflex_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sport = &lfport->port;
 	sport->line = ret;
 
 	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -844,39 +853,65 @@ static int linflex_probe(struct platform_device *pdev)
 	sport->flags = UPF_BOOT_AUTOCONF;
 	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
 
-	linflex_ports[sport->line] = sport;
+	lfport->clk_lin = devm_clk_get_optional_enabled(&pdev->dev, "lin");
+	if (IS_ERR(lfport->clk_lin))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_lin),
+				"Failed to get linflexuart clk\n");
 
-	platform_set_drvdata(pdev, sport);
+	lfport->clk_ipg = devm_clk_get_optional_enabled(&pdev->dev, "ipg");
+	if (IS_ERR(lfport->clk_ipg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lfport->clk_ipg),
+				"Failed to get linflexuart ipg clk\n");
+
+	linflex_ports[sport->line] = sport;
+	platform_set_drvdata(pdev, lfport);
 
 	return uart_add_one_port(&linflex_reg, sport);
 }
 
 static void linflex_remove(struct platform_device *pdev)
 {
-	struct uart_port *sport = platform_get_drvdata(pdev);
+	struct linflex_port *lfport = platform_get_drvdata(pdev);
 
-	uart_remove_one_port(&linflex_reg, sport);
+	uart_remove_one_port(&linflex_reg, &lfport->port);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int linflex_suspend(struct device *dev)
+static int __maybe_unused linflex_suspend(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+
+	uart_suspend_port(&linflex_reg, &lfport->port);
 
-	uart_suspend_port(&linflex_reg, sport);
+	clk_disable_unprepare(lfport->clk_lin);
+	clk_disable_unprepare(lfport->clk_ipg);
 
 	return 0;
 }
 
-static int linflex_resume(struct device *dev)
+static int __maybe_unused linflex_resume(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+	int ret;
 
-	uart_resume_port(&linflex_reg, sport);
+	if (lfport->clk_lin) {
+		ret = clk_prepare_enable(lfport->clk_lin);
+		if (ret) {
+			dev_err(dev, "Failed to enable linflexuart clk: %d\n", ret);
+			return ret;
+		}
+	}
 
-	return 0;
+	if (lfport->clk_ipg) {
+		ret = clk_prepare_enable(lfport->clk_ipg);
+		if (ret) {
+			dev_err(dev, "Failed to enable linflexuart ipg clk: %d\n", ret);
+			clk_disable_unprepare(lfport->clk_lin);
+			return ret;
+		}
+	}
+
+	return uart_resume_port(&linflex_reg, &lfport->port);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(linflex_pm_ops, linflex_suspend, linflex_resume);
 
-- 
2.45.2

