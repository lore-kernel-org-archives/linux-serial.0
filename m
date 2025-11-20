Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2218184E;
	Thu, 20 Nov 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623862; cv=fail; b=C2a0cTuRJXNji69oaXjasgwG71XgXxbvExzj/iOQKZpSbU+DTijeA3yxZXlfx3Iwc1bDkZnhLvcj6f/f6YOnfLOI583rrqq7YR8ril4E4AjVF3OQd0xziliMk4Fvw42ujlmWwc4/VfqFgM+yHU/j9DeEpoqj/qMfQxL3rd9GdwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623862; c=relaxed/simple;
	bh=u0zgV80NIv0YJW70sLtig5H2IG3BeAltgiLOl9kWpic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W8NzKoKyntDUzs+JWWmscb8NFU5VtdiWfAdRedQR3HDRGB11JoM5imBXi+7KSIQKJzTEf3P0yAU2GUhLAJFdfB/pT7mQT2soYsoreh5zyf/bniJB/ycAbKOCTDgIXjPomUv3Sg39XjQeLTDxgen2kyxe2hGa53xMiHWydNqIq+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mYvRCPE8; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mYvRCPE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXeCQhXfUFYW89wlmHrwBZsAIwR/6doIUi9gb5qeovBqu6FkQDiFn+GOxeKXQ4kr8jjkH9Tprw0OW23Zhynl2fulCGi1LJd3v1IKDoOcBXpsO5a8a6wArYL8D6IiJq5uRbI0ykj4vZjUAZ9Qrt/ofL2Lx6BDoUagNlyJi5luzvCv7FMJPEY8FtmpiZhr5VXHJiyZ3bfcKkmV7u8/VUZK5KoQYrzFm3DEirMC30oLP/Ko9EiYsfUQwijbtiFEPPowMqYpH+1fT7RTMLxNXDX96G66ICKubfvSRIph2G96idyTeaRPK+Lhd8pm4r0Y+qNTI06VJ738WJvXElTlgCo7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNkPQMug6FI+cdKY2OU/g/mQk+dT8UuqwsleIvi6Xqs=;
 b=yM7dViQ4lcyuAwTMsALksW0b+IC9aCLb1SFlfiJFJlC1rxR5+rqBY/GI19LkDJzknbcD9Xp0TibwxGYhJWX93rvuLZhmskw0OQZXgd9ClC6bx8ajqT2D7HwwFb/JE/r8xzV5uI6P77QN6guYrVDv9Qu7bgA+i0YdgOkJa/3wc4U/ClIC6/JnVTlWaGI+QheASnWyyQ3gBI03aYRJ8WstN/tx8HBHkLjd683trPwKZQBKvSFAqSHt6fyyehaKPZDr+auP1bFjegxHUJdcM5kcL2hhfv2i+ZvzHzA6csGI3MowThUJs2f7VGOpMbi6WqTEyPmTaOZF5stEdKz514jNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNkPQMug6FI+cdKY2OU/g/mQk+dT8UuqwsleIvi6Xqs=;
 b=mYvRCPE84PAOshjx0QRJF812uV9vFIk5DUInV+/WhB6AFmRNGxVfp1DfO8yyZ9R6pgjfQHRBq2P1uRnql9Ftv2jeXUEF27y7c+l9dNHn++cRNRL7H/8sh1MbIqmxuNd0tuwRH31sl0R/8ikA3oHub3ZHum0tVjPlh1ID+kmN954=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:30:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 07:30:56 +0000
Message-ID: <aefd886b-381f-42b3-8c58-ff8834158675@amd.com>
Date: Thu, 20 Nov 2025 08:30:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] serial: xilinx_uartps: drop
 cdns_uart::cdns_uart_driver
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251119092457.826789-1-jirislaby@kernel.org>
 <20251119092457.826789-3-jirislaby@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251119092457.826789-3-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: e7751d08-691a-4290-d8af-08de2806beb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZ6dExzQ0dYNERicmpoRTBMd3FzdGhIZnE5R1RpMnVwaFk0K2srVE96ZFJZ?=
 =?utf-8?B?clQzcCtzSW1CVWx5RXVOLzhyKyttV3l3YUtGN1lPRzZMYUt6d25qQTFiQzBB?=
 =?utf-8?B?TDkzOEgzMVlZOUdCaFVrVnlTOG5QY3NqM1JFVGFEQUFHMVFWTjB2dHJvVFZO?=
 =?utf-8?B?bHBsTFAvc054TTMvdmlHVkh0cjdzeDhFaWpnY0VwRDFUTWJTZi9WR1N5QWEr?=
 =?utf-8?B?WTFscVhwWktPbURGYzlYYkIycHp6MFJEUlUwUkNnSVFQZHgyZ0V4SUxWdDVH?=
 =?utf-8?B?UmcvRTNma0N2c3VBd2NwU1B6RC9GVGRLblFPVUlNUTBSSFhsYXJrNzJlL1dV?=
 =?utf-8?B?UENpanp6SmwzUElENTI3MkYwWHVFakk2U2FUcVR6Rms0SVRkRURDWEtBRE9G?=
 =?utf-8?B?YU5tL2pxbVNuS1NSVmxFbEJQd0lBSVdpUmtTbkM0ZDgrREltbFNLdmxxZE54?=
 =?utf-8?B?MFVoY09VUGsvTm5mSzV6RmNmc0RuWE12SHhXcHViY3gxTi9HR1A4WStWQVd2?=
 =?utf-8?B?VklXTWUvR1pWQkN1RkYwNllPeUx4UEJQbjYxNVhDZ1RYMm1Leno5S0hEVnNM?=
 =?utf-8?B?Yk9BZFZvbEZzT0dGbTNKbi9CQW1Kd2NMUldLMzJXamFUSUJUaHlSU1E2TGcy?=
 =?utf-8?B?TVAvZ2hMZjFZOEF6bE53ZmVkRUFWVjZYdjYwWjZWK3dML1NGVFU2L3FaSldM?=
 =?utf-8?B?NGhSQmx5aGJsRUhXL2gwVWZTZ3Q5bUFuYW1tMWNSOGNGQmJYMFpQYyt6QXUr?=
 =?utf-8?B?bVdxU2J5ZGorRDVpTXl6ajJpTXl0UDQvYnQ3MlcyR1JKWStNY0lZSUlqVGdR?=
 =?utf-8?B?SnlsSzlUblMwU3FlSmdTakZMc0JMYWM1N3RNbTF5cUVLKzVmZnh4QXBtMm1J?=
 =?utf-8?B?WmwvK3V4aHhJZEZoYWxNUHNETFdEd2pNa3hDc0hOQTR2UDQ0ZHI3bkljYnI2?=
 =?utf-8?B?MFhvcVNUTUN4TVVha0RyRHlJT2lMQlNhOC81WGZLWVA3TEhxbXJEQnVwU3Jq?=
 =?utf-8?B?RzRpTFBKaXVIU21aVUNsdnV3RUxpZU1SdHpWZUdmMFpMYVN5QnB1OXFrRXR1?=
 =?utf-8?B?MkxINVpwZytFT1RpOElmaXoxODdxWlhQazR4cWVPaGJNbVY3OS8yblpVcmpr?=
 =?utf-8?B?dytvU2ZMbzFLZDVpemdaVEFqSUtkZ3lLQWppVTdoSjl4R3dOQ0xuTzlSbnk1?=
 =?utf-8?B?YUlyL014YnFMR2FlNHBLamNQNlFyeDZoT3VVUk1lSjdZV2ZjcGlnc001VVlV?=
 =?utf-8?B?aldSRWlwMnp5YUFWTWZpZlAvYU0wRXN0a2tsek4wNEtWR0Vlbk81dnJoUllK?=
 =?utf-8?B?SFlrY3NZSW5qTFBoZldtOVR0TEFuTkRhUnlYamNnTEp3Nlh2dGxZK21iclVm?=
 =?utf-8?B?NFRocVN2a2tuQi9JVWZURFBzMzMvQXpCdVgvdXJVRUoxNTRWVlQ5bCtxUmlF?=
 =?utf-8?B?eDdZSGI0VmN1N0lFMDF3RThsUEprdE1BWEpFODZwV2w4cGMycEZDZ081S3d0?=
 =?utf-8?B?UDM1bVU4Q25UcGFiQ3gzcjRjSjd3eVdobjRlL3lPUVhzS3Mxc1E1VndLbmlO?=
 =?utf-8?B?dFRiOGNoKytEMDFFVVhvYVFPTU9CMWZaaUp3RjhqUmNLUUhEWWdNWkxPZHVt?=
 =?utf-8?B?QVgvZi9xTjU2YXpRK0xjQyt2NUx0bHp4ZUEzL3V1MnBXOUVPSWNyTE96eXZV?=
 =?utf-8?B?QkxiNW91OC9ZVVgvMHNtNVJnNkZiOHEyYnBUaUVid3hyTElqMFJtbzhkNXJM?=
 =?utf-8?B?MUhodFNNcFNaTXk3QVFibFlhZWNjcGVMVWxIbURJN1NZWFE5UDNPdE1jUlI3?=
 =?utf-8?B?RC9oTWRlVmVtV2dqOE9JV1B0ZjZKNjVCRzBNS1loNjE0NzJaeFpRL1lZK2Fp?=
 =?utf-8?B?Mk9rOUpXMEhxMXZhczArci9LQ3QxbkZUcUVLbzJLUENZcXVXZ0ZrOTA5WEFM?=
 =?utf-8?Q?HVmETk20dDgLQNvcJHmqe1FJxMuyqjW2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dkdndDeDZ6cmV2L3FnTWFtV1NOWkQyYjh4UHVNVlBJT2NkVFA4TGk3b0ZW?=
 =?utf-8?B?dnU4QmlQUUN1aHQvdlpUS0tBTmxzNlRJVC9PdTYwRTJ2RHBnU1lQMG9LRGZm?=
 =?utf-8?B?eEhVbTVyUXlYYkNjdDJmckFPVnRoWFBVSEg4SnN1Zys3WlJIeHJVN2pJMTBS?=
 =?utf-8?B?MkN2YWxwNDNJQlk3OG9DblAyMlREUUJKM0tYditsRXBUMHE2VnhSNHZSZTNR?=
 =?utf-8?B?YUJxa1FpWjhBWXlXcUcwd2dabTIyWmZzdHJnU3lWNWIyTWhOb0lES2tLZDRq?=
 =?utf-8?B?d2M5SDhMNXgxM0ttSlJjaGxlaWdHVnhLN0pVYmhYbkpUakVuY0ZucUFJL0tU?=
 =?utf-8?B?SjVTd1ZDZVhvd1YxRFpUN0dJVm5HOFI5MXdZbGtIS281TVg5LzFsQ2lXZnFa?=
 =?utf-8?B?bCt5SjNGWUFrT21BNm9VYllHTU1JNVpmVlc4ZWtHenBwU2Y4Rk9GQTdsOEJm?=
 =?utf-8?B?U0c1bnNIYTJhVlRTL3FZOTdRMGVvQVFuS0syRGFSUHlBMXlMbkg2WEVFaDRD?=
 =?utf-8?B?b2w0V3dDUkZycDN2WktNN0MxM0tUalpnZkppVDNpcHZ3RFBuT0xDU0hXbEZJ?=
 =?utf-8?B?WlJyaVdQN2FnRC84Y3hjTm5qVjZwQ3RsRFpOS3JlVUdwdVVscVRlSExMNkZ1?=
 =?utf-8?B?d1ovdm5KVW1nakRIbEhRN1BxS1lwTjF0bU5xM1N0KzRWTTJCbWRCQjZDRUE5?=
 =?utf-8?B?RXNWZWtzanowbmxjNnFQRk1TbFI1Y2wxN3VWaU1PQWl5SHJQT3lCaERWUVZz?=
 =?utf-8?B?dlcwZU5OWitMNlZvMzMxNzgyL1NJSXQ5U2FjYzkva20wSmtVcnZlU2hOMFpQ?=
 =?utf-8?B?Q0VFaW9FNDFOTUFsUXh6cEcrd2RKVjg0alFOalJIT2VlUnFNYmFUN0tWSXpK?=
 =?utf-8?B?NlBzNnR0ZTRlZ1JPZW9QRUJydTlnQ2lJRFRjT3d4Uk1nSTRPb0tFYTJKVzQ4?=
 =?utf-8?B?RkF2OS9BdXFGWHNJeFNVQlh4L2tIdGV0aTMyVm9oWXBrcU5YdVpIWXpUalhX?=
 =?utf-8?B?czhPMDU4T0pwSC90UXFTbE1waHYrYXJlbmJTNitqcjdKTE1wdTIrMWpVMWo5?=
 =?utf-8?B?TThBVlU3K09xdTVZS1Q0UkEwWWFyWmtjbGVsM1VZdDhOSUttT05ZaWo0Y0Zr?=
 =?utf-8?B?akJNTkFmRStMRnRrNkxOZ3IrRXBoQkt0ajZPMjlVYytqRjJ4MGpxQmU0eUJH?=
 =?utf-8?B?aXU3NEc3NGlKUUxiVkt3eEVkZ0FtbXdUSXdHNHByY21aMlN0ckplM1pBSjhq?=
 =?utf-8?B?cUp0MDdxVkw0OUU4ZUJGd0lCYVpoajR4UW1FR2thUkFWTWlrSklzMklqWldp?=
 =?utf-8?B?YjJBM1p3TEdUMXBUbjRzMjduTkRRbGZBYnZNRk9IRlpNeVdPdnd5TFYrcUZP?=
 =?utf-8?B?by9SODZmMGNlSUdhUUNVYVQzVmpDem5TNmk2S0NjSkRnN2kzaXNZN3lCVklO?=
 =?utf-8?B?bFQzS1BqRVp0d1l3R2xsWlVkM0xPN1hEanhObWZtREhOeTFReHl6WW84c3Jl?=
 =?utf-8?B?blY5dWtybmFiUjRUb2pLa3pZYnFnZnlOYnBhVFV2Y2pvSWhDeFN5Sjh1Q0ht?=
 =?utf-8?B?SGovWTF4cXRxcmt3L0dWa0Y3YUF2dWw1ZUpVRDNTRTQ1U0ZzNVVlMGh6NUJC?=
 =?utf-8?B?c05PeHk1Z3NXNGhrRHN6aFlQbEpjaUo4QVJZR3RvSFlYTGlWVUpySlhzWWJK?=
 =?utf-8?B?eGdQOW5zcUVCYytkZU5Eajk1NmVndzBBMS9XcXJMcGVlZWlsdjFFMkhGQWZo?=
 =?utf-8?B?eUJmeEgzTkRiK0pGd0pNL3NTdDdoYk5aNHp0a3pYY05WN0lnZTQ1Qk5QT1Bj?=
 =?utf-8?B?NlhGSU1hWjRYQytyUVNPd0JhQVl2Mi9wQTJaL0lMQS9RUWYyRE5vUzNuNmIw?=
 =?utf-8?B?aVJBSzllQnp6eWlpNDNZa0xOMlFQVm4wN3BjUEFOc0RBR2NRckRpV1A3SUti?=
 =?utf-8?B?QklHV1BSTXJZSkxVZkxyQ0ZsbHVHL2J1RnJTUkRuejBGWVlzTmdqdXZJdlp4?=
 =?utf-8?B?dXRSYWZMMVhCSStYeE9MK0h3blV1VVVkRVhjelBGOS9qRGxQK3VKSm13OVVj?=
 =?utf-8?B?elFWeHBtUTZQcDhHNEFWUCtSZjh1ZXArK2RQajRGZkkrTm93VW53YnNMbXJT?=
 =?utf-8?Q?cyv8I38xqkjSSyS2nbjtJOX52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7751d08-691a-4290-d8af-08de2806beb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:30:56.8513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOvUirHOQXM2gxCiIahzp7ZyeXu79r+oTzGqcQfOESM1mlN1FphFXSYeGsLok6X1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981



On 11/19/25 10:24, Jiri Slaby (SUSE) wrote:
> Provided the uart driver is available globally, there is no need to
> store a pointer to it in struct cdns_uart. Instead, use the global
> cdns_uart_uart_driver in the code directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/tty/serial/xilinx_uartps.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index a66b44d21fba..c793fc74c26b 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -190,7 +190,6 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>    * @port:		Pointer to the UART port
>    * @uartclk:		Reference clock
>    * @pclk:		APB clock
> - * @cdns_uart_driver:	Pointer to UART driver
>    * @baud:		Current baud rate
>    * @clk_rate_change_nb:	Notifier block for clock changes
>    * @quirks:		Flags for RXBS support.
> @@ -204,7 +203,6 @@ struct cdns_uart {
>   	struct uart_port	*port;
>   	struct clk		*uartclk;
>   	struct clk		*pclk;
> -	struct uart_driver	*cdns_uart_driver;
>   	unsigned int		baud;
>   	struct notifier_block	clk_rate_change_nb;
>   	u32			quirks;
> @@ -1465,7 +1463,6 @@ static struct console cdns_uart_console = {
>   static int cdns_uart_suspend(struct device *device)
>   {
>   	struct uart_port *port = dev_get_drvdata(device);
> -	struct cdns_uart *cdns_uart = port->private_data;
>   	int may_wake;
>   
>   	may_wake = device_may_wakeup(device);
> @@ -1489,7 +1486,7 @@ static int cdns_uart_suspend(struct device *device)
>   	 * Call the API provided in serial_core.c file which handles
>   	 * the suspend.
>   	 */
> -	return uart_suspend_port(cdns_uart->cdns_uart_driver, port);
> +	return uart_suspend_port(&cdns_uart_uart_driver, port);
>   }
>   
>   /**
> @@ -1550,7 +1547,7 @@ static int cdns_uart_resume(struct device *device)
>   		uart_port_unlock_irqrestore(port, flags);
>   	}
>   
> -	return uart_resume_port(cdns_uart->cdns_uart_driver, port);
> +	return uart_resume_port(&cdns_uart_uart_driver, port);
>   }
>   #endif /* ! CONFIG_PM_SLEEP */
>   static int __maybe_unused cdns_runtime_suspend(struct device *dev)
> @@ -1686,8 +1683,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
> -
>   	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
>   	if (match && match->data) {
>   		const struct cdns_platform_data *data = match->data;
> @@ -1862,7 +1857,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>   	clk_disable_unprepare(cdns_uart_data->pclk);
>   err_out_unregister_driver:
>   	if (!instances)
> -		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
> +		uart_unregister_driver(&cdns_uart_uart_driver);
>   	return rc;
>   }
>   
> @@ -1880,7 +1875,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
>   	clk_notifier_unregister(cdns_uart_data->uartclk,
>   			&cdns_uart_data->clk_rate_change_nb);
>   #endif
> -	uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
> +	uart_remove_one_port(&cdns_uart_uart_driver, port);
>   	port->mapbase = 0;
>   	clk_disable_unprepare(cdns_uart_data->uartclk);
>   	clk_disable_unprepare(cdns_uart_data->pclk);
> @@ -1896,7 +1891,7 @@ static void cdns_uart_remove(struct platform_device *pdev)
>   	reset_control_assert(cdns_uart_data->rstc);
>   
>   	if (!--instances)
> -		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
> +		uart_unregister_driver(&cdns_uart_uart_driver);
>   }
>   
>   static struct platform_driver cdns_uart_platform_driver = {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
