Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3653E7BB4;
	Wed,  2 Sep 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338065; cv=fail; b=hmKebV/zeNtiDCiDikfBD3ENpOCRac0MQNkw98eC6bDTybhHg63kTMeyf66R7SKj6jXgnt+CFXWtCAe5pi6oCwXgl7OVYxke+bOkSbJxJ29ttk0HQ+H8gH0rp93jDbcKd+JkIQXGnR3RZUSySii67/7VH9whRq7n9Rtzt8N0Rac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338065; c=relaxed/simple;
	bh=WIubD107iNukbZtHgU6pZ7AD73yt5QguYV25xCM9Ad4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JV8fyewkgssbRVU9UE0NzQTDia+D33UfJUObJdJ8kQuLGHJBLo6YLtf7fqlQrFGxzbZxn4FAPUzXEQDdbw+vTTllcT2VRTLvjgVESJFqp8jkMU2kTFvPajxvCRG8hbBcImgTwQ8VQhgZLCmHxh2K3yTB+44fLvs+O66eJEmz5P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ATAWH+bR; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ATAWH+bR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWa/s2pNwGP/zRD7P/+R2lj4sMhpFi0I+/qhF254APiH0W8uLp0EdzfadDbNNbpd+vVQRjiQawZtdC8N9Gj/bRdWP95tfuehZsHCywRPZ2mP7HP3l9PS1xYkksMA4jB/40HfOcLLfr83rm6m1yQd1aG02J9aCG7rPIqRwJNhriKDLgHcPlUb1rIFYGaL2EN0CXDnjLDEqCSTd7n8VtU2Ghk+I0T5NQov9MtetfelO+vdGdnSpBlcOS8Qx/ZegU8y0oyPcJrMt1E7YY9HRM+J8+TB3UIjKs/EQ2ChIPHbZcM+r/Xt8ij9iuOXL6uLRlDLyqbBuKqGocyBC/WhfZO/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYXZJAYy25Np24MgsClBljROZnA+/MJkUF1TEQD5hRw=;
 b=FMqzme4fvxVseUCXpJmIG79x9lqtfk93wOnK9VVx3NsO3hwSCwgHQzJnXJkZx7sLKY+6dzBF/RRBOzkTGhhQZjho2X37KqvOVjkbnNEjdOgJJ/JyRQPAd5jALP+1jkwMsqhKkPBtAMp5p/tMHSkYhCux2hXTjn1aRSkEjOcOeV5YEOIDWUEsr4z2aMJ04vVmi9i2N5/9jZOoo0NUu4uh6yAj0oCY3uYH6vPh6bqtsqw4ro7xwAUQgFGCIAZ8g7CwRQidPQF+xyfyE92fBBuT6UtdDLIAl8HfHTV+R2wcrdWKsBh7msBhPYGJXLXpzmMXq9kMtzF3dzKqIRLh2R29WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYXZJAYy25Np24MgsClBljROZnA+/MJkUF1TEQD5hRw=;
 b=ATAWH+bRTNVMl6XgqmatCxRCBfrt84Iyed+X6Yggg8gkEZqiOfi2UH/7aNnT8dYheZvh3SJYJQ10gRarvXCk7XHu89icBJH2krt/MuoExYTXvVMSyZpon7tw2gfmYDFO4EjSUqaN6DZ/1nT7QyCLfHNXAz7y/+ilTTCz/lWvj+ucl9EJI0ZXumS5DAO2jlkXV4XYSieALQCABMu7RvocD2HO649Bw15RIizsOIHFLJJPNv2QMk76m4iuH23ihcrngTb4HUNDFRauiyexVWhxIVqihlVjwxF7yEoYn7Y7JRAHlP2+sST0BFNNsYcsqC9dpLijqO0kvu/3fSY9ynO41A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:34:21 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:34:21 +0000
Message-ID: <8ae7610d-e160-4fab-a9f4-414001fd5fee@nvidia.com>
Date: Wed, 2 Sep 2026 09:34:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thierry Reding <thierry.reding@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Crescent Hsieh <crescentcy.hsieh@moxa.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-serial@vger.kernel.org
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260828155811.270462-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0023.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:33::9) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cf7dfe-6fd1-4423-31b2-08df08ccfc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|3023799007|10067099003|56012099006|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zXQzxiTj4uAsOZewcz6h4rerwLViwUzAZ8b2HssRT3tYQ8GuvOc7PiKKFnnO6DouRe1f5JopO2ZuDQ7WVWtKhNjb2BQIwXH1okKVjEu/QrlC7tMmBlLAZlI6Jr7AUb08D2XIl4qMw3EkjwMvbdv/0Z72Fl1in/ROk5vdMMeZUUIDkRzCpotC9XjjOVsXtHd8QB3CjrLucii+xq/MMVIjFdXwP2SWEmpX06PaWXdY5n9Ou49hqM6GihJec0+6CWxaEL28ROduA3c7u2IwmZCI78pvI502TV0OVyom2MkmdMhtlq5EcKELyurz5Jz5biaKWD0tzj5W23xBHjYyJUVKpcOgwmV7AjoMV/cSDr42mMIfEmm1JM6D2U520bb+YC6tdbPeArI5mE3cmqnGMp2FLdeOKKSgqJBiVRCqTMa2xZnjeXo6CIWDLZc4/dtMkyNdbqDc2qynxRuN7RrhpeKfMPhTrQOH/PONCnVc/WTVkHzjz69URc1l8YyWyOUCyzmNfYzVPl8qrYV6rd2H6N/y7Rr7pTrbD34mc266JvMbrkSjMfx5BuibS6+eJBd2BqWiuF8n9hzRNhRvEPrMy0MiPnKe4/x0/tjzLiBVvLQvUZ/jhXq4z1g8TgMnBN/ozc+HWyZ78qWDppB+bnwKfmd1vGOVKK9sz+lxEAMIiCvmbUE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(3023799007)(10067099003)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxkSGU3OG9jR1dkVnBWOEkrcEJ5cnRiQTg4ZFlFajZwM3hWQU1lMjZzbmtG?=
 =?utf-8?B?NG43OXJHMkw3d0xOVVUyTlhvaWtyWS9GYW1zTkNXR2J6WEk3NzlzeXFqdWZj?=
 =?utf-8?B?SWZKSEsvamx1djBvV212RHkrY0wzWVFKWmdkMnQ4QjVkbEVZa0U4K2oyVG9u?=
 =?utf-8?B?bW5vOGFIY0lzRjdqbzUxemgxRHMyN2pOSmlKRm9MSXViMHFCV2p5UzFTbEh0?=
 =?utf-8?B?RE1WNlBadnNnY2c0TU1xN3BDZ0xRc3hRdUFobjBoMHZyRDdZOEc3a2JUZ21Y?=
 =?utf-8?B?Qjl1ZDJkN2svOVVMU3B2SmRLYzdPcks2NmE4Vm1qclIvNkRKbGc3TEJCOFRY?=
 =?utf-8?B?ZmFZZ1RBWk1lekdGRkVhUVZ3Skk4VE9aNEdqbDA1a21QS3ZMaFc2ck5URE1z?=
 =?utf-8?B?ODZyZ3hOeEdVVUtKMGJHK0N4ekplRXdsRXZ1OHNhT2F1OWZmazk5Z3c2ZlBI?=
 =?utf-8?B?U256NnhPOVo4RlVKblIvRVRnZ2ZOc2U0L0IzbHRmNWlrWEhXU1EwckpVRDRN?=
 =?utf-8?B?WncySWplYVRreDBKL1MzM2VyaUlhbWFDK3hzRkROdm5mQ1d2aEFFaTRnSVJ2?=
 =?utf-8?B?UFltazBJWEF5UFZqK0ZIT1pqeXNpMklkZUYxR3U1ZTkyby9NdmxxWEZzN1A1?=
 =?utf-8?B?bTJyV1BtNXRVaEt0T0c5Q0V2aDJjT2hIdks0Nk9BTUdhWGFXbDhGZzNjOXpS?=
 =?utf-8?B?OWszTkZKeGtGWVJNSFMrb3dTU01WTHllR1lYN2xJdWMySjJEMjJETk9HVTFP?=
 =?utf-8?B?elVja1B2Ui9NZjJob2FTQ1lvL3FlTFp0ZGxpdkEvWFRxdlhuZHN4dzdkYWNM?=
 =?utf-8?B?OHAzenhRWldMcGIyOTNWRGpJamZqdVZlYTFhNkEwVDFUVDR0aG4xcWdtd2ww?=
 =?utf-8?B?cStoWlBHY2hLVk5CelZweWw4bm1ka05kMm44eFJ6b0hhSldtelVVRUEzUnhQ?=
 =?utf-8?B?VmxJVVhRVlZoWUxkNWRXNmtzWkswczFWMWtMZzhlVExEeThEOXM4Q0ZIVzdj?=
 =?utf-8?B?NEMxaHg1eFp2cjNaQnpDOThGMm5UYjBTcnBnc2Vxenh5Zk11emNDcHdoY1Vs?=
 =?utf-8?B?dUd0VjQ5WFZxTEJScmQ0VDhEUHRNY2VNcmIrNlY4NWdKMkJLY3VJZUNOV1kv?=
 =?utf-8?B?NVNwRE1jUS9jT2tGWFIrbytVZ01jSjk4OE5KL2VpNjl0RUEwQ21OTGRJNk5I?=
 =?utf-8?B?aWtPSUpra2gyWGRQaHd2VG9EbmhDN1ZOZU9MMGIvbmttQVJBeWhJS29KWGNy?=
 =?utf-8?B?elltYmhtNWJUSGZ5RVVjb0tqY292MjB5QTgrZC8wN0IzaERzbTdoVGtONEtO?=
 =?utf-8?B?OStyU2dHaUxDTDdzQkt5MmZjL0tmRmZWbGtCTFVHOUZWTnU3aTlKa0Z6elha?=
 =?utf-8?B?UXpWN3hKRHlGaWpVQlVzV1Rla0srSVBBNjNRL0lkSW5hNW41WUZZSTJVaEZ2?=
 =?utf-8?B?N1dQQ0VES3JkWlNrUVNFSEJMTzg3a1FLaENNVit2bHBHMDcyM0ZpRmlFV3Rt?=
 =?utf-8?B?V2VjNVE0NjFFeUFma1lmWDZ4NHZReVlyU1Q3TkZiRlJUcEdQeUlCbnZWOStP?=
 =?utf-8?B?VDBTVklDb3JMcDdUUjhEempuVzJmck5pakVHU1pWa2Q4a3d4NnlKSHZzWGtV?=
 =?utf-8?B?SjZtVmdjTDZrZUJ3d05FTGZNcUlIcWFyQ3JydVNZcGxZd0VjQk1uaGtCVFpY?=
 =?utf-8?B?V2JoVGpnU2ZSbmZ4Ty8xTnZQUDVZbC9uRnB6UGZZVFE1MmtCZXpzM3VzMmty?=
 =?utf-8?B?aTJCYjhJK3V5K0JUVTh3QTdNYmJNWkp5cjVOUnFFaHFucElBcjlCVEVqQnRX?=
 =?utf-8?B?U2dFYzRPQlFFY1c5Tk52L2lhakg1VVBVR0oyc3RhN3p2QXozdVZJZ1Rwclhi?=
 =?utf-8?B?NFZNT3hHNHJ2c3d5cVc0Z3RwU2F3d3NjbVRJOFQyeFh2T0NKcmp2VUt2QVlW?=
 =?utf-8?B?K2dlcHFCN2kyMy9wUjY2MFRkelJxeE90ZnZFWGRRdUNSWWpSa3hGR3lTVmR5?=
 =?utf-8?B?dHVHYzQ4RHBsL2xkeVBWa2J1NHBLTTNlYkk1YThPTlNZZWdhY3NMekxBWWdZ?=
 =?utf-8?B?bkVDNUhHTk15WkpYd2xWSnRJbkN1WWUveTdZenFrL04rYTY4NE4ycHNCRTFF?=
 =?utf-8?B?ZG90eGlVMmMwdzV3Z3lmSWlSNXlYQmFkYThmWVBsSTljbS9vUFRqaGJrL0dk?=
 =?utf-8?B?ZHF2Sm9QZkFBZ3VDUTJ0UHVlZ0xTTnNXSGxWcGJRWW1wRlhSYVMxNjBuRUUx?=
 =?utf-8?B?ZXkxSWRhcmNNTHEydkdNL1ZuczcrWU5QMlBPdUxkUEtRNFVBd1N1Mjg5SlZ2?=
 =?utf-8?B?eUJHNVFvdDJUN00ySHJZcE16TExqZUJkbGdIOW1HR2NCNXRQemhNY0dPVDNo?=
 =?utf-8?Q?a5wLIlLO3B1rnh4cqjGSsoH7vlbuTbTJ9Px094PTX1SfB?=
X-MS-Exchange-AntiSpam-MessageData-1: ZrSZsD33A+DuLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf7dfe-6fd1-4423-31b2-08df08ccfc8e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:34:21.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QyEcaEF/IwBRaYNaguWsbRNIM14BVwaErA2dbLMsH0uY1VO4YZrSwGApFe0eCSQcag5qbS8fesqdr0Mob7H/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853


On 28/08/2026 16:58, John Ogness wrote:
> For some platforms it is a problem to queue irq_work when entering
> cpuidle states. Since irq_work is used for deferred MSR handling,
> any atomic console printing when entering cpuidle states can lead
> to the affected hardware hanging. Tegra20 and Tegra30 are examples
> of such platforms. Avoiding raising the irq_work IRQ has shown to
> circumvent the problem.
> 
> Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
> an IRQ upon irq_work queuing. The irq_work is then handled on the
> next interrupt (worst case, kernel tick).
> 
> Link: https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com
> Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>   drivers/tty/serial/8250/8250_port.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 38fa45e74a37a..1acb73e45f8a0 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3597,7 +3597,7 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
>   
>   	up->console_line_ended = true;
>   	up->console_msr_work_allow = true;
> -	init_irq_work(&up->console_msr_work, console_msr_handler);
> +	up->console_msr_work = IRQ_WORK_INIT_LAZY(console_msr_handler);
>   
>   	if (options)
>   		uart_parse_options(options, &baud, &parity, &bits, &flow);


FWIW ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

