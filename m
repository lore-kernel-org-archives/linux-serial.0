Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021095.outbound.protection.outlook.com [40.107.130.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14140DFC8;
	Fri,  2 Oct 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926044; cv=fail; b=ksv2ELfXaX4SnXjv8KsNOjI8mem3BtLwZUJQQcKoFK+O6cN6e2RqRDl7MpxF8A+73cb/mjaBrX7I8LERfR1kcjCMyMz781vF0+2foZMFQz94jnM+lSGo2D0fT7iQfzHKg6YqZB40oI9cB5QtRTtt5hDkiGcawCnbL0EdsI0RJsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926044; c=relaxed/simple;
	bh=mdaamrUea+jNGZKviijtg8UvFRdy69eSHupYyVNJykQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LkjiE9n38GwNas5uGNgonat14dPX5fe1WO5A0j0Fi8MV/+FEjNvt9jcAZdZDxfpVjY7BaFz5HJF9PId6oTgZ59+Am/gJRK+/yju9Jwv+rBe0FpAvEWoSJ7nq3QJ46wQW6ArEAueXNuEb/mICN6Q3m+NMY+wNqT75pJ/1MPtviH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Ow1Ctthi; arc=fail smtp.client-ip=40.107.130.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Ow1Ctthi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6bw4qq9fK1DeEjIRMw5fgigQW6FkiaOMJIiNTi5YjTpDCqMhh0A+dpf9iYqTu5QSGNl3EAJ/kqDLsLf9W6pWdbvwlN4aR63K/myRXxoF0nHGHhiRburED7C33JyF9ey7oAaY6Fc5b7ZQzeT/xSU91Ljky6GL+1LaSpzOsNxbdn+HdQLM5jd7H2P7/i7aHaP3cyx/XdE38rWFbI3+D+OEQu3Ef0UYZ1g4wfl6dY2cEATFG++nQ/QkbNPT1nRoIQtd+4IkgRQmUZsWkTHC4Id1jUjFmU2kPLE/VzhUyZ2qAl7S7SvuavbOKKl9+7wNry3+REFJTNLOkPS2+gOxGR8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdaamrUea+jNGZKviijtg8UvFRdy69eSHupYyVNJykQ=;
 b=rVak+41BP8TAyxRmyPKYnKL1llu5EB0Ljp4WiOT+7O7I1tAu7RwQPkJRleDMsvBGDtlcQFW2haCsRz4mRmOVmpNZ3qrLV262zoFxXEKmD42VpOZzQa4tnoZigOpEZVI0YhFJfrLrZsy1AUjItMRqZouEyAc1BWFIgVx5B8ae+Bo9mzExkQuZz6reD9n36DaLclkeS7EYDj48tq+qQMiw1tNgrbG6uTBBpOvgi5qKrv1mejpRkQ3rKnAU1zOqi3B1BTnvZnBNx4Ahr+rqs2MmnI8M9JBWOqDt5WuoZQYg6eLfZL+qK0peoKtFaTmh13vQjWdwvzi8atGFF+mW5qmFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdaamrUea+jNGZKviijtg8UvFRdy69eSHupYyVNJykQ=;
 b=Ow1Ctthi6XWYv+F0/h3Iutbk1H2dBceCKXFVim1T3IaTZ1nD2+7tKBcU7w3WOOXY0RZ1z3Or+wLCO7dBkazT4Hi0h3Gt/eyzsq23Zl7qoqJRqU9t9HjTTSkZY/UPsnKqt+qyL8j/zbjKk4PGNlhsYFXhIMZ+mezcqo5lmL+nib9euuyvzj1vo5Jzz3sfanS1aACQ7ap7PJ9S4YfVJVIWfQc3SyKiT5tSh4vevZyKl2pPlowy4/6lFdKlfVqWj0kb+MflgpwW9J16qM/ZHPdq1Aa0QFI6uBDTwCrtp+478tV/7Mbl5xgNpZ/x47HbP+hMd+ZHXW3qRqAHpseZ9CsQBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by MI9PR06MB910975.eurprd06.prod.outlook.com (2603:10a6:290:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 07:27:13 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 07:27:13 +0000
Message-ID: <77d6748d-19bc-48a8-b956-c4bd2f77fa57@vaisala.com>
Date: Fri, 2 Oct 2026 10:27:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
 <20261001151125.1cf9daecf48174999aa676f0@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261001151125.1cf9daecf48174999aa676f0@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBC1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a4) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|MI9PR06MB910975:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5b0a6c-afed-482e-2198-08df205693d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uNQtG7u4QSWS+g8hcDRvE0ffa8/1Nve1pa0zbo2bwlx2cchMq/8l/RtTShVsR84ZehLN4e9HBCiPHoLGR7FVv1DzQ0WZG2U7RtR0A5pKfFTh6Kb2/Cl2NvFWklBCxyCbU84Cfq4FWMXpfJ86yUain7p6BisL0GRIl6AG6tZGaWXlFzgENnc+ZJs0m7xuHG2rGmzoFlCW3W2sbjKJIf/mFOa/ru6Eg2CwhNQqHx30bUJHsF/BgJXjCoxGdVHxmlvuBfe71FwpIAUmXg0Csh8SotXc0nAVgagjJBaQy1DSSlWVHlOxQ3x6DQlM8z2yDbex6kQz6WMu+A68fQt08VPl7oLO3zWbyKu0YLrE4OmEkSSx1rUFsyWoIdcPbvCEV3VcjkVK8F3L14WEP12iAQI99C+wUVfURTI/vIaLoBgqD7wFpNCTmsGNsDAqKRlQWc/ygv9ari2Ymi/20+yIrobrEzrY5R4lbJpw46MAjH8/yqFSwPWJ5AKFRrXcT2lOlc5TcM/pONNdl/Vi2v+6RY+uODUxzABafykqDXykqNCdKHpS+g2mbdYPiPU8xduEgaNF9s9H9Nsm9phd2emC9XEgO9iCnxHW4dcSdh9SDT2k+pJgHIXX7FUJ2y/X6hyZZb8bdVuuANTDkoqw6MWNnMvRyA1mOoKKt1ig/RH+MZlz3OA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmhnbkJPVk5KNjNMaTdlZWlJV20reXg5NXBCUlJUaFJEclJCT1FoaERMRUNB?=
 =?utf-8?B?TkhzVFVoZE9DdUVkL3IycmJ5cTNmZHUzNTNMeDNPcDJGSEJBLy8wM3FhQ2xR?=
 =?utf-8?B?MHh0UUVwYlVVcVBBY3RCYWJsdnF4S05JRmwrbzl3WmN0UXYwRXFmcEpVOTdz?=
 =?utf-8?B?TTVSZDRmQnI1ejhRMmRERmRtbGh3NGxsTUUxT2tqSTdONzlNeUVCdThEWmly?=
 =?utf-8?B?Mk9YaERRMnJra0lKaDhJMk9iMW9maGVZOE1LTjZ2QkhZalhQbHlKNDJJWDdN?=
 =?utf-8?B?Q28wNGIrM0FIcWhraHJia0c3SmNoZEUzSHQwdmlMOHhaM3h5RTdMUjQrZDQx?=
 =?utf-8?B?ZkMvTUtmUDNIMi8rTGd6K2dOV2NUUkRVVlU2Y1JqQnFwb2Zla25abDdVa1Av?=
 =?utf-8?B?bkxBaEpvL0NnSmRTaVFGaFpvS3pwdUp3L1VXZ28wWDVzZHY4S2tOWXZsYW55?=
 =?utf-8?B?ZFFMSU5LUXptaTBTQ3lVQ0FVRzREcVhzdzY2UGY1ZHNETHNQeHdnTGwxdlA0?=
 =?utf-8?B?UjA0cEs3MnNtVUwxeldoN1lOK3dMN1NOcU8yV1VZc1UyclMrMFhrUjJtakpj?=
 =?utf-8?B?d2l1ODJyUFpoS3pNbDk0UG0vbWdpenlKUWV3YW1vUDdSckRyTEQ5ZnIzLzQ3?=
 =?utf-8?B?ZmNCUzMzZjFIUmgzTWowN1dTM3J5SjM0LzhZdHJ2N2wzRDg1WkxMamQvcjFZ?=
 =?utf-8?B?NC9pZlBQQ2lJbmxqelFoYWNoOUJiWEtuemtiR04zYnNiV2Y5K2oyKzdyUjha?=
 =?utf-8?B?Ny9GTVhDTUovTWpkdng2UUdseG5HL05BRFVVb3FLSjRmVXF6T0dtaEMyOUVu?=
 =?utf-8?B?ZkI3UVdVVGxHamF2cGZJWk42dGRITXBFK1lORjd4eGhwOFExV0tYRkM0Y0th?=
 =?utf-8?B?TEtQL0xlbFRjWFpreEZyY3g5enZySGRQdEgyZkhkWmFsVkxDVHA4WDNWS1VD?=
 =?utf-8?B?UGNEcnFWWi9xeGFrS1dPNjBMeWlaQ2pDNHpIak5rVENjQlB6SGszaHh4ZUxL?=
 =?utf-8?B?QkNhSFE3NFJsUlBUSFAzMG9WOWRBNkYra2xWV3czL1c5Yy9FNlY1R1B6U3Vp?=
 =?utf-8?B?TnROV3o2R2hncEkyalFQZ0dlNkRWSXBjdGtVQ1dqS1Q4Z3BCWXM0T2FaeVk1?=
 =?utf-8?B?LzB1cGdEN1JZR0o3d285N01TWnlCM2J4QkxUUllkOExSeTZRbUUvNFJTcDVm?=
 =?utf-8?B?VFpTcTIxRUQ1RllLREk4eXBZK1R2VHlOK05DZkIyam5TVHhTSDlvMWtoaWxu?=
 =?utf-8?B?aGlVVzFoSTA2a3VsNzQ3M1Jyd3MxVVMzUWRHYVhFU3ZWSVNvS3ZJRitZZ3dB?=
 =?utf-8?B?NWlHVVYzcTg2VkYyY0RrVGdOVkFsUXo5ZG5UdUtibFMwa0tnSTBvTThTLzZE?=
 =?utf-8?B?UzFKL0NBYjVUZktDNnF4dHlrTTU5SmNQeFduNWJ0SVUyUHg2NURkb3kxd05G?=
 =?utf-8?B?VHRTSm1iRVkyN3E1Q09VN000Q0FOb1UwOS9NR01RZEl1TG1nRkcwMFgrWE5F?=
 =?utf-8?B?cHdwS3dqM1dZb3czR3Y0WHFFV2EranV4UTVIenJCQU1uNmViUzlYOExzaTZI?=
 =?utf-8?B?YmxpbWY3ZmFyVFpzT0FhSWRtclQ4OEN2NGVKNVl5OXNOV21vY3R4OFZzUWdM?=
 =?utf-8?B?QXBYSXMrSjJiaGMwZDVRL0pMVmJxZ2JIQUZJRVR0SXkyQjdrZ1FMTkxqS25N?=
 =?utf-8?B?T2N5U0xrK0plTGxqa3hzVFByRXRYSi9UWmhUMEZvRE0wVVZlYSt5dHRydW5P?=
 =?utf-8?B?Z3k4cEdHOTh5aU5RSlNuQStjWnExTjhENmFqUGhmd2RRdld5cnpzYVFKL0NG?=
 =?utf-8?B?Nml4M3VaOFUzOUxTUWc3dW9TQ2dvN09jNVVydXF1eTBpSGQwMEFIMUs2TFMr?=
 =?utf-8?B?UCs3dG9TNVltZmZIdUpvWWxWWFNZbW5JbWNtaW83ZGVoSCtxb2xDVHRhTURN?=
 =?utf-8?B?cXBJSXI1cWpTdjFaT3VzME5QcEl3V0hKVjdVaGt3YVNZb2ZSN2pNSWVKRGxy?=
 =?utf-8?B?QlNhYkJ1UFR4enFKR1lBeGNGeVNNM0xzM1RUNjlpT1JINWptS29kKzRUS3ds?=
 =?utf-8?B?MGt6aVVnb041UENaeVE3Zm9uTU1hTXBRNzNNUUVBTGtNbjRuQlVBTmVnVWt3?=
 =?utf-8?B?b0xIdmVxVUczTExoSW9qS0Qzdm9WWlBWR3ZXK1Q4ZHFHWXZrYkw2WVJ5N1Iv?=
 =?utf-8?B?LzAzSkltY0l5bWNEeGRQeEkxYW40SHNCc3VJNkpPNG1mOGlLWjI5MG9GbkVJ?=
 =?utf-8?B?bUpDYmtGYVJQeVcrU2ZqQTFTRjlCd0tnT3ZpKzE2Qk5TTk9ZVVhrSTBHdmZw?=
 =?utf-8?B?cjlyTHdRMFpzVVdFRkJ4TENOUzBjQ0tOTWFpMFZGdlN5STQ2Z3FEZFFKWTZ4?=
 =?utf-8?Q?DjnJOr11MgUMkw2Q=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5b0a6c-afed-482e-2198-08df205693d4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:27:13.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btTJ4aPBvUYUxHRQY6eiO11uQdUitYR0s6PYgPdZekViW4xckNicBN6sI6zuEFl6CuEhePQZiT8BSZE9F36xlAk4M6OikiOYeL0Wh1GncqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR06MB910975

Hi Hugo,

On Thu, 1 Oct 2026 15:11:25 -0400, Hugo Villeneuve wrote:
> > never shorter than requested, and capping at the 15 bit-times the
> > 4-bit field can hold. Centralize the HDPIXDELAY and MODE1.TRNSCVCTRL
> > programming in max310x_set_rts_ctl_params(), called from
> > set_termios() (the conversion depends on the baud rate), the
> > rs485-config worker and startup(), which each had their own copy.
>
> Could this centralization be done in a separate patch, without
> any functional changes intented, in order to facilitate the
> review of this patch?

Yes, good idea. In v6 this becomes two patches: one that only
introduces max310x_set_rts_ctl_params() and folds the three existing
copies into it, still writing the raw millisecond values (no
functional change), and this one, which then only adds the baud
caching and the millisecond-to-bit-time conversion inside the helper.

Your earlier comment on this patch is also folded in: break_ctl()
keeps the single max310x_rts_ctl(port, break_state) call at the end
instead of duplicating it in both branches.

Tapio

