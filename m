Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713114A82;
	Thu, 12 Dec 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969092; cv=fail; b=BfYEjJ+yMpEP7gwJrz48/RX954TscIwKm7dMqyOilU606236XYFffuQy2MWX5P0dq8N2CDQ0qeYI7niGsNKBdyjpVc1MMjn+KMKmE5+je1x6mPOidI8WwnbvpOWK5TWmX1YQUEZc1MY8QA5XKgeh0wk6UtaNDCHFYnEG8tjIkXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969092; c=relaxed/simple;
	bh=ilSzw/OIcH5EcWOrQnMMvID/3p0fDRIFFLbfaeDBAvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DpAT6cmjQL3Ak+xF04Q91HjU9LXk2vRgy6DQTDC4x5LadohBnIoFXTzmltFu3W6wwIpyrw9vvzbCoaaNT0OLBQzLVoIagZPR858qK6bROZKaubaBrVZYpna9NnoFirRdAArsoA25kPu6cvft0yGUFWkDfNndMErFFnLiYC+tOmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=sWZGKmb/; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="sWZGKmb/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+9wegG6blCy2pVgVtGWNcCupZWkqQFRKHnP0w5dog9HzrRE/ew+QAITi1/swtXKWGMONNYMpTpKc1+QpnBnZXaWPMgVRAlFWMs99JBFNqBQ27zQU/Y/F4fRmBJHfCgcNhcnZnDOxz8A+YtifOW/ddM30UCUipRJPMbHBvaEsb60HdZYj5xaryttF9UMyDMFNvT79mFbiFAnS5xipeL8z9Dn9UIPq302auBaObtoRL6v0qeFA3+TZDh3zDbbrls6TGGbVaKVF7QHnnPSBoeo5rzbyQWC/BUeT6zkZelwcXU6IwJuYob+Vh5U7HFxGqp0ZsoiN87Rqi4tBzwDYYwxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDUm6B4sqtddyuVu0pQDrsv+ubh81YF65GIIuJHxDWk=;
 b=iDtjz4P4eVpM3PzgeQ2YYi+AyTnMk/DlOuq7cPoJc2Mw/GJCmkck90eR1EfZ1Fc5bxwlSiwsGKKf5zHMKu0Ewf0nidYy7+AYg0NPEiRLpqbSqET3BzqQGvFpWO6i93BKatltj37dqgYZw5SlLu+lNjAclC12h/lIsudLtfUMx6ZlFR5BhDpRu/Ak4ivRPbfadMe01bGEVlWcVZCNRx+XAZ+FEAN+mpchJ0HxLTq7UB3R3X7clJlvRZDnvSMoQYorHiC/g0RsfR0iQYYUj0IG9uKs1dRD1qkLvPHz48H6O/pSdnXx20tY6MLvyo3WSFv1VUd3aDI2/A+aVzDwL6WvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDUm6B4sqtddyuVu0pQDrsv+ubh81YF65GIIuJHxDWk=;
 b=sWZGKmb/fowS/jq4doV0bfHOreKc1yrccXt2tXGJ0LMG+6Fu6OKSkx6cjXvtM/vKeVfVw0+54pgoNqVj0CXU6taHb33eGm1nakmvdYhECyplP+JLztdT55R2nB+NVfMXx4mEyzhERRFItrws3YnxtNIppN494vbzdsJ1UbWDpKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ab::17)
 by PR3P193MB1053.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 02:04:45 +0000
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486]) by PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:04:45 +0000
Message-ID: <dd42e362-eba1-4e12-afe5-f71ae048a316@kunbus.com>
Date: Thu, 12 Dec 2024 03:04:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: amba-pl011: Fix RTS handling in RS485 mode
To: ondra@faster.cz, Russell King <linux@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20241206-master-v2-1-02628dc036c9@faster.cz>
Content-Language: en-US
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20241206-master-v2-1-02628dc036c9@faster.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:ab::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P193MB0846:EE_|PR3P193MB1053:EE_
X-MS-Office365-Filtering-Correlation-Id: 9059634e-e6be-4e43-b2f2-08dd1a515971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|52116014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDVhMzE5ZXdOMllpNzBISzFRZmN4YmJtVVRKM3VqOWREKzVRek5NeXFSWDUy?=
 =?utf-8?B?L1owSzcrSkw3VnlHayttWk9mYmZHSDZnZ1NTNVNETU9JTkg4emdYTUJxNTY5?=
 =?utf-8?B?OFVsV2FCQnROaWRyZDFmcVZlSFYwUHdOS3YvNlMwVXh5UHBRSEVXOTU4NmZ2?=
 =?utf-8?B?cnl0MUM1OFNuVE5jT1g5Nkp3blhkeUZEM2x2SC9jT1BxSWlndzM1dnViZHFj?=
 =?utf-8?B?OXA5amRXNkVkUHZxd09lbzFRMHZva3R3MEhlM3E5dHNLMHU1TmxHM3p3MHhr?=
 =?utf-8?B?eEtNZkcrL3ZINDZWRTk0aFp1NVNwb1ZlTzNTMWJqV2V3YmUzcDB3L0xSYlJx?=
 =?utf-8?B?eWlTMzF5MXA1SmUwWFlDSjkyaWZZKzdOd1kyU3p3TEtTNVlsMkZzL1lZZStv?=
 =?utf-8?B?aDRtbkVDT0pQWjVtQVc5ZkwwUlUzRkVNSjhyMlVWRDJUVzR1bGNHRUZOM2o1?=
 =?utf-8?B?dDloUmwxUEtmN1lla0xEZG11a3NVdmJyWkEyT3pUN1RTUFFJNlNmUFd5Ulpo?=
 =?utf-8?B?K2Q2SjZjUTBzUVRIaXl3V3lxaXh1alFiODVuOE9yMWw0eDRITi81U0RLeTNl?=
 =?utf-8?B?OTFnY3RPaS9TUkswbW82MXh1UW85RTRvbzkvV1VjZTdLNEdaQnJLWFNhM2NH?=
 =?utf-8?B?RTZNWTRkdUFHRjVyT0NteHBhR2dQendOVkIrQm1PT3hHa3NmLzJuU3VpVVpn?=
 =?utf-8?B?VmtGMVkzRWkveFRJeUZ6a2paM2YrQXRqOUU0SlZNekUrV24vYUZzQWd2QzRW?=
 =?utf-8?B?dXgrTWUvdm1jTnFuZWFKbGppbHdNSnY2Q29NN3RQNHVRV2JrUkt6M2UzWDBu?=
 =?utf-8?B?SG9XZHJIYXNlYlQ3bWErc3BFNzBPR3Q1NHlkdUkycDZaUUdpREw4dG1UZkRz?=
 =?utf-8?B?UGRoTFZLcmhRcHprb2dUS3NwS0xIWlBWOGQydmlQWlNoR2hFU290NFA5UzF2?=
 =?utf-8?B?b2RNSDdCYVpmaW02ZjA0N0RkZWcyMUN2SEtpSUNPNEY2WENtWmN5OERURTZw?=
 =?utf-8?B?Tzg0SVlMUkZGTWc0a1cyVWlkMzNEVmpoNGRMTzhSL2c5WjM1NkpiMkNmZDFL?=
 =?utf-8?B?clBmanZMckRhcndPMUNMdXk1OU9EU28zUEVObXcwd3NMQkJtbGsrUmZmcWdK?=
 =?utf-8?B?MW11bldUWlRyOXJ6WmFNVjh0T0RFbGMyUDRVdkFOcUs1ckFoaWN3SmJmV0ds?=
 =?utf-8?B?QWdWVTk0QXFQMDdzZENzZldOUm9WM05hTjZOVWhKS1pScjI2OXErNWJzS1lw?=
 =?utf-8?B?VWcxdFNNSkVGaVVxYlY0clNNTVMxamZiVmNZc1ZQNHFIcnZCTFJyRE1rajFh?=
 =?utf-8?B?ZytkNkV4M1BRUnVOamdZM1RySkxFR2xHL1Q5NHA0VW40dkh1eHVYT1B0SjMx?=
 =?utf-8?B?d0w2UmsxLzFBR1hBdUgya1o3VXFvSWNaL0N1WUtTdmRNcTNzU3NWOHJCcldN?=
 =?utf-8?B?aUFDK1Yrd0VRb3pKQWVOTXhDY0s4TE9OOVZvT05vYXVPSHlXNmhlQ3FpMk04?=
 =?utf-8?B?eDZLWTZRSFhFeE0wbnZKQWFpVFBYTmtmQ045c3I1eXhoUG9sRFY0R3JPWGNm?=
 =?utf-8?B?ZnkxclFtRlZ1Sms3TDA1RVhyYmorUXF0aUNTOG0zWXhIVWhmWWFxMzZlR0RT?=
 =?utf-8?B?bXFUcDRDT3dQM1NGdzhqbTdQYWZxVHZ0QW5hVjJXZ1B0SkhwcFJ5SWVJdFFh?=
 =?utf-8?B?Y1JDdkltWHpaKy9MMHFGblY3c3MwdVlhaTZiT2drWlBGS2VHaFNqbXhzNEtM?=
 =?utf-8?B?R0p2bVZaeU5TNUxQT0pCbGJ3VkxnYUw4bmw2TFI3cFN6bU1PZkpicGx2NU5K?=
 =?utf-8?Q?KmHVadGnOUuBm+iTfVVTRv2lRJyWk7+Uh4zf0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0846.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(52116014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFJejJTNnBkdEgrc1ZacU82SCtWTXFlWWRBWjlJME80MU9TVklJMVpFS1R1?=
 =?utf-8?B?NWxvVGpRaGFQZ2JKdFRxeTE4KzA0WnNmekg5b0oxa1R4RFl4WmhhV1Z2VnZZ?=
 =?utf-8?B?TWdGcmpHZ1hPV1VWQTAvVFkxd1VDcmtSM281N1QxTDBKVlkvUUJQUFkxTHB3?=
 =?utf-8?B?VFRTUkNYZWxRdGdiRXlNTTZpZW9qcEMzcjNMaTNadnI2WXpMUndnSTNoZkFS?=
 =?utf-8?B?cEpKK2NOeXZDNDY2d01xUXAxSDNEcmFjaElEbVIwdG5jZlJDQ29oV1duQnZh?=
 =?utf-8?B?TEM3UXptWGpmclFlZThRYjFsZDBBN285QVFFbVJvRjJ2SDZHUk04ZWFzc1Mv?=
 =?utf-8?B?RENvUmRaM1ZSTlR5b3FBYTZZUUN1ZGU2aW1jenBOdXVKcWhGR1FDVGhwREZp?=
 =?utf-8?B?VWoyTUhGemRJZWdoU0MwVU9kaUpQZGFpdmdNK1RXYWpvUVFOK3lTMmhoNnhw?=
 =?utf-8?B?aStJcUR5d2hJaUN0S3l5MkVuL2ExZ1NsbTd6aGJVV1RtazRkTmdkc1IzeHlq?=
 =?utf-8?B?S05kMUVJMnhQbjBMWkNNV25jdWM2QVo5RWdRRzJpcGhjTm5PdG5TeUlCUE9G?=
 =?utf-8?B?YlduNjFPdFV2Y1NuQk1mWmx2ZHljd3hyTDk1dGJSdHBOMldaYXNTQUpCV2E2?=
 =?utf-8?B?MlRpWTE3WjZmRmhHeTZqL0Z4ZFFJanpLQkIwSGFLNWV2ODN4WFJxU2ZVQjBF?=
 =?utf-8?B?R05XamhOUkhTNGxiWjluSENDc2VmZnZRbTNPZUdJR2NtMU1uQzdTOWVaV0V3?=
 =?utf-8?B?YnVkSmtKVXphMkZiU0RsVkdxNW1Rc3ozMXNxcjRXaVloaERmZ2kxdmV5UG52?=
 =?utf-8?B?TE1KRnFuS0RBTVpjWGI1RVl1QXdZSm5nMmxWWklsb054SEVVVTE3QjdWUVlr?=
 =?utf-8?B?SXNGM2YxQlhMTnNxOTd6QVQyZ3huVXAwbjBtNGNJbVluaFBPMFNCUXNKLytl?=
 =?utf-8?B?Q2poYTRqTEVwcnQzQWdWQ3FJdEZXdkhyTjNQVHJGVGxlYzFOQ1VYN2IrL25J?=
 =?utf-8?B?cGJ6VDB0aW94WmhVaGhiZTEvU0hqVlIyQW9nOGZIMUdackd5ckRhcllRQVdj?=
 =?utf-8?B?UWFYM3dLMkRQTnJsSWZVZUtpTlB6djJqRjlwRVFRSWJkRkd0ZTkrdEc5QjU5?=
 =?utf-8?B?VVNWYWhDWkpRTmdtNDYyZ0I2bmFpQ0xUODVzVWkzK0VCMmhobStXVG1jcFhQ?=
 =?utf-8?B?bG1qanNXa1lwRHRLWFlicUNRbXNNTCtHUnlZQzZjMlRsQTYvamFXbjNkZFJl?=
 =?utf-8?B?Wmxodm5JdFY2UW44R2RWVGJWTENmNGc1NUUzYkZjU0xTTnhKRVZEYktIN2g5?=
 =?utf-8?B?WlBZWlNQSnNDUTdDQXp0SzEvRStPZUtFV0gwMEhaL3hHYUJqQzFheE1KQWpa?=
 =?utf-8?B?aDNHWVhEeUdyRm9IWnhSdno0aUZCT0pUb3lLdTRnTXN0K1M0NVBkQ2k2U3Fr?=
 =?utf-8?B?a2cwbWF6VG04ZHNqTXlnZUlZcTlINlAwSFhLTHUzaEhJODlzU1Z5SnlYZ3lz?=
 =?utf-8?B?T00vTHk2QnR2aHYxa1hoeGNKd2ZDbzUzRmx0NWJiOFVZTGNWR1JaOG1MUElp?=
 =?utf-8?B?WkUwRm5CTHgycUNrUEptblFjQkwraE0yaVlLNEp0cmZ6VHQ3bWpCUWpIdkpy?=
 =?utf-8?B?L3dGRnVJMmlUdkxqODVPSjdVRDhITXE3clR2QU9BL0FVZDZFSUhoa3FYTVQ0?=
 =?utf-8?B?NVdXZHBtSUtDNDZVK1crbCtsUzV0dEFuRHJ4cStxUlpsNHZxMDE1SDlBVnph?=
 =?utf-8?B?dGN5aTY4RVlIbUQ1amVYNXVhNWV1QTQrTGpUR3JQbzJhdnZWZnJxRWpaMHNw?=
 =?utf-8?B?WjFQNEhVVnZ5SWljUTFhYlpSc1owbGRQZjZtcDlvYU5veXFtOE52NWN4N1lS?=
 =?utf-8?B?aHdXdlAxOWExQ3BMYzNlQ1RhOUNPb0Q1NmJONWF4TDllYXdZRTlHZzZ4ZnQ2?=
 =?utf-8?B?dXRWenVuZXRmbFFIcmFHTy84VlVFajRkQzRTREpZemZJNHFTdmZRbXlIWGxz?=
 =?utf-8?B?WU1nVUgrVDMzdlJhS2lCRHJZVTV1cUtwU0Z4NTNueVhQTnVaSXcwWk1JSGVB?=
 =?utf-8?B?aXcrakFlYXF1cVo4dytIS2FYYzFrL29vNUZuYWpvcVJ4QmNDSnRFNjJiaStF?=
 =?utf-8?B?d0ZBMUVVdmpIZTNHTmdQUXh0SGhSTDJ0YXROdXpnaWgxdHFBVHRTa3lGdVRi?=
 =?utf-8?B?azQ0cm82RTBsaFM2eVBYTUV6b2h5a1RtaXlYbXEvanRDY0VVbVhJSzlFeEsw?=
 =?utf-8?B?QllaZ1lMOFRKcXcydzVQVGlweVB3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9059634e-e6be-4e43-b2f2-08dd1a515971
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 02:04:45.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwfSnyR5x2N49AZhrpPOJ/PGYhtPwCe05xhMtF3kekZym1+toea6KtDvgqnbGWHqB+dnGZyf00502AiCLagoLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1053


Hi Miroslav,

On 06.12.24 20:30, Miroslav Ondra via B4 Relay wrote:
> From: Miroslav Ondra <ondra@faster.cz>
> 
> Data loss on serial line was observed during communication through
> serial ports ttyAMA1 and ttyAMA2 interconnected via RS485 transcievers.
> Both ports are in one BCM2711 (Compute Module CM40) and they share
> the same interrupt line.
> 
> The problem is caused by long waiting for tx queue flush in the function
> pl011_rs485_tx_stop. Udelay or mdelay are used to wait.
> The function is called from the interrupt handler. If multiple devices
> share a single interrupt line, late processing of pending interrupts
> and data loss may occur. When operation of both devices are synchronous,
> collisions are quite often.
> 
> This rework is based on the method used in tty/serial/imx.c
> Use hrtimer instead of udelay and mdelay calls.
> Replace simple bool variable rs485_tx_started by 4-state variable
> rs485_tx_state.


Thanks for that patch!

I came across the same issue (data corruption/data loss) when working with the Raspberry PI CM4.
I was able to solve it by putting the processing of the tx chars into a worker
thread instead of the interrupt handler. 

However I like your timer-based solution more, because it is less invasive concerning
the non-RS485 code.

I tested your solution and at least for our use case (periodically sending short
frames over two RS485 connections at the same time) it fixes the problem. 

So at least for this scenario

Tested-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>


Best Regards,
Lino



> 
> Signed-off-by: Miroslav Ondra <ondra@faster.cz>
> ---
> Thanks Greg for the advice.
>  
> ---
> Changes in v2:
> - Reword commit message to explain the problem.
> - Link to v1: https://lore.kernel.org/r/20241123-master-v1-1-260194426ea3@faster.cz
> ---
>  drivers/tty/serial/amba-pl011.c | 126 ++++++++++++++++++++++++++++++----------
>  1 file changed, 96 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 69b7a3e1e418e200944b0b0429b6341d71ecff26..04212c823a91d5a343327292d8ffd95be1465473 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -248,6 +248,13 @@ struct pl011_dmatx_data {
>  	bool			queued;
>  };
>  
> +enum pl011_rs485_tx_state {
> +	OFF,
> +	WAIT_AFTER_RTS,
> +	SEND,
> +	WAIT_AFTER_SEND,
> +};
> +
>  /*
>   * We wrap our port structure around the generic uart_port.
>   */
> @@ -261,8 +268,10 @@ struct uart_amba_port {
>  	unsigned int		fifosize;	/* vendor-specific */
>  	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
>  	char			type[12];
> -	bool			rs485_tx_started;
> -	unsigned int		rs485_tx_drain_interval; /* usecs */
> +	ktime_t			rs485_tx_drain_interval; /* nano */
> +	enum pl011_rs485_tx_state	rs485_tx_state;
> +	struct hrtimer		trigger_start_tx;
> +	struct hrtimer		trigger_stop_tx;
>  #ifdef CONFIG_DMA_ENGINE
>  	/* DMA stuff */
>  	unsigned int		dmacr;		/* dma control reg */
> @@ -1260,30 +1269,31 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
>  
>  static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
>  {
> -	/*
> -	 * To be on the safe side only time out after twice as many iterations
> -	 * as fifo size.
> -	 */
> -	const int MAX_TX_DRAIN_ITERS = uap->port.fifosize * 2;
>  	struct uart_port *port = &uap->port;
> -	int i = 0;
>  	u32 cr;
>  
> -	/* Wait until hardware tx queue is empty */
> -	while (!pl011_tx_empty(port)) {
> -		if (i > MAX_TX_DRAIN_ITERS) {
> -			dev_warn(port->dev,
> -				 "timeout while draining hardware tx queue\n");
> -			break;
> -		}
> +	if (uap->rs485_tx_state == SEND)
> +		uap->rs485_tx_state = WAIT_AFTER_SEND;
>  
> -		udelay(uap->rs485_tx_drain_interval);
> -		i++;
> +	if (uap->rs485_tx_state == WAIT_AFTER_SEND) {
> +		/* Schedule hrtimer if tx queue not empty */
> +		if (!pl011_tx_empty(port)) {
> +			hrtimer_start(&uap->trigger_stop_tx,
> +				      uap->rs485_tx_drain_interval,
> +				      HRTIMER_MODE_REL);
> +			return;
> +		}
> +		if (port->rs485.delay_rts_after_send > 0) {
> +			hrtimer_start(&uap->trigger_stop_tx,
> +				      ms_to_ktime(port->rs485.delay_rts_after_send),
> +				      HRTIMER_MODE_REL);
> +			return;
> +		}
> +		/* Continue without any delay */
> +	} else if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +		hrtimer_try_to_cancel(&uap->trigger_start_tx);
>  	}
>  
> -	if (port->rs485.delay_rts_after_send)
> -		mdelay(port->rs485.delay_rts_after_send);
> -
>  	cr = pl011_read(uap, REG_CR);
>  
>  	if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> @@ -1296,7 +1306,7 @@ static void pl011_rs485_tx_stop(struct uart_amba_port *uap)
>  	cr |= UART011_CR_RXE;
>  	pl011_write(cr, uap, REG_CR);
>  
> -	uap->rs485_tx_started = false;
> +	uap->rs485_tx_state = OFF;
>  }
>  
>  static void pl011_stop_tx(struct uart_port *port)
> @@ -1304,11 +1314,18 @@ static void pl011_stop_tx(struct uart_port *port)
>  	struct uart_amba_port *uap =
>  	    container_of(port, struct uart_amba_port, port);
>  
> +	if (port->rs485.flags & SER_RS485_ENABLED &&
> +	    uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +		pl011_rs485_tx_stop(uap);
> +		return;
> +	}
> +
>  	uap->im &= ~UART011_TXIM;
>  	pl011_write(uap->im, uap, REG_IMSC);
>  	pl011_dma_tx_stop(uap);
>  
> -	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
> +	if (port->rs485.flags & SER_RS485_ENABLED &&
> +	    uap->rs485_tx_state != OFF)
>  		pl011_rs485_tx_stop(uap);
>  }
>  
> @@ -1328,10 +1345,19 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
>  	struct uart_port *port = &uap->port;
>  	u32 cr;
>  
> +	if (uap->rs485_tx_state == WAIT_AFTER_RTS) {
> +		uap->rs485_tx_state = SEND;
> +		return;
> +	}
> +	if (uap->rs485_tx_state == WAIT_AFTER_SEND) {
> +		hrtimer_try_to_cancel(&uap->trigger_stop_tx);
> +		uap->rs485_tx_state = SEND;
> +		return;
> +	}
> +	/* uap->rs485_tx_state == OFF */
>  	/* Enable transmitter */
>  	cr = pl011_read(uap, REG_CR);
>  	cr |= UART011_CR_TXE;
> -
>  	/* Disable receiver if half-duplex */
>  	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
>  		cr &= ~UART011_CR_RXE;
> @@ -1343,10 +1369,14 @@ static void pl011_rs485_tx_start(struct uart_amba_port *uap)
>  
>  	pl011_write(cr, uap, REG_CR);
>  
> -	if (port->rs485.delay_rts_before_send)
> -		mdelay(port->rs485.delay_rts_before_send);
> -
> -	uap->rs485_tx_started = true;
> +	if (port->rs485.delay_rts_before_send > 0) {
> +		uap->rs485_tx_state = WAIT_AFTER_RTS;
> +		hrtimer_start(&uap->trigger_start_tx,
> +			      ms_to_ktime(port->rs485.delay_rts_before_send),
> +			      HRTIMER_MODE_REL);
> +	} else {
> +		uap->rs485_tx_state = SEND;
> +	}
>  }
>  
>  static void pl011_start_tx(struct uart_port *port)
> @@ -1355,13 +1385,44 @@ static void pl011_start_tx(struct uart_port *port)
>  	    container_of(port, struct uart_amba_port, port);
>  
>  	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
> -	    !uap->rs485_tx_started)
> +	    uap->rs485_tx_state != SEND) {
>  		pl011_rs485_tx_start(uap);
> +		if (uap->rs485_tx_state == WAIT_AFTER_RTS)
> +			return;
> +	}
>  
>  	if (!pl011_dma_tx_start(uap))
>  		pl011_start_tx_pio(uap);
>  }
>  
> +static enum hrtimer_restart pl011_trigger_start_tx(struct hrtimer *t)
> +{
> +	struct uart_amba_port *uap =
> +	    container_of(t, struct uart_amba_port, trigger_start_tx);
> +	unsigned long flags;
> +
> +	uart_port_lock_irqsave(&uap->port, &flags);
> +	if (uap->rs485_tx_state == WAIT_AFTER_RTS)
> +		pl011_start_tx(&uap->port);
> +	uart_port_unlock_irqrestore(&uap->port, flags);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +static enum hrtimer_restart pl011_trigger_stop_tx(struct hrtimer *t)
> +{
> +	struct uart_amba_port *uap =
> +	    container_of(t, struct uart_amba_port, trigger_stop_tx);
> +	unsigned long flags;
> +
> +	uart_port_lock_irqsave(&uap->port, &flags);
> +	if (uap->rs485_tx_state == WAIT_AFTER_SEND)
> +		pl011_rs485_tx_stop(uap);
> +	uart_port_unlock_irqrestore(&uap->port, flags);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
>  static void pl011_stop_rx(struct uart_port *port)
>  {
>  	struct uart_amba_port *uap =
> @@ -1953,7 +2014,7 @@ static void pl011_shutdown(struct uart_port *port)
>  
>  	pl011_dma_shutdown(uap);
>  
> -	if ((port->rs485.flags & SER_RS485_ENABLED) && uap->rs485_tx_started)
> +	if ((port->rs485.flags & SER_RS485_ENABLED && uap->rs485_tx_state != OFF))
>  		pl011_rs485_tx_stop(uap);
>  
>  	free_irq(uap->port.irq, uap);
> @@ -2098,7 +2159,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
>  	 * with the given baud rate. We use this as the poll interval when we
>  	 * wait for the tx queue to empty.
>  	 */
> -	uap->rs485_tx_drain_interval = DIV_ROUND_UP(bits * 1000 * 1000, baud);
> +	uap->rs485_tx_drain_interval = ns_to_ktime(DIV_ROUND_UP(bits * NSEC_PER_SEC, baud));
>  
>  	pl011_setup_status_masks(port, termios);
>  
> @@ -2807,6 +2868,11 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
>  		}
>  	}
>  
> +	hrtimer_init(&uap->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&uap->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	uap->trigger_start_tx.function = pl011_trigger_start_tx;
> +	uap->trigger_stop_tx.function = pl011_trigger_stop_tx;
> +
>  	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
>  	if (ret)
>  		return ret;
> 
> ---
> base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
> change-id: 20241117-master-9df0434f1e04
> 
> Best regards,
