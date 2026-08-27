Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E9379C5C;
	Thu, 27 Aug 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840976; cv=fail; b=m+ZJJ6qg5XJbloiB0PNoVa6mNKfUS9fCF2jdS5J3QFkkqRFTOyHqyUOrltVmiN2DVvh5/aFtHb5lf4BbxdwW9mZdFYteW7Ah+4jBvrYuZ2JGUxb/8cXnj87iKIfldyWtmO28ujtrSIP/hEQTXnSa9ReODqEb1Z+PuTnVudXeWBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840976; c=relaxed/simple;
	bh=eUCRx5WZRpGI9Uqm7idT459N80D6NE/fCzQdB7wTB+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SdfLRYQTHPn63ObaCHWkLTjrsZFLm7UwdUmFzdJMyqiVa6RBTsyrx27MSynitF9hYS2fbxcUUlpkcCcAAQJUPqRYrCHqBQXq3FEHmX/a+SBN17IvukDJipF0z9ivDfEJxglDtBEbSxBoXGt52CPcNCshwOWtYASZbqEDShtOSM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFm33xar; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFm33xar"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYQ8YGq+ft0jVh8h9qHFnkYV6djWBWMrqDKqY/MOVqySHE7nVsj4Tiu5vQfkrGqsaZZt6IdgQN9gMrimKPIQyXOwkHJdU+fPPQNXv0eV7b1mvntDoW1JAW+wyrG3fT01gTb/Gqgtq+9pT/iDT2TjW5TWhTWAht2ygFbq4cvSnrAChSVcnX8npRwW6c8apCCY2Ukj4qQfvWZBaZHh5ke5GhNiZ2sBgkq3NbbJerVVA1uj4dB1JZobidnPQha/kSQ7sT2yZJjPmKgkFMaEHteBUrsY1SHYmUEpP0KqM6/8BiEftQGgD/DY/oRcYrgutOB9cJBXRBxZ+LoRHu4UR/unYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uK6/Ztl/KgiwtNN+IMscuPIqN9dKA6OZNcHCY/hCcg=;
 b=X3jRGPoBcqfaL319yzmzADkdCqkIm4WytyJ2EmvpSRyNvB9omozYV2qocQUhEIPfzNbTf1R01+lfXZTL8AX2EsRgRhodsYHwReMRzjtf6qMpY8bVw+N6SZ9xOw4HwEZM7Twib7aGhHXDwbfYTwoYUr40dSIANrD6yTIpQLhItSDlKyYwDyRr/lH+UK5EqgXgPFSS1vHYs1Jh7xH0Txx1CTScvbwZSQ+P3/MhSP79stekpnEa3q2iUZX2HVKOv6pxi2YzdwLSsi84BG6yucjzD3HKqgGhGCmilgVMtNC85u8zIuCB5ip1lAxnL3IRp4SVzxOJBJC1uc+lwAeoX0VZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uK6/Ztl/KgiwtNN+IMscuPIqN9dKA6OZNcHCY/hCcg=;
 b=YFm33xardI9UjNtW8ua4yH97qdbLj24s8PwCIyp12IjdSJvkTejPCXB2hp8RsGurh3EBBjbdAskC+i22SRHDcDTDN0OM4iiBQRf2Xg6gJrQbaefuuMlfX015y0VjNNifCW7f2PtCsBUQK7TR3TbTftU2MlQfHaXbj4RzJHmzC9oDALZTHAbk8k/a+yR5QBoEA0X3xhX+FklHmv+lAAlGPrF8G7nra1iIk+S/usO1JAJxZF8CYII2QaNFG7iSZ/4RRdgRXYGOB7z0J3JXKYXwpWvteuUwI7TWBf362Af1DSi6wbAmT/8ud8khSSXv6nRfRUpR/e+LIwPniWp52rw1rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 BY1PR12MB8445.namprd12.prod.outlook.com (2603:10b6:a03:523::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:29:14 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 14:29:14 +0000
Message-ID: <791131d7-cf8d-4572-8eec-df5fff1783a9@nvidia.com>
Date: Thu, 27 Aug 2026 15:29:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: Thierry Reding <thierry.reding@kernel.org>,
 John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Marco Felsch
 <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz> <87a4qh9gyk.fsf@jogness.linutronix.de>
 <apAEsebh17YagOsa@orome>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <apAEsebh17YagOsa@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0022.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:276::14) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|BY1PR12MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f78d562-3453-4d00-f56a-08df044791ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	3+B3Hix0F/zMrqA1xFXA+l/ydwyKmILnmAtO/N/Vidhvfx88w2hWW99FrHbMKsi2aMZB2VQX9AiWiTciPOvhFQQGwga5I9MzfRMZ3BNmrLSj2tjTfw6Db+zDGawHzMmubSYoLbk7tjLiGEUsHDe9UEwDFpA7mKvOH/Fw/Y3fY4nlJ0wvze9gicNLIJdu2BWZxE+3jEId6n+szzDZZX/D1BoOEYJUGnMAR+yKiCPalwOHVNxVnGTLjWmdkdZ4arrbYkgW2XdNn2diS+3hFIsyCazVVP2xemjElQd7kPa7R2VwCCN1gqyRDVUVfv4Sg87vtKqzLT2T9sF9yoejFmdq56q9xfaTb6+tbj7yvXtIy0YQEfZBngpvQXmxgM3gBjDhA/T38tcPCgm4DkhD7P2sHgP4EhKFqMxWSx/2HQbmC+jRnoEr5bgQax4Qe1GbtuC5I3zGeY+e077deTUdvO1MumSO15o7AalY6rxcUCuMTSL+2BxImMmH3GPRN6Somw2+B47IwMwsUr8b8avwTe59m5U+3/uNzMfJzR7hgZ5Y2FeIQhYuer6c5lbmquI91rHkhxAme/uELUkvCc+9vNjjtn9MID3u7Hxvn8T2kDM1jzSXYK0yB3CyPXX1dgdONRwEeApd9vDxxzPmhwLjEsx+UQzsl/FUJljioQqF3DVp3HA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NENkRDMyUEluZDhFZzMvdlB5dHNDa1BpOENlQytYcGxnb3Z4UzNaY1hmZjhm?=
 =?utf-8?B?K2c1Vk9HNHdZTjJnVzNUUythOUxyU0xtVXowaHU5ejV1NmZYQVdiTFU1SzFu?=
 =?utf-8?B?MDI2QmhOUGRZS2ROdjY3NHVnYUVCekZ3ZWY1MHNKcXUzNkI3SWVKRHIrZU9L?=
 =?utf-8?B?RUFXVEFrelhsckZQTk93dnE5ZG5HY2dtdHNHQ2JtUDdxcXJxWndNdWpwY25t?=
 =?utf-8?B?TXc4VTYzdmQvN2k1MDBEQk4yQjNhb2FTaFdwM1FDbVlTQy8zRFpSdUdoVVBP?=
 =?utf-8?B?dnZyTjNkVWQxYnhLWVEyOVdpcXVGcmd5ZFZMTmUwTmowSlN5UFEyS1M5UkxT?=
 =?utf-8?B?T1FzN0NuQkI5VU44TWpjN2YvajcvODZRakRzRGpiY3hqTzVDdXc3cTFINFk0?=
 =?utf-8?B?eVg1Nnh5TW5kMFgwVllQVVViTDFFajlUYmtydDVEZnZDZXJrbmpzUktMcEV2?=
 =?utf-8?B?NVo3Sm52Skt5RHV6cUNDVVhGMnd4ZHM5N2F0TVFCakEzVGVsWVJRR1UwY0hH?=
 =?utf-8?B?Qi9UZ2lDeitCejVWS3M0RXFhMktJem04V1lXQkxKdVhrMjlhNjNvK2R3RDVp?=
 =?utf-8?B?VXFPRUptZlNPU3J3clRtTjVNOVhpSmxCS2xabWJSLzZJc3dSVUxHZk82ZFVD?=
 =?utf-8?B?SFU5dmRtVlRxeVYzKzFmS05kTTYvU0NBRDAvZzRqMm9IRnQrMDd2S0ZSa0Fx?=
 =?utf-8?B?SnJXVktKVHhpUzFrUTBvRlZVMkpKb3VIOUUvSDJHWW9QK0JoNWQyV01tOE9u?=
 =?utf-8?B?Wm80ZUFOQThzTnMxeFlrWmhkVWNzT1Y5TDNPTUNtN05uOHNWcmkwVGhuTHFz?=
 =?utf-8?B?MjV3dDliUWJZbkxRYmE2WmtVSVBjOVRZWi91bHE1R1V2WkxuTWp3cGk1akxn?=
 =?utf-8?B?WmJjcUEwWHl3V0VFL0NXczU2OHhPMkVoNW9aM0trVnREQXl2b05zRk9PbXN3?=
 =?utf-8?B?cDdEVytiKzNGem9VNjdqdCt6eE8wdHJDODN0Y0dXYXJyQmRFM29pdVlwbzlP?=
 =?utf-8?B?c3pXcVNUa1krSjlIYmNRd24yWUFSM21ycFdkb1g5NG5NU01XVlRhOVdxaUFM?=
 =?utf-8?B?aVE4SVVya3BxRHR1VnovSFppUzlXcnJCdTlBMmhoRmpkSDRUV1d6ZFFYL29T?=
 =?utf-8?B?L3ZrL1JMNW14d1F2anhlMTVNUUFBR3ZUZ1llTWw3NXUrVDRYSUhHbzUxeEpG?=
 =?utf-8?B?cnYycmo3ZC9RazBDdlo2emp1WFZESEpTU1JtenM3K2Z1WlExN1JqY29zVW9h?=
 =?utf-8?B?R2JiUFpYU3JQVXZ4TTBOeVZEWTdrMWlKbEVLelI2d01rZ1RIQklEZjBZV1Ny?=
 =?utf-8?B?SGF6MDIwRVNNcmhUR0I3S3JVekRNcG1HZkl1S2c5TVJLZ1FJc3BuMmhTTjFD?=
 =?utf-8?B?TDhoY1V1RW84VjV0V0NpYUhRZ1h0ckFlUUxPWHg5ZU5xa3pTRW9TZFJNSmFY?=
 =?utf-8?B?ZWRnakduTTlpNm10bk5MOHJKWXNXL2ZxaVdFK21nNmJwUWdJWThwbThOWDRF?=
 =?utf-8?B?UG56Qnk0dkh0YjViVjQwNGhEUklrWE5pR2pGNDVTRDBnZFBZdlhRRlg4eURM?=
 =?utf-8?B?Z2ZPcVA5aCtBVGZ6U0xLTk9aaEV1QXhaZ2ZtdVpQVFovOElGTjB1MUFFa285?=
 =?utf-8?B?SzNldUJSZTlwYTRiS2pCMC94SXQ3K2g0Tnk2R25MV3o3YkJPSFFSemRlZ2tm?=
 =?utf-8?B?dWJvcUlFbEN6Nk9XZWd1YUdENENrQ2R1T1pDd1VaOXdhZ0VVb1JQTmVwSE5r?=
 =?utf-8?B?NGNXS1UyQXpFcGE3c2xnTmQzK1BNM2RNSks3VWpJTHM3NTkzRkRBdnVQS29s?=
 =?utf-8?B?TmZkTTA5VHV4ZUtkTm4wZ2Vjc20rUmlPem01MWlQZlllVHhydlpUR21PeGd0?=
 =?utf-8?B?bmlmK0RKRW5xVUtOTmNTQ0tMOUdOZG80ZW1JbGxPZG5Tb0RLb3M1TTNlUGo3?=
 =?utf-8?B?UXQ3MHRTOG9YOTRkcUdzWXFBRFM3SXRlWlBndTAzWjFLV2RLRUszRW1pSG5G?=
 =?utf-8?B?VGVHVFV0L3I0U2wrTUNDcU4yNEtVckZsZUdZdHgvT1RkVWE1dStQOWxWS3BT?=
 =?utf-8?B?UThWZTRYeWMxTzAydXJZQWxnelZqRTNZZnJOWGhwbm4xdlArT2dIWjVVaHhh?=
 =?utf-8?B?dHFMWERYMVVQNE1idVprN0QzUURXZHQxVFZ1cUFXRHZRYXY5ZnhTMGxiR3dE?=
 =?utf-8?B?eUFOL3Q0RjRKSEF2MmJ1SWFBUC9aZGdJSnF3K0hpd3JGWktoQ0NpRWpua1g5?=
 =?utf-8?B?bmlRQ0FvUlNFUWVyVTl0M0g1R1VFbFQ1Rll3WFN1cnJpajRYeG9qaFpaSkZu?=
 =?utf-8?B?SmRDWjdUTmNhU0VsNHFmekZBVWZOQXFIL3gxYTVTejVKT09obUdVZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f78d562-3453-4d00-f56a-08df044791ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:29:14.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SOFejz4dUB79C2qLcd4N3HmOY0WUJMq7iAbjSsJCLyiVsleY7QWmIXmt83U6D64WXs0E339nBg0vOP7e85TrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8445


On 27/08/2026 10:45, Thierry Reding wrote:
> On Thu, Aug 20, 2026 at 01:26:03PM +0206, John Ogness wrote:
>> On 2026-08-18, Petr Mladek <pmladek@suse.com> wrote:
>>>> [0] https://pastebin.com/FhQVSqfy
>>
>> ...
>>
>>> Almost everything works as expected except for:
>>>
>>>    1. I am not sure why "printk: console [ttyS0] disabled" is printed.
>>>       It does not make any sense to me.
>>
>> I have seen this in the past. It can happens unregister_console_locked()
>> has always printed the disabled message before actually checking if the
>> console is registered.
>>
>> IIRC it has something to do with serial8250_register_8250_port() calling
>> uart_remove_one_port(). I remember starting to look into how to fix it
>> but then was going down a rabbit hole that exceeded my scope at the
>> time.
>>
>>>    2. The WARNING would be handled with NBCON_PRIO_EMERGENCY.
>>>       I wonder if this warning happened also with "v5" of this
>>>       patchset.
>>
>> The tegra issue we had with v5 was related to irqwork being scheduled
>> when suspending. When keep_bootcon is specified, there will be no
>> irqwork scheduled during boot because legacy_direct=true.
>>
>>  From the backtrace in the posted boot log we see that the warning is
>> within tegra_pmc_enter_suspend_mode(). I am wondering if this is the
>> same issue we saw with v5... an irqwork getting scheduled when the tegra
>> is entering some suspend state.
> 
> You mentioning tegra_pmc_enter_suspend_mode() jogged a memory. We have
> to play some weird cpuidle tricks when PCI interrupts are anebled
> because of a hardware bug. That bug, as far as I know, is only Tegra20
> specific, so it doesn't explain this. In this particular case we're also
> not talking about PCI in this case, *but* I wonder if there's maybe
> other IRQ issues related to cpuidle.
> 
> It's a bit of a shot in the dark, but we could try disabling the various
> suspend modes via the PMC DT node. Notably LP2 seems to be the one
> that's causing issues on Tegra20 with PCI, so maybe changing
> nvidia,suspend-mode to something like 0 or 1 would help narrow things
> down?
By default 'nvidia,suspend-mode' is set to 1 for this board. In order,
to disable CPU idle CC6 state (CPU cluster off) I needed to remove this
property completely. Doing so does work around the problem and the
device boots.

Similarly, if I make the following change to ensure that CC6 is
disabled for Tegra20 and Tegra30 this also works for both Tegra20 and
Tegra30 ...

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index aca907a62bb5..d592e1f37f00 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -374,9 +374,11 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
         case TEGRA20:
                 /* Tegra20 isn't capable to power-off individual CPU cores */
                 tegra_cpuidle_disable_state(TEGRA_C7);
+               tegra_cpuidle_disable_state(TEGRA_CC6);
                 break;
  
         case TEGRA30:
+               tegra_cpuidle_disable_state(TEGRA_CC6);
                 break;
  
         case TEGRA114:

Jon

-- 
nvpublic

