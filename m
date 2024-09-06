Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC83B1A2;
	Fri,  6 Sep 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606310; cv=fail; b=HC3gjM8tbFgwlrMpcv/enD/U0l3SVQdQS3WVbkTmasgy8bodn/t1qBjwzHu6Lr0/xelzfXmGdkTJnk9YT8W18hCWvnkDCfcI8pfXnznvCbIjOKPsbqmAWqsaXRySx07U9H74yhWqWNe+99HONjyVDSiLg0dnE5+Tt59r6UVTQJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606310; c=relaxed/simple;
	bh=CJuFd/skp9h46QY5ygJSzmJY5vQ0+4bpohpqUsJt2jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NrEtFVOuA+cenEdl5j0GXeD6x/MX71SpJSm5pgLIEHeL6xFQsEgEWvgkPya1dYUQDyKbhmf8BE7l6KeznJhLXcd1AZZJ5emZmsFbFwL/clx8hBSmIMFB7ZHmuvfOL4MPUudbiDSKV7kZXvst3nalPor9+ZnfYwPgkVrwVcGQGFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5JuiwZls; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5JuiwZls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0e4P5yyQFZZ12LRi2oDgYDN2BJHTKq/qbLNo6YnEtomW7+RI2VzXC1PzAXhd4waLyr+CbHZLLMj9Ump38joyy8rv98QFrXQG2vSpRpyI8+zPoKewtZcq3a2CwAk9T+jJEEEQ3uTzTN4OUPKAsVicrchXki87xmQuxwP/tNoyWtXGSOyz2akYG9kr+hA0LooPY8Vv1KCYg0yDVgv/dbmr5/HO7bBNtG4wBRTwECD/7BmA1n35Op7cvYKXfmRE1auo0AXCTuTHFF15moie6pB3ztogTfX1zWkd5oeVbCv9y6rOybrRyIo56bwodf2/ubdZQXRo4/+cp6YDGXCvsrFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UWVb6nMLL2hs4eaOjy5TZvtJ1UuroDFHp2mntH/lF8=;
 b=CYJRWqkWIKIRiTeReYhPeA2tLXRcSUIU77s8IN504Zrq3RcqOIH8af7GMNQaClEDhYa4RT76ToTgwt2Akj7ic+II5924hPNNHZOtnCfKurnAKBAgoZyPjw14VYYruu/qNOS6TnI/8gh5iDCtsYj1Pb8a1zBQOgBMARTrA9MmNPlynMfZ+tA+awo4Ul7GPzN9ieSxQW4BHJwpABxmlCjQi3GDLGoXTbLYZ8SSw7p/HgX6etUm5xh7fX9V+uUWfNoGrpN1Du9Ah3vmUuC5E7PNe5ezz3EGboyG3Rxmo9Q/oAq7IXV6XI1j9xjqCtrBRNZJWCsSLNpue5PAnFa86+5taw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UWVb6nMLL2hs4eaOjy5TZvtJ1UuroDFHp2mntH/lF8=;
 b=5JuiwZlsQj4TlbJ5k7TLNcubPjF0oT426EQHrW80mLczE1kiKJvBQC1KGloF4F/YQxo4Vp4iGdzUGl9q/1zrG7RSWNB4qE2L7f/2eKBT+o1azX/klMVmFi0sWSvCS4R9gsJQ91WkCapRM1cx22ewmnBKPF6BmvAYP4gr+ys5AwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 07:05:06 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 07:05:06 +0000
Message-ID: <33cb57cd-200b-48a7-9028-3f6bf46b4dde@amd.com>
Date: Fri, 6 Sep 2024 09:05:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: xilinx_uartps: make cdns_rs485_supported static
To: Min-Hua Chen <minhuadotchen@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240905231930.343759-1-minhuadotchen@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240905231930.343759-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8108c5-b09b-450b-4caa-08dcce423cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmlrVm5hUUdBZW0xeHlOeDlNZ1RFcUNUam02eksxd1N4OHBlckg4L1FRaThZ?=
 =?utf-8?B?SHg2cEYzWE1nYmhmMm5iVUkvRUdmWHhXcTZWdTM5clJFOVhVWDFiYkZWb1R3?=
 =?utf-8?B?N0h6RWdlT3Y2NlhZK1lJVjZWTW5rRGZVZ1hVWWtRNGY2d2pyRlkvUGRmUk9H?=
 =?utf-8?B?Q0FIelJSQ0tGakVEaDVTbFkwcHFab1ZvQUtxY045bGNOY3l2NFQ3SGVOVTRa?=
 =?utf-8?B?Y1UyQ1h3cGxXUk1kdDFzNlYwRStSR05mSmxyeHo3ckxoWk5tN1dQRjZxKy9U?=
 =?utf-8?B?K2l5M3V1dFdmUUJjeXA3elBJa1hBWnNZMHZOdjJhc0g5K0t2U0dMSmhxeC8z?=
 =?utf-8?B?aHFjTXVYTDhWWEM3RUdWUU5HM05vU0Z6d05SdnNnY1dSdHVKM2tzMmM5dGZi?=
 =?utf-8?B?VHZLa2NKVHRQZ0hTOWttbzFvT21kMkg2emFjTGNodElzUExjYUZBRnhBYUNL?=
 =?utf-8?B?YVBpQVp2MitPaGRFYnZPR0xsaWdlTDRlblFmOTNlbXpJcWczeGZpSXV1UlJi?=
 =?utf-8?B?ZnkyOFBCVHhNUmlVZGhkSFRONHZRQnU4eG9sTkREUGIzS01vR3BJNm1CVUhs?=
 =?utf-8?B?WEhuOFVZNEVRZUF1bExScWFRbTBjY1JEa1Q0dGZlTk02b295WFV4aU8vZHN1?=
 =?utf-8?B?VmJXL0FyR0NDUnRTMGQ5c2tjMDBxSC9tTWZ6T01Lc3ZPZUFwSE9MYUhEQzJ5?=
 =?utf-8?B?bG1iR1BDaDg3TzJabTFLZk9PdWtmS2V1blV2c1FKbHRNZkRCVWxWOU1BVEpv?=
 =?utf-8?B?aXpROERuZHhTanZ0MUhNZStxRUZDMjI3TnFMY2xwSDFzQXQ0K3NzWkJOa0wy?=
 =?utf-8?B?OEVnVHpkUkNHUDVQN3A1cXYrMitSNHRPNVU1c3U1TkpUandlQXBEenRlNDEy?=
 =?utf-8?B?VXRyQ0pETHVnRUo1UzEwNmdxakJyNXh5SFd3a2JPckFlbFoxKzFaT3pmVmUx?=
 =?utf-8?B?YnhNZFlCZ0x1UU9JM3FUMzNTaU9teTJ6cDhjUnVvQmlPOFliYVkvNlpzd2dh?=
 =?utf-8?B?czF3VmtkYkxjUGtSdnBKcWYwYXhoOUJNdms0ZnpJZEFKazd0TjBYa2xwbFlF?=
 =?utf-8?B?eEJSM1BJQmpaK29TNTNXanhWeER2aDJWd2lFM1F4cnAzaVhocDZSYnJ2dERi?=
 =?utf-8?B?RVdSZE1uRGg3bkZzNWFaeVBJT004ZW04bmRpWTZqdWlTRDRjV0xKTlQvYVVM?=
 =?utf-8?B?cmFCT1VzZ2ZJTFVFZUlPL2RzRzBYUmVQWW03ZEVtNFFpMzUrVHArd1Y5TFAy?=
 =?utf-8?B?alVFU25Wa2Z6RnhIQ0FuREsySTE0QW9zdDkrbWp5bzJ1ZzIrcU1zMVlEcVFB?=
 =?utf-8?B?SEZITzk3WlFhdTVYOGlvQWxlZGdQcEZDR1pCL1dZMnpieC9ETFVGbmVPRlk1?=
 =?utf-8?B?MXArUldxZ1pUa1FOVmU4RzBLbmpGSlZkcUNWYjJOYXE3alRSYVhCMDVicnRh?=
 =?utf-8?B?REFqTVVOdGlXNXFrKzRTUXFaYVFIWjJnOE1FbWJKTzI5MWtOOFdZTTJsU2l4?=
 =?utf-8?B?S01RT1ovdFQ0TXZrblMwcEVDeWlxZUVWcHYzZlVleHFZVndrbXArdjYvUFA3?=
 =?utf-8?B?WmpBaWtJd1UrUnRHU0ZFU3lBVytpbkVCSjhQRnVGRWVleXZiV09PVzlSVUtN?=
 =?utf-8?B?azRRTW5XaWFuRlFGRU9aQ2E5Y2ZjZDJ4ckRLLzBCU1BlVmVqeFJVZUxZRjFh?=
 =?utf-8?B?L2Y0MStYcGxjMFRaQjNSSXAyTnJlcDFZZVJIejdMeVRRUmRiaDcyUEFTM2FC?=
 =?utf-8?B?ejdYcGFQZEV0OEk4RjU3QXJsUklxb1RBeEtXdmQvcHNLcGg4NVhxWHBNRnE5?=
 =?utf-8?Q?FiBD6K36DkH89qG69a6c3WNuXxSbpv/grvQFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0cyOHZHRlQ0QzRiZXJNZWZHMHowWGtUbnM1TTdSdUt1Z2lNMC81bkE2bkwx?=
 =?utf-8?B?M1p2bHEvWTFPTGh6cDRJSHdyWDYzczNaVDFwSnVSb1phODJ6Z1Z3MkxaYWtx?=
 =?utf-8?B?YUNJZDR2d1Y1OTIxbjRJZzZ0ZDk4eTBMTTFVbUJuaWI0T2luMS8vNUk5eVFL?=
 =?utf-8?B?amI1OFE4UzhCdC9PZXVucWpTWHhRYThOM0hnVThtOFBGbjBHdCtKZlZUQ2hZ?=
 =?utf-8?B?a3BDOTJmb2FicG53UmZkcGpVOGY2dVdXbDlmT2Y0djFldlpHUVllUi9uSld6?=
 =?utf-8?B?S0ZLR2IvdXJSRnQ2Qm1SZXAwME4xenZJeWRpL0Uwak5UZDN0VGx6RDBVVm5T?=
 =?utf-8?B?cm9LZU8rT2J0NnAvZlowUHFOaVM3RFRlWmJZYjN6RE5FU2RQdmJwVnpybzV5?=
 =?utf-8?B?eGtLajR4WUV5dVRxRWRpaEI1bURGV2M2WFN5UitHUWVmMkUxbzQyc3FzV3l2?=
 =?utf-8?B?NkQ2eTFBUnhlay9mdHlaV1dTS2c5RlNyTGFnZjFoTHlUTStYbStTRFI3eUY4?=
 =?utf-8?B?c3pMTmYwRDNnbXd5eStGeWw5Q2cyRng4WVRyOWVJbVN4Rjd1L2I5eVEvRTVo?=
 =?utf-8?B?L0JKK3o1T1Vjc0F4N3Z5OXN6RlNiOUh5blZLN2pua211QWttWjFINGtmeFlX?=
 =?utf-8?B?aDNvNUs2TFdwZGN5U054NXFQUWVXd0VwZVBYZE5YcGo3NUg2RkdhQ1VNOTBK?=
 =?utf-8?B?WHIzQllrT2FpNU9jQkE5NGcyT2hMQUh1dnREOUp1Uk4reGhjMjlud1dmU3Fi?=
 =?utf-8?B?NWdRN0p4UGVNdmp3SjdNc29BWUgvU05aTWZXYUk2bnNybyt3RUNOSGljY3R3?=
 =?utf-8?B?QVNLdHZyNm00WVNtWUtYOEQ4WjRvWkNuTTRYM0UzWDc5Y00xSEU3VDE0WXhz?=
 =?utf-8?B?TUo5cTZyd2tvUVZMRndHUFZwTGJubG4xS2pLZ3I1R3pPd1B3T2RxL3VpNkI2?=
 =?utf-8?B?d3oxMWNiMURRc3YydE1OU1pXMzdUTGIvVHJuSUVJdnJvMkVpdGFadlZycmpn?=
 =?utf-8?B?N1ZHa0gyUHV1ODhlWk9PdHJRUlZrK2U1Z0xMTzIxZWtVMlE1R0tvTkM0YXdU?=
 =?utf-8?B?NTNaNk11YTEwZ3grTTlveFhqNkdaVENLNHJ6WmlMTEVVQXJiTjl0U3ZyQkVy?=
 =?utf-8?B?dFhMbnFOM2ZTK2gzT3JSWVh5Mmx5SE5GQVBURUF2NFNXYnZXWXh0VWNXQmVy?=
 =?utf-8?B?N0kyRStOU3piTXhtL3dDYWYrRm5mZThVa1REbUREQkV0ejIwbXJjdDZjcFR0?=
 =?utf-8?B?K01HRm1pUkl2dS8zUHhkMXIvb1JnNDJ0dUdjbHR5TnpVb3FUREMyRUJ0YUc0?=
 =?utf-8?B?bmNlWG9ZVE5GREh3RUdMTzVzeEVkUFM1d2psODJCaEZwSTd3R3lFeGRoeEJa?=
 =?utf-8?B?aTJQUncyL1loSklObEZVemlHV0xaZmV2TVJHaHBUcWdvU1E4Um9IYyt3SFdt?=
 =?utf-8?B?VEdabDFzQmJBanYvV1FUYUVxR2tYRENtNjlqSWxlOS9CbmpPbFJXQksyV0NY?=
 =?utf-8?B?NFBGc0NjS01SREdRNldWNWE5VkxMUE5keG8ra3FCYXFWNFN4QlRBQ2Y3aDNF?=
 =?utf-8?B?N3pCUkpCZ3VxeHZHb25lcVdyTWU4b2xhSFVJVnNuaEVTN2kzWnJOcHk3Uk1W?=
 =?utf-8?B?VU9YNTFtR2hHNkZHd2lCM2UyeXVSSElUd2pWT0pVMFlFdldtcXpIUkM2bkp4?=
 =?utf-8?B?Q01XWkpKQWRhbW1SZ3RJVWxUREw5a0h2SVdYUldjcURvV3pOMHI4cXpDOVFm?=
 =?utf-8?B?VlFMalJpWVN3bUI3TUpZMkJCSjhLS0p0enFlK1FKQ1kxY2dSSHF5M0VGOFg2?=
 =?utf-8?B?a2FyWjZSVTBIRklKYjIxcERXNEFheGRuVHdJWU1ZSDVGQzNjcS9XelBLRitw?=
 =?utf-8?B?Vk1PbytobFNXdVNZUHQvakV4dEh2L0lYekdVN0pnb1hOTWIyc1JnQVNRYnB4?=
 =?utf-8?B?Mk5xNE8yNkJlUHFRUWlhc0w1MG9FelFOYjFEU2RlQXI2dE8zS3BZbS9hV0pm?=
 =?utf-8?B?THZmMFF1bVVBM1pXWjR3cWJOSFdlUTFXTE1YUVIxWEhXVGx6alY1dFpsdGx3?=
 =?utf-8?B?OWY1b2k4ZUFhV1pNUEY5MVc5YytEekhBRnF2L3ZRR3hMbHc0dGlzTmd0bGIr?=
 =?utf-8?Q?KAWw+apxPZntxixUmk/KjH2Bp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8108c5-b09b-450b-4caa-08dcce423cf6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:05:06.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihh1ce76vw6J5hXazhCNhUfPwZ8/MzvMYwOi9R9cFcDv9moww7yYTP16n/SyhgY0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546



On 9/6/24 01:19, Min-Hua Chen wrote:
> make cdns_rs485_supported static to fix the following sparse
> warning:
> 
> drivers/tty/serial/xilinx_uartps.c:222:21: sparse: warning:
> symbol 'cdns_rs485_supported' was not declared. Should it be static?
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>   drivers/tty/serial/xilinx_uartps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 2acfcea403ce..777392914819 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -219,7 +219,7 @@ struct cdns_platform_data {
>   	u32 quirks;
>   };
>   
> -struct serial_rs485 cdns_rs485_supported = {
> +static struct serial_rs485 cdns_rs485_supported = {
>   	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
>   		 SER_RS485_RTS_AFTER_SEND,
>   	.delay_rts_before_send = 1,


This has been applied already as commit 68c5efd9dca ("serial: xilinx_uartps: 
Make cdns_rs485_supported static").

You can also see it here
https://lore.kernel.org/r/20240819120107.3884973-1-ruanjinjie@huawei.com

Thanks,
Michal
