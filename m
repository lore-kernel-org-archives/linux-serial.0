Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC70188906;
	Wed, 20 Aug 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673101; cv=fail; b=n6YfLRhqlZHBm/mCd0qUufQ+Jwo/rFj+0d1y+cM6WgqGG8lUbyWQT9fprDJwk4pygI9B8JtQ3LEVzvnZH3h7L+cYWsBfy6gFcwwT3xpUOOg5dbIWdw3zV2WjznR5L989fwa+oRIL7SPOpTtty3CogPUxXd0ZdpXtizWjR8Jzw2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673101; c=relaxed/simple;
	bh=HPLgbpj6IjnVR2xXEyfrUbA8OwQl2gXoxi/vo7QSCQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2MCOVHO8efXG4ioT6AsbU5FgpKGBmZnqoX/NsrfFwrt+8ZvrgglnPzRcm3TqpU5Nkcj2M9uzHEllXu2D8MG/jBoTFtKsntz2SP+LRjb7IVelit4ShLfpfbqH4SH5rg596FPvYT630FNtCeor0U6BczfL10AhqcIVj3fW1P0mus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fI2IC4eT; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fI2IC4eT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ9zG2odHZMIC/B1ARcQAkCuWARigNOOafgAMFS7D1DVDIXSJc9Q/c2tSGul+fjK651+mMj13YCUlTEwlyxtTK2DmrPIn8B6QwF8JNoul/sE/FxhMTC05HA5M8aqFRWvG1OCwtG6mCaM9D2AYywosKZf3+saJl4V08rb9E76jyAkSY38fcZlufQ7zZ5StZUnOUYR+lXqGTHNmS4X4O8DcfXIBNOAikJG9j7b2vxSlssKIYHrpfoqwPdhNQliy7hTEyI6tcwcAvYEDJ6HnBUc8iiqvaJSFMv9gUCiQqzWPhT/sT4r2/AxegRIBFX0v8H7AwhrTvDuPt8l31TwgEWyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnqKtZbGkHwmVN5gsi/mGt2X/bHeUV5Vm1zj7YpmRvM=;
 b=HhvmuvqZ6qftWeA2K+2nUQ0rfvPWq03LVgz6RK/8r7LzaEYTtVmWl4ZNzCRBsYO3R2qoUcv092SEQog52kFXcSIDbGck/l1f/sON1GNs0rjD3KdigdBYl7RJdwGv6XA0Av4TOpXPeIIIMWOMRgJhdLJomSpW8XpwZrTkCHiKGjfDcBbMY+1smfKCjZJHax3z7O+us736o8Ie+fJPpAQmjJvqwJYEWpy/C26mfrdZGGRsUZjq4LDcPxWTQnl4zsuOMeMickmLCMa4x7Iwv7mZcOaetoLYzvic02UEdKpeEra0lM8XpDs+wHEelDczvwMFbqywsqOwRn4Viz1IxWq/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnqKtZbGkHwmVN5gsi/mGt2X/bHeUV5Vm1zj7YpmRvM=;
 b=fI2IC4eTGmbCUqTp8S/NEN+3fvViLyHUK//TcCqrHx9g7yyhgcqRVrVCGHxiGusOH/8OH8VBYFWHfbqTSy+nRlhAPQqv6sVEeNXiK4GffpWYG6ejesVmJQkNcAz983dIWAjwSyxPojo4KPenGy+Ceq6Ovvu3xfOec7W/929F8i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Wed, 20 Aug
 2025 06:58:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 06:58:16 +0000
Message-ID: <59692110-eca9-4f0f-b6f9-e23bf835733c@amd.com>
Date: Wed, 20 Aug 2025 08:58:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: xilinx_uartps: read reg size from DTS
To: Harshit Shah <hshah@axiado.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 63759809-7ead-4563-851b-08dddfb6f06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjR2dEpHZDRvVUEwSnoyNlRwbUZmMmtRdDBjVDFSR1orZWdybXl1NmhzV29T?=
 =?utf-8?B?RkFWZ1U0cTg1Q2dkMUlxR3Z5VXlmR0kvY3A2Q2pCVjdHSDJod3hnSFR0clRH?=
 =?utf-8?B?bnd3TXM3WEViTnhvUnBMNWpnWHZjdGkzOWJ0UG5aL2c5R3VsSnk5OEZXNkRx?=
 =?utf-8?B?WVNlWGdNWFdiODltTHh5MFFGYUFlSnFCdzd1aExVbVgyU2xkellDL2JrWHY5?=
 =?utf-8?B?N2pnSFBxOVA2ZVFUNlp3MCtZL2c4VE44T2dtKzdjK0lFU3cvT3pEZEdYUVNi?=
 =?utf-8?B?Q1BHYm1tUUdWNFVmYlJvY3JaMnRMV0lQN3ppQ1d6eDJXdEVzMGtnN3ZrMG9u?=
 =?utf-8?B?T0xTZldiZTNZMlZpZFlMSllwU2tXOHY0RDRBaVJ3bHJCQkVlL2FFMmU5R1hw?=
 =?utf-8?B?RUE2VFlScUx5RWlMYVhUeUpuTEVJcE03T3h3SEM2ekh4dnArd2FySkNSWkt6?=
 =?utf-8?B?ZHpkdDZ2S0NSZFgyc2x6YnA4clNUQm5oTjhCUlVkVVkvSFVWWWxDblZvek83?=
 =?utf-8?B?N2l2M0FBK1l1Z3E5b1loR2g0OG5WNEVLeVh4RXAxMG05dUdHYnFXRU9LdENm?=
 =?utf-8?B?VHJ2bHdDMGU5L3phMWY4NDVjMUtQaXlXYXhjUnVUODllbHIzTWFNdEYreDNV?=
 =?utf-8?B?ZUpMOFQ3b2oyUUdYMUE4TUpQbmUvYk9kUVNKSDNIaS9zeGo1T01qd2VrUkN5?=
 =?utf-8?B?dFI1aDN3ZUtpQmcwUFg5Q2hzdExPbkRFR05yZUtiT0p2bndDYWoxZ3kxdE84?=
 =?utf-8?B?UTBDWGZqWk5zdUd5NlBHbWRUM04vdmU1bXdnY2lnUU52U2F2MEc3UjJSeERZ?=
 =?utf-8?B?YW4vVmxSc1pOdDA2ZkVjcStXYkV4aWdMTnFrUDlFUkRoZ2FLN213YXVjT0dB?=
 =?utf-8?B?TFB2ZlhqYWljdnhqNTkrUlRTNmpFZncyRTRiRHJzdTRRZzJKKzRJdGlJNU1h?=
 =?utf-8?B?eUV2YktldVo1STFkcW5UMnRjeE4zQ3EwNS9xYkFrcWV3TkhZQ3IvTlVqWHVz?=
 =?utf-8?B?MzlIa2ZubGZrckdsb3haZG1qblZvYmpBVnF4U21xd2RVcmVuUzVjMStmc3lB?=
 =?utf-8?B?RkR1UHZjaE1HcHZtUnZIQWFrcHV5TmZtdXZlSTZUdTlobG5BaE80aWlRbmZq?=
 =?utf-8?B?VzVmcHJkSUJoSWRHaE5QNHFIOEtGb1pCazJsME1KN1l5R3hvY2xPY1BtK3Iw?=
 =?utf-8?B?ZFhYWVYxOE5zU1lGVFJKbDFZWXBhcFpNU3lLZzJodWxjN0RYWElITHdXVzdR?=
 =?utf-8?B?Z0tDSmlFMmdTRStER1FsV3VTb0swUmxJL3lrSUxTQUxnaXQrTFgvZXZSaEsy?=
 =?utf-8?B?T1dGWm1qNUM3K1ovcHBzOXpaek5LTjdtMmVOVmlTTDByR09RUGVhcGJXOWxo?=
 =?utf-8?B?bEc2dTYraHZEeHNJYllKUnRvZkdBdEU1R2llOVhIL1dyNzlERy91bE84UzhP?=
 =?utf-8?B?Z0tzRExjUDRNVndDcWw4NVdvS0p3b1h5MEpaMTRUVHhiTW1iOW0wQUlaWC81?=
 =?utf-8?B?OXQ0VndLUGNrTXRCWXU2SENuQ2U3c3VIS1ZEam9FZnU1SWhOeG1ULzNsdlVP?=
 =?utf-8?B?dGNOR0NMazh4NERZVDhHOWQya01VMUhSVUErYlVGUFBVZ1NSd1dxOC9VZ3FZ?=
 =?utf-8?B?ZGRpMFdHV3FRU1pRQU5LZk1jWXMrSmtxQ1ZPV3pqWVVLMUh2dWV3ck9FcUNJ?=
 =?utf-8?B?Y1NWdmFrbEJ2dGxMSmhHelZ4dGo1SFU3RjExZE1KVEtsSkNRbXBTay9zYThJ?=
 =?utf-8?B?dzBPRWtQbHNvOUFtNWVtMTVBdXoxMlhIUmZNZ1hwaGh2YkU1UnBIV2dFK3VV?=
 =?utf-8?B?M1pUcy9iVXRpYVNCdFN3NmVaeEk4L3A3M0wrN0NQWkdHelh5SXRVbHBzaUlv?=
 =?utf-8?B?NDg2dzNaTXBmUDZXUzR1OVZHaVNzU2RlQ2RSUmx3Mmo3UFNFVEtaNWp6bjZn?=
 =?utf-8?Q?JR4GA3N7IMs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZSbzQ0d2dydEh6Y3pxbVlJL09HMS9iQW9CbEVPNWNHbGNmUVJMZ2krOGpq?=
 =?utf-8?B?bFc2UndLVzdJalhPdmhoMEhDYmNrUk11ZlRQWVJVSFAza1hBbUhpOGRxUkhS?=
 =?utf-8?B?RW01ZHZCZjRQN0FUeEN1MnpKK05CRW1xZUJsV20vL2c3U2wvMDZ1ZzErRllY?=
 =?utf-8?B?OU5QWG5WYnAyTFFZN3d6NUJWRGFrRlJtYmZBKzc2S3hpN3YweXdIeXNna0Nj?=
 =?utf-8?B?eHBBTmV5QjdseHhPcmJYWGMvTmpMSTZzSFM1bC9INzNxQlhCSU0ycU9tb29p?=
 =?utf-8?B?Myt4QVdBTUl0Q25ZRldvSlVaR0RySVkxYjQ4YVVFMVNoUzIzV0ZCa0VTR0tL?=
 =?utf-8?B?a3lCVGdNeWZYNjJKUGFSV3BJNFBVaWsrVjlaanFCSkZNTWJjSzI1Y2pSVlVn?=
 =?utf-8?B?aVR3OFdLYTlGcTIxZnBYSk9FdDlrZHhDc3dkUEJjd0xlV3ZUUFVKT0lzNFVk?=
 =?utf-8?B?Wlc5dFU3eEp4b3NxSkwvR3UrSTdNT1g0YzJkU1NQVFBBK2tKL2crSTJzcEpp?=
 =?utf-8?B?UkRVQWZtVjRSTFhac2pVVVBNV0JOT0JRRE8zbk1WSWkvSVpKdFJja1ZKZjlQ?=
 =?utf-8?B?LzNMb3JQLzVLL1kxV2NmVTFkUjJBMkpNS0J0MVZncHY2bzhzV0lPM3VURmc3?=
 =?utf-8?B?ZTdMdmxxOW9rS2hTK014a0QxQTI4bVU2dnQ0N0hnZTJpU09ndXUxVkt3YzVC?=
 =?utf-8?B?Ynh4MEtwbldvT0swc2w1Uk96VWttcFo0OE1JajRoR000Ky9MSlZqWXlodU9E?=
 =?utf-8?B?TWRNTXhBaFVQeU5DWG1WN1NUazlJVTNOcDFBeGhUQ0lYT2pvbmx2ZjBRdkNW?=
 =?utf-8?B?WFRJZ0V1akJjTENXNXdFTm1kME05a3ZpaGZWcTBlSW9tcktrdDlNYzB6b0gz?=
 =?utf-8?B?R3k2Mjk1RlpJWWM4bXpoYktMUVRRU0kweXNSa3hlM2lCdS9jL0x6cS9yL2kx?=
 =?utf-8?B?RzVLZGwzM0E3OUEra3h6L0NpTUk0SFZOdDdvNTk0SG1IUG9Ta1RSOVUyMG5U?=
 =?utf-8?B?TU0xUVBnQ2EyZFZFMTFESitzMWpRTnpteFJPN2VuYmdoU29tT0lWQUhyVGN2?=
 =?utf-8?B?T1crTGlHaXVhWnhCOUxwMG9KSDNySWE2alc5Tis5Ky8rRDBic2xOOUk5Uy81?=
 =?utf-8?B?TGdjTG5PV0o4VmpzOHk4elFBTytQWnhSME5KTVh0MHRkY3R5YzFZOWtoRnFM?=
 =?utf-8?B?YU9WTFJMTlhSYlRiSmFLNDBZeWJ5cE95dThJQmcwdXZOVlVGVUNpTTlkTUgx?=
 =?utf-8?B?Y25zYitKOHZkUW9weDVlQ0RBT01RNi9PbThZaWlKMEVvYnlFcUxPUHAvVzhP?=
 =?utf-8?B?cFhRYWI2b0J1QmN0V290NHdVdHk4RVc0UFQ2NkdvQ1FZb0hmamNHakhvVm5q?=
 =?utf-8?B?Vlo4TFlIVzRkaCtiSk1jRnU5TXptKzRpSldXdDg2Y3lIcXlrK2tkMGw2cDlN?=
 =?utf-8?B?cDU1WlNIQk1sMnlyQm5ralQ2cXcyUWVUMGVaL1FidVJSMm5QVSsyUFpyeEk2?=
 =?utf-8?B?cUhMM1dEWnJYY2xhYk50UFdSMk9hQUJNZ2FnYTk1bzJWY2VoajBiUXA1cDVw?=
 =?utf-8?B?WlpDN01KNEJFNTNJOExrenRubWdUZkxxL3Z0NmRXcWtpRHE0TlZXQWpYclJu?=
 =?utf-8?B?YSs0N0NxUFN1NUpMWUhxRkgwcUttN05CMTR1MlVyeUtoTjN6cUV4SUhFenlU?=
 =?utf-8?B?bWhEdjlkaUFhSXNyZ0VVMGhDOThzVWU2U0ZKOXYxL3orZXJrMEJDd3ZKSW5w?=
 =?utf-8?B?MzIxcllSVVkrc0pCQzd5ZU9OOVNmZnZTbEJnT0ZSWEg4NGNiSzN2d2pJeWJD?=
 =?utf-8?B?Z3J6WnNVWnF5ZVpBU0IyUndUZFJ5Y2ZHK1N5QjdTTGpDZVBtNXJMWkpuUmM3?=
 =?utf-8?B?dldZaGFtWHIwbUhlZlAvWTI5eG11alEvSE5oMmI5N0tZa1NrdFFJb3lXZVAw?=
 =?utf-8?B?U1MramxlOVFpWUxzMzVpWDN6RVgvakQvbk9DdjlOR25STXkvS0ZWbHpRRk9R?=
 =?utf-8?B?NnFRMFFuV0FYQ2o2cTc2VHREOVd2MEVlR0RsYU1FRFljYkN4aUVneVQ4RmRU?=
 =?utf-8?B?VGFDSVE1cDdxdXArVUszL1BpY1BqbTRPSzdzcmFHaTJHL3dvcmRQUzgzZUxu?=
 =?utf-8?Q?zafVwqhMTDdq7LrwsPzw4h2hH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63759809-7ead-4563-851b-08dddfb6f06d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 06:58:16.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UWEifFPaYwomkptaoX2wnsxISmVS5GxcQsBTLWFmzRaPv9/eH/C7adNWFTClIcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033



On 8/19/25 22:53, Harshit Shah wrote:
> Current implementation uses `CDNS_UART_REGISTER_SPACE(0x1000)`
> for request_mem_region() and ioremap() in cdns_uart_request_port() API.
> 
> The cadence/xilinx IP has register space defined from offset 0x0 to 0x48.
> It also mentions that the register map is defined as [6:0]. So, the upper
> region may/maynot be used based on the IP integration.
> 
> In Axiado AX3000 SoC two UART instances are defined
> 0x100 apart. That is creating issue in some other instance due to overlap
> with addresses.
> 
> Since, this address space is already being defined in the
> devicetree, use the same when requesting the register space.
> 
> Signed-off-by: Harshit Shah <hshah@axiado.com>
> ---
>   drivers/tty/serial/xilinx_uartps.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index fe457bf1e15bb4fc77a5c7de2aea8bfbdbaa643a..a66b44d21fba2558d0b2a62864d86d3b73152e26 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -33,7 +33,6 @@
>   #define CDNS_UART_MINOR		0	/* works best with devtmpfs */
>   #define CDNS_UART_NR_PORTS	16
>   #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
> -#define CDNS_UART_REGISTER_SPACE	0x1000
>   #define TX_TIMEOUT		500000
>   
>   /* Rx Trigger level */
> @@ -1098,15 +1097,15 @@ static int cdns_uart_verify_port(struct uart_port *port,
>    */
>   static int cdns_uart_request_port(struct uart_port *port)
>   {
> -	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
> +	if (!request_mem_region(port->mapbase, port->mapsize,
>   					 CDNS_UART_NAME)) {
>   		return -ENOMEM;
>   	}
>   
> -	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
> +	port->membase = ioremap(port->mapbase, port->mapsize);
>   	if (!port->membase) {
>   		dev_err(port->dev, "Unable to map registers\n");
> -		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
> +		release_mem_region(port->mapbase, port->mapsize);
>   		return -ENOMEM;
>   	}
>   	return 0;
> @@ -1121,7 +1120,7 @@ static int cdns_uart_request_port(struct uart_port *port)
>    */
>   static void cdns_uart_release_port(struct uart_port *port)
>   {
> -	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
> +	release_mem_region(port->mapbase, port->mapsize);
>   	iounmap(port->membase);
>   	port->membase = NULL;
>   }
> @@ -1780,6 +1779,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>   	 * and triggers invocation of the config_port() entry point.
>   	 */
>   	port->mapbase = res->start;
> +	port->mapsize = resource_size(res);
>   	port->irq = irq;
>   	port->dev = &pdev->dev;
>   	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
> 
> ---
> base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
> change-id: 20250813-xilinx-uartps-reg-size-c3be67d88b7c
> 
> Best regards,

yes. There is no reason to hardcode it to 0x1000. Only 0x48 is used on our 
silicon. Information about size can be taken from DT.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

