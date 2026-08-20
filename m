Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA044062A;
	Thu, 20 Aug 2026 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787201786; cv=fail; b=VQDVmtrjLuDq4SqHLCszKZUaEyVBuwcyxIBTEIaxqUNMg2u4p2hdIKqTnJYLW758uFvLJSW3ttOq2aVmoipwQDSwJFdlk6YPH/3MxsefjY7Z2/ey7MaV3z+dbrEC8OfZZrwg0+3rQUs+AGk5jLTeE9wu03PS6DlDFts3diizdzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787201786; c=relaxed/simple;
	bh=nliyzKgGT61UEpO/S/LVvCyaS7g4WZ87Mn2XL9dcdeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YZQNhGp0D6yJd7OP9rnbcyppf9P5gie9s8Gk1pwe79nqx7EgtJVGPsCpRndR2F33vQ3rvo9KsCisIsu//9aNHGqI+VLAHwJOcrJAGVY8FxijpgzVbrzQZrWp1Zc/RpxXqHdQTIpZnLGA6YrgNKsKQqVYiJWbt5A3u9TyN6J9JB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m6NNjNEl; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m6NNjNEl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXv2zTUP0j6EwOgeRxXu/Yq1CjoHv0DsOqDxlMc3y+MJrvYTKO3Jv4revWDQK14mrsPr3ik9h5r6cA+F5h6zzwYwA7fAm2OYFeiRrxRHKjWZrRr948ncljSsGx/BgUH1eOdePau0h3u2ny2kdgp7ZchhtttT+R40lRv6JqViHgYBNKtBRDi1SnT6+hmUxe6xHBQojQ0a6Auu4NWnbrlFkHbfOn1W0YtTWAo3hJcapzcFGwWZkRA8RmtDR9AQLBD0cMqX8S2K5R+0VQrzzTfti0ZMygAK932s3shZZrc1pNCAo40uwLTTkRQ30M5lxl7aAu7wIHdZOEl7dRDPw9qasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7wko9QzZA7GZ5O/3Hycxv0T17zdPudKXj+ly/Yox00=;
 b=nWogwfeqnzsY5sFPk5dNV2NuLaaeOF5TI1Vr2UYCv8SHjEUSwJtw24XNQ19CljQGHlFWlNy6ehNT3HiHj505hmI3LGdowu6MWO8WAlGxOiGOTew1llavppATErFemnIrjgExlDFarxrhh55Bqrxh0u4FNkfnLfKXcQA+xhJmI5EDbSwxt144KI8NkdJYmtin1puSwR2GY8vAAKx4H13KNcjEGdfFUrz2cOg/QTZt6YUTw8kZRkXvTp5cPb42ajbB2kGlfwmYiC9A/BDCY4JoL5L6TQYeB/X/tIMkfHJ3Tpu2TSOkpOKRqdL8A/P4HSP9fRyYt0xlbp7pxVszO9hHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7wko9QzZA7GZ5O/3Hycxv0T17zdPudKXj+ly/Yox00=;
 b=m6NNjNElNejbER715EtZgBAJ4ybAfAbrcvvjJ0CJVTMUOBa/PeJAN02aWrWUtA6AmUQHGblV6patsXA6UvEbXUB9YnwCJ8Ttysnq6RECVGUwlXO25bYzVAWYdwT14BSvUMNPdULQDkQZ32/TELkTPRRpJT8PtAXFROGyItS/RbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:56:21 +0000
Received: from CH3PR12MB8284.namprd12.prod.outlook.com
 ([fe80::1bc1:88b1:7cf7:87aa]) by CH3PR12MB8284.namprd12.prod.outlook.com
 ([fe80::1bc1:88b1:7cf7:87aa%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 04:56:21 +0000
Message-ID: <f22c5687-c379-4fa5-9b32-555ecf5e54f1@amd.com>
Date: Thu, 20 Aug 2026 10:26:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_dw: Add device HID for AMDI0021 AMD UART
 controller
To: Steffen Dirkwinkel <lists@steffen.cc>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20260813-b4-raven-ridge-uart-v1-1-fae442416ba1@beckhoff.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20260813-b4-raven-ridge-uart-v1-1-fae442416ba1@beckhoff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::6) To CH3PR12MB8284.namprd12.prod.outlook.com
 (2603:10b6:610:12e::21)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8284:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 8725ee31-26f7-4fc7-5a51-08defe776098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dqJdhKBr+JwNVXGlT8YxiYHrWl4/PzIDy3rb96O1Zn4Le1BDAvmk/RoSjch9mRrtYRu+2s0uh6IRDzaMc7yaeOSg2alGNCr3NQiKjmBFDlrOSiDMq932fILeH2/wQtg5LGwceWjpnbpR9gnZ+Buo7tKsTzsN65LBwv41oOcvdm0zXLiOXXhPJq9jTfMnSCJwmmko0oWxYUBTY+J7H87irnIuWvmFIH3xpSl6q+jrqV1GXNuUPmmGEBZ4wKX4e61ryLIXZbyFJZBfmC3XlPHv2EaU8YMPY367kWOpLiyIBYBKMZlFD+pew/WW4KEHezLtyM8d5FMWocMs2AP5+ZKMqSjHV0Wuj6OBgdG3/1vE2Q/9s4CVVBp2G++oM6XAme8SQfky+hbqk5a2HbpThSnuYGz60sKE2qZay6QY20IAr4BPsatYQeHSDfeL0cP9Tazy2mpnDHFRQ3UXE9rdScCV04ycSeQYd8K4eOs+EhJUS+cmAKSGGggERH5HPidJ6sddOjtJgJO+In/xlrmM4v1I7nDEtRt+y95axgvrlWOqkRIa+OBkJ3/JAq4CdpOK5/jbZ5ft8Ebm/HFlnBDFrbEdqZGnI5Jq7V8tQ7IReCPXyqMkydBz8plh2t+Fe6QwgQEFYRnJpVsxTNXiIVNagg64JyZZiQWKdSh8jk0ZYJpY3fI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0pwWit0NVVGTDVCM3BzSjFRZEdzWXVIZEVac1A0cXhMSk9qNTEwbkJqYll3?=
 =?utf-8?B?K29KYWVuekoxSnZadUxaWVlsMm9GQll0SUN0SDlzRWxHQUx2L3BKcTVRb0c5?=
 =?utf-8?B?Ynd2Z05Uc2ZZUStXZm9nOUV6N3pRcXNkcTEzREt0QzMwOXczS3FRY3ozTjJS?=
 =?utf-8?B?WlpyNXJKUWF2ZFdUdFdmL2dKdkFTWVpzWVZBbnFaM2cvazUzWXJDZC85cUkr?=
 =?utf-8?B?K1V5RDU0OGZ3b3NBbXhTMFc3NTBhVW1EUTlGV2V2MzlmYVM0Y3A1Zk5ydjFW?=
 =?utf-8?B?ODdaT0dKenRTYzhpM0EybnZQdlNOUFZqUHkrMTFoUkZWZEdLZUV6SzhIT2ho?=
 =?utf-8?B?R2k3aE1FdGt0SmtOQzR3WFJqZDlKL0QrUUtaVlU5RHRYY25RTytrSFpJUjUy?=
 =?utf-8?B?eHBZc2V4L0xrZndnWWZIS3I1bUJ1cVYwaXhwZXlHdmNONXdoZXN5SzJuRUpv?=
 =?utf-8?B?a1IyYVVhM1p0Q3plZUpEc05mb0JqZTlsT0FIaXROc1AxNUdHNVBTeGE2YWYr?=
 =?utf-8?B?QUZmVUQ3VG4xOWhKWSt2KzBmWTF4YjRBczNDTXBRUGZ5Z2xMYXRlMEx2TDF4?=
 =?utf-8?B?aUNwYThOZTlyMjIzOWlVWVdTVWgrOEZtZHA0UitKTDJGc0lmbWhPbHVoVUdN?=
 =?utf-8?B?aytRUmk3V2MrL1YxRy9NdFpONHAvU0lmYWVtTUU4TjlqaXlmTE1mYlBpeWRi?=
 =?utf-8?B?Um11bk8rYnBsbmc1cHZneWZqOE8yNEFTK3ZpbHdrZTM3R0VVT3pQNUlJSFZD?=
 =?utf-8?B?dklrUFM3R3FqN25zckdpeFlqbEhPR2RVbVBxQldwNFJneFhYTG00WmFKNlBZ?=
 =?utf-8?B?eTBkMzFaQ0lXRzRlR1huYmdnOEgyTUdZd2J1UWYwa2ZFV2p6R2VMVTdWQlY2?=
 =?utf-8?B?R2FvWUdkVjRLemxTbFBtT3dNYmpyOGFla0l4ZXdjRjNlU25aNzNkZFpWRHlH?=
 =?utf-8?B?TU1acVJiYStRZE9URUNaNjkrR3dPV2F1V1lFdkNNMy9TSGJFa1dUTW9qd1RS?=
 =?utf-8?B?YWoxVlA1dUZoVXF5eDJzeVBBdW11cDFmWDNpcHhTTTNLRXROdElTM3o4eVhT?=
 =?utf-8?B?OUIyZWR3VldFb3BGeXh2WVV5WFdXWFRmdDdTT1QwRnE2a0owZ0ZwTk5yZ0VR?=
 =?utf-8?B?VjRNdzU3T0czNDVvTU9PaDN6RDZmTUNXQmxublZRTzZCbVllK3pQelNuNU9Q?=
 =?utf-8?B?cFVrVWs2NjhrM2ZvZitRaWFjWk9ZVHh5T3EwU0xBNng2aWN1T2V1YklYRCsy?=
 =?utf-8?B?RWtQeWtYc0FHRGZscUR6YzlXMVdnMDkwWGNSa0tkOEdTbzU1NGNmNWVFZGdq?=
 =?utf-8?B?Zmh2SkFvbDVQQzlQY1ViSU41NmJoajFBbU5tRy9UaHdnT3QxYjYvRzNUUEhy?=
 =?utf-8?B?RG4xenZNOFNheUNpTVFLTUxjV01XWGwwSy9QL1F1N29zakI3VWNaTHhhR2tZ?=
 =?utf-8?B?ajJTeGVNeUpIbHlxaUxXTkp3bTZVaERUZGRqV0tSMXdaNkFjU3FwWHJZSkZs?=
 =?utf-8?B?YjFxREk2dTArZjVueEFoQTJFTmxxcWxnYnMzZmttZmM3YjE0SlpBZ1VRekJ5?=
 =?utf-8?B?TjZRZXVNbHFOYkcvajhFeTlYYkIvU0ZmSWFRRFRNZ1V6UkxqTU56czNkQ0pK?=
 =?utf-8?B?OTlsbHBudHVJN0VDd0tVSksya3ZLOXhBV3hnWUE0UFN3bS83ZjhCbHdONFcr?=
 =?utf-8?B?aWhWVUlRdlZBQWNkTHJFMGltcFZhT2FqcTJlU2pRZ2JnTWE2ODhZMGNFblcz?=
 =?utf-8?B?SHFBbmFGc2lIMW9GRXAwNDk4RTVzTVBleDlUTUd4TDNyQ2VTdEMzOGZQR3lX?=
 =?utf-8?B?VlpraWVVdjFMWnhKVWUyN0diNG1vb3prazF3R1hOYSs2N1BQSkh0UVpJcEx6?=
 =?utf-8?B?cnpFSUJlN3RhbU5nR0dvU3BPZWhCa2diTUxOcFN5SFdTNDRkSHFpYXFsZ1pQ?=
 =?utf-8?B?RU1ZZjdwQkJiajdSVlBkeTZaSlA1UHVybWlab05KcEFmR2U3TzJXM0czdzNI?=
 =?utf-8?B?eWFZWklXZ0JYU2UrUWVNSUZobDd5Z2t5anQvVy9FTzVFMWZDbGNsOVZJbXNq?=
 =?utf-8?B?aEpDRkU1UWxVNjRoclV5cjc3WFBsTzRvd21HNHZUOGR0a2RkR1ozakdvSmor?=
 =?utf-8?B?dHpVSmF6R210OUV2eTY0aU92MUpDMHcxMkZaYTBBb1REQklyY3p2OU93ankr?=
 =?utf-8?B?ajRPak1UOVMrQzZKYythYjlYRWZ0LzVJU0VkbWVSaWw1Y0EwMDRNa1FOLzJh?=
 =?utf-8?B?ODU5WG9lNHdpVC92dGd5eXB6bVNaUDhlRGUreG1WRjZ1Tmc3Tm5FWERqbVYy?=
 =?utf-8?B?aDBaai9oZ080ZHdJTFJRRFVQTjRMWnZKazcwYzhKeWZyZkx6TG9OZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8725ee31-26f7-4fc7-5a51-08defe776098
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 04:56:21.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/1yOpB4gNHjfJ2VRk51AAJeC7J+ks6xSDUre40oRnVedkulslQ4XA5TDH9GgORiLFou5LZIuTMvE1nK0Av9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186



On 14-08-2026 00:07, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> This ID is found on AMD V1202B.
> Like the AMDI0022 [1] this one works with the same match and the existing driver.
> Tested with a loopback cable.
> 
> [1] commit 3c35d2a960c0 ("serial: 8250_dw: Add device HID for new AMD UART controller")
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Looked at AMD's ACPI reservation table and this looks right to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> ---
>  drivers/acpi/acpi_apd.c           | 1 +
>  drivers/tty/serial/8250/8250_dw.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 008bd0552cb7..562be86aa272 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -250,6 +250,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
>  	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },
>  	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
>  	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
> +	{ "AMDI0021", APD_ADDR(cz_uart_desc) },
>  	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
>  	{ "HYGO0010", APD_ADDR(wt_i2c_desc) },
>  #endif
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5fba913f3301..214d3e7ae628 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -910,6 +910,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
>  	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
>  	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
>  	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> +	{ "AMDI0021", (kernel_ulong_t)&dw8250_dw_apb },
>  	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
>  	{ "APMC0D08", (kernel_ulong_t)&dw8250_apmc0d08 },
>  	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> 
> ---
> base-commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40
> change-id: 20260813-b4-raven-ridge-uart-62b1ef1fc246
> 
> Best regards,
> --  
> Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 

