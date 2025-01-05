Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2113.outbound.protection.outlook.com [40.107.20.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E2A920;
	Sun,  5 Jan 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736109905; cv=fail; b=o+n6cOf44FipeXQ+78Xl8ZJ+4Ma8NjnVfuAknyLOrCORzH0+8rskrdAbYcHKUgqw2wRc8o5rKjDNMbIYP7ONIbA+J9Fep2OSKW6uB5m0aYSDKoPBZRlOienYmyCDO8zdHaOUePvoFRsCuWZy+jmEioe6ymd6xmZpl2KGxh2zAgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736109905; c=relaxed/simple;
	bh=/8mO0/4D4E3ljVjHZIGR+i9Dhxd/sczR2fUSk8YgHBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BPzibrwFmajevwMbEghuhT4eApDaMaTjIXCCYxDqpHnzgGM0rUJAg9z7qKhljEAyu4pw6wWDCPfKMVFElVJneT8pN6e2/+qi9lV9iPjsAHMIuXWpXypEWocG1ejTBzgT2DtPGvD51nFDG3GMAbQwlIaZ0KovLBetLNgxCbKNi9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=mZWiMIrw; arc=fail smtp.client-ip=40.107.20.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="mZWiMIrw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjGRNUaTO816JWd58hAeoUBZKBivO6W8NRch+UyyHmEJrJzFdmW3TCCVuJ6bnBMjayANcuSj64w+84EPSUITdi4Jvgsrmz3KwZ5FDT2XFZGLxaLcyIwRR+I6hwSKGhxEu6DdSFS77uj7x68LkBtOYoUxR8IfmQ01O+tUIrO3LVgie8nZCHTteVkHFUYGh6Br616vdK8Xmcm/WBJH91bGGga96cBIA5CqUX7D9VsU6Qm6MCp0LR4Rrp7fMJgEpZKLuJ/6zOK5uzcrjVBuJ48JcNIf//hRo7oJWKIDI0VADnZmqDhOSIuMLAQ0NoG2+oJxCvu55taRUviNhVILTZCJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4/ifzN79d3IEw43KAqN3OSJW66rRaHCox7lJwj/BOQ=;
 b=KchxhcS3QomMnnxHAhgxTTqayeROK9Z6Y7zhR+RzqKhMnmNGBrU0T+tq8WxuMRpG/O3tAVEMGthUJkkT5tkoiXuq4TeD7vi4zMteGquNdIQ/gaznCuT9dwMb3YDH2ZP6GXnb3BYySYC9/jyxUR8H93a37Hc6hosn09vs9dMVAY5WYk2+nKMKdtCRHgEMNA5indazA14g2gDO0CUjio5imc6qMRiHVQuWx3kenYT6cWTZGNWqIzNBJYapFRbuj//8Z/XTcUAfni7yuSqtNHUfuGkjdVuk2TJZxONwHuZZkK15taVycY3vAzwSggeqg/4nGNxVjYyIg+KGMovtgjLZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4/ifzN79d3IEw43KAqN3OSJW66rRaHCox7lJwj/BOQ=;
 b=mZWiMIrwVThVsxBwOrykUPbB7qkvT6XzLRnpdvPH74I5Pwca6IkOe38rNRHKvcCoaYyfMoCRn4qPwBTbpL7eFdQPvZO5jNYGwzPKJElK+94ggUbTxqQ5BkVGUpOGLdlysA0imYArC2ARusp8sq7h8KUgPhmk9ZLbGDZGsqDlCa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AS8PR08MB6552.eurprd08.prod.outlook.com (2603:10a6:20b:31c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Sun, 5 Jan
 2025 20:44:54 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 20:44:54 +0000
Message-ID: <45f22ec5-76da-4a1d-bdf5-22246dc8f692@genexis.eu>
Date: Sun, 5 Jan 2025 21:44:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
 <2025010500-subscript-expectant-144a@gregkh>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <2025010500-subscript-expectant-144a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002E48.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::16) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AS8PR08MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b274457-5be0-48b6-ec53-08dd2dc9cef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2lUSWdHQS9tb1FrNVZSeGY4UnZRdGN6UldHa1JiZVRtSFFvMWorekpRaTdG?=
 =?utf-8?B?ckZNWkVxY0hxWDhNeFhZNldRT1h3dkRTZXFvd0xMVUwvSU5IUklHNjNwSmlH?=
 =?utf-8?B?NDI2Y29TSWEvUmNON3ZYcU1xeHZzUWJYeDJiZDArVTNTTHZHSkpZMlV6WXhT?=
 =?utf-8?B?RVhYTy8zWk5RemNFV051TFFORkp6YVRRbHNQS3Fyam1laVUwTDBjemRLS3Fv?=
 =?utf-8?B?Q050ZEQvaTVqMVE4QTNNN0VhMGI5d2NQVjQwVTZOaWRNZlZ1ci9tM2prYlJX?=
 =?utf-8?B?WHp0Y2d4N1VmY3Y4Y0c1MFdONFp4RjNsaXpXV21HV1N6SVg4aGxXYXZYV3Bo?=
 =?utf-8?B?TFZTeTViK1NRVWxaVmhOdTVJcEk4UVFsNElTbnZxNm9YTFN3VzU4UnFCWmZB?=
 =?utf-8?B?WGhld01IZkdUN29BVzFhZlFOdVlZa2xOREQySDZncXRGdnorclh4ZHdZclJ5?=
 =?utf-8?B?dU1BTW1McjBRb3oxQVBZWEJ0QzRCc0ViL0lYdTQ4TU5BUGF6UnZsanhVdk9K?=
 =?utf-8?B?Ukc1V2cydWRhSkEyck05RGZjakNZeVpRTWE2bmxmWEtoZDBuUnlWRzBxN2pU?=
 =?utf-8?B?MVFJRUIrSHA1ZXNYVjljL2RsZHd3WHRNMmw0VHpIRXZmMkU0ajVWVUhPUzJo?=
 =?utf-8?B?Yk10RWNobHNmVzVzTFVSMzNkbFJVbldGVXhKeGtWZHU3OGM1Rm5FQUtyYWh6?=
 =?utf-8?B?OHhBL0pPcDR0NStJVmNGQ0MrV2xjMm9FWlFLc2ROVEJYMTJSVmVIeHF2M0s5?=
 =?utf-8?B?Vyt6clV5cUJVdnpzZmZzdEpUNUY2SUFyMzJGbGV2d1d3VVhwbHk0QWJSeE1C?=
 =?utf-8?B?elBDWGlNcE43UkQ2MmUzdnhVZEE2S0JZaE01eWdQVDBzSFhTRjdjbWRkbEpz?=
 =?utf-8?B?REpyZ25qaGs1UGxEVkgweWZLdUtjeDF6VVM3Skh1OEhKbzlweHk4NzlBR1lw?=
 =?utf-8?B?a0xkWTF0c1gxUiswNVZNMUJBNGRKU1RSNit4Y2RKRFp0UVpVWVozZ21lWWVn?=
 =?utf-8?B?U1VGV3IwN0VKK01XK0ZkdCtmL3FMUlB2VHhTRExLVGtuMkUzNG9JTzc3cXdQ?=
 =?utf-8?B?ek5lOExac2NDVXczU05pNmdLZ251WkxJbWxlbnBUV3dVQUczMlRaa2p4cGNx?=
 =?utf-8?B?MEdoTmZwczA2VjF2b2NiNUJQOEY0ZVp3OUJ2akpkcXAxczM3MW42bnNiQTJ6?=
 =?utf-8?B?a2l5czlUMkxMb3NkeTR0ZWdtMTg4TGc1S0UxazFVcGZIVk1QbmlhZHRTdzNq?=
 =?utf-8?B?K0lRbyt2K3d6cTFOUWxTL0NIUmo1Q3dqWGt6U1NOMHN1aEd2cXVOM3hhS1Rm?=
 =?utf-8?B?Njk1TTNoWUdoaUpsSExuWG5tamh4cHl3RVJiQUpqVkxVMDIwbWhodFpHeGw3?=
 =?utf-8?B?QUROd1VtWngrYXB4Y0pVczl1OHVFd1FoQzFYaTMrc3lRMDU3c1VXaFFlRmk5?=
 =?utf-8?B?V1B0akFRdTZuc1FmMXhMcnlaNG9EZFBMNm1RekJ6Nll6S25PL25mVnRPZmpB?=
 =?utf-8?B?V0s1MG1KQk5LYkhrUGVZVVBYNjNKTys1ZFZTb0pORmdrTGpVVkRSd1NZQzJs?=
 =?utf-8?B?azR3THZPTEF5eUtRQjJIcGFqWHBWN0xrcFJKYVRXQ2UxR28xS0NlKzBuNldp?=
 =?utf-8?B?U3RwN3AvNUJRWFk0aExIcEwrNWJZRW9NUUhBVlhiU1hRVEVzQUtjaFZKTWk3?=
 =?utf-8?B?L2NrR0RYNWNHVkRlb0p6eXZ2V3lYMmlCVms5LzdZTWRRZkpxQXh4dXpJZEJ1?=
 =?utf-8?B?MDB0cEg3ZmNPZGN0eVZUeXlnMmw3bGtvbXJuV2V6SlczWXFNNVprdmt3UmVo?=
 =?utf-8?B?TitXT1Y0bk01YnpiL1RvYnVhRkNTdFZyWkwyR2d0cDRXM242N3VrMUlBSC9a?=
 =?utf-8?Q?MnBmUBOFPMHwE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmk0ekZFTlRvR21qWlJXb2krVi9kdTZlMDdoY002YU1QVXZadGJqSklTankr?=
 =?utf-8?B?QUhJeG8zYlp1RGpBb050UkQ0dThWaERYYk1DQVROOUZFZlVNd1JZNGFmb25z?=
 =?utf-8?B?c3R1bUJGN0h1bmRjOGU4NEhMQWg5TUtVbzFUTnMvTDJ5SUh2RkhDcWxFMmND?=
 =?utf-8?B?aGRZdzdBemUvc0IxZ2FDUjBMcncvT1JjSUQwK2lLQlRwdnVmMkZ4a043bzhZ?=
 =?utf-8?B?cTNFdWV0WDdWdEJWMjJpZHF1Q1BDRmtZRXVodDB1SkRWcGRzSVREdmFnM0Vy?=
 =?utf-8?B?aUVtS2dlOFRIRVpDMitPZlhvdDFRSmtoMVU1Q284NHl6R2d1Rmx5WmNudUJY?=
 =?utf-8?B?WVp0Z1BDK3piNjdHNmtVYTJHUUhtdlVUd0o2RmhmSXk1dVgycTB0Y1QxMXBX?=
 =?utf-8?B?cTFaOHpQVk1FVGJ0WUV5WkVvSlZhSmV2eGx1MkdkT2ZZb1NRbmEwaVg4L2tu?=
 =?utf-8?B?d05ZVVJTU29USzZjVG9WU1lVSXVPZEwzUUgvbmhwZklKV1pBckpxZVQzYkYy?=
 =?utf-8?B?allZdkdOV1JpYk9jSVU5SG0wWGFVUEt6d1hYdXlEWjR3ZWQya1hvNDhkcHhW?=
 =?utf-8?B?MitROHExZnNPWGV3cXovajBZYmVGemFKdElHQXlHU3NJZW8zVk9WL2RtM2ZG?=
 =?utf-8?B?VE5lMkViWmxiM2EySnZpWEhFdHVEWVpnS3plMlFROXhxdHIxcWQ4Q2lJUkw0?=
 =?utf-8?B?M2ZKakRvVUFpR3ZVSDByUlR0VnRiclZ6eXBQWlUvQmJ6VmI0ajYwR01YVk9v?=
 =?utf-8?B?V042ZC9na2hlMHZBUW5zZ0hOY3BqMGcrL21MQlkwc1VCWkdWSUtyNGsyVW1v?=
 =?utf-8?B?NlE3dERldXplRXBIa2g4NlJMMUxXakhGeUNTZGl2K3hLbzdPcVBoQUlrZU9Q?=
 =?utf-8?B?TU1tTkVTWGR4d1ZzZnB0cmJGV1ZKeEtTY2JOcURCeGszZGZTQnR3YWxTZVQr?=
 =?utf-8?B?VEE5d29ucTRGMzIvMzlPOU1MbXNLUERsSzBqQlJnNmZXZ2pIalFzcVhWV0Ez?=
 =?utf-8?B?UzBCcVZ2ZzhLR2Fmb0ZDa1hxZmNMVitVaHg5akF5MzlTZE5PUWNsLzVCeHN5?=
 =?utf-8?B?Nmc0RWlTK3E0R25MbEJOU0xJWEFWQjBtODJDSmRrNzFOQjE2SGZIQnlZQ1lC?=
 =?utf-8?B?WFRaV2U4NWtwNFl6ZTFEU0hOck1zYWFMeWJTdlZaTHJjV0h2OTk3WDBtY1ps?=
 =?utf-8?B?UERLalBNZUhwUXIzTHVpaHI2U3VDQjFHZkRxOUQ5ZFhvZndVSmw3ZUh2Wm8x?=
 =?utf-8?B?T3E0Rk01WGlIOEdEUEk1cEZBN05PbUtLSjIvc05HWEYzTE0wZEppd1k4eDB4?=
 =?utf-8?B?ZlBPK2V6ZjJqZytqRHJJYnByN1MrZ1djTlBwRHM1OExyaThSNGRGV3BmQ3ds?=
 =?utf-8?B?VTc2Rk9tL1cvYWRlMGZvTDl2NEd5dTBKbTl5Y1dUK0w4QnRhTzVWUG5MUGhY?=
 =?utf-8?B?Q1JkNExjUkkrcWtuRzVoNkVPeFlqUzVJS0ZuVW0yd1Jpbk5Kd2FSb29xTXh0?=
 =?utf-8?B?Wi9iUms4OGpsWFJ4dzB2V3gzVjlpRlhxQitVNFlPOUdHanNlRWdQMWZnalZm?=
 =?utf-8?B?UVBVQ3NPeVJ0QTE1emJTaEtzdVVjWWM5cGkyeVFqaDFyeWYwU3duc2NTK1Fk?=
 =?utf-8?B?bC9LMU1wZ0lGQVBLQW53RHgxTzNnT0VDSEttaW5VVXI3akY0ZDVKcmlBNzd5?=
 =?utf-8?B?Rk5yMVVlV2Q1Q3F0UzVJb1c1a01jeTE1dEtZaDErZ3dFdzRwTENkQ0hldGdi?=
 =?utf-8?B?dXNNQkxRcXdvVXRpVEhHdEVLZUQwU1JMODJSck4va0hid0UwdWFuZEs4bTlh?=
 =?utf-8?B?dUdrR0ZUS0ZLRzIrMXJManRFU0dkZjBKTmNZYmZ3eVVOREZ3QllwZG5uMFE4?=
 =?utf-8?B?NGJYY2hSbC8rbGRjbC9MRXZCd3JBUUdDemZUV3VlZUh6OWdhSWwwSFA2dmpy?=
 =?utf-8?B?dzZILytXL1IzR0UzY1l6VVQxeGJtbHd6Y3pMZUs4Zk1JYzcyV2FiQlNwNFNG?=
 =?utf-8?B?cjVHaWtMdWM1aGtaaWZBUDhBaXptTUxhNjNKYlcyeW53T0I3RklVUVQ4U2Mx?=
 =?utf-8?B?ckJOcXRGMW51NXV5YUpocGhoc2RsUXZlZnJWK250UnhLbVRWcDN2aWhGcjVW?=
 =?utf-8?B?azd2ZTV6K2RCcTBJTkVJS2VYSVdTMHhQZGdOQU5xamtRZXdjVDVnZzZuUzNS?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b274457-5be0-48b6-ec53-08dd2dc9cef3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 20:44:54.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRXCeV97rjwv/VVpkkmoaHk5lk3aIQ2oh0DzlUJtppz751t7/j5OsZRNlygZP5+5A3ggb7tNls5ktJ4WX+yHSFu3MEebsl6uBBpgblbgnZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6552

Hi.

On 05/01/2025 16:59, Greg KH wrote:
> 
> On Sun, Jan 05, 2025 at 02:11:47PM +0100, Benjamin Larsson wrote:
>> Support for Airoha AN7581 SoC UART and HSUART baud rate
>> calculation routine.
>>
>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> ---
>>   drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
>>   drivers/tty/serial/8250/8250_of.c     |  2 +
>>   drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
>>   drivers/tty/serial/8250/Kconfig       | 10 ++++
>>   drivers/tty/serial/8250/Makefile      |  1 +
>>   include/linux/serial_8250.h           |  1 +
>>   include/uapi/linux/serial_core.h      |  6 ++
>>   include/uapi/linux/serial_reg.h       |  9 +++
>>   8 files changed, 140 insertions(+)
>>   create mode 100644 drivers/tty/serial/8250/8250_airoha.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
>> new file mode 100644
>> index 000000000000..c57789dcc174
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_airoha.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Do you really mean "+" here?  Sorry, I have to ask.
> 

I just try to follow the style of 8250_port.c. Whatever is fine by me.

>> +
>> +/*
>> + * Airoha UART driver.
>> + *
>> + * Copyright (c) 2025 Genexis Sweden AB
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/console.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +
>> +#include "8250.h"
>> +
>> +/* The Airoha UART is 16550-compatible except for the baud rate calculation.
>> + *
>> + * crystal_clock = 20 MHz
>> + * xindiv_clock = crystal_clock / clock_div
>> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
>> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
>> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
>> + *
>> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
>> + *
>> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
>> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 give even values
>> + * for usual baud rates.
>> + *
>> + * Selecting divider needs to fulfill
>> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
>> + * The clocks are unknown but a divider of value 1 did not result in a valid
>> + * waveform.
>> + *
>> + */
>> +
>> +#define CLOCK_DIV_TAB_ELEMS 3
>> +#define XYD_Y 65000
>> +#define XINDIV_CLOCK 20000000
>> +#define UART_BRDL_20M 0x01
>> +#define UART_BRDH_20M 0x00
>> +static int clock_div_tab[] = { 10, 4, 2};
>> +static int clock_div_reg[] = {  4, 2, 1};
>> +
>> +int airoha8250_set_baud_rate(struct uart_port *port,
>> +                          unsigned int baud, unsigned int hs)
> 
> What is "hs"?

I will address this in v2 by documenting the function.

> 
>> +{
>> +     struct uart_8250_port *up = up_to_u8250p(port);
>> +     unsigned int xyd_x, nom, denom;
>> +
>> +     int i;
>> +     /* set DLAB to access the baud rate divider registers (BRDH, BRDL) */
> 
> 
> Didn't checkpatch complain about this?  You don't need a blank line
> before the "int i;", but rather after it.

./scripts/checkpatch.pl 
outgoing/0002-serial-Airoha-SoC-UART-and-HSUART-support.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#23:
new file mode 100644

total: 0 errors, 1 warnings, 187 lines checked


I missed the blank line and will address in v2.


> 
>> +     serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
>> +     /* set baud rate calculation defaults */
>> +     /* set BRDIV ([BRDH,BRDL]) to 1 */
>> +     serial_port_out(port, UART_BRDL, UART_BRDL_20M);
>> +     serial_port_out(port, UART_BRDH, UART_BRDH_20M);
>> +     /* calculate XYD_x and XINCLKDR register
>> +      * for the HSUART xyd_x needs to be scale by a factor of 2
>> +      */
>> +     for (i = 0 ; i < CLOCK_DIV_TAB_ELEMS ; i++) {
>> +             denom = (XINDIV_CLOCK/40) / clock_div_tab[i];
>> +             nom = (baud * (XYD_Y/40));
>> +             xyd_x = ((nom/denom) << 4) >> hs;
>> +             if (xyd_x < XYD_Y)
>> +                     break;
>> +     }
>> +     serial_port_out(port, UART_XINCLKDR, clock_div_reg[i]);
>> +     serial_port_out(port, UART_XYD, (xyd_x<<16) | XYD_Y);
>> +     /* unset DLAB */
>> +     serial_port_out(port, UART_LCR, up->lcr);
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(airoha8250_set_baud_rate);
>> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
>> index 64aed7efc569..5315bc1bc06d 100644
>> --- a/drivers/tty/serial/8250/8250_of.c
>> +++ b/drivers/tty/serial/8250/8250_of.c
>> @@ -341,6 +341,8 @@ static const struct of_device_id of_platform_serial_table[] = {
>>        { .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
>>        { .compatible = "nuvoton,wpcm450-uart", .data = (void *)PORT_NPCM, },
>>        { .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
>> +     { .compatible = "airoha,airoha-uart", .data = (void *)PORT_AIROHA, },
>> +     { .compatible = "airoha,airoha-hsuart", .data = (void *)PORT_AIROHA_HS, },
>>        { /* end of list */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, of_platform_serial_table);
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 1ea52fce9bf1..00163a3d35cd 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -319,6 +319,22 @@ static const struct serial8250_config uart_config[] = {
>>                .rxtrig_bytes   = {1, 8, 16, 30},
>>                .flags          = UART_CAP_FIFO | UART_CAP_AFE,
>>        },
>> +     [PORT_AIROHA] = {
>> +             .name           = "Airoha UART",
>> +             .fifo_size      = 8,
>> +             .tx_loadsz      = 1,
>> +             .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
>> +             .rxtrig_bytes   = {1, 4},
>> +             .flags          = UART_CAP_FIFO,
>> +     },
>> +     [PORT_AIROHA_HS] = {
>> +             .name           = "Airoha HSUART",
>> +             .fifo_size      = 128,
>> +             .tx_loadsz      = 128,
>> +             .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01 | UART_FCR_CLEAR_RCVR,
>> +             .rxtrig_bytes   = {1, 4},
>> +             .flags          = UART_CAP_FIFO,
>> +     },
>>   };
>>
>>   /* Uart divisor latch read */
>> @@ -2847,6 +2863,16 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>>
>>        serial8250_set_divisor(port, baud, quot, frac);
>>
>> +
>> +     /*
>> +      * Airoha SoCs have custom registers for baud rate settings
>> +      */
>> +#ifdef CONFIG_SERIAL_8250_AIROHA
> 
> Please don't put #ifdef in .c files, are you sure this is needed this
> way?  Why not do it the other way around like other uart types do it?

There are other instances of ifdef in the code (#ifdef 
CONFIG_SERIAL_8250_RSA). Thus I used ifdefs.

Should I use IS_REACHABLE or IS_ENABLED instead?


> 
>> +     if (port->type == PORT_AIROHA)
>> +             airoha8250_set_baud_rate(port, baud, 0);
>> +     if (port->type == PORT_AIROHA_HS)
>> +             airoha8250_set_baud_rate(port, baud, 1);
>> +#endif
>>        /*
>>         * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
>>         * is written without DLAB set, this mode will be disabled.
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index 55d26d16df9b..97fe6ea9393d 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -356,6 +356,16 @@ config SERIAL_8250_ACORN
>>          system, say Y to this option.  The driver can handle 1, 2, or 3 port
>>          cards.  If unsure, say N.
>>
>> +config SERIAL_8250_AIROHA
>> +     tristate "Airoha UART support"
>> +     depends on (ARCH_AIROHA || COMPILE_TEST) && OF && SERIAL_8250
>> +     help
>> +       Selecting this option enables an Airoha SoC specific baud rate
>> +       calculation routine on an otherwise 16550 compatible UART hardware.
>> +
>> +       If you have an Airoha based board and want to use the serial port,
>> +       say Y to this option. If unsure, say N.
> 
> module name?

I will add that this is part of the 8250 driver in v2.

> 
> 
>> +
>>   config SERIAL_8250_BCM2835AUX
>>        tristate "BCM2835 auxiliar mini UART support"
>>        depends on ARCH_BCM2835 || COMPILE_TEST
>> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
>> index 1516de629b61..b7f07d5c4cca 100644
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)   += 8250_early.o
>>
>>   obj-$(CONFIG_SERIAL_8250_ACCENT)     += 8250_accent.o
>>   obj-$(CONFIG_SERIAL_8250_ACORN)              += 8250_acorn.o
>> +obj-$(CONFIG_SERIAL_8250_AIROHA)     += 8250_airoha.o
>>   obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)       += 8250_aspeed_vuart.o
>>   obj-$(CONFIG_SERIAL_8250_BCM2835AUX) += 8250_bcm2835aux.o
>>   obj-$(CONFIG_SERIAL_8250_BCM7271)    += 8250_bcm7271.o
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index e0717c8393d7..33e7e1922149 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -195,6 +195,7 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
>>   void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
>>                               unsigned int quot);
>>   int fsl8250_handle_irq(struct uart_port *port);
>> +int airoha8250_set_baud_rate(struct uart_port *port, unsigned int baud, unsigned int hs);
> 
> Why is this here?

I use the same place as fsl8250_handle_irq() uses. Should I place it 
somewhere else ?


> 
>>   int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
>>   u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
>>   void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>> index 9c007a106330..c71fb338accb 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -231,6 +231,12 @@
>>   /* Sunplus UART */
>>   #define PORT_SUNPLUS 123
>>
>> +/* Airoha UART */
>> +#define PORT_AIROHA  124
>> +
>> +/* Airoha HSUART */
>> +#define PORT_AIROHA_HS       125
> 
> Do you REALLY need these port definitions in userspace?  If so, what is
> going to use them there?
> 

Testing another PORT define gives this result:

grep -ri PORT_MTK_BTIF *

drivers/tty/serial/8250/8250_of.c:		.data = (void *)PORT_MTK_BTIF, },
drivers/tty/serial/8250/8250_port.c:	[PORT_MTK_BTIF] = {
include/uapi/linux/serial_core.h:#define PORT_MTK_BTIF	117

Per my understanding this is how the current code is designed to work.

> 
>> +
>>   /* Generic type identifier for ports which type is not important to userspace. */
>>   #define PORT_GENERIC (-1)
>>
>> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
>> index 9c987b04e2d0..72a71e171602 100644
>> --- a/include/uapi/linux/serial_reg.h
>> +++ b/include/uapi/linux/serial_reg.h
>> @@ -383,5 +383,14 @@
>>   #define UART_ALTR_EN_TXFIFO_LW       0x01    /* Enable the TX FIFO Low Watermark */
>>   #define UART_ALTR_TX_LOW     0x41    /* Tx FIFO Low Watermark */
>>
>> +/*
>> + * These are definitions for the Airoha UART
>> + * Normalized because of 32 bit registers.
>> + */
>> +#define UART_BRDL            0
>> +#define UART_BRDH            1
>> +#define UART_XINCLKDR                10
>> +#define UART_XYD             11
> 
> Why does the define not have your uart type in it?

I will address this in v2.

>  And what is
> userspace going to do with these values?  Why do they need to be in this
> file?

Per my understanding I am following the intended design.

> 
> thanks,
> 
> greg k-h

MvH
Benjamin Larsson
