Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B33A1D11;
	Thu, 26 Feb 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100292; cv=fail; b=JmVA2Hwu78p/8wKQLCGLQVsdZP4ZFlO88SbMS06ogT85Q6r5745v5VPvdpvaProZSGl2z5KPnNUunvUUQwc80nI6apWTvoi62jhZhf0izSVdZXZiO19veKn8aYmtGeVgPLFgHSzrmGSTMzG/lN8XhsChMcrQITScTi1c8kvH2hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100292; c=relaxed/simple;
	bh=htHcJbYCXk6w/05K4KSTBuJ/xaIyS4hQVF4GcoDpKv8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFz3Yua+lmQS/LrZSbmUQZoWfE/gA2dMrpKHO0xgL6WMFKQyT9WWCVKgEyP3PeP0hc+5A6F8uv+brf/wPCZl2X8nybDT9WXTkwCv+0IN7s2SgAyDEJnfHh0Qvohm5eeYvH5qScTMvgYK4ItC7u5F1iFMWWwAGjpV7M0PqHUmuNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BDSgUDXI; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BDSgUDXI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbH1Gadt5h3YpmS0UHd9QYQhTPmPWh8ONKVbmG561ZQ53vqR0uSERdq6P9VxfAaMDFtwVD+gD9t1G9SsayZ2qiHve7NiAkk2W7zSFMXRWdyRcl85qNGqeVwjRzhgRGf6Ik/XqPJp0ujqgmZ5Q0tKZBJZ5f46PTGpyCXdOwzU5aLffeche5RbQ6JXhPAStXYr/e43G8x06E5+0Muz+FYHQQFBSb/He0l5/pbI9zBxTB1ux+lVvxxwSqAFhc/Uo1WpSwoMfnFmBWuyvETulO1EAz0+++kwXeBCYoufCpkBGOtcsWaUyLvsoOGyQyoTeu7d/RdIVGiQS7VcqvWGVKbnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MasuguUVUmOxj3kCo8Ffba0eUzI0tX0l9a+GGkWHrW0=;
 b=yFaOTh8dzaxLMGdPO2imxXeA/gq+yO1iUBF+BAubH2ZxbXGsTSN+BmPOyl+EiJiZEG2uapEVJS80Z9aGyGjM0r6uJ4zFunRhwQixcIqdiUvyVet1UmcZ4xWiRY6OglIIF62dn5B0j2veBOUUzHFUrVas8cGcifi7A5soStuZkLntoTaI9Pu+uuA3/81DAXJsiB1e8nJlhq5UZIn7c8UQ1+dJqi2AOncQkIWm5LUZfGBkpEkzDNP5hPgSv1+kJnvopySBr4JItuFyG2swM8UeUJ1F2qCJS866mGGYwJyyuGNv0ujDV9SUSHktDGYhuynG1H6p3cCbcMJhtEL4cIEu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MasuguUVUmOxj3kCo8Ffba0eUzI0tX0l9a+GGkWHrW0=;
 b=BDSgUDXIUosGwdB/pk3vnM1CVp7otuhA6roG/BYKaTJqiaZqPdP8t5DnyYbOAKt3DgRDlYqNotCoQ3o9p78NlHCF+pTxw8hl4g3L8x+QZtmrrsb4Zce9OvBCfBTnyrUGtPshC/6YsNSoBWuB06kvsXx7xPqQVHvV0Og0ee2rqNCdvI4t7rtxKT3RdbUECXbTAWMUEVVefS3pyT2lSFtIvNT574q1bnOoLYgscOOwvMCWNWOZJanrKj1y4SLcgTokSBwI1oDsIX7xeyNfk7JqCh0ObtoBDeX9nrWS4k7Yt1uLGhbMeOHR7dB+CY1tmh8nTSCV1K1HdiJzDbitm8pHaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:04:43 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 10:04:43 +0000
Message-ID: <85ea9062-1e16-4757-988d-8a170a546e04@nvidia.com>
Date: Thu, 26 Feb 2026 10:04:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
To: Francesco Lavra <flavra@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kartik Rajput <kkartik@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251126090759.4042709-1-flavra@baylibre.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251126090759.4042709-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 11255213-91ee-4143-aadd-08de751e7665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	x0yNLI2jBtmgffxlkV37xnCq82O/hH/Pr+z6YW/gVIWMgtfIaLSZGAW1iYDpF9HlseNnT3tOLPl7N1KMOhT0xs6d+Je/Z8XrQZrqRP37b/4Q/F+cCzTsh2ZB93OBodXl/ublk7NZChEzwpC11UmhrGgFcp9o1Dn944GZHikkR7IELNrk96VUu7tJT/2yGEpzCp4sFfSdoLal31Vpxa5KcVZJl7uO1n3r9cO3G9cIG6kl4rb8OKIyoRgdUeOkf14WDRB+BiGtSnvnyVSjJDsEzNDEUnx2fAvVSh9ufSzTpAncx4zRvAjgDsQLvwjH1fwQ8js8vOdsQCQNPGemQiwEmz8ZgYyz5+fLP5sa7I+MWlI8Vncs8jeQgkd6/4SvIT+D5QkPOlWYrmJG4q6N01uBE6Qy45MGOzLxbHr8xBh373DJy6qxr6x0YQF9EtkWOdLolq/jnlY8IahNlqKEjp+mY+2TiOkLZ75jeSwZU0/zZpnU+PKVGW7rK3BLDuCxFO0BJQsU/GMuj+zCP8v974sEMxaZHQ7P/UhsqT/w6wN7mOV+WwXDRKXtRDiQ84Dqbc/q1nXPWKHNb3LRfpuGy/Jd+YYx8vGxAccIM1r88dws6FLtOeeb+98nCg1ingVHmclqi4K9MShPDrnvKrTIasE0ogvU0pasE+4qswsXJNJ52Y5jvMfQakk/I//3xtXAPBRxemtz+kz9swv0jKUe74rVtyfE0BRvWZyhg0A2AG0SVFm/OgAa5q+5QM2Ov//RomYSk7NOujv+zRUISwjrhOiqmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNEdVFZZ1RxZjhDa0liU3ZTUDBQLy9zSU5yeEZqU0V5NTRKNXUvVzEzaCtv?=
 =?utf-8?B?bVJJaS9hYmNhckFRc2VYd1NxVVprRExNNk9qV3JEZmdOZXN2aXN5ZWNLenZv?=
 =?utf-8?B?SFJ0NFkwS2VYN1pPbnhaYkpjL2FyTW1pbVhkQng2TE9pT2FpbmtLYnQ0SEVw?=
 =?utf-8?B?TGI4SkhhcnJMeUlKa0h2bEhXMTNsSGxTN0tQcncrcW9Vai9YeDdQMjlaRlFZ?=
 =?utf-8?B?MXRpSCtZUmFvaEJzTDFycVN6NFVzQ0dNVFpEb0VkVzI3LzRRUzNFNnhlQTBj?=
 =?utf-8?B?cXpFNHp3cWI3aWg5R1ZXdWwvZjltR1B2R3JFUHMzUzB4dzhWSloyUS9kMkEy?=
 =?utf-8?B?V1lSdUp4ZWQxN05rTUZUOWxkb1Z5M2VzWmZ3VDlXdWlvYkxadkpQTTNnZ0F6?=
 =?utf-8?B?VmJzTzVObU9IZnFyc3RDNVBLVEJ5NHFQeGcxaVVPcDFkL0ZXcHNVdG8xbmFS?=
 =?utf-8?B?SmhEMUhYZDMwMjFSQU41QWdoQjVUY3oraXVoaFhkQzJPZGxDdnhldkpqcDRk?=
 =?utf-8?B?cWdHNHF1OXdhTU1SMmFxQVh6MVlPRDdBQnU1a2Ivd2w5ZFhTOHpMQmw2OGZT?=
 =?utf-8?B?N0tzZFh2S05LWkxVWjIxa3lUYnZDMmVWZ2FIbmViSGRjbnZjTklsSnFuOXZI?=
 =?utf-8?B?OE5GOFFhcENoU1laNnlnUWdqS09pNmU4U2N5aElRam4xVEN4bmVCeVlLamRC?=
 =?utf-8?B?VXNRN3JPSXYzdGxkb3UraG4yL01QU1JPT0liMXV6MGtFbHgvRjgvdmFOR09G?=
 =?utf-8?B?NER6NmhETFdRc093UGRFODV1aXFjQVBSKzEvc1h2VlRJc003NUNSRjJuVUtX?=
 =?utf-8?B?L3pyWmxrVDlSMWptTCtraVlBY2I4d0VlT3hUNjB0cmJmYnRON0I5UllOYmZ2?=
 =?utf-8?B?L1l1WDRxc1g4eHRvVDh2b0dLUzVrRHhpUVlmdFIyL3B5aUF4cUZxSkFVKzFU?=
 =?utf-8?B?WGNFWmFnSjZMVFhaVDZwaThMNFU5SE9SbnVkLzRHTEloSldvWHNOTkEybS9N?=
 =?utf-8?B?Mm5GUklrTzl5bC9Ud0VTTTdTaVd6U05McXdha0Rrc1VGek1oZWFjakxoZmIv?=
 =?utf-8?B?NjNkY3pkL3RMT0FFV1FMTTNqaXQvdDRsZ1lydnhxb2l0dVcxb3hCSFhBZmdY?=
 =?utf-8?B?YXVRaDYzWlE1dzU5ZnRzbmk3eG40ZHV5RUdTK0NqcERlOHBJOEZlMVFCNlJT?=
 =?utf-8?B?S01hbmQ3eE1PTzFsMlY4NkNUV2hsS3ZLNmdSWFdvcTZNMzVWN3JGcjI5R3Mx?=
 =?utf-8?B?V0l3dmVsdlNxRHcxS2VVNjZwMHF6RWt5ZXJGZTFLSlZFQS9YalFzMURjaktu?=
 =?utf-8?B?QXFMQXpiQW5CRitzdTJrSnd4cjNZa2V2STNybXQ5Ync0ZjVXSEFIdmxxbWRt?=
 =?utf-8?B?U1FKQWcyNExwWTcrVW9kSUpYRitWbUZiblVtOEVPV3B5dHVObC8zUVRsdVdw?=
 =?utf-8?B?SVBjRlowOHlRbmJuV0JJRWEycXcwSkxYSjZiWnFyWkxJT3NnR295WHlwelhS?=
 =?utf-8?B?em1iR2Z5b0FrVFc5cDdoVkVDcks5b3l3akNsNEk4am5jWDZPeDJCd1gwK3NN?=
 =?utf-8?B?R0Q4TU5sMEVaS1pzQ3gxSzV3UnpJemc0d3h5V3hVV0Q5THNEeEUyNWtJbTdU?=
 =?utf-8?B?UHl2a1ZEQ1BKWWpJU1BjQzMxeUZQYU4zcktkOXlhSXI4ZE96Mzk4Rm8zeFVS?=
 =?utf-8?B?bW1JRkJFdDBwbHRWa09VSzFVV0NMQitDbFdTLzZBRW55Q2ZSblk4U1lLQmY2?=
 =?utf-8?B?WkpFTUVNeHd2UlFkcTdZVFFvRjhES043alkwUWVya011OEFYR3dVekNmVmp2?=
 =?utf-8?B?dDFWOWdrSVpHYXF0ek9QeGlDOWJya3Jtd1d6Mng0Y0NtREN1QVZFMmhHbmdu?=
 =?utf-8?B?TFJWa05hek1nejI1cG1DQXlBS2c5RUFlTy9aS21vNWM4QlRVcS94Yi9SOFp2?=
 =?utf-8?B?SkRxRkZDWno2amlWTGpESUpiSVVDRE5RVy84OUM5TjBWbmc5M1l4YzAzZ2Zs?=
 =?utf-8?B?QXVQaSt1R3lXZGY1cHByRDVFQ2dESFVORXFtVzFNaitPNW9lQytaR3MwRklY?=
 =?utf-8?B?aTRwZW5YZnNYRU5GWGFNSGJDN3RDYkw4bWNZRElLbWVoQm13ZG50ZUlCeXhM?=
 =?utf-8?B?WmNXZVJwOGJBRjJDcGVlR0NNR0NudmxBZm5XM0Z3VFRDc2x5Q2Y0Q2ZxNFpa?=
 =?utf-8?B?NnVINzhhamt1M3lxZ3BGUHg1bk1KbUJMeHJ3ckZ4Nk5QN0ZZL2tFL056RGV6?=
 =?utf-8?B?VUNZS0JkNFlXNEhvc0tkQ0JGVit0NmdiMVJ0dVJYMEwrTS9MalN5YmJKQnl5?=
 =?utf-8?B?WEZobEhIMlMrU0Vhbzc1aG1Wc21oNXgwNGU3Qm9PNlV1YjdxSGI2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11255213-91ee-4143-aadd-08de751e7665
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:04:43.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfPmSX1w6M+VmpYzqfEn66VIEz85OcffOAA/1/B6vhnjmJgBNm1CNhfA8P7q1djiJboTbJekZSBLzht6SN8k9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134


On 26/11/2025 09:07, Francesco Lavra wrote:
> This driver runs also on SoCs without a Tegra20 APB DMA controller (e.g.
> Tegra234).
> Remove the Kconfig dependency on TEGRA20_APB_DMA, and remove reference to
> the APB DMA controller from the Kconfig help text.
> 
> Fixes: 60d2016a5161 ("arm64: tegra: Add Tegra234 GPCDMA device tree node")

This patch looks fine, but I would drop the fixes tag. 	There are other 
earlier devices, such as Tegra186 that also use this. Also please CC 
linux-tegra@vger.kernel.org on these patches too. I know people try to 
limit the number of list copied, but we may miss this otherwise.

Thanks
Jon

-- 
nvpublic

