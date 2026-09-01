Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B0478868;
	Tue,  1 Sep 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254458; cv=fail; b=pGhHyZCIi9FhGqG0PJ/pH9qXlAQS5Ov219KYIW+BWcmwGrvu/PLuz7i8NIXe4vCVEZ5d0jTvak0gfRveAHN5wZ8zxKnotZEL4MEr+G8nb+tOCeKMb6LniUVnbyvLJsGZOOVyOfW0Fe0M9j/0DuMg/7W0p6mU5fPmttCNXVOjXGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254458; c=relaxed/simple;
	bh=LzPgiytSCqdpGbO6sH89lBBNhixjyCYKTtA8bljR8lM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M//JHOBBwcpzbOj7AhncbGDnDS1TTrdGbpL6vm3LgNjA1EyA4vST9w3QXtJRRhjtaXWMz2FIwyZau6DhHainfKy5LOlLcZyS6YZess7KMhjKt2NLt8pWlofSIoGFxqaGwaPaYBjoQtugntKzlIiM2JIWWrJMnVfrSBhIWe/BqKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1oOHT0h; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1oOHT0h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5sx0HAn/Bhj2UsGS9Qc3SFwgdvssrRInLduIvBK6Qn/YHZa4AkBbqzTGPLm/IC7YUTGhIwqXp36aLMmK6s4HN329zCMAMB7gVvEtPKJinPnlfwJFGMWokcU9/qWfDtt7BlprvxsecnsangOW1o6j96LAO0UrpHmF6R2JQTZITzvKvs2mu613SR7C80mlBvKYXlSse4pEQrW+91NWWJrBMhaC7FV9K3pYD6YfDHw4AXnUgfAsD2XnIqVFqjNmQRTF0Bg3I1rRcaWY2F++M744q8sfb73Lj+XrTJ52gFuzhgv663wm9cD6BDiUaX+7VCKULecqQi7WFAUWTXaLJYlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91Z9JLh9ZmVL+laxOzCzciwmnvmor0TeJ8f4VpNaIJc=;
 b=zEEWkcn+aJ/t/f6UnEPe6WoU3ory5aEdjZUTMg1+kQ268JWM39uiUSvbtumNz4h4IDIREEtWwwfWdgYqqVAY+uUKjA73ht6uiihU+sUHFUvhbw5bT35swGpVGdPFUVaruHX4dOs/1IQxnzJhbDDtpL3Jkd6DcsVQCxEUW9eFFdPGlqIJCNx7yTo/XCPXknsdCnaTXPu2OOxpD84PB9/Op09CvUrEZ3adTWmAaD516h5KoRLhiAtXbOwmO59O7Q2msZjswTOVqYd4QUG4kacM9eZNwV7TISlbgwVaGP4Wh01iy129A8z8OrWfAJE4MbuEKF6jG1ifI77rgr+wXM9YGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Z9JLh9ZmVL+laxOzCzciwmnvmor0TeJ8f4VpNaIJc=;
 b=o1oOHT0hGlt/uA+tQ5p1eJ894Wuwbk61Gd8bLamyP9/vUkoOAuH3cm4yqIA6wDSO+8OqciRfMQfWySFu+F+MvekrUrqBmz7u/zJeveS5GiWKq/Kd83SHpuypQdXls5HtZRPhUVuLzDtgOQR8EBBBBmh/DK4auYKrclXTUynf39BVOUcJjIFjZuaP89FV0TGN/oF13q4a87cQWoajM4iWI2ObFN0etH/cbP1gdppRrFGNiugTFoHR/KbR/GzaCR9jrXVSQKMHADDy4UvyepMabHhyKWT0kgjToHFAp3bibvr4vglHBc4MT9w1HMOFCnRkN1p61HMIlgL6TlDi1typGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 09:20:53 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 09:20:52 +0000
Message-ID: <a6e33c46-160d-49a5-b711-56b4f47b9326@nvidia.com>
Date: Tue, 1 Sep 2026 10:20:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
 <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>
 <20260831082028.cCEc7BXU@linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260831082028.cCEc7BXU@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00023955.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::352) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc32e77-bafa-4b5e-8182-08df080a51c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|10067099003|11063799006|56012099006|10086099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WJ7sHFRaf5oj9/mGol+luJX4ShzHkLPCAgy7VdohPesm/Gp98IRAtlWnRYgifusayY7J5HLrStknMvrLBQ242B3rTkj963lybTtfaQ83FxtX6nkJSa/j0ANDDSx/6eBgn4Q/QI5opaMe3Owz2MrCq8+zUvxoVMynmzFt2luigUUjmGnLEOS4PasmXzeBDOCPzZwY5grSLwjxEqo0n9uE1cbCDPIOQ1qfhvF14r+i7F2qN08x6bd95xK2syMDYwxyJjyMeoIgADCL9Ei4NPbFaztscjW71XgoX02t22Z15wy0T1JzSvAaQhNOgZhRD3aBxlOieME1Y+AYcKhS6XXrq5FTUTh+tyTDEDyjg17GyB9kAXj4/WVviQEak3AtkIQZ+abnDPvGejqDLVTVNsZr2QDMbE9tMapaq8SQjG3XO5wQI2cnwqWYetMPiYM5ZqdoWPX5z9VmA4tEKKu6aqgUY1pyslYwdTcwUVWa8cmlZECpDBUH9V3MiULO4oLPn4xbpoCKVHU+vyYhNl5BF1Y77o4wvhwwpibFt8WkU6UqtQuqobOMX5I5vASqgrAb6KEF6TCjuwYMIP28ImrGKM2TZoFz/vs/lkxHwsNDcz+4+KlwS+mffUQsbDBuLCdQpYQLwLgm1NN2YMlpaeZdZcVjqtxUucf960Gs3mFdQ+gYzMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(10086099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2crTS9WT0ZPbkM0YitVa1hCdUdqeU56YWkxcDdlY0YrYVhrYVAvQ05Ea1kv?=
 =?utf-8?B?R3RJU1lERUs2OEJ4QTJFSDBCSzVSWGR3dklULzVLSEZrR1dGdzdrSGFweTVu?=
 =?utf-8?B?NmcvWHI1Z0FBMnlJMVlwaVFmdFM2OWN0VjJKN1g0ME5uVXhTNUk0bFlPR0I1?=
 =?utf-8?B?SmI4ODlsMmNYb1ozdEJFT1M1U00ybXlRYmcvRjlKOW53T1phL1B5SDlWUnFt?=
 =?utf-8?B?MEdoZlZRR3pNUkV6a0NDaE50YysyM2c0dkFyS0QrYzNJL2MyUFNidzNSQTl6?=
 =?utf-8?B?aEFPcTdCQkhGdTRQbzVzTDRpZTU5czRZZTZ3Y0cvcHU3cWU2Um9QRzhqMVZK?=
 =?utf-8?B?MitzeGxxZXU3c2VuNWRYSWl2QUwrdWdIOWUyUkE4RWd1bk5xL0VsaVViN0pB?=
 =?utf-8?B?WEhyYUUyUVoydWdVZkNkNUFyQ2hXejAvOE90NHZOZGcwMk1pTlA4YXFRbDl4?=
 =?utf-8?B?RHlMUUMrTzhrZi9RbGM5Q2o2YjFIN1AvWTc0TFZKOG5xdUEzYUtpYjRDTSty?=
 =?utf-8?B?N0VXZ3ZvUnJ5Z0hObVNmU0x3dmN1azNnMndLckZobURIbm9EUndlYzV3dGZU?=
 =?utf-8?B?QzhDQzljOTUzWDBXSlNHOThua2hQcUpWRnhhZ24vOHZjZFJOT0JXZlM4M2Rz?=
 =?utf-8?B?RjFQODljc3I2RHMyY1V2eElKVDFTVWIwR0U3SURiYkV3ZWJUMWNYYmU0L2VS?=
 =?utf-8?B?d0tSSUduNTlXd01scms0bERYaVFDQ0hUSlo5Q3VzanNtM0ZyWWRaS2I2eUFZ?=
 =?utf-8?B?YjRMemZJMVpXektnMy8wa2pibWQvZ2JELy90bUgwRGkvc1YxdnBZOGRXbkpL?=
 =?utf-8?B?S0o1dXhGVm5PTFpJQXAraG1hZ2FodjdGZFFUdjFZa2hmanYwVTA0N3JXZ2h5?=
 =?utf-8?B?cGNabHJUSHhMNkdUUkVRSE1BQklEbS96dU1qd3BIeDUwOWpxTUN6WURPaENJ?=
 =?utf-8?B?b3NVZnJpMmp1WnM2Qm9ZckxFUFBydlFyWlR4dm1GQ0h2RFM5aWV1a2ZpTDZy?=
 =?utf-8?B?cnhoemNHQzZpc1gyRUU4RlFFakluNXhkMmE1d2s0RXJORnpOVnowVlFQZ0VP?=
 =?utf-8?B?TkxicE9PY1VMVVBKQzgyTnlmazdnTmZXVjhPR1lWajlhOTVOdmJ6NnlsZGNH?=
 =?utf-8?B?WWxoTlhnSzY4ZnQza042RU1OV1hUakZHSGxNNC9qa0FsSS8wUXdHc1ZoaEk4?=
 =?utf-8?B?b29Kbkd2TWRsMngvMTNNdkVDQXkrWTZmMWJDZ24rQlFoWmFEZ0xCOE5TQ2ZJ?=
 =?utf-8?B?OTFoWGVzZUdsNGVSVnJ2S1h4dzY4QXVBVEJYSTBPR1NDeVBkR0ZWS1VkNmZW?=
 =?utf-8?B?SnJuR2pnb08rWTNyMWY4VzF3bm5aVGhYbzZLVGpsamwxZXA1MWEwS0QrcUly?=
 =?utf-8?B?Mjg0ZWtQdVI4OVNJb3Z5QlBaR2lkNXIzVkphQUMwd3Y2WUtaWWhvMjIvb0M1?=
 =?utf-8?B?SlkzbDhQUGJqV0d3Q0ZSbFN1RlJEWDVOOVpnY2phUjdDYVJnNEVvSGVMWEcx?=
 =?utf-8?B?SmlhazdXMDlvUnBGanZvSndxUExqT1N3OVQ5bWhkNVVYTmlQUnpmNjkrUU53?=
 =?utf-8?B?YWU3cHpJa1FyRmkvcHRTWjZJODRDSlNjcWxERElvbUhDSFAya2k1cVVQRURy?=
 =?utf-8?B?bU5QbUJ2M1dSWTlkdUFoeHk4VlR1QzF0OHVCTmhaN1NJbHYwelc0QU8yek1E?=
 =?utf-8?B?MHJWeTBCdkZEMUNIaVpNVHhHbDE1ay96NUFETVdIbEFjKzVvMWljUHdHbkxR?=
 =?utf-8?B?b0lBdWtMYjhJK3RqcWJmLzNWZmR6d0U3eHd6VG03alRIWDk5RFVyZDVTWTFk?=
 =?utf-8?B?c1VORlFpdmg4Y0U4OVdFTjYzTVdnZ0hDRmhLTlVWVkNndTRyN2FLMXJrMVhI?=
 =?utf-8?B?dUprRkFkdytwYjhDU3lWYUt0T3FPV1BkRlE2SjE1b2RQSW9rSWE5ODhNSWNB?=
 =?utf-8?B?dzhjcVpjRlIzc2V5dGZFQnBGOVEvcVI5bDV6by9aZWJnUStxdjNGZm16NUcw?=
 =?utf-8?B?SVFTMXAxRGJrT3lnM1c1M2VUcWlhelRkdkhINHpRYW0wR01halphNWp5Y1Rw?=
 =?utf-8?B?bFpacmFrd3htTWZSWXJGSy9uN3Z3WUVZUTU5SGJlUlhGMTl1eDFwUEF5NWZJ?=
 =?utf-8?B?TDZvTE5oeDd4RXhqajU4eFBiVlVma0ttN3RzWWE5WlQ1MlVLbGdZRW1zV1VU?=
 =?utf-8?B?ZEI5YVVHcjZzMVk2enB4RDBtNHhCMmRSWGhFcm5qWkQ4cTQvQVM3QTRKZ29I?=
 =?utf-8?B?V1loajRIMW9QYmZnNmppTGgxMWR6d1lHckJwNlpScVVqSkowZTFabHljMExT?=
 =?utf-8?B?UFFoU2NpSFRtclY0WkdHbHVKb0c5ZjdkOENHK1hsb3V1SWFIVDFkQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc32e77-bafa-4b5e-8182-08df080a51c5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:20:52.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEvaeQLJcTYGvEUPStNXxvQem90wrKDod4PIbvz0gZ07TXClJXon4EChyj7SK7ej7uRQ7yQFJdB1WFqIRtfw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889


On 31/08/2026 09:20, Sebastian Andrzej Siewior wrote:
> On 2026-08-28 18:06:50 [+0100], Jon Hunter wrote:
>>
>> On 28/08/2026 17:06, Sebastian Andrzej Siewior wrote:
>>> On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
>>>> For some platforms it is a problem to queue irq_work when entering
>>>> cpuidle states. Since irq_work is used for deferred MSR handling,
>>>> any atomic console printing when entering cpuidle states can lead
>>>> to the affected hardware hanging. Tegra20 and Tegra30 are examples
>>>> of such platforms. Avoiding raising the irq_work IRQ has shown to
>>>> circumvent the problem.
>>>
>>> I would argue that this is done for the benefit of less interrupts since
>>> there no need to handle console_msr_work immediately. With the side
>>> effect that it might fix a bug that was not yet reported on Tegra[23]0.
>>>
>>> Ideally the Tegra folks should figure out what exactly is broken instead
>>> of adding duct tape everywhere else.
>>
>> Yes that would be ideal. Unfortunately these are old devices now and very
>> much in maintenance mode so getting to the bottom of this now is unlikely.
> 
> So this is maintenance mode.
> 
>> You may say then why don't we completely deprecate these, but then you
>> could argue the other way and say they have been working fine up until
>> now.
> 
> So a couple of years ago this platform stalled printk development due
> its irq_work usage. Now again. Imagine we would have a ext4 feature
> which freezes just this platform on boot. What would happen here?

I simply reported a regression. I did not set out to stall any work.
If the work stalled because of this issue alone, why was this not
discussed back when this happened? I am sure we could have come to
a reasonable comprise.

Please note that these legacy boards have caught some other issues in
the past and so I do see some value in keeping them working. This one
is a bit of an odd ball because clearly this platform has some issues
related to CPU idle. Again we are happy to discuss that and come to a
reasonable comprise.
> The current workaround is to use LAZY which in general defers the IRQ
> work to the next tick and it works for you. If you enable NOHZ and the
> CPU goes tickless even a scheduled LAZY irq-work will raise the irq-work
> interrupt to ensure the CPU does not go idle and we do have a wake up.
> 
> This might bring the problem back at some point.

That may be, and we will cross that bridge if and when we come to it.

Jon

-- 
nvpublic

