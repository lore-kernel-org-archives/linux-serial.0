Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020136.outbound.protection.outlook.com [52.101.193.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF533689D;
	Tue, 21 Jul 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602066; cv=fail; b=Pakm9a1+L1ypdWGI4tFqUMhMAUnoLzbm04L2BSAXr5K6BGVTrN1m0JQ2i+tjx0aPKIKJLJKzh7i/XHetiZ9jUrFyhrHdqpa/FjV8pibIGjEjYy1LHbcFSvXFuqoW8arW1/OOBFY2JQH18+CRv1cGTDUWBu7hD4okKVFmsq9zdOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602066; c=relaxed/simple;
	bh=9g6bmji4UngQanI+71wgbnG4tcmSlL4DheJEpscX4ng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SM4GCxu8FeUMZfXONE0t41uwKiZSTwFdNgmAYJwDU0Wk9Ecxxn7Zi/CloD6YvXg95ROOF5vFwDuNZW+AQWAg/Hz136SKH42qTDZkLBDFuEw2tFOxrTju0i1jnFL99sWCQWvRfxC9Ov4hfWoirUbvoxupmZy1aAY6fPZeobAK4Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=de6vED20; arc=fail smtp.client-ip=52.101.193.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="de6vED20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYqMC/rklwT05feM6ZW5CmL/If4qA+xbD9Z4cIK4JAROnZVdYCIsinG5FKlgcBxVRGcu8gc0bh+tdO58KOG+z//jchLF0EMj/FdcKdanJXBl+lcmOFKYt3xkkquLMyOuDiSfYBDkbwvBmbnigjlqYY0xGDa0Xvkvmsj/IZlfrsE+7sCto569QL0CqqpjBpgj3I625AncD9ATNXs6GSU5ghmtVa6UNymu2DJDjWjh50Gq21VlRleQuvQg/me93yS0I/yb/ReSzCAcBIWLpI/PsXU3d0aFssKFtPo2AO6NIKV5vw+HTKHYo44vwGL4gmdWBJ+UAHtYEYosS/UqlLHhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AetWyRUlPFDvNFKGsQQG2ibvzT9jtBNpCDVWJnUTtSk=;
 b=Lk8AQldW3B2hlEzYKIUe/Iz5ggA4a79PovaA0/9/yH/TSo8E07LfmLkKA533NIxfGu5M56usX43vNmnC3jqXzAmdSPGFUR2ma3soF0g1oVtM6fJmeWcGFoyvq1w+79tTK5f6bQsQZf4Ok275KEo+ypHkbHSEmpNXxi4L/FkslMEUIF1NcOmoTxtsPR5kAF6vrpL5OWD1Y3VEUcAei1mvgzq36GhwjfNe486JT0EYD+/rLs56cmAVWIRvkK9YyGGUAWj2nrh9H1pldIiw5ZxKMVPbAh9UfY1nylmYTS75lwS8UFxZoer2BhYU8N24PVkOZRxVo+m0MSZ2d1t3ca51EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AetWyRUlPFDvNFKGsQQG2ibvzT9jtBNpCDVWJnUTtSk=;
 b=de6vED20K/iTaojWbj8De3dgAwp0ITUDMFw3csNGTGxsJvsGIOhBpTiJTGYgkULW2U4wg8lmGvDDQmkNh4Ty6c9kUzKOh524pKxWbpZMoClZA1K+2VMcmD3lbV2NDDRJBrKiVG8vNEh4gJdKdfp9ud9a5FNM/S+NOXy6lrIMcAMMFp3+xcmjxScT9MHiauvtlsgQsR1eDe9G+t7vUSEFxtZWchctzWoTkazQ1Of571hOgUMHvpDSghwsfoUJUC++NF+1OEA3JF5QhIUxNu3K0o7IRNCCJQbtCSlmDLrWZNLr2H3l3mzeMSXBMBZOsnJJVwwuWxC7CmbOQsRKHam5lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c) by PH0PR18MB988450.namprd18.prod.outlook.com
 (2603:10b6:510:3c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 02:47:42 +0000
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e]) by BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e%5]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 02:47:42 +0000
Message-ID: <4e0dd005-2600-4014-8069-b5ba9d392825@axiado.com>
Date: Tue, 21 Jul 2026 10:47:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi: add Axiado AX3005
 SPI variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jan Kotas <jank@cadence.com>, Michal Simek <michal.simek@amd.com>,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?Q?Przemys=C5=82aw_Gaj?=
 <pgaj@cadence.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
 Mathias Nyman <mathias.nyman@intel.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
 <20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com>
 <20260717-admirable-robust-adder-7aad70@quoll>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <20260717-admirable-robust-adder-7aad70@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0057.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::16) To BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PPF1B62FD55C:EE_|PH0PR18MB988450:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bcae90-708a-49ad-0dd7-08dee6d26f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mN0mEW7p+/p88lc7dfqpMdbddPPEHaL2fhc4nxY7o1lpTCYUX/qPGDuQ1osSNn7aQCLs7CeTjwNu1vfj2WBIi/6I56hcKGz08tOtfHVvDWw1/MLGLKRXSwJ/WopZyp3BZv9hS8C6fwJMOzSl7gnrxyYULnQel2iTOE4v5Paumq3X6QMPR2CI2GJBsBIKpPcvrZICnRJ3Ybic3jNM9yGrgra/z+MoAtAHCGfDXnz3py/OKhqr8HJPNPqcBsOFLxXtjDC8pQAG4x7b2nll3ZZ2v2ukmqg6hWRPIfTSBNNqfEJd3ss+2pxJXljwvAGYtOj+hlbzVEaNFnT4OQRlW9iCwKwcEr36wzuph+XkRWZbv+/W6WqqgDTxjXQYV14V57u1SAanVofEWw5Zx7kC1Jh0PdVpcUcpSNiqfbDmpgDeO6+y+9EEOoTN0XYG+hVuQo2choIE0cT7gyJCLenHSFxLv7DjeeS6K/NkXli0CbdquoLk/oH0uO2WkXJyC8KsVj/bOf/t4DF9lWgxkfdVQZ3WgMtk9a9YOeaJEzSmxy3iUp/A/Y0KOEUdoJQT3VF15MdopJAFG7ekakuYvDWyfaU0LeNAk3vD2qgm2a274UCtYvSXHVZTgm4KZ9hLrg179lGEJ/bSS47y4pQuNIsumGydjqI2pVbftY6pzipKyEx1tG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPF1B62FD55C.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N25LT0l4M1NjTTZvMzNCRHVHemJVNmpGYjc0clJlbW9YRXBpZzNLc2JnNXNM?=
 =?utf-8?B?bGNRVGlwV0pjT0dtWHJSeTAvc0NrNHkyT2ZXQ25FNmFYclMvZ0tPZzJMMUNp?=
 =?utf-8?B?Y05Zc2hxUmpwQkhVdG83TE9UWlAxZlpJN1doT2lFOU0wZFo0ZXlJSkxuWVhT?=
 =?utf-8?B?UHlzMGZIbGxnT2pDSWhTcnZlci9iWCtrMlhndHBsdFdCZ1B0YXNpbkZvKzd5?=
 =?utf-8?B?bnFjTEk1K0Q2NVJxaU41OFQ3QU5CZVpYMkJJeXVxTWxPTU9sS3FRU0tIdHJK?=
 =?utf-8?B?Vk9WM3NZVmVXUVM3VHM5S3ZJUGtyekg4WjJNaFczNW1JbGlFVEhoSzQyc0Zk?=
 =?utf-8?B?MFhkSkZzQXF5cWt4WXlnQ09JbkV4U2g5a1ZUL1plcVA3Y3RYcHFrQk1WOGJE?=
 =?utf-8?B?b2NoZ2lLNFBuaWlXTVliTEZZcFU1V3dxSnZDQ3lqT1BCS3Bwb2ZuMkVSeEJo?=
 =?utf-8?B?Z2pXUWdVRFgvSzJZZjlWaXM1SEtGbUhzK2IwbjJUc2ViRzNpdFJnZUVYbHF5?=
 =?utf-8?B?d3FwNWwrdFl3S3prSVc0endzSTJseHdsNWZselpVVDVmdXlveG5UeDFmQzdF?=
 =?utf-8?B?UzhGQlVJRFFQZVoyY3MvbjFDaWVSRkQ1OFQvVHJRSmxjMVF0elhoV3VIZkZB?=
 =?utf-8?B?LzFuTjUvQnJsVldsMW02OFZsMFo1M0FPQjVlY3Y5bE9vVFZxdXV1d0o4UGtH?=
 =?utf-8?B?LzJyUDd0ekpLYVBybEFUeGVpQXVMcEV3OTFCbTg0bDlBMEN0WXdVUTJ1eUF1?=
 =?utf-8?B?RFM3eFdzb0RhaWVnZzdMOGZSYk11b2pRMnI5NUVyajVjaG5WbGxodkdSZDJt?=
 =?utf-8?B?QjloUnQ2elh6VmFRNEh4bjROeEZBMU4zbjFhcy8xUytDd1BUQmlSWnNBQ3Fm?=
 =?utf-8?B?VkI4S2xDRSs4QkFrbkFpRFY0Z0piNmNybnNmRC9ncS8rVEgreHhwMVFIdlcr?=
 =?utf-8?B?VnBtUDdQbktMbEROSlFacDBDSVo0aVJGWlpmeTFqYjYyVlpMamRnakphUHhH?=
 =?utf-8?B?R1pPOEtlWUxoaG9QZlJIWTBpamE4V0xOc0o1aUlHVVNGaGtaQVVzUm5kL2NV?=
 =?utf-8?B?SlBjQXp1bHd4NUhvalN5SExZeVNYQVZodE1aRUJQUnUwakJFd3lLQWdoSm41?=
 =?utf-8?B?YjRGODlqcmJtQzdCZXIweTNPTnJkLzNRZ1pFemcrOGczZER1d2dyckNuR1Nn?=
 =?utf-8?B?cFpMaG5KYmlPOXdjVjVjcHQxODF4NnRTNVFDS1p4UGRtWHVOTGszSU1WSjI3?=
 =?utf-8?B?ejJEVUlzWjArbXNWWElSbWp4eHR2VUFJcDF2bWNJVGVqRS9zN1NnK2lWK0dx?=
 =?utf-8?B?NFlBUXFBV3diMG1qdmFjTjF5RzJRVnYrbDJDYUw3OCtKcEJiTEFTQlpveFVy?=
 =?utf-8?B?TnhGcDVqM0d1OEtRdS9HMlRDZ1lXOWRFdHNDR2RnaU05NUZVSElhOGZYcmYx?=
 =?utf-8?B?Nzg4T1lBd1p2NytZM0t1U0RTR0M2QmNJU0JwbkRZV2dGb21ZbmZQdjVpS1ZI?=
 =?utf-8?B?amJPVDN3Ykh2OVljL0lrUHM3cEkzdDFvQnpuL0dBNHNxR2d4RzRobk5tR1ZG?=
 =?utf-8?B?eGlYODBiU2VZemgwdjhiYy96WSt6aktWT3dZVitlWjZXVkdWWWk3K1kwQ0VO?=
 =?utf-8?B?THpoZkZPaFhyUlpMOHJmalVrczBKWU04blZ6VS95SFZRdi9zeDZuUHdrSnlM?=
 =?utf-8?B?TWRuakdURm1oY3RGM1BRcFJVYmlucjFiWXpjNERSbVRMTnV2MVdDRXNaclhH?=
 =?utf-8?B?dldDOEozOS84UGJQa1dQZWczdXFlQUlXcU82MTgrOEZuaU9HS1dzM01LRDlT?=
 =?utf-8?B?MFl4VHpKZWxXbU9QWEF1cm1rUnlUbjlsR0d3eUVXaE45VzBWUnBBQVFxMjBx?=
 =?utf-8?B?THlnQlp4RGNSYnAwbW1PMERnQnZTWGVscUxzTEhZc0wwTTE5TXpXbmh1UVRX?=
 =?utf-8?B?K1hGRW16aVRLeDJFKzZMcDI2OHhWYnZOZGZMcEU4bEhyaldtNHYvTFJzTE5S?=
 =?utf-8?B?TUJKNThBR3VqQWgwUVBSUnZocXFveitaU3JBSUlCQ0t3V3M2ZXRxMTRVNUpH?=
 =?utf-8?B?U3dTcUhxdWtDejhoaWVpOFE3L040ejFGUWtrMmhDZU92b2d4aCtTYVh0ODhE?=
 =?utf-8?B?VnV0cWNGZWQyc1RxK2dvRzZIUldNNERuUFVZOWdRTDdJOXoxRThwR2JxcXRM?=
 =?utf-8?B?S3AyWTNQTm1hZ0Jmc2xuOXk0YklKVDFsb2E3RE5JajdiTlR6Umx2V0Z3cVhq?=
 =?utf-8?B?QmVsTjNNbnJDSnJUNEg4MjRLOVd2bTRJN0dEL2VPaHFqZER5UHphNXFiRCtR?=
 =?utf-8?Q?rgkiAyInBlEmK19XZw?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bcae90-708a-49ad-0dd7-08dee6d26f31
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF1B62FD55C.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 02:47:42.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5XsnZF0is5rc6syOgsxOV62JA1j46siLZ7Jzg3+bddwrKOth4+L/2qydOEpPsgY0YScSx9El5EzvDeMM8hRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB988450

On 7/17/2026 4:34 PM, Krzysztof Kozlowski wrote:
> Rather: Vendor controllers compatible with v1.01a
> 
> and then place it after the group with "description: Vendor controllers which
> use snps,dw-apb-ssi as fallback".
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

Will do. I'll change the first entry to an enum and move it after the
fallback group.

Note: Following Mark's advice, I will be splitting this out and sending
it separately to the SPI subsystem in the next iteration.

Best Regards,
Swark
