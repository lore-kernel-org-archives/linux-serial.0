Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F1184F;
	Mon,  6 Jan 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166923; cv=fail; b=e3aWa2JayHVNpzQRhw309/+WHAlH8Izrtb4hYEb9yKweAmLN8258Uc3HcxKnWNlN4GOIhNLGBPEjCoRDZZzI6ZO3VqSB3K/YoM/yZxQfXKZtfgzQ7yxm5DYme5yjnp1HeHvOCxSrEPA7vZ7mfoUAPj5FJOsSC4OQ9cIB0Mcppi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166923; c=relaxed/simple;
	bh=SHx5Uq38vRGV1wDUijxzTiadpOPayWo7xYmGeRBYFL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pDsUwEKu9OnVR2944lHk0Af5RzX0K+V5jJtw3be54QtTSwRrl4Mk7dXqAes2Sk1nbOnASNbdCaNKYoXX6+SR4NEZMrKfE9CO2Q31I7k6ZQSZiWNzu2mQT5e41tQw1yPPsQJd+vEMM3Zol+DGGcGX3o5821CrEig56x3am1i9i48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=mczQbR98; arc=fail smtp.client-ip=40.107.20.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="mczQbR98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2ZlYANNpEQGNAVlP/3vKe1si//j2HfuZoVjz3yJnciSJ8LbO0UWydLRP9OTB8fjTd1ZG0n9jZmpLTLMkp6yneVU4Ds4SShAFVBfVHhTESu9jWK2brj4rmAWdj+YZy1Vh7UphYcp/39YS3T57R7GKK09SlW9uh9alM0KW0BCTPb5BNZjPAoDFH4Mw1lzgwfx6+vvBlJqOKSB6IJt8CS7XmH2rSwc1Tt2R8R1b0trm4dKaXMptoUWsfqIxPYmUII8jixlZL9F787IjIOQ9FpzjNoKEBCcmYCGUnA0uxFR0DMEzr51ImO8sN6EmA7dT40zGBJHGEh0aWCw3OGirL86KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwsQkMylG8w63B3pVK0LO7JKUkyAXCOe8NVFHEnD9yM=;
 b=UfJkWT9+br386OfaX9bDnsy76yhYccMvoY+3d+ytDkIQrxp3yuMEcA5v7DWYRf5u692vctUjJFFYnmonXgeAUEfi5K50+XDD9bRk7OQ8QzXuIYtuhKc9pInPuslKdRrC2ZAe89BOn7cjT4qSUENShSpxBZw9YE/0FjtkOFEwzRotvem9x9s0CaqabOrJJTu4Uz21vwiDKGPngrTjRFAQVU0kdSOHTh9N9aa+jsP7rbWLB8+kf7jphQ97i3OglLsMFXXxmQ7xcJ55G5TJty3x4+MfbmzqnqyLSqKOn5qwNjj1KFFYGYuM/8RwRgKrmmHZ0rrNgLazBy97YaeZto0+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwsQkMylG8w63B3pVK0LO7JKUkyAXCOe8NVFHEnD9yM=;
 b=mczQbR98uX4a4SSaVQWL83Y1JvzPP59x+uf9DJffyuPL1i1vLsobjRfwCXIzC5oRsOZLFfNizH2EHWzQgciT+f1sWQ6ZnT4hPgLRlhoG31p4TPfZZE+CZJbBS01uGODtPDt42FqXPeObMZKxkMd/xzl4aLM5Fhji9PjE//I5zPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DU2PR08MB10302.eurprd08.prod.outlook.com (2603:10a6:10:46e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 12:35:12 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 12:35:11 +0000
Message-ID: <49278805-b667-40cf-9217-1c51eb80882a@genexis.eu>
Date: Mon, 6 Jan 2025 13:35:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
 <2025010500-subscript-expectant-144a@gregkh>
 <45f22ec5-76da-4a1d-bdf5-22246dc8f692@genexis.eu>
 <2025010646-nacho-grinning-cd35@gregkh>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <2025010646-nacho-grinning-cd35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B59.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:e) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DU2PR08MB10302:EE_
X-MS-Office365-Filtering-Correlation-Id: e48bbb1f-3335-4a2d-1109-08dd2e4e9022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NHTkNPanAvUXVseEtpbGJFQW5OK0V0RUtnakJWMjRGN1dheE0vQTFBUjRN?=
 =?utf-8?B?SFN0d3NQMXNLK0FPVWo2MXpvZ3Z5b1N2STVGTnJPbmg2eWlpK0ROYWRBT0FD?=
 =?utf-8?B?RS8xRGpMR3FXcWdQSk5wZTNhUmlHN01GWWpjL1E2TnVkNnRPaXk2eUl5NDZM?=
 =?utf-8?B?UmpqcTh5RFhsMS9XNGhYWS9mSURmQktvYUY5MnFBRDY5U2JNVVpjVFcyQ2Vz?=
 =?utf-8?B?cVp5OEVEaHlGc0VGcDBuRlZMdVFsMjQ4VDlDeXl4dzRzemNUUk9RVXJKNkx4?=
 =?utf-8?B?ZXAvNnczVFdyalR1NWwvSzlLN2hBYm5JN01YTHNoL0xZTnBac2ZFenUyZm01?=
 =?utf-8?B?U2dmRXBOMUpLMEpXWnZlVndSRTJjTUFoT2M4SnNMN3QwVEErKzUveWRCbm82?=
 =?utf-8?B?a3ZLSUpLYjlnMVZ1K1kxT3VITVlkUEt4ejZicVBOWnRFeW5YYTNhZXEyWEdY?=
 =?utf-8?B?YzRHTmI5WFUwQmhiS29ncXMxVG02ODN6dkdFUFI1bWhCbmdIeGZ5UU1jU2Z2?=
 =?utf-8?B?OWNjcDdmdTBaS0dDSEZLZDR1bC9mc1BsR0Fyc1o4UFRIdjFRWHViSjlvMzJv?=
 =?utf-8?B?K0dNNXltcXRUWS9xLzVBMnEzK1JQcDBwdXhOcXQ4TU9jWjFBMGkrSXUwWVFr?=
 =?utf-8?B?UWpDQS96cDZYNTdpNFA3M3Q4cERFQ2RxMUpXRWpJY0hGd0FIYzNUQkdLRlJO?=
 =?utf-8?B?cEpFVE9abEd1c21WcWVpcGhOMWtub2VVTHZhYXc3U0cwQ3I2dy9tTEVMUFcy?=
 =?utf-8?B?clFUa2h2d1lTV3RGdHFqSFVOWmRuZzFMamo0NDl4bXJia25Ga21KYllvTEZ4?=
 =?utf-8?B?SllOc2c0ZzZEb0NSTDhCZmNLa0FUQWt0U0dhR0dlcGd4T0FieGN3cXd6ejZD?=
 =?utf-8?B?dk1HUUM5TlZKbHROSm5ONHhRczVKbzhZdzNGU2l3bXhDQ3Z0WWh4eHJSRFBK?=
 =?utf-8?B?dnJUQ1AzL3RPUi85dk5ZYXhPN25zMWE4dWwrdVc1MkwyVCtCelpmTVNnYkJw?=
 =?utf-8?B?VTcrVXR3YXl6N0d0NSt1MUl1UWRMUDUwUVNvZjJreWpQQmFOSDNtc2ttZitW?=
 =?utf-8?B?RzV6RFVrNXAvUy9KTWlKVHlaUk1vWDZLc0daak5tSlVIUFlPbmxjTjVjaEpa?=
 =?utf-8?B?MStDaGN2N1VmSk1rNUxFTkpwVW5pR3RZTGFvczJsdVlnNkNRUnIvVEVqdGpN?=
 =?utf-8?B?NzIxUk1YQWtDcGJLSHV6MTB3bDRYN01wejlQZ1FRYmVsaWo0M2l0cTlTZmlQ?=
 =?utf-8?B?aVFDcEI3L0JCbkxWSVdyZmZWdVdmMStmOFNHSHVGKzJuWTJEWUY0bHhrMmNJ?=
 =?utf-8?B?Y1ZtTklwblJTd2x4NzFQWXM0TldQZWxWcVdSbS9KSXc1Y24vN1JpY3hscGhz?=
 =?utf-8?B?aCtHYldiV3ZsV3pMWFRaa1FyZG51dVlWK3ZNdkN1d3BsZXBLNTJSUUt6NzVw?=
 =?utf-8?B?WlFZVUJzQUVURTc1TDA3ZE01VmtjRWVLQm9lQ2grTHhXcTZINGI3OXlLaXVD?=
 =?utf-8?B?WUxXd0t4MVc3RkkwTktWSVh2ZzEwbldReG5aVVhiRUNrMDczYXdhNWxvOHA4?=
 =?utf-8?B?M2xxWUREREVMWVhXMXpoaEtBcm43RXNVaWVYTnRQbTZrZ0EvUldoOTNiUmRl?=
 =?utf-8?B?b3pYUkZ0ZzNHNzdCcWJ3SEl0dnIzV2FYNWNkbFAxRTJWby9Ld3FQTVErWFp2?=
 =?utf-8?B?ODcrcUtlWERFZCtpMi9JVlplNi9SczltbTN3Z0pLSFUra2tKMkE4R29xaWh5?=
 =?utf-8?B?SmZkMGxmcFkycEo4Z3lUZ3FJaXNaWE4rbWswQmFXeCttNUZxK3VVUG53YnBZ?=
 =?utf-8?B?RFpMdXptN3FrMUExNUppdlUrOFdwbDM4cFlvYmZxcnVNVFg3aHZYd3pwWnVL?=
 =?utf-8?Q?Bzkx3hRMX4tOg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUsyZzNFcEp2NjkrQWpRWUhMMXFzdi9xemJKTTErbWppZ2orZlY0SjBMVjA3?=
 =?utf-8?B?bW1XT2FrNDJWejRRKzB2bS83VnY2T1dBc24rMmNBclVJZlR1akFXTXE4L0JX?=
 =?utf-8?B?a3JEU3BZZ09CeTRScFRIalQ0Qys2YmJqWFVkNFJ3dHZWUHZSYTVaU1B1S2Qz?=
 =?utf-8?B?eVFaWWdxeFgrOGowUm1SQlpnZmVUQlRyUmdhdTdpcDk3dmk3ejEvMGdURHZw?=
 =?utf-8?B?VU5OZ0tTVGFWTGV3dDZxWnFuRWJ3R0kyOTdudGxxcm51QlA4V0tReUlxL0Nl?=
 =?utf-8?B?UGZlRXlEUkN0NS9DMElzMDA4dU45SXFCMDZHdlhKYkppVStCcjNBVXU4RFpx?=
 =?utf-8?B?WTY0dmxKdElEZUNzeDYzb3BwRVdPNkliRitmSU11cTFwM3JtdnU1Zi9LRTFs?=
 =?utf-8?B?Wk16M1U3ZlFHY1JxeWdxWXovaXQyTjZFc3BCV05vNjBYelhVeU9CV0FadEs1?=
 =?utf-8?B?VVlseHhEOHZ3djB5aUpaSVQ5V1ZuSkxCV3B5Yys1V1ZRRnN2ay9sSi9UVkJx?=
 =?utf-8?B?MW9aemdwNmhycXhGUHRhT2tNekVKaHJmeU1OTnFEMkhZcTJSTjRJVXcvVVFq?=
 =?utf-8?B?TGJrUDdqR281QzEyL2w4YlBYWFdHMmFzL1ltK0IycWdkUzFuOUpETnpMaVov?=
 =?utf-8?B?d0prendzQW9scnZONjIrVzRNWGtTYXdEb0dVQUgxbTRkUFNpQ0hKcE1NREg1?=
 =?utf-8?B?T0VmNUFnMTQ2TFlKa2lDME9NZWxReEZLak10cnpPaHZKVWM2NmpJcmxXSUdJ?=
 =?utf-8?B?dXpPRklzaU1HZWJXZHFXaVcvZ0plbDlPWmF0SmFjZlFmSmI4MVhwUTlRaEd4?=
 =?utf-8?B?OUVXRUpDamZ3cC95amN4eVZVTk1PWThTZ3lLTE16dGc4TTRMQzlFeEQ4cU1Z?=
 =?utf-8?B?TWw2RTRreTk5NHdWUGZKT25XbnUwMUw0WE8zWkxPejdrQmtBcUI4MGgyejlk?=
 =?utf-8?B?K2NMMkpqYk5aWVJqUFJNVDZ1dFU5YnZiNElva0VhZE9sZzdzVks4NnY5a2wz?=
 =?utf-8?B?VHhuZFFDbXdlTEs4TGpkY1c0ZUhDaTU2SDIyMjJjbHp1VGplMmlHSFFPM3h4?=
 =?utf-8?B?UzVsNWZFbFdpTHY2YnlRTlQwTXY2TVptTkpDaFJWZGtOVkpxRzRNZTNHazR5?=
 =?utf-8?B?aWdzRVNoazh0RVQrcGtaWFFUMDgrdmlIRkhOTjF4MlpmL1Y2NnVQWHdtQkVG?=
 =?utf-8?B?Y3kxd1U5b3huaDNSM0gxd2F3eWNkQXBmN3NYeWs1bWRTSHlDcnpXVnBCUWNk?=
 =?utf-8?B?SUNScU1hL1F1elRkSk9tTWxsRDk5NUhvaE1tcjJabUxDb2hYZUNONU40Y1dE?=
 =?utf-8?B?QmVhWmsvYTZGcWdBU0trMkt2SnRuTlB3VElsaWtDb1Z2cnorVkdVcVZEQkM2?=
 =?utf-8?B?Ly9MOGFUOUh2U25TaHVxNkdWTE5XTUlhMW9PU0p0SU9QQ3cyU2R6a3pOYVZ2?=
 =?utf-8?B?alREWnpQWXEvakdmRDBuenBHQkM4R2RSRkpKUjJDM0Q4SFNrR2t6TzVBdHYw?=
 =?utf-8?B?YXc4S29FcW5qTm9PTjgwVUVHbUJqWFVjZExXSCtJWW9ZSkJpU09CSmZBVDVp?=
 =?utf-8?B?cUh6Umg5OHpwV1hHYmlOdUdhUmthcm5hNWZJcVNZaERYcDQvT25TQkt5U0oy?=
 =?utf-8?B?WmNUMDhTOWRqMmRBdjhKcmRUeHBZMWZoeFF3WHU5MHNOTVIySVc2WXRaNWN2?=
 =?utf-8?B?WjRVWnhqL3VHTDBWVnpmaEs0OGpsbk0vT29GQjRjTE1iWnJ2RjZud2NsYlY5?=
 =?utf-8?B?Y0RDUTZrck9kb0MzZHA5WGRNcUZrc1pJTGEvVHh3bTdRUURMdjd1VVc5VjZP?=
 =?utf-8?B?NDM5UklBY1pYbGR4ejhaMVQvM0VEQS9ScGg1UHpyc1l3Ulp1cFd5WjlEYmV1?=
 =?utf-8?B?YmRTL3pCQ1ZTdVhTKzdhY1pHaWY2SU1melZ5WnpLRmpmdmhhVWdyVCttK0cz?=
 =?utf-8?B?ZW13bG5vUTc4a28rUkZ5dFV6elMwSjVBSzM2aVFPRkNVZ3JuamVKUVBHSytI?=
 =?utf-8?B?QzlCSUlpenBEd0d4TkxjVkZBSmhzVzFTdFNlTGRYVWlBUEVjY00ybG1acTha?=
 =?utf-8?B?QTJ4UGhUQUZCS3lWQm1CNEU0UE5aSUZQSnBnenJCY21QK2pPWkNmWURLU1Ru?=
 =?utf-8?B?VlVKallEZHFPWEdBNnNSMFRKWmM4NXdmSVpkTnc3T2VtamdCclQzTGUzQWlt?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e48bbb1f-3335-4a2d-1109-08dd2e4e9022
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 12:35:11.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htPKtah63vubX/2X6HaPx3zRKWwZN13yKVgiWIb8+h44YzrgSaYzv5OJg7vgcs3lwdogO3kTtdL+WY6ZzRRpX3Pqe2ol88gvnkkXLs6ZAVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10302

Hi.

>>>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>>>> index 9c007a106330..c71fb338accb 100644
>>>> --- a/include/uapi/linux/serial_core.h
>>>> +++ b/include/uapi/linux/serial_core.h
>>>> @@ -231,6 +231,12 @@
>>>>    /* Sunplus UART */
>>>>    #define PORT_SUNPLUS 123
>>>>
>>>> +/* Airoha UART */
>>>> +#define PORT_AIROHA  124
>>>> +
>>>> +/* Airoha HSUART */
>>>> +#define PORT_AIROHA_HS       125
>>>
>>> Do you REALLY need these port definitions in userspace?  If so, what is
>>> going to use them there?
>>>
>>
>> Testing another PORT define gives this result:
>>
>> grep -ri PORT_MTK_BTIF *
>>
>> drivers/tty/serial/8250/8250_of.c:            .data = (void *)PORT_MTK_BTIF, },
>> drivers/tty/serial/8250/8250_port.c:  [PORT_MTK_BTIF] = {
>> include/uapi/linux/serial_core.h:#define PORT_MTK_BTIF        117
>>
>> Per my understanding this is how the current code is designed to work.
> 
> That's a very old pattern, I'm asking you if you need this new number in
> userspace, which is what you are doing here.  I'd prefer not to add new
> values here as they are a pain to manage and we can never change them if
> added.
> 

I dont need it in userspace. I need it in serial8250_config 
uart_config[] that uses this header.

I need to pass something from 8250_of.c so that 8250_port.c can pick up 
that an airoha uart is selected via dts. Any solution that is acceptable 
is fine by me. I just reused the current implemented method in 8250_of.c.

MvH
Benjamin Larsson
