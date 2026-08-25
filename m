Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07044E055;
	Tue, 25 Aug 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672131; cv=fail; b=YCUzqznMrkZSnll7amHx/tC8e10VG8gZqnPnz80hawNbu3HuAGjZyskgvLAQPVWeRGH0jGrgIZQASNvsY4cS0fZB/5bwGFFg+V0lcnXXHXtmqQlM5zAJTXjD7TFF3ZiZv3PQOX7tgVPaOkFFFunCqwGXKys8fjhfqaMSVKD4vLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672131; c=relaxed/simple;
	bh=ZymEhdlCQYShCKIq4Juaki8DjXdZRyQBfD/5FH695i0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qE94aXnG/r4jL9yxrGOJ3ElqIxOAi+UDlx3A2nskx45L4Gh42CEYg9yslxOYrI/XYTIIvD3lLhIm+osCa/ozonPnfAF0yHxcEMu8F4MnHbxfgUSvtHu3EBi4diO23Ep5A64yfSI7NkBU8YKcCmFavw6WDKnsnGyxbzdOcAvXEhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LxkDSgL/; arc=fail smtp.client-ip=40.107.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LxkDSgL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9blcCQrSJ2vJKmk2uBWXVY/WqTdwJU9kVPCsrR6yTh8Pic5+elSYXRJu6ljYc6r/7JSFgsY7LidZZ7WegnIH/ITCy6vvPUdikxdY6r46Gi/ZjpmqtA1ZWgGqJKhkKdCH5VWd0F4Rpp/Q7Yu6cRPjCaDfvQ8QGJ0TJQfSEEnxZYkjhShy4wnfFlR5EjK44fq8VtObwPzXSS6y24RfyYprbm3+G7etTMKrSeTIHENeC+qgJrBLZkTfxqJ30fVYQO6wlXHjVJFr39fthOYd0ldlIkpWo7+tTLAtZAvgOoWQXWlkL2Bigd/a+/tVm9brMQ8HUBiX825qrM8axRmOpQbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FII7yTVkJm4nLN59AzZR73xGxoznqXotqDB9rDgcdhE=;
 b=iGZrePMa0C8KWc7oPjj75ZCMuA/6NcogP6Tz1jyrqVye8Q3pf1Qsog+nCASQGNKxHXDYBzwwkOmtv5PIiilTS5NL9t/AOb3roHPiee/b4fz6U+5ZKQtg2+biYaiF1sQMMgxVOAhu/SHzW5pzpoYPojulhu1rwYPXTRF8elaimnAGUDEFMpZk+rD+r/BDAoeG8VhwnPULrupmAYUkyi+dHbc0E9YmNMOgE+PGxaU1vNl4KCmPOJJwF6jHaNV+5Xqd1BC5Vc6egcabqaoOCdxN4ls7LNGw8RhciarS1VuBHPFiJJlbT0T91MNTlsBincFijngGi9BLnMb5PlrMFBy9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FII7yTVkJm4nLN59AzZR73xGxoznqXotqDB9rDgcdhE=;
 b=LxkDSgL/xECBr+OViX5y6EJDJwDzJQw98lchVIvfClfSex5ZPSHBfL+ZWqhwwC0i+Mk69rczTktU/Sgfs58q+yzO6w/ANZQ8Kb/VrR0Ial3F89b+56+rEnp1VvJmQiDiyPk+BTRZ/LvfsQAxlL81UmaRjvNpN/rY+Gt8NATnsU+hqG7l7xtYL35NIXekjL1xgtBVF0U4KR1lsR/kGEhlxRDBCOHv3rElkhvcncZR2LoS4NXiEG43M/n+vmoIV1wkauA/21JvaC7UEPAPhqqHChtczRnE4COzJ3Iqmg7aVjYCnQSilrMpMWVFLLmOaPbyLy0yhSig6Ih1Imn++0zZxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 15:35:22 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 15:35:22 +0000
Message-ID: <d058012e-2be7-4e70-9c10-5e4c00a23b05@nvidia.com>
Date: Tue, 25 Aug 2026 16:35:15 +0100
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
 <eb0f2c8b-2c7b-4bfd-9144-6786999c4c31@nvidia.com>
 <875x139eqr.fsf@jogness.linutronix.de>
 <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
 <877ble714e.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <877ble714e.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: d12139ec-d246-46a0-4f65-08df02be79d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|10067099003|11063799006|3023799007|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PM88BVwQ6YQPjB1hdTmtfDkE3iltSvkUcA5jYE47I4uPg5SVgbF0I14FOjr4UxHiGJyjOg55WNWTbkNUlkWdmtLo6iBjCwK7pU7360Yp6IRhAnYiyUnXBbWRU6wXpFTx/6nKpKN4zcBUWwIhK+hp9ygPv5hB/L+Z0Byv/SOVvHESD0NtsmQF+p3MC4q970LctwczMGuX+fbXFVZgGp76aV8pE4vITgdJ58G+ELUCifUcu/1z1VCZ3sI5fzymceRigB5tsticsZ4sW6qtCpx1kXvL2N/IXevOgSiozO1Z/Tq10qzy7QmgDvLzCZzpmRpTNdOedcqJCWiMTDQkmvo3BB7SG7Ty4qx02OHGtmCcLCC90ksOeJe6G9BEqfYz8DXlbCtpu24Cho10iWKKCquLBH09QBOsXoZjNAmBLCwOm+uoyp+cbHFGDI/IbjQWT4vz0+Az7DPKPwmzk9chenytKm9iaAqwZOVrVIgpl7Vv6wNJ5Zod30KJszcKeCQzhAbZ/S95NVBGsiYZxbvfA4X+JW/3mOw0IRQLXJZSry1MkBLjTdV+8nIT/23ZgiebrNuGHXulB3hSNt/cQ1pwxoGF3OapWOIDBlHHPzAvkKkRbcuQ18RU7TrvKArrnPbv+yldm8Fs6CYxp/Yi3l5Egl/l06D9ohWjQiTx/8w1ID5Fcfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(10067099003)(11063799006)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05pSUFINnBBOEx4K0U3c0dzWmJGNy9lK2VhR05CTlVZcWpMMFFwaDBTeHha?=
 =?utf-8?B?YmozN29WVkJ4bkdvblh1V2tYR2FnNHhhbnh6akd5RnU5b0NUQ3JaVHlzUE9m?=
 =?utf-8?B?VUpxR05qbS9CV2hlSVZZVVJON1EyUFl1dlNCMXQyQ1BEdGYyZ05tNC82aWRJ?=
 =?utf-8?B?SEU4NEJOVDNkb1lIWlV0SnduMzRYZUFnVzRZbks4MVBUUFc5WURqUG84OC8v?=
 =?utf-8?B?MlN2dXplcnFNSFg5OG04Tng1V3kyWUNCVDJxaSswYk40ZWY2Z2xNMm4xYTIy?=
 =?utf-8?B?MkNPcXU4Z2xMMkRQcWlrS01wSjJGSlhqWDJiNmdsOUFQSXFWWm1VRE1BZ21J?=
 =?utf-8?B?UWdUbTNScFUvNGp1WUJvS2NqMDh4TTdCWFIvbGZlQUVJQ2VGNVVYc1NtaVp1?=
 =?utf-8?B?TEh4WTRCUHlaNDhhTFpnVTduZXZVR0lzV3loRCtZOTEvT2M5eU5UV3RveDdN?=
 =?utf-8?B?YWdJVjRoNDB6cEVoSEt2REVScG01SlU3T0NSTDd5dG9JQmRObFQ4Rzh4QnBk?=
 =?utf-8?B?aW5QT0FTWGQxK1JGeUs3WVFKQThSeGVyWVlmTlZLT0hNUzRhWjdTN2o4ZUFD?=
 =?utf-8?B?d0RhSUFFRS9pSXh3R3hJWmtwODNYZlRQN21BTXEzSGE1U096akJIYzZtZ3Nz?=
 =?utf-8?B?U294ZDhPVnVXSmlnRG4xSVB6Z2d3b244VnY2T3FKdjY5ZkFYOFcxM1pMMnFm?=
 =?utf-8?B?ck5GYmdZVC8xZGxGUHNuRzRnTzFZTEpUZklPbjNyd3lBSmkrYmJFY1UvVjBp?=
 =?utf-8?B?N0VWaEV3QXQ3WXBlVzdxbmZQb2QzQUVpU0hFc1M4OHMrZTZCWWdWOGJOTGF0?=
 =?utf-8?B?dzdPd1NBRUJlWlVpQ3pwT0lGejVTZTd2M2pneGxaemQ4MHIxRmxTWkk5UFlV?=
 =?utf-8?B?d0ZoYUlYRmpMejRBak5KL1BtWkptM2FuOGxENDFBRFBIZ3MvOWtUNlRYNlN0?=
 =?utf-8?B?Uk83L0lpa1BSUXdnNVF6MExYYjlMUmlwcFJadHRzT2h2OVBqLzMrTU14dnpz?=
 =?utf-8?B?ekV3b3hpZnIwTE9QVkRqcFZsbTVONm01ZWE5aXZYV1IrS2VrV2RlT1FUWnh2?=
 =?utf-8?B?b3JwSFZyNTBEN1pzVjZDU2l1OEQwaENGVVFmZi8yZ09rSHJWZWoyYXo1SDBa?=
 =?utf-8?B?N3M0czlQMXBrZHV6N3dFaW5vZHpERTdzeWhHbi9WcFdOODl4amlRVkptZzBD?=
 =?utf-8?B?MWtCNmU0MEFJWUYxSDJmaHpEcHNCVEg5YmRkdHhRYVRtTk9rMW5xTGdMZkhL?=
 =?utf-8?B?Q2JNMTB5a1BhR2x5V0huYXZRZWp5MUVuNllUaWRndFpqQ3IxN3dTbUlGci9F?=
 =?utf-8?B?WUNLVVh2UXUyVGVUbUlwRUR3OGhkQk00ZkIwRjJkTmRUN0ZDY1BNMURWUXVX?=
 =?utf-8?B?dEJKSUphMTEwV1pQdEdhMHMxd1dzR2RkZjBuemlJb3E5TE5hTmhPcmlEdWsx?=
 =?utf-8?B?dU1FUEM1b0tPbHF6RWlKbU0yTDU4bmdHNEhXVytwZ2RyMmFjb0FzQlRVa1hT?=
 =?utf-8?B?WmN1dm5NY283U0dnSUcyZ1NhVjF5eFhwUWduSTgzOEFrVUYyMStzQzNOektR?=
 =?utf-8?B?S0RyMHlhUUVreHhCRDM5Vzh4YUU4Y3JlN2d5MEVTSHd3MGJMMkhGRTg5dm9F?=
 =?utf-8?B?NEFjUUpGZ04ycldqRloxa3FRZ2l5aSsxZ29JMEF2cmxxcGNuTVdhZ1dLRFNQ?=
 =?utf-8?B?eXh2ZW90NGpBRjU0eGFGVmhpZU8zMHZKcDRINUZFZjBzT2wwYkM5YjVoM3N3?=
 =?utf-8?B?MnM0bE9mczh1cks2eXVNb0RGbk8yS0JOeER1WDRpejVBT2xzZXAyRVhVTkdY?=
 =?utf-8?B?bjBGNjNVdDRBU0tjakIrcHBxMnNocyswMStXaEN3N1VPdzhEUmxaVHRBYjlz?=
 =?utf-8?B?NS8yL1RZMWVQMy9mR2NxcldIcTRNdU9YNmVDV1JyZ2lUb2twZDVTdTBkYjF1?=
 =?utf-8?B?MlU1SC9uWTdVYm5xcjdkZmZwQXBjV29pOWFGR2RobXRKTXFDWDJHY0ZYR1ds?=
 =?utf-8?B?TEk1VVNRRjRyR2pMNGp5aHJBV3FJQXRXY2JDZC8zQkhzVDBqZHVITHFMbEg2?=
 =?utf-8?B?OGJJUldjREtYek5ZWGEyOE5ZN0twd25xczg0eGZjTzAxb2hzNXA1QkdmTmRL?=
 =?utf-8?B?Sm9LelovbFIvemNXWVE2NUtzN2lpdXZicjIvRG04QTJ5VFVES3JjcEJoQSt5?=
 =?utf-8?B?UTJYaUNwMTBQeStiY2lFQllnVy9xalBMbWFiYTg2eGlwK2xSN2t0dmIvQUw2?=
 =?utf-8?B?WTZBZ1ZuRmlCdDhyeVpDRXB0TTBsQkw3Z2VXaW5NTm5JWkJSQm1CL1lqUENZ?=
 =?utf-8?B?ZktZWHlxRzRjeVUrWjlnNE52bU9sS3lhNVVTcXFWWGpNU1hjZnZIQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12139ec-d246-46a0-4f65-08df02be79d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:35:22.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GluWY2olIlEATs4XzwWlAwGJX+4gCOEqinW1UvS896yRie09R8ZymNNAez003YyiZSzFndQNDN23ylhcXV3jwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

Hi John,

On 25/08/2026 14:58, John Ogness wrote:
> Hi Jon,
> 
> On 2026-08-24, Jon Hunter <jonathanh@nvidia.com> wrote:
>> With this I see a little more output on the console, but it still
>> appears to hang later and never fully boots.
>>
>> Boot log here: https://pastebin.com/Xe1vmeUj
> 
> Thanks, this information is helpful. Below is another hack, to be used
> on the unmodified linux-next. For whatever reason, I think the queuing
> of irqwork is causing problems. Perhaps the irqwork is actually firing
> even though interrupts are supposed to be disabled here.
> 
> The following hack will disable the queuing during the cpuidle. Please
> give this a try:
> 
> ===== BEGIN CPUIDLE HACK =====
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index aca907a62bb5d..1dca9d6defbff 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -226,6 +226,7 @@ static int tegra_cpuidle_adjust_state_index(int index, unsigned int cpu)
>   	return index;
>   }
>   
> +extern bool console_irqwork_blocked;
>   static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>   					 struct cpuidle_driver *drv,
>   					 int index)
> @@ -238,6 +239,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>   	if (dev->states_usage[index].disable)
>   		return -1;
>   
> +	console_irqwork_blocked = true;
> +
>   	if (index == TEGRA_C1) {
>   		if (do_rcu)
>   			ct_cpuidle_enter();
> @@ -256,6 +259,8 @@ static __cpuidle int tegra_cpuidle_enter(struct cpuidle_device *dev,
>   		index = ret;
>   	}
>   
> +	console_irqwork_blocked = false;
> +
>   	return index;
>   }
> ===== END CPUIDLE HACK =====
Yes that does boot. Let me know if there are any further tests I can run.

Thanks!
Jon

-- 
nvpublic

