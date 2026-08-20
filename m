Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F33399CED;
	Thu, 20 Aug 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269066; cv=fail; b=Y3xmUUx464ND5veMIPRWczylAuszAUZ+6w+8FOF9L6LNXpxMaMWjNXJo9qAoTmyc+DP7b3vlES1jgBJVy+4hdcH9llQs46kKIRretgDfedxravlRMjs6RGkQJY5MXYkJ9V+wCYgQXtFF6/oP86IaMNRfwtIwJc1r2hRoEBtV4Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269066; c=relaxed/simple;
	bh=jxXO7eSKJAljshIDAH+5Fcz5rI0PYusZPmhispTqfoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IHQyhQUn53pHfumN3n1/j5mGp6rH6Hmz8Q52UyQPkjLBxFJ0OvF73nq90P/kVWvy0m7IC+yvoJgLJ67t1HzjufTPdG5oZSi9a5v2G1Z4RpJ4qLUNvPfvzKpXGGWhNK9YtgcJ68ID2cG0JwWdhnRBZ4F54w4SmfsBeu5gUUDhCQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnXNhcSS; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnXNhcSS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHygXD0yM5BMAM1jcoF4JP4qzORwhpEFIJtKadcITCajx819Jy+Oww39Yq94+AFq3/S/hjjKlfoCOdVKTdzi5ZhYhc4N3drirmJjx3Ffu+xmmYKdrxxHMYBupMezSPks/q8bfQZ7zxlaDGQtnwndMVn/JvNT5wUNQgD4XlSU0kQ+z1GRt+XC2g0L2K76EUj6uIHQ4A3uGyBtJDS6tf+55LY0BZ1Nvbhi4IwOd9QBvA7N1S3vi9dQyFRyYN+ssY/DImt9oLJhz0vCi4GoMsYCfVLb+bTXvtyhM2F4DUpkheqra1bLdnC6BCVGG/r+ZpYgnAMgiTDxUuhn9fhMZj+zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1fnctCTWIrukKsVcZdPSPCXBhDV+8zMYFRJW4ApJDo=;
 b=gRMS1JHsAwRna/SR12GaWn1PQyUZ+DghCjTvsUds1S1HKOlbRloc8gAPMmjPAzbcxAWhBFWJtscunXZn2N+iUjT6RIp9CViuhuNYoSo9+OXRTg3X786W3WF08xzS9r0ElUFoqgWklCETmJBk1OiB+PnDgI5EYZLX3Uif4HU96Az1lN0iJpAHWLGDapQYLQ6eywHn6BWX//fQNkXpDClke7nhCAKZSjBW5G0abOzMxOEh4dc9JY2i6y4JHeS5ltSFzpXQelkboJ41WVNyVEut26kh3//9jGWkB1lxIw4iGeBUScPCkJphbACMvDrjK9NiYROoO6jWy6aRXeAZx719dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1fnctCTWIrukKsVcZdPSPCXBhDV+8zMYFRJW4ApJDo=;
 b=AnXNhcSSzKJqqByFDI60bkD+iFXIw9+MS/xoWLLbZDUCj4bRdxS5UGoYFMsypMPrxMt64IsiU6O1h39PoeLgA3Xp+k0ujeXPDUizJ5EiS1/xeB2IdDFrIHMQk7ig82edid7PhMCXrvZwiOSKPvBuyxC3Z36/JO0aAqE+/yLtWm1Ksue/MB71Ah8Bd4SpglSfyYqbd50N9ux8ZUgEO+Xig4WiUajwAh38vVy2F4929yIXlZlgLLMBp+Cjroi35B7wBwIvfzDFHGl36uD0MqE/0MWlyU7DAPG/4fio64xM1mjzVQDvbsfYWSiyAePnQHfNilJkJd8avSwtEQeGLxS7QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 20 Aug
 2026 23:37:32 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:37:32 +0000
Message-ID: <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
Date: Fri, 21 Aug 2026 00:37:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <877bll9d91.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P309CA0012.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:28f::19) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 285d153d-7b89-4fb2-8e2f-08deff14010d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	mUrW0QbPfQkwpkh8C7Hm3vhYhqlgk8+H1bYTiJzpr9fGGr1Gnomr+mh9MyAqEjXMx6ab+sIPtfSQo3mx+5UlkC1RpyTSru3VoK194EH/KK8AcXvqPa+Ap/KwfxPowdWXy/UkivzHwZKzc2XdNber8QnzRKzG9MKgflTRnUSbdw8YppHtYX4bVoBzcG8/6aSPGXBh3mQBS1ZTwEm7GNM73i2lmX3GkNuxsjUNeB55bnCiiUFpX6eHK22gBW0E+unOcs1i5nXtCdWXpyeLKnTOqkC2Dx4DWn8encxo8DSyjv5ltCqpTSHJAQbAlcLhvZVq/hOfsMbH3d5qd58r19qyzIR0OVp2zBGNUfTXtIZOfaSsglEF1gR9j43y2yoEDxzCiIJHGaLquj9Un06wcvPs2ZN88e3MuaMuc6P/4yeVXCMimOH0BL3b9Vts07/eD6RGOVpHYWcHpqif0s9z4rVkhKP6wzE51U5vHgB5R3ZKT00gzg6GO81B+EpjDh1Pg8JB8sLMcuSUknRShYJV/qFxK4IDlWNk9MdxMNep0rtCBflgsoF02ORT+jesV37RpL2N5cYF/x+uP5S2C51MJG3Y85ii04EJmPRddHRpDZcSVzEkCXnYfgr+0tSG4MgSN0kJ5hPca7Y/4djZCTRr2P/zmlXubVC4uZNVYsUD2gnQj2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTV5QzdJNGx2TEMzNDQxQjFiZ0NrVlFmMCtnajU3MGg4RWEvcittRjBMdmFl?=
 =?utf-8?B?enBCSFkrQU9UcUhZbVYwZVM1Wm5hTkhROUJidUtucUtuaDhVREZpMXlVR3o1?=
 =?utf-8?B?M3ZvQ3VXVEJJaWM0OFcvMlpsTFZubWNJeWJWeUhmOUlaWXoyZVpQTzAwMjh4?=
 =?utf-8?B?WEs4OUxRa0ZzN2ZzMHc0RWVGN3FjUEZXS3BGWUZGdE5Hd1pHU3BFNzluakdy?=
 =?utf-8?B?cTJ3b1FVZWRyRWQvUlBGaWRQZ0Z3bVVZZFF5Q1g4YXBkWkg1WktLeld2clFN?=
 =?utf-8?B?SWU3cTJWTXRtL1B5d3NDdXNpVy9FOFNHV3BwNVhMemJvT1dQcng1R2t6ditR?=
 =?utf-8?B?REJQcFBrR1VzN2NpUlVxYm12NHFQSVlSQkhnWi9hSDlqNlIrUCtLUGZoWmNw?=
 =?utf-8?B?YlFOZ3NNY2prUHdRWTFVaG9xbjYyTkJIU05udWZsR1NyQjFaeUkrTjJoK3h1?=
 =?utf-8?B?S3cwYkVkdzRNMGpwNjZmejYxRmJHVVRITnk4NEdmUkJST0lYV2tmKzhUSXph?=
 =?utf-8?B?WjgyL1NQWjRsSGNuSXBTWk4ra3l0Wkw1em84dGFkRWZOUjlkK1BLazdOc3Zn?=
 =?utf-8?B?VEplSGxsTmNMYTlEQXJ5S1grNjdSYnpORVdwTmpXbzlCMzVPbEpCS252Sk95?=
 =?utf-8?B?SDJuY3BHL0NIN3ZESTc4cjhIbi9LWGx1aTVUbFdRM3BPRXgyRjArZjRtZXBS?=
 =?utf-8?B?Qy8xM1dxUGkvdDJvcWRPQ1k2ZzZrSzN5ZmtGQTZWWEJHbzdKMjNtaWFWdnMz?=
 =?utf-8?B?WS9raUJjTlAwVlhIcnY0RGw1RVF3aWlZU0RQUEFFbVVmbmMvbmtTM3l4L1pY?=
 =?utf-8?B?RzBXQisvZVpaS1hxclJWWnU3U2NVcyt4UDl4RFlLWVdxUE9Jam9UYkIxZllY?=
 =?utf-8?B?WGtvNkRFNmhzeDhiM05uVm9heG45YnlYeXFOYmo4OHErTUo2R0hZVVhRWFlW?=
 =?utf-8?B?aStYZDIzWmZWbjNMMXpaOG5SUnBmb0dYQ21xck1HSmVsekZ2akh1dUlST0RB?=
 =?utf-8?B?Mjg1NHFiQ2N3WTMyVVkwRWsxbjBleG1WMjR4b0hLRThEbFc0Mm4zUW9tTjZt?=
 =?utf-8?B?OGhRRGl3VVN2b0VPVm9YZ3B2N1dxZUJVWGFSWUJ5MXVISnJJKzd4TE1vTlRH?=
 =?utf-8?B?VnNJejJRVnhZYk9SdEh5RVF4R0ZNdzRmbDNZSWRhS2tpTE5vQ0Rjbi9kWTdM?=
 =?utf-8?B?TEdQQisxUUdLRmkvbzBxTmZyalIzejdLZjdqWDc3ZmEwQm1nVEJEZFlVK043?=
 =?utf-8?B?bWphT05vM1M3bVpqNjNJTWNyTXdnWmZrelFxc25palh3aFptUkFBSkxkaHlu?=
 =?utf-8?B?ZUp2R3lrVENBYllqS2c1Y3RUd1hUaExBV29qL1FaVy9lUkhxNU03QTA4UlU4?=
 =?utf-8?B?T1pqdmFjdFJMbDgwN2xOanNGUHgyYWxUMkl4UC9ZZmRtL1FHQVVTN1JUQnVD?=
 =?utf-8?B?QS91UXNDZmJXQTNFbVJRcDc3YmtxU1VEVmFhb3JocUFsa3dQcnV4WnRsVHRi?=
 =?utf-8?B?Z3hWRm5HV0lpbzdZRkgzVjhEaFNzOXlFNld0b2hWY0xoZlBWWVA0SlFZRUhR?=
 =?utf-8?B?ZUx1OGh5WTNJMkVKYkROYUxNUjRHNGRwc1dwSjc1ZVBCZnY1MHhaeldEUTR6?=
 =?utf-8?B?YmtLRk9ubzY3bmtRZ0lGTGNuL3ZiY1ZvT3VscnBBb3R1R1JpM1lwTVg2OFpL?=
 =?utf-8?B?bE54bUlJVzBzOUsyUURaNjFjZ0xMWGc4dDNNQ1RmQ2h0NFdOMG5sdjFDdi9t?=
 =?utf-8?B?YTBuMEp1R3JNZWJ0cVRBaGwzeXJEZ1lFOTZQdUwvSGtybG9GcnBIeGpOaWUz?=
 =?utf-8?B?SE5rd09jNDFVbllOK1o4Y0tTOTlGdURnNFZja1B0bEgvR3NLYWppYWI1eFFt?=
 =?utf-8?B?alZNM283aTZVUFBzTERFTGxwTnZHVHJRcGl5dk5TNWkva2VIaEg4eUorUGdF?=
 =?utf-8?B?a1BWN1ppcTUwZkpzekFsNjVIYURhdVoyM3ZKUVlQd1d0VlpOTDFVUXd4WU5o?=
 =?utf-8?B?SlZyVkNDb3FCR1dvVE1uM1Nlbjl4UUlwUDVsY0NBUzh6NEtYZHppK2h4QWRD?=
 =?utf-8?B?aHVFRG16N2E0NGR1TmNnalhHM1FGUktWdkh2cnFuVGdML2psUWRGTzdqaWhl?=
 =?utf-8?B?Y1VQMnI5WE1VcXFNb3dhcFJ3SkVCc1JMZk5WdkROR3FiUjd0Q0h4U05TTmds?=
 =?utf-8?B?dVVuclJIM2s5bkI4a05BVG82S3R3MW5nWWNEWkFlWDVVZGUrY1BWK3J3cnVD?=
 =?utf-8?B?azZTU1pQdkg0c016QkYxREM2anMzRytHa2k5RmZJb1c4eW84Y1piM2JUNHZU?=
 =?utf-8?B?S1BtQm5wS29LMklUb0xVRDVNbXpCa29neWVYNGVtT3BVeFBQb05md1hQL0tu?=
 =?utf-8?Q?z2OXfXecn96GIa1iaenH+GaoIfrTk4+bcZwFfnG1tzcwK?=
X-MS-Exchange-AntiSpam-MessageData-1: 0lBt3IUschNymw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285d153d-7b89-4fb2-8e2f-08deff14010d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:37:32.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZKe7Au1RtFOyUvlJtOWP7t0OKmDxWgHMS3AfdhGd5zrbb/0KoKhyvWoWBinPKcKejYIbPiJaK5XUM67mLLjkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

Hi John,

On 20/08/2026 13:40, John Ogness wrote:
> Hi Jon,
> 
> On 2026-08-20, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> 1. I wonder if adding a WARN() with v5 of this patchset
>>>      would make v5 fail as well.
>>
>> Thanks for the analysis. I don't think that WARN occurred back in V5
>> because this is something I believe is fairly recent and we need to fix.
>> Anyway, for testing, I simply removed the warning to see if this has an
>> impact and it does. So you are right, this appears to be the cause of
>> the issue.
> 
> Instead of the WARN, could you insert a pr_err() call? I would like to
> remove the EMERGENCY printing from the picture if we can. If it hangs
> due to NORMAL console printing from that suspend function, I expect it
> is irqwork related.
I replaced the WARN with a pr_err() and I see the same issue.

Thanks
Jon

-- 
nvpublic

