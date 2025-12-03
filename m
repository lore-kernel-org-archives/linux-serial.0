Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D515189BB6;
	Wed,  3 Dec 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764730453; cv=fail; b=TLjnHUyltggxtMIKGA2TVACa1pg/obxZy0+go/Pk7TVpk3BX849P0UvBQS9YII3PleVxcbdScEWLSuvShrG6wkFG/Ia9S2sRra/n21MZxfmMfp+vLOcI9o75wxt9UWlUUAKPgyb279gfDgkCH31rj8FSfNnxU1OjRAPfcdAgaPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764730453; c=relaxed/simple;
	bh=54T0vBra4E18ubarHzqt/H+cazAXTuSNLi8YIGEY4rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F2hy4pv58FTzGQccH5aKxKSPhBDwCgOYp/5okhHkuyrJO+K9yHdCiM2P+AQqLj+mleSJCmYXNHKcZ3qqud2thEJC+cOfswA4xq+D6SkaC4cI73k5uIpJf66o2Yi2KfDksc2sHMUPHrexcjZHtpLLWrw2ZVvtiTWHT7Z6yWGuuxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Eg4kRnp4; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Eg4kRnp4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjEcDPYc7KYoaeR0+Xs4SMdZ7E1AUMDSTjH4wP/2TL3nQWLSdmyOrq2lPgkAIuI0EwvGwL+45+DahutrrWb1NEW3Ucg+El7y6rdOzl1BYG2m6DCUBxYUWFE3uCgAuEn+W/m7hSvH5Uz3EcKGKPGbOD4Kefo+zjUv5hXn00ASEbeNk15mJjkk/MUbWwwtDSXHUAOyjVCgDXg84jwgLFmXKaAkxbFUZ/wYpNee5OjzVwgQYIHvGHbdgbIcDD2Hza6QB6BV+C02txCdx0gOfZ4yw98YVaHbSHfI7FMsxtwp2DBvXu28LK7rt5v+ajzVm8PO6qtOWvxmQfY1KMvdBTlPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaMesjIxoK3g5BigINEN1bG691bq5iL9iTEdBwDOkl0=;
 b=WYc2kjxjdFwCdQKGPnCyptIpoq9wRXiBBk/jIdj9cSxy48+4FTy0g33+Hzbv1JxhzP9Kg/w7clxHo6POwZpLy3LTgrTslYLKklP9YWpQBNeYyUe38FKxlS4VsDK5djn/ZEMWR51FRhVy97AiQp6RGiRLlGaXWF8MC7Zy09oTac3HQilztWQfYunpMZc2zdrZ1pyHqg2LwV10os+CopSijn4ZzYDSiFQlFkEASbMH9O3039ekLoFnYXFmwk2RP6uknbCLKKuUYYyiTge/YX1USIhO6DCQW2oHm+wyTONXhI9VE/xqXiryzHVtjyk3gJofBn8O+AgvcZEtMxBMZlGpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaMesjIxoK3g5BigINEN1bG691bq5iL9iTEdBwDOkl0=;
 b=Eg4kRnp4vTn/UhnEBscS+4bmEHRWYiIhOis8oQGrbcltaSVucq1Ta2YOXA3H3ghvUUdz+evrOjW31WULG0uwmExmR9NLAtJvT70PLLCtdL4My63qCnrr7ail6AOF00fYrltZnI49ObQ/n2TdWQmZNeqFK4juqZE046fCA0MBqes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4453.apcprd01.prod.exchangelabs.com
 (2603:1096:101:71::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 02:54:08 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Wed, 3 Dec 2025
 02:54:08 +0000
Date: Wed, 3 Dec 2025 10:54:04 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 09/31] serial: 8250: split 8250_mxpcie from 8250_pci
Message-ID: <aS-mTGjGtn1gQuvI@moxa-ThinkCentre-M90t>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-10-crescentcy.hsieh@moxa.com>
 <CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeDsVt0GQYUFxLM+obfmqXBPa3hM3YMsFbc26uzWZG-SQ@mail.gmail.com>
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e25f3f-b646-4d42-5a8e-08de32173a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhMd0FvbTdzRExmTWNoV011RTJqekFIYkl0RnFHdFpaeXVoRW4rNXkrd1hm?=
 =?utf-8?B?TDVmbzFDVHUyaVI1SlkrbGZ1N3g0K0p5eUlOMHBwYWgvbkNBWXgvdy9lZEM0?=
 =?utf-8?B?ekVQcXp3MGNMZExuelFDbThkL2JKMGl4MXpPb0N4aUQydC9YTG1WdUJNNXZ6?=
 =?utf-8?B?RThtNmxlaDY4MklVakFVRXFOcW1UM2NlWDVXb2kzaWhiZmp1Y0d1S2ppOXRm?=
 =?utf-8?B?OC9icS9vSUo3cE42MVNjVXdZczFobDZCd0NrTXcvWXBaWUJrMk9PSzE5cC83?=
 =?utf-8?B?QVRVdUJMUjh3cmtpcEZmeVp3VFRQZnlsRngreHhPTzQxem8yYiszVWdKQmpV?=
 =?utf-8?B?eTZQOVQzZHhDemRLa2owRm9zcE1saWhZTnQva283ZWpvTkNNMnF3M3FYditD?=
 =?utf-8?B?WHc2cmt5Vm9GYmx3bVU4TmNzWTFNUEpjb1FDY3F5cWZ0TzAxYXFqUjd6ZlpQ?=
 =?utf-8?B?VTFlWUxxWmRUeFRtT1poeThBZzE4bkpIWlJnTjVOZjVmL20rNUZvQm5BdXc1?=
 =?utf-8?B?S0tWYjNGVUhZM2VyWGlkTEMvYlN6akRzK1puRjNCckhpN0daYWJVa203cXdD?=
 =?utf-8?B?NUNjK08vZzUzbUsyUXZjRFRrMk54a0poRG4wOUwxTkM2TDNMVUVweHducnFm?=
 =?utf-8?B?M2laMVBQZmZyT2Z5VFFmV1ZaNzhDMmsraW5qOVQ5cy83cFpadzJmVUdrOGlD?=
 =?utf-8?B?MnJMd0xVM21hUGN6RWpubzBHbmwrUVJBWVR2SHhvZFovQjNnRTd6NnV0ZHFt?=
 =?utf-8?B?UXBndFFJcHh4UG82aG1sSUU4VFcwZ1dsVzNMSCtoTk5uTlFPdXg2YjFuZ2dH?=
 =?utf-8?B?Sm9yNW9PT0x5Q2xweE9EZ0J2OHFyK0txeERkOWFYak11VlNUcUZHL0Q2cWlk?=
 =?utf-8?B?VnFwcnJNYjZac2hwNVBLUGlxdURrb0drT2FQUjl6WVQ5Tm45MCtWa213b1VE?=
 =?utf-8?B?enc4TWNkMDNGcU9nYkFuR3UzVnRJVmNUaDVCcEhGaXVQMUN5L1JFTm1QcUpO?=
 =?utf-8?B?dUwxQlVWWDZRV2JpUFdRS3lSODhKc0xCUEhRVWZoZnZIb2xOSGR1UlpCeGRy?=
 =?utf-8?B?YmdwY1FMTTJVNzFOU0pOU09ONndZMFR2dS85RkZHVUlUc2xHZG1PdUZYMmh4?=
 =?utf-8?B?bUg1YnlSYkVSKzV4SG1RVVRpL2lLa002Z3RXZjQ2MmVNTWNYalhsdFZLK3px?=
 =?utf-8?B?dHdkUDdOeVN0VWRSU2FMaml2VVg5TVllZW4xcjV2RXhGK0JrSUw0ZWRlakxF?=
 =?utf-8?B?d1kyVlJqSFZNRkUyVW1OekhMVXhOeTF3N1VzcGtoOTY1eGhIdEp2eVdURnZi?=
 =?utf-8?B?R2xsbVlyMlIxTEU3VjlSTHBZZGh0VVBybWJiYWNmc1BQeUQwZXYydmJZSmlM?=
 =?utf-8?B?ZHhLNlFZeGZybHVwdStXMUt0NjFGbjloWmNDcUdqWlg1QWRqQmJCZERBNkdR?=
 =?utf-8?B?bGJJaEtwSWdoMjhudGR2Rm1tZVJWUjdGbm5HeTNhbkFMaTNaZGV3SXljU2dS?=
 =?utf-8?B?UlFpOXNyVk5QMGhzWnpIcEUyTmtvOTlFdWJqNmZPTjljRWJvdng4Y2M4R2F3?=
 =?utf-8?B?WWFEUXdEMzlPS090cWszRGRJUmZwNlRINFdVWHgzY3lWWTQzeHpKakwzY3hO?=
 =?utf-8?B?Q0tQbjRUVXNoaDMwT0l5dW1reGtQdndQNUxOTEE2TmZMVXllNmJ2UTE0QTJM?=
 =?utf-8?B?UmVpOHFUT2syZGU2ZUZHVThEbE5BbGh2Ukkzb1lTRlhBN2lGQUNnR2FrWlht?=
 =?utf-8?B?dnl4cXVUb2QxYUNIa05nQlNTaWxoc1dFMnBQRkRjbDY3Z0xjNGxyMmtXc2cv?=
 =?utf-8?B?ZnJkdzhsQjV6c0U0eXV3b2tpNHBLZnVMWDYyZDJwYUVBL01mcTNUUnhSSXpH?=
 =?utf-8?B?Vlh1bHRFZkhSbFpKWkpXclg1TTFiQUZwUVp0NU1qR0hxKzY0UmNKRjNLd2Ry?=
 =?utf-8?B?N05mRThVVEM3aCsraWR1dGsrTkNsOHNlZWYzTWxUUUNKM1c4ZnFDTGx0TG5o?=
 =?utf-8?B?bVFKeWNxUTlOb0RLSXd5MnZXZk5tcWtNMXNjNnBXWWNXRmNLZWx0MkdwaUNx?=
 =?utf-8?Q?joSS5p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVNaZFRKbWkvSE9FZjRtVHBzaVFXYndVRC8zM1Zqb0NvVTMrY2h6WWhyUUha?=
 =?utf-8?B?dGJiREgza28wNFBQNzBDa3dEVituc1FVem9ySEM5a3JtdmNEaXlDODlEN0hS?=
 =?utf-8?B?dVJFa09Oc1VSYXp5M0pMRkI1RGF4ZkhpMDVsZ1FTbkRoQVlGdzZNM2d0Mnoy?=
 =?utf-8?B?VXg2c29pNm5rTDBseHJaVmpGQW5jT2hYSWdpSGdDUUk4NU5ORnFjRVJ0Q2Uw?=
 =?utf-8?B?Mmo3MTdGVGxrUlhhUFFCTm1aSUczdUEybVdQcDBPSHZKeGV4THl1Rk9hN2lC?=
 =?utf-8?B?R2h5R3UxTVBKRzBYeVg3UkVrdXhDbWhkRjRJZ1Y5M09tTFc1NkZrVzJPaUtS?=
 =?utf-8?B?ajdHakl5NVBxVFlwdnBQYkdrTUREejFudUFneTRXQ3c2Nk9qSEhqaERYMjlB?=
 =?utf-8?B?S0tSSkd6djErYTdKODZzVi9IQTU3UktVY1RCcGF4bnNvN1p2LzR2cUJOUHZR?=
 =?utf-8?B?b3dSWUFsVkNGYnVIQ1BBYTQ2d0hrL0xaNW1XQWF1UUVjQVpKNGdCNzFBLzha?=
 =?utf-8?B?NWlJRUtER3g4bmNXby9mK0Q4c1RyYTJhRWZlUTZjakNkbHZrSVRQR3hKNTIr?=
 =?utf-8?B?a3pjbFY0RjNFSXd3bjVCOHBNRnUvMTg0TmpDSlloODcwUVJOS2diTzZBN0x2?=
 =?utf-8?B?Z1FqOGdGOFM2MVFEUWtOb29BQjBVa3ZaUWlLZHBaSzVYWEMwa0szSUUyQkhh?=
 =?utf-8?B?TEZmVGs1ekx6dDRVamdHU20vUW52bnh6L01rVFkzRmIzZDBSUjVNZTFaWUJC?=
 =?utf-8?B?Q2ZjcVd4cTk2RWJlVWgvM2NsODFZc0NzLzhhT3NibzdscjVXY0JwdFZTY2hm?=
 =?utf-8?B?eENNSFlOcEdmRHppZHF2MEZKWVdSKzJZUHV5Q1Fqbys3aElYNitoZy83OUh6?=
 =?utf-8?B?VW1FRW41ZGt5dmhMVDdKdlNpTDEyNkV6eWVkRzdKc1Z0WTg5cjdVWXNEQVRl?=
 =?utf-8?B?S012bzduU3JFZEtaTFJpMFVveTFKRGlJM1ROTXpnaTllSWVnRFJtQlZGL2tU?=
 =?utf-8?B?UzRCb3N3K1cvWCt5c1BJM1pIb2xBTlJmU0ZycUJPWEhCM3oyS0xsTGlxNXZX?=
 =?utf-8?B?Rk5VcG8wbGNMTlRFTTJMVnhESUp0WFBKSHg1VTgyRjBjOG05RlZQVXlrSmI1?=
 =?utf-8?B?SHNzUnUxL2dVQktpKytMUHliU2VJdlBKMWk0ZlpHdkRqVU50dE05OFNCeDM2?=
 =?utf-8?B?UkJwdFJrbGowL3MwZ0l1aG90dGNRbzJNcnpNSytOZkNySU5qc3N6M1V6bTN2?=
 =?utf-8?B?bWFYdVh1a3pTWCtLVlNTWWgzZjhsRlQ4cWRqUkVQZDVBVkdxQUhqSEM1YS8y?=
 =?utf-8?B?REsrL2x2T1ZrdjJNem5Oemw4SzhidE12VHl6MFJKWEJGdVloTkNCS0RVQ0Jq?=
 =?utf-8?B?YnRKVnBaNHNsaWt5LzRwQkExMUF5Y2RTYS9lNGlIOGFHb1NkdE9HOWFHMkg1?=
 =?utf-8?B?aFl6Z2FNemFDQmZ6NUI2VjNQRm9YVGRBZFFWWWhESlFJUXA1NklSb3F0WGtx?=
 =?utf-8?B?MG5OdllEcW5hOEloZ2luZm56ZG9McDhVNkxJRE5qM1dnZys3amhuenQwYWtq?=
 =?utf-8?B?d1hqQ1JYZ0ZocWtkM052U05xVm5TQUFPd0ZLQXNZVmd2cm9jZEpITStGM1hn?=
 =?utf-8?B?cEUzR2RtWEhtK0pwelJzZkN0RmVqTlN1RDdzRWtVekpGM1RaZXNPdEZRS0o5?=
 =?utf-8?B?K25RRHhMdTlpS2JIQlljbGxpWXZESnlHYkRMcUE5UzRSRyt1RzFXZzlpdFc3?=
 =?utf-8?B?L0Z6N3NCcFkwVDNHV1g3T0szQ3kyQ0ZISmd6Y3F4QTR3WFZ6S1NKK3Y0bkZS?=
 =?utf-8?B?eU5TL201QVN6UXNIOW1mY1BlcDJRWUVqSnhUVHpoajNHa3VaYVB6S1JyQ1dE?=
 =?utf-8?B?TENnTFZOaXRjRGpYNjNTZ3FoYUIxU2ROZkt2S2UyOFFQZkROeUVSVFMwaVNC?=
 =?utf-8?B?YkVhaFRhSlM0eUh1c21senc1WUJXUG9FRlk0VkFyOE5MdFdDTjlQSkVDTFNS?=
 =?utf-8?B?VlZxZ0lGN3pMUUFSa3R6ZkVHNnpQazNQVjBON0pFMitLMFpxdktLUnFrdlh4?=
 =?utf-8?B?a0daZzVuY0ZwMnBrVVo5eVMvY0pZZXdYaGZuaTgvZjdNdUNkcVBQT1YwbTZP?=
 =?utf-8?B?VFpZRmUwNjBoNkRsa1prckhjUUFEbE1qL1dvOHlGMTFxZlJGZ0EvVkFoS2Ir?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e25f3f-b646-4d42-5a8e-08de32173a60
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 02:54:07.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cv3eMaQpglCZPbJyd/lwnKpO3McR8WI4Z3mtEVSdJyEgGO9Bi+Nivbt7kfJGOzHVd4hw3K1Kn3AXZooMVSpdF/xohRh3qYO7vWh7gH3N7w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4453

On Sun, Nov 30, 2025 at 09:22:20PM +0200, Andy Shevchenko wrote:
> On Sun, Nov 30, 2025 at 12:44 PM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> 
> This needs more headers to be included
> 
> bitfield.h
> bits.h
> dev_printk.h
> device/devres.h
> ioport.h
> types.h

May I ask a clarification: my understanding was to include headers only
when the corresponding symbols are directly used.

Is the intention here to avoid relying on implicit includes and to make
the driver’s dependencies explicit?

---
Sincerely,
Crescent Hsieh
