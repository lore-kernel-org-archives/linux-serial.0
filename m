Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979E39150A;
	Mon, 24 Aug 2026 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606784; cv=fail; b=tKFmiFtEHzo/wRTbg5YwYA9t94zmqoe13Gjk0aiMub8JzMzuAXw7mRq/Ycp6XFVBEibfl9Ym4VZTX3HbExxWlkBrakhFWHHWs0v3q+QaQSZRdwSZJAHbIZZf1+qcDDLYuBJ0DkrsE1k1/QJffd4A0RPpK2ve33mY3Y3ja5f+1Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606784; c=relaxed/simple;
	bh=ybhhdOny4iU2fVjE5xOIO3rdgijIRvg++8ZETOFprlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ilfeRg/sNM7yDp3+nIn07X6riYCO1IFg4/Wan3ju02egBKlMhgK5m01YlDh5kax4K/e/k2k0yDppCSWTfApr+DTQOIkpJfytws95FvhknZ+8UCF5ULx6cM2ICk1y2vRkOGzCcsHzbYd+zdLU7cOUtz0Jkfkho1EzvIy57rCWsiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1Ub3Uvt; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1Ub3Uvt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9Id/bjUb2QNwbCsrqoOmxJYjW4JIw7QmeGHj5Y4TbGvqfVjv0xUtkWnpLrLgndpXzq+rBdNK7x07ghopU6mD6LcbCbYmTDMGS9Ru+imOHNwMMm+ACR2YlFTvlQqvhT4CzLuq5BNyQsouCc8b+VXczhPb32NgqFs343Kb/nD5mrNJrGGJwQPMhW66kiy/b17GX0SPxh651MEPIIIbzuQTaV55F/ra06vsTeyUHpTlG1J4sxdukTYg2VQZIgGEgkgsgIkHw4NK/MG+hnscmsDSPx7k3mIqdvcX2OA0td+URBG5CDbkKTQ4bfkGdRUqLjidQCdfLVQ6Zop0ohsJlLuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0zL3t9JH5ZAUJ9tg7yaZCfeBOj6hIfM7QRC+3F5Q7A=;
 b=sbT2DPkhkTbpruY3m+LhCdQopBCnU834CpIk9Et9jxvfaULtLKVnMol9v6ZSLeBHuWb+jVf6Rod6sbung1wZqqvZfW9FRyI+N6Qukk15qtq4G6+s/GGdswUbbap5A45/qBSJpHue6yMF/lvVsV+SEaXYVw11uuPw+Bfprxf5KMpotgHjW1OVoiaIoBdAbD5IU8LH44GRFD5J58uCMheLMlin81jrc8hjoiyLnpgSuvyjtiHU5XNXTVyeKmy6/TYU7w0I4wcq/lKXxKdrHVNuTOtyC0sGcbI7pvkeTvq52QA2PcH9/0mlvl1mVv+DZkyn4h8k8Bvfgxv2X7JuQomLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0zL3t9JH5ZAUJ9tg7yaZCfeBOj6hIfM7QRC+3F5Q7A=;
 b=t1Ub3UvtAaXpG0toU88wCCmTLhwRNlr4dWlBkQNuyygrBaGjant2HMu4H++O8unSGPTImCgdwhCbmvKp39lWrRdejwxKis7MjtJ6J//3/zfD7pRQCnnGqx7VxwrlPxO/K5TVGyb3dQ089zeSxndPjvWWFFljQwu1fFuD+np0wX0V+g94D3uWtEgoNO8w/KLnaTU9OekSqIRulKctKKw7Jn8lFdLwehfpVZ9RdWFRyeupNZQokthMKye5JrvxaFXJ3sL1cFTDmHAm+F+OGuo6GrOb80c/htSp8UKUShmFWl117X3UuHMnQFoe94FcQeoL3y8DKgX0YJ26z2VZmugVpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 24 Aug
 2026 21:26:18 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 21:26:18 +0000
Message-ID: <6b46866f-548f-4963-bc41-48ce15ae9012@nvidia.com>
Date: Mon, 24 Aug 2026 22:26:09 +0100
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
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <875x139eqr.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00023953.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::350) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ff771f-8274-4d2b-e865-08df02265603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|7416014|376014|366016|18002099003|56012099006|10067099003|3023799007|22082099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wC2l/eV8+VFamINBkVTKPz9eaIrCUkxRp9pfei99vHxKGL/mbkIrx7p+ozAWA8VvK5DcSwirHQSya0y9DKVH/qmJ1OzgHu16gMtx4ciFhS4L4U9BmVCRdrm1pfcuSDw2qCdLjvBqyzZGacK70Ujnt9ktCuBkHNno+oWqQ0Uhe7ntuUi0CjS+r1ro5/T9fFfsOavhUEB9mMJVyuXhKAmicx9TfUbdOTBphKghpwnM+uBO9Xfhh1XbkLUN3yita6MSvM4k+e1VYRl6LpSPGcDV4Gp40uJ7VeHWjRS7rgeHsbIEZmyLve9lwh1sSxmMHUC6fgRkpY84C1xIf2kH4wjl5DDHbpzcapSdMFsuSEPq3Jxup1CKTOEE5hs1GV4+QgeGUuBW1MrPQztGlVGhvJBMXVavsPaSWf0/XNIqGEkNdl2ogCyUYC+4u+94epzoIUPK6TlAfvL9V7Ms4PUJ/YIQRUy3IDLG0vWseFVO+xJY/9dQLXLcFoEYrDZbZxiBylPxRk0FNFB0wqImE4VbULeUzU+Yy3IizxwahJeNsoRX255IEQc3A6YXccAY0qWh85moVYHDT576ciGDFhSI2QDOn/Kc6/pQ+VJyCvsuI4X3cSB4sEO2oRMQmct6m43d0PrAMt5q6lvM0wTXvzBvPG+v03YuXEugNJVBdbskd8xlde8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099006)(10067099003)(3023799007)(22082099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmxEQ2N0clVuazlmSElpV2ZFbWt3NTB0NFNqREZBRG05a2tKaW81TzdWR2RS?=
 =?utf-8?B?OXl3ZEUzUmV1N2Y4anVJa3FVNUlETnErQWZMY2QzdXY0MVlmQ0NvR2kwYzdK?=
 =?utf-8?B?c3ltUkFUQUx6Q20yRytTdnBQUUl1eFVEb0lKS0d4MVEzM0kzNjVSNW5xZlo3?=
 =?utf-8?B?ZEhpOFpIMnRYYVA4RGpUVmtueVpnL05zeW4wdHk4S2p5UzBYMzh2SDZjV20v?=
 =?utf-8?B?ZE9kd0k4d1kwQmZCMDFRZHJhRWJrTTRmRjVqcmxtZ2pGQVFmMGpYd01LZ2E1?=
 =?utf-8?B?dTFPQnlETW4zcmFtNi9EVmJaV1R5UzBkNGwrTzZNalNBbzhnSzlUZFZHK1NE?=
 =?utf-8?B?SUE2TTRRSVZzelJySkpSLy95aGdaY09PVGNGWDdMbUpyenFET0J4UmxSVUlu?=
 =?utf-8?B?d0QzUHFheGhyLzBveW9yMENscEpOVDhxK1M1QVhhRWJFTXNWNFFmVkcxeExS?=
 =?utf-8?B?dm5ONWsvS3lDUlFDbUJYUE1WUG5uZkhSVGxnUEFFamtsL2FGSVI4eGpCTkhl?=
 =?utf-8?B?SGZ0enM4eDBIZlJWMkZSVVlKODhjL2JvdnYwc0pUWTBCNTFOWE9zaC94end2?=
 =?utf-8?B?TFlGbzQ5bDFVV1E1QysxRHZmVDliQ2VXNWtJMEUvb0oySGk5Rk5ET28rU1Fq?=
 =?utf-8?B?SGZnckU0WllTT0ZQeTMrVDNRK2QvVjUvK0d6VEhTVEc4cjQxY2tMTjJSaDhH?=
 =?utf-8?B?M3VnN1R2TmxEbGRJdmc2UHlqcEFYNnNBZVVKQ29CR204Q0d1bXNhUHhDblI3?=
 =?utf-8?B?VDdMcXRmTFV2cjRpdG5ORmV0M2FvQ0NveW8zSEh2Q3A0UHBzQmlTUXA4Y2Fn?=
 =?utf-8?B?QzJuVCtwYkZQMG4vVkwyUCt0WVpkZllld2RqQmErbVJub0tUdXZyaWIwUkFR?=
 =?utf-8?B?QXR3TjZNTzNMZ2kweGNoWUovbklaZ0RKcFNUa1pkWlR3bUNmSnhZYWFINW9U?=
 =?utf-8?B?NzBWQ3h5QXA1d3lMTjJlSmd4VFo5ZmF4RDU5bC9CdEoyMnNjQWdzeVVoUjQw?=
 =?utf-8?B?WUFhNkdiV3hCaGhEdTVFbDJqclRiWmU5Wk9iT3k2S1pydmZ2K2ZTK1U0ckMr?=
 =?utf-8?B?eGxHNXhWOHk4blIwa3dBMUwzU04rZGRFQnpGQjJ6TGxvbEw2SDFIWVo2dXN5?=
 =?utf-8?B?K0tuMGRWK1M1Q1RWdENLbE96WSs4MW1UMmNoYWQwTTFUSjdBK20wVGJRS3Jr?=
 =?utf-8?B?ejZ6SWwxVHo1NEo0bFk4NTBGRFBzdHJqNXp0Z2FxeWE0K2ZHTVRpVzh4Vnpy?=
 =?utf-8?B?V3VzajIwOHQ5dkd6VkJyZDJ1WlFWUGIxL09IOVByZFpycGhWbHdMK3FkQjZR?=
 =?utf-8?B?SW1jdjdJUGszNHNSQnlBYnVUTGtIeXB6S0w2ell0QkxLZmkzeWRUalVqZmZk?=
 =?utf-8?B?OXVmZXdWWW1idDJwakN2SDRRcGZaUFJOYUdVYVAwTzUwQ09rVldEQXhLWi9G?=
 =?utf-8?B?cHFyZkhDczZnR05wNG10MUNoZzlBejM2eWphNlRlSUhWQTFEQVZocy90QmZ4?=
 =?utf-8?B?TC9iTU80eHRENWRHb21GS2pMMERiWDEvVHl1Nk5YMXNzYk9KZStVckpMUE42?=
 =?utf-8?B?N21PK1RrbFI5b0g2am9rdGdiZWN4V2V4VTVVZFhWZGxla0VhcFVtR2lHaWp6?=
 =?utf-8?B?NkcxdkE2eHkyejNzY3JNMkVPVUVzcm14VXlLbElYS1VEOGg3Um4yNUtBY3Rn?=
 =?utf-8?B?ZEp0V2tqbVF3cGxyYlczM3graEpEdW51a2k0V2FpRTVhbU8rdlA4T1BXYUVr?=
 =?utf-8?B?YzJtV0JNYXhCbS8yelN4aEhXUWgyVVY1aUJjZmFYSGpBRHdyTWFSRzVTT1lU?=
 =?utf-8?B?bC83dlNhbXUvVzN6UmpLRGpoQnlPOVFLcG8wcDgzdXFHUWlITFBERytZM0Nj?=
 =?utf-8?B?QWpPWjNHTWk2Rkd3b0xuRm9tUmNNOTd5dXpYN0h0dm5vWU9hNUdSSjE0TDNh?=
 =?utf-8?B?NVhMWVBxV2IyU3ZHalFKcUNTNXNoWno1VUZCbnY0VHB2bG5pdERvaVFrb1pT?=
 =?utf-8?B?WXN0cEl4aDVGWVZYam1JNVM0NG1VazhWVnBtR1BZaHNUdTBHNVZZWjhsaTFP?=
 =?utf-8?B?bjN5VklZbGoreEtqOW5VdWJ4c1pLVFRHYjJhbTFxeWlLY0R4ODFjZVZRTVIr?=
 =?utf-8?B?V2EyY0RHTzYvRHp3ZnFGcTFOZ3lFMXk5cHFqdFN5WU5uekxyUzNjdjQ1enIv?=
 =?utf-8?B?K1JCazRWdlBCY1VBYUljYXNBL1FhSWpucXRVcXRhMTVmVEw2Ri9ucjlUT0Vw?=
 =?utf-8?B?cFpvUjR6NWVaZWJwT3gxbCtpeXVPMkNlQ0EyK3FLV2JRSmw1VDRsd2dzRUJ1?=
 =?utf-8?B?akZTd1dGSUhXbXIvWk14Z3JLZFpiN0c3RkRZZmF4NTBidGswTVBzSi9oREN1?=
 =?utf-8?Q?ZKTWORdwLmCx1w4QqMqLHMXlol9j04iTF3BrRVlH/Incf?=
X-MS-Exchange-AntiSpam-MessageData-1: eqaHo9kPLkygGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ff771f-8274-4d2b-e865-08df02265603
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 21:26:18.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnryT+G8HB9PygrP4lwOXt+43hf1uw0fgO4ZsIDl5Q8W1VgaYzrQgVpzGrfK1sx72QmszzSTa7VWb9eNiG2ENA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104

Hi John,

On 22/08/2026 01:32, John Ogness wrote:
> On 2026-08-21, Jon Hunter <jonathanh@nvidia.com> wrote:
>> I replaced the WARN with a pr_err() and I see the same issue.
> 
> Thanks for testing. But just to be certain, can you restore the original
> code (with the warning) and apply this horrible hack to force atomic
> printing? I want to be certain that the problem goes away when nbcon
> deferred printing is not active. For thet test you should boot normally
> (without keep_bootcon).
> 
> ===== BEGIN HACK =====
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 85fbf1801cbe0..5806815fa11b2 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -202,6 +202,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
>   				ft->nbcon_offload = true;
>   			else
>   				ft->nbcon_atomic = true;
> +			ft->nbcon_atomic = true;
>   		}
>   
>   		/* Legacy consoles are flushed directly when possible. */
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b03b019cd5ee..152d9ac28176d 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1185,6 +1185,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>   
>   	if (kthread_should_stop())
>   		return true;
> +	return false;
>   
>   	/*
>   	 * Block the kthread when the system is in an emergency or panic mode.
> ===== END HACK =====
> 
> I am expecting that this will work and the warning will be cleanly
> visible on the UART console.

With this I see a little more output on the console, but it still
appears to hang later and never fully boots.

Boot log here: https://pastebin.com/Xe1vmeUj
  
> If the above test was successful, I am wondering if cpuidle should be
> disabling the deferred printing as this seems quite similar to suspend.
> 
> Could you perform another test using the following hack _instead_ of the
> above hack? This is probably a bit extreme since it does more than just
> disable deferring, but it could help us figure out what is going on.
> 
> ===== BEGIN HACK2 =====
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> index aca907a62bb5d..0fb449e23f677 100644
> --- a/drivers/cpuidle/cpuidle-tegra.c
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -15,6 +15,7 @@
>   #define pr_fmt(fmt)	"tegra-cpuidle: " fmt
>   
>   #include <linux/atomic.h>
> +#include <linux/console.h>
>   #include <linux/cpuidle.h>
>   #include <linux/cpumask.h>
>   #include <linux/cpu_pm.h>
> @@ -165,6 +166,8 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>   {
>   	int err;
>   
> +	console_suspend_all();
> +
>   	/*
>   	 * CC6 state is the "CPU cluster power-off" state.  In order to
>   	 * enter this state, at first the secondary CPU cores need to be
> @@ -176,7 +179,7 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>   	if (index == TEGRA_CC6) {
>   		err = tegra_cpuidle_coupled_barrier(dev);
>   		if (err)
> -			return err;
> +			goto out;
>   	}
>   
>   	local_fiq_disable();
> @@ -204,6 +207,8 @@ static __cpuidle int tegra_cpuidle_state_enter(struct cpuidle_device *dev,
>   	cpu_pm_exit();
>   	tegra_pm_clear_cpu_in_lp2();
>   	local_fiq_enable();
> +out:
> +	console_resume_all();
>   
>   	return err ?: index;
>   }
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 3fcdf4b4e2e53..8d126b5068684 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2787,7 +2787,7 @@ void console_suspend_all(void)
>   	struct console *con;
>   
>   	if (console_suspend_enabled)
> -		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
> +		pr_info_once("Suspending console(s) (use no_console_suspend to debug)\n");
>   
>   	/*
>   	 * Flush any console backlog and then avoid queueing irq_work until
> ===== END HACK2 =====


I tried the above anyway, but this is hitting a 'scheduling while atomic' bug ...

[    2.083585] BUG: scheduling while atomic: swapper/0/0/0x00000002
[    2.084118] Modules linked in:
[    2.099178]
[    2.106346] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.2.0-next-20260817-00003-ga0c285a6f831 #23 PREEMPT
[    2.106413] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    2.106440] Call trace:
[    2.106468]  unwind_backtrace from show_stack+0x10/0x14
[    2.106596]  show_stack from dump_stack_lvl+0x54/0x68
[    2.106714]  dump_stack_lvl from __schedule_bug+0x50/0x64
[    2.106815]  __schedule_bug from __schedule+0x9e0/0x1348
[    2.106897]  __schedule from schedule+0x2c/0xf8
[    2.106962]  schedule from schedule_timeout+0xbc/0x114
[    2.107049]  schedule_timeout from __down_common+0x14c/0x3ac
[    2.107137]  __down_common from down+0x4c/0x60
[    2.107213]  down from __pr_flush+0x294/0x3d0
[    2.107284]  __pr_flush from console_suspend_all+0x44/0xc8
[    2.107342]  console_suspend_all from tegra_cpuidle_state_enter+0x18/0x33c
[    2.107406]  tegra_cpuidle_state_enter from tegra_cpuidle_enter+0x168/0x184
[    2.107470]  tegra_cpuidle_enter from cpuidle_enter_state+0x80/0x610
[    2.107533]  cpuidle_enter_state from cpuidle_enter_state_coupled+0x3ac/0x400
[    2.107637]  cpuidle_enter_state_coupled from cpuidle_enter+0x3c/0x54
[    2.107736]  cpuidle_enter from do_idle+0x150/0x340
[    2.107809]  do_idle from cpu_startup_entry+0x28/0x2c
[    2.107861]  cpu_startup_entry from secondary_start_kernel+0x118/0x120
[    2.107959]  secondary_start_kernel from 0x1160a0
[    2.108085] bad: scheduling from the idle thread!

Cheers
Jon

-- 
nvpublic

