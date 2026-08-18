Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164C330D24;
	Tue, 18 Aug 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034327; cv=fail; b=L+/ihnkjCVOsku4/Y/XQpAAq1PpuFjV0cDRyQSYFlpIRki4m8wozGv+/kvNpIZFETYmndC34BnOnDkJ+DvpHS0CygBd4SieI3Pt5EP4TGC2QzI+UFyU7Z5UpzdSG6tGqyrpSste86JMQtN8JhcHbA6j78EJxDZ6nrpbgop2Bsbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034327; c=relaxed/simple;
	bh=dPSJE9Bh7Y9Luppe63UTyvJhP1pTL6vWSGf/mZkieDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLbDa9+zTFhb3FjfCSUtsfwYg40NLCuQXptk/oBMuz1Y4rEomA6dOzBuX9jzoLp9BoKPwGQdaDw23bkdvhM6UYMWo6lW6i0tYqQVro47YdRS1ZePrcRMp6tS8y8KxbIDlmKDpmcRZaKHFTR8ZUKErxnebFQJW6uCugSrfnuZ4YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nG8WQpJu; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nG8WQpJu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSs3bp8v1Odp3fZUb8ViJEz1nz8ycp+zDrEHVy/yml2Wjdc7be9i5XkPrJenSLGdK1mwdqTYqNhU9aIi9PBfzsiI0Gy2ENn1iNesFfyX2lOMU+1pP2aW43Ozi5VCPoy/2kbVhh+dEMiFxdA71axswp7s/b7fy2felc8z72JFZVqRrVNok5m6uzGbPPKDLE7x7rxBjygfLmZGWrZAN1KSgQ9kKJ0X0nHEKV+Sl00OJCSh2oevRKqkr+6noQ3VKqu+0iITI00VJkHEKnWnq49tNJ9WADQLMaYalvLDGwJf8WuVHZbVigL5COd3IoAEB2TQ3Am/aeZqmKaU2jvHcEUZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N74ggy7HR+ChyliIbaCYnyQwQgbAfEnUTtIwx2m8RW0=;
 b=Omtr9LJYBRI0U4UmteHlPHYtFaMNQLzfQE+nVpHRoyP0NirjTv/as3FdpK32mv85ipuaSDHUQyR4nxFoQMEGky8aCho5t2EXVKPnXdwQ+OMrORlvsa+O38XSlcXFZyy4llg8kTBteB/cr6u+GakIzFQLYkw5sPsnslUzH0IZbzIMZwIQiqo4A2mDBk5lRnfR1gCwZMx/glIwMGdcQjzUaricAyShuHawpKszyLnraftRPgktLojVO5P3JNVaBd7cwnqKdmcs7axPxQLUtF1XbBGmKbSqo+lI6JILH4R5RQoh2Z99Sz/E9KlbxxVWcOMx9Ez9WmKbTAGsG8er29QvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N74ggy7HR+ChyliIbaCYnyQwQgbAfEnUTtIwx2m8RW0=;
 b=nG8WQpJut/oq+rBavJZ8BSzhcff6zW8dr+qS9s1Yz0vmxtLTIx7bHaduSDXWriFJWtDP8dCMOeld/uXbEjRpAWn8SBWBSFE084CA+mGXw/GgXIAApzG6AAnh8NZOWG+hd1Xe1IueChGCCQt8tVPhmNH5VAtDqoZBRzyq1C+96U6jck8ClmT29yDwgxWkYaKOvE3OarkTCMc85hZaDFrVFsmIkvEno9kF9+A8J3wgZ8syFKzxUXtCu65xB5Wl7M6+DoMXLTr/9NUi89JaFZs9c1k0mAQhdHA0vu3MxEHJPTO3upQ9BLsltNsi1T1AnnVySZOJ6jpdlGN1ZaVfUqiefA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:25:21 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%6]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:25:21 +0000
Message-ID: <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
Date: Tue, 18 Aug 2026 07:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
To: John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Petr Mladek <pmladek@suse.com>,
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
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260729120439.281252-2-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::8) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a859c8-914d-4a26-12c8-08defcf17af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|23010399003|366016|56012099006|10067099003|4143699003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	xlUnLe/XCwQXL8jFPihURC+McClwnAaUuyyHTr8BsN2wJAQvQpyj0yUzcMwrwd9CfPGcZjsA60m8i9QA4w/k/OPQcYoLgXoZD/VMa5K2b6uzoDbo/NJtAJPMbbWznC953evTpmnB/60W1IXbHbru/kInhe7i8noaRV0hDwKqrNLC2/gSzcbeqYR6nSMfmq38JxgoAjNTWiJDw/k7PRW1SYKd1LHU8hPqkwCZlEu9/ISRTJKeT7b1aeDB/kDzZeS5TNXkxwzL7Bhdwqrii8z927T3qGI/AJvc/fBzGeAQjMHqvHG+Vy3UFIE4td3yXfJnAZxoi20HXCnbdPWGTwzPonqQRvFyAWLcAXZRhGlDWClnDkbjE8JP/AM0ibvXY5eaP1zY2oVq5B1KRZhrZ+mBT093wA1P60rculWTA+qg4MIeP3hfDeHRRS3wHk1fV1JXVOu7OhonBlrxcICZeWP9ZKVSjcN7ITl2rTvCSCuCScLzqZ3QD1F7ptrCdRoVDwvPllh+SuMkNnD0gRkkfpOf7dxtN5I7ebeipBTfgc8l9++pX2ns1Ewpk1N8aG+LHFEoGSXeSKk2mp9bYbpcZC6Ji6jfy8VPBapFBDpBQLgLSI/onTlQ/CsRxROlGRWoeuWftLmNwrAaFmYb0Qzq18VoA++3n5cy/udNLW+6lYtg6Bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d00wcVROSU90QVhHVWZyRjlYUHpuN05IV0V4ZkVWb1FDbC9uazhkZXpJYlVt?=
 =?utf-8?B?bjdzZ1ErT0VianNUS3VkMFo3dGtiOTBjMEFrbko2dkJuREtUWkRxaForWmZK?=
 =?utf-8?B?dW8za3lleXRlNW00R016Z1E5Y3dOYUFEaU1JKzIrMFFhQ05TNjRmNStxYU1P?=
 =?utf-8?B?RFVWckpOT1lLT2lTWTE5UkJPUStZdXExQk0zR0VQR2xmVHpHOGM1SDNMbWFU?=
 =?utf-8?B?d2pSbjRlWWF5UmlENCs0R0NqVnpYQURYWUVKakt0MWppZFplRXFJTkR0UmxS?=
 =?utf-8?B?djRzUUxZL044bXRNTzVpdHZlcnBtYVBWNnVTTWVqbzFZNkVzNERMSWE5amN0?=
 =?utf-8?B?c25MNTZsOGlnZ1BZc3VGb29qSzV5eFF0bElBK3FvUFpuTXA3SmZETUoxVFhV?=
 =?utf-8?B?ZEFPODAxaGVLSUxLR25kOGxOQkdZU1E3TDl5VE4yRmt4cWVaU2VseE1qNUVx?=
 =?utf-8?B?MkdCK2dZekJqemZtTE1obGV2aDE1MjRHaXVtRUdidnFKTVIzREpTc0NUMGhq?=
 =?utf-8?B?NVRqSG5DdzQ5L1ZQY1NaS1QyWk1iVVR2VStuNGg5WHJlL3FpMXR4d3ZoRXFv?=
 =?utf-8?B?eVZ4RzBPTW1ncVNGdVR2R3JRVTRaSkJhVVlPQ2tGbHUrQy9Mczl2RmRMMmlT?=
 =?utf-8?B?RU52bTlKbmU5REFGMlpBbDJobUp6RW0wd1NrUU5JYkIvR2NEbW9VSVZyZno2?=
 =?utf-8?B?ZExHdzVVeVdpUzBlZllSUU92clV6SlNTaXBrM2dLZGVjT0xuZ2pIZ3kvemIx?=
 =?utf-8?B?K1FMK0lJN1F0R2ltemFEc2pFcXcveG1NcXFqL0hRaWtSWDFQT1MxT05ocHBr?=
 =?utf-8?B?dFRKNVl1ZWhhb3N6VUh4NXdWS1NHWHNLeUphZ0RGREJjYlN1RkFCWWJ0Y3dZ?=
 =?utf-8?B?bmozdFFMK1dnRkg3cnVwUEVMMnk2NVhMeXhHQy82YlFkaWcxY2djNWozUk9p?=
 =?utf-8?B?T2JBL0xSazNHWmIwcHBKUmk2UUFWMDYxU0tIcVUxNytEMzlyb0EyazhEUnlZ?=
 =?utf-8?B?NEdvdGJaMWZFS2lzNDhwd0hoY1FjaXpLOUVPNUlMcDR4WGVYVkRWelpnM1Fa?=
 =?utf-8?B?Um8zMWJjVVdmeXJtNktxYk04V2VzRGdkT0szcTMyaFY0YnMrOGl1QzJjTk9N?=
 =?utf-8?B?WkQ5VDFOSE5QSS8xQW52WFpwTVhjRU1BbDRVajZKVENSc2d2MXFGbE9ueWxz?=
 =?utf-8?B?Zml4M0RyclQ4aEIvWmgwa0F6bUhOZzllaXArQi9zL0NFR1dQQ1FYQXdGdEpF?=
 =?utf-8?B?MlBXcmt0MStEY1owTys0NjBSbWlvMHdxSTJidVdDOXozMWpoSERjTnRSaklM?=
 =?utf-8?B?TEZyUnRDYmY5dnFpUEdQNkNhWXVleW9JMG1qUGo2cmZGYUFlQjRLR21BSnNT?=
 =?utf-8?B?dy9GOWhxQ3V2Um9IekZzNHBMbDQ3dk9jODhLVFB5dHcrcVdESUFZWWlUSWhJ?=
 =?utf-8?B?c0JoQzRZaEVZNHNNZ2V4YkIxVXJLZjJ4bFFOMG54TE5zeHhvNkxjalUvWjZD?=
 =?utf-8?B?dlJOaDZIbnR1SXJBNklXb2F2MG9NV0VEUDhaQjJkZ2RCZS9zNHI1UGFJNmUw?=
 =?utf-8?B?OVpMQVZGajlrUlY4WU8xaE9pQnV3c3RNN3NDNGo3UnVkREZxUnN2cFJ6UG1E?=
 =?utf-8?B?ZnpCMkJvWFFYNS90bnNVUi9CWjdxU0lNOTZLZTl4QldGcUNxUFpiZW53NTBi?=
 =?utf-8?B?bDlueU1hVW1Fc2tkSTFXWXJoRWZ3c0c4YzE2SjdXY0t0SjJOYXB3am5SQnYz?=
 =?utf-8?B?cHJIa3ZHMUgveXRiUXozRmZEZWVLUFR5b3F4YzZ4cENVYnJFekFCY201Tkcy?=
 =?utf-8?B?WWJLY2pTTVJNTGUxTHN5ZVhBWkx5d2pKOStCNE1zNmlTa1Q0YStEdWlrUjBi?=
 =?utf-8?B?aXhSN3B5blBhQUl2R2ZXZ1dkNDFLa0N6U0M1RXVRV09oME5oSERhOHRkSnRa?=
 =?utf-8?B?NWNCaGloaEw1S2NXYW4xQlBhbzhKcGNiOG92dDdMM1FpeVVRczE3c1hUWHlL?=
 =?utf-8?B?OGxLVStIbFBCS2tWUXdtcU5MQk5lK3dPSFNHMkJnK05WSWpUOSthalBFVHJZ?=
 =?utf-8?B?L3VGRW5JSUpqa0lFSWpyZWYyRU1uQ3hCSCtmVis3UCtRcEN4L0xjUEU3SlJi?=
 =?utf-8?B?V3htZW16eFQ5VG0vUmZCcGRhd0FLN0tOYlZxaWlYbFcwSlFObkV4MGpzRmxQ?=
 =?utf-8?B?NmxXQkErWlZwdGJteW82OGEwdng0bldZUGpMakQrbi9ScDR1b3Bxd1NBSGNh?=
 =?utf-8?B?eWcxTW9UaVJ2bFBWOVFSbi9oQm5vQi9ESWpYT212alJBaERNalV4SFo1cjh1?=
 =?utf-8?B?YU9wbWJqejB5QnY5MkdVYUZZazlpbzY5c255dEhKWUJ4clBBMWpiMlE3Yysx?=
 =?utf-8?Q?hXFihRdo5yyvhrZ4IEcbW0DuP7vxk673qcYhpF1SHgMAq?=
X-MS-Exchange-AntiSpam-MessageData-1: 3v6X4X0J1wmmsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a859c8-914d-4a26-12c8-08defcf17af0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:25:21.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS2zdtVcFM3MYoFQpCD64ydAyEbZODyuoHOPZvX6r/EofEg+mnK2jQ+D+JaY/G+yW/YJrBCTg9Lem1h5CSxz8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820

Hi John,

On 29/07/2026 13:04, John Ogness wrote:
> Implement the necessary callbacks to switch the 8250 console driver
> to perform as an nbcon console.
> 
> Add implementations for the nbcon console callbacks:
> 
>    ->write_atomic()
>    ->write_thread()
>    ->device_lock()
>    ->device_unlock()
> 
> and add CON_NBCON to the initial @flags.
> 
> All hardware access in the callbacks is within unsafe sections.
> The ->write_atomic() and ->write_thread() callbacks allow safe
> handover/takeover per byte and add a preceding newline if they
> take over from another context mid-line.
> 
> For the ->write_atomic() callback, a new irq_work is used to defer
> modem control since it may be called from a context that does not
> allow waking up tasks. During suspend/resume the irq_work is not
> used as this has been shown to cause suspend problems for some
> hardware. Upon resume, any pending modem control is performed.
> 
> Note: A new __serial8250_clear_IER() is introduced for direct
> clearing of UART_IER during console writing (which will not be
> holding the port lock for atomic printing or KDB/KGDB). This
> allows restoring a lockdep check to serial8250_clear_IER() in
> a follow-up commit.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I accidently responded to V9, but responding here with the same report 
for completeness.

This change is causing a boot regression for our Tegra20 and Tegra30 
platforms. Reverting this on top of -next fixes the issue. Previously 
with V5 I did not see a boot issue only an issue in suspend. So far I 
have not had chance to dig any further.

Jon

-- 
nvpublic

