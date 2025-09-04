Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023083.outbound.protection.outlook.com [40.107.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CD1F1302;
	Thu,  4 Sep 2025 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970619; cv=fail; b=k+f6+KDvnX0SlkazWqbQZBMyuGyUVhOva+FLm07zgqISY9PnxfzVJwNjBbvRk4vBB8tzMRFY8y4RpCYkPn0pA7r5uk6qjRkDDELPpsMxyPaDjKwxYhkiLwCJw7TlseZMBnPmUIMl+AB+Q6fqtpxWa5gjKvAc8VcsItvhxzJncjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970619; c=relaxed/simple;
	bh=wcrC3MLiU2+zK25FRdUbmsIqGyISebo8MoIzadflAxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T7qyHspuT0GB+KDnom7mDC9pW3BKrpeoxstvOK4P37+Zk1n+90yAnZiNF5Xa9DZQljfYchP8uaWKP8PUV/JmTGY4aaIGOXGGEJHOt1NZiZU/sDIxt+XxGYFf9tjS7gof5LVfooCLhoVQx0CylH+WMfWVI1CqOY4dOEN8Phytcn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=0gRuVpM5; arc=fail smtp.client-ip=40.107.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="0gRuVpM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMm5kshag8OWHySLY+C+I/41SNPBpNeTXZ0ZWuCgM+3zworpgZXZOiC8WE7ZWhW9nEHn4xjH42xaTkN5PlGicfM4mwTd83JPQ/TVEAxBwby1j920iYEVpogiOxwrdUpV3VSNMl3OmjCbdTNGC8ijq1EP7QmpIqo85+lpCu5uf02eBX0M5QJF3RkMLnh5GpLjq3qb8F+Fdj1Y+sY5t2wCmbRwa+MjlZf6hWGZRjLzAFnAsCFr6OTdmbFUD0u+9Jlunxo1QkrFCxOCOUg2DNmkzwvxTijWLB8qVeTQ+8gF7Rj1ZFrCbIy2TmNmwbRQBZFPjjENi//YTXOm0AscBaW4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W625qxlZ0ocvbl2kniFqr5gJSD2CgECV8Npddb8xJ6I=;
 b=Kc6rQIAYGa6KM7CoYWGBs0UqRk88SDfCwJGHIIj8zRPc578c6kbkVIAXxtmfNOFw1zzkEA1UazCyEyjf3hNoxDaUw0qArHC0pne84KgaTWe2q7ELXlezZoDxMH2W5L2x0Y6ybA4+Z4D4W1mM3EK0vbnZ5GPjWGZenOjkNECFxTK4L8OQaLMhvriC6JcuH69hW+yIFX69uf8cWl2/8WqpBp0PM/vRgpNpLeAwrm2iefAHsjAABWCnmfAYDvS1OET424yQXAhdLDCe+9ExcpWaKBw1GPkirt/mIPYsvUrI8wYlLFD6MkI9dfc0659YxOyszdHNplx7rGUUOrBg+XCPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W625qxlZ0ocvbl2kniFqr5gJSD2CgECV8Npddb8xJ6I=;
 b=0gRuVpM53EYHEtuZtg9Mdn3S353D4O7ySy85JDgAkuFULXu9GBTTPmv9h5SLkqS9ZzmpbvRO+8XdnP9eOZ5ZYzIDYEMTSg4Aj7kV8uZ+GZBFlSbDpMj5xH4Lgwb5GiVS83ciHgxDzjLsZsxXRaoDf/dmIpgRl/brWncKLYiArjjdDQr7n9Z8g2q2GRARnCPD8dfT1edBi/TYSf1QxDDMzLFAbzLujTR7j5qsqa5CxJ2U6O5jt+/YG4wY+v6VOgP4ndcYJq+8/yn3jjrZ9ggnz+VpNEi/zzp7StsQVjv10xfUUvi6cl4Hw3DNE5ynnlDrm2b2ZkJT4H6KuZOWSlh3oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AM9PR06MB8230.eurprd06.prod.outlook.com (2603:10a6:20b:3df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 07:23:26 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 07:23:25 +0000
Message-ID: <3424939f-3abc-4154-9cda-51abd657e889@vaisala.com>
Date: Thu, 4 Sep 2025 10:23:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
 <20250903113731.24f5ac2499e92246bc0c93eb@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20250903113731.24f5ac2499e92246bc0c93eb@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003849.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:7) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AM9PR06MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 39460bf5-d701-4a34-69ed-08ddeb83efee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDRRZk9XMklKY3VEUXVtMHo4VlBGS0owNExoMUV2S080bUxGaFhwZU5RMUlu?=
 =?utf-8?B?VlFoM0hhRVRDclQwQmczZy81YXZydjZWYk5CMUdHRjZhdG44TlZzUVNoU1ZG?=
 =?utf-8?B?QzZsbXpFdkh6azhHSjFMazU4QSt3eHdlMDlUbnlGYW9FV2w4ZW5vcW8rbndO?=
 =?utf-8?B?OVdnQVJxZnl4R3RoaGxVL3BJOVMvOS9nb2Jnb0M4NEx3cVRqSHpLNzM0enJj?=
 =?utf-8?B?eU1ETWZaZDAwdk4vL2RVSXZyK1JHOGZsVFJSdW1zcVd0d3l5QXRLL0xCcmpB?=
 =?utf-8?B?TWoxTjhoMnZFenJUaFhvbHpGcUhGNE80dTB1L2xwcjVlZG5wUlFGQ1Y4akZp?=
 =?utf-8?B?aEMyR01rY1VDSmdhbG92ays0ZGFRbTVMRVgzSHhWdnBBSENua0w5SHZSbmZL?=
 =?utf-8?B?WStDVmN4b0p4SU9xNmtHbnZLM2syOGNiVFIwRkVoMDJiSlZWRlJsV2c0bFc4?=
 =?utf-8?B?VFN5a3k4RUpHNmZFQ0JYOEJrekYxeGQ5K3JTTXM0dGlMa3N0ZlZ3SlFaaFNh?=
 =?utf-8?B?MHFidlJyTTg5Y1VLTlZDTVR0YldOTzQ4U2N4QzBHNko3QS85WElveC9JUFkz?=
 =?utf-8?B?dUpkYlBPbGRkU24rRVdVVm0wdVlBd3pJZWlya2pZYWhZV0hvNWw2dlNrQ3Uz?=
 =?utf-8?B?TXc4Q3Z1ZVlqTWF1eUhtU2YrdGJYeVBUanplUjRBeklCT29EOWMrWFpmWGxm?=
 =?utf-8?B?VU5nL1FkUndLOUVnNUVTOHg0ODNqVFpqYURQbUlBb3lHYVdNQUVUenorNGFL?=
 =?utf-8?B?NHdhcnAxb2Z4U09oWEpIOXlZUVJEYVFtaC84c1p5eFczOHVGWndIWnFPL2Vw?=
 =?utf-8?B?cEpDbVhFeCswV0ZhMytwRDREVGlvUlQ0bkFrWTlVRmU5UzV2YitYMzdET01F?=
 =?utf-8?B?S3hkQms5K1hHNmhlZTJCU2RGS2dOYUN4ZnZ3T2kzNzdCZGc4cEpNUzVDQi9E?=
 =?utf-8?B?ZzE4WC9VNXNvS0swTklCSHdLWlBsdzZmeWZWR01qTElVWjNJUjV2TnRRK2NO?=
 =?utf-8?B?REJvVGVyNkMybWVJQlhJeTBvRnhsQkk4ZWhMbkR2VW9tYngxUGJDWEMwa2tS?=
 =?utf-8?B?SjBFSjMyWkRqNVBydFUyRVErMjQzQjlOZ1ovUWdoVlJFVVBDRGZhd1Jza1FM?=
 =?utf-8?B?dU0zN2JBZkk3YXhWUTF2Q050US9Wb2hHaWc0aVJXeVN6R2RKdUxwTGdzMCtU?=
 =?utf-8?B?ekV6NFk5eTZWU3AwVGlYRWR2cGtxSVplV0s2K25IVURDSFA3YU5zME9vOGxY?=
 =?utf-8?B?N0hxcWx5SE9OSUpNNGl0WTZibWszUVkvaDNZcGhKWEx1L21sRVl3a1pDUktQ?=
 =?utf-8?B?MEl4U2xHVndxK3NwTkRpZzRaYUZzTnUyWWVCSTJ3aDMrbEViWXc0V0xCY05J?=
 =?utf-8?B?WUtsQUpDdUpyK2ExaG54UEJpV3owbXdTVDkrMEE3b0JFV0hhS2g5RkVzSEdr?=
 =?utf-8?B?dE42VWtDU3Z2SGhGeUtyV3B6UEhiV1B6TE1IM2syRkl6RmduMzNCTW5RNDVG?=
 =?utf-8?B?b1F5YVRpdFF4Qk4zaW5KbUZZOCtQQytYR1ovaHFIaFRDVEV2Y2gyVGxKbDdJ?=
 =?utf-8?B?cFBickoyRGRsL0RDR0ZxeWEzTEVZWUhtbmIvVkcybDZDSkwyNnFsb3ZYY045?=
 =?utf-8?B?a2Zja1ZuQ2dad1l2Z1NXaU1FTkFGVlQvbCt1Y1psMUJmTUEwMmdOdTRBcmNm?=
 =?utf-8?B?UnJCSVFNbUtpV0xGcGRVaTlwdW54Yy9RQk9sWlpmeGw3VUdVQjVZUE0zTmNr?=
 =?utf-8?B?RVpWNDY5WWZNYjl1a1lVU0p6eCszRkwrRzJNaEYwQVJMWEs0bEg2aHNQMlpq?=
 =?utf-8?B?cHQ2SzhjQ1IzZndhZExSbDM4c3VNYXRtQkhyT2ljeDdPRlhVZXhKMkx5R2Iv?=
 =?utf-8?B?Y0pRN3o3ekNVUjVxU0ltS3VWbjFNLzJmMGdVdithKzZUOHpEVnZmWFJYckQv?=
 =?utf-8?Q?xZEHP4njNQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTArcC9OdUlRR3RDMkhTL091OHQ5TzVCUml3T3ZPN29VcVJUcXZVeUZ5ZWJZ?=
 =?utf-8?B?cEhoN2FKdnd0cjJ4bElsRXNEZU5FOW02MFViR2lUNXVqUUpxQ3g1cTM2V1p6?=
 =?utf-8?B?VkxJYjBtZUVUblFZK0VpQmVWNDFsd3Bvc2p1UXlhQ0c2T0hSbkNWaU8xTTdH?=
 =?utf-8?B?bFRYcXB2L2FLbFVYbEpTc2pFZnZxRldHYithVEREWWl1ekI5dzljd0ZNRjlv?=
 =?utf-8?B?MEhDc091Qi96QWh4RWxZekxiNFhsZXFLa3NzQWZ2aU95Qkh2UGgrSTUxM0NN?=
 =?utf-8?B?QmI3QmhDamh2MXQzd0d6SFQ1MHlVcHg3WHZsZEpsalQvUTF5REI3TnBpdmJa?=
 =?utf-8?B?VGx5MUFwSVBHd20wbjByVXBlVFcrYS9QdUJkeVZLYXBRT0tDRTJ6WHV2RG9u?=
 =?utf-8?B?MTdJUkNIUmxjdjdqakZUWk5iRVpXWHNUOE44TzBnbGM2ckJQUEtTUy9DUXAv?=
 =?utf-8?B?dmFuOE1iQS9PbjV5ZzlHbXVkWU1HU0psZGZiL2hJaHU3Q0NNQmxzY0YyYmFZ?=
 =?utf-8?B?ZG9TNVd5WkFVR2ZSSjdUVlJOYUVvK01sRk92U2MvLzJaN290bW9CY1Y2TnQ3?=
 =?utf-8?B?S3VPVTRjMXRzZXYvUkZHbDhMRFlBNmFYRUxYS2VFR1oyZ1BkcG1ra1FQc09U?=
 =?utf-8?B?OWJrNVkrOG8wOUNtUHZPZ1VQcTRMTDBtdEhLbU5RbWl3UjBYMlRxZWNHdEU5?=
 =?utf-8?B?MkpYVU1vYUhpZCt5MEEyeXJhU1hBaTZaVklFMGRRTlpUTlJBNzBNNHg5dEt1?=
 =?utf-8?B?NjROQmtSWldHVlJCcnpTdXhuc2xlWGk0ZWdpNGFXcVZQaHhGMFVrd1FVaDNT?=
 =?utf-8?B?WEhmcDJmOUN1WFBobkozVWwvVGhxekF1UCtTWjhMVHZSNVMxM0Yvai90OHVT?=
 =?utf-8?B?bnEzVzgybWo0TVBRek53QTdia014V29Sb1ZRZ0RieXRBdUF1M1BVYTVVOEFt?=
 =?utf-8?B?QU04bFJwdktGUWRjWmNpR05OQTBFbXdtVk8xbGw0dnZnZnpKOC9yOW1jdXl3?=
 =?utf-8?B?ZmxEREt5cGVvQzBpamVpVkhEckdUSENSWGZLSk1tL3F6eHpYY3BTb1dvUDIz?=
 =?utf-8?B?azJhQ3lGbFFLQ0JRQS9xek9MYjd3bVNrR2FqOGpITSs0NVM1dTZXcFcxNlBS?=
 =?utf-8?B?SU82Q3RSaWlXRkJ0amcyWk81SEQrMVFpQXNKZWtZQkV4RjMwUEg5cXFOR1kr?=
 =?utf-8?B?SVkzTGhlZlIwN2FqWU94eHI0Z0VIZ1F4RXF1NFNiYVNFTExOSDZ2ZVZQc3BT?=
 =?utf-8?B?aThhc0h2VUt4Y0w0WjFDZjRYcWpGNUIyVkNmYk1xd2NLSGs2UW9LNEpEcXpL?=
 =?utf-8?B?Z0JiUGNjbXRvRjgybWVaTk12LzNmdFRmb1l5ZkV0U3FqY2RsK1BlVnBSWmhq?=
 =?utf-8?B?RktZWTVZOTFsbTArd3JKdW1HTFhGTUhiMkpleVhtN3ErSkRLblFUVlVTcFha?=
 =?utf-8?B?Nm45eVNhUW1pVElPZzVINERBRGU5MkRXS0NvVlBrdk4wSHcvVFlUZmpXS2hh?=
 =?utf-8?B?UTV6SjZadzZWME9mbE40KzJLSkVVZm5iNld2K2I4eHhJcEl2ZVRwejBSWXlY?=
 =?utf-8?B?TmtKUjY5d0orcmxPdW5tdEhjS1lqOWp3WWVUckRjc2tqazVFNTF3bzBMS21O?=
 =?utf-8?B?bG5tcWZTSm83MC9oQ2NHNkVOUmVsRk0zcUtZcVJiU0lMR05QbVYwcmZMM2Fx?=
 =?utf-8?B?N1FJUy92ZFRjU1NkOHF4T1haRTNhU3QyMmpwc0tONHg4T0s2ait1Z29yYW00?=
 =?utf-8?B?R005UCtGQkNBVGJaYlpOOWN1QjY4OEFJQldjT0NId2VwS2ZZR3JaTWdDMFNG?=
 =?utf-8?B?ODZGZW9pMzVQdzZhN1JjbDVuRHpjZjJNNzdFd2pTamVWUUR1VmVZZTIrOFZC?=
 =?utf-8?B?cCszYW90SGhod0NEMUs2VlBjekRGVlZVY1RsOXFJSW4vUmxIUTFCcng4b0pk?=
 =?utf-8?B?WHdHd2RVOEJmYUlIc3B5eHQzNFlKbSs5WmF5ZWNLR0tVSmphRXo0QlgwNDIy?=
 =?utf-8?B?V002bE1tZ2tQNmNqZUdualo2cEJWa1lIN2VjYXNWUDF2RE1LbFM0MTdPOEM5?=
 =?utf-8?B?Yndid2lCcXJDQUhTTUpublovRmpTbmx5TnNNNXBVdVpKWUY0WGtqOXZSbTNy?=
 =?utf-8?B?amx4V0xKYmhHU0U3TnVQQW1aZVFGZFZ4bWxFUzBXaGdwNEVLWE95Q0RjVk1I?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39460bf5-d701-4a34-69ed-08ddeb83efee
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:23:25.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWKrWXWCDcSYBSFjNN83gW4SO4gEaByTquhehcM7S8opV0cv3i9kK00UAvUtdI8IAqH4Tq0U8QJ1yhRFkwHf0IUcHiOqobrOQhyYUG/BT9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8230

Hi,

On 9/3/25 18:37, Hugo Villeneuve wrote:
> Hi,
> 
> On Wed, 03 Sep 2025 09:23:04 +0000
> Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:
> 
>> When there is a heavy load of receiving characters to all
>> four UART's, the warning 'Hardware RX FIFO overrun' is
>> sometimes detected.
>> The current implementation always service first UART3 until
>> no more interrupt and then service another UARTs.
> 
> To improve clarity and reduce confusion, maybe change to
> something like:
> 
> ... always service first the highest UART until
> no more interrupt and then service another UART (ex: UART3 will be
> serviced for as long as there are interrupts for it, then UART2, etc).
> 
> 
>>
>> This commit improve interrupt service routine to handle all
>> interrupt sources, e.g. UARTs when a global IRQ is detected.
> 
> The current code already handle all interrupt sources. What you
> maybe could be saying is that you handle all individual interrupt
> sources before reading the global IRQ register again?
> 
> You could also add in your commit message that your modification has the
> nice side-effect of improving the efficiency of the driver by reducing
> the number of reads of the global IRQ register.
> 
> 
Try to improve commit message in next patch version.

>>
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>>   drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
>> index ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
>> --- a/drivers/tty/serial/max310x.c
>> +++ b/drivers/tty/serial/max310x.c
>> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
>>
>>        if (s->devtype->nr > 1) {
>>                do {
>> -                     unsigned int val = ~0;
>> +                     unsigned int val;
>> +                     unsigned int global_irq = ~0;
>> +                     int port;
>>
>>                        WARN_ON_ONCE(regmap_read(s->regmap,
>> -                                              MAX310X_GLOBALIRQ_REG, &val));
>> -                     val = ((1 << s->devtype->nr) - 1) & ~val;
>> +                             MAX310X_GLOBALIRQ_REG, &global_irq));
> 
> You changed the indentation here...
> 
I'll fix the indentation, my fault.

>> +
>> +                     val = ((1 << s->devtype->nr) - 1) & ~global_irq;
>> +
>>                        if (!val)
>>                                break;
>> -                     if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
>> -                             handled = true;
>> +
>> +                     do {
>> +                             port = fls(val) - 1;
>> +                             if (max310x_port_irq(s, port) == IRQ_HANDLED)
>> +                                     handled = true;
>> +
>> +                             global_irq |= 1 << port;
>> +                             val = ((1 << s->devtype->nr) - 1) & ~global_irq;
>> +                     } while (val);
>>                } while (1);
>>        } else {
>>                if (max310x_port_irq(s, 0) == IRQ_HANDLED)
> 
> Maybe you could simplify (and improve readability) with this instead:
> 
I am reviewing the proposal.

> ---
>                          val = ((1 << s->devtype->nr) - 1) & ~val;
>                          if (!val)
>                                  break;
> 
> -                       if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
> -                               handled = true;
> +
> +                       do {
> +                               unsigned int channel;
> +
> +                               channel = fls(val) - 1;
> +
> +                               if (max310x_port_irq(s, channel) == IRQ_HANDLED)
> +                                       handled = true;
> +
> +                               val &= ~(1 << channel);
> +                       } while (val);
> ---
> 
>>
>> ---
>> base-commit: c8bc81a52d5a2ac2e4b257ae123677cf94112755
>> change-id: 20250903-master-max310x-improve-interrupt-handling-aa22b7ba1c1d
>>
>> Best regards,
>> --
>> Tapio Reijonen <tapio.reijonen@vaisala.com>
>>
>>
>>
> 
> --
> Hugo Villeneuve

--
Many thanks,
Tapio Reijonen
