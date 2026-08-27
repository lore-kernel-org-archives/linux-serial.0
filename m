Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF54456290;
	Thu, 27 Aug 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842202; cv=fail; b=FG1wa5zQi/HM0TrnTR7BQaRiyGjg0jwD4jB3iJ9bb+cNeQo+OCBOY8gAHhsckZ2ZfMrLvfJRHF7ZxD25JvhtTZfFxI6y/ulERM1WKTngIlvZXe2slV5RP3uzBuQAGEJ4bYPa1lgj2HCQvEr6Kok6rIZQF9lefEgsOVkTV8CwnWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842202; c=relaxed/simple;
	bh=zbIDv7dkoAdk6k4Qg9Q+Vwm7oeSxmmwxWMVBDCSJ4Tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uN000tMVM6WYxz6R+8SM9kMKQHOl/dN6ZJt53Rnx0/9QqjvL4baG+j9mcAvctGHQDmwGyBabKPaU0z0iAmys/iA+UqbqwJccVRtKsLTbJOi7MtVx3GHR7TGSyjNPdCO35h7R0A04dk4c4+7qyxjbhz9VQuuv8r2FnVz87Df9rh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lTJw1v0Y; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lTJw1v0Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2pLOgox00hCG7hDPoypyoAYLY624XItMLtqClVy+FoNNJW/MA6OmUcoquUnPv0Ep5xVjmR7PfI1hEDjecEJh2kkljFM1f/Wy9x883clLRwgwxvycDcfnivaIV3c/MHPPdtxRSbNlQ5YAI/SeonV+2uogdAaklmMQNcHzapjKICusCg2gmdpKiyf6Ad1tMKRe4wZQwuijETT+3E2PNrgyYUZWG4ok2w/zRa3YFSCpDdrydi7nWmsp8q1UevigxuxT1BmqWEaD+W668odrdAKlzRdPKLCwcz25Qpd0WaLDLUzzBFlHnzIwpfbr+sopfcHEIjBgAcfGZtzh0Bd8Xje8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpP/nQiqVH2w8AKBji35FqMsmqeZt7mRDLZ+n7pn33A=;
 b=ZVHjhVQHa6nsV8nBsNl3Ma585+J7pv4pE7yIwfEhfTEwzOKgMJDNo94Q2soSTA7GrzR01BA7Y3oZAtfYzAiOKL9m2rIj1/hoVBAC3Zo/4lltyx9Y5OaZd0Yt+vAg+YCx3mvyjROMawwnl9ph8E5URujMlrleI0+x99sk03FcwBICfgq4f3RbS8nqd7WU0EJXTfAgrXvMJUBcj9w4Yt93Mpd4v2VN2h14DkgM6L1Xg9CJ9U5SuS49amrcgve1T4s0aZOf2YI5b3rz0P+j4bdcGvlFzJVds/aii9h9aEjZ8t9VniqI5LGtKBxpg5utROO0U98LKmTcqAggWhWn75LwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpP/nQiqVH2w8AKBji35FqMsmqeZt7mRDLZ+n7pn33A=;
 b=lTJw1v0YzExpe2O+fYasU9ABckjlzC7Ree+YWxbZGs+z9wNI/uycCl4DLNOdE2AO/DNb+YvYWy2QL2nD8i+EaoC+ROXwZ2/AsYFGird2Vb8fABl3tsJD9+OMrd7HUNxJ5mn80qy6icFGSDjxpfUi+GCPOu1pTKishvL4gnVNz6OE/nvKswQh7LW4zDHB24qOfAohguCXz+h1WLptygRsQiqQ0kadbBLCjLx5pRtjOb6V6JaCyZTekQhVf1kDMMtsHLNQaZC8qEXOw1q5odzGvEe7KAPUjl7unm61PXxqbTt4Gh81VKAXfNH7abZvXVqqd5++LFsRNQXdghU2MAhrzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:49:44 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 14:49:44 +0000
Message-ID: <95ab37fe-2e21-4b6e-b8ef-39bccd2e7d75@nvidia.com>
Date: Thu, 27 Aug 2026 15:49:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: John Ogness <john.ogness@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Marco Felsch
 <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
 <877bll9d91.fsf@jogness.linutronix.de>
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
 <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
 <87pkz56epl.fsf@jogness.linutronix.de> <ao6XVfmvV6HjBiEv@pathway.suse.cz>
 <20260826075925.WTEVoXWi@linutronix.de>
 <875x0vpvma.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <875x0vpvma.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0095.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::6)
 To DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7cbedd-86be-4855-ba8a-08df044a6eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Hg4iddMJLdJrs/iwuwX2FOun9DNnZpgACYVskV7cjKA8HFgwCnwX1oRa6WV/Fw/iu/DNlCFnuJ2BVP34IqAnJ9q6CZLMaoNpwrI8MM1epMGC+mcvNdNE/KZAb61uz8yHQsZPv39LYRSz71LHCyMznwJ74hfrE+dCM0STa1lnIuEZkqGUbVnB+mJZPVMXKEqrLaKB7fwb6lwNMa3NjW4frC8IC0tji+mxVqbv/JylAgAtYs1mYmAZFhHjQWC913A7S3Yh8R6Z3rMkD8JIMe/Jpb960zESHDnVcv9vLJgxipSOk7YhfJKDQ4kalEwN9O+EOrOhfhdmn8dmiZP9SAUTlRLjH82W3h00CcVHc5ekmmYOVKJgg3pe87iI/m9Afc7JQ7hy6gXMM6KvjWgAb9V/tjGleG/c3wbn0JgIK1jwS6bNcW8h0PuaCZOveKu1S/p4k38T3bX92MbwYlsv+eeFGT3I2DRU7XyVAhhD4z3bU2r2EiM7BWnwH5C3H4R4h6gWUx5/EzOzgfenFzfRXoms6rJAWwV6qyBwpPhjURnS8+G6ERv7YrHEQkP44iC4MC8scWUV9+q9kaBFqYW0modqxM7S2lnHRk/ymcdqU56zQCbpKaUk6kGoRGKbSdOHCZRTyDe2ZYJeNcv8BLhnnVDa0Oj6xNGfwLoeFjbZu7qgkFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZUM1VFeVU5d05yV1dNNUgxUjhlektLVTZvYlU3RlduQjNWdXJKUnZjaTUv?=
 =?utf-8?B?SFJDUnBva2VieXJLbEhrZkROQzlKb2YzTWxLd3FISGlwTnNpczFmdzA4eStl?=
 =?utf-8?B?Mmw4QkhCUEFrTWRVaDYyL0k3SHB2WmNUZHJ3SkFvNVA4b3dTdnR5YzZsa2lF?=
 =?utf-8?B?R2l2ZnYwZWEraFVnY0l6aC9NZ2hJUmxOekdRUVp5UXIxckU5WVBIMEZLZUJG?=
 =?utf-8?B?WU9Jd3V6emdxczk3bGxFNGlUVG5pQ3I1SXYvS2c0RW42MC9XUmh1Vm9FQVVx?=
 =?utf-8?B?amQyK2lldS9yNmRVZWVPMkRPZTNGQTNxOWQ0RThFYlJxa3BoNC9jZmxBbDVJ?=
 =?utf-8?B?cEhPUW5kYjhiQjhLM1g5dGFldjd1WnFzaFl1MVRueHRnWWEvWlhISE4zUjJM?=
 =?utf-8?B?KzFkVm9SVzkwYXBaaGtNblFUcHk3YkNzVG5RNVdUbjdQS1VpVmo0cFlSbmdl?=
 =?utf-8?B?NCtHR3N4UVVDVGpBRWZicEovbElENnJDME5naW5rMWN0UXllM1lOVk1SOFcx?=
 =?utf-8?B?UUZ4aDVHRkw3KzhGbStITkRhb2tpa3ByVnZCdnQ2SVVxVVFLLzJVZEVUTFlF?=
 =?utf-8?B?NmNlQnlXT1k0TDJWWG8rK3dGa3lIN0tPR3pKb1J2SStBZHNJNFViSjlMMTRi?=
 =?utf-8?B?ZUZjRnhPN1NsL3hoN3ozSVpTNUU2VjBvL0QvZFpNM3lnL244RklNb3JYUXo0?=
 =?utf-8?B?U3hmWEErNmZZNkljK1c0VVpMcDhkV3pacWhBTWFsU25PeFpvVzdsWklsRmRQ?=
 =?utf-8?B?SXJEZkpQczJVZXFiRnBPUjFUaTYzVVo5ZG95Tm5zbnYyMlFQTTdxS3RsZ0E4?=
 =?utf-8?B?ZnhTeVlBT1lVdWlKMEVuYStDOUQ2QWUwRC9ZM1dFRzFlYUx5YWduVk9TNUtG?=
 =?utf-8?B?aS9ORituMUhiSXdQcjY2d2paK1BIcU5PMnlWYkVXQjR0czRkamU2WFBGc2po?=
 =?utf-8?B?dW1EV01XL3ZhZHc1TW4rWnQ5aWUzUlUyTzIrMnJOY0hRbUh3MmJOV0l6S2dl?=
 =?utf-8?B?N2Eza0F1SHNOMkVLL0x2V0tqOHhHS0xxODBtOE1kc0hXZG84alg3OXhhK0J1?=
 =?utf-8?B?T1BTbFNpcnpkcnJnR21YS2YvZ2FWTXprMkJXQTFjZGNYN3NDdE1PQjhxakM2?=
 =?utf-8?B?WXQyeUxWdjlhMjJ0RVFsMHpjemxlM0dUYWc0SWJUZUF1ZlBGNEo0NFJIVVU4?=
 =?utf-8?B?MTB2TmN3S3dobGUyYjFjZllBRDNrcWhITUJjc2NnaHFXU3FUdnhKTmhYNndo?=
 =?utf-8?B?NEVOL2F1WCtOM21mYmhCa2txMERCNHEvYy83MmtDRUV5VHJleENnQjBVU2hi?=
 =?utf-8?B?cTVTbmIyODFrY2p4N3pkTW5XazZZUVpTNFBxMEt5MlVraFE0LzBJZFV1U25y?=
 =?utf-8?B?YTZrNHlScUxZNk5rZ3NjVTJLM29NQmpmdENidUpPSlMxakRrTjlBdFRVK1lJ?=
 =?utf-8?B?M3djaXhveWdUYXlwZlUrejFpYVRUdjBwanIrVW5uRGJSL3BZVnpwMFJFWits?=
 =?utf-8?B?aDRuTm0zaDkwUE9vMGowZDRnTzBzYVRQaVY0bWtRWjFaYjFGWWwvc2J5cVlu?=
 =?utf-8?B?Szk2eSt6ZWprTlRiUU11azFqcmtXL0dPMjUrSFMzeEpHVDZzNDlvNENOcStz?=
 =?utf-8?B?TUtXcElXbWViKzFtM0tFK25XMHBhTkozRDVzNWtxSG5lUWg2Z1BjY3Q3RGJj?=
 =?utf-8?B?ZWV3ZisydzV5OFBFUUhaYXJiS3JibWRQeVp4cUNVd2ZlU0FsYTd0V21CVGNZ?=
 =?utf-8?B?MElxUFg3enZ6NkZ6MFdpU1hDZkZDeWsrT3NBRmZNcEhOQWY4aG9KZkFaeDdx?=
 =?utf-8?B?a2NOZytpR1Fib1g1clJvNHIvZGxFK2hrZzZqQ1U4aGMzQXAwMkhNb0lTcFR1?=
 =?utf-8?B?NGovVDBmZENRbSt0anI0WkNrdURzL2FEek9FbGV4WGpyZlU3N0kyVllxSGV3?=
 =?utf-8?B?MFhHenBkc2VtN2ZHT1I0aEdhaG4vU0lOelh6UXROakkrTXBYS0dCcXRVRGtk?=
 =?utf-8?B?citRQ0hHbUxPVE1lSXpvZC84R0RoRnhzRTd5NDhJVXZORDlOaDczY0UvUnVj?=
 =?utf-8?B?L0FpMkdUSHdwMVdqL21QVldvNVNHVDdzZUR0ZStPMDJYWUJkN1pXM1hUTFpV?=
 =?utf-8?B?ZmxGSGVSTXplQWozekFrTnBkTmh6UlVldktjSW51SnBQTFBWZWhxVkVHNmcw?=
 =?utf-8?B?ZVEyV0c4djBSWXNjWDN3YS9JU0I5QSt4dnIwdEhId0FaV3pITXd6Q0R2MVpu?=
 =?utf-8?B?TFYyNTZRUklKR1lncUFTcG9CNzFLRlJMTzk4MnI4SW41ejFobEwvL292V2c4?=
 =?utf-8?B?czNXNXpWOXlpM25hZ1B0Y2hqNnJHOGpIc3cwVlJxRnQ1MWNBRm5Idz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7cbedd-86be-4855-ba8a-08df044a6eb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:49:44.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u/IrkuUoL6aPSrQgv0kbhhFKBx32ZFKjWHju/cml86n04bdze/AcBJoCOOf5nMtiq/2J2Lj9NMJfHaB7coANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646

Hi John,

On 27/08/2026 13:59, John Ogness wrote:
> Hi Jon,
> 
> On 2026-08-26, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> If that irq_work is the problem that making nbcon_irq_work LAZY should
>> delay it, masking the problem.
> 
> Making nbcon_irq_work LAZY should work around this problem. And,
> actually, it should be fine to make nbcon_irq_work LAZY in general since
> it is only related to non-emergency messages, which are delayed anyway.
> 
> Jon, could you run your tests with only the following patch applied? If
> this works for you, I will submit an official version of the patch.
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index a5921a84a80ed..ad79e30afd647 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1782,7 +1782,7 @@ bool nbcon_alloc(struct console *con)
>   	}
>   
>   	rcuwait_init(&con->rcuwait);
> -	init_irq_work(&con->irq_work, nbcon_irq_work);
> +	con->irq_work = IRQ_WORK_INIT_LAZY(nbcon_irq_work);
>   	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_prev_seq), -1UL);
>   	nbcon_state_set(con, &state);
>   

I gave this a quick try on Tegra20 and Tegra30 and I can confirm that
this does work.

Thanks!
Jon

-- 
nvpublic

