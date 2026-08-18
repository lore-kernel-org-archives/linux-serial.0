Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564144B048C;
	Tue, 18 Aug 2026 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034070; cv=fail; b=o8jj0547+0Ow5FXJxw/AlmjJypyCS2wnjwKZAUwScFjE3C4I2bmwYlmgSFZ5lrkUBaRqxmYphn6Usl3zherTR/12IXgDpIR4eghhPLjGWAyCmW3cpptHHVP+Q70pUQWKjjEM5PbR43iHb0pFC+UsC5V4d16A32MH/ZiwRVg5Jak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034070; c=relaxed/simple;
	bh=RdVH4MLJP4lZ3fa1vbcGlAkwOMIrXIvdpVtCYwYxupQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jiZ9qRspCyTI7WsF+s5uaLAJ2PV0GUZ0wpoWZlqs1iRZ8lwZXSQ6ARa1LPLZlnHpZikS4bbHtPW0XXts9Qp0moTwjlYDu1HpwrxXjekbwcJUCXdh+o8yfydvCB4a/PNfw90lLyaS61jArXF7xgHlg2E9RjlWI0NVJPDPt2X3g7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2jxAkSz; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2jxAkSz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0JVw0IGsW6p+tFZPvcc/1Je7s0KWsNdmntNZYCzAnT3RxnNSezBOe8i1rzekbQECL5ZtKUkuIFKtj3zhpv0rrlDVYJ9uimzegau6ya6hnoJPTYje6dK8uvQs58CdvVrxfiTD/swfKuhNad5LRXVOei6ZO1Av1+s7ZQRL+IAu3L/leZmGvtO19DBkD0EZklSNF1m/KdMyxaVRne9NjA4tdHAN7uBIvMCEN3oLu/EUM9edgtn9C8BOPRmHLCF/sUSbBM/zRBBUs0hKCUvPR3jPs3FE3sUuzo6StrOMhybTEwS9W8NIhsBtthxT+XZ9+seOMfoPVqJSXuCbQ7HKJs+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0/5t4+pbNI4AJ8n3w3QGu53wYr3Qx9prhPwQGq8E2M=;
 b=iF5/v0rLDxW61oAdasgfQ9IaxvzA0i9FvSjg8LTNy3sJWJDyXGLZ3Ef+ZP9PfNXCGFReD2E61Jfs0Ih8iDFny3iOxCCktYMheEE/Pw3vnHw5XxsqDybBh5/tq5YDO3azS6Li0I1HQpm1hQ2aSnuY0kBbrx9kQBfj/g0NVeMgKAHp4tapv9YJlu6gXSp8IJ8sdf/oBVEc2+dt+7PiRuDS2M6cLOyPoqIFYwIuwRMiC6SD8OpO+KiOev0vV8ZHt+Pp7ocgX9riTYmrVH9cxi4BZkXzkMe+K3/2t9RnVhtTBY7dKG45zwQA1WlERnfOVkdYNhLfWbswG63lPD0FkaCeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0/5t4+pbNI4AJ8n3w3QGu53wYr3Qx9prhPwQGq8E2M=;
 b=a2jxAkSzsaPnaCKsCSG0The0PvkK5zY/iA1zBE5KdKxFH4UXPawgoq//JgieCPgzFdFtrdoyNDKeLKyQZ+vnsA69e+gb7xTbr4Ri4fChD5UZPiL+0hjvIBFaKfQLM3tITStJTAZjtngai/VvtFMavGyjjUHbtFFu1kKaB6Ic0VjL2Pi6JhdMbjM0yCVzKSAaMz1Fx3VBdnEENtHtAbwVcycK1HJfyKe6yQ3/tNtbUZXEzQjtPzGAN9ouUZKdX6hTXiHRl3BUVVBtkgrKQj0Vb/0hU7g2eOOJwaW4tzm1u+EDk24njRH9KjG1BGoOlHHwRNoMFaCCSL+G5P7V4DLETA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by CHAPR12MB999226.namprd12.prod.outlook.com (2603:10b6:610:2ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 18 Aug
 2026 06:21:05 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:21:05 +0000
Message-ID: <360d4d12-2755-4270-96b9-88ee152d69ba@nvidia.com>
Date: Tue, 18 Aug 2026 07:20:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
 Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
 <20260724103654.133654-2-john.ogness@linutronix.de>
 <3023d7d7-c8ab-48e7-a0e4-e18cc4ea0b9a@nvidia.com>
 <aoP4Wzji7w1XTTpI@ashevche-desk.local>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <aoP4Wzji7w1XTTpI@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::10) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|CHAPR12MB999226:EE_
X-MS-Office365-Filtering-Correlation-Id: 812ecdb7-3cac-4449-0b1e-08defcf0e20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Sb1cdfrP6V6dmrv0c+VUBWGH86FMq4vX5R66F6QX58Xc28ui02KmBJPiWN48BLdqzBhYWo7whuhtoy7sotOPs0vFD5uJkVkDoRya5CqmXTkpF6mVe3b1xsRdAr/75jAFImRsqEh/LWx5KeszeB8YpiAsKniBLda/R4qolIzVNzJAZovbmANioXrojQ24cJKFThM5clpHPrJZVjCpTQRDqMPqNLHLiHAEIQ/ovjLeRq6fUaQ7e3aGsZH+Lrw/IyL8DSNh3WinP8TFR60zoC605E/I7kBHUCGRzkBUbMJP9/cJiGp50Zy4GRF8vXyfzmFBV4+3nmNMiBFkv1OnitlgbPr0UV+FuRCrwTZDIy9BMSw0yf5Q5ZYwy4KBUW7EQSrrpYJwkhGWqZY9Ml1m9sbJAXeFZrXRLiHb4Bxjb+hoQ6hfDQDDRZJ8O51mH81TkX0t5uGwCSGYwQKh1iOeAdAcKQkpFbrXFk768DZpqd5YT6KgcjqnN3K4JRMGz05mSg/P8x2ZeUR7RKtczcEG9YM7pYaeWiIWP3nbGfzsbLkyj4sf8dddRG5WJ+icrdeI76ID9AE3Y6poXwnfEFWdxMF9Iswfs7dAGb6vnrTWq7CMC4HvhfjsiVwDoTzRdqKW8cZm1SLbEApf9LiPZrVVpERqoPnRBkpxnPpWTm5TE1yt32c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0N4VGRZQTJ4MGQyVWp6citkY1BtOUxpZnpiQkJRMjRZWElpU2RRQXFZL2Na?=
 =?utf-8?B?UnE0UmxTM0d6ektOK2lKTzluOFNhSm1oaXVscDRZODAxSEVYSjI2MXpqd3Vk?=
 =?utf-8?B?QTZubUZkNGdERjFtcTY0ME5QMXZhakFwMHU0TXpha05Ua3ZjazlKUmx6d2VI?=
 =?utf-8?B?OGxERjVrSHo1WVZqeklZT0UxUEY0aUVuQWN4cGdTUzJkOHVDQ2QwUS81TVlq?=
 =?utf-8?B?cU5WVytxRWhQSWFDc2hUYlpLOFhjMXJDUnMxUUFnUWhmczkvcnVYQ2hiai9N?=
 =?utf-8?B?VVYzT25GWlB3cmI4WUtZMGx1ZVdJa0dvZFJlNElLam4rUUlrYm82SUE4TEpo?=
 =?utf-8?B?TmZ2ZDIreW9wY1c5SVFTdFRodVdQeHZXcmNvVFUxOGVCSk5lN1M4QTNkdTE2?=
 =?utf-8?B?N09CREx3SXgxR1lBTU0rL1k5Mzl1MHJNQ0RWVituY0VXZWdMenFreThqWnRx?=
 =?utf-8?B?c2JKTWg1RkRZUjdkTjhnNFFEZkJCczNPWjJYVFVib09yVmdKcGRJOFkrRHFu?=
 =?utf-8?B?T1AzT2ZFQUZKa2dlUTZyMXlLWWdOL1cvWHFwMGYwbjBoeit6Z3VJN2tqdVlB?=
 =?utf-8?B?dmg2SW1tM1k2Q2FrbkJ3ZWNqUis2Yll3NkczVlMzZ2FEU2lqK1VEeVc1YjJy?=
 =?utf-8?B?bCtxRzJlam1sbGhvaUJkM0JncldMdE5YazNHOERqQlNpNlYyK21TeDM4UFow?=
 =?utf-8?B?dG1veUxhNW5mQ0lhaVMvay9wQWhUWGJZbmpKVjlzdkVZcFpreXMwdTlBTEFo?=
 =?utf-8?B?Ry9qdE8yT2tyekxGQVAyUThTZy9oWHNCTGxVRmRMUGNyTHVWWFEyMloycWha?=
 =?utf-8?B?b3dUR1Y5TG9ROVJnYzRhaEhnOHNXNzh0aFQ2QllBMmdHYWFBNVRWeDdLVzM4?=
 =?utf-8?B?RGtpa1pOcDhvcVBELy9nNEphYjc4U281cVdsWjhIT2sxd2lubGIraDFZUkNZ?=
 =?utf-8?B?Sm1EaEhPckRTaTM4Yjhyb3I3SmZuanJWL1l2bUJmUzlrUFpyYXo0Q2d3N2E0?=
 =?utf-8?B?WnI1M0JlaVRjSGo3OG9LbjJ6d3dTWjVJcHU4ZEZJcys4QlhkL29EenVFeXli?=
 =?utf-8?B?M20xYjRtQmVUVkFBUCtxaU9HQ0l3NzE1S1p1RWYzcmpCTUMwczJRbjZhUVB4?=
 =?utf-8?B?bDduOGFGMmdTSE5USUR4NzZGb29qQ21QVVVQNUo2ZFM1a2d6cGloRG1VUDU3?=
 =?utf-8?B?OEgrMGdCWis2bnJSa3YxcFYzcXl1TmE1RmJZWW82d0VaRDlGdU9ZQkF6WDZi?=
 =?utf-8?B?VDN6YnpMdjVrZ2lOalVpMkpSeGtGOU1DMTBBcjRiVVkxWGxGQ1ptN1lTTU1I?=
 =?utf-8?B?SWEyelVOaXQ2eGhISHYzL3piWjJWZjlERi8yVjUyYU5JQ1dEWEZ5TEtxN0Yx?=
 =?utf-8?B?emE3Y3MrNE9PeEdGOXRXdVRLaGhQZm5GRTlOWjlKaDF5Ylo1SXoxYkpEd1hU?=
 =?utf-8?B?akVvUzNtS0hha2d6dzhpcVpiWXhYTTRFRFRGbThETkc5RWQ3WnJybzQ2cThP?=
 =?utf-8?B?bkk4cTVjY3JZeHRVK09TL2c0Z1J0Rmp4ekpqeHpNMFlXekJna2JTZVJuR3k1?=
 =?utf-8?B?QmxMZ1JGeTJGNGorVElLSHJzYkRFcnJDcE9oejRxZTZJYnkrYkliRkdFVy9G?=
 =?utf-8?B?WjduOVA1d0VheVoxWjhDQnBsdjJGb3B5c1FmUUlmUll3WGVzb3VERkZZM2NJ?=
 =?utf-8?B?L09jQVpZVnA1NlJGUFlCMjJVbHpuOGVaVUQyVC9yY01qUEhoVXNDbTZIZXFa?=
 =?utf-8?B?MVdmTXMzaGxZeTVOOEZGQVYzdHkvVEVrT3VJUzU4Skg2WGhlSnloN0R2b1Uv?=
 =?utf-8?B?MmVzNmFwNGlGVXN1VzFyYTBMQ0p4VE9rVE93R2t3MFdNQkF5TjZqS0hJaHln?=
 =?utf-8?B?NFZheUhsYnd6MzBrbk9pdnRmb1VxREgvNEpKZjJGSjlPVnFDaUR5Sld1WE5w?=
 =?utf-8?B?TnJUUDZ6NnIvYXQ2YkIzL3AyQk96SUxzdEhRYjVMM0lpdDltTHVUaUpaT1NG?=
 =?utf-8?B?ODNKMXNuYkpuaWxpek4yV0FYMTJxeGpxWEpCbWRWQ0dGK09VdXVJd3ZWMHk1?=
 =?utf-8?B?eFJhUG5MeFlxQ2xHZC9QY2xlTmRES09iZ0FwVkM3aEF5SFdTZmpCU2dPMXd3?=
 =?utf-8?B?Y1AzNC9mdGY4TTAzT013UHV5VGp6WW1POTYxWVFRQmNNSU5JbFVTZTk1QU5j?=
 =?utf-8?B?VkFmby9vZXVnOC80MTJXaFdkYjVnTXNpNGdtWHp4Mm9LMmdxcU1HenN2SlpN?=
 =?utf-8?B?cUZ5WWliRU9vL1RROXhpbjJQQ1RPR2tiejVtY0pQTEcrOUZoL2tYV2lJT2NB?=
 =?utf-8?B?RnhBQnU4RldQdTF0U1RTSTdmR1hOVUNsR2wvRHRNVE5razFVaS9Dd3VzdmRK?=
 =?utf-8?Q?nG9eCNu1GXwfEgQsxLRhiUF/sQPuLw6gYirxM2FGjWH1l?=
X-MS-Exchange-AntiSpam-MessageData-1: DPYxCh+FEsLg8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ecdb7-3cac-4449-0b1e-08defcf0e20e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:21:05.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqKN3P7eqo98xJExwLjJ+LtmQgc2uR9FDP22QZzVhwPxrhoZgeYSsfb84Zf3xqaQMSQ4C0IszF2F32poYxD4qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999226


On 18/08/2026 07:14, Andy Shevchenko wrote:
> On Tue, Aug 18, 2026 at 06:32:12AM +0100, Jon Hunter wrote:
>> On 24/07/2026 11:36, John Ogness wrote:
>>> Implement the necessary callbacks to switch the 8250 console driver
>>> to perform as an nbcon console.
>>>
>>> Add implementations for the nbcon console callbacks:
>>>
>>>     ->write_atomic()
>>>     ->write_thread()
>>>     ->device_lock()
>>>     ->device_unlock()
>>>
>>> and add CON_NBCON to the initial @flags.
>>>
>>> All hardware access in the callbacks is within unsafe sections.
>>> The ->write_atomic() and ->write_thread() callbacks allow safe
>>> handover/takeover per byte and add a preceding newline if they
>>> take over from another context mid-line.
>>>
>>> For the ->write_atomic() callback, a new irq_work is used to defer
>>> modem control since it may be called from a context that does not
>>> allow waking up tasks. During suspend/resume the irq_work is not
>>> used as this has been shown to cause suspend problems for some
>>> hardware. Upon resume, any pending modem control is performed.
>>>
>>> Note: A new __serial8250_clear_IER() is introduced for direct
>>> clearing of UART_IER during console writing (which will not be
>>> holding the port lock for atomic printing or KDB/KGDB). This
>>> allows restoring a lockdep check to serial8250_clear_IER() in
>>> a follow-up commit.
>>
>> This change is causing a boot regression for our Tegra20 and Tegra30
>> platforms. Reverting this on top of -next fixes the issue. Previously with
>> V5 I did not see a boot issue only an issue in suspend.
> 
> Wasn't v11 applied and not v9?

Ah may be I replied to the wrong version. However, I am testing 
next-20260817. So whatever is in -next.
>> So far the only
>> interesting thing I have observed is that if I add 'keep_bootcon' to the
>> command line the board does boot.
> 
> keep_bootcon defers driver taking over, that's why it works, it uses just
> simple primitives instead of full-featured driver.

Yes that makes sense then.
Jon

-- 
nvpublic

