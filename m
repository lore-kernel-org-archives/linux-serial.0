Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CF37AA9C;
	Fri, 28 Aug 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936835; cv=fail; b=aqHFzv/HvjVaW0DR8wPRJXCYQ6FKkiKTbtoEm6Ay5GcBOaZA9N5i4GU8duS0paMUlZ5PFX/aa19MEyPjYaYOvVJUxqPfF3FuwjdDVpzYZdTR3cS2Z2ILtQEiaU4Ir9bt2o3ponyeQ6Vhnr6snoAXOaCpGPBKqTV3jDHVVus6UDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936835; c=relaxed/simple;
	bh=YCQKyn84Cft8dKunNYycAKIzFO7dyHk5ESIOhWwH67Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zr15IFFPHllxrGKnjAolHSefA7gEVV1wE44R/UUjBPa2BieIiaKXLAcUDepQsDIUmrhkx/8EToADwXpUATr9RPDl2H5oxf3Gsz8TN94wCKxAUcJFEAiQeCyfCD3+vKk4tp04f81CmhZjaLjL4O6H2UVauuV3bIQpdKWGAI2voXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YhNshMXX; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YhNshMXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX5GKjRZaNoFqlBEOIY+U+dFxdPB5ZfNkfwfEQYdEBU+y1zIcsZ31NhGDvf3vc4H1cF7LhD76eLY4ykDKDWk/xMcRZiBvovj0WkKz75m3Xg+HzUKXqU01gRQDoCs6GOV/7j7yaIwN2Pz3RyCZrrET1DnLts7a3P1FqF6WNgXn2uat0EGAEGoV2IEGWRSW7iBjeP7uuGUxEMRBq6zOPz2/s4VTR23fDqYQgEcrN8ie8Le+VklVhr1CVaVTy1bg87lO+qNXBnf2dv++z/OYZpgYJ8q6T4oQWBnLr4bLbtupekNHejwy/PB/rVDAV/9RykCRPc7yBFazOjCtFxqxXbEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83p7jdO2VEUXzIiQ67WkCOz2qEys4Gzg/qmYb0FRtV4=;
 b=lu6qdcG6IVZ1/VzE1BYGxPKF4tu39WsASY9r9G40h594RxK7u+00s7Y+fK7Y3tPVe2WOeHtynPTt6nJ8NxZgx2ZvxxNdF6v1qBpvGy0MAfyXvcPBPRruZZ0Jx7b8Ped7pPtLuZ95dmxPJ/oKewCCzeogQyfQuQC1hezxK9VBoS4gMJdrk89/CNEv87CYCDLBuJlJ8A6m/oALdTdUk6t6TmwELToFHvh8PPrRFuSf+Ih+1xhVAH8PP4mLXrHXnMNnLa88IoLm0W04q51NZioaVGkP4YQpqp3om7p7UP3PUPt0CulCHiZIckv2xVhHSiJV/PLMr+LZBYwuJY8qmMziVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83p7jdO2VEUXzIiQ67WkCOz2qEys4Gzg/qmYb0FRtV4=;
 b=YhNshMXXUp2uvJIWZOuoe0VRb1XS5i4B3AiOp6dA6YsZvdTzMnEm0JkkQaRm/FZSmH5L+/qeF1twnXq264m6AWA+/eMXg8ntDLd1DYLnJE8JjvNRXPVZa9tgNOMngXRkPfbl2u1Y5nGaZ4ys743WR9wIP/XyjMuz4ZgY1qC5lkzWMXFZe/MnPV7p1oJEg4twyFK2UAB4XLHaOCBDs0gGYQDGlGRotFjBpIuyCGj7rKya1SM+xGo1MhH9p7waxxDINVeDufGGWgz+jwkUvf6KnPfLqDqfH/TxTdbytztQ8lZu4JnXFed1as/oPm4BU8YW2RXO2u85P6GIXyhXf0KDig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:06:58 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:06:57 +0000
Message-ID: <0c2c424f-0372-4626-b14e-7697d98e6b20@nvidia.com>
Date: Fri, 28 Aug 2026 18:06:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260828160652.TQBsi8oO@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::20) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: fe68df80-ac26-4597-e671-08df0526c472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|7416014|10086099003|22082099003|18002099003|56012099006|3023799007|4143699003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yMdc1B6ZaecRjMCUx5qjZ+LBJ1Dtj9LF0mKc2DpcpXs0PIi47kklVIqdbbudSKNyVJh/1PPprqvSojQDHVscXu6H6cEddAieY11ofObYsMJvBkA3olTU1cNaizzWd+icuAfewGvnNJvuYpVsV6T0pLcJTkZGukbXnGZ+A4U4jFJ8AyR2BYb93q/0MSIkD0ItEZxc1CY509gTe2UR9o4A1lfWMjgo5OSJ8rSu0RGBiK2/joXp8auewK5gl4JU08tzhstjsCzYJyzN56nhrWPNm88CZT5hDUCTQn69Xfwg/Em3fuepmPdmv1jPke/O7n8b1TSxH8Y8xkA83CZmkoENgXAcZOVVeSePMXiADo9ceyJbqYaikbxJrWAkJXCL4tbU5OQhInicl8n6x0rJaZnFXNMjHsjDlEQE++2ge4l49r9Wf+gRyvaMnECWkGobunO3t3rTTwUORK11m29d6EnGY06ypS/ZiFUO3lfn9a82aGuxvZYfG5ZhjU37DAfLkda2SFVA9Bbdn8Z/g2PIyfoHTomML5LaPYN7FzvvNyvQWAvD040vG4rd2ciGdv5qzvkwOQbFiGMhFbO88seTRaZy0TVmCtB7VZLIRyaW7HbUy+N1JZz+S6/GoJd4a+VcpiLvXcbfKq6xQV7UhAyZrfSxup+SlVsH5Qkt17d2fokhaQs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(7416014)(10086099003)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?citqdjNTTGpXQ0l2TUdzMHh4UlNBTkw2TEtYU0I0QXBHZk9hL1pKZE12RFBP?=
 =?utf-8?B?NVJFdHlLUVV0TFh6SUFuRHY4VTBHVU1FblB3TWFPNUhYRkdMSHdPRXdBR0Vv?=
 =?utf-8?B?eWlqcWZEVlVqcWNKMVEzNkRXUXZBUHY5TVJNRkc3Q0IxeTdBRFBQeGloUWxH?=
 =?utf-8?B?ZGxlK21jRWlRVU1XZlF0WHpUYXFTUUJ4ZWJuZ1lHMVcraURHMUluWW56dzJv?=
 =?utf-8?B?NWVzNExjZW01S1FZMTFHS1RyWEQwL3BERUovaG9LSThpMTRwdERKejhDdk1Z?=
 =?utf-8?B?SEloMFRNN2RUUEY3R1VkVjl3Vm9xSkwwR2d6bzY5WmlsUG5iYzdlWHFQZTNa?=
 =?utf-8?B?M3FvbWVUNzBqc3pYMVY5YmRHdVVCUlZWa0hzNFZRRWl2WnphSEl1cGpPTytq?=
 =?utf-8?B?NlE4TDd0dVhxa2VZa1Jtb09zeElINUxDM0hQNm1CUDdxUTEyeTQxQVhYVnZC?=
 =?utf-8?B?c0FMZEx3aEtzT1FSOEV5NG82QXpMR3BUalYvaVM3L014NEhnSElzdmZVRENt?=
 =?utf-8?B?ekowdkxObnlBR1ZTYmxGVkNrZzJnaUpNUVVTOWpXOHJNVlptdzZ3TU5MZWNH?=
 =?utf-8?B?bHVDeUx0dHN5bmN2WXE0SHRnMUd3bGxLcHR5dy83Nms0UUZXMURLNktrZmUy?=
 =?utf-8?B?VHFzZExwQU5SVkRQZ2dpdDJrSGgzbGNEZzN4MHRQMjZYKzQ4VmhZdXRaODha?=
 =?utf-8?B?czJHMGVUamJOOXhCRDNreG5ENHFPUXJBUjNnL0VsTUFKdGVjRW9pU2JlcmZI?=
 =?utf-8?B?TmpCaExZOUkvVEdrVUNVQVhZOXhMNmQ1bTRiNFlIeXZmVjFMU3I1dXFWNEVo?=
 =?utf-8?B?WC9Rcnd3b3VlSzNKckpBYTFKM3dWdnFlallpNUdTK284OHhNRU5BaW1VT2k3?=
 =?utf-8?B?Y1kwa3h2cXFuR1ZzVXl5TnQ2ZGlQRm1naGJkV3JKS0pDc2IzYkZIMDdyRG54?=
 =?utf-8?B?SFQwb0hQS3BmKzFMODVUNUZULzVaS1dOd3V5SEJCcDlwczJNNk9GZWtQVUFv?=
 =?utf-8?B?RWNFMHhEYmVMc0tmOGpTZDdqRWErMjVHeEVycUtxVjRIMUppNGRaN2RWaVFT?=
 =?utf-8?B?YmhzWUQyVXliVk0zQ21RSzN3d2ROczBrSzhZdnVYN1dYc1J1c000ZytuRGFo?=
 =?utf-8?B?NUg0MHRQMFhkS1BHdUQ5dXFxdmIzU2tKZmlOQVA2U0N3am5jTDBxaXY0bUV3?=
 =?utf-8?B?NDlqbXlhbG5FNXBvYzkvYVN3TlpUTWxUWkRwcGpjTWRIL29jNGZleVJLT3hn?=
 =?utf-8?B?UnNKOGZoeDFlbDUvSTdJbVNuTFI2b1EwVGI4bkJhcGYyZEw0U0NDMjNIMmkz?=
 =?utf-8?B?TVY0UjdJUXdUcndQTm9WVkdSMy9LOG1jSnlTZ01rQzRTc1RBcTNyNldwUHY3?=
 =?utf-8?B?cmowRGJnY2thOExhajlYUVJnc0ZsM29teUVlVTVlR3NjdWxubTQrMmFFV0ls?=
 =?utf-8?B?ZUtBbitSY3NlR3FCYVlPVDFnQ0duVVRTajVWOTdET0QwOWh5U1VZdWdvL2xJ?=
 =?utf-8?B?M3ZzNi8yVFgvRHdESXB2dmx4VzdYcEJqOHAzSTlCeGw4SXl5V1JTRnlRdnlM?=
 =?utf-8?B?WVJ4aUZFUlBIWDJLMHkxUXZCdEp4MUt0SlVoWXJqUkhzV2dUckNIWE5iakM3?=
 =?utf-8?B?L2RCMXYrRjZFVGE2NXVoamhuTHdudk1xVkhYMnJQYXQyQWo0akZ6VVA2QU5u?=
 =?utf-8?B?NXVNZmJscWxZbDM3aGRGYnlMRlN6RzlQNmZlUytHU0NyUldLU0g3cVc4QVQv?=
 =?utf-8?B?SVF6ZkFxQVlSMUJRZ2RJdjlaZ2M5ZFNYcVFic3NmelpSSXN6WDVqZ21kMWVQ?=
 =?utf-8?B?MldzQmZlbDNOQ0VSK1hyT0oyZ0FZRmIwL1NzajNTRCs5S2VDZkJyaWhpMVdH?=
 =?utf-8?B?Y0xIRzIxVzU5MmxMRjR1UWYzYzIzUmU4eSsyQ0E0QzdZcy9jZjFyMGxPeUJZ?=
 =?utf-8?B?SXNWakFCczhrUVdTNWowZ3p6MU9Vd1JFVWJWM3ZZZVZ5aHNtRFY4RmEzZ2M3?=
 =?utf-8?B?RG95OW1XQjJjTndjZk55dGRPMWtlTVhzZ25hVlFQSGtabHg1OUZtKzlNd0pP?=
 =?utf-8?B?MmdqUmZaaVkrRjVyZHZVYXl1U0hUMndpNTJ2b3BrMGVhdVVURmQ2NDA3QVZ0?=
 =?utf-8?B?b3Q1ekp1Z0l0RmVhb09WNGRhbFJvTlRmeStScllQTWtSYmx3ZERzSmcyMXAx?=
 =?utf-8?B?cDcvUjl0NFVreWNRb1JZbnAxKzdYYUhWUEpKMExVWmVkVCtRSXk1d29ZU1h3?=
 =?utf-8?B?ZzRRNC9tZ3ZydEJJVXJ6Qis4UGFxU2xrajVaN3RKRzZueHE5UDB1bDUwQWRt?=
 =?utf-8?B?T0VCOVJtZnVkS0xNR3hDclNDQ1QrN25SaTdYZmJjUlZnSmNWN3d3SjRod1FF?=
 =?utf-8?Q?S+gbJ5ezjzvfVOajQj5MJqeQumCEz97yINifaZ4QqszsP?=
X-MS-Exchange-AntiSpam-MessageData-1: sZbTuX6by5zl6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe68df80-ac26-4597-e671-08df0526c472
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:06:57.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnRewoFEY8oTzYbIAjvf5b/1ZgpiiQ0P8xgc8/0nBL2/9IQ0+WENjeUZ4HWj1Od7ZVdOV4u28PEDX5q8/R0jRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309


On 28/08/2026 17:06, Sebastian Andrzej Siewior wrote:
> On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
>> For some platforms it is a problem to queue irq_work when entering
>> cpuidle states. Since irq_work is used for deferred MSR handling,
>> any atomic console printing when entering cpuidle states can lead
>> to the affected hardware hanging. Tegra20 and Tegra30 are examples
>> of such platforms. Avoiding raising the irq_work IRQ has shown to
>> circumvent the problem.
> 
> I would argue that this is done for the benefit of less interrupts since
> there no need to handle console_msr_work immediately. With the side
> effect that it might fix a bug that was not yet reported on Tegra[23]0.
> 
> Ideally the Tegra folks should figure out what exactly is broken instead
> of adding duct tape everywhere else.

Yes that would be ideal. Unfortunately these are old devices now and very
much in maintenance mode so getting to the bottom of this now is unlikely.
You may say then why don't we completely deprecate these, but then you
could argue the other way and say they have been working fine up until
now.

Jon

-- 
nvpublic

