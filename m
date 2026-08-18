Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525437C0F0;
	Tue, 18 Aug 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055567; cv=fail; b=oH/CHLXWEcOMiH3paXii/HXiE1EGtM6JpGN5CDybVQhSykJsHP9fG0jpT2/OfHLKyfFwrkM5wZZyXTLCtRXTQ4N4RVyEhbDQYgzgeZeR2cpZcIBV5UM8UyotinPPjN0ViymvCajdYD3D7EVeDlkNTl9rWATZQ6RjNuBf+jnXnZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055567; c=relaxed/simple;
	bh=tpEo/dKRfs6DeIz/dLO1flG13ndShHvcWhwyvdRTFCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbXIqJoVt4yrchhA7bZuFQtgUr8kSt1fRvpQFY41Qop82lE8y2BQr9/KRDl4emjan4MApF+GM8LbPCcnC49B5MY4cjm2sALxl9jlQfvjozbuQThewTd/q5cjpCpFg8irHgL6YhUvNluly2rJwXyrhepn8JD5nbK5EFUB63RA1Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aVwPEStp; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aVwPEStp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aY5Qqqq+P8330KQa53+Qh3vYslhTycD+6zB/fOt8P6IFXg2xKBJjzvO/SnTwEJ/c9F6Ua9255/jLGPiEpgMdJh5OFVd53qBuv4CK0aAfVFX6bDGe46dApNTDE+J9IWcj21yO9JDIF7x7BdUAqqz4Iw+5eTvZ7rxQvfSgas9gnFCGzZx+6wrPN6StNbBD2bMUvXoBwTcxOMUX3SLTqf+itLeiU+fccf8bNSrYtS2nxhv4nKR8lcqdsL+SYjLXo0ot3bMK90s97vhpHjLb7Q8Rx7HPHhoebUMx9wcOuYSB20WzrnZ7b8TqRnRQAtYu//QiWVPWwGwX4tcYWHxUWZKyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivJBnaxkmBGlVTBfQ4q8p6vZ0tmkfToU4RXAyJo5mEE=;
 b=Cm17PRCm17Hy4wIFfJXhNgRbWT0QgXNneWi3EEail8wiLnC/Nf7eIGNilmiEjGJxDrcHXWZFFr+LdFKJzhd5SNzijlbPeugw8rvgxXm0rIctxIySKxWDaOVxr4FL9vFtuqndnwjmKdfCKh0cEvhVyHw44eeCWF+pdYh+jVssFRDJ/yogLe7LA5PYox/uwTpWx1OrdLZ2QUnKygJyYHiWyF0k8x1LkBsTJ4THVfgGiJuFxJ7vwo0x6xCerSTIp/r6CJHnuS/efYOdIAurfF36ABK62ucTIb4LBV1APEh4nR+ZWUvHxnRggees6q057q9JRw2pAWfBjfK+ewwn1LfVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivJBnaxkmBGlVTBfQ4q8p6vZ0tmkfToU4RXAyJo5mEE=;
 b=aVwPEStphPH/eW3C7pd46CCUBi8eqP3vY3+4eYlsnxsk1v9X3DnUbYDsaAyJONLSUjt8472MyVRNL0G4uPFHsQ8MdgPzkMi8mfhT5ZzmTu9P1OZOSh8si6F06hm4FBtLAq2dNLazskt+9oLGFN7Tb1QdDcgtlZw0+gZbMex2/k0o70HNMwK79GimHjrRfHy8iLqx4iIahEZi1znSwE/cqDU0ISItuvmetgN2hoD3XInQyhPFBWebycM/6UjJdFAlFVmNQkMlJ638Dhdsm+Pjs32W3DmSwzrbkHdZ6RMpFeTtNbMzpOFrsdbPpyw11aRNor7xOYiNzzO0yi4QOc71Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:19:20 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:19:20 +0000
Message-ID: <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
Date: Tue, 18 Aug 2026 13:19:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
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
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <aoQPFC7d8mSuNZMh@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 7079b623-a2b9-4c12-0a4c-08defd22edb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|4143699003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	NE+54HFm9bWHSOm4t946PiTh//z1tXn8DzavUGLRMvXep/G9I/NzmlolmRS1/guFupHS0VRG7rDdRTn1+4J5dja31Qmc3qYUDZ6txmVJQsAe4U9DxsZfLFanHj1N3kQoNvgrkE8Y8r7x2lkGPB/BOq0S8vT/rwW7MsZH7lrGusGA26z1GDZcJIi3hb/I8dsTBcEY4/+h/66tXzHPJbR2P8PYy1AnpCo4vJxeHWYEudu27ua90AuHqtCTUGsDjEWHC23c09X2Gok63dbw65dk6WVB+o3ds8FzFiksAtPSQGz3mf2ls+i4JhYVf9PD2FOr/9RZbgZmHjPHFQLF88IAfeRYMh0a3z4UeQG1s3hzizK/0tsyeWlhlzf0WMs8AirhHvwAUbcizHETiTPbo3ji9ZsXZrHkfVlPYalbGoR09bAZ7pI+dg9Sk6jeohEktpu5JlbF46BBQzXxG/tqIqNZ8511kRWYTaRXwUD0VRQCl2xpNm5GSwhkvIXtFXeelTHyY9m5fLJVwjoHwAftB61Lr2jlgIn3UoX/BcqjVJm/2dM06fgPMokjx9VWuEsF/w0NjxRoW0BtLZNZ9OpXxrkZfSdyu6FqsVfNiVyGLzvCfBC8lM1GrR8T7CIrOfrIZizLaPJ+dVJsDJEsvI84+S6hTvDPpH8wOS3r+YTjqrNzP/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjgvdG9KVHBVUGtkdzgyVGszWTBmMVlPdFl5U1htWWlEYXFOR2VrMDE0Smln?=
 =?utf-8?B?TmR0MUN2a3NQcWFocnNMMnVhTDlXdWY2TE9wbzN5K2kvTHdJL2VxRUVFSGpl?=
 =?utf-8?B?WEVEWHZvS2M1VmYxVlpmRFVBQ0RHOUpNeGhTTVo4TlRHb2wxMnVpR3RxRFVr?=
 =?utf-8?B?Ti9aUnI2K2l2UFhWQ1dTUDgxTk5TYW51dzFHNzdQS0RQUFErOGdJOXNJRlgx?=
 =?utf-8?B?YUhoL0VFVUZvcUtrYmtrR0g1ZFE0bFpVNE1aZGJNTlRtcy9DTEovZ05YbWI1?=
 =?utf-8?B?ZUtiak03U09qcExVd1FPa1NTZzNYUW9UczBLdC9na2lrQ2dTTFRBVnZScHBl?=
 =?utf-8?B?SGduamNRZmxoWG9CaE15ODNYblMyd3lObWZNa2pNbERmdEFrb2tpSjBEUHNh?=
 =?utf-8?B?SHlPMHBrRXNIQWxlR1dTbFRJeXBGczZiNXBaSFhIbk90SFZSMmxVdGFBSlI3?=
 =?utf-8?B?Q3R6OEdBSW91VmlRV01peVR1OWhzMkExeGZ3M1ZsUDU4OWtUdzdRRHBOUG9B?=
 =?utf-8?B?WlRGTEJBVmlTQjZ2YlJ1VjhDbklKdGxhenR5ZHFCVjBFRGo1c0pBb2dVZnVS?=
 =?utf-8?B?R0EwOGluQ3YrWS9jVUdscEFtZlkyaUlrQ29xbG5wOUZDWEp0S3k5clpzK1d5?=
 =?utf-8?B?T01Vb1ZYR2p6R2FXRDd6NDZ6MjFFQVNBWDhqNHJVaUlkVEJiZGhLYklQSlhy?=
 =?utf-8?B?Y3dHeGgwVVhlSVJQV3FxSTNxQVVMUlh3bTlKRUNEN3BzakNjbjFhbnBsQ1Zj?=
 =?utf-8?B?bWdMb0lpWmpybTJPTFczeXlRVDdXYjVjQXViOFo3NmgvZ3R4MUdyNDNoMy9F?=
 =?utf-8?B?TCtEZ1FNbW4yZFFWbkhxcWFJRXJmWlZLcGJQZlcrR3ZYUjdBRjRBWmxreHps?=
 =?utf-8?B?d1BYblU1S3Vla3FzUFVTeXVJZEl1cE12TURRMWJjMlVsSEV5N3dEdm80Qlp6?=
 =?utf-8?B?QVFuRFBSY3hpK0RnZ0RtWVQ0MXlPZ1ROdEFNT05nRE16SEcyYjI3ZWtLVWxO?=
 =?utf-8?B?UEF4Z1BoQWtzRFJyMXN4ZmYvYk5nRS9NODhNR2drYUJUNVk3enlES3l2R2pN?=
 =?utf-8?B?Q0hQMjl0SzMybVk2RmRici9DektsWU9xKzZzSnNQMTI2VXJnNWJUR1R6WXdB?=
 =?utf-8?B?Tkx4MVozY3pUMndXZSt2d0JrejR2dFdRenE5SmpsbWNUczBtNFdza1NFV3FH?=
 =?utf-8?B?VlZiOTVrN2xnUms1cU9QVUNLSnZGeUwvZU9KVU05djBiVWJIQmVWWW5HaWoy?=
 =?utf-8?B?UTNMTnF4aUhzYnRxZVZvL3lVWmp1OXFTazA4clZIVzZvU3JiQkZBYkV3QmFK?=
 =?utf-8?B?NDJGdU9kNFFaYm15V1VIR2g4ZS9WM3BJaVY4NVR2Q0tHTDFWR0V2cU14TFF4?=
 =?utf-8?B?ZmV6MU9XeE96QWRteUltWFl5UWZjTmpQMytYMVJpaitSUGg0Y3dUdkk1SUdU?=
 =?utf-8?B?RXR1QkVTVWdaMlR4bzd3NVM4UGxpcUtKUFR0T3VpQmpQMnRGS0x0TmtFRVJD?=
 =?utf-8?B?N0lHbmdxNkNqblZZbGtnZW4rbDVhdEsxZElBeGFMVWJJMlNBWEVBWGVzMUlY?=
 =?utf-8?B?V0ZVdWw2cm1neGFwZDZQNTZBRkdBajRZdlI5dU5NMFpCZUxvdFNkQWMxd2w1?=
 =?utf-8?B?WjQzOWVIeGh3WnY4Mm5ZaXNhYXEvTjMvUjMxQzliVFJtMzdvMkFYRm5NV1hV?=
 =?utf-8?B?MGk4TUJ2TGpMdFhMSkg5MzBMSWFFZWYyMFdtU3V2Ym94eTdERDNoT0ptaXVC?=
 =?utf-8?B?K00zWVdiQjdJWkorTW0vbUQva3BQeW5SVnUzM0l5aTI2TE1zaXNhRm5YYitO?=
 =?utf-8?B?bENITGhBK2l3Y0ppTXI0TFhuYk0rb1dGcWdsWmQzZ2lIOW5PR1gzMnVjQ2V5?=
 =?utf-8?B?VnVwSURGd09nOTdySk9jWkxmMlE3dDNBa00xY0Y4bzhNdmZNbWF2UTRBYkd5?=
 =?utf-8?B?bVlJMDVLUEFzSnVTa2o1N2VKYlJwajlleUV0VGlqSjFQckIrMEtaQ05KYUxI?=
 =?utf-8?B?YmZBajRBVUZRNVJFK2wxak9yOVVaWFNzZitxdmpITTNzYXptQm9jdHVKMGQv?=
 =?utf-8?B?bVJJNi9QNklZVHdmQk1hQ0tOU3Q2djYvdVY3T0Y3VzJ1Q0N3bW5MTkNRMTNT?=
 =?utf-8?B?UmxnMWFwUjEvR2hmSDh0L00wSGJQU1ZhLzlQWmgxYnNIZDFoMGc4aldzL0pY?=
 =?utf-8?B?RGQ4eXNFbXFRb0wwOUJRdVVpU29NMTNFdVJSaXBOOGNocXlOcXp1bllHWlJZ?=
 =?utf-8?B?akNpRmVOWDBzbWpGWHFNREI1TmVBRnFpcDlFcU5uMDVrU0hDdkZJSWVNdFhK?=
 =?utf-8?B?RURDWG9MdS9GamhVdi9OUU5tLzZzSmtvNjd6UjVSZzlML1N5UU5XUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7079b623-a2b9-4c12-0a4c-08defd22edb0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:19:20.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7DGHFKMq4mTXOrBN9rSVf2RTyaBNIoLfmNNphJicV8omFrXGcmFT/eXnbCYEsypUSZ36HSJ/i38rCgj5EaOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

Hi Petr,

On 18/08/2026 08:51, Petr Mladek wrote:

...

>> This change is causing a boot regression for our Tegra20 and Tegra30
>> platforms. Reverting this on top of -next fixes the issue. Previously with
>> V5 I did not see a boot issue only an issue in suspend. So far I have not
>> had chance to dig any further.
> 
> Interesting.
> 
> Another clue, mentioned in the v9 thread [1], is that the boot
> regression does not happen with v11 when "keep_bootcon" option
> is used.
> 
> The "keep_bootcon" option causes that the boot console driver stays
> registered even when the full featured driver gets registered
> later.
> 
> The most important effect is that the printk kthreads can't
> be used as long as any boot console driver is registered.
> All drivers need to be called in the legacy loop in this case.
> There are two reasons for this:
> 
>    1. Boot console drivers are synchronized only by
>       the legacy console_lock (console_sem). port->lock
>       is available only for the full featured driver.
> 
>    2. There is no easy way to match boot console and
>       full featured console drivers working on the same
>       HW.
> 
> So, the regression seems to happen when the printk kthreads
> start being used.
> 
> Jon, could you please share the full log when "keep_bootcon"
> is used?


Yes absolutely. You can find the boot log here [0]. So far nothing 
really stands out to me but let me know if you see anything.

Jon

[0] https://pastebin.com/FhQVSqfy

-- 
nvpublic

