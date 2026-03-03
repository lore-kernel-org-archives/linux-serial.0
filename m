Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023141.outbound.protection.outlook.com [52.101.127.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BA29BD82;
	Tue,  3 Mar 2026 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772504347; cv=fail; b=FcZe+0pXdJXJKd9Ar3vIVGoABCR5xmpa+eoy4IBLW4rpk16B8jVhZlG++bcWwnZtV4kxnO+dr8cuaKds/rmUdeRflbsQ3UWiNmRMO3hlUrq8vignk1JLHuQxWk2pTPRG4TtJ2WWaQfpcXOGBeDaTD74ZH/0Cr3QPrpPhgKRM/UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772504347; c=relaxed/simple;
	bh=NhrKBkulCUR+tGLQU7M+VIoxsofbrm4zv6J5eup0S/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bzyc62/DSzummIQmF6NrgPHSmDd1hyNc0ISCir4SE6NJ92Dns2rclVRH7H504aoXxC8QYa352ubDTebsWRicDbpySoZjW6hiknmUw4vhfuYd02I9t0z3UDRe5B69gXrJUG8ZwOu/0Ojex0jioXMzJTc5MVzfVjmjoiu8hV4yVfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Zg8dhho1; arc=fail smtp.client-ip=52.101.127.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Zg8dhho1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUPNijXuBzSayp7/SxGuNG7Z3o82SE0XxSxa/lHy4xQe1AGK7Syk6hnU9fLn/wQKworUvLrBtHGcJ8L/048kyYEi90RMKR5yG4Wj1VtO3Hn6XBpwKWMYK4A/XJQk2NiWfQS6xV31ovo0XHX0HMdbcVqfOJxfzqIEwtNHJrxBNFzJVKJ4HkF3D0Zi5UmLwZEuc0w8Obzi/QqgrXuEYW87ZIFuvls7ToPWH3upghzwiymb1bUmv8snr4++nGEod0oiiI840N+yZh2ceQFYgtt9hpSyQ94ZV2Op+4ytBMbjH+dlcBCMvqjEixRsyzDAQtQUhvCesVmgUH8zXKHBxNjRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PU7AodaWwrGsUF212+xDbfz9qG8uN6XX8BHZff5tjs=;
 b=JTFivDP/T0804ESvczo6W1r0jqn2mOjkN6W+w44WVBRpk4dDbOoPT+/skCV+n/5QDScZL6cpcmxcn15w1+GKJRw59ppGjN8TRqju1gN9ZczQADFcdRUyKUeYaQlS6/4DU3Yrsm6licB3B9z5pZOHOgGf6xLV2DSjxcVKgNuVif3rEELnw2U1LFIzMh8YIs5INYwyNnQM/nxch/xhECYRWUxak9WtM7vtHyCotAk8LCN3GXejMoTHQ8WkahORdlrNRRQhuDxD4k7A2yMiKG5QJbiW/VGei+O6keuGgT7e0x7yNCZAXM3Hort1myC+0IDx863xndaOpMWSVGm0BIeXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PU7AodaWwrGsUF212+xDbfz9qG8uN6XX8BHZff5tjs=;
 b=Zg8dhho1YgdwVavJaYLmiZ5dtYUOnMpzFokQ2Q4zmGvJKdv1h2vKaLVkuBgU8o3W3Swgx8YCmDwFPzMDJ0IQGjjzpXiqu6VEw0nYUoHTrghE/Wbmev8/nrmz4nZ0h0B5iEsfNvioSiXBliC7kYutOWir4/MTqgOjRjb6GethCE9zxIsrryiJnk/YgW1rljsrFxiw/1jIQ3Zu+lFenPqF3Fer/s2WtHQPQN+HZqd0Ojgq/HS7F6iaUVRxWjzeR7lrVny9iOwTVCP48nBm5ydb1pWeMpnOQMuD6J3+I3KmH7jZdufdnF7TbW6Z2os3qMNx/BRxgn4CAWUHn0aYAHW0Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7513.apcprd03.prod.outlook.com (2603:1096:101:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 02:19:02 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:19:01 +0000
Message-ID: <7a3d7837-7862-401e-9b07-83eb862de619@amlogic.com>
Date: Tue, 3 Mar 2026 10:18:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for A9
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260228-a9-baisc-dts-v2-0-47489d5cc1a8@amlogic.com>
 <20260228-a9-baisc-dts-v2-2-47489d5cc1a8@amlogic.com>
 <88ea9b0a-1eb1-4273-98d6-b0283e1af6eb@oss.qualcomm.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <88ea9b0a-1eb1-4273-98d6-b0283e1af6eb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5341e6-1028-40b4-be72-08de78cb3b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	5lVqOFuqjBskqPFvgVrETKiAjv4ppgAt/yVWEINTHLbMCdLe5pjMVmwiCKHPmORO9dQ5G0eYkuj6ZG1T/S7bUxX4H4fix5aMO0XgziZimsuOPair7dcfPxr73JHG2Vfqkk/hX0qib+uaR0qnXnbK5ePr0YptEUH7zg8yJxvO01tizxkWR5GJyiFJNt1ne3mzK6ClE3IBTKxXtWrW7FDWoEEDrl6RG3s3bla9FLvtG2Ar0f2B1AoxGOtfESxkbGiFJuSXuHJanQhgB10JM3ZjwHSAku+Q5vteH4zWxoskl1muKvYUAOZUNsL20O+aojQk1J3xqRaRIJi5C7GxWdQgXQLOR7hYNeW9TM8dEykl7gqR5eI0uxfwPRAphB+VCTaS7KgJKmpPleahCXFxzfQwlTAFXSOlbgDUpUH4IpRNAEk7b49ULz0s16SaYwXLSqGaa+jsdxAEdPr4HTFF+/tCkjLMC3Oz5ka7CP4ZJO9fiuCB8oB3JJctbSc0XWb8leJt4G0aupce5O8BR/exRce0+hLY3wUvWjkkkthLkTIbdXcRJdwd9prTLJOVbUvdhDbwlN9z2T6RXLqh3fhiJOx8gNjAeF222iyCKLT9llzbNsIloL+bQDg0R241BR4+85Fw5VGR51Ju6wGcXae/mYGynoJWIO0AzgM2iaXoXqv+3dfou535s0W1APZVMpXXA/JLux4NYlcdb+f7v/BogaOzYvu981h81WlyFfTNnywQnXofLW9bkCdflF/dzmNAO09Ip25+DgL/PIZxucAhxoF/eA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5PTjJkZFRKdHlxQjFMOW1WSllPUjFXTlpOZmdiVk1adXNOSnVqQnZtL2M0?=
 =?utf-8?B?MVpqa2V0NDlUWEpuRU0yd2FuYkVsd0FUSURtbEhldHlaNFB5amR5b29qeUNy?=
 =?utf-8?B?MUZXbEk2NHJsaXBtNk0rN3EvVlRHOTNNMUFIVmM1ck1kQ21mOGIxRS84NHZu?=
 =?utf-8?B?ZG1LYjdkSE82dnVlUEhCRStwVVhGTW9lVEU4ZnV1ZkxRVk5RcjR0OVY5T01v?=
 =?utf-8?B?RHlNeCs5bzdQMUJsN1BGZlYyeW8rNE1rczlNbm1QWllZeHEyU05CMW5QYXpv?=
 =?utf-8?B?cXlqV2RtbXBMTVk3RW1LZnJ5SmMwQkNZbFpOeExYMlFsOEZzYjgzZUtzRjFJ?=
 =?utf-8?B?aVZhZlFDV09MSUF0QlpoWGNhSHRtZ3pqdEZ0RldGRC9PT2U0UFhaTElqSlZF?=
 =?utf-8?B?WjlWWWQ3dlZ2ajNjRlJxN1FNWjZ1MWcrOGFrRi9qTytJM25idk9TUnhuSVk5?=
 =?utf-8?B?Qm1MMVlrY1pMWmRmRDNCeFZZVWFsNkZUU1ZDTEpIMzRZVVl6Tk1TMWYwQzJT?=
 =?utf-8?B?WkxLSXNqWlNyYWMwMWJrMHRydm1RelpwM3o0enE4ZlZ1WGZUZ0t6R3l2Y2FB?=
 =?utf-8?B?MTRBVjhtKzV4QzE4bUl4M002TmdkVG1OWERnQk9uR3FYUFQzdHd6N3hTQkRZ?=
 =?utf-8?B?dEZkMHR5RkxDTktnK3FGc2lYT284UnptTW5EZitud1czWDJJLzFyNHc5Z1p1?=
 =?utf-8?B?YzMwRUVmd3hZaWNwNUZXZmUvSHVUT2dFbXdFWmRLM2dtbm1taFhWdUEvanpJ?=
 =?utf-8?B?SnQ0UDdFY1oxZkJCWjlQYjhkYVZOTUZiMzJwMEdkbVNaSkc4VFU4TmNRWEhq?=
 =?utf-8?B?c1VtdkMyWlBHTXhjeVdOLzZnOE01Mnl4VXlSTHZtSzczV2xJeDNMNmRkS3lY?=
 =?utf-8?B?dDJybitEVTZqY2xvNStmSjBJaUk0WnZHaTRFWmxYVVJaNFo2WWVaaWIwczVZ?=
 =?utf-8?B?WCt6TXNYVGFYZXB4UCtQQnhQSnR1V3I1K1BxZjVHUHR1SGIzcFB6K1V1cWg3?=
 =?utf-8?B?cHpxNk1tdTFNcmlNcE9LN1AzS3o3QmVkNWowd3d0akE0ZGVJQm5helc1THJI?=
 =?utf-8?B?Z2U2Q0RuZ0U2b2pBbXBoZVJZMVhaVzJHMmc1L25sMDNKWVZrNktpMWdWV0JT?=
 =?utf-8?B?THFmaytZWnpvZWhaSVpXTU5tQ1g2WEJJM05GRmduWmxHTEtCdzVjaCtodC9l?=
 =?utf-8?B?YlFhK0hSTE9FTjZ4M0c2RW5mWHNrVFNNZjdZN3ZCT1RqLzhOa1JRaWlwZVRt?=
 =?utf-8?B?bjFWMlZoY2JlQ2w2ZmVsR095b25sa3BGejlkdHhtbERFK0dTS3kwUDM1NlNn?=
 =?utf-8?B?ZURKcGtDUzBNTXRUNDBOaXVITlJ6Tk1sbTU1cCtFZXhGS0plMW9JMkliWUtv?=
 =?utf-8?B?SjE2MVM5WVdscjdPdk1mS0xzTUhSQld5RUJRYm1TVmlaTGhKVkI3RkJhTmM1?=
 =?utf-8?B?YWo3ZTVwNXJidnoyVlE3TlpWYUxtbkhmbmlYRWxhTGRkSEZTZUUwMithb20w?=
 =?utf-8?B?UDArSE04NUZPQWRrK3pQaFMzNHFBN08yWW9RcmFYTDBTQytyRGFGdTNXOGFq?=
 =?utf-8?B?ZVdLQXdwbFpLVmdwVkNqb3BFd2RQSnZPMk0wdS8wUEpZMGErODV0SzRaejA4?=
 =?utf-8?B?eTd1dXh5STd0YmRNWG1oWjZSc254aHdYRkJGTnJ2TExMNHV1T1JzWHpwaVFl?=
 =?utf-8?B?NC9wOXczVHpkMmVVRHpNWjY1eGVqWG9tTzNxa1NUV0xoNUJPN0xVbGtRZk42?=
 =?utf-8?B?cElmY1BvVEU4czFxWTJvWkV2eXozR25HUzJBVlZCbU0xVHM1MkRuN2xWVERP?=
 =?utf-8?B?MU9nMXltckJ1ZUQyYXB5dDZXOUFIU1VJV1hRNU5aUGhqQXBOeTNQc20zMVBz?=
 =?utf-8?B?bTcydStGRFdEcExDbTVNeVFCbWlaZmRwSXVoVEdyMFdQM2pvWWhLRjRVaUNK?=
 =?utf-8?B?aE8vWHJaNmNMcVB6Ry9HbHgrdkpTMksyNUdRZjZza1Vwb2FpQ21mVnNsV3Yz?=
 =?utf-8?B?K24zZ085R3VXMFFyTmFPZ256ZDNQK3B5N0g1NzFlekNqWjhsU2NrdlZHMXBG?=
 =?utf-8?B?WjdTYmR1VS85VitqTTVyWkUzM2RkekdVWm44bFNhVjVqeE1tQmUrMVpKaGk1?=
 =?utf-8?B?OEdYTkw5eTdza01qWmp2SlVMb0lsWmltVGl4dVVWZ0lFMWpQd00xSjhSalhP?=
 =?utf-8?B?TXdsT2VMYndxSmRveVB0UFdNTk9rbmVzR3lJdHFBcDBGN0o0ZUhaNnVvMU9y?=
 =?utf-8?B?V3VNS1pWQmgvaGZxSHlKeWw0ai8wL1B6eEtXTmxWd1B6cElIZUVaOFNZTitk?=
 =?utf-8?B?TE1KWGRhUzdsLzFLU2lzSEVGVi83YkhpMDl4aDhJN2p1dlpQQWcrQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5341e6-1028-40b4-be72-08de78cb3b94
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:19:00.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6hPg4ys6B1hwHxw1c5S3mHaqXX2OiVr9bjqDCjK8qgd36fn/8iAH8OHurxIkh6USN6h5YOYTqyWMyquJIXfElyJ0ggLm9YWv9RAu71Deew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7513

Hi Krzysztof,
    Sorry, I misunderstood before. I will send this submission 
separately and independently later.

On 2026/2/28 17:50, Krzysztof Kozlowski wrote:
> On 28/02/2026 08:56, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Amlogic A9 SoCs uses the same UART controller as S4 SoCs.
>> There is no need for an extra compatible line in the driver,
>> but add A9 compatible line for documentation.
>>
>> Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
>> Acked-by: Krzysztof Kozlowski<krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
> Really, so just just ignored my feedback?
> 
> Shall I NAK your patches so you will respond and implement it?
> 
> Best regards,
> Krzysztof
